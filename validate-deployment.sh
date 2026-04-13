#!/bin/bash
# WhatsApp Bot - Pre-Deployment Validation Script

echo "🔍 Validando projeto para deployment no Railway..."
echo ""

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

# 1. Check Node.js version
echo "📦 Verificando Node.js..."
if ! command -v node &> /dev/null; then
    echo -e "${RED}✗ Node.js não encontrado${NC}"
    ERRORS=$((ERRORS + 1))
else
    NODE_VERSION=$(node -v)
    echo -e "${GREEN}✓ Node.js ${NODE_VERSION}${NC}"
fi

# 2. Check critical files
echo ""
echo "📋 Verificando arquivos essenciais..."

FILES=(
    "Procfile"
    "railway.json"
    "runtime.txt"
    "package.json"
    "backend/server.js"
    "backend/package.json"
    "frontend/package.json"
)

for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓ ${file}${NC}"
    else
        echo -e "${RED}✗ ${file} - NÃO ENCONTRADO${NC}"
        ERRORS=$((ERRORS + 1))
    fi
done

# 3. Check backend dependencies
echo ""
echo "🔧 Verificando dependências do backend..."
cd backend
if npm list express > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Express instalado${NC}"
else
    echo -e "${YELLOW}⚠ Express não instalado (será instalado no Railway)${NC}"
    WARNINGS=$((WARNINGS + 1))
fi
cd ..

# 4. Check .gitignore
echo ""
echo "📁 Verificando .gitignore..."
if grep -q "node_modules" .gitignore; then
    echo -e "${GREEN}✓ node_modules ignora${NC}"
else
    echo -e "${YELLOW}⚠ node_modules não está em .gitignore${NC}"
fi

# 5. Check runtime.txt format
echo ""
echo "⚙️  Verificando runtime.txt..."
RUNTIME=$(cat runtime.txt)
if [[ $RUNTIME =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo -e "${GREEN}✓ runtime.txt válido: ${RUNTIME}${NC}"
else
    echo -e "${RED}✗ runtime.txt inválido${NC}"
    ERRORS=$((ERRORS + 1))
fi

# 6. Check Procfile
echo ""
echo "🚀 Verificando Procfile..."
if grep -q "web:" Procfile; then
    WEB_CMD=$(grep "web:" Procfile)
    echo -e "${GREEN}✓ Procfile contém comando web:${NC}"
    echo "   $WEB_CMD"
else
    echo -e "${RED}✗ Procfile não contém comando web${NC}"
    ERRORS=$((ERRORS + 1))
fi

# 7. Check git status
echo ""
echo "📤 Verificando status do Git..."
if git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Repositório Git inicializado${NC}"
    
    UNCOMMITTED=$(git status --porcelain | wc -l)
    if [ $UNCOMMITTED -gt 0 ]; then
        echo -e "${YELLOW}⚠ Existem $UNCOMMITTED arquivo(s) não commitado(s)${NC}"
        WARNINGS=$((WARNINGS + 1))
    else
        echo -e "${GREEN}✓ Todos os arquivos commitados${NC}"
    fi
else
    echo -e "${RED}✗ Repositório Git não encontrado${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Final report
echo ""
echo "================================"
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ PRONTO PARA DEPLOY${NC}"
    if [ $WARNINGS -gt 0 ]; then
        echo -e "${YELLOW}⚠ $WARNINGS aviso(s)${NC}"
    fi
else
    echo -e "${RED}✗ ERROS ENCONTRADOS: $ERRORS${NC}"
    echo -e "Resolva os erros acima antes de fazer deploy"
fi
echo "================================"
echo ""

exit $ERRORS
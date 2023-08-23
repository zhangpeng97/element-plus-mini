#! /bin/bash

NAME=$1

FILE_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")/../packages" && pwd)

re="[[:space:]]+"
# 针对输入参数进行校验
if [ "$#" -ne 1 ] || [[ $NAME =~ $re ]] || [ "$NAME" == "" ]; then
  echo "Usage: pnpm gc \${name} with no space"
  exit 1
fi

DIRNAME="$FILE_PATH/components/$NAME"
INPUT_NAME=$NAME

if [ -d "$DIRNAME" ]; then
  echo "$NAME component already exists, please change it"
  exit 1
fi
#  针对文件命名进行规范化
NORMALIZED_NAME=""
for i in $(echo $NAME | sed 's/[_|-]\([a-z]\)/\ \1/;s/^\([a-z]\)/\ \1/'); do
  C=$(echo "${i:0:1}" | tr "[:lower:]" "[:upper:]")
  NORMALIZED_NAME="$NORMALIZED_NAME${C}${i:1}"
done
NAME=$NORMALIZED_NAME
# 创建对应的目录
mkdir -p "$DIRNAME"
mkdir -p "$DIRNAME/src"

#  指定输出地址  主要目的代码统一风格
cat > $DIRNAME/src/$INPUT_NAME.vue <<EOF
<template>
  <div>
 
  </div>
</template>

<script lang="ts" setup>
import { ${INPUT_NAME}Props } from './$INPUT_NAME'

defineOptions({
  name: 'El$NAME',
})

const props = defineProps(${INPUT_NAME}Props)

</script>
EOF

cat > $DIRNAME/src/$INPUT_NAME.ts <<EOF
import { buildProps } from '@element-plus/utils'

import type { ExtractPropTypes } from 'vue'
import type $NAME from './$INPUT_NAME.vue'

export const ${INPUT_NAME}Props = buildProps({})

export type ${NAME}Props = ExtractPropTypes<typeof ${INPUT_NAME}Props>
export type ${NAME}Instance = InstanceType<typeof $NAME>
EOF

cat <<EOF >"$DIRNAME/index.ts"
import { withInstall } from '@element-plus/utils'
import $NAME from './src/$INPUT_NAME.vue'

export const El$NAME = withInstall($NAME)
export default El$NAME

export * from './src/$INPUT_NAME'
EOF



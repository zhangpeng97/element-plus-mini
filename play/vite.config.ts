import {defineConfig} from 'vite'
import vue from '@vitejs/plugin-vue'
import VueMacros from 'unplugin-vue-macros/vite'
import vueJsx from '@vitejs/plugin-vue-jsx'
export default defineConfig({
    // 服务器常见配置
    
    server:{
        open:true,
        proxy:{

        }
    },
    
    build:{

    },
    plugins:[
        vue(),
        vueJsx()
           

    ]
   
})
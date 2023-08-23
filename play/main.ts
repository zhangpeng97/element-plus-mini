import { PvButton } from './../packages/components/button/index';
import {createApp} from "vue"
import App from './scr/App.vue'
console.log('Pvbutton',PvButton)

const app=createApp(App)
PvButton.install(app)
app.mount('#app')
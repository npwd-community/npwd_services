import App from './src/App';
import { AppIcon } from './icon';
import { theme } from './src/app.theme';

const defaultLanguage = 'en';
const localizedAppName = {
  en: 'Services',
};

interface Settings {
  language: 'en';
}

export default (settings: Settings) => ({
  id: 'services',
  nameLocale: localizedAppName[settings?.language ?? defaultLanguage],
  color: '#fff',
  backgroundColor: '#333',
  path: '/services',
  icon: AppIcon,
  app: App,
  theme: theme,
});

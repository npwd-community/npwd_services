import App from "./src/App";
import { ServicesIcon } from "./icon";
import { theme } from "./src/app.theme";

export default (settings: any) => ({
  id: "services",
  nameLocale: "Services",
  color: "#fff",
  backgroundColor: "#333",
  path: "/services",
  icon: ServicesIcon,
  app: App,
  theme: theme,
});

import { AppRegistry } from 'react-native';
import AppNavigation from './app/(tabs)/navigation/AppNavigation';

// Määritä sovelluksen nimi suoraan
const appName = "step_tracker_app";

AppRegistry.registerComponent(appName, () => AppNavigation);
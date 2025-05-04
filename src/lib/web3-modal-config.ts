// imports
import {
  EthereumClient,
  w3mConnectors,
  w3mProvider,
} from "@web3modal/ethereum";
import { Chain } from "wagmi/chains";
import { configureChains, createConfig } from "wagmi";
import { jsonRpcProvider } from "wagmi/providers/jsonRpc";

// configure web3modal
// 1. Get the projectID at https://cloud.walletconnect.com
if (!process.env.WEB3_PROJECT_ID) {
  throw new Error("Missing WEB3_PROJECT_ID env variable");
}
export const projectId = process.env.WEB3_PROJECT_ID;

// 2. Configure Sonic Blaze testnet chain
export const sonicChain: Chain = {
  id: 57054,
  name: 'Sonic Blaze',
  network: 'sonic-blaze',
  nativeCurrency: {
    decimals: 18,
    name: 'Sonic',
    symbol: 'SONIC',
  },
  rpcUrls: {
    default: { http: ["https://rpc.blaze.soniclabs.com"] },
    public: { http: ["https://rpc.blaze.soniclabs.com"] },
  },
  blockExplorers: {
    default: { name: 'Sonic Explorer', url: 'https://blaze.soniclabs.com' },
  },
  testnet: true,
};

// 3. Configure wagmi config with Sonic chain
export const supportedChains = [sonicChain];
const { publicClient } = configureChains(supportedChains, [
  jsonRpcProvider({
    rpc: () => ({
      http: "https://rpc.blaze.soniclabs.com"
    }),
  }),
]);

export const wagmiConfig = createConfig({
  autoConnect: true,
  connectors: w3mConnectors({ projectId, chains: supportedChains }),
  publicClient,
});

// 4. Configure web3 modal ethereum client
export const ethereumClient = new EthereumClient(wagmiConfig, supportedChains);
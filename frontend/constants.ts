import { sepolia, scrollSepolia, mantleTestnet } from "wagmi/chains";
import { Chain } from "@wagmi/core";

export const chainIdToAddresses: {
  [chainId: number]: {
    DAI: `0x${string}`;
    aDAI: `0x${string}`;
  };
} = {
  [sepolia.id]: {
    DAI: "0x4fEe0DA6C3B8baEAABFaaa2959bdE62D85074CC6",
    aDAI: "0x0d92849fA073415297f25adEC0112Fa80abCf89A",
  },
  [scrollSepolia.id]: {
    DAI: "0xfA91c4C5C12C18ed73E5DD8eE3Ddcc145e6A67F2",
    aDAI: "0xe3aa62D983E06CE9e098Daf5669395AE1f5B9155",
  },
  [mantleTestnet.id]: {
    DAI: "0x00",
    aDAI: "0x00",
  },
};

export const okx1 = {
  id: 43_114,
  name: "Avalanche",
  network: "avalanche",
  nativeCurrency: {
    decimals: 18,
    name: "Avalanche",
    symbol: "AVAX",
  },
  rpcUrls: {
    public: { http: ["https://api.avax.network/ext/bc/C/rpc"] },
    default: { http: ["https://api.avax.network/ext/bc/C/rpc"] },
  },
  blockExplorers: {
    etherscan: { name: "SnowTrace", url: "https://snowtrace.io" },
    default: { name: "SnowTrace", url: "https://snowtrace.io" },
  },
  contracts: {
    multicall3: {
      address: "0xca11bde05977b3631167028862be2a173976ca11",
      blockCreated: 11_907_934,
    },
  },
} as const satisfies Chain;

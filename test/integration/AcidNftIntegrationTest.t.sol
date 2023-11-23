// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {SvgUtils} from "../../src/utils/SvgUtils.sol";
import {DeployAcidNft} from "../../script/DeployAcidNft.s.sol";
import {AcidNft} from "../../src/tokens/AcidNft.sol";

contract AcidNftIntegrationTest is Test {
    string public constant EXAMPLE_SVG = "./img/svg/example.svg";

    string public constant NORMAL_SVG_URI =
        "data:application/json;base64,ewogICAgIm5hbWUiOiAiU2hyb29tTkZUIiwKICAgICJkZXNjcmlwdGlvbiI6ICJRdWVzdGlvbiBhdXRob3JpdHkuIFRoaW5rIGZvciB5b3Vyc2VsZi4iLAogICAgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEQ5NGJXd2dkbVZ5YzJsdmJqMGlNUzR3SWlCbGJtTnZaR2x1WnowaWFYTnZMVGc0TlRrdE1TSS9QZ284YzNabklHaGxhV2RvZEQwaU9EQXdjSGdpSUhkcFpIUm9QU0k0TURCd2VDSWdkbVZ5YzJsdmJqMGlNUzR4SWlCcFpEMGlUR0Y1WlhKZk1TSWdlRzFzYm5NOUltaDBkSEE2THk5M2QzY3Vkek11YjNKbkx6SXdNREF2YzNabklnb0plRzFzYm5NNmVHeHBibXM5SW1oMGRIQTZMeTkzZDNjdWR6TXViM0puTHpFNU9Ua3ZlR3hwYm1zaUlIWnBaWGRDYjNnOUlqQWdNQ0ExTVRJZ05URXlJaUI0Yld3NmMzQmhZMlU5SW5CeVpYTmxjblpsSWo0S0NUeHdZWFJvSUhOMGVXeGxQU0ptYVd4c09pTkdORVE0TlRNN0lpQmtQU0pOTXpFNExqQTJNU3d5TlRaSU1Ua3pMamt6T1dNdE1USXVPRFV6TERBdE1qTXVNamN6TERFd0xqUXhPQzB5TXk0eU56TXNNak11TWpjemRqRXlOQzR4TWpFS0NXTXdMRFEzTGpBMU1Td3pPQzR5T0RFc09EVXVNek16TERnMUxqTXpNeXc0TlM0ek16TnpPRFV1TXpNekxUTTRMakk0TWl3NE5TNHpNek10T0RVdU16TXpWakkzT1M0eU56TkRNelF4TGpNek15d3lOall1TkRFNExETXpNQzQ1TVRNc01qVTJMRE14T0M0d05qRXNNalUyZWlJZ0x6NEtDVHhuUGdvSkNUeHdZWFJvSUhOMGVXeGxQU0ptYVd4c09pTkZPVUUwTkRBN0lpQmtQU0pOTXpFNExqQTJNU3d5TlRaSU1qVTJkakl6TWk0M01qZGpORGN1TURVekxEQXNPRFV1TXpNekxUTTRMakk0TWl3NE5TNHpNek10T0RVdU16TXpWakkzT1M0eU56TUtDUWxETXpReExqTXpNeXd5TmpZdU5ERTRMRE16TUM0NU1UTXNNalUyTERNeE9DNHdOakVzTWpVMmVpSWdMejRLQ1FrOGNHRjBhQ0J6ZEhsc1pUMGlabWxzYkRvalJUbEJORFF3T3lJZ1pEMGlUVEkxTml3eU15NHlOek5qTFRFME1TNHhOVGdzTUMweU5UWXNNVEUwTGpnMExUSTFOaXd5TlRaak1Dd3hNaTQ0TlRFc01UQXVORElzTWpNdU1qY3pMREl6TGpJM015d3lNeTR5TnpOb05EWTFMalExTlFvSkNXTXhNaTQ0TlRNc01Dd3lNeTR5TnpNdE1UQXVOREl5TERJekxqSTNNeTB5TXk0eU56TkROVEV5TERFek9DNHhNVE1zTXprM0xqRTFPQ3d5TXk0eU56TXNNalUyTERJekxqSTNNM29pSUM4K0NnazhMMmMrQ2drOGNHRjBhQ0J6ZEhsc1pUMGlabWxzYkRvalJURTNPRFU0T3lJZ1pEMGlUVEkxTml3eU15NHlOek4yTWpjNUxqSTNNMmd5TXpJdU56STNZekV5TGpnMU15d3dMREl6TGpJM015MHhNQzQwTWpJc01qTXVNamN6TFRJekxqSTNNd29KUXpVeE1pd3hNemd1TVRFekxETTVOeTR4TlRnc01qTXVNamN6TERJMU5pd3lNeTR5TnpONklpQXZQZ284TDNOMlp6ND0iLAogICAgImF0dHJpYnV0ZXMiOiBbCiAgICAgICAgewogICAgICAgICAgICAic3RyYWluX3R5cGUiOiAiR29sZGVuIFRlYWNoZXIiLAogICAgICAgICAgICAidmFsdWUiOiAxMzcKICAgICAgICB9CiAgICBdCn0=";

    string public constant HEROIC_SVG_URI =
        "data:application/json;base64,ewogICAgIm5hbWUiOiAiU2hyb29tTkZUIiwKICAgICJkZXNjcmlwdGlvbiI6ICJRdWVzdGlvbiBhdXRob3JpdHkuIFRoaW5rIGZvciB5b3Vyc2VsZi4iLAogICAgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEQ5NGJXd2dkbVZ5YzJsdmJqMGlNUzR3SWlCbGJtTnZaR2x1WnowaWFYTnZMVGc0TlRrdE1TSS9QZ284YzNabklHaGxhV2RvZEQwaU9EQXdjSGdpSUhkcFpIUm9QU0k0TURCd2VDSWdkbVZ5YzJsdmJqMGlNUzR4SWlCcFpEMGlUR0Y1WlhKZk1TSWdlRzFzYm5NOUltaDBkSEE2THk5M2QzY3Vkek11YjNKbkx6SXdNREF2YzNabklnb0plRzFzYm5NNmVHeHBibXM5SW1oMGRIQTZMeTkzZDNjdWR6TXViM0puTHpFNU9Ua3ZlR3hwYm1zaUlIWnBaWGRDYjNnOUlqQWdNQ0F5T1RjdU1EQXhJREk1Tnk0d01ERWlJSGh0YkRwemNHRmpaVDBpY0hKbGMyVnlkbVVpUGdvSlBHYytDZ2tKUEhCaGRHZ2djM1I1YkdVOUltWnBiR3c2SXpOQk0wRXpSanNpSUdROUlrMHhOREl1TlRVNUxERXlOQzR6TmpkakxURXVNREU1TFRRdU1qTTVMVFV1TWpnM0xUWXVPRFEzTFRrdU5URTRMVFV1T0RJM1l5MHpMall4T1N3d0xqZzNMVFl1TURReUxEUXVNVEEzTFRZdU1ETTVMRGN1TmpjelNERXdOQzQxTndvSkNVZzRNaTR6T1RGak1DNHdNRE10TXk0Mk1UWXRNaTQwT0RndE5pNDROemd0Tmk0eE5qTXROeTQzTURGakxUUXVNalV5TFRBdU9UVTBMVGd1TkRjekxERXVOekkwTFRrdU5ESTFMRFV1T1RjMll5MHdMakk1TERFdU1qazBMVGN1TURrc016SXVNRGd5TFRjdU1Ea3NOamN1TnpZNENna0pZekFzTXpjdU1ERTJMREk0TGpVeU55dzBOeTR5TURJc05EUXVNalUwTERRM0xqVXdNbU13TGpJME1pd3dMakF3TlN3d0xqUTVNU3d3TGpBeE5Td3dMamN5T0N3d0xqQXhOV014TlM0MU5UZ3NNQ3cwTkM0NU9ETXRPUzQ1TXpFc05EUXVPVGd6TFRRM0xqVXhOd29KQ1VNeE5Ea3VOamM0TERFMU5DNHpPVGNzTVRReUxqZzFMREV5TlM0MU56WXNNVFF5TGpVMU9Td3hNalF1TXpZM2VpSWdMejRLQ1FrOGNHRjBhQ0J6ZEhsc1pUMGlabWxzYkRvak5FRTBRVFV5T3lJS0NRa0paRDBpVFRneUxqTTVNU3d4TWpZdU1qRXpZekF1TURBekxUTXVOakUyTFRJdU5EZzRMVFl1T0RjNExUWXVNVFl6TFRjdU56QXhZeTAwTGpJMU1pMHdMamsxTkMwNExqUTNNeXd4TGpjeU5DMDVMalF5TlN3MUxqazNOZ29KQ1dNdE1DNHlPU3d4TGpJNU5DMDNMakE1TERNeUxqQTRNaTAzTGpBNUxEWTNMamMyT0dNd0xETTNMakF4Tml3eU9DNDFNamNzTkRjdU1qQXlMRFEwTGpJMU5DdzBOeTQxTUROc01DNDJNREl0TVRFekxqVTBOa3c0TWk0ek9URXNNVEkyTGpJeE0wdzRNaTR6T1RFc01USTJMakl4TTNvaUlDOCtDZ2tKUEhCaGRHZ2djM1I1YkdVOUltWnBiR3c2SXpOQk0wRXpSanNpSUdROUlrMHhOREl1TlRVNUxERXlOQzR6TmpkakxURXVNREU1TFRRdU1qTTVMVFV1TWpnM0xUWXVPRFEzTFRrdU5URTRMVFV1T0RJM1l5MHpMall4T1N3d0xqZzNMVFl1TURReUxEUXVNVEEzTFRZdU1ETTVMRGN1TmpjelNERXdOQzQxTndvSkNXd3RNQzQyTURJc01URXpMalUwTm1Nd0xqSTBNaXd3TGpBd05Td3dMalE1TVN3d0xqQXhOQ3d3TGpjeU9Dd3dMakF4TkdNeE5TNDFOVGdzTUN3ME5DNDVPRE10T1M0NU16RXNORFF1T1RnekxUUTNMalV4TndvSkNVTXhORGt1TmpjNExERTFOQzR6T1Rjc01UUXlMamcxTERFeU5TNDFOellzTVRReUxqVTFPU3d4TWpRdU16WTNlaUlnTHo0S0NRazhjR0YwYUNCemRIbHNaVDBpWm1sc2JEb2pPVEJCTXpsR095SUtDUWtKWkQwaVRURXdOUzR5TXpnc01DNHdNRGRETVRBMUxqQTFOeXd3TGpBd05pd3hNRFF1T0RjM0xEQXNNVEEwTGpZNU5Td3dRelE0TGpFek1pd3dMREl1TVRFMExEUTJMakF4T0N3eUxqRXhOQ3d4TURJdU5UZ3lDZ2tKWXpBc01UVXVOVFUwTERNdU5EVTFMREkxTGpVNE9Td3hNQzQ0TnpRc016RXVOVGd6WXpVdU1Ua3lMRFF1TVRrMExERXhMalUwTml3MUxqY3dNeXd4T0M0M09EY3NOUzQzTUROak9DNDFORGdzTUN3eE9DNHpNek10TWk0eE1ETXNNamd1T0RrMkxUUXVNemN6Q2drSll6RXpMakl5TkMweUxqZzBNeXd5T0M0eU1EWXROaTR3TmpFc05ETXVPRGd4TFRZdU1EZ3hZekF1TURRNExEQXNNQzR3T1RVdE1DNHdNRElzTUM0eE5ETXRNQzR3TURKak1UVXVOekkzTERBc016QXVOellzTXk0eU16RXNORFF1TURJMExEWXVNRGd5Q2drSll6RTVMalV4Tml3MExqRTVNeXd6Tmk0ek5qVXNOeTQ0TVRNc05EY3VOamcxTFRFdU16STVZemN1TkRFNExUVXVPVGswTERFd0xqZzNOQzB4Tmk0d01qa3NNVEF1T0RjMExUTXhMalU0TTBNeU1EY3VNamM0TERRMkxqSXNNVFl4TGpVMU15d3dMak13TVN3eE1EVXVNak00TERBdU1EQTNlaUlnTHo0S0NRazhjR0YwYUNCemRIbHNaVDBpWm1sc2JEb2pRVEZDUlVJNU95SWdaRDBpVFRFd05DNDJPVFVzTUVNME9DNHhNeklzTUN3eUxqRXhOQ3cwTmk0d01UZ3NNaTR4TVRRc01UQXlMalU0TW1Nd0xERTFMalUxTkN3ekxqUTFOU3d5TlM0MU9Ea3NNVEF1T0RjMExETXhMalU0TXdvSkNXTTFMakU1TWl3MExqRTVOQ3d4TVM0MU5EWXNOUzQzTURNc01UZ3VOemczTERVdU56QXpZemd1TlRRNExEQXNNVGd1TXpNekxUSXVNVEF6TERJNExqZzVOaTAwTGpNM00yTXhNeTR5TWpRdE1pNDRORE1zTWpndU1qQTJMVFl1TURZeExEUXpMamc0TVMwMkxqQTRNV3d3TGpZNE5pMHhNamt1TkRBMkNna0pRekV3TlM0d05UY3NNQzR3TURZc01UQTBMamczTnl3d0xERXdOQzQyT1RVc01Ib2lJQzgrQ2drSlBIQmhkR2dnYzNSNWJHVTlJbVpwYkd3Nkl6a3dRVE01UmpzaUNna0pDV1E5SWsweE1EVXVNak00TERBdU1EQTNiQzB3TGpZNE5pd3hNamt1TkRBMll6QXVNRFE0TERBc01DNHdPVFV0TUM0d01ESXNNQzR4TkRNdE1DNHdNREpqTVRVdU56STNMREFzTXpBdU56WXNNeTR5TXpFc05EUXVNREkwTERZdU1EZ3lDZ2tKWXpFNUxqVXhOaXcwTGpFNU15d3pOaTR6TmpVc055NDRNVE1zTkRjdU5qZzFMVEV1TXpJNVl6Y3VOREU0TFRVdU9UazBMREV3TGpnM05DMHhOaTR3TWprc01UQXVPRGMwTFRNeExqVTRNME15TURjdU1qYzRMRFEyTGpJc01UWXhMalUxTXl3d0xqTXdNU3d4TURVdU1qTTRMREF1TURBM2VpSWdMejRLQ1FrOGNHRjBhQ0J6ZEhsc1pUMGlabWxzYkRvalF6RTJRekUzT3lJZ1pEMGlUVEl3TkM0d05UY3NNVGt3TGpVeU9XTXRNeTQyTVRRdE1DNDRPRFV0Tnk0eU5USXNNQzQ0T0RFdE9DNDRPRFVzTkM0d05USnNMVEUzTGpnek5DMDVMakU0T1d3dE1qWXVNREU1TFRFekxqUXdOZ29KQ1dNeExqWTFPQzB6TGpJeE1pd3dMamt6T0MwM0xqSTFOQzB4TGprMU1pMDVMalkyT1dNdE15NHpORFV0TWk0M09USXRPQzR6TWkweUxqTTBPQzB4TVM0eE1UWXNNQzQ1T1RkakxUQXVPVEUwTERFdU1EazBMVEl5TGpVNU15d3lOeTR4T1RRdE5EQXVNVGcxTERZeExqTXpPQW9KQ1dNdE1UZ3VNek00TERNMUxqVTRPQ3cwTGpZMU9TdzFPUzR6TkN3eE9TNHpPREVzTmpZdU9USTJZekF1TURreUxEQXVNRFEzTERBdU1Ua3hMREF1TURrMExEQXVNamcxTERBdU1UUXhZelV1TmpNeUxESXVPRFEyTERFekxqYzNPQ3cxTGpJNE1pd3lNaTQzTWpZc05TNHlPRElLQ1Fsak1UUXVOalE0TERBc016RXVOREkxTFRZdU5UTXlMRFF5TGpjek55MHlPQzQwT0Rkak1UZ3VOall6TFRNMkxqSXlNU3d5Tmk0ek16VXROamN1TVRRNUxESTJMalkxTXkwMk9DNDBORGhETWpFd0xqZzRNU3d4T1RVdU9ETXpMREl3T0M0eU9Ea3NNVGt4TGpVMk5Td3lNRFF1TURVM0xERTVNQzQxTWprS0NRbDZJaUF2UGdvSkNUeHdZWFJvSUhOMGVXeGxQU0ptYVd4c09pTkdRVGsyTVVVN0lpQmtQU0pOTVRVeExqTXhPU3d4TnpFdU9UZzFZekV1TmpVNExUTXVNakV5TERBdU9UTTRMVGN1TWpVMExURXVPVFV5TFRrdU5qWTVZeTB6TGpNME5TMHlMamM1TWkwNExqTXlMVEl1TXpRNExURXhMakV4Tml3d0xqazVOd29KQ1dNdE1DNDVNVFFzTVM0d09UUXRNakl1TlRrekxESTNMakU1TkMwME1DNHhPRFVzTmpFdU16TTRZeTB4T0M0ek16Z3NNelV1TlRnNExEUXVOalU1TERVNUxqTTBMREU1TGpNNE1TdzJOaTQ1TWpaak1DNHdPVElzTUM0d05EY3NNQzR4T1RFc01DNHdPVFFzTUM0eU9EVXNNQzR4TkRFS0NRbHNOVGt1TmpBM0xURXdOaTR6TWpaTU1UVXhMak14T1N3eE56RXVPVGcxZWlJZ0x6NEtDUWs4Y0dGMGFDQnpkSGxzWlQwaVptbHNiRG9qUXpFMlF6RTNPeUlnWkQwaVRUSXdOQzR3TlRjc01Ua3dMalV5T1dNdE15NDJNVFF0TUM0NE9EVXROeTR5TlRJc01DNDRPREV0T0M0NE9EVXNOQzR3TlRKc0xURTNMamd6TkMwNUxqRTRPV3d0TlRrdU5qQTNMREV3Tmk0ek1qWUtDUWxqTlM0Mk16SXNNaTQ0TkRZc01UTXVOemM0TERVdU1qZ3lMREl5TGpjeU5pdzFMakk0TW1NeE5DNDJORGdzTUN3ek1TNDBNalV0Tmk0MU16SXNOREl1TnpNM0xUSTRMalE0TjJNeE9DNDJOak10TXpZdU1qSXhMREkyTGpNek5TMDJOeTR4TkRrc01qWXVOalV6TFRZNExqUTBPQW9KQ1VNeU1UQXVPRGd4TERFNU5TNDRNek1zTWpBNExqSTRPU3d4T1RFdU5UWTFMREl3TkM0d05UY3NNVGt3TGpVeU9Yb2lJQzgrQ2drSlBIQmhkR2dnYzNSNWJHVTlJbVpwYkd3NkkwUkNRak0yTlRzaUNna0pDV1E5SWsweU5ETXVOREkyTERZM0xqVXdObU10TWk0Mk1qUXRNUzQyTkRZdE5TNHpNek10TXk0eUxUZ3VNVE0yTFRRdU5qUTFZeTAxTXk0NU1USXRNamN1TnpjNUxURXlNQzR6TnpFdE5pNDFNVFl0TVRRNExqRTBOeXcwTnk0ek9UWUtDUWxqTFRjdU5UZzVMREUwTGpjeU9TMDVMakl5T0N3eU5TNDRPRFV0TlM0eE5Ua3NNelV1TVRBNVl6WXVNakUwTERFMExqQTROeXd5TkM0d01qSXNNVGd1T1RBeExEUTBMalkwTWl3eU5DNDBOelpqTVRRdU1UVXhMRE11T0RJMUxETXdMakU0T1N3NExqRTJNU3cwTlM0ek1qSXNNVFV1T1RVNENna0pZekV1TXpReExEQXVOamt4TERJdU5qVTNMREV1TkRFc015NDVOaklzTWk0eE5ERmpNVE11TkRJM0xEY3VOVEl4TERJMUxqQXhOQ3d4Tnk0d01qUXNNelV1TXpRc01qVXVOVEF5WXpFMExqWTROU3d4TWk0d05UZ3NNamN1TlRnM0xESXlMalkxTXl3ME1DNDROeklzTWpJdU5qVXpDZ2tKWXpFdU5qUTRMREFzTXk0ek1EUXRNQzR4TmpRc05DNDVOamt0TUM0MU1EaGpPUzQ0TnpRdE1pNHdOQ3d4T0M0d01EY3RPUzQ0TlN3eU5TNDFPVFV0TWpRdU5UYzVRek13T1M0d01Ua3NNVFU1TGprd01Td3lPVEV1TWpjMExEazNMalV5TVN3eU5ETXVOREkyTERZM0xqVXdObm9pSUM4K0Nna0pQSEJoZEdnZ2MzUjViR1U5SW1acGJHdzZJME01T1VVMU1Ec2lJR1E5SWsweU5ETXVOREkyTERZM0xqVXdOa3d4TnpVdU9URXNNVGczTGprMFl6RXpMalF5Tnl3M0xqVXlNU3d5TlM0d01UUXNNVGN1TURJMExETTFMak0wTERJMUxqVXdNZ29KQ1dNeE5DNDJPRFVzTVRJdU1EVTRMREkzTGpVNE55d3lNaTQyTlRNc05EQXVPRGN5TERJeUxqWTFNMk14TGpZME9Dd3dMRE11TXpBMExUQXVNVFkwTERRdU9UWTVMVEF1TlRBNFl6a3VPRGMwTFRJdU1EUXNNVGd1TURBM0xUa3VPRFVzTWpVdU5UazFMVEkwTGpVM09Rb0pDVU16TURrdU1ERTVMREUxT1M0NU1ERXNNamt4TGpJM05DdzVOeTQxTWpFc01qUXpMalF5Tml3Mk55NDFNRFo2SWlBdlBnb0pDVHh3WVhSb0lITjBlV3hsUFNKbWFXeHNPaU5FUWtJek5qVTdJaUJrUFNKTk1qTTFMakk1TERZeUxqZzJNbU10TlRNdU9URXlMVEkzTGpjM09TMHhNakF1TXpjeExUWXVOVEUyTFRFME9DNHhORGNzTkRjdU16azJDZ2tKWXkwM0xqVTRPU3d4TkM0M01qa3RPUzR5TWpnc01qVXVPRGcxTFRVdU1UVTVMRE0xTGpFd09XTTJMakl4TkN3eE5DNHdPRFlzTWpRdU1ESXlMREU0TGprd01TdzBOQzQyTkRJc01qUXVORGMyWXpFMExqRTFNU3d6TGpneU5Td3pNQzR4T0Rrc09DNHhOakVzTkRVdU16SXlMREUxTGprMU9Bb0pDV014TGpNMExEQXVOamt4TERJdU5qVTNMREV1TkRFc015NDVOaklzTWk0eE5ERnNOamN1TlRFMkxURXlNQzQwTXpSRE1qUXdMamd3TWl3Mk5TNDROaXd5TXpndU1Ea3lMRFkwTGpNd05pd3lNelV1TWprc05qSXVPRFl5ZWlJZ0x6NEtDVHd2Wno0S1BDOXpkbWMrIiwKICAgICJhdHRyaWJ1dGVzIjogWwogICAgICAgIHsKICAgICAgICAgICAgInN0cmFpbl90eXBlIjogIkdvbGRlbiBUZWFjaGVyIiwKICAgICAgICAgICAgInZhbHVlIjogMTM3CiAgICAgICAgfQogICAgXQp9";

    DeployAcidNft public deployer;
    AcidNft acidNft;

    address public USER = makeAddr("user");

    function setUp() public {
        deployer = new DeployAcidNft();
        acidNft = deployer.run();
    }

    function test_ViewTokenURIIntegration() public {
        vm.prank(USER);
        acidNft.mintNft();
        console.log(acidNft.tokenURI(0));
    }

    /* function test_SwitchTokenTripToNormal() public {
        vm.prank(USER);
        acidNft.mintNft();

        vm.prank(USER);
        acidNft.switchTrip(0);

        assert(
            keccak256(abi.encodePacked(acidNft.tokenURI(0))) ==
                keccak256(abi.encodePacked(NORMAL_SVG_URI))
        );
    } */
}

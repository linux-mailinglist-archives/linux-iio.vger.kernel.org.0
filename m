Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500AA6509D6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Dec 2022 11:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiLSKNq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Dec 2022 05:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiLSKNm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2022 05:13:42 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F09A449;
        Mon, 19 Dec 2022 02:13:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KANDYTucG96tqkZKV9lW8SmN+Gx32iWUNgZyd9b4TnxJ66FEws4j80QAOvLrSSemV+WdqWM0889p6Aj5XDfxNCDzKEMgEGIK4//zwOWP3V6kvnkPkXbmsqkR669PBDhZjYN7r2gHQ66UF3cLJo19dAmuzdF9S6HZ4HweoH34lAwubKvIoYlRN2F7oIWSG6vDorOoT2p+P9Zsvon+GLeU0Q5SYLrH47tcTwKtXLiKbqiVRY0AURYvt59uFNvln3VQjldTsz8xGwQL2zbVfSnhqtLsg/vu3hZmgK/VVG3RzQu5YZIvQLEOOKJerRdO4FXhGgL2hol+XE8bb28oE7G33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCPx8PdY6rLjR/H0P4N7d5qmx1HEvqGEo5Cf6b7b5qk=;
 b=KJKHdBEfnHBjjgIFnAm0Z/kMUHClJRXB7XT6/ogLX+aoTf0whHUtWLmSMQrrO8iY/TvH9cmM8hZg47GH6cwXN7bcbMuNVZ9Vk6sgSjnB5WrebqTpVlwQ3cDwhnxcqiYR5kxfvBLVqTzit4SzuM9Ii/d9MfbXZhs17efJS80mhRXwJ93ZzPAuFDG9KIvIGsOmL1h3YqFfKBvaRCXYrk1s9cZ84p3cDZRs+Is853/Hz/9KmSC1zTQCzJY3RSqMjf+BnbGNuontb6v7b8DypYgL50TqVnaW1uUyRz3T/j3zOvHaYBzJs4a5q2jELj7dCtUV/OJkrUD2lnG3eljC7IZHsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCPx8PdY6rLjR/H0P4N7d5qmx1HEvqGEo5Cf6b7b5qk=;
 b=flBd2MXWzbel16oiFFC9kiRDW3l7ldwjjGOvdpdnhyK5yhzMVZZD965NIAooG3Jf7DCIrkiph/LJRGfClJv6lHitKAplHbFLYlP610qHs/pe4uohdbvJb4yN9PcR5UoFAqx6uegu3jCVIKQdfQzn0gRD/LCImZKhjIuu2ChHeTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM9PR04MB8178.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.10; Mon, 19 Dec 2022 10:13:35 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 10:13:35 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, haibo.chen@nxp.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/3] add imx93 adc support
Date:   Mon, 19 Dec 2022 18:13:33 +0800
Message-Id: <20221219101336.3929570-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM9PR04MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee8fc0c-b2d0-4c5f-0452-08dae1a9b03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqAXMltWe7MQEg6V94onuJ/+dwlOy+lUYSKTh8srmwOke/QBnDKr1HmYnGC+nEUTnyTBSZ5WTfAG8/GkS+tYKPwGi3VuTqNymD70QllrEepZLyZewPGtowdyyZi9yDJwrFCBVKW+AZOArx7K50WimSAW/1qMVb5nQ4uk4NbVwWmjKX75bQu3LvB72RHGGq3dxRkrVQhGpjr7nZX6izPSUG+RzRyREnpn/kg2rwhXqQpgsgSxDU28laU/d0k92zHZ+5yKXcbloO9nRyS5es6awE7EiPInAqz1Nsd1O2oeWb9SAiDy8J4rf+YsD4UsL6HIEwyMCLz3EmXVqN/DG1llUe6xq54f/hv8feT3n+6PtiWg/PJAio1Paw8yq7DqONTLofGLSRAoAv+KtMStoSY8/da0J7ceAhQzGdv1zKyg1efpIx8U6G5kYC6WyB9LokEEwfbf6UsiP37h0lAuowvM3eKi/Wq/tlZvUcQ8ZJ6Sy0/YJ3X4levXM5Vnui9hxc7E/E+oIwBYlloJGvz00Ue/1YP+i6A0ikOvc1LrZ52lOmwaGuWRoQpfURntaBbvkXPcBmGFbMRNxIjYY3X1P3s61LQT3lK/jwW4cGyYKCLg+mFm8G24nZ9HWCT0rv+9PTCKRFM2kxkdzE2wN/3TzTghBIuCHw/dKxURUxSlf0wPVqhBJ4yr871GIRuXOAl3jktD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199015)(66556008)(38350700002)(41300700001)(7416002)(66476007)(66946007)(4744005)(8676002)(86362001)(8936002)(6512007)(36756003)(52116002)(26005)(2906002)(478600001)(4326008)(186003)(2616005)(83380400001)(1076003)(6506007)(316002)(38100700002)(5660300002)(9686003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1QXKN0Rc6VeNfIK1/I/LpwSUyPUsvngPajSs67XYfndbEW5CTv6j4Rg1oLYy?=
 =?us-ascii?Q?1AM82k+Qq3i9uTE8wpfJmlqjXpaBM/4xqYPzR8aXKtTEemtif4OfV5NZ8XxK?=
 =?us-ascii?Q?UNAG86GYLmW6x2fm+yvH5RB4lRjjaqUQU2E/fzFjPFlv5b8wBQu4ocPe6lC4?=
 =?us-ascii?Q?faTyQ+bl6pkFezefHglzCCd5S0kbO2fVW45OY2tTtTXAVtXu9Xt5VVLmQhQO?=
 =?us-ascii?Q?uSiQ7wouf5zYD7phGgWrhblJdmmA+AAy44tLXcexp9exzMhsmrN37+3z/TPF?=
 =?us-ascii?Q?7VPAeWZHsPzIG8B+BVouI9CFDP9uYOS80g+PB0FL8j/20U4uBGklswMO1rJM?=
 =?us-ascii?Q?qdRSiQltqZevhN/oKdhswC0Jw3s+R8+S7u+uk8HREBAbLUCPwWYypqEOO6Rl?=
 =?us-ascii?Q?9Md0LnlDZ4k6b+HC0sgjkgCeoluSCZTwC8SsP4TVngF2FR3JK9DPndtNAkA7?=
 =?us-ascii?Q?aPOxjByHUcy/MR1EsFCze9f3HmKi0k/WtXvRKMKiCKsQKeHgstMy12OYOjW/?=
 =?us-ascii?Q?rD0DcuTIBY0VS/Nx+Z73D384aoZI9ULhSC4aWbNOAGl+O6FRXmAVej48RL1O?=
 =?us-ascii?Q?JjxWfcOMySBFwPC6aaVtHR08tQeRqHPoRW7C4nM08LLqS5FQIEazF15h2fs3?=
 =?us-ascii?Q?HAPfTxK6+ROc+RKBMst/CrcmnXS3Tyj2JGp6nxQrYW+rGeGzM/1y8LK2d+iM?=
 =?us-ascii?Q?AEt8uwfSV63xdfuYmDqmxAIrKM6yieUNyL9SPUxItq/1AB/YG2aNgQs9pKfD?=
 =?us-ascii?Q?odXckzaNqiSwwmmvpsizzBj+ufNWx3CCPmrV3QfWJ+1TWcmaN6agXb282nuR?=
 =?us-ascii?Q?gNS0fljw9a0ZrmImfvigryjnvpPgBLH70hAjiAEzR3ZRVoA/tBDQgcDT62Yj?=
 =?us-ascii?Q?PVueBO4igc28Plergi2AzCEaWUiwEZXDJ4NJCH3w8eW24mkPCLbaW3da3FaJ?=
 =?us-ascii?Q?l6JIz5orFA/MgwbK7/Umhv1KxZog2Blx4VR9HH9uesol0L7udWO61fHzW71/?=
 =?us-ascii?Q?pfByjM4dnZeeuWy7ZP66EO6lBinoOkJPKEpSVUgsP/rraynnRtGw6RpiVEM0?=
 =?us-ascii?Q?psMf1T9pK1YLikBv8oee9lxHHCV4cB5jiahDZkaYYzsO/BDrbomWf2yWXuAQ?=
 =?us-ascii?Q?8WHkjE+709deyG88cdcyckHVsgN0mRPrRTNAx7fCRRzMnt/vMwMqJlQmJd1r?=
 =?us-ascii?Q?2LimRVdLgY3Vd7bqGoAx5qSBvz8Ghb9ye+vAlfW4W78zEuvNZDdSvo+tqwkH?=
 =?us-ascii?Q?qA9YOgqiy/EEbvdsZmcCPC9kZo6XAWNuIqIF8rRWuhNbXKprBVaBPicWgnmA?=
 =?us-ascii?Q?PJTea/1xKQlwI9PMYOqEPf16X2lh5HF1feuqzpw7R8RFChQ2AIDuwkzkroLi?=
 =?us-ascii?Q?fuiBztS/HR/Y42DHUDVy9MmcJcq5asLHOMXaiI4gXKmKjED90NE9pWTF9WNp?=
 =?us-ascii?Q?ODAbI9ZByX0qtOy+IaF7VsR2DfIapNaaWzCQJ0Cic7Dxppgxbesoh0dUTqL+?=
 =?us-ascii?Q?qTzbhCl+aDdpuYG6IzIUC+I/tHSMopTTU3F6m7HGdqa8s/SPvodKsla3Eq+x?=
 =?us-ascii?Q?j0/Ii1dk5/nbzeZswVIYDTaajEWRDLp80nFCZRwA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee8fc0c-b2d0-4c5f-0452-08dae1a9b03c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 10:13:35.2385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAzM+Mr/fvKRivSOd2sMoHF6U1vYgVlmF8RxJGNFnpE3xKEaVyysBLdLCdy9Kc9HyHG3sYFLctmn901rJBwKLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

V3:
  For dt-bings, add some change according to review comments, and pass dt_binding_check.
  For dts, add #io-channel-cells = <1>; to pass dtbs_check
  For ADC driver, no change.

V2:
  For ADC driver, add change according to matainer's commets.

Haibo Chen (3):
  iio: adc: add imx93 adc support
  dt-bindings: iio: adc: Add binding documentation for NXP IMX93 ADC
  arm64: dts: imx93: add ADC support

 .../bindings/iio/adc/nxp,imx93-adc.yaml       |  81 +++
 MAINTAINERS                                   |   4 +-
 .../boot/dts/freescale/imx93-11x11-evk.dts    |  12 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      |  13 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/imx93_adc.c                   | 474 ++++++++++++++++++
 7 files changed, 594 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
 create mode 100644 drivers/iio/adc/imx93_adc.c

-- 
2.34.1


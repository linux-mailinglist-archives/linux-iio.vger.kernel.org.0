Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF2866DF71
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 14:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjAQNxP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 08:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjAQNw4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 08:52:56 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4A3CE29;
        Tue, 17 Jan 2023 05:51:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fj5pykZYD+0kIOOeKyjJ4rvjEhC3esXJ8puMpxTbHtcGMWhfX9/vLzYCLglh0QfIU2bCYdY5McPiNiViVV1nYMvHrkSmnmnGTGAfiYzuxG4IShwBXvwB6dEzHd6IzNXS9wj1awNboFMe4ca/8rDHnQMgRZB44AAfY9HY8qZz1Dbu7Pz1EQZ9Ifa+QR4BtJTs85RXPfF0P2NNdx1Bi0SbS+/WE9L3O/x4Ze4D+GBY4kTpnOKU4v8CuRPvFTqMYMEbZEUjUn4fa99LIeJ+1b6X078ZklWj3Magjw/Xpce75lKEhg/Umq+G6dfGo4GwP2C3YaJ6QbbYoRIF3jpVPGp+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9VMheMwhKy88WKtB/x0JuUemVSQFfTfqkFMuOlyidw=;
 b=fJxT1SRaCknqB+nORKja0B88miCZyMtpj9iAaC4DrmFplBymGqYasOxSEQKHhZh8fTXrLq1mgi71DGwkw/yh2bfkMQOkdZH2aGmcDm5klWH0DfmzAFSClsnop/7kQ9swgxOkxMoGf1Uh1H96B7jRzLgJ+U+3Yu75Hr3tuw79djcLtswlWwnvMEXEgBxIVNfRgxnCPADLbF9+RzbBYngy3RhyiHaVQDmXbVxHqxEkqxwUKUljaQ74z58RD6LmdmksrdOiQ0925Fx8aNtbo4fyja0sut1D6Q041ifFtGm9jJfMOKdSRUHEBIRJimoaDs6o98lhZvosBWBjNWHx6uMSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9VMheMwhKy88WKtB/x0JuUemVSQFfTfqkFMuOlyidw=;
 b=BH3IHMfMSBfP22BACx/PdNOAYfe7FAIgN3wyITcy1v73qUMHQsPfTSbqk0m/BWZU8mdB4ZFzcuTAkFREPhofGL7cQg7AMVAqyv074+eC7jmOGdyEw/dFuYCSnGrEdFtcvBPk3190ZD6gNJl0VKDaYdt/iy8tZlTgzzKvJ16uRgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 VI1PR04MB6909.eurprd04.prod.outlook.com (2603:10a6:803:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 13:51:26 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 13:51:26 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        haibo.chen@nxp.com
Subject: [PATCH v6 3/3] arm64: dts: imx93: add ADC support
Date:   Tue, 17 Jan 2023 21:51:37 +0800
Message-Id: <20230117135137.1735536-4-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117135137.1735536-1-haibo.chen@nxp.com>
References: <20230117135137.1735536-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|VI1PR04MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d51a46-cb17-4a5b-f0a8-08daf891ed18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ch9TJmmvReRiYSKt6wSTRBuO4THVNIt1ykSpIgQBad/88xfWyLcvsyyLuloNaZGs4Z44qvtoCOJb+KFgyuw1vE+BIEiHtYlMhySlbCtNIdehUKcLiEQVRIOwBWN+NrWPEOZzmlEvrgESFxLX+f5OvSahu1TqFbX1VuQAt5UEBB5zcw6H+HHQGZ7W8Tbx+YLl7xvoNWLFqpauNft3R5QwcZwvq8wBtZHkGyNWWRsVkAhpW1yo6tScbS/qit/Wx7sS3fFWu2WpfJ02QA1SjSVxqwFiA0BfKfETQNazyVwajOU/VTFBNUOXWo8jm8NMxenZBnenRWR4U0eBXcjNeSq0UyIDC0BvNw97ouMNwxdm0hNzwmgqXW4QTsXeYpBxmbH095SEHb9imk/k4ZjaKE5edZn8m1Dn8Gjb776qP+iXUGoh+WfZbp44VRK6dAVssEl5RXLNj0F/RiIhjwKveVbLlgtEMLOA9laS5ft0QFKlkuYVSgDl3UUhh1eIihX0jYxcpMAvrNZz/TQ/aKai8nQc7rRpG8mIaHSWTymbMaDUeFkHCv2dyfoamo9qHboNNXvSNoX+y1TuysdV5IWKxn5EWa0bAFUcqCHD0Ud66sA8BcrnUJf6hTkcPrnXYFl84fPVH6x+N4r92cgWH3/d7CZQWIZz0M3SXOrr2A+hKaYqj5R5k2exAdUqGuhGfX3PmQF29LUlVfLIXAEcjTJEajj/Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(36756003)(86362001)(66946007)(66556008)(8936002)(8676002)(66476007)(7416002)(2906002)(4326008)(38100700002)(83380400001)(5660300002)(38350700002)(316002)(6666004)(6486002)(52116002)(41300700001)(478600001)(2616005)(6512007)(1076003)(9686003)(26005)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7LyFfEEKkUA2hlkkwFPtXNg3/G5Y9hztMnnkSfktsX16sbJP+jQJBO7Z8urP?=
 =?us-ascii?Q?kGZ2MyfenWc7oV/JpZbFrJS7oXTzpg79c1qS0YyU27JfFysVR/McN8+icANJ?=
 =?us-ascii?Q?xNEPTlMZut3SZ+Kodq2tT0W+TJWqFov8kl8APUniRtZgCuS2CLWPTgZ+Sbf0?=
 =?us-ascii?Q?960qBiEPDjFovnpxptMLR1L7KbFSEbwi+ITmSa5IJr5IXPHgUAR+A6GBmVaJ?=
 =?us-ascii?Q?4Ss3zDmvjZVCM6kbETYRAn2tMI2mTlVEAOyIgzPtOF4ndl5zl1/ndvZswBah?=
 =?us-ascii?Q?9NYdOpsrKqY7bMeie/mFOmbzxO6Ztw8axdweqjcSzm8QrQB8d5i35qOOhJAW?=
 =?us-ascii?Q?tlvBONnWjPubx++zHFsI+HoFmCiUDRWixkUgljxqlzu0iLRcgGOn/glSXfZL?=
 =?us-ascii?Q?bU02UxTskgKOaC1QfyKH+v7LZSlGpLBAKdt+CrcXNmd/0WfVwGZO9KBSyvZY?=
 =?us-ascii?Q?GqfOx36dTDjMGS9/CLhHS37creVIGYZWbNtdcPhOjLsceUSfuG6l+0iRzeWd?=
 =?us-ascii?Q?SYjFJ01OqRRK+DnSh1lBxq/EhQa7M16dSSPLeF1044chM9Xp5X3ULJLkO+e/?=
 =?us-ascii?Q?4XPAg+ZWs+F6i98ptDdAOqI+q0BAYGm7Qls9hraz+lJgeJsuoNj/O+6TbR+2?=
 =?us-ascii?Q?8j+dVj1HZZyOxLVl0qy1W8LH0BnvjOYlFBcYuzEhU6miX1yn4BvMtiDh+HlF?=
 =?us-ascii?Q?PEzewj1vK+H2xwJrkMArDYSeEvKNje4w4xbFysynAXYfuNOVPAhBUOykQsfy?=
 =?us-ascii?Q?xELIxCNxYI18Lgn1rJVoFyzpFwE2ikab4u+GYHax4z7J7udA6Cf7fMFj1Jjc?=
 =?us-ascii?Q?mPg5+YJWLLTmj89QFn6+FDiuOY2T5CcJPqloj8DXtje3Bwq/1onB+P4M9fd8?=
 =?us-ascii?Q?Y+AYJjBvuXWFKABFHz33sArfLLFNMl2mLAbofMiuzxFPQq/60jeJQiNFm0sn?=
 =?us-ascii?Q?ZmeXDx8Fo+p2L32D4CAFk2c5P4UlDwZKbvAyLtwgaLZNijpUoQjbDN0neMAB?=
 =?us-ascii?Q?6dt4IARIJbWUBzES3+ubPdLA/M0FbNKhTtKd2Nb8SbDOW7EQWWZFeKGRHcJg?=
 =?us-ascii?Q?frIhu7eYPbqWRkW9ok7kDOiYGbL+smyYIwAsfbAa2RobVZ9B6F3UxVLXpwMH?=
 =?us-ascii?Q?DagkFJiTJ4QKfqL9lflrvpJB2jQWrowlb0ukTuUFIS9WvDNs1rQ8PRPzoCsR?=
 =?us-ascii?Q?uf5sSGGMjbR3zG1u+9uzOn6rp7zcYvPjF8up6UdHiFJzKyloVtPBrjy2VWZj?=
 =?us-ascii?Q?ZT1XmzF8h+LzgpzGK4COwNC5ccev/GWWzhTSayuyrgzVBpqbD8RLtGJ55RsJ?=
 =?us-ascii?Q?Vo0TGBUqFARI6juBVHozXWGq/EkjMFdISA58DJaWnfMcn5q4KR7y5Rrf8jKG?=
 =?us-ascii?Q?prtWP20+R6wd/0qUHElieiXUcuNnqhkbb625+TZi3SJvjOTt1a+v2V50mDmJ?=
 =?us-ascii?Q?z0Y539nmHv+SHM3QeIyaPADfsoVEiLBokXyKKmhIlXAFjX0PgAP7RbVtgyxv?=
 =?us-ascii?Q?+bb2jqKr9qnspsImlfZ1Ag39ZZTH+zOcu6OqqH8wWbgz8/ust7CSr1f7iV2s?=
 =?us-ascii?Q?Kk33BdYjOwRKMDqBzvBd8t8GHtjW7zL42LB70tyi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d51a46-cb17-4a5b-f0a8-08daf891ed18
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:51:26.0627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8a6DfiIqscXwTXNT9Z+Rr+upZA9xxqO7EtoE3RdMkQjFLgBL5UUwB6AX9NB3oaK+AtNnTwlR8582AUmrIziFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6909
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

Add ADC support for imx93-11x11-evk board.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 12 ++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi          | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 27f9a9f33134..c928b6824e41 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -15,6 +15,13 @@ chosen {
 		stdout-path = &lpuart1;
 	};
 
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -27,6 +34,11 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 	};
 };
 
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
 &mu1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 6808321ed809..abb3fbe4ba22 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -280,6 +280,19 @@ anatop: anatop@44480000 {
 				compatible = "fsl,imx93-anatop", "syscon";
 				reg = <0x44480000 0x10000>;
 			};
+
+			adc1: adc@44530000 {
+				compatible = "nxp,imx93-adc";
+				reg = <0x44530000 0x10000>;
+				interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_ADC1_GATE>;
+				clock-names = "ipg";
+				#io-channel-cells = <1>;
+				status = "disabled";
+			};
 		};
 
 		aips2: bus@42000000 {
-- 
2.34.1


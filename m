Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FABD65BF51
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jan 2023 12:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbjACLoM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Jan 2023 06:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbjACLnb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jan 2023 06:43:31 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D4A6153;
        Tue,  3 Jan 2023 03:43:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZaz5hqZRSE2/Gxy7HsRyQnozoLJgH+PLO/Piks3aFAjEmo8Mr90egWna5tCsJX4/4H74DmQD9Sud5qaH+WQkAKiJnei5H6PwpRUJUndpIl3bs1XaWPj2cDYN2QPgqov2NeuxdLSpoOeeRmjPxQXVxc36/+whXLwAQDqyHAgLCmITP3zXAL+RZGqEFEsy//8eT5sbz+tVe3L+SklJhkeHii1MKOrRWnhdcNjZrqO6BemG6GB1xoc7AY18CnySnibu7LoMj6SXfuNCXYIb0r8KGXIDP3D1kKpmG0i4YCDVO1XgR55KA/XJtQPq9RYIuB7bJnB7Tm0I3nQPHC6fhn+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnF4qNwlp9kJu26GVY9c+6QFxVEYVdoAp364itOFTKg=;
 b=oU3bSkV5rRfye7YQq4ngtiC2WXbegLKEnoV51gsmGuzgt0ERpGiL0rwcynEq+RdghAW2A9IQHheZbAsO0Ht17WxHlly3h2M+PIMFJswbIQEKReSZhT/jKvhy8dh0DAx3aIPryhcOeopXoyTDcCFdzG7m8PhC/JjSdn3BvD2srfkolaErhe0tbaTrpn15kHVUaGn72nLONnPZwb35JMJtUB7HtzqHrjssOQzbCOD0xlmOyswdiVcr5/UzebP2Qggzxj5U07Je7+EmRVL+f935XDx94vMbOd0e+x2xTj/T3uVmh64ZVfEViA0NWT4qdah1/PFZ+0J6Wp4MW7YJ/yjthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnF4qNwlp9kJu26GVY9c+6QFxVEYVdoAp364itOFTKg=;
 b=L9xrSqqYOS0We0ptUJ1MhGgkQ/rtm+Lv/GQnwzCqLlvGwKx9QI9FJS9dY20QNLDn3a9v1hr1ZM4/l1m/4K08GK5cPcn68yjvypIouvDy1gZEF3vaBKLoaNFK1YiMH9leaQ7uBwKEfxjc7wxMoXMO0I2IeMjP5TZNOOmPcvoIAyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 11:43:27 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 11:43:27 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        haibo.chen@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 3/3] arm64: dts: imx93: add ADC support
Date:   Tue,  3 Jan 2023 19:43:58 +0800
Message-Id: <20230103114359.2663262-4-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103114359.2663262-1-haibo.chen@nxp.com>
References: <20230103114359.2663262-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: b61b0753-4720-41c4-a7a9-08daed7fbaa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Qo9qwlYEzvnGzU5dQwCHSRxzJXT2zwONLYmGz+DCH+cjDHVLEPkkvgeniYYDjjYxLmI21nZwSOKr6s35ExRksrbSUdNFXvzBWt0Rb8XFc7c8CrI9YriwRxF9W3S2bdjIRX27lEDyqF79TTvlHW1OLlYELB1sx7nMyl/Gz2gMJT2Khg5DRd2X06GHWa4EBOwj3eQdo+WB3Yum+7H/5awQET8Opzu+Uj4C7A/4gAZfrDCgqi6xl6s3tDUGQ8druA0DujtGJ58UHgpQ5XuYDPYCKnITpMam19WWPfJRaVXbCTxf/34QQ+fUk+UGBeroCQTu33xUxK+F1UOGyznLqjXvlbySHrCeOmNXt3IoEcniVj0MQg/JSc0MyT0y6fhIUr4VX4KYmNeeBcLnSIqXYfso9S8kx/UH+icwVdRXsY3WdGZvvOk+7gPHIn5pqUUQcFMUA0OSS5CqfbLas+cKrjgEGHArTmPUkyh6ECHvqr/Eze2va32mPqRNYXo77YKTxI6WY5czK8IFrGSSjKcDtDU2GCMGQPPqMt5Si2zqktoS2BdvZoGnWBvF37mVF4faAxw4dGwfPZW2ThS+kMEpvPEPPLXJ4rLF2EyaK6L9HTsx3njy4PirSdPhTHw+ruxpdWn6nquzXARY2sZp9BUNU4+t9+xH7LSPFMk0WZ/8P4s3/N319AQGAjWg/uI9EEusOTh6af6JjsRo5fGjMvEDbqIEDHVeXV57rMwgAmPlBE/s+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(6512007)(9686003)(26005)(52116002)(6666004)(186003)(2906002)(6506007)(478600001)(6486002)(66556008)(66946007)(1076003)(66476007)(2616005)(4326008)(8676002)(41300700001)(316002)(83380400001)(5660300002)(7416002)(36756003)(38350700002)(38100700002)(8936002)(86362001)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cfEBRtZiCJrSAp+TVtv0FJVq5VJefxKCwA+6k+inZoU8gEjR8aoKE4HbSzpF?=
 =?us-ascii?Q?ADhDMVi0cdk/gyZ5aDm14Dz5Na5sn9r0coRrYGUYPUuV3ieP1TWgyfRYBxdg?=
 =?us-ascii?Q?hY4W0xcLrpH9LW1XkBc6YxokF3yRUsnmXyOWhbqt527AOEVD9VnZPhBMO8L0?=
 =?us-ascii?Q?LCveuYjJHvw7IZNSuJdLHAHVYcH6nArG1W4Lr8Kxxe2MhsVmfGLMKHU/LO4N?=
 =?us-ascii?Q?qirN8fFfwen9lmJXpsVzn5GATPTiSRDq7T3O1SvXuu8tyyKG9w0vrOK1/gwZ?=
 =?us-ascii?Q?k+MpgKrsMED/TLwDHqcSb7n+0YvMQo8aBJExMcm9e6Kzrx09/MZtqW28qS/P?=
 =?us-ascii?Q?LDg9rUf6/lvlsUaN+bn3B3tFuz0xXZUcy4EcAGSvXd14eafSLrulhfBoM7Zh?=
 =?us-ascii?Q?v/ewALH23DS9o2YGpf9sGKhEuK6GpAMmKPn4GYF4norMOZ3Kg09FQerapilQ?=
 =?us-ascii?Q?L1qXBYIowCjcT95m3kpaN6Av4pO+BAGfOoIfFXqe4ssZuw2nRk4OzkuBHnLG?=
 =?us-ascii?Q?cGZfTC30s+m/XZlged8oCh+wPc7m1IhsI14aFpHqjEWYiMzFodiwL2HxrKas?=
 =?us-ascii?Q?fi0zwXF2noD7Zzw/Q6fs5aALQHKaiK1Qw0o3d6C0yhlAwhS4VJcm+XDpiBnp?=
 =?us-ascii?Q?9+DcYURpShmqbMNElhRvAo7vaJIJQuaYIn3JNLUxOAlI9bBNtsvWI9ZR3QyH?=
 =?us-ascii?Q?9iG/CL6cFVmn9cweSHdqHiG4LzfPUXD9P/zXSIi97JKUcpPZMj+UC///HZBe?=
 =?us-ascii?Q?NHUGrVj55Rq3FYNZIqQn0lHmQHRxE5iCuzmr2dWJl8kpT2FzsRAhjyb/qGRT?=
 =?us-ascii?Q?2RTywfLkHGvS4pOnWd4zG6Kl+Iu6Z0lM4Q02vxDe40ldVhcYq06xB0ahuMkm?=
 =?us-ascii?Q?WpHDfCl4wSpuVMMZ8jqG2LhSNA+mIcoUdwz+V1r2S+dvx86o+AAmCBwQu31a?=
 =?us-ascii?Q?yQTNHtfgruMSgj1PZD4VGKhCuuISMfsBvjUv/Vb7DusCVIEQkrWHR1KvpyL8?=
 =?us-ascii?Q?XJCOL2AfrHI/jT0qmlYlVWErnGMn9Dmyjt5FOCGGg0O3qlzy4dikuy8Wp6TT?=
 =?us-ascii?Q?FAYmvNP9hT1MZ8q8znJPwPXNT5iVTOjlHyhlmkLv02AZ7/QvOZr908Hl7jn0?=
 =?us-ascii?Q?EEFTzFo1j78za8lml3GdWAYuCzX4iHcBCMVpraZizKTqhLGQwt0T90kql//R?=
 =?us-ascii?Q?hFG9jLvdVcdXxBx0pQCC+ECqREyUoLz3jX89Ob26r2GJsGQdhifAm9hdWchR?=
 =?us-ascii?Q?YzuZvtCvvEVf/iEK2UM/bkeZQp61nGzGx4a1d5tNayMpL1ztAv5iYPT9bid9?=
 =?us-ascii?Q?rT6OVSP6X243XZ9ngqqKDILl3OJevphh+8uoXo/vNqxLCmaSbQXDnRXnkDoB?=
 =?us-ascii?Q?5+ayYv7Mh9O19uJgKqRCPKkT48il4XJDTonBNIxenkfbzxY/7Dg/QYJP9wK5?=
 =?us-ascii?Q?fkpJi/R+C/oq34vz687F+qxr35E8n9UybFm3H5MASwHyRdL7jpsfCh+d/a3h?=
 =?us-ascii?Q?PWQTzM/YpT3sS9AgGNJbqmVuUPc5zoOuIsiV8/6cO4sR9Mj4Y0ic7YOEXl8y?=
 =?us-ascii?Q?K4IAt6byN6imRFKomJgJozQJ0MFIqs5uByZL57WO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61b0753-4720-41c4-a7a9-08daed7fbaa7
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 11:43:27.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfG4HxnYK13I7icO0u3ERW9Tv0RKHVl5fmlr4vw7ksU1h75xwiw4oXy60Xih8Rxyx4y91EGpGQRn8rxTi8kcaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013
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
index 69786c326db0..cab5f4d66bf9 100644
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
index 5d79663b3b84..a0d39dd34591 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -266,6 +266,19 @@ anatop: anatop@44480000 {
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


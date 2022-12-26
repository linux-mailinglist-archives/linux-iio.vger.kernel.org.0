Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D838655FEF
	for <lists+linux-iio@lfdr.de>; Mon, 26 Dec 2022 05:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiLZE1I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Dec 2022 23:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiLZE1F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Dec 2022 23:27:05 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2079.outbound.protection.outlook.com [40.107.103.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA84F26;
        Sun, 25 Dec 2022 20:27:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jekBTXU7Pcve44wTxc29PVrMTTcW25rdmBKd16QgZce5jc3/bHkPe72dEt/urkdGMGlR38Mzb7YNtqQ8cxy7d91djRQtfJoubRlXc6r4xNxGEPhvaC+hOsfIzaLCZ09YqyFAV8HZKi5zCosDK8x8visCTOIZVNDCE8xRbHhQvrBE6S1e3FT/kpGs5okuitiyklK7fgiwRwld9zrk6HsJ2EAzd9lyFLMei/MHSK8mQlSJEBWdI0SmdvHQSFo/L8LDSvANiPBpA/F13uHiYQ6iwLqwci8ZWIvFvIFhdcXay0ghSlrkR19mOtfvYrgC/S1ODNnp6U9CoKU8Oob1WEmW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnF4qNwlp9kJu26GVY9c+6QFxVEYVdoAp364itOFTKg=;
 b=bHI01kFAW6pygQce9+iBurupRc4Wo9HWoCJacgawRVg71lkRr8WmdR6wL8IpEEw699F8cg3Q9KGLMHN+0bj8CuV00Y3ocJm41CYFdqdOYn2arJaFvM83fLNPvAgh9BQ1QsQoZ3e00ffFSwHFa4DlFIPI9hnrIDJBcvk/HmWn+rfkIaV/I9rA0ZeTndXvBOmuytBmLm96KaB0/yaa1rAK/5AVv8uODCIJ9uWu5NWTZ8FNcCX32ud0+kD6JgMR8sCViLXTeyQjy542M1o4v94rfY4nocCiyFHtZgaKl6Ko7x2rMs9Eo6hsLicCIUJoFtE0tKdDnDvEo27EzOsExsj6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnF4qNwlp9kJu26GVY9c+6QFxVEYVdoAp364itOFTKg=;
 b=UAE3MK8M6rDl+lW8ocXdXfW8WhrXWg0AEUo//JkqhoTCDgUSnRZIZN79WW9LwisLOORw4jfXlwJmbJjt6sZqSrozNWk7lCPeMTpsGSvT3x7Cd50XaNJhnm9M6hdCm18tPjOVqAXhHWTybwpSnwbqnGVWmqMOwbH77mR0SPsJhN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PA4PR04MB7792.eurprd04.prod.outlook.com (2603:10a6:102:c0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.16; Mon, 26 Dec 2022 04:26:57 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5944.016; Mon, 26 Dec 2022
 04:26:57 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        haibo.chen@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 3/3] arm64: dts: imx93: add ADC support
Date:   Mon, 26 Dec 2022 12:27:19 +0800
Message-Id: <20221226042719.694659-4-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221226042719.694659-1-haibo.chen@nxp.com>
References: <20221226042719.694659-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|PA4PR04MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: afa1864a-7624-44f7-30aa-08dae6f96cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYQovKxL/nxJhpaUsQLAhSCgmJwqBAWYubktBe4ko4kEYCoh5yff6h5OikYd6AKTVvnfaIN7PkBmq4nN6EqYgReMOV6xLdOUCb2krduMlTzWA1oP4IE8jijpWZP7tMj74DilzlNp7oOMuKjQnf8PWRjldT7FqGToqNQTKgu/ovbkQhWhMpEnBXqcmt7obDvocEAY5VVkMxyC3P+FJCSapcH+d+byhir/30184zNhkx6eqOO2w/wUVluvpz35hVJLFOPpY3riwB/4SsPgnMjzgmPmzqj2s6c4ZI/hPm+44Puuk0B/S2R9FYXG1yt+WlFGsrhp5irPr3gMQSsP7WhZLKrVgSKBcGuQzUekZ1RLzSIASc17XBXg6RO8FFjwXKHhXiC6M/Vm2cQ6F1q3ipD+dG3jCVjyCaWfxQ0tngYnpKioeGeYOttyVhoH/K3UQ2bFkyIzXEfor0baeM8xZ37rXGUyZc8Eg6Y2yV6BH70y+U769yTUtlh8pylaLzovXaWOwERk0Xfbf1IlR4p84RuQQFiWjQ8qfk5F6muoXVR9U+3Y5bWGtoOpxTs2DVtxCoHvrO6Ssrjhjejd9ZZIXd9pwsoktA4U9LJ3PVoekm3KaOmkUxWPFUZ8+IwPgm/w1slu3dGwMGnC97PxDK3t37iu+89M+UgngbJsepLX01+KwMNpntMZGBUT8QjD08bIfpo0gQBRvI0daJYV8ALJCZBVdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199015)(478600001)(6486002)(6666004)(2906002)(316002)(52116002)(36756003)(38100700002)(83380400001)(38350700002)(1076003)(2616005)(26005)(9686003)(6506007)(186003)(6512007)(86362001)(5660300002)(7416002)(41300700001)(8676002)(4326008)(66476007)(66556008)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LoUDTGdMe62iviqK/LxnQ44k8WDA+Z4Gm6LaAQSOqDUifV9sM6EYmLKZ3+31?=
 =?us-ascii?Q?v2SRkM86eO0odzJsPWyQ0Rh32BFb87vykqjp4QsKryOw8BhGQeVu2UBESUOq?=
 =?us-ascii?Q?IjGh/wfrKD3AgSauTLlI7csEK2WJICDQJEtp41gGXhd2x9O+cTWXNxxOCjHb?=
 =?us-ascii?Q?hbEjoGcmeqTWj61BvOSBkjJMYHXVNs5z+nTRqDOHPvV3FskNaJ4Qdz33FYku?=
 =?us-ascii?Q?nKg9OoLpGHRyDPCW5fi5wF6X+tXpmt4O6FLvShZiPSJ/z+WLMqy0MuYyVqBk?=
 =?us-ascii?Q?PCggAxZJWo75otI/2Txk6DTHet3OWJ1aCjCGZMLSZ0S5lcmfe2YbzVwfrUp2?=
 =?us-ascii?Q?LVHvnhdl6D/YVEHoczSXfGig9YWwjvykNwSA4R5KVxr3CR6exWQSHmSkMz75?=
 =?us-ascii?Q?XAulc1oXeRs40nS7IkTtPCBKC9zUoIGBma+9Aj7G6lYrtt6TI9HkPIGviLO+?=
 =?us-ascii?Q?NDTMGHdqx1jW1SZkpLfXdkamsKCWc17O84zhnfyv3vxK2hJZw7bcfrHKbVjt?=
 =?us-ascii?Q?f8jFmaI6DLQGPBpJ3cvzYBa7DuwiRmSEhkqjNXvRhK3a5DDsDqAX43Bdq0tr?=
 =?us-ascii?Q?YDvopAz+1rxWc5rqz50qZ/FjoTZCRS75fo6Uwo6XGrfhNW0kUyxOl6tZ5OsV?=
 =?us-ascii?Q?62IrZVrrGoub9+grOezHpeTrSDPlsqatPiY7B2YPYSACzpBwxk5OBYI+ZDeu?=
 =?us-ascii?Q?q4e8hQAlFiDTuQ3P/3HKOC+VLJcXna0Rsb1FRgwH3KDayZhs/upE+Ft8kFV1?=
 =?us-ascii?Q?T36IYBSqHNwRs7ppAha4LWgNBHbcyeQOED44HtRUPfKfGKNuDHiqpYZf1l3M?=
 =?us-ascii?Q?qW01rPRsmrW4Nm7xMgNCUabIUai8YoVImC31lNljIhmDBOP++IeCo2suI/H3?=
 =?us-ascii?Q?MiIfnpIAm1iz8B/pQH/Fzi6QU75mvHiGU8GDN88OeeD5F+pWh6xAo4MT++AP?=
 =?us-ascii?Q?UHv7bvKUtWXZ4yBtG6vIBodXPO/bGZWLSje9qE5XCnj+A1vJlRmTVs7kqTUy?=
 =?us-ascii?Q?tXS/5C9Isr69Dm0j0gimbUYFeVxyhgGoH741dCjkXkcZT6iyR4gNJl8BnwvT?=
 =?us-ascii?Q?4fm9kiZcZs92QQtM7MW8ndw3WKj8A72GLL2KgeVwV3Ybn/uPAgvhd7uCFoZY?=
 =?us-ascii?Q?ak0zBnb4Uv3Vcdtf2hf8tueRLDd7JaGAgRelGklcWeNbWc7Rk2B794oo1vPz?=
 =?us-ascii?Q?xoEHLYlxdZ2Zgfkw/3x1TavCdot6Su/0liBOvbMMNgodU7448tETKwtRlE1C?=
 =?us-ascii?Q?XtUvq+IJk6mhzVYoxC08hLcfBwmziJEPV6XNSBrGzxr2LzVrUQ4UrtfZa104?=
 =?us-ascii?Q?n2mz78bgpsK//IfHiaGbMBysr2yOkqwBrN8F20jhsqN0IFmbiqXukxXVvNWY?=
 =?us-ascii?Q?v/3mTzp/OT4Z9yrFTECm1yhkVyUhlBUa//IuXfxbglVkpk8Qz5MqWRAS7Yrl?=
 =?us-ascii?Q?ly+8H50qkcuuuvGda206Na3pOv7iLt42/aK0jQPlokbPh7PMA2A1KtD2YxsK?=
 =?us-ascii?Q?Q3BcfatYzR6sYm0lb72tmf7rbmX9iTi9aqpgIJVyMc1Tit7S6wGOobHfRNFK?=
 =?us-ascii?Q?SOsnFtu6oY83iFkgUdcCDJJcyaV+wRLFf+lrvPj2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa1864a-7624-44f7-30aa-08dae6f96cd0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2022 04:26:57.5674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtQgfXczLpi58ZVLHbTNKryECwY8U8Hso4GrRXoB0maIvcAK+8mPUbpuQ3LeEXh9H6EGCmo9CQ3EolQQ/TZi/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7792
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


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285BB6509DD
	for <lists+linux-iio@lfdr.de>; Mon, 19 Dec 2022 11:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiLSKN6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Dec 2022 05:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiLSKNu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2022 05:13:50 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90503A444;
        Mon, 19 Dec 2022 02:13:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIgitW3Dgm6z4ToVL3HUdOPktTZ2ZJ0+gDl4cZbnuomd/2SzkmSzrYaSPT3GnWTJm8H0spbyJuCTetM35N5IPLiR9/p0go8nFEbQtPbCJ/wecryWIFg/4RxIU/7WuW8Yixt2IZjPbycDZv2VVhFfl802FSL8M8T3I3JwMLMTn/PyFO7CXMouo0mZOA2u8L+tGK/gt9OZHOE7xfbqCtkJL8FCzezMlqpwae37gSsvVtfZGsaK8DBMbLqroFOywbusKSdMmremuyP7CcYHpTglxOAvMJhq0SXZiXvfwowpSyZHa4GrUTyUn9oh+HmqLL/uu7vRWAdCW/c1dugezBvopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnF4qNwlp9kJu26GVY9c+6QFxVEYVdoAp364itOFTKg=;
 b=AdWR1mnTLPf4xE7t+ODPMFiYQIXjCt0DGO0tzA76Yqb5dc49rSRSTNF2HkW7yIFVG0SnSgJYFzPZewrc/jcP8UtAEpt6P6rrs/YyyxVEKwbrLmLFwkyLb2uCwMRWDySM4sO28Jl5w8qjzOWRhgocaewSzQx0/6a8iKfxqwLnWphajgn0G4Ozq5TBn/pA1gAuWJIC38hL/fSXVHpI8kydtUfXuNdptWTTGK/EF+LehIEE0U9vokMZr2ER62PLhLUVU9BSZp3DsDJnsV2w5UB31hdDM9qhp+UABVLNauCehZkZfokOLjHCeOO6t4Bd3H0GSqVyVzKqKgKEpD2jLqn8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnF4qNwlp9kJu26GVY9c+6QFxVEYVdoAp364itOFTKg=;
 b=JmLS7tvVlmbQJfUgiasuPv/YQeGFV555KfEvVr5ypNHFIBEWFo1fmZKzVolTnrmd+j1CZxcbuL0zTn3Wd1qQ89TntzmrlSXQ71d+aO4k/AdHhvPT9UtwxC10cxf8HH/lyXz46u99p1gbg45cz6KLzHqObmPszN7/NHv7hvuyLSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM9PR04MB8178.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.10; Mon, 19 Dec 2022 10:13:46 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%6]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 10:13:46 +0000
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, haibo.chen@nxp.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: imx93: add ADC support
Date:   Mon, 19 Dec 2022 18:13:36 +0800
Message-Id: <20221219101336.3929570-4-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219101336.3929570-1-haibo.chen@nxp.com>
References: <20221219101336.3929570-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM9PR04MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: beff18b8-27ee-41b5-de03-08dae1a9b730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzofJELxbtuO5RncnoqgvLvHgyV6OdCHKdjV87Q1CCx6FaJkgKRsbnjudsy+0ECNUB0iweO1esrmKj/7SzaxSh2Vo8miLZLHhbKtHeECESvYGZEspTPKOE1pdMOx1LgND1YAn41W4Z7vj39MxzNxbd4EHaqD4xRiuT65JLhwbPZPC0KwPMtRLpaxMVbJtz2SmeyCqy42bCCJaqNk4h0V7XwAP4cylToXDV77Ic2vgAt8XLnXUpOpW8IPNxrlFPCVUcvh77+YH0av7bPW7+SoTpDWcdlK36NFLYUW5njexPZNX1EvfXCNbUu4rmm440J5WMQ9Oi+R5cq1yoG/Y5/FD0Bk14bdSv74yxlTBF6lAWWIzYcRz6a2vSeSEloOTrVsDhi5c/qI/TV3wAfqFAbw5CexPwlW9tc86enluOFmGynUyvdkokO0/rGSz6KXGFkHX1jEs22waDUHVrcHAInSdYw81qC0ZsN93EKEucs2NfG292v1n24YsmkJ09JAmQdvbNSyRMy38MQMWmWargBwdBCWOEjDknFnhPOnppeO5ykR3MueyRfI1avHGRrtviiwYiPoUn91RSKqBhW6GztB27b4h9EsjgFLSOlPsmDN0V7zMdDSbGTnW3AgAyEtOwS/crbwAnJllw/iTbmVsBbTU3xQYZA2PGJkY/kGOuqxEoYKY4myYM8vjcHjm0nwjXRl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199015)(66556008)(38350700002)(41300700001)(7416002)(66476007)(66946007)(8676002)(86362001)(8936002)(6512007)(36756003)(52116002)(26005)(2906002)(478600001)(6666004)(4326008)(186003)(2616005)(83380400001)(1076003)(6506007)(316002)(38100700002)(5660300002)(9686003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uKbJ+9/yfM8ZfwgNv4+aMClGwkfs602iPNELXCeN3WsmMsVJu2AvodY8aNCp?=
 =?us-ascii?Q?k8tFyfVhPhp3O8cl7SQX/EdSYI8o5mQmzWvWzswhR9bCIoAgT40Eoua/UMF1?=
 =?us-ascii?Q?vRYP2ZvHK2VplqflrxxLG2x/R4cQfsgwGwr+2hW2zH40pISwQO0xYJKgzP/8?=
 =?us-ascii?Q?KDFw/vLV0PL4M8lpEJkqosLcSHb6ghzt6nSspQLlaXfNPVEzCggv9SR6i0Rn?=
 =?us-ascii?Q?v2LthOGsmimIthqlxi0GCxhT7ZBNiNeuG5Nw8nQedc7j5edvLYFcfR0r7010?=
 =?us-ascii?Q?/tkyI6x6GPRT7RUdEeICptUsPGbfiLowxg51G7QJV0saJcG2z0Bi5PnRVBK3?=
 =?us-ascii?Q?LusR+tze+OYkwWzGUrBtNEv1kd3UkYpWzamA+FfJyVllJNecNMmIq3aKD7/3?=
 =?us-ascii?Q?WcYcJimG9UzQ2YUYH3/M3cdzj/L1x14y3fx2legeHDAxkbIa4qxx81o2JxJI?=
 =?us-ascii?Q?1gK1OYLAtAnyy9UWKnQz5MLbvcCzIq8xSRSaUW4vx7ZSHfACUJz1v+Q0PwK+?=
 =?us-ascii?Q?cEtuTve406+9GKAY9w08k60aVZQgs2/JoEyK5kpsFxTA/rn782RP6/llYN2U?=
 =?us-ascii?Q?yNG/6mhpkU8hj28xxKO/Z0xPgHb+W94KKQSYlPTKwMfZyX6wzLM8Fr5fAOEN?=
 =?us-ascii?Q?9Bqg2obDfPvZf2V8Ve6hNXYna3CtW7lndygWlGoKyw8zHprl8Bcffx3tSOS4?=
 =?us-ascii?Q?sfZzIzwYbz5xYgTN3g0RyFBfZmuOJ5tca/gIq8JzI9nPt4QYbBcu5o1WtW4M?=
 =?us-ascii?Q?MjxTG6zq+kbueksRv9934tAK6bTLfveRUjxPyUnQbovXjjscio781qGc2egM?=
 =?us-ascii?Q?Azl96X1m8o/NedChW48dB0HmIr1QnlTWjHFCw8k6APMWnJgH9uqjnwNQ653G?=
 =?us-ascii?Q?fskhH4831je7kWRP3Mq9KJL7ZW8uvCC+ksU/dNxbwqePlpCSZQTWv2LVI19G?=
 =?us-ascii?Q?MNw6W0PwJ2jt7KsH/s8RE3uVDF2eRIANVzv2OtEQmK14YtNjXvWRmp4VbMsu?=
 =?us-ascii?Q?ToPrJ6PbM0iwauRJfBZ+HXenClkojjQJhIoYJSftnwlHPEx3oz3KFnSanlzA?=
 =?us-ascii?Q?p616gp+YVzbw3HiWjvVShz1hq2YAkraKyU1VhzbBsbVCJpqD8f21jI4aQvY7?=
 =?us-ascii?Q?vkdV8qDo2wIYWdFAvmmAkZ9F7nfLi3ldJVDjY6SZ8cmS0dY/U3ZyPwequFzp?=
 =?us-ascii?Q?I8Thc5GnTwV6U/7IEA553w1tiICQUkM4eiI+FNoncyLNcclWn2DteXo5EhY6?=
 =?us-ascii?Q?9ZejPFSEy+vCYHajD3Uoc338nHuKTAAosZvlWUJ0PyAh8rR5hRMullx/lrEd?=
 =?us-ascii?Q?s5p2hCj3/5k47wc/qKlFsUVnwIEiPtL2eYGQ0bJOHRJVXK3sCxJ+Qfqg37Tp?=
 =?us-ascii?Q?lqXYf8EU/VhDccP4sUCyG7d+0hUlZg0LuKn28vGTYi5qjP9GVsAPjl2lDYYV?=
 =?us-ascii?Q?h1+90vHvIowb8oNSClETAdBAsnPcRdiUlwNoWHVOe4rUe9AOvzTQegqAL4Y4?=
 =?us-ascii?Q?ISFIOcQH/jPAcNr22/wg7iSDqDcEtnT/OyegnI902ot5XjsEohW1iqa5MY0H?=
 =?us-ascii?Q?yaMGdrbNVL6X9ag+tOAWuEXWOLX5mGXP9OEHkMTe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beff18b8-27ee-41b5-de03-08dae1a9b730
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 10:13:46.7220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRaHyePqyYpBDeLIqqX06hpDfpYUDhjBxkWDN5Nbg6uMPdD8HUwqzF1NDc27PYo2Jr22KnzTnKvADNsv5TWgmQ==
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


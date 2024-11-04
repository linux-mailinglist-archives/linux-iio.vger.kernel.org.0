Return-Path: <linux-iio+bounces-11904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DC39BC14B
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 00:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F74A1F22A7A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 23:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50F21FCC78;
	Mon,  4 Nov 2024 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nfsk+/LQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168F616087B;
	Mon,  4 Nov 2024 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730761941; cv=fail; b=FzPJTQm2zDDDZvD9uzBE3XOZGXlATumh5IqVq8xpA8GzLA2Ft74ojTSy7NFj5sOj9zHo14D0k1WDMctWCwuSn4bRvFLw5+XP3tFCV7YzjqbRYGVyGZREeox68zhqyrsa3oDqncdoeZDu7OicuLW12M5uTGbDJoUC1/injD37YWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730761941; c=relaxed/simple;
	bh=5++BXI8md2FKJ4/PmLSPUeTym64LQ8BHsYdHHAmH2bE=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CUcQcJKsJj60Dhj9ZKblKbiLZwIV7teulKo4A1w5AkVPh6fd1PvFXam0scsZvX4BNtzguMe+4NlZRQj3GhLKM6/NvlqQRUiGKnU9cUc465mE2HgTyJAjtQjK3mhd602ZZM8Tnn0r7O9c0CY0VOx+8exyikJP+03fp9suhuwaNI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nfsk+/LQ; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpoM/TEvEb4ycmFi+mqmCogYy2R5VPxgYI2wi4LSPYBwBw3DXnq5baY7h5hG357TKXGA+d7KnNlAspmEAFRzVO1gk36drgdkojXem+l+pEiUxqWw9gISaCiuL600FtHrHUgl80qoSxOqzETpK/RZqNYMRSiXhYE6NKBJ1mH7FVBZi6GMnqSlzNfofcGK2hNmTJRJTMpMWUVBHPejRL0OVDqE6A6/0zbQFAW7IT055Kq2HlztjUrhAlQUZFmZ2Br7lTMe3Bx4INu/gPL1vk5t2HKlFBtZi7C4Wpuh2lPKEfDrQTigs0eWFcuba228Oc4LVVvX3ljVvrSQQadvjBoh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLpbs09pRzhIJec1UWnAydZjyn5Qo0Nc8n2cBDAYUnk=;
 b=c4JljbJyuP6b90E3YO1saXmfPdQyKmdLG2geLurYDPefuX2q/QluQvsA0EPqO96MAcjcWynha2dVksK9awR/N3qbUCdYStrXQizmJCe4yor+Qv6rp+qprTcrxREfb7XisG7l2/cSIizie7xn7NqNxYOahzkJBBkQXIHFpxVpnRYoZG7Udh/C6r9FTRocwlN1TA6ZTE5Kxc1qjlV4kNHgpkforaw1oRnMvbWkVmtVOktk0vuxNEyGC6Q3z8iAT5lC7+W7z144gM41w4ETOCfeUjfjNb+ND2poWKLOcSYZXJX7LbEEuID0cJ84YnzXHBixaQTQHnWwfhCCokGEc1AfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLpbs09pRzhIJec1UWnAydZjyn5Qo0Nc8n2cBDAYUnk=;
 b=Nfsk+/LQD1vkVHpqXScvqVedU8Wcm74q+uT4ls4ENp74TVIyg/kok9JXQ13MUrjhkE2hCq5tMyCwXA+w7CKaoG23/IYbbN4VSOSe8H1h+R6U2xqh4tHO7iPHNKs7NpCqdnP8nJrsKBmr3rqxQ19y0oe2foQnkX/ry4v06p7mt3hE0YKqzgCymo/vkprfh8h/EHGrS8zZ4GgGci7hzAm/c10SMs8urMEw9RNd6dHokqTY1nGHHY2Zp1nFqtYofc1EPHtsaFfKJctnQ052JbSPmck5xe3WovxZ93R/VEx9Zu0smajo8MW6Bleyc50JNYTpEzDRkWodYJObsqVAVpfNYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7357.eurprd04.prod.outlook.com (2603:10a6:800:1ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 23:12:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 23:12:15 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] iio: adc: vf610_adc: use devm_* and dev_err_probe() to simple code
Date: Mon,  4 Nov 2024 18:11:59 -0500
Message-Id: <20241104231200.2745342-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 50cd41c7-28c1-4e84-fc4b-08dcfd261ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KtLUIFPDiulpBfOiqq6uGoZalr3ClIiMdlB+nyXG9JQ1X7QO98L/MHMVtT5G?=
 =?us-ascii?Q?glVj4z8T6KKKvKgO09+RYD8oA9soEnQSTgMOZJsr9geKlvN8B4bjslbtti20?=
 =?us-ascii?Q?cYb1B0Umz1fIWGt/xYgVlg55r1pfzoetzXl23NggEzfKvx5c5kOyCjVs/HuI?=
 =?us-ascii?Q?zEeR3ZdNeHoiVdnGmNjMSGom9EQhaeUycMo1fJUTP9H4qfpuhuNbrgXQJS2+?=
 =?us-ascii?Q?wUr+6X995Kl9dDTKp+QbEdsW7qY1s/nktp62LxLV6PzZuAt5FLvQCoO4Gm0r?=
 =?us-ascii?Q?2GXTFbaHvsvjTr4V0sG7X/Qd5G3g1ULo4MBSqPSbjML57S9KSwdRQJxOm3qG?=
 =?us-ascii?Q?GCFuYHwyhNsW1FLZ/EI/4WNHdBeKpuaEK2T5BfSKaAQSKHUMu2qlriDlnhQp?=
 =?us-ascii?Q?sO5WVZoLz7hGWaumO59Ap7UnmHXHPjwdpQC0RTVwuyJcF+oJ1BSWvo66J6Wd?=
 =?us-ascii?Q?NdZ65igm4FzNGvGNK7FL3wwF3wYHQEo9EUQdjW+FzyweARMsp53XwU6GGA8t?=
 =?us-ascii?Q?UXSlUGajDDW1Z6NxC1oZobwWud4C0ACyq5mXK6YxvY6HlFYV/2IY54xauye5?=
 =?us-ascii?Q?m/4VKfvcVpudLdcrA9wCzWdq9Gw8EkGxjNT2ewvzqnfpV4z00fiTaCjkuvNZ?=
 =?us-ascii?Q?sU/9SyHgnkUSdCwuPyvapI/OlvIFjiNr3/vC6pBWx6S3a6KVGH1tlR6dSa/q?=
 =?us-ascii?Q?qbF0YR26usjfHf1nKVvpIPnRteT69FpwtlxjDnnYQu0PCPSFGe5CBOegR5+O?=
 =?us-ascii?Q?Pg7z/8T1AKSLUte4FYfaXmTuMCh3Cm4TP4+6Cwf4B3Al2DxRKNpeCTPLYzMw?=
 =?us-ascii?Q?RyDMHD85GDHyPOkv6I+Cfh7We2xEBpRBgwYeDSPs1KSBk37eNJjoz6DarSeA?=
 =?us-ascii?Q?j5xNZdlWFySWUmrrXH63x6tIYNZnwAEoXC++rsoUA+uSIbqUoX7Vbnx83Bs7?=
 =?us-ascii?Q?NCnGkzM2cH/FsDAMHJvV0Rki7AdbdICOdjlMSBr5m64636ZORbuz5e04h2nv?=
 =?us-ascii?Q?+xKkum/Wk8ilJcNUSYhl0XOkXnq5VEc1MOTZ6lL2PsWzeHUUNtV5pTtkcLFt?=
 =?us-ascii?Q?qK6+E3J/rxqT4L5U40ou2r7CDnxL66QU0zhC6xgGgfu2cchHuPNj8VStcDIY?=
 =?us-ascii?Q?27i7rIOiv/CCmj8HfCXj4V8JpAiNU+A2u1DMhLb77TGmvPlmZ3OImqAQoVTq?=
 =?us-ascii?Q?Q/k/DKmjrM8blSdIMxEw+qDsd5pJMZmi/TAhbbKYljzDONRYd6md4qyXiUnX?=
 =?us-ascii?Q?+gOw+CvX17HJzcwI9Aqwy8bxYYz9nHKBmIHIrH5c5jbD/xijagCms3+Q8qAI?=
 =?us-ascii?Q?MzzdFAl5rwNHjLWp0L3Lqodw0FWBBEWgBI0HqJDjHXnbtD/HkW9mMBaU3RCn?=
 =?us-ascii?Q?cB6uio0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GaZBgPxSAjkpjsnq+MiZHZ1DZzyT/IEZlwyeIjF33ooBblBJs/GwT3XLjHQV?=
 =?us-ascii?Q?wFU5qO2ztBUo4uqkgHTE8mVnGEqTbkbA3koooe+S1S8yJgE7DUwnnc+Xbz1n?=
 =?us-ascii?Q?bTGz7USAu23Kl6wQlyIrLI7yg5K3jN+BrUnw8x90o0zt8Mc83GECtv3yZNds?=
 =?us-ascii?Q?rNiDt+WFLioPKmi2up9pMhgUM7xoaZyLUX1D93joX6i+Ymrf4D/FNyyK+6Du?=
 =?us-ascii?Q?IvoRRhXAGUjrhS+aZV7+UHofYsKadaq92nLnfshM8Q1056n5MCUUzfhZ1/Fb?=
 =?us-ascii?Q?H6teWRuo25TZLttfC9TPvgo4WNEE2jKXa3q30tQ8YXmLpW1tzaPVldYXBjqZ?=
 =?us-ascii?Q?TFcFKuo8L12nTkvkHQJomkzMyWXZ1vjHjS3lnicfkSx27+N5tTxLvCL6vASM?=
 =?us-ascii?Q?hantOTPLDxdhvh9YzhNIz6BElb5FCfl8eZ5t+hqd2b0rbCm54fzArVWJs1OC?=
 =?us-ascii?Q?3hQzuslgd2SZeprgTxuaabfqRSClRIEZQMGdDBbTSMxComUFjhRdIeqsjA7V?=
 =?us-ascii?Q?3oNQZynDloHHshUooSmvUv5t39C0udU34CY49u8CrI1OqmyVGbcc3UM2WS/H?=
 =?us-ascii?Q?tTBIg1R1L5Z2CqJVQ2H6M4WAHIB2/R1J33gORnG/Wr6w6FWeftdqnYDvBxmg?=
 =?us-ascii?Q?csrFEnMzrxQqoRzqKWTHXnEFMLNP7ubuW0taRW8yhMgOvcHIlOF0uR0HNid4?=
 =?us-ascii?Q?Rb+9dGOU1YMTTI+ecdCi31Ts17b95GsU2y0Ob1m885CNKY8u1tV/tRKAFg/s?=
 =?us-ascii?Q?AWo6bfCRkNcVwuXoukbXLLPcdkOGyzXVjFqMTFTZC7zSB+ojzedH0eulirtc?=
 =?us-ascii?Q?/KQxwIE1ZYBeRv/xvj/LZhBXGW3EwYaatFHIMyDE5rBZV/sbgDQXN+1tiTRT?=
 =?us-ascii?Q?yeZAYjfUjATvG74cR1qZjrgLIh9YixXwLQFp5az1LUnYiTM2NOzPHPhVtMyt?=
 =?us-ascii?Q?QF5pKIos6S/bbI2bg7fVqrAqp0waikPIzljVdl03giQTTQatwv6N2B98xGsA?=
 =?us-ascii?Q?x/30eeYHGepWYRDImmtflNQvBrdvSzibpO4VkvdE4vqE4dxGjk/x2h4dpFSL?=
 =?us-ascii?Q?U3Z55ULMqgb/K0Bfcf5Ze/xaI9sw+bzerRL5bDY3OyeIoFW0H4BbVl8MFw6F?=
 =?us-ascii?Q?mgC80YfdCc5lyr/wwPAT9abZhhKKSVm1x82II5VJNjnlZwvDCIDSRE+XRi6Z?=
 =?us-ascii?Q?mTefYfhKUxoi0BPFniOQSXNvNQnlSPxBDmpykaYfwr6G5APbOye4pY2CC3mQ?=
 =?us-ascii?Q?I0Xslh3gKSOkEiHPKayen7s/goFYlrRC1woWyEizUR7ZqR6PP40yEiqM3uY9?=
 =?us-ascii?Q?/vehPqCizknHQAvMNBdnqGU/r0nmWtPM7k9SeJ/QdDWhrlPBLRSXIbRJKIZL?=
 =?us-ascii?Q?yb0e2ZpSrqoz8+2TSD0Pj6C1+wmlcPivmm+v9P7YOg1yfCkand5Rwn9TTEgw?=
 =?us-ascii?Q?7pZUtW7I4Anw1w8Ck+/JNAd2XjB4Hlwyj1TgfonapRnxrs6OgivoHRmPpz6i?=
 =?us-ascii?Q?Jo1Fa3DTUNGja5dAuXLuz8XzQxn+/PCXG+UoW6U0RkvjDztXUDNaHNc1GsYS?=
 =?us-ascii?Q?/jz33pruRu39WN5vuJ0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cd41c7-28c1-4e84-fc4b-08dcfd261ef5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 23:12:15.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJ5qFzzdxb5YZELLlfYKzPIEWgi+VgLBZSFRH0ACpTV0Kudu99NhXQDXl4rDG7L8bqlmLKvOEzZM5Q0lJjjYXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7357

Use devm_* and dev_err_probe() simplify probe function and remove
vf610_adc_remove().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/iio/adc/vf610_adc.c | 77 +++++++++----------------------------
 1 file changed, 19 insertions(+), 58 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 4d83c12975c53..4e737b193c012 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -823,10 +823,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct vf610_adc));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "Failed allocating iio device\n");
-		return -ENOMEM;
-	}
+	if (!indio_dev)
+		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed allocating iio device\n");
 
 	info = iio_priv(indio_dev);
 	info->dev = &pdev->dev;
@@ -842,27 +840,22 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	ret = devm_request_irq(info->dev, irq,
 				vf610_adc_isr, 0,
 				dev_name(&pdev->dev), indio_dev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
-		return ret;
-	}
+	if (ret < 0)
+		dev_err_probe(&pdev->dev, ret, "failed requesting irq, irq = %d\n", irq);
 
-	info->clk = devm_clk_get(&pdev->dev, "adc");
-	if (IS_ERR(info->clk)) {
-		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
-						PTR_ERR(info->clk));
-		return PTR_ERR(info->clk);
-	}
+	info->clk = devm_clk_get_enabled(&pdev->dev, "adc");
+	if (IS_ERR(info->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
+				     "failed getting clock, err = %ld\n",
+				     PTR_ERR(info->clk));
 
 	info->vref = devm_regulator_get(&pdev->dev, "vref");
 	if (IS_ERR(info->vref))
 		return PTR_ERR(info->vref);
 
-	ret = regulator_enable(info->vref);
-	if (ret)
-		return ret;
-
-	info->vref_uv = regulator_get_voltage(info->vref);
+	info->vref_uv = devm_regulator_get_enable_read_voltage(&pdev->dev, "vref");
+	if (info->vref_uv < 0)
+		return info->vref_uv;
 
 	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
 
@@ -879,52 +872,21 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = vf610_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
 
-	ret = clk_prepare_enable(info->clk);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Could not prepare or enable the clock.\n");
-		goto error_adc_clk_enable;
-	}
-
 	vf610_adc_cfg_init(info);
 	vf610_adc_hw_init(info);
 
-	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-					NULL, &iio_triggered_buffer_setup_ops);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Couldn't initialise the buffer\n");
-		goto error_iio_device_register;
-	}
+	ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev, &iio_pollfunc_store_time,
+					      NULL, &iio_triggered_buffer_setup_ops);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Couldn't initialise the buffer\n");
 
 	mutex_init(&info->lock);
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Couldn't register the device.\n");
-		goto error_adc_buffer_init;
-	}
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Couldn't register the device.\n");
 
 	return 0;
-
-error_adc_buffer_init:
-	iio_triggered_buffer_cleanup(indio_dev);
-error_iio_device_register:
-	clk_disable_unprepare(info->clk);
-error_adc_clk_enable:
-	regulator_disable(info->vref);
-
-	return ret;
-}
-
-static void vf610_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct vf610_adc *info = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	regulator_disable(info->vref);
-	clk_disable_unprepare(info->clk);
 }
 
 static int vf610_adc_suspend(struct device *dev)
@@ -972,7 +934,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend,
 
 static struct platform_driver vf610_adc_driver = {
 	.probe          = vf610_adc_probe,
-	.remove         = vf610_adc_remove,
 	.driver         = {
 		.name   = DRIVER_NAME,
 		.of_match_table = vf610_adc_match,
-- 
2.34.1



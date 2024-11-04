Return-Path: <linux-iio+bounces-11905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7D39BC14D
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 00:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9331F22AD2
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 23:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C141FDFB9;
	Mon,  4 Nov 2024 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eIgNwleS"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE05A1FCC7C;
	Mon,  4 Nov 2024 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730761943; cv=fail; b=CuctUP3zucs8HxfSyPkc+ie8GcULDVwFAyuAzD79+znv+pN4KpaIKPBRISSUrv21LeHAQKAYIbmzJlPS54UJp+BllizmNp9mjEZTTfwQtY58DW53VX724+7ynX4ZKU+HSNfxFQRq9Hw81Xa6nSpFw1eF8InRpBEElDht7WH3M50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730761943; c=relaxed/simple;
	bh=9A66vK6rBbTba+6yRSom+iwbF28M21m/zwp92UEkE/s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=damuKDZzOGtAQ5otoBTn7dLGwRegBvHsm1fUKNkvzo4ESp+4MZUU0lxCR3BLFJTCvq7psEcUlmXoAfx47M00U1fEpKYuBCwno1UZr38J3TjwYiOAMVBvsavkGALTzVua2p/DQMdXWF8cn9Hfibpnt1VTrxaU0Nc1ziMP9FrRe8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eIgNwleS; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiJtHeE3mq/HQPqCXU1RdTSA+5hSEAy2Fv6Vb5162kkHF1bITm+WGH4uuQwm4hnbf9/2SzwN4mZn3st0CFzym7iKALIK6fJltr6OfJMH2/C8F/yOR7pzz/7bnjiOJUPa61Xc9yPKX1Uq0AJmRN8umsJV31Jr4K7Vgb+e5QMpgH+23lsoGZQu/IOi+PWDyktCpOD5yUPDNZoM3oJs1KYnrgDVtXlsHARUnJhVzlY999i5Il93oVCfv+wXYG0Q4KCtOa4gbulDX+YfxCja8GonznJTwi3Te8kRTt3wS3cfYWdPxWrCNEc1G4PdzAsXTitaXdPF749E0AVeldLNUXfE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGES0RxWgd/uohnuz37fTKCIsQNEhCIfA2Q62dQ3BrA=;
 b=zWAax7dNdCETaezxVApTomlBm5Dd9Su4e8JuMIsK2v0CtfugUvcAdJXrSEx37RcFNobI/TUNjlpWGM+Q3yH5746kp4dOuAhyu7VjqCpiWdxfrQOohkFtSubHMUY/A5+p8hjqx6euZREqc7lQYwrdNBGxLODHXJBCl/6/vzgSz6oqLGKsqWKDO2cDhSOsUkwjn6xwBwvxkcddHLTF4xj9S9HWAjArxo7V/oJdE/n0kS6LZ9/X1YJYiKEdB1kxrsZ99RR9hYa8F1qC4eP7qOS2gphVzuCpBLOAZLO/OoSLl2Rhu6lNBoaS/aqdZGg+8STlH+M5nsUDvk86sXum5fHsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGES0RxWgd/uohnuz37fTKCIsQNEhCIfA2Q62dQ3BrA=;
 b=eIgNwleSh09JtxUaXJMa6ssrbi/P2JMPXg+ZUU6MApJhiA6agrahC2GKVb5nrNUqeiUWFp044OREZIPXeyQ89PiWBu1l8IFaf66KkbnliN2IVX52YKhcA0GqTVqWCRPGVYoml6ETVxsUIQnmfHhY3mBs8EQBmfF7YySleebSWxs5eEEiRrdBa7Vnc7Pbr0VbR0psgyeOqRkShsBwRSPPZgFextHGQai6hyuO4PKSIQhFTNOJd5/7d4g29/oNBHcx5p+Zfrebwp9OKCJE9Hv0oUQ5dxOJBx8eh8n8XMHqzjTaLyL/A9Z6o4U6oNLPFwslaF6U2Rf7Z2TIeFPsc1qqeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7357.eurprd04.prod.outlook.com (2603:10a6:800:1ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 23:12:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 23:12:17 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel number to 4
Date: Mon,  4 Nov 2024 18:12:00 -0500
Message-Id: <20241104231200.2745342-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104231200.2745342-1-Frank.Li@nxp.com>
References: <20241104231200.2745342-1-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: dda33822-0030-44f2-45ca-08dcfd262056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sFsEF1VHOCAGF1uKM8N8ZRGoUFGQ4KPkzVAZH5Trj3l6i2Z6PBwRygmKINdb?=
 =?us-ascii?Q?oWMEkqAQjNwcQLWvp1AAIx3SsAisSO5LfWIHarRA64cx5he350zzLdXNm5MT?=
 =?us-ascii?Q?OCjan4m7NpZi99taCn8UL5f+D69PjkjE2uyJObPG/qZhhLXFbjVm6lmNrlrB?=
 =?us-ascii?Q?+Amd0Mu1Wtj07spUMLvJa0ab9x+Fr799HKV0PAXGutTElsv62sytTwLrKKSY?=
 =?us-ascii?Q?HGgIglrXRU6VIt8aSapN01OeVvVEWpWaXnbobsSDeMgZRjA/jnsgtWEeJEef?=
 =?us-ascii?Q?kRB89lbfEiDiDOxx1MKteV+z3lFPPqKDhhxxLB/6VKz9zUwOp/A/nbygOxR3?=
 =?us-ascii?Q?xqBDYiksypR8FwUbvtbHtAicWi1diyH/5B5vgfV3a0nQ6og4TdW+GAj43oxt?=
 =?us-ascii?Q?QfJ0v6PfJtsfOrawHG1tQwi4xJ7MjdIEDRaq1TaC1oP0QVFuyAxW11s46VTL?=
 =?us-ascii?Q?h0X5AL2pCmE2bx3akQc0/+qfli8g5a50mR82JsTlDI+RVT76Vn98T9WfAT0f?=
 =?us-ascii?Q?43UHdtUj5aOUkUEqxi2lh5WJivjjSF3PVl2bS4PKe68uN1mQ0YkZfr7oRaHV?=
 =?us-ascii?Q?L8HkTlV+Sq3fP0Eb5ne6ny4SVntxFu2No5lDlRS+nzfsFMJjLWYxrtKN8oSp?=
 =?us-ascii?Q?k9glUmq/i8SZLvjlKlD547621sqoqil3ngM1p1GAt5Lfoy1gY7Z8icWbF0jb?=
 =?us-ascii?Q?LbnAtxRcqdC5cb5ylTEpMyEi4Fq/OgK1fhANBCp1MfqqDwBaCPcMga0MZSwB?=
 =?us-ascii?Q?Skiw5+gEtAjmHZGOLXBXJcPHAMf188/8O3c/+lenPQnF8YBxtABG5LBFYYI0?=
 =?us-ascii?Q?1vT79YAkh71E9DFj4R954c6GSiQjxLE8ZipzGA0eTOkINVp8jliDQxS4azz8?=
 =?us-ascii?Q?gs6pthjMfuaFlXcoUOgksXxnBwBOT1sqFBM6McxVrlecdc5fn2x0527GshgV?=
 =?us-ascii?Q?0HawNE37yYVnlxBCgGiVZMORMZGVq4DDCsAN/yvoReNl7jhhbRLn0kDqd1ct?=
 =?us-ascii?Q?qj1jgl+J2lSC6QsMBL80lVQ2PNNSG3YgFGCxbP+ljO5aDrXedxp8LZIeguS6?=
 =?us-ascii?Q?H/RRQmm9tVncn7U5INPzenimsj3iNNQbRRp4Zd2vVNgoORcF6BcixUP+JjzE?=
 =?us-ascii?Q?mtERsv0dpCc8dVgPwAybCkFwhmVY2hxXgY8Lrz50dhIq2Uf/yMckcAX7uZ8P?=
 =?us-ascii?Q?Ly1BvdrVSjUeYR/ltAJGZFDdwBxT8yVSoytC83yV7Ps3jJqRNP08YDptmXev?=
 =?us-ascii?Q?1mZXnpUNaSBmAzHZgFNeApShcOpyzIT73F/74Fk4uczCkfS6ujofZUOm0S0z?=
 =?us-ascii?Q?9oJcz599TjRZq9GNG8tOAz35XemrPsg0vWfsfPaiT+k4MZDHLB1xWMdGAGvR?=
 =?us-ascii?Q?czthrxU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vlQJQ4we2l98HGI1a0luCxsjEMb9Rr90H4g2SgruoIq2BfYHadYSa5HWBHEZ?=
 =?us-ascii?Q?QUyZDEMchMSIdCShvhfQ9LIUiwC0OZXcyOkCPO5JSHohdSG9xYUlXHTev6FQ?=
 =?us-ascii?Q?SjJlZo3tqvDV3Oy/HDGKcVIA/3Fi96VNyrAlDGIQ0zpJUEDHNW4FyKvzgUoa?=
 =?us-ascii?Q?tYxX5DvJbrkfYPCKn11JWqdVGe4cxtGdF+lHS4+oDNv+iWJ7+MlZLrCeU7p3?=
 =?us-ascii?Q?VgBozs2s7WO8WXmsJhIKqq4Xip5ZMYkrSXF8PWkHIC6qPR6CHJA5rVauJ9wJ?=
 =?us-ascii?Q?mcCvaeY2y3xqYRI7r+SMP1+u7Ze/iyMdf0pxzpVR7R190/pM99/RaDGa2LXZ?=
 =?us-ascii?Q?KYW3HSc+mReMyS1qYpIhgyWbxsgi0YfnAqoggakmw0uQSVypNBSGGEmJ03cA?=
 =?us-ascii?Q?LRX260/ubUeaK2H9AS1CJx3ljDJPIJMxSTnxbsMZv+1wjulODrvEC2LMyRkR?=
 =?us-ascii?Q?09ghxhm7GPbf6pHYZHeda3fj9mIOOk2nzlpJA/m1xPMKHHOL2P7SgnA98pu2?=
 =?us-ascii?Q?QTV8ibm1XKJh1XQz01W9Ez2x0KSuNLJtM1lzYrKNF2pqLTIDhQhR46OxalhB?=
 =?us-ascii?Q?W2vMBpWtUfLb9gpG2ll3HxTs3xKh11mmSrAok1j8L6fYY4oSHLJd8G67oSXD?=
 =?us-ascii?Q?kb03xq25c0CjdWaYsT/wrtgpkZefA6/Gk2G/8n8govG7BL088h14kpTRcWMK?=
 =?us-ascii?Q?37XF+AUsWljiuUlDSz+W+SbEzV6MZOlN5CIGiYTfEmCahFpN2GNALX/WjgT+?=
 =?us-ascii?Q?6qSeLvMalmOpeALnZqAU7neTdx2zkSpYnFLTfvar+YOJ31BJylHr78upWo+z?=
 =?us-ascii?Q?3kyb6m5SDH2jePkOkJqymhTX1zoMlwuL3adtR5jxeq0d2EmCWmh5Lrmy0t6U?=
 =?us-ascii?Q?6jKEDNWU3zjgDUk7F0zpmoqGutnXG2hwv73KP+igejDC6wc6R52hVp0qjE1C?=
 =?us-ascii?Q?vQL7u1+eK45DoA+MQQHWkYdDfNXuitl5IFJwFNvlCS8rpVhxk2QXgU60N8L4?=
 =?us-ascii?Q?VxBSNiuleiWj4VoT/j4qI9dkr8qOeaX5rdlCz73AfR1UHsBYbY+7tSkOqY3v?=
 =?us-ascii?Q?S+YcN4pFaymnL+fcSrUd2BN5mNx9/q3cDZ05++vzNwPHr/KPk9wxCzoAlHQq?=
 =?us-ascii?Q?1c3e8jGWKs5yaxOIeD2xSGu6mx7YfEVwBdEf5yafzdPQUkecgE0Tmx+Eo+Wv?=
 =?us-ascii?Q?Yah55QuRWusKs3C7qSUhI8H8h1dguyv7SWzYJ2GsecaYQLzq1fyZLSCQv/DB?=
 =?us-ascii?Q?nyJTZzltP3hSmrBqQYQozOr7BoxEKC2zDROJAXf4/SIznHP4jIJEl0272Mll?=
 =?us-ascii?Q?u9s3uMS9UfggdXFBvm4Gx3ZBwhXxq3qUqG0loAVDkQACGKgXMEJFEeEa0VBb?=
 =?us-ascii?Q?XWldXqzdrVtmMnqzgt5dZdrsH2dKLJWCVU7/V6jByK9ll7a7wufa3nQaRmVg?=
 =?us-ascii?Q?mjD5oHez3vwMVpalyLLx3pLP9fKCsC9NWB4+5xvmAYPVmqbIDULP0haqggx0?=
 =?us-ascii?Q?54BHam7h+adUn6JSioTEhsdjojfRpkwzxskngGOLOGzXZes2WK4+9fafYJjb?=
 =?us-ascii?Q?HWkJ1PlAvDQ6p9njUEk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda33822-0030-44f2-45ca-08dcfd262056
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 23:12:17.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWowfeWOM41nWI+zaOhdRY3Zs8yzUU7ntpd67/aj5y8VlzKkN9xbWa/S4ehzzh03Sz1kCN2+zlq4QxRaURBPvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7357

i.MX6SX only has 4 ADC channels, so limit channel numbers to 4 for
compatible string 'fsl,imx6sx-adc'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
compatible string 'fsl,imx6sx-adc' already document in
Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
---
 drivers/iio/adc/vf610_adc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 4e737b193c012..84573cdfce5da 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -809,7 +809,8 @@ static const struct iio_info vf610_adc_iio_info = {
 };
 
 static const struct of_device_id vf610_adc_match[] = {
-	{ .compatible = "fsl,vf610-adc", },
+	{ .compatible = "fsl,imx6sx-adc", .data = (void *)4},
+	{ .compatible = "fsl,vf610-adc", .data = (void *)ARRAY_SIZE(vf610_adc_iio_channels)},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, vf610_adc_match);
@@ -870,7 +871,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	indio_dev->info = &vf610_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = vf610_adc_iio_channels;
-	indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
+	indio_dev->num_channels = (u32)device_get_match_data(dev);
 
 	vf610_adc_cfg_init(info);
 	vf610_adc_hw_init(info);
-- 
2.34.1



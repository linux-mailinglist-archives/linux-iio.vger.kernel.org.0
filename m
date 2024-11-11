Return-Path: <linux-iio+bounces-12164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7EA9C483C
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 22:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6BA286712
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 21:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63491BCA11;
	Mon, 11 Nov 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PXndSPps"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED251BC099;
	Mon, 11 Nov 2024 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361162; cv=fail; b=ruWKumQUddEs+9b6gkJaUgbHs8EPhxCiU13Abjg3oSi4h+yojLBSpJQNAC/crC/YJLzGe0P91AgEpAjGB23IbuoZZ/fHJZREH4k4hYsA/N+vd4bERQfaDh8sChBew1CUQt3B+/+Iwf7EGMgZHUT5HkJD7MmLx7CQxpJxU6lxZXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361162; c=relaxed/simple;
	bh=T9BobDkcKhfQsaxEbiINbA9mXiTHqunRHNHo+OgtMUg=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ueNxGdveziQF91k6FCJOOhdDVa/moQeULRVtCJ794AcnywOPspkGUI9XmOBBHiVyu/gE+mYqCx0ELOfSDKO3mHBka3kNUWt/S0IRZFaaWHDwL4LzXnRKpet93B16eIq0Tgx5ekzyKFEKmvsL1DeYpxLga5cmGBnR6aU925X2Se0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PXndSPps; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMxl9PKtQ8IE1SYiLOlH8dWgKrTM9Lsi4SsH/mdWfagstrLZgTq7VM+7AqGpy25widhVh4mU6+84MksS6VepCs+ZrPTgOB18+o9Fu0noptoeFn3sUJSpH5P0r0PM9slMLfA+uZROW9YEB/V3LuRyHUvKw1Qhx+LHfEHveNPifY6+MmUrRbmJL52rG79AED0cMj+F5mTOuMPN9ZASFSZB1W2cVDBqGLlC5m0sjyC2dEkHJCASVplmLUpIibdTVj27JP1O0r7DnJ/bGKfOZobLdFEjf90aFuIQ28NK8KOppvf9tO0UHIJ/mV+eecCl2CJqwpmXZo5txeH9FZ8Kjghaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDrMxCdYtmGKVnjdltj2kO8OLilSABgOuAwa94mhmr8=;
 b=qZoa18jF85cIy/8dEOFYS9/58m2Di+CbwOd8fLn/sM/m5qyelJPrEtNx6x2Tv75gsJhVl++jbwyE6CCAX0jCga8TPox2DZ6nF8tgAy8Wc73Zu0BloM08FHLU7/lHlA1+MmBllmSYhRWRem/tISJ1isnT8NEaODtgZAJg05E02HYuxDy7z2Y3tN904nA+LYtRCb/7F3VhAUroAgdPbbEAHOXZ9CCp/pn8n/6brD7/0IuDEdfs+++pGM8MzmaCuHvtPe2gRuYNMYADiLrKbuEfBolsrtqMMVt/ZLMtMmDMJAQgwo+lKOOGBPC9M+NMQlMEuvNlak6BIDL3WpBuVd/i0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDrMxCdYtmGKVnjdltj2kO8OLilSABgOuAwa94mhmr8=;
 b=PXndSPpskwiOsmfSMgfFMsMOZy5ylYlDltneOaY/dD9j2zKSRvnXamD9/vIoYdazsbzwBm1E1Ouph+PyQFWU4jbKxElizr56b3HwO5lrK6UgB42nok3hVJKuDSuqfSvs2ck2XYrMuTdA0UsTqK9vueJ08DFcp18VbijYmOekt1sv7S8MDnTp4C1o6Lq6StLVGgmtsnIqWSahOscLr1viSqnKzCl7qFf/P8SOepkhw793uPZ2M6rltz8W97uRS5EX2SuhQEiaQ9iqiujKlYm3znQw4scIX4S+QYQZAJPCZUjMYd3VcH5GPDotzN8VKsnYhRznyAmdsyjbPCjebjMfig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9738.eurprd04.prod.outlook.com (2603:10a6:800:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Mon, 11 Nov
 2024 21:39:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 21:39:14 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/2] iio: adc: vf610_adc: use devm_* and dev_err_probe() to simple code
Date: Mon, 11 Nov 2024 16:38:58 -0500
Message-Id: <20241111213859.3317909-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0108.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::49) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa37b70-b0b7-420e-6ce0-08dd02994978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qUaJgWM2VZ73ueqY6yRNRHeDeHk89uZXUwM5IMTabEymYgXYrtG8IU6MmCk3?=
 =?us-ascii?Q?Nw+Uv36MRIQTllM9PMvmqOlH57SkYIXYnTi6P1Srizma0RequdMEaGHxCdhe?=
 =?us-ascii?Q?2DONDanNk5pWKv1O1XTzZDWIulJFTxb+OHiQzkcR45zQQar9Hzzb4XVv+gtW?=
 =?us-ascii?Q?huUBdb3JJjvdlecYYB84GBQawDof7Gd6BX0U1pJDKKEZvC4wf3GxVcj5s41l?=
 =?us-ascii?Q?rENnZ6Z7jA9GkzavvMl6vMukmGY1qvOn2vZ02BPUePUIyl4Y2qMvkvS8wDD4?=
 =?us-ascii?Q?7gAo3QLQhYokxW3FoVkbs66HndTA7erlhq019P9waAkGBH1Si9jOMzi9AUjE?=
 =?us-ascii?Q?/nvGCgqs7f+hIKRdiTlHOiWhoSaXherIbmtyQN8g63sSII/RI4Q4lRWrEJGQ?=
 =?us-ascii?Q?TmEOhlohYS5AY9pYqw/QNn5hnpSGuzk30HEewVroHZkN86wYEQzGBtJSElex?=
 =?us-ascii?Q?dkqGzpXUrTRurJTUepW1iVyG+FaEbicbvLa34C70weSP+F2PcO59VtPJ9KR4?=
 =?us-ascii?Q?+r1mGX5iKzIUSmAoOUGJ908wMMtLpDPOwpyZagHRN8skr4tXIumW9FQNJOmU?=
 =?us-ascii?Q?zZgHR5pmxtzSTO6PWJSBuUGSLOL9/NTiu7MGmtudF2VPnUeiQPop0kR1K8Wx?=
 =?us-ascii?Q?/Htc7wtdrF+Z6xG7KGX7wubw/WZfdPS0yM6XBEz7xY/CnVzRcVF0gBEnOWkJ?=
 =?us-ascii?Q?mlQKzi0vwrpKe3mmWzozucTMG73YuZlXlVxCbrWRL+nLQLon27F4C0SyV9Nb?=
 =?us-ascii?Q?+sT8wfiEVvodgbuGzm0GC9UILPaW4b/niz4str2+ctZW0zl3Wadz/BDyV7sv?=
 =?us-ascii?Q?FelhtV9BVsz2zDt0yGOpBm6nEOsSzyB8pE663e9lsJpx14QKdBaD95XS7NBT?=
 =?us-ascii?Q?BAoH3dNcl9MhwkytWTPkxiL7HdWz19aJQPRWl+biPUVdCWlxBxFSygh+OtQs?=
 =?us-ascii?Q?Uyc1Bu7tkf1K7ah1TkXQPUuzdWDjCMeI3Uw69ytqi4z4jXbDzXg9n5tk1TAK?=
 =?us-ascii?Q?TM2SnLS+rnmW3vdB7qWR2D+kzmmxxNiX8Smd6TOPPrQDh8A93s6dn8zcXTdQ?=
 =?us-ascii?Q?wDKWmkUL9Jgs/VBFaXhFfdQ31CZ/FfH41UZkPc4nmXrSVI04/wnqFScwczsI?=
 =?us-ascii?Q?KlSrXdZWONzbqJ/KPCBviyEhwOAtnM1tOazp6zP8+kqNf2Nmmx54SEL2vJ0G?=
 =?us-ascii?Q?c7ixuWVp5/8auQ4KCWOumlx+Dh/bE0eLGMG6RQFpMg05i8+hFK9Q5HrQXFny?=
 =?us-ascii?Q?ERFAqVvzjA1kUvmDcn5xiTB0F07zK9BztQDR1tXaYwuQy3B+l9hP+8vY1aNX?=
 =?us-ascii?Q?xc87vte925wmkK9be3/gsoEs5wadbM+l8xzVP7rnA5WRZLvdIpOOfQ5JLA7j?=
 =?us-ascii?Q?rQBxrDH/kcceFNBC2O0gbNahqL4e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DC8lW8DxEV/mrK1XXJIGFOzBaoG7cw4/ow8ZlP1O0loJpwLucj7NR2r2wWBm?=
 =?us-ascii?Q?zhPKuotSdrE+erVFrpshEBP+VtQKTDOUUN0VkHHYsZI5RzgmJvmK6DnFxnTo?=
 =?us-ascii?Q?adt8vHsZosRakk3nEtehXfUztzbyk7EHbn3qS/8iWe5nYvvTEjCKH+OX+OJj?=
 =?us-ascii?Q?1CiZ/Meo2uXfN/q+YApuDOx5pgvJgoCspTo8g2fzt06xoHHEXQe00QgIwhtp?=
 =?us-ascii?Q?IFxX6UNxgGyrjphj3N94ScEqZDbEXPPSCm45JesjcF3twFpNEZyxYaqoC8cf?=
 =?us-ascii?Q?tkbsQyp6/Lw802kJ+jT8pN2VN1YQ/yrqm3qI/m2KoQ7UxaY+vtx3dzLX6G26?=
 =?us-ascii?Q?WdLF8a+D1k1wZyk/kt28a5Tjv5uYOsDk2LqyPY/+BAzDDAkmOPZ5cR+Y4NKc?=
 =?us-ascii?Q?uioed5CaDryHxCoMH0k//hpeyui0LqMGTcIEqB+dfsZrvKJE9cR1YSTNXzxW?=
 =?us-ascii?Q?zoLGuW2khbzw1X0HTW48eP8o0Ob2EMxDzVDxkKu6xCdEv6ggbcpcmpOmat9q?=
 =?us-ascii?Q?sbmKsGuNGLWqIFZpHpkQjfPmechtHcJATI+FFxwLpQqTrFTaelaeLwqDT5QI?=
 =?us-ascii?Q?CeyIpNyWtl6YqYhVnhAaOLnbsQS9nn0Y7vHOtKgldKZ56+7h1hVNKC7A7305?=
 =?us-ascii?Q?exLux+II0eIBNKv18Z9IVnM2MnsJoB/UKglK/21wh+SW+4eB6TBJ1yczqfn1?=
 =?us-ascii?Q?JRQOJJc1+GAT7YGIt7iFgTYfVhc3Dj/ayq+hQ7pl0LaiS2fnSscg+qPAb3ag?=
 =?us-ascii?Q?TuhD08jcs2EIbwigKhqwsD9tl4Bc9cqvgiq3lfRD6tAFbo6rHyNHN8ZSTOHe?=
 =?us-ascii?Q?GyICXfT4wZfDPozIIXMc7Yh2746F5/rnFolf+v4KRzSABxgeYWbq9dwNte4D?=
 =?us-ascii?Q?oL1Voi4hlyjfQOip/xmW42sWj9oV0IWDmWE5b2AXAiN0bAqRiMGiI5RS8fiQ?=
 =?us-ascii?Q?un2aCZle6fJAI7dlQehk3YwoxDl5hCEGuyB5/qrjCIMRQJBVZIp1cGLvQWTc?=
 =?us-ascii?Q?VXpVqvQ5UqbokISwi3qHDQDlRqsA2VjC41F1z5CjlNz1OVxKax3cE/oakI5b?=
 =?us-ascii?Q?+3sP4UthIu0w/NIAsijaEdIgqUglpR9aya0xk4/7+YNjOb68rUTfktobBP7/?=
 =?us-ascii?Q?VH57gT2yCP9f4M0ngaQg5DKd7FN/5PFxQ5FyJeK29xJSi4IvxECja/5ppClm?=
 =?us-ascii?Q?TPH+eYUPumC7lf9sSVtZYb+kl2CqzYuVWsHQ0797UCK9FXwYjyGcRdafx97C?=
 =?us-ascii?Q?HbPwUoZdfVM6tzKNedti3WFVhvL6s7pkA9/n7R9rLvG1K7FEMD4VUd1obcpn?=
 =?us-ascii?Q?GsGwxHHPnhCdVDGzESZxmPqe2rppcZSSLErYI+WjVOtSurIblGyFvAvAtoFo?=
 =?us-ascii?Q?RkCt49dY33bGxKEBtMGDrEHRvme7VjDbXxpBSK4t9KwRIr4L+o1I0TotoY9/?=
 =?us-ascii?Q?lrcPH9JQkUFAL3rG3e1K8N63cTs3zNhS0qXiEOZoxAua2CPU+Cv2B5/Bz0G7?=
 =?us-ascii?Q?rJbDB2e1s7fahQgK5g3gjC0aXc8ra64YQgS4h7n4pX7Hb4lG2YDrBxIzr2mo?=
 =?us-ascii?Q?o85e5fTHz5p4Ic1oycg8D/mR0++vBKnCIFqYpMWe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa37b70-b0b7-420e-6ce0-08dd02994978
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 21:39:14.6510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gohpMkbyG8dFfoWvr8q6QyCAdP7dWGWKq2YW3xK1+hfOM+JsH6k7E9Jq8Zn/6aq3J1UmAH3I6ZZv26j8AFJdKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9738

Use devm_* and dev_err_probe() simplify probe function and remove
vf610_adc_remove().

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- keep vref_uv as u32
- keep original regulator part and only add
devm_add_action_or_reset(&pdev->dev, vf610_adc_remove, info)

Change from v2 to v3
- change vref_uv to int from u32 to fix below warning
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411070633.NIrO7Ert-lkp@intel.com/
smatch warnings:
drivers/iio/adc/vf610_adc.c:857 vf610_adc_probe() warn: unsigned 'info->vref_uv' is never less than zero.

vim +857 drivers/iio/adc/vf610_adc.c

Change from v1 to v2
- add Haibo's review tag
---
 drivers/iio/adc/vf610_adc.c | 79 ++++++++++++-------------------------
 1 file changed, 26 insertions(+), 53 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 4d83c12975c53..d4b778799755b 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -814,6 +814,14 @@ static const struct of_device_id vf610_adc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, vf610_adc_match);
 
+static void vf610_adc_action_remove(void *d)
+{
+	struct vf610_adc *info = d;
+
+	if (info->vref)
+		regulator_disable(info->vref);
+}
+
 static int vf610_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -823,10 +831,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
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
@@ -842,17 +848,12 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	ret = devm_request_irq(info->dev, irq,
 				vf610_adc_isr, 0,
 				dev_name(&pdev->dev), indio_dev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed requesting irq, irq = %d\n", irq);
 
-	info->clk = devm_clk_get(&pdev->dev, "adc");
-	if (IS_ERR(info->clk)) {
-		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
-						PTR_ERR(info->clk));
-		return PTR_ERR(info->clk);
-	}
+	info->clk = devm_clk_get_enabled(&pdev->dev, "adc");
+	if (IS_ERR(info->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk), "failed getting clock\n");
 
 	info->vref = devm_regulator_get(&pdev->dev, "vref");
 	if (IS_ERR(info->vref))
@@ -862,6 +863,10 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(&pdev->dev, vf610_adc_action_remove, info);
+	if (ret)
+		return ret;
+
 	info->vref_uv = regulator_get_voltage(info->vref);
 
 	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
@@ -879,52 +884,21 @@ static int vf610_adc_probe(struct platform_device *pdev)
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
@@ -972,7 +946,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend,
 
 static struct platform_driver vf610_adc_driver = {
 	.probe          = vf610_adc_probe,
-	.remove         = vf610_adc_remove,
 	.driver         = {
 		.name   = DRIVER_NAME,
 		.of_match_table = vf610_adc_match,
-- 
2.34.1



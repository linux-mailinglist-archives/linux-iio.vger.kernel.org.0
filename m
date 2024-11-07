Return-Path: <linux-iio+bounces-12004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AE29C0EC3
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 20:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D390A2830E3
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 19:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56152194C86;
	Thu,  7 Nov 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NX1zAH8Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB10125D6;
	Thu,  7 Nov 2024 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007147; cv=fail; b=OvtEbfsOX1D8kOlYaXceyYRhO0gGVZjtSS80xVrE8zKVfN6isH7o11n7ORCzvKxxtOSbQUtkPQp1gKwhx0E0hfcFweyVjA9ckY5p/bAhu44/2jeFyIqcjglh6KhSmaCF934VKIKEkyJee84l0eW2gbSRsuCwk1zi/DX7XmDaJo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007147; c=relaxed/simple;
	bh=WzwTTmhZpwi2/Zk49REqU4gHY3063pgo/Y/nMTNgnG8=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a/g1nHIBohK+VW4/KYTBXfSaKFIOuvsrA/OziDA5nHLQhr5wYFr3/f2igOV+EGWKh6+Bh3HRopq2B1b/34V542aDmrFm3/VL8Jj8Px+cmWu62P2snEhJyQpiQ9by538xFzddtCOZha9FFNHeDf8BwmMukTDuMP3eDrsuD8CGzls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NX1zAH8Q; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJpiDzZDTlNZy4+EBHFWlozUgpgMC6x2ULSk0VvpkjRKgV0O5h0ZnoYj2qnH5Y+uP5HMfhhNjs5XqTkBPF0OVkD749CEF4QyNZgfJKHqe+LOWoiXBV7AU8Cx8Z72Lt6d8O+cXnzed/Sc9u5rtQvmrOZcmux6chBB34h0J87XaAj4EaXcLcBPDpIm+SE8e/7LLJz2WsEJkOYJGecBB8GPAFCrE0BZ2E6G97NHVakOn/vBnd+sLvkQ48+kHBsyEoo9Uckw+6T0QjztNDoygFk59kmeiLaVnPj2TsZJS/fs/EjJIMimalUWqNI4KjYSepxmUWnHc8Yfi+vVzyeQov7zUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fSAYRH83AS81M2WlpU5dBTKmFwXkIfbJe1h1KHu6uk=;
 b=VhfHTf/uzVq5nXojiJ9NJX6BcSlH7V4/ps96/i7O3eLtpq+uw8eD2dRDYcjk2qEiqo/EOfqWkz6JRN4dlJln1i7B9SYGeWkVzAfLV5sC/19288/sfKpRiTSQCqns44BVInYk/bVbKY6Fp6vUSVXLVXeEd6Cl7c5GLwAR8MZ+re6iDNrOjddkvX1qxJsFlKJvNKL0QoJxdPUbYSrL147HLHmkbTLfdACVLUe4Xg1TlSgCK5RYAdJPkMSNXRP7KoyDJPbx14edamfKiNfZ20S994PLD3jYZTyEug+5gnOYNzO+iA4tHi/cs3eynW8FZJdpJw5IQAU6/gj4/o05aDmRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fSAYRH83AS81M2WlpU5dBTKmFwXkIfbJe1h1KHu6uk=;
 b=NX1zAH8Q8MosDg52MaNOvE0r/68ybqO6kS1HjpzKfqI3q3VzrrfGmGqMJazjPDY1qrESB5BEug7DwOMBdU5AsCOGOocl/6T1DVR08bd9pCbmSiZN2HwFjl5oCRQfBOrcEs4YNhRzl8Sfyr726X07vb7UTsxs2cMBgqBHZ35CP7eI2WKAbbOVRESy4AN/0JPDtulKKUxSHdq2/2o7HF7SxZsyZ5eHL6He7UZES4FJielmnzDzpvEGBV+MWtT/Bp8c/LBkYZ051Su37kfI7dRrYx3PC4a1NzVbQ+Eli3goIgfuu77EizdC5/pqKIJqfw0ThgDY2T5EtjrDxc5DOl9sSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:18:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 19:18:56 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] iio: adc: vf610_adc: use devm_* and dev_err_probe() to simple code
Date: Thu,  7 Nov 2024 14:18:40 -0500
Message-Id: <20241107191842.3002319-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e4d5d7-68ba-45f4-2d47-08dcff610672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gVzvyWZriEqAuQ4x42O9/+k8VTN7wrCWpgGQXp0Gw7r79bE9oZ7o9MXijE9J?=
 =?us-ascii?Q?v/h9LGsxZCC0Is5eq22ZmmhosZdiji49dDmnHECsJEeDeSNVJ7W8O3uTri9w?=
 =?us-ascii?Q?4qtxP8A36T5U9mzF6tFVbQ0kxZyrAgbAq+mbfqZOZmnmMSuQeqSPWFObbnsf?=
 =?us-ascii?Q?CZEb9opCgACbb0+vnswF/RXlbUqrXB6HWk+bUX2WsHbkgLJhB6JT0BYOEODR?=
 =?us-ascii?Q?GjAU6hO1ngUK4WnwKr9pNvj67SqtteZRD5Nw+eO6hKM1JJiNJtc8ZIxvHCKg?=
 =?us-ascii?Q?FGnh0+vxBtHTLYOGD63fzXjRV6VpzK+YF4czYZubxHK2z+zcv4qFhOI06eE/?=
 =?us-ascii?Q?ocIQ44wqBDjobPPaQ20Tw9PgfHP8JfkXoqpuzHwL7PHt319O8a4A0z2FTtb2?=
 =?us-ascii?Q?+o1tYNgNrSCeLZG9pn1Y12tlc8iiTJKIWRwlrdYbqUIs2ZFiC2kjXI6H6kIG?=
 =?us-ascii?Q?hgF4BCKZNz9TnhKnyt4uciwpxfCkGLivYLC67OJ9eKMrHGVaeAx5Zzwlddo2?=
 =?us-ascii?Q?BU2RJWi5IkmKpBCtyJRo3zXNH0p8Y8nUqFdXOMgu21rGLppITiLv++eQnJgR?=
 =?us-ascii?Q?2lGH2B1thbvi7RunZm9b4cNGkKfUC1pHDDnGtXd6eseo1aS1j+X6ApYbvwUR?=
 =?us-ascii?Q?1EwIICoRfFpGix3FA+EQqxK2RlEzov+pOZdklQiQP51n93WR+8FsZAa6lBI4?=
 =?us-ascii?Q?kK04mg5JYALAeDn3VgM5UHGMIbm05AN4q2V9GDsNJBZ1wzdiG9lJZnmfeU5o?=
 =?us-ascii?Q?owiu7LpzsMf5QLFttizlVhqeQkzD8c9nrjE8QN5VK52ajfw31Af1y75n2wdS?=
 =?us-ascii?Q?gu5SHxxlRKIQHROzfxx1Kno8jbw6PKRfc6A3EvUMrT87U8Il12eWvcPQU+V4?=
 =?us-ascii?Q?9cij2MXtvmM/dWmv7/aH6WbOrWlHN/jxFbtTiDHjiC6EvtWaxTe/N32aCo1Q?=
 =?us-ascii?Q?Me4aEJlGjydM7b/+geNMvoyOuWdO/q4FDpcwajqlELweyNKCuR3KGm6l+qoA?=
 =?us-ascii?Q?UcYk0unuOgnL6n48yJUg1EYjV+K2lii7RBU+Q2Qul66jMRolvD5SuIUC8yEN?=
 =?us-ascii?Q?jNJrZpCheIXZpyqrxFDPFV/KX3gjVHSPe0UQXa8yAxSDMQUpH1x7SQE0raAU?=
 =?us-ascii?Q?8Ir0DFVppjD2F7YboQCq3vYlP2xbq3IByJtlkGnUiNqJdEDbrg0SSkWvLPmm?=
 =?us-ascii?Q?LRjqihIsSuxdtBBbD7kINI0Qtwbr6ToavBJeX6zRngTPi/x9veOm5y2HcRrE?=
 =?us-ascii?Q?WxTd50o7/NRMBSngub2l5QIX2KJ+Ve2UdfCakufZ5LIuVeoFkuS8HZMtNBdT?=
 =?us-ascii?Q?uPQRTf3J1vHoHZMjEO+u/Isk/t02pNwX6+WGmSIs1f62xY+GtnYTxBfimHps?=
 =?us-ascii?Q?NwGsA+7Qo2/56r5F2dHZ0tNFNINN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JFZM2tuucAS+NOv/zXLq/+CGcdBuQ8oy4e6naHDbubOROqw3Vla2xz+NVLhI?=
 =?us-ascii?Q?p/Fk7tgNVRpAne8FBnJVE6OiA4Hw9Oa0g6AeRgf1mwqjQhWkbuurVXsQCjF0?=
 =?us-ascii?Q?TLbGJPqtOP17FN+7+v9jwYfXxE3xpmf6PIUnD+fSB67FBKA9hBwrM4UUYXKB?=
 =?us-ascii?Q?z2Ue1D5zW0JZluY8riUulozP/GYeCaqsTLV644Ej2VH6B6pHobw6taXwxaam?=
 =?us-ascii?Q?ZDe5yIr9bgyWvtE1q4yLv4Yx0x6LQ0+54Jmjh5NMataMRef7o9HfAo/gbi5c?=
 =?us-ascii?Q?8BBMdYK+hK3GZ3kUF3ybZziQPy7gP6RAKcfVPirsfuSLYIvEpTdQEiaPyBry?=
 =?us-ascii?Q?vOzTh8auLrXISxJQVNkvZYsusmKYmH7dWYQ/DaP6xi57Cb5wllL3urUq7A8C?=
 =?us-ascii?Q?j3g6goOHZTxrhqiv7N91V47etGRYXz3zWDtrWxZuP4bzOP76ypRlBu9MSZ5u?=
 =?us-ascii?Q?RmIeR8QHCcNdDwNgyhHUs+XN7CnBmRYvyYbcn4Ebp4yzYvoYQfjEoKHEBqwS?=
 =?us-ascii?Q?i4LslYEsY6hPDfKBdxuMMkFIcaL7OaCItFSwYKORF+CsJ5c8o3fwH1Qx0QS3?=
 =?us-ascii?Q?9ub7jSyA++pjXaUYOeLvpqoXzUNL3EpMgleyU5I3IoXSm+Wpzju8UjJZDiQZ?=
 =?us-ascii?Q?2nVPLcEfeDPLDIU0zw77FTCP1NYIo0t3HC6BJxR8LUp1ZyEkCgDMaIyj+ITf?=
 =?us-ascii?Q?PR0fR5Wl/r6Rn0rCdIMERR/wDb6/x37zw5/R5EJso9kwWpbEbOWgt+yDpPW+?=
 =?us-ascii?Q?W/rzlJUmH+H2D//d8xxoN0a6jLpHp7YuBeWx0ZRByQBj+DfGFJ7BoV/SkS1T?=
 =?us-ascii?Q?sWngCrzENkaNmTbb9A/4nf2wknDdWljYJo4FWgIgVd8RuYZsI/QaG34W4wUm?=
 =?us-ascii?Q?BAzbINcCeFohReXzUDpFtIvCaPCk1YvVu4mkYZ8YMoID8dPGMRW1m39zHU8M?=
 =?us-ascii?Q?00YYO8Gfr/uTPbx0TOc+yzeQNE3JmkXsCliPQDFWzq3TMSa2QXM7oxOrdYrM?=
 =?us-ascii?Q?pK44Z8rZWo27SHlQ1QPUDaRBwtLSfOsu15M0g8fJckxIaqYGH/KGgPqy2JDf?=
 =?us-ascii?Q?MBu+Z6UIKLnnzzlbo9xoF/ui85Y/pqSfhjtnzes8vKb/JskGMrK9nuvEt159?=
 =?us-ascii?Q?g4OTYr0rL6bpBrlYIadYC8SJ0v7oBYKhPvrxhpUWehPcazW7xZX2ZPBp4gCG?=
 =?us-ascii?Q?nUFJvoZbUrZftsK210bCWkoUnQkTVNbM2lOHbm/7WyHkNDvXsBRuHQSN9DsW?=
 =?us-ascii?Q?rJFUnW0OMIj/I7e3Waq98Z9ZuVqtjLPndaqqiROBBhNeQE/rhlXTnz9Ydf2z?=
 =?us-ascii?Q?Bqn5/hJX8UhFfcLPYGE9H3czSluKeKYdUYmVkp9N96aN5oH2ED+TS3Hom+T4?=
 =?us-ascii?Q?5UsIr1+kuZH+529T7yJzkgxfJ+pQwY5Pj+gg3uNvq4btse84IIgp/kvhDS6z?=
 =?us-ascii?Q?f1mWBxwiD3R/UA2miWHkqiS1mg9b9rSPoGqBWw9aIPnKTzoEmxNlagLclYNP?=
 =?us-ascii?Q?LoP6xbV4mCvzrGCPbPSY4yDk+bW6AUvjzMreWbYna7teuT+PmQvNMvNPr/41?=
 =?us-ascii?Q?iuAWmjMaGXTdYIFOh7vO+4d9wxbRpLB0z5yVMz4a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e4d5d7-68ba-45f4-2d47-08dcff610672
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:18:56.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ox3dDZCqCw8KtaNc7TOJLdKFxQ1Ye5vJXJel91Ln4jwjGUCVEyDsZrhF/mJxvqIHCc1/CNZmCxVjGfvQeWTTWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8344

Use devm_* and dev_err_probe() simplify probe function and remove
vf610_adc_remove(). Change type of 'vref_uv' to int because
regulator_get_voltage() return type is int.

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
 drivers/iio/adc/vf610_adc.c | 79 ++++++++++---------------------------
 1 file changed, 20 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 4d83c12975c53..a6a0ada8a102f 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -160,7 +160,7 @@ struct vf610_adc {
 	/* lock to protect against multiple access to the device */
 	struct mutex lock;
 
-	u32 vref_uv;
+	int vref_uv;
 	u32 value;
 	struct regulator *vref;
 
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



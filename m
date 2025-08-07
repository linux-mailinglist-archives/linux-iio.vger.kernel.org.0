Return-Path: <linux-iio+bounces-22402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04181B1D8DB
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 15:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C13B1728E7
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D07255F3F;
	Thu,  7 Aug 2025 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="XQk1aKQh"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA324A0C;
	Thu,  7 Aug 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572874; cv=fail; b=aoAHK30HI9C0RIu5qUNPq6ZFxl3uvkj4XIdUb8wdwTnGUnqwYDUmP2t6+eP1uatEmIiMjrWZFbgKOxcc0DPBBvM2t/miYHAG8QN/FhbhC7OzeKETqZmkfDdXi15ROI4e6Rhaj8t2+MxDzUZd0E7KFkVvyNA+aATNE5K30WNFi74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572874; c=relaxed/simple;
	bh=jY3onvjXhlOQnypq3SjqmmiVIKeCC4R3gmmxTzDfGMs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e52ZSIa/mTSdP0DHkeS72LpllwrxOdyS/g/hD8hFUhcfZnCv3o+W1NURw7mR/ciAOGE3rax0UAjPit8yufggVSIO5d3sZ8j1CHmL69J/HMYPVsZC5DqYDoz6zAHp4CI7flAXOIlqKOWmKUMEEOoa8CilES1houAoLHJY6JeMnrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=XQk1aKQh; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQqetpgNQczI4b0NA4KFTiOD8/TSRff6eEqLJMwRqP7zT1HvE0vi+b2AFTaTLl5y4RkemduEozLrG/EitpZ9ErYzK4JTenTF/MPgYrU/DrfnaupYyF46HlXg1wP0cXuhr4N3v/WiQPEAdN7jV6TcHI9NjGdw1SQtUH2niaVEZ8wTHm9VupeszNV5RpkwM9sRnEhPvj2ZTmnLeV34S++ycPAFSVERjBK1I5WGc3YPHufhc030FZ3gvsYeolmZwB2cjSpmAti2w0k+Es3aG75YbbIZoaQX//gGLIlO8TsUiX2osPVu8hoLpWtbvtpKuRrC6inEicnFIqW6HtRkPwR6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4B+DuRdNoT6o8X0sV8dOh00GPR3turbXYwOseGQPak=;
 b=B1GT66J57S7Iq61eMDFktWudiwX94cBq6YRbirWhZ+9IKpP67ptRjbXv689HhGiSqGGD1vRw0QomvL8AbMIr3iIY0l+3br0r5mVl/w5JUhrRJTP90NQq1rH0UEqsELsiFx05jbQHCjolP3o8o3R97Wtwjiw0P9l0AVwKj8OYiBzTdZNxk6ky6mXnxbKZxispcZ8tEEWNR7XqMbbP5onhVV/cZIvN+CkdX9zSVBpkOz8v+X7nUbPcIrIz7Vnwm9yqaa0R/H5FTPIOGQxHQN8Vx+P9vA51MXSX1P0FoLojry1FIV4TwDtGxZPm8f6/PywY+pAoBwHJa1+ow57B0nN65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4B+DuRdNoT6o8X0sV8dOh00GPR3turbXYwOseGQPak=;
 b=XQk1aKQhuYn2VnkMZhW2GMT1MFPxFIrbemN0D4IcE/6ZMQ+B0KQMGzeS4PybfZ7PgF/C1NdXCr0rFyjeaCi3w+/uteBPi8OvIDyvXMDLe62DrO3KQ70VLiNz8PQi94T6U36at/qEcbFpye8AcJJFkrVzByhpyB78ePUCkde36eI=
Received: from DUZPR01CA0342.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::26) by AS8PR02MB9090.eurprd02.prod.outlook.com
 (2603:10a6:20b:5b8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 13:21:09 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::cb) by DUZPR01CA0342.outlook.office365.com
 (2603:10a6:10:4b8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Thu,
 7 Aug 2025 13:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 13:21:09 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 7 Aug
 2025 15:21:08 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Julien Panis <jpanis@baylibre.com>,
	William Breathitt Gray <wbg@kernel.org>, Andrew Davis <afd@ti.com>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] counter: ti-ecap-capture: Use devm_pm_runtime_enable()
User-Agent: a.out
Date: Thu, 7 Aug 2025 15:21:08 +0200
Message-ID: <pnda54bjmij.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|AS8PR02MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: f68ce342-411f-45f7-2505-08ddd5b545bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PrsObfwO0QGbnWoK2GSU+2+CddNH/iT76vVxHfHyrutLGFD2P7SSP5g8t73t?=
 =?us-ascii?Q?eeWehHgYabypzp+2DfXM5+OWHOCeYn9KBe/K35XyVD1YqhGnbnfeZS5KiOq5?=
 =?us-ascii?Q?yHuV1eYbsip2CCiSZZfzG6dvmbuZiQ169PvCFN9Cb/exfKsx1WbuT4gJXuxu?=
 =?us-ascii?Q?LpeeFc/bgOkhJdp4O7Q3jpdxOFQZoVVxG1zCioytGmBKB9sF70Mx7nXoPVx1?=
 =?us-ascii?Q?Y5Pmuv0r561MFf0PI6PSJdwi1dVRyq7x0EUe5X9O8zPxjJHceYz5T4dh7LMB?=
 =?us-ascii?Q?MUE7kYmGq8PD7sfJFtJd2qHOzC2+UFIk6HkCUdddy1uYMPp2GcnnJwymHu0q?=
 =?us-ascii?Q?pXL/MUS1nl9RITWRlr2Aoi8ZEzVL7CrBgFDovu2cawhRVgNdV4zXWRRDhAdM?=
 =?us-ascii?Q?hf2vG3k+g+9xx1uZb4poANnklJ7Y4SO6+k2MMxOJLFCGCoLPxW3V7NLqy/5T?=
 =?us-ascii?Q?T9UdeCGENpyjri+oy30+RGsdh/cAzuQGX2zG9hlnKJ2W6k2B9ZCzEWIDxg3X?=
 =?us-ascii?Q?0HF+RdyxCog53mmeg2b51DBQramuYVIlSCd6Uupr3L8kuOwxilRWn0462Gw1?=
 =?us-ascii?Q?IkIXKPutTOZ8y9AKzAUyk36+lqO3fk5IUHvSyXjh1Cc8kg+4byuNkFrpt0Xm?=
 =?us-ascii?Q?Nq++i/EpQ0gSgJhmLg4s8Y1Ybqb2ANbmalbcatVe9vV93UClCGHVe9fNuUPL?=
 =?us-ascii?Q?nSsIqynpektP4HDCNhYLoQfBv2YB7rqeH7xrNgM4FAKuVVGJbIjJ4mNcUfFP?=
 =?us-ascii?Q?bzUlFy6nfNbz7DL9ZNS5JFcDaOHxYpwPHvVqrwNc8hSOGvnKINmHQnuA1WGg?=
 =?us-ascii?Q?HDmVPMcDS6hGycCvADXXaHCwDt3SI0unFcLq08YR+WlTNCzb3U0kjy4PPbXy?=
 =?us-ascii?Q?xWB6hzFcirLFNZDkMVIbv6PCGw3wz105Piqs1DbaYaFlgjEz2/y7DsQZg+Gs?=
 =?us-ascii?Q?VXRLkJP2YUd8tGo8OSMMyWIw9URl2bjqr8gtqBn0t2mwnOmrRr8lPNFUwesc?=
 =?us-ascii?Q?1DXg2bts+m2tAiGH2AJ97jgT7B/gSoxGfE3541mZ2ZHb3pnHTJeJ4nQLpxUo?=
 =?us-ascii?Q?kgrKBbihr7fKSCUVBTsAneD183nH5q/15NArY/LMXT3rEQA/gqPcWKm9bxdP?=
 =?us-ascii?Q?ljzMix3p5LIMB7CtVm4PCR2dgPmYS+y/G0cqXovsrJF1qxn9dgOypSH5DQlR?=
 =?us-ascii?Q?uHQRNXYJI1QHc9oFiU8Hly/1oJJxXlyQWmLbp8ZwX8GdTroi1HY/c3hAKTUo?=
 =?us-ascii?Q?1T9a+y+0FQCYQcDUUgNWueQ0YlMbvf61M7Ti2WyTVyW9jMfA22JaVfIQFPX0?=
 =?us-ascii?Q?+S/RFEkXYoZL4vVUdmw9BAbyPgONhtvXJ6xd/iE5DPHiabLTaud7xc6eF+V6?=
 =?us-ascii?Q?5H7C2+NEt5/sIonZNNBYbRAVrgbV/48v0QCLFyNdDX9Sj1QrSeLFvr0UgCLJ?=
 =?us-ascii?Q?MSQGQnoAgZfsR7AOmLcOQG4MoNhtvmQrANkJWXwRoESL7ijPnBHMCIp5NLss?=
 =?us-ascii?Q?lgviwtHC01UTYqnx3NJIyi5B/FCmXB5NY0gD8t+RsuG2pv5AAUzzmsJO3A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 13:21:09.1643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f68ce342-411f-45f7-2505-08ddd5b545bb
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9090

There is no need to register a manual `devm` action for
`pm_runtime_disable()` when `devm_pm_runtime_enable()` exists. It does
the same thing (but also calls `pm_runtime_dont_use_autosuspend()`,
which should be fine here).

Moreover, when `devm_add_action_or_reset()` fails, it is due to a failed
memory allocation and will thus return `-ENOMEM`. `dev_err_probe()`
doesn't do anything when error is `-ENOMEM`. Therefore, the call to
`dev_err_probe()` is useless. Note that `devm_pm_runtime_enable()` has a
tail call to `devm_add_action_or_reset()` and thus returns that value.
Therefore, replace `dev_err_probe()` with the returning value.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
Changes in v3:

* Remove the manual `devm_add_action_or_reset()` and use
  `devm_pm_runtime_enable()` instead.
  
Link to v2: https://lore.kernel.org/lkml/pndms8em7tf.a.out@axis.com/

Changes in v2:

* Split the patch to one seperate patch for each sub-system.

Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/

drivers/counter/ti-ecap-capture.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
index 3faaf7f60539..3586a7ab9887 100644
--- a/drivers/counter/ti-ecap-capture.c
+++ b/drivers/counter/ti-ecap-capture.c
@@ -465,11 +465,6 @@ static irqreturn_t ecap_cnt_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void ecap_cnt_pm_disable(void *dev)
-{
-	pm_runtime_disable(dev);
-}
-
 static int ecap_cnt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -523,12 +518,9 @@ static int ecap_cnt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, counter_dev);
 
-	pm_runtime_enable(dev);
-
-	/* Register a cleanup callback to care for disabling PM */
-	ret = devm_add_action_or_reset(dev, ecap_cnt_pm_disable, dev);
+	ret = devm_pm_runtime_enable(dev);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to add pm disable action\n");
+		return ret;
 
 	ret = devm_counter_add(dev, counter_dev);
 	if (ret)

base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
-- 
2.39.5



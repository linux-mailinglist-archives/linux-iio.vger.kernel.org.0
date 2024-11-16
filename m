Return-Path: <linux-iio+bounces-12338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D198B9CFF7E
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2024 16:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635B8283075
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2024 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED41537E5;
	Sat, 16 Nov 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZbRp4uQ7"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3581732;
	Sat, 16 Nov 2024 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771006; cv=fail; b=RUAYXteIQxvXL51FirFtfABE818FFL4HI7sM76Qw+N2YdR/uavpBcTgtU24OloOdpa539vNYiRir3/+quMj5ZaFo90MD9Pyc+L7D5026BbJe2Tl/EkIxZxp1YSKSAwAYiSRUjpju3zxeI+tw5W8+/Ye/RmO3NvhjueAxkLOB3o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771006; c=relaxed/simple;
	bh=wjvIw5tph23C+qyTQTLxp6TCv2SX49HC3ROChm1CV6U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZcxyIxKk1EObB9fEhv59uSRCa1lOpPj0wfdUopo6gjgD9VxeZ1I8PyZq3O3JDIN3YWBLWXDS9I2FCp7NENvEDFqhWS1lS4fuy18OJCQ7YstEB9jbE9FY22yD+pd7vC93gxanMyiT4zSfwbOHNYqcDDJ8PiFtL+lq9XGhF/hv8E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZbRp4uQ7; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHsmi5AXUI0GeYA3nMyquqOa9sktI1ns/uSCHsvto2Jj2TYhARbLlvgEN+Qx0hEH2vYk8WicV5nOW9m+Pp3STWtVIdWHCSE6KwTX2YxcBKvsErMsqHtmkBe/7SidcXfwBZspCiFybYk//pCem8mWczsfQgLdMLQ2IR2b3Zdm0xy3t5txosJZDAJXcG9VfJcHOLi/FBGuaWafbzpdzurkNow0j/CyafNwg465ba1g4IAiVPKxPLb8RtTXV1UhaGiyAPV9dLg6mHClS0nUiX/qyR/VCbjnRysPZrjvD9Ef6zKl9X6C2xWmTAW7M7P7SMMA0AiHLNGa2Luz1n+0BdK2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yKbLFYo+yc8utGST4rtYsYgFSHz1BsczOqVoEBO0zI=;
 b=K8LiNYvrVJLvELZDBqqQM+SyPPBnFvQiL8kFS9oRwOze6gg4CLmEqOYGD+4TLb2/13/UUvRcyV7wf1DuWNyVd9YUOpoRskZzpnpw3C14VKR/9kuLLVJ6/ambu4QGSLCskYNFnCMJQpQDtdVSuYfKwD4JJKoxpN5VPT+QWNjChLqV0oSOMBikppvOklVdD/gr2SfnNPVbeDxRrvxHnwpR5MqfircMzbawuaMq3lNOQn38dFwFilSXv3qFQ3ZKai/cCxHyylZL54JoV9Qcp2d1njEvYIHZHH5Gy+d7h7u/t5f1nR4IHqSBTZUD7cnEMIcFNuQ9d0L3eYH7asXxSXFQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yKbLFYo+yc8utGST4rtYsYgFSHz1BsczOqVoEBO0zI=;
 b=ZbRp4uQ7sfErm6XNDncX5MVVk9duqQctcspxJ9iDzb1+cd7Qrdmo+CUTh10TFv1LwgxjPNsGnh6Y6pEx6aMQmnf1RjffTPhN+ukgllB8B80n0Dm1RdgtkmcTRGFgKJvvqC9Ce6/CmA4Zijta/C5RLSVgTkXH8j570dEe+SOqxDmVEMQ5+SU/AS9VHIZRZEvMUjGX3hW50eFL/TpFC5eqvdFC7Fqhmr2nZK3KZYZfxW9NnFSXc/H6c2sc99k6QMg37j73cPt052pzA9P+eD1C7ShK2/5vZocwvDd/1rHW+aYeYmRtQjldK9VGPP12MzfSk2o8cG5WwzjQ9jMv4J5Axw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7742.eurprd04.prod.outlook.com (2603:10a6:102:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Sat, 16 Nov
 2024 15:30:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Sat, 16 Nov 2024
 15:30:00 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rui Miguel Silva <rmfrfs@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org (open list:NXP FXAS21002C DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] iio: gyro: fxas21002c: Fix missing data update in trigger handler
Date: Sat, 16 Nov 2024 10:29:45 -0500
Message-Id: <20241116152945.4006374-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 543a1d2f-8f59-4285-1155-08dd065388cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fy6eWF5efb1HieEZsQ47v/m7IMp5XRBh1We/NS9Qi4EDC2UsVqhQTkKPmXLB?=
 =?us-ascii?Q?PEVvpKQg8ltuHj+K/3igqSHlYCtG4Gyoyt4d4OqKumveqVummgurDxtimTkS?=
 =?us-ascii?Q?hMM/ogyBmRSZy2Q+Z7mQIq8Y4xYjZXKLtjcTtxKjLS2eVL6ypoeu++zWhZat?=
 =?us-ascii?Q?yCXEvBhukMTfColSeIIHcyaShlfZoyKea4EY6oy6SL8WEWz5Z8zYZEWr5Gma?=
 =?us-ascii?Q?FGl2VCe2vf17DimyIED9swKqp6icpUJrzquqWHloQI1IOgLrcOD7mdO8KYyy?=
 =?us-ascii?Q?k6BvHpWhKEDJhQB938NInN/Pt4FTVsBDNqLxuDE9De/9d1ahZD8anaNXQdhK?=
 =?us-ascii?Q?Xf9LJxLVY9AdpmJv7OPcPMhk9ToDaH6axNDX6s7heWQwTsvUu8oePrcDUMFp?=
 =?us-ascii?Q?iOVgzcLBnGRCueR9t0TvcQzifDiZXKGXBW1ajOYGIPTXFlWX5VkmPLbBlDlL?=
 =?us-ascii?Q?un6GB87uogVN66OhlmMTzX24SdfM0OHuBZUK/EuDbHA4Gy/3L607D10Y7nGU?=
 =?us-ascii?Q?cngZicuKnPp3V+WXVibxdr8wByXJoHVskhKtSk8ckZ6fae6JCNjLRJovZB6g?=
 =?us-ascii?Q?pOIsaKUhWO/IsJbwcg7+V5fbcZ67FheOKYQc9MgV38Ycmeow5/6RBSihPz6e?=
 =?us-ascii?Q?BdOoc8FDwjNuQGiYbe8szzLaIDxSG6iD0KrnJA8AYXn/K8jVHeYAk24IXjsA?=
 =?us-ascii?Q?G7Fay1LhkEEkxuYd5VBCz5QIEQ2r+j1pvskdBkTL2XT5rjRwMM/epOZAx1cP?=
 =?us-ascii?Q?W9fa5k6PEdd4wp+qrE7UTuBDgZHULfN1T98OjXHEVvYs9LUFjVK/WIcaP5Yj?=
 =?us-ascii?Q?7gpvAOvfQgfKZIIrlXq+IyVREvYJqG19Hv1TQDL3ZmTuCcYj2IjeTubdei2h?=
 =?us-ascii?Q?iYncvKlH52YSJX64q3NlG3GGGM7miAPY92T8QCY3AAHlJ2WkW0Jsxvzk0lDD?=
 =?us-ascii?Q?WZkJZXMv3wwKOV18oJqjJQT9ulFTRESUIgZuQpFj9EZv4bFyTtPYYtHdpbo9?=
 =?us-ascii?Q?khVgaxq7jOVjIZBvZRWJPM1EHEnVx8YwZ5+lBapxkqTAZKF6GG2qIQFlqcKb?=
 =?us-ascii?Q?h90oeEOB2dRi/VSr14Twm/P+qt9NesBm9V8YuoGjrOnCVeTc2V9lLpa1Y6+B?=
 =?us-ascii?Q?lZJloO2TG84u1dGpPU2DgsEF3GAlWem+s9aO74GybLkbF8DiFjJNufnduOb3?=
 =?us-ascii?Q?qUkK/jvbXyfvVKwGGJS+8KlO/w5xgNgX7b3nB9IbAFA04C5ivyq2lzI8IXjs?=
 =?us-ascii?Q?6AFW5oEuww07m7I3bc0zXuTqAn4GBgT6M7BXvgRBDY77pG7itq8USgqRZOPb?=
 =?us-ascii?Q?FSXWdl0A/9wMlcekFaEN0C2bQZRR259aqcN/wBr7FlZMG7JzZt/tdDmstker?=
 =?us-ascii?Q?8EG71jc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rdkkj8vFCLePw24ONDpoor9s4FxWZ6YJ+Q78owe9Z+fbu+upzTCFYULF7ZxC?=
 =?us-ascii?Q?2zlF7lybCyJfYGA4wwAQczVT9EbutSHq6aECHc5F1KiVhWwsU34CFjl/i2Io?=
 =?us-ascii?Q?ISIXG66nLT4twiR2R7q3QjgPM90KjFdd5lFqmmgzNMwl65Ds33BL0O0f7OYV?=
 =?us-ascii?Q?ZQPDMZX13KCJk4/Qn0a/i0jrDkDpDnvxE3tY6aS2uIkAI0HnHjRJC4xMnDS8?=
 =?us-ascii?Q?2n9W41GsX4v0zl3gvRldbrZR6SrjondHsBHcC9RKW2DbgSAug10SwSqNEzpG?=
 =?us-ascii?Q?91qA0y4DlN+m5n3lbWc7osYUD376iyHBm9EZy5h0WUQY3+Jgqd+4c8jpDVjV?=
 =?us-ascii?Q?UWvHJBA0/8CdktWNZPyG65l3ItdyH3rNhAsTQjqtiBOU0YNr3OPwO0Ufy4r/?=
 =?us-ascii?Q?e61L+kvVMqoGI2gQ9MuVx0NBQk/KL7su1uKmXPejek7FeZpwbhHtmmqmQR+0?=
 =?us-ascii?Q?JJG6FkCjXh239GbHPseiRgc/VRKkLuPNTOaYepX737cPA6CNX+RZ+cRFP6kg?=
 =?us-ascii?Q?8seJgmMcxQ8K0p9SN2vIyr1ZU1LY8vgWtdwySPBsyIk/R5N2G4odEWgtZKH7?=
 =?us-ascii?Q?WFOi63E16p2AkYbmN8lJdy9E0pqvl9EKd7r4HTkyqb0SwuelTV6x2rWC/Ftv?=
 =?us-ascii?Q?3T07qbLOyHm0pj408eb8hYL4fmfhygdrfG/XAgLuZQnsHW7DS76LXcFxnh8S?=
 =?us-ascii?Q?FltaGHPN8L1BWpll3K5jmxv7N7YSmO/pE/4z45bEDnxI/W7dbLshaYpUDbGt?=
 =?us-ascii?Q?kY1Neldf1XoNQQNE6Cipf8mTQwV1dU/Qzxf0MdJfvaLGpjQO2NgAxEdz2qpA?=
 =?us-ascii?Q?VzUOdKjTGsrIJMq5pwI3337SS197sQ87WkyNk9JLdvymCUWnh/uARXluIJJB?=
 =?us-ascii?Q?4oyXMR3RuRom8E/Yb8xekJPZ0Rt/F4TaL6A9p41brSNtA3rilvYl35pEsitb?=
 =?us-ascii?Q?xqt9r93ERzMcqsK7WP/ANYQuIvDMn3o8VxmWzIVvV0ttmD2hx8L393iNBGnI?=
 =?us-ascii?Q?tpwJhQ8gcdfUSICXe6y9QFjFmKFsNVRnuEI8t/xntTse12VYC/no5TYXUr6D?=
 =?us-ascii?Q?1TqdjWPVl06LQEic0gk0ZiEnnX3e+/rdfX4per4NVjFnKboJ526jTxAbNQfp?=
 =?us-ascii?Q?YP05QIT2x1voHrpAu/AzcJMqmvY9VHnllH0UhLuhIZQOw8dYKuyDbD/9ZzSZ?=
 =?us-ascii?Q?74680lELXDSMnroejwvddd8QTfLt7x3NM1fKAMaXHE8QGl+ZfNvW4CDueK1p?=
 =?us-ascii?Q?SLVuIgSjNeLy8jn2AIgLK4PKj/vqvghpElOdST3CRJnZsg0WI17vuiKb8cP/?=
 =?us-ascii?Q?hui+OWQsoM/ud9frGuOwrhZjU02btofnOqOicd3P5jZ8Aad49e/PbQ1jop4i?=
 =?us-ascii?Q?9cx0YfUxNnG7RGMkPbCihJqwFdy0wRklH+BVi6ZocdmzcKAnGWnq7jkF8/tu?=
 =?us-ascii?Q?q+ojzgYXqKc/b6DOBisZyD/TzRqnkXltn7hbtZ9su338a3hCj2XTeXYPT0Wv?=
 =?us-ascii?Q?DhTlz3sggJ1GAGNvSQplNzo4jgodjPb79AuwGNYr4OwWX/VNTWtzBMbYdhl8?=
 =?us-ascii?Q?5PFrBFijV7Kemuk5pHY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543a1d2f-8f59-4285-1155-08dd065388cb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 15:30:00.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOuy+T1VOe00gfs/DVQ1Gs4wmtRyD44wWpeBTpL4ZMl/ZQuTq7reEuwGXd5gIWCvSAT3cSvvvKWV0NyUxaetrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7742

From: Carlos Song <carlos.song@nxp.com>

The fxas21002c_trigger_handler() may fail to acquire sample data because
the runtime PM enters the autosuspend state and sensor can not return
sample data in standby mode..

Resume the sensor before reading the sample data into the buffer within the
trigger handler. After the data is read, place the sensor back into the
autosuspend state.

Fixes: a0701b6263ae ("iio: gyro: add core driver for fxas21002c")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/iio/gyro/fxas21002c_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index 688966129f704..50b908b2419be 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -730,14 +730,21 @@ static irqreturn_t fxas21002c_trigger_handler(int irq, void *p)
 	int ret;
 
 	mutex_lock(&data->lock);
+	ret = fxas21002c_pm_get(data);
+	if (ret < 0)
+		goto out_unlock;
+
 	ret = regmap_bulk_read(data->regmap, FXAS21002C_REG_OUT_X_MSB,
 			       data->buffer, CHANNEL_SCAN_MAX * sizeof(s16));
 	if (ret < 0)
-		goto out_unlock;
+		goto out_pm_put;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 					   data->timestamp);
 
+out_pm_put:
+	fxas21002c_pm_put(data);
+
 out_unlock:
 	mutex_unlock(&data->lock);
 
-- 
2.34.1



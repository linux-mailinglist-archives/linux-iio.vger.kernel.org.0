Return-Path: <linux-iio+bounces-19606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3486ABA1CF
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 19:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD451BC67F9
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1F225DB1A;
	Fri, 16 May 2025 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ZWc960Ev"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D8C23D28E;
	Fri, 16 May 2025 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415943; cv=fail; b=svKQrHImvLSRv/5/r544baqSrsCnHqRAiaLRhYwCt1Ioq5e1LjPPbasjL0H/lShXwoluKYXfC/Tb004dCOuG8iBMlTfRaATCcMh41nL0YtvKsm3P8pBBGm7M0YvINIKIEXdHkDIiSR+GVAiIGdanzSyifLRPlWxB46q1fp6zGEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415943; c=relaxed/simple;
	bh=rXMqwO6cZoJ9QrcgkdlPG1oQTCTA0plW7OEjTSOWwBE=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=H8ORHuNgCsELuzCeFkQXXkH97cwqbz51oWbICHMYN+46A2StrDLgsXBYGIM1f6T5hF3PE71MKdStKacJvHl0LtqzM6WZhIhDSp+K1OX/5+pdRKamKdEv1YsuJAuqXT9xLv2wfwoCsrv2tq8Dgi/OaGCQkDWmscMphph/s66arb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ZWc960Ev; arc=fail smtp.client-ip=40.107.22.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7nVY6QLrdQA4EvOCKY9mQGu+eMm12H99HwH63fIm9cblgfoywwK7hNT2n7Ab5mb8dN1wRAr3HqZBPzgVZexlNsbi2iyyF0whHjE9dPv/9lLo1eYWvm/GBCbsjCRBjwSsgZgFZgBM9vhOeFUZZLm7tSxvlQugQRJlgrwNOrZDho2owRvfuvmHWnlVIh7nMDLzcpnnb6KTe1s63JKD86IaJ9FoyermKTsRWreEIiQQlQxyRreS5yCHSk8UO46GOpi02AnEVf8zMB3AqoQLrtQzY08/kuxFlqQm59HS/VmD8nS1SQz9jTq9r9tNxur+fOA3k6mAWv94MmchITlcFDfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUJ7r3QAxtlgfUSlUPT99E9FoQ853ahf5eIvAGKbGeg=;
 b=ChycnCJ/9kIKYQGyNi0hhFelOFBfWmeS+p9d+zBfLiEdxo51rFMmtUH/bpUDA5UMRpWZxjUQHpS/oDUP4fn85dSEwiOjIgUkP3xgEuapP76NgudMeTrHAs2LsTwmrJxUGoipLC7bKPG3xB9579X5j0VtPHCbcPqSYSfz/ig3EHK9x8HJ3D9ijilysNMIgtCIp9iFFs+51A2AlLx4EXSE65LQNAvbJpAAIcy6OPR/g0sMu2r3pWf06nVyWd+RHc+kIf82IVFFjqjP1gke0gkrNcMurEfxclPpVMtrOB2fjtmjoFLwtM9Pgtlkwv9GxhHaOG6L21FWRueNR0s1rtQgcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUJ7r3QAxtlgfUSlUPT99E9FoQ853ahf5eIvAGKbGeg=;
 b=ZWc960Ev5Pd63jvPIa0wK+06cMcfSOj4hsTfgUSaD4kf1WkyuXh4f+xOLygCZSfUvFGdDPBpupuVWMXTzM+1Z5NDzmTdfeEh84Vp8EH3yve5dpcsDpJn1IfYs1VWn7WJoSPNdJy+OrpjFS5XpT3gmTitHO4f6NLfG3fufprt4qs=
Received: from DU7PR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::15) by DU5PR02MB10552.eurprd02.prod.outlook.com
 (2603:10a6:10:51e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 16 May
 2025 17:18:58 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::fd) by DU7PR01CA0012.outlook.office365.com
 (2603:10a6:10:50f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.21 via Frontend Transport; Fri,
 16 May 2025 17:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Fri, 16 May 2025 17:18:57 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 16 May
 2025 19:18:56 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: irsd200: Remove print of error code from dev_err_probe
User-Agent: a.out
Message-ID: <83c5ed21654b1b98437247d0fef823237af641b4.1747415559.git.waqar.hameed@axis.com>
Date: Fri, 16 May 2025 19:18:56 +0200
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|DU5PR02MB10552:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb4b7ee-5b6f-47c6-cf76-08dd949dbdff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F8HFIZ7bGkPqnJeEzQh4q79C+eq7HL2Snziia5AfWqGRAVyEVghPbXdJIRil?=
 =?us-ascii?Q?QtAmnDXp/XP40WfX8rn7aXnn2dwh5qbRp6nVXxIEKArAlPvC+ZfwkOH6iKxi?=
 =?us-ascii?Q?1TjJX6WuR/yNcHReDcp24xsBqhxX7SlaykUjCHmkwbJUo44GGDOLo2qmAJUx?=
 =?us-ascii?Q?YIEbNWBdoSeEtoq3U0jgBKQkkRlQES45pfx+U7PuPP7MoDCFin6sw7dUsBIr?=
 =?us-ascii?Q?lvft2ONN0uFWHO7FRelZLLRHzGPjtggUM0QyL8uVgpjdpr4LD+U4jOOEuvdq?=
 =?us-ascii?Q?qAcHyFvv3VCownIiBwW4evTLXRqjs2DQjL8cxOh5rQNx4HhYVsAO2socRjTB?=
 =?us-ascii?Q?ht2y1gX/CLqXLuZ0dv7ZL5Kr3RbNnBNW0LKj5VbBC/cQ+QlyWd4F8bTd7L9L?=
 =?us-ascii?Q?JuJl5xNPOCtBKJSXuHS5vD9IqmDA4wGQrSkp76CTm1oEbOPqxxR2Mt5RR50u?=
 =?us-ascii?Q?RLZ8e2XnXQeNSLP4Fb6bDayEr9mi1Kyet0ILl6N6vaM9Y0SMD242+ofOzy1h?=
 =?us-ascii?Q?dl86adlpNrOW1iqluXcd/m5ZJvdEY8PFSIyv3BZqxSqHYMPQtor4gFFXZ5t1?=
 =?us-ascii?Q?loJc1wKx/VBrPh0SIlPPtOEuMaEAoH62sMbf9kshRBgcIVmeVpjkaOSV//+d?=
 =?us-ascii?Q?Y9YV8Udj7TSor5dWwOOsAiPPVsr8SrB/dPpimmIAwZEcoKUP4t/SzdiinPTS?=
 =?us-ascii?Q?WWQtvqUDnq3V6nOjx2qxVlhJzoWeLsSPGknU1HU9wcjadDsDGJVc6DTa7si5?=
 =?us-ascii?Q?NRV5aJhIr4DubviKo4ai2dz6myOXv00ngA8Cww/MJtTQgRQvEJClXV8BkVwg?=
 =?us-ascii?Q?uQHGwlxZ66wSQQ1z6xXla+WaD7+FZ4+4qhgsEKnfgN8FWFBVut8hpTmnUwgW?=
 =?us-ascii?Q?ws+5urG0/W3cXS1jt1r2DWP4WdtaDJVX3Ui1F5w9x7ZD2s9m4ead09J8iO2d?=
 =?us-ascii?Q?Kpw6fzUGMxRNpUO5t00fVJ6OCGag2O5/voEgAtEnaz3BNH5T+0mxUEzL8EWY?=
 =?us-ascii?Q?zLdkVBYUkx7cC97xprgG3iRq08R7AStabZTDC2BH9dmAnLyRSB3ce2+91oY8?=
 =?us-ascii?Q?zC3SfMe5uwC0baOvlCjoTk2hRPN1JZgvuyYaZCjqaArN5PuxuNDpCkTIClyv?=
 =?us-ascii?Q?tkSRiJPhz0FD/OoFNYvdKuadpHqid79tCGr/KgO8fj3Oft8jMMmwCiqolZHD?=
 =?us-ascii?Q?5sNnO6qgSSZ9HasNp25zNH3s98usS3MYjVvb7U8ArXrthQ/rRStjKi94dqX4?=
 =?us-ascii?Q?UhHArGTjCn88l2cF5UK06V919gGnMu8z/fi8Vyb6+vkDgl2iQgjLWPMdbSwt?=
 =?us-ascii?Q?G099APPakuboxXnYv7kEN7HnkPv1yXMcgrKTQkgQyiBf1jxFVpJRgk8vU50B?=
 =?us-ascii?Q?SK0ng/LEBhBOSEnHCYewuOA/bnG/QIavTOE0aQWjuIg12UBP5x8/IdA2LIti?=
 =?us-ascii?Q?w4qhVK+qxEfVS7ILg0Hl+W/FMgZxtYmNs9bRgTUuwhcukUA0i/arbZ5JM9rX?=
 =?us-ascii?Q?pVex6JmeyYWxXHGqYtrMndQoOLFNFAVWcfUv?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:18:57.4353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb4b7ee-5b6f-47c6-cf76-08dd949dbdff
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR02MB10552

Since `dev_err_probe()` already prints the error code, there is no need
to additionally print it in the error message. Therefore, just remove
them.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/iio/proximity/irsd200.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index b0ffd3574013..011b506f4542 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -881,9 +881,8 @@ static int irsd200_probe(struct i2c_client *client)
 
 	ret = devm_regulator_get_enable(data->dev, "vdd");
 	if (ret)
-		return dev_err_probe(
-			data->dev, ret,
-			"Could not get and enable regulator (%d)\n", ret);
+		return dev_err_probe(data->dev, ret,
+				     "Could not get and enable regulator\n");
 
 	ret = irsd200_setup(data);
 	if (ret)
@@ -901,17 +900,15 @@ static int irsd200_probe(struct i2c_client *client)
 	ret = devm_iio_triggered_buffer_setup(data->dev, indio_dev, NULL,
 					      irsd200_trigger_handler, NULL);
 	if (ret)
-		return dev_err_probe(
-			data->dev, ret,
-			"Could not setup iio triggered buffer (%d)\n", ret);
+		return dev_err_probe(data->dev, ret,
+				     "Could not setup iio triggered buffer\n");
 
 	ret = devm_request_threaded_irq(data->dev, client->irq, NULL,
 					irsd200_irq_thread,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					NULL, indio_dev);
 	if (ret)
-		return dev_err_probe(data->dev, ret,
-				     "Could not request irq (%d)\n", ret);
+		return dev_err_probe(data->dev, ret, "Could not request irq\n");
 
 	trigger = devm_iio_trigger_alloc(data->dev, "%s-dev%d", indio_dev->name,
 					 iio_device_id(indio_dev));
@@ -925,14 +922,12 @@ static int irsd200_probe(struct i2c_client *client)
 	ret = devm_iio_trigger_register(data->dev, trigger);
 	if (ret)
 		return dev_err_probe(data->dev, ret,
-				     "Could not register iio trigger (%d)\n",
-				     ret);
+				     "Could not register iio trigger\n");
 
 	ret = devm_iio_device_register(data->dev, indio_dev);
 	if (ret)
 		return dev_err_probe(data->dev, ret,
-				     "Could not register iio device (%d)\n",
-				     ret);
+				     "Could not register iio device\n");
 
 	return 0;
 }

base-commit: d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3
-- 
2.39.5



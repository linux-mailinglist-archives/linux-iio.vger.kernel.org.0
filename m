Return-Path: <linux-iio+bounces-22305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC1AB1B11D
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 11:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5C1189C639
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 09:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A012641EE;
	Tue,  5 Aug 2025 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="HeDAickp"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721225A348;
	Tue,  5 Aug 2025 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386421; cv=fail; b=iB0YSQPdfKfT+Pm815/tSynloNLRFw84+AMlF+gZHgTrDVSE65xKGv5pa4soRwEgOt5Z6sqwd5h0X+mg0vvYyn6dFxZhB3ab6iWkEUX4bMsmqAOtEicPZjbc2Sp3acTmDbU89prTOMFp9ndNtEN+Djdoj8MZFmpxwWEt0vjMido=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386421; c=relaxed/simple;
	bh=rePD9tTxnpc4ipiP4AGHmKjN6pd+Uf9yptM4rtiIieQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CI2T8vJTdQisgo7jGfiZ2GosVGijFtJeLtwvZ6NHWtIbKk/qbRblaYbM+/XZJYLXDJawTNZfaSMHGejABccUP73iH7HjYabGTahQKYmmI/kgnwXEt9trb9OSnA60YZeF40OWxGHv5hd1gDP6ADCFYbtTdEHYt35/u9xy6F9vbww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=HeDAickp; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzuyAGOYcKrwk2hXj5XHixRtmoYYE3KbLi0ndVWwc1lhcBclrdlOLqb1eBeqqNpKh9lYOdCiM0C4oKHTV1LUB1VvCfDPmsN7TjTxHj+JlrXaDY0zcay91MK7h2DPrhzNAVe1SF1bPI9G2pnKfIzraJwS1X4nFlJBeWVi/aws4wZMzCgcCfww+i28kcuAFSBXdAf6WRC/yBdRcUvEf9tvM0SrurADlml6J1pimNxD2XRppH5N+NK2ztI45S+d/yRlyKT3ycjuGjQoHGa5qqaLVXEvwhTRNQSQZsaTkOiapqIF7kiy1J1qi/B72mUSjjtMwxgaKVDTg8Oot6s38L5vsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Rlr+H5lHjrKv0c5NsOfGAyXZnJ5tX0M3NVHk7I5ah4=;
 b=xhnkPn6Lf4gRfl8u4NWwcsnQnKP31jdYnDJjxTp/x68Q1XHB1u/nhu4TRlX7DJ48qSX7comflZoeUA5jjjsX5ubw5IRkiiyRPyZsyNgBRsv08iiLh3lFrOMg9ywIjW/8QpxJVuM5ANJzYFRIjLq9PcfSAMD3/Uay1uf0JQAPgGaWvcxnzKnY1GnIuu8BeGXHVBPSu6ftw/cMQ0F07XWuHLiNCDhjUL4BteXLRzGTTDnkzbPgQj/cTLopBLRElR3RUJIqop92VcVifNrpctQiVKkeSreLir64nkJZpJL4QuyFmfBqeYsLJ9Zabs4VgrvMKdrHAAyO2pZ0+NBZj0LWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Rlr+H5lHjrKv0c5NsOfGAyXZnJ5tX0M3NVHk7I5ah4=;
 b=HeDAickpq3QlsxcHzzt+4CqsnFsszZ3luAA1NC/yiKn0tK2yKLckDUpKlvR3I4IkR7gNZV6/FKeXXhyR+qhSEW+ie/vzm8PkjWzIWinbgsvC16Xgo1KuYNcd3gAvNDiO26GPF5BERxXeFpkvcPDP4NV5n7gTfMuiPMrC3wax5/8=
Received: from CWLP123CA0013.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:56::25)
 by PRAPR02MB7836.eurprd02.prod.outlook.com (2603:10a6:102:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 09:33:35 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:401:56:cafe::83) by CWLP123CA0013.outlook.office365.com
 (2603:10a6:401:56::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 09:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 09:33:35 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 5 Aug
 2025 11:33:32 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Julien Panis <jpanis@baylibre.com>,
	William Breathitt Gray <wbg@kernel.org>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] counter: ti-ecap-capture: Remove error print for
 devm_add_action_or_reset()
User-Agent: a.out
Date: Tue, 5 Aug 2025 11:33:32 +0200
Message-ID: <pndms8em7tf.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A790:EE_|PRAPR02MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7b3f4d-4796-4f46-295a-08ddd403268b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t3SYMdqnNGpkO6LF45lRT9Rj9Wq/PnzwiQV5wueXYb6lrlasMoV6P2bIwDtv?=
 =?us-ascii?Q?hDJu+7x/7fFjZBYV8r4L0J5nJ5pRkZXNbLMna5kQrE1+FAUL/OVjPjE2zgAe?=
 =?us-ascii?Q?EZbTJ7LP55miOE9Wq7M2xhw/DrlAB/XRFC0kRM3Dfuu9TGP87WVjQf8syy32?=
 =?us-ascii?Q?ToE6wDpvAe9oQTbzueRmOjFi9EAdtONuhkMwnUD7XRPfsENXRrjX3uzwQNVR?=
 =?us-ascii?Q?VmWJLTACNsuWIED3ya+dMjmI1YlLmfbgCk4pUi0iJR5B9ttMaeCOWMEMDbBZ?=
 =?us-ascii?Q?QYNXHs+Mf+wTIg51q+wMio6qpr5kWbJQyp0GLc1kE4sIG8LoVxxVcze5wymV?=
 =?us-ascii?Q?qZLdTkFIG7tm45MzGoS+1EPpmR8Fxayu+/GA5WPUC/ZWtR3z5K2C0m1UQRKS?=
 =?us-ascii?Q?NWyIGVgOE6HdY9GclDrE252gmOGil2oN6UgEFqzrkH/vfZfO51LiwPZGjiNa?=
 =?us-ascii?Q?VjHwmaNOGWsj8hXZYVUEQAAsncFj4ijcz7MxKU1B6KuNcgV4mv3irFOTQTOv?=
 =?us-ascii?Q?Q9vfwmgbyN9jeWg63v30ZDVnqlhUKF6jWdlEieaiJcJBsFR6XjX98rWh4yya?=
 =?us-ascii?Q?K+4/hQECiAuW08ZyR/fmtJx+ZkZIQiV/U1ppO5PYP9TO0uzdH6NqoPAJ282d?=
 =?us-ascii?Q?7CMtX77xKUmE/VL8JRJ+nrPY9UDuAwiYN55bfqlhYLIf54TJJeKPzjNSsW1y?=
 =?us-ascii?Q?5TsWWm9OwDQw5XzRcd7DxPN0Yr6livt1kdwRsTK6OYbxgrk4S998BkCM/7uH?=
 =?us-ascii?Q?v8Soq7qry9hBqAr1W3WTq5Xv+oOnviSpSzavMDEjefdljfCgIuk0E3+z8aMZ?=
 =?us-ascii?Q?ksflqBxa4T9pyb3UVClR+jJNuiIjRxKluZAjFx20CfoH01VBbQEw1d1OPCGX?=
 =?us-ascii?Q?80bZmV38kC5Glhp90Z8uzMk3YFwUFCX0t3a0CkojdQTrZhGc0PgdAywYljET?=
 =?us-ascii?Q?ac1CrfG1g2UXL/O8xLn38wOZ/UjnreYUDn/LYF1LmaNTd7lW0Z9q4JQDs/KH?=
 =?us-ascii?Q?n6CiZS4FRZtYxk/M4nfzJiSNlnd6AJdYYctCyFp5ZO6dt9sIM487i/QJxFP3?=
 =?us-ascii?Q?VSqPUWzqxti7iSnrwwiV2ce2SXOz/zCIkqOMaOZtKxUqn2c4qpTujaxUdqCT?=
 =?us-ascii?Q?eGsuutSuVRl02h5Q/FrD0fJa4JUhAV8xBGUBdT6oC5BtKIZuceNz9P4gFuwz?=
 =?us-ascii?Q?+FBYPx9oChaX0t4DWJ1khpDH8e6rGUO57zc0UXrgs/DgnSk9JSdhI+ckij3o?=
 =?us-ascii?Q?frM0yX4pqf4gQNo8S2X/kZx7Nuu+7ioxYiGEEo2YdCVvrFNtIzR5tUHS9R5p?=
 =?us-ascii?Q?PoxkZfCszvN2FYOOGRp1slb4pUTFYDF7BjaXxFgXzLqOU6TsHmMcR88NW1Qf?=
 =?us-ascii?Q?QyLi12IiUuwICYnFYSqhIyD3zmVU0pHuvu+VJPjOlHpdEs60+tTzChQII+nX?=
 =?us-ascii?Q?lbLQ0GBe7VgoWoAipb8NATa8grlUEwkdvWRs9zEVc4aHlI4CI45Qii8TBBXo?=
 =?us-ascii?Q?aci9rbh24HSzrNodKkAvz4hT9DPHy2YK6YzC6YJ/kcllER6TZy49Py0gVg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:33:35.2704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7b3f4d-4796-4f46-295a-08ddd403268b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR02MB7836

When `devm_add_action_or_reset()` fails, it is due to a failed memory
allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
anything when error is `-ENOMEM`. Therefore, remove the useless call to
`dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
return the value instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
Changes in v2:

* Split the patch to one seperate patch for each sub-system.

Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/

 drivers/counter/ti-ecap-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
index 3faaf7f60539..114f2d33f193 100644
--- a/drivers/counter/ti-ecap-capture.c
+++ b/drivers/counter/ti-ecap-capture.c
@@ -528,7 +528,7 @@ static int ecap_cnt_probe(struct platform_device *pdev)
 	/* Register a cleanup callback to care for disabling PM */
 	ret = devm_add_action_or_reset(dev, ecap_cnt_pm_disable, dev);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to add pm disable action\n");
+		return ret;
 
 	ret = devm_counter_add(dev, counter_dev);
 	if (ret)

base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
-- 
2.39.5



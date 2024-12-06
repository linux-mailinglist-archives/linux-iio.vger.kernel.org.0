Return-Path: <linux-iio+bounces-13188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCE39E7C0D
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 23:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4568283E70
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 22:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A2F213E7D;
	Fri,  6 Dec 2024 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iDgihNNu"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA1212FB4;
	Fri,  6 Dec 2024 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525820; cv=fail; b=NH81TBSioQxg/hHxdQUE+EFIu7SXO8T+XdfUn65Y8Iml9/XaQ42MHxwN1mIqxCyqPN6qdb0XUUBPfLjrD14hu4YeHzzEZ4/MSyp80oCF2jQoqM9IXd4ZxdjuBk7YcfpfLeulSfGJyR1wH+arRk+2jmmSfVlQOTsPOfivMUuf01o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525820; c=relaxed/simple;
	bh=gdaZmGZKt/HEMZsvvWdVjisT/bSHP+AXZvmK/21Rxks=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bXriva996yMfRIO8X8DvDTUPg0OUHEdjsWhVQ/EmQCvEKk+KQohYGeAbvv7mZoJjZJOHyahabcDf2wpYdzlCZE863vvrQh35ymTfmpIEcdKkl413KZnjEEtRZBKyssuMcKPXG6iQDAFsIWa7AgJcvdQvLzZ/yyZEQ+u4N7X1HjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iDgihNNu; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T82eu2FWssXcdrYxQ12w+tz8QPRnS/N4m3lNF4ygwsjgD8wJGNp2XvKL2O45X4LkcSf6CW0uElVcn8t1x/+v9Aq4wTepg3dcny5Bn8oddQ0arbYtayI/z50Q34F0DE0TEUWnEzzDM8gxywch3W8ncr6ceWpQ3hW7uAtWSLPA9DNp9z6vpzj6y77GjGH7MgIQll93YmRrWZYQTA1nzvbaiJMeVfTA5+IjYxPyXtcMphzJsBsdZcff6EOadJ752Ic5Ix1RIdqZP0e48izBO8eTBOH87mRv/9vTf28s0K+uH5O/HbTTyulr7Fx6W9VTECcFi3g2CCIv42XEtHXNMBO0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fz0VnUtPq+U1rvgBgMjKNagLttDXW0PMW8mcqI0ufrQ=;
 b=wNsp9p6TDFee/NJbPb56+E8akUy+t8AH10Oitbhwmuhg2xpcCgRhPo1t7vCgjSVN19k6bbYGiD1qXuXulNKOL0j6jN3erl9qFNdpemac66lnRf8Q63e9lEU9PI7Rhl+myGjwnm9Ra3we2kSLjde8qX9aLXgZOF6M6E8EHESdfhPF4E6udc7OCcSytNmrz8XAzgnQUnpnkO3aihqeW8VhOK+0DecEolkPQlE0g9ySgYm9rDa3it++ZtBQs4o0UYnoUWikY71iGleIOcuBmZ85v9pNXEA4Q4rfh3Tdm5swSiwv7bqpnaDYJj+f8YNNkI8e/+OGhPqYHZ3uaJ1QmOnmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fz0VnUtPq+U1rvgBgMjKNagLttDXW0PMW8mcqI0ufrQ=;
 b=iDgihNNuKu1EyLR0ClHoDlzl6bk6MiuahRLf8tu4WRIUvjoxKXHdZgT3K1TTg6t2WPc5pytEQ5wTQNDDAp5YwBbfT+V6Wm3+6Pp5tCeDPUV6L8Inx25Es+6kE9lqpREvBGM5M3tFP7tookx8zyvp76utEYZYe19RiqwqdHt9DqjqEdeaLPRjcoONnL2s+uhPBxCb7Cw6O0T04JZ3hh5HrH8TJhmeDFPD0Gxf+7kRnj6PGcjeCFvUob9WSc1lMUHs2k2IwvFDudkRyBlxeWbmR+m+DAGN5s28Pu5GMhFp5vAMw4dSxfgx2pW9oDEfwncQlTeoS93813Pqj5ct3h+3Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10709.eurprd04.prod.outlook.com (2603:10a6:800:262::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 22:56:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 22:56:54 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 1/2] iio: adc: vf610_adc: use devm_* and dev_err_probe() to simple code
Date: Fri,  6 Dec 2024 17:56:23 -0500
Message-Id: <20241206225624.3744880-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206225624.3744880-1-Frank.Li@nxp.com>
References: <20241206225624.3744880-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10709:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a159193-c2cf-4c26-3eec-08dd16494790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BHPRf4DMBZjVLoO5+/0at9zwdbmy9/CaWMkEyH5FxUCtf96nVHv5uuFNWq+7?=
 =?us-ascii?Q?4SJT65lUou7tmF1CS56VnemswesihAg8rMCjuYQj5psaQEZ/RSBHvM/LKRa7?=
 =?us-ascii?Q?43WzyU0eP01C0OtvQC7kkKqArzwufe2AlndwxfVS2fBcADAxvFS8qi2ZR3ba?=
 =?us-ascii?Q?IA/rjtSJ0ceGvDZm773WfccF93g1A8/wTQv2SOfeSGaYRFu/aFuSlBClNFV2?=
 =?us-ascii?Q?/sJFQc2Zjd6Qj1lNwL2x+kmr1Z4fZ22KqK1m5wI6u3jSkADsRjRfbQX1F9M/?=
 =?us-ascii?Q?S6I+M06xziLxPaiJL3bk5M6HJ5MNbwXZHJT77hD8WWNx4pav5fWO2VvRML5S?=
 =?us-ascii?Q?mTsNvBt1E+eV9u1wuRJpLQ3Bl7qU1z+NhDQ6SU5Skzzb7QQcwlQX2WfWZZbH?=
 =?us-ascii?Q?YviKWyyJibzWL8NrS9KjONltozbCJV63ZbNdJ7OE8RWw3c12jH3n9FWh4IBR?=
 =?us-ascii?Q?sb7rx9sN+8h99fCt5N0BEJk5Ubf1GY8MdfTqE1/BBQxWIFr/ooTj0S8LqqGI?=
 =?us-ascii?Q?Kef/SGO1Hs87iYZ7qH6UHVCKCzo6zJCgVhKunoslmv8R7WoU9l9rynAsmB0r?=
 =?us-ascii?Q?xicNYQULlh2OPAo6KhD3yGMonhb1+1RcrNZIdYW09xMs9/49oaVL3P+yuGKV?=
 =?us-ascii?Q?DrcDnXaE5O+B3X0C7bbTqFnee1AYivCJSIjCRJfRPaJQJtPcsQeYdjyfpDuJ?=
 =?us-ascii?Q?rXxnwSJyP3BqYQPZppyLeVp3IKQFYqd2DkE6kWWc38IFKMJ8YBYXmb/YxUcx?=
 =?us-ascii?Q?/rsudeGs3NcmQJE1oQf1VScyf3rKtKSVjtbfWfFddRN4vIw7yaM6Gzki0eUR?=
 =?us-ascii?Q?LRK7atJW27NFLUwSaGhjYs+cUDux8Eq69iVbE8qH5yppNY3jRF2AWiJjLFwC?=
 =?us-ascii?Q?4CYl1eXY2ZbBWOHyZHKw9LXbWvUQvAsbO3L38R3cQQX+spsznTjrqEJkVwBB?=
 =?us-ascii?Q?JMH+RVwa29eC+6ONivv0iC+ipesCU6qfhnF+A5dhBDPlusYtDIZkC90dha2W?=
 =?us-ascii?Q?HptLF61EIIUvJkpNA52zQSYOA17kKbF/63cm786R6/iVVEMypXpfK0Rb+Aoz?=
 =?us-ascii?Q?Yg/pn8Y6MWGrqgzkLpZnaXK6hup2glKDX9diqa8BwdexzhgG2YwsbH57Va2n?=
 =?us-ascii?Q?C9PnrmpFPKnTJX5fyxVcm3q0Vc56h+7bLXP+Q6UGzNcZajuHoIjBeCMNyTVO?=
 =?us-ascii?Q?83DfqPRQTKlBT2LBS3mKRFKGm8R0jV/HAlQAo+W3ofVxsJFAdKBLvH5PYMGp?=
 =?us-ascii?Q?uhZeoMgWUpBwxRKv8FhiMPkUlwHyZs0kMk8e7Dx0p+b2fIKHMyBrByQ6X05G?=
 =?us-ascii?Q?UThLhYW45imh2n8G7e24LEMjokRteKIXJaL2OQkQ2nLz2w5R2i2th+tzA5r9?=
 =?us-ascii?Q?iVIr7PpHGHy0cqGCxmGSGnYqz+v1LOQtYkXcloIkjLAyk0fa1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PoZ0b9JS9DWXIkHZXaXYMzzGWvmCWbhEVi44kFWPh6Q3IZmhHLrqPROG7TgL?=
 =?us-ascii?Q?Ci1Dog1kvP5G8JQy5mflYMCWhvJgG91TsLijhfxPIgUSSRiQXk80BbmTXyvT?=
 =?us-ascii?Q?S98CdsfF6I393CGfJrV5SUz+i82cMwq9Ef72B/VWMbTIxe06Fs1x2pvvNa5a?=
 =?us-ascii?Q?hr19/KbFMNrbjsyTPljOc5ygscjNmOZh/K8x1qilrrTI480SrEYejGK2shMD?=
 =?us-ascii?Q?PqQHLqfJ2mxi4KQj5HtQt6VSOLug2NRNy29zo4jKj/E7k+46fzdBKUQOJKzq?=
 =?us-ascii?Q?BaUpWjnB0FWjDdbvLGGiNp5cPfbs4JwL9Da0CkkivxzCF8qm/EEy8WrBibsg?=
 =?us-ascii?Q?K8TK0CAspjU84XJX85ZPh0QYJuvJBqfej/ZAFtjH16VTUI3H/omiWCKxel3c?=
 =?us-ascii?Q?Gl/JmYuibOOP43ajlElUkocXZ3qq8DzjtKYSwn8rgHemWbURMmmSwxC4zfSM?=
 =?us-ascii?Q?H5O85eLhHTKbQjxKf/VDVp+gQP0xAqxKKcuq4pPhmNlwZNuQuBVfu6KbAZft?=
 =?us-ascii?Q?hLwiIJsziqlpJLfhwEVUYY9P4iREqTgYEa39hAjwXMQjSQFFu2JTPOp3YJPi?=
 =?us-ascii?Q?LZkv0EXpYK0ORIT/POuMbQc1JfTHBbTXdl/ycRK2QW/qr3XZ21me5Y8ukZsY?=
 =?us-ascii?Q?YCWZaAmiMo1rn1TNTyfD7zjKIOHh7QglRS9n7M85DE6SEJvkpwgwjsAIvUrk?=
 =?us-ascii?Q?JUnPvzPI+OGuEM9I5wcf+lw0CBZ/c99VclcBph+V6qcQXxdLs0x1PHK/+DKN?=
 =?us-ascii?Q?Q8XZNbz/ovDJSk0eQaYsFuyVQ8HjC9jB0OVZazbkYrcPp3f8BR5PiYiMeTFl?=
 =?us-ascii?Q?5ZIK5x1ZKxkzXdIVP7C6X54leocTKr5xFmMrRoc3SF1Gqfc0XWL0ULsFy550?=
 =?us-ascii?Q?PXRH2R3S7mSUF1J3b1l9upYVRG3NJCQQ8M3WMtB+5O5VH84UmzlCSXER2R9H?=
 =?us-ascii?Q?UXALaJBd7Qis1Ne3rzFXC9mz4ZJldu/RFde7Uv20/Qmqqvlm7mVwdI8Cwpaf?=
 =?us-ascii?Q?qvVnogmgI0f6FbK7eq+DDMsBY4/A+YLhkz7zcmhBTl6H80PBv41ksl+QJbE8?=
 =?us-ascii?Q?JE+bkC+MbsC+OnOJcV3qI33pfuvlAXD1kMF3uPu/fwVHlGkzpZHFegt0eOqd?=
 =?us-ascii?Q?WXURPdn60BmgpAwKA/fCnuz04zoXqqd+xVEBCGxKLdTR5DmuhsBFZDOckO0q?=
 =?us-ascii?Q?BCcVh9y4ZUdLswHAlBkWEGJg9bZNzqYVq5pTF+2DMR3y1MwRojUWIIx1Q3m5?=
 =?us-ascii?Q?Y201HYVXltlTgvkniKocXhkeMCwYb3M4Tr5/ccNPm4xtESB1PfX9rLEfJCLF?=
 =?us-ascii?Q?bWdezKdHeqJ4vKtpqeTJjc4CA2C7jORa1Pjr1xwBI/0BT+o6qxkVE3A2Ih4r?=
 =?us-ascii?Q?cveJLnkrNOOhFpNDn4q0wqyTSR/s7TO7U4Owpr6yoBvymMjSWmvr2WAIfvBP?=
 =?us-ascii?Q?+ItcOwhf1n92OdfcUVKXVM18R284KdFkDvQOuI7uCcc0qeHHbevxzBSeaEMG?=
 =?us-ascii?Q?O79ypYOoZacEKb8GOGHwQYRz4p/yS+GUHLpQFMxcSTtp5zEtVcCcQUHunNdd?=
 =?us-ascii?Q?Sf5jUAJTvj6TU2X4UCLPO3weEYl+hbkWL31/laYe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a159193-c2cf-4c26-3eec-08dd16494790
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 22:56:54.6899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il+JOE66tIhIv/ZptaoQFOB+zVnuaXYzOcRybyqdsASbBX9T/2d8mi2++kvOClKXI5ZG0t4AXa7q4y81jcoBZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10709

Use devm_* and dev_err_probe() simplify probe function and remove
vf610_adc_remove().

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- none

Change from v4 to v5
- Remove vref check in remove action callback

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
 drivers/iio/adc/vf610_adc.c | 78 ++++++++++++-------------------------
 1 file changed, 25 insertions(+), 53 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 4d83c12975c53..fb7afa91151f2 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -814,6 +814,13 @@ static const struct of_device_id vf610_adc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, vf610_adc_match);
 
+static void vf610_adc_action_remove(void *d)
+{
+	struct vf610_adc *info = d;
+
+	regulator_disable(info->vref);
+}
+
 static int vf610_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -823,10 +830,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
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
@@ -842,17 +847,12 @@ static int vf610_adc_probe(struct platform_device *pdev)
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
@@ -862,6 +862,10 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(&pdev->dev, vf610_adc_action_remove, info);
+	if (ret)
+		return ret;
+
 	info->vref_uv = regulator_get_voltage(info->vref);
 
 	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
@@ -879,52 +883,21 @@ static int vf610_adc_probe(struct platform_device *pdev)
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
@@ -972,7 +945,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend,
 
 static struct platform_driver vf610_adc_driver = {
 	.probe          = vf610_adc_probe,
-	.remove         = vf610_adc_remove,
 	.driver         = {
 		.name   = DRIVER_NAME,
 		.of_match_table = vf610_adc_match,
-- 
2.34.1



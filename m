Return-Path: <linux-iio+bounces-19170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B028BAA9D63
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 22:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE6A16D5C4
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 20:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A7E25D522;
	Mon,  5 May 2025 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="OWmaglKi"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2525C6F4;
	Mon,  5 May 2025 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477614; cv=fail; b=BSE1KG1UHI7qYp6Vw0r3uZ8PX+d1Xc5fXdgdpwuqx3BFOFwVx8Y1h40jcEtoePvqKYXzTKivaUqWEMHGfhMVqA3Of6aY7KUis4hQSmv4iKsTVm5J9fgpRXSuafyWRMMCVTCp0/I5/H2BxOHvw8zP7jNuvusNb0lqzq56rT2ncYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477614; c=relaxed/simple;
	bh=mqUw7s+nehNvv8MGGEQ/E9H+tzHgL46W8rcS24G9r+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WbdwUoOj9BXtfxiXR4+6W5DaV4GCpJ/wrESMuw+GWVFSC870JHI56xU2HwKZQneWXdZf1av65M9k4r7MVatL3/QKcYwP6V1jU7VLYiqRibmgC5PGZEcfE17T5hPY75EYgBUsnTIEyja4eYqOfAqCOklmCfPre3qqE3SdJP3NyM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=OWmaglKi; arc=fail smtp.client-ip=40.107.249.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4WOyKtNoAKCpAlEh+I/SmsXxVdtO8qRjd/cMQkF5SqSBaE6vjRuoQqg+0tq9WVywtjWZcQfe5yigXWcwSPV7XxEFwCPQ+MVH6uQ2T/oW1VAnTKxNdMU6uWv0jVg9ESQ39KWKZXnyKHTBEKEiUSyc4oqYdL+N41w6FLOUYQfY+xpXv7It6e8OxYV4tZoSOFC0H26/GjlSrp8QpaRH+uc/BpLl0cYiHosiBlnOoYrz9irMDv5PJVN1dH3qbZyXZGHqFxxoZfoNnmYs57omZ8pyPKnt/Wa5N+pU4wo8JYArTpp8dvpFukenU+KZFFB0Q/QW15+BXsMSfwqF9NXI7c00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8VaWO1kXooxCo7LnJurz2FjBqrZkUyzdCaPN2PvKOI=;
 b=KPjTZVfI0VCkezBmFgENX6tPMT16atOVtNozbchaEP73owVWWYN9nA25jgUmcGo/vB0KGhAX29J8aQmmSxyAHGKz3zW9gS+Iyz9eo2NesQLkaRIovnxHdM9onMprW6TeyNwLpl+3/H95uUCg7gJdoejhs1lw2+PMrv7h/WiJejk6anep3ZU2ggz36okgu23ZpOyMYsKc5LWcg/VRhR8fZuDnk2OiBNT+wCxJXBMKUr/XIRo0L5L0fju5NTE41kGHXKUyDE8Nzk2+pOn59DJLLm+borblxmrhMX0GaA9hOC6PToSl5hTAldLWxY9ZH4ww5t5n5rTVxGJmsMb+E14/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8VaWO1kXooxCo7LnJurz2FjBqrZkUyzdCaPN2PvKOI=;
 b=OWmaglKidjtFMPyCY4nHBOLaFeWTPj3VCGXYDap4StCbuPDPtS8yt8nro2+P9wDLYWP8wRxxNjkqt/VVrCUe/dEx9SrtwXHReUHOR3SktKRfDkNgRLzhv6Y1pfAOdDolQEjlDLwdmDtJs6OPQyGUoaxCHzqLiPB/VQG/eRk4qP80n/USOjSRUv7zpICMdUBMzcQyEApjTdMPyYwTMFRhvd+P7UGBbOxoGRkL+UcoIsAZ7+L0VMbLIYiUNHvQn/zFMdk07VEkPqBKUSJ3hu5FKLqHeZ+LHG2Yiqe8BQE9UiN/OYKt0u8L1SAT9fw3n7Ad5Gn0goKQCObFrvoeAOl1dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from VI1PR03MB6285.eurprd03.prod.outlook.com (2603:10a6:800:137::14)
 by DU0PR03MB9613.eurprd03.prod.outlook.com (2603:10a6:10:420::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 20:40:08 +0000
Received: from VI1PR03MB6285.eurprd03.prod.outlook.com
 ([fe80::e290:ebac:cbe4:198a]) by VI1PR03MB6285.eurprd03.prod.outlook.com
 ([fe80::e290:ebac:cbe4:198a%5]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 20:40:07 +0000
From: Markus Burri <markus.burri@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Markus Burri <markus.burri@mt.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Markus Burri <markus.burri@bbv.ch>
Subject: [PATCH v3] iio: backend: fix out-of-bound write
Date: Mon,  5 May 2025 22:38:30 +0200
Message-Id: <20250505203830.5117-1-markus.burri@mt.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To VI1PR03MB6285.eurprd03.prod.outlook.com
 (2603:10a6:800:137::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB6285:EE_|DU0PR03MB9613:EE_
X-MS-Office365-Filtering-Correlation-Id: 91731a82-6fa0-4d75-474b-08dd8c1505bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EXyVQjXqIFa25KyL7RFnSBOhFyZLQRORDfbEHyMBzZnzhBzefbogud4oKHsf?=
 =?us-ascii?Q?LMZ+9wEsJSewOgvKmc9O30QWw0iJQyQzdQ7g/j2OmOOhEVPV9UzlBw6e8qrs?=
 =?us-ascii?Q?t40wFW/A1yaeJ7SldNJRGxu9/hgLw4cp4qJG4JlvsdQ0H3iYAhXj0mZ/8Oon?=
 =?us-ascii?Q?O+ylFtx/wN5ZgqFbcRAmwIrIsWL9Bxt7jGlHaILcose1Xy6B5yWdj7z9Sta9?=
 =?us-ascii?Q?ZrV4q2Z4Z0z+CRSvjlyGzktCA2v+pcKxtAF/cE3UdV5lO/udjV89dJVIR3uS?=
 =?us-ascii?Q?0+OtqUw4Mopy8YmQI/CouliF56aL0vKYdIubwkTIPXC2kXh/t+OuCpwP4rUf?=
 =?us-ascii?Q?PoMRtkfrMJ9Pv/sfZ+z+tgKkHXfiUaSPcFVDD3ufMCk50oPm+VgvdrQZedDo?=
 =?us-ascii?Q?Ky2pJTD7TLVEUJFdGTEva+BdlAGNW301NHhHKCKB3KSxGmu+qwkp/6pw0woJ?=
 =?us-ascii?Q?wbr9Wb/LI7VUSjCRy7zYJWlIbtVJJGEDbRKavBrf+LqvQNGNMzq06VmSWcbi?=
 =?us-ascii?Q?3AghqCLctEaGQaUoXjU15Sj30Qo0e9NVaTXcSu+nZedHaofHycFXKnxWhqgY?=
 =?us-ascii?Q?0KqR2DACuD8i1F8OkOErIvU5FqlZvoWdQbd9Ru5CGfCYQOiyMtgsl/VVW4LP?=
 =?us-ascii?Q?Oo/7qBZe4k7aefffzpnMUATdo1gR639gBlEO7IlrmMglSnYaHXZpV32LbX7g?=
 =?us-ascii?Q?wtHtnAU/5I4d0BQSSVAvKwCMZJyE3fbL3uWJeHkKgHV9kgUBTtJft19LinnM?=
 =?us-ascii?Q?onClbzyclpSCzmjBEpQUbqjniCRgL9pqcN8r2+lCtAA/62dqYsgDofJ+/aO4?=
 =?us-ascii?Q?Mzse+qVeRccX5ULHqXCYgE6vcUjqIfInFf7KM9BJ1oEaZ2h033YSHg49OJ74?=
 =?us-ascii?Q?1r+7c+NcOK1QEbnfn1G2t1BaLQFBocM66DsL39iyj7KgvsU24Od3/iIpJ/hv?=
 =?us-ascii?Q?eUV1Frr5Pd5lJajhfF/kFGTucMq1Dgm8+1lvOruqG1e0edp2TmFroDVt8U8v?=
 =?us-ascii?Q?du0hgvxkZg/HY3Qys0XbIp/76BB3N3e3rSDYirgXB5yu7ADjlF6OimV4u6gR?=
 =?us-ascii?Q?aAVWf7TzZfOO+6jDLfbBsc+VKGqyKA20BfR+s6HK+sJU436/E+ES50PKxSWz?=
 =?us-ascii?Q?dJz2doNe7xVz2A5HvWvUeIr/KFQLodg3SuVo5kIVyXYT5oEYzHDrJ8hHsW5m?=
 =?us-ascii?Q?YRVWNoRyVLyzqvktn6Vr86+/U5ancb9kRQP61C0R9a70O0yPkoa8tks6KAeq?=
 =?us-ascii?Q?YlKMWeLlvMzDnhipCxPE60vQ6AcGn3uEAWol5OfF/bZBI7E7aK0NrhuxJdvj?=
 =?us-ascii?Q?i+IyCblURitp7lkVNIM+gDN/QOXd2+68HKB74/qIHVGrTeXmE9LMpH+NnnJ+?=
 =?us-ascii?Q?kC7Aps2KUEkw7jmZNpzXtBCWWez8y3RUZrG8W1H5RdlSA4Zd+eahUJ3d7zCS?=
 =?us-ascii?Q?jExqcDA3HPDWQm9wEFdBjb/Pg6oWrqZwaVtBrWRrU/MN7IdK78kdHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB6285.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tVWQMXj0u0DyCfAd+cxUMEJemjCnnH44Ekty6qLKCilLR24gx5NSoBQ+ube0?=
 =?us-ascii?Q?hIVhe8qokRauAdeuFfy1IUfvsOasqSCXg/OPMu6BdkY2eSRYD5uvnmT7Bav8?=
 =?us-ascii?Q?j3/9migT8fm1d3dFj+zm3PB/tIUBln32uy396qd3l4iodHGNnPTZK0POiQPV?=
 =?us-ascii?Q?Sb2L5w58dGdKOh4e6rY3NkEObUThF9py1JFhD/svgoob2P9D8ZZYDcdy49kV?=
 =?us-ascii?Q?+lVhTgsb08+n5D1suzuFNbsgLLSOLbQDERCCrPdlUlhF/GuEfwr2LZGn63FP?=
 =?us-ascii?Q?aarX8HATzeNWQgftwUMSlLwkt2hNoyb/MkonAZboF05YmHWblf/K0j9hbNk/?=
 =?us-ascii?Q?LAGfCsCGXvpsx/cmZGWZdxz++BQuulRahsRGvHX0bhIA5r6FDeSqhW5TnXEX?=
 =?us-ascii?Q?A618yLimUfuzF3X9NqCT57hTtTSJH3po4hdIba/qNybcoh3PRoIA8uiNWGTP?=
 =?us-ascii?Q?PslgwtAsSlNprrn7Jm2CFPAOEmK2Uw6Zq2oFs2OCfPz+irm5dzHi8RmviKID?=
 =?us-ascii?Q?mlbPmTx3nHwnEGnz4U0v/QPnvXFf4s0RnyfkiLbW9czXhOVoZOWfA3LhD+lg?=
 =?us-ascii?Q?DAstenyyMHGfgq8zzPkBj7htoS7d8De+RmJaoqexFZta0p5XraqxoLPLFoe6?=
 =?us-ascii?Q?6PFkj+1xlfslbdpIGWR94ARC+c/GinaDOg5/2lqLNQ/lXnwkQs/Rev7BPGyc?=
 =?us-ascii?Q?RMMcs+a3v0928W0ozMnMiSB60YTlHRCBp+If6I65AsnJan+B+LF9UOddTrwv?=
 =?us-ascii?Q?3zjwutG2OwtgnJA1lWS7rWNetQum9aeAk5RLJP3rvWJynzqEYKzhF24r+rr1?=
 =?us-ascii?Q?cPGEqYUmWTz82Hkq5D2WEZzl3YUGtdF2KqjHDMX9IFHu4HHcFfES6+qLSK7U?=
 =?us-ascii?Q?i63NggYlvmqI+AdWEj7pkapgemedLdrFqqH5mxpIGOJmv8ikb3AaCQdQWZaT?=
 =?us-ascii?Q?EgPyO8pR8I7I2v5mzjPh0u8+XRsDa4qNStZeryEIMYTMof/zilTeCKIEkF+2?=
 =?us-ascii?Q?1F3Uk37EYKyMwejuC4r3b4zoXEp505XUM/UoviMgJJj1hTQ9q8Br6wmSrl6W?=
 =?us-ascii?Q?Xta9aOKh6Tz7ND/eCkPbiJXEyJvKixuz8vpjYyJIz0vK4o4hWeA+b4KEL118?=
 =?us-ascii?Q?d4Hi8iT/6ivJrp6ak0dgLvNpBINjfr85/v3hdJMIkEcLQnouOM6ijZMCUOVT?=
 =?us-ascii?Q?2oDEi4hnFN2Hcce49T9fz5AffMtzbA9zsWpwkYEwSom9rdlRJXV4RuW0gBnw?=
 =?us-ascii?Q?KWcNAgkxG96ooY+kSGLY2BO0Utu2MiDS1bEiSXlZowyLcOguRmIf/gBba9+m?=
 =?us-ascii?Q?izNrfBiz23OaZeLolnMlRO0V1t0Nbsjw1DfnZ6XZ5ZwuzqCG7j0JB13vJLMJ?=
 =?us-ascii?Q?QmYG90dclE/a5nJzNq5HKufpKx/HG+ZHxeJmbzC/3WcrWc4m5q91aDxEbYJs?=
 =?us-ascii?Q?p1Vhkzxs5AnJHLwCgij0tQiGO1sTpPBKRiC/eYVlIfBFWjXqrWN3brfsFX6o?=
 =?us-ascii?Q?NSPFIx44kEk9z7XIj48+BP5LjHeg3V+5p/larUq9pPWhM9l3EJ5O4n8ZCVOX?=
 =?us-ascii?Q?dYIBdY8l06mhJqzhA/LpwmdlSErCSY2eLG4I8WTJ?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91731a82-6fa0-4d75-474b-08dd8c1505bc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB6285.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 20:40:07.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WegfZyF2a3q5KVay1P7y+ybG24L+4Hu9pH4aWBcLvUYe1OEz57C/aI52HTfXfVgS9jxNI+NOdlFCYrs181izPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9613

The buffer is set to 80 character. If a caller write more characters,
count is truncated to the max available space in "simple_write_to_buffer".
But afterwards a string terminator is written to the buffer at offset count
without boundary check. The zero termination is written OUT-OF-BOUND.

Add a check that the given buffer is smaller then the buffer to prevent.

Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate stack buffer")
Signed-off-by: Markus Burri <markus.burri@mt.com>
---
 drivers/iio/industrialio-backend.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index a43c8d1bb3d0..4a364e038449 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -155,11 +155,14 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
 	ssize_t rc;
 	int ret;
 
+	if (count >= sizeof(buf) - 1)
+		return -ENOSPC;
+
 	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
 	if (rc < 0)
 		return rc;
 
-	buf[count] = '\0';
+	buf[rc] = '\0';
 
 	ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
 

base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
-- 
2.39.5



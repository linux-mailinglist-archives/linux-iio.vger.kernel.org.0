Return-Path: <linux-iio+bounces-18924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E99C3AA5B0D
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 08:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F0C9C3E43
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 06:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F9925EFBC;
	Thu,  1 May 2025 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="wIP6HMAw"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30B0746E;
	Thu,  1 May 2025 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746081198; cv=fail; b=XF6dKuupRQLieDibJclxZtKrJmtH2QNj6qnRXhE5ZzLYaORcMnHg+QJxQ8iyZYjJcnQ5xtZr+YvlsPE9ah4P+tdncjXMypIwsE5OsM21cSx3WxCknFofZr7k7INtDtGUQTJen4Nj7J6HDGDJJq9wib7vfpXV5QTs9XNNRAf10QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746081198; c=relaxed/simple;
	bh=N9hs/MD+N9ZH9j27WQfuyZpZziipm7SYY2r8a62QrpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rM5UYYfQcx+Mzj0yJLj0erKnACjJ9Y8CAg2YPQ0c0McSd50QFYgNimV+yZdKlEjsvTeIzlP0lnhcrNOgH6iAzC5nOCf5eio+Lg35RZay0dNxrjJ9UdRHHGK+r5fNxrcepOl2TlCipZVVBuBD5ggikmpX3wlnVUhsIhadL40Wio8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=wIP6HMAw; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ph5U4dDc19LXsWgkENgDyiGT4HgRpLUqaZDvlUmSmyxH3Flk5NBOESBiVNhjv8Nb69nYjNWEoYxVZAFH/87oF4M9x7z/J8w8YeEG29VQMSjcKdLgF77y9a3yrmiBHpQOWKaD1pXFstXICSb8ekPGcW5hKWjSEXP862u52I9KRUy4F/ihhDr1TRBuMJg/h8iKM2MA2N5CETcuH0p3wY9kg1M6kJL9eh/60IA/ge9S8z6xokSopRipVJ+/0kKrvJQm7X2PyEnpMuoUYeuRDy/l/lHYbl6IUKTHah56eOgi184OVSfDfHKHpO4TpiuMPktzFno6FkQ21NnWcdNO8Sq6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHU8HZnqAgFAYqATd9B+8zt82ZGVUbrmbRPgOgJugAU=;
 b=xIO10t7qftR5PoCaqnN2RREetwJxSzKQ1phqoxmkoH16LAgLuJTMdnMewXWmEFqpjA5u3DAt9kMOKSR8Fw62AF5RCUy5UiK7Ukit0yIAP9TPCxY0bYXb6zxip2DlJf+Fhx88AASN8SaSmuz4Gv8eimQo2sDVBG8Llag5Te9NeNDMe9o7d0wUwT44aDIBDQls7MWJJmc3Clcl+D01Lagb5wQIA31gT8OUh60x07AKho7d4ZLWD/c7QAjaOiUnzXdtw/sB18c+IS7iG8bZQA4E4/Yhe73G7D+Qu6wHIQMfS36nfRV3hK20Oc8vu1yqJ0wMhAJZTRAVNWxmY3kZfunSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHU8HZnqAgFAYqATd9B+8zt82ZGVUbrmbRPgOgJugAU=;
 b=wIP6HMAwq9gVY1qs5EPoif62+b4Bf52Q3oYPYHPyyf/bBbr4g8MLayU0r8hyaXUWoLf5HfSTIcAhTTs84lADK33CDbyKGzW80DfFu81lU0Q8IjgJM4OoPDFd7ReQnYmdcv5gaxccGvZNHi4koztbEB5tp42JasUy63PkFFjUvK2m7X0ZXuVuCPqr59o8thzcU2zQfpnqz2j9MxNd9xIbtqhFMJsY8tYQAblLO2Vt7WsSQIGaoyOrsOCqjb7HT2mot+wqgpleFr5Ycevs5uIQmr+g0IUJ9lKhsYc1GNJ8MHg+IRrw1pnlQR8xAjj1WHj6qMYx6kDa3I69uIbGQe8IDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from VI1PR03MB6285.eurprd03.prod.outlook.com (2603:10a6:800:137::14)
 by DU0PR03MB9590.eurprd03.prod.outlook.com (2603:10a6:10:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Thu, 1 May
 2025 06:33:12 +0000
Received: from VI1PR03MB6285.eurprd03.prod.outlook.com
 ([fe80::e290:ebac:cbe4:198a]) by VI1PR03MB6285.eurprd03.prod.outlook.com
 ([fe80::e290:ebac:cbe4:198a%6]) with mapi id 15.20.8699.021; Thu, 1 May 2025
 06:33:11 +0000
From: Markus Burri <markus.burri@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Markus Burri <markus.burri@mt.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Markus Burri <markus.burri@bbv.ch>
Subject: [PATCH v1] iio: backend: fix out-of-bound write
Date: Thu,  1 May 2025 08:32:40 +0200
Message-Id: <20250501063240.25295-1-markus.burri@mt.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0009.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::6)
 To VI1PR03MB6285.eurprd03.prod.outlook.com (2603:10a6:800:137::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB6285:EE_|DU0PR03MB9590:EE_
X-MS-Office365-Filtering-Correlation-Id: cb004e7a-2b37-4b80-8e9a-08dd887a0b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c5T3SZx2W9R98iFLhC5M6m0A4fMuqt+jY98Ns2l1zJurr3ixzhka89cMkM4V?=
 =?us-ascii?Q?1KKaay4FlMbOdLnWx1EHFc7CToyFGvzhOPIturpvNtV5YtaLBQ8gTn/gG2/3?=
 =?us-ascii?Q?rpOZzcS90wMTBXO4l01XP7CxDN57SmDvT+4X9cGGxiuQo2jKKTR8o6pB100y?=
 =?us-ascii?Q?1Mi0y4b0ylKd4C4r0nDAxur//lfcLXomhCTfuch6EeNUPHz6Gq1L477r0XRz?=
 =?us-ascii?Q?Xya95f2geYRGHVyn0V7hUINMUxz1y+2BPtlxM8PZTexbZkmYzW6JSnSS719+?=
 =?us-ascii?Q?vN9mJYgns0TMc+o89y9g1hXUMuEQxhX5pNFzWbWPv3naHI3UMBbPSxSbgKVB?=
 =?us-ascii?Q?+LqmgpR0aZBct1hd5CdSiVtx3zeMU1i6hSdELoYrFacoMco51RV7Lc9F7H5S?=
 =?us-ascii?Q?39KCSh6ruByP2Th+VlnwvnGC9pcOsCdkxd/deIAYhohEwZgwOHlQhV5yMytq?=
 =?us-ascii?Q?svV+0SmIxdfahy+w/03M6qKOWndG0GussOCYUNBOMD7/Nt+esEf1iNwVW6Md?=
 =?us-ascii?Q?XBTnD19rvZQ7koVn67dC7teI8Bd/2sz8RFC+ph3N4wYRigmq3haKSuJhJds+?=
 =?us-ascii?Q?Em+tj6kDOIUYDZszMhnfwCTd++iTNYw33X7XjQnQ5WqJU8zyFOcK3uPSafu3?=
 =?us-ascii?Q?fPL2ZVo52Sv2duDMyjLQZAd2AQfJ0ubGua/QfhiSa8RkVhvf1GgldiLwLqcu?=
 =?us-ascii?Q?5A+7F1ri9DhZA8MTdlhv/WP2EfvShSjNxCNVkTEqU2X9/1r2+jSsHywRGlT+?=
 =?us-ascii?Q?QNUyzRUdhfOGR8bSc4YOg2IdZ3F/3xiOr+uoPNI84sYjezESeCl8+Z8XaHMD?=
 =?us-ascii?Q?m3YFi9AAbdc8dxBanTxfrc+EEA3klG4FVv3emN1ETa1qB0IGnKjXVHKEv8Sh?=
 =?us-ascii?Q?2CyHyFJkjGqJcJflHfKrV5UZILzeJ1uz3b4K5+G/w81h+gXCbxO+sxvVCjQP?=
 =?us-ascii?Q?FA0ipq2Uh5UmnSSPQ5Dc7xeYeADndrHkAnPwmzvqiYJWCtS8NVZNnmcq808D?=
 =?us-ascii?Q?Hh1TS9btOEoWvSXjG3QVudkY+dHv0MVv3orcQ6CYR0AIdEvgQttXexI672zP?=
 =?us-ascii?Q?EeurlxyiybpYc6AZU4qHgK8RKGZB72QCNRMBB5sGuX/q/RQu0n00CoLTtz1k?=
 =?us-ascii?Q?2Fiuf+eGP1p7d6gu/TLPPJpS1yQoAIZ6E6z3psOC3S0oHqZHea1uHW54rYHP?=
 =?us-ascii?Q?cD929MyE4qdaQPvbrfRrBWcRGPfx56yYvXauFbXR0N8whPP3rKyHlGHfiZ3R?=
 =?us-ascii?Q?5KOdD5/yT5YgpQuNeeRi9Cm+hiwGGvB7UXnBH8rs23pR9KqgpFo0C4O63tpi?=
 =?us-ascii?Q?bPBOa8Q2jhdmpT3vF0+D0BYYnUTM4x89mVNl0+buYP1tjZtJYhKPjs5Q3WUH?=
 =?us-ascii?Q?xZBm+5Q5Cd6HzwCfpWU21iJ03fHOxIBtto8iWe3xVIwIG5cHfSO89xr2LazC?=
 =?us-ascii?Q?BO0XnZ0BLXyuA8R/omZBKN8k6IMiH6djjHDWGKHp8Mn1kRCI2imESw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB6285.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZF68gbK/63trOfK3fbj6AHw+n8QDtKESPi7FJhf2MvW4JdibAHrU4YnyiLXp?=
 =?us-ascii?Q?vNAoY/ou+Mbf2vznck+v/z+M9qDk5dCvVriNRwZFU2YuzeXKP03FCvj1CXQD?=
 =?us-ascii?Q?0JmTDAz0+6e1lAFL2205FNcXJCSH201NW8uZMxv+aUxQXaDWCNkhKtANtLD/?=
 =?us-ascii?Q?TG7JwqaRIjDIfTrlI4LD/LVk1dHN/gJ26A7AfRaJRwOcUpGZpU01+1KJ9iIN?=
 =?us-ascii?Q?ZY+m27QZhEn8wmu975Ios6s5MoS0TimudI9uphr95FZhd57y200w1jL+XsMK?=
 =?us-ascii?Q?ZRzmkFvjs9InP2fHDpH+pHyS7/s62x7rcHx0GbIdPK/ilk/vDndVd/cvG2IT?=
 =?us-ascii?Q?JPH4zJnytJMPwHdx3kr0mTtBwRfKPM82ujoTh3ZVKFXnskuJlBpeMoCuka72?=
 =?us-ascii?Q?xrhx1+yDcdCPzMSkXw3QWkjf8aGchxu1Gj9HoGXVl1ZWg0cKRC3AQsCYBzAl?=
 =?us-ascii?Q?3uwz+O6flmK/9ibmdeccssx0FUyTNXh+wok32vr21ZZrelFIWrsfvHp6/ao1?=
 =?us-ascii?Q?3cMCaEY+AGLSrQ9HLz8C/zFeDSYV5pMaICZ27grh8ZnBu6FYsQVOrnH6cUh9?=
 =?us-ascii?Q?3eg59PtRY3Mujn0soYYhWuBr56zWVrlp8lIfMWzjHWruBVWBz8US2IGZFfGE?=
 =?us-ascii?Q?xnic3765qqIqcdF+8rORdALIMCi0JBzdmthgbpGT+n40XHJvL//nssl2csZ5?=
 =?us-ascii?Q?BXr5SaQYTzUWekLP82lTRON1lmXPuwrrih7QFmFoa7ys92ZCHu7vAEWGbdZ1?=
 =?us-ascii?Q?L2YzwvA6CG1pZ16BYVOy3Qn6FtWFIo8MTmKBbZW0L4/NJTexu+b1C5sdgBM3?=
 =?us-ascii?Q?bHhobTJD7UVzMp+37H68Y4QDpENPZAPTqQgNZnvEsl7b+0c6RnW2Ete9L8df?=
 =?us-ascii?Q?3OZdGv97FWrWMJsQ3s80kZG/3jNxCqXpitgUncbWjid22oLWDmn7JAU3LdHt?=
 =?us-ascii?Q?0Fd6E33xo8zyVGmS5cnzWHGt0QnMT9d4DY3KLCAb3KcjxIMAp8PRKKOqhGhz?=
 =?us-ascii?Q?fI2/dY0g3VH/lIs84SErzoaJ14X9mcuKQC1ZnhuIe6vniAUsyvdHyruyvmrD?=
 =?us-ascii?Q?JHCJiPy5q8QthxONSQUOBzc1Kl+okuzLLfVB4zpMiLg92g56YDxD/pl+k95P?=
 =?us-ascii?Q?zV8D/fPk5cPGP7s1rZzqetrpkBdWXMyRkrS1apqoCOgbg5W60ufyeqQ5pKo/?=
 =?us-ascii?Q?f7mZLujLfF+Ts3X8x1kYlJXLxysQ+imqzoRCK02YWvSXWdJeKvWQc8mPpGLQ?=
 =?us-ascii?Q?+1n0kM8RIUW5mQKzH1OXWDiwMHxbQEGMdH5QJiIk4LeSE3xCDcTA7+Ye1bCS?=
 =?us-ascii?Q?0qaOomupEejZWjxQxWT3rIL87B8MaAzOqWPJFozEish/UmJAGQ+NdQwZY+hb?=
 =?us-ascii?Q?CN45CvXeMXXk7K44m6kJn68K4rkSRF8wXd+Kce7Zo5KJn25nZsNR95krMfYX?=
 =?us-ascii?Q?oOIK0+x4oK/Z5xMNrmNapHPn8wDJZFCW5zmmA7oPvmE5JNLMp5QV0ap8oyej?=
 =?us-ascii?Q?8NJFmSLU4/RmNHNoisvirnQHh8RhMX9+DwFKF0zsK38t5L/rfU18kgOiBFjI?=
 =?us-ascii?Q?TBCSrLPFuXCNpiK0a2ZfRX72UqluyoJJM2Mn4UwR?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb004e7a-2b37-4b80-8e9a-08dd887a0b50
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB6285.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 06:33:11.5097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDyUIC/B4tFOg/1Sn2bSmD+y30PtVt6aOaIGQG/DoEEV0oBgK0D58RJtjAyo/Ks66AwCySZwt41jZATRZDHgZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9590

The buffer is set to 80 character. If a caller write more characters,
count is truncated to the max available space in "simple_write_to_buffer".
But afterwards a string terminator is written to the buffer at offset count
without boundary check. The zero termination is written OUT-OF-BOUND.

Add a check that the given buffer is smaller then the buffer to prevent.

Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate stack buffer")
Signed-off-by: Markus Burri <markus.burri@mt.com>
---
 drivers/iio/industrialio-backend.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index a43c8d1bb3d0..3878bd698c98 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -155,6 +155,9 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
 	ssize_t rc;
 	int ret;
 
+	if (count >= sizeof(buf))
+		return -ENOSPC;
+
 	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
 	if (rc < 0)
 		return rc;

base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
-- 
2.39.5



Return-Path: <linux-iio+bounces-5647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5E8D774A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 19:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66792815E4
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0BD4D5A5;
	Sun,  2 Jun 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HMRx2tXQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2087.outbound.protection.outlook.com [40.92.75.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C225A0E0;
	Sun,  2 Jun 2024 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717349056; cv=fail; b=JjtJlSS0bSX2DRAngyfDEE+1dN/qKbwj0IbIUHd5/nachhl9kigyHeuHjMcfjqUpdC65wJQ8653oTMmsq/UkL/s043QjmezVC5bYfk3PKV5TNscqrxrCpCL+mieMbcQgUbLF/AAfNSFA/Q+bN7E1onWxkHaSP1G8GQuplbU7l+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717349056; c=relaxed/simple;
	bh=o1UyOYCbORytrrgw+p8KenbRmSZKV8PI+EnUyM217bI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HObMmEPxkc+sRDPJDB8a6yUDjtHA42PmBfI+itvuDy1EnilEbB/cxpn8TqsslgL4g43brfzcA3nVMh5c6/KbvPUb2MmsGrMU1RSi8dLvHshkfch/4LxQW0G1pKD6QgaSIbI4tGKNN86AVgpW1n2qcfBs6itKFCZEmA85YXo3Oug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HMRx2tXQ; arc=fail smtp.client-ip=40.92.75.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRFd6ycxgQ3DPxU5ZoE/Hc9dekubzHDEGx4tyssuFxX8W4iKnt6UiEX1OV+a7DLOsm0hoDyrYeiDBTw7M4qKERURRd/ASvN1z8xGkhMkegtTlZ/qcDhZxtFQdQURd1tpJzzLRxtwsZ+U7mFXbZvEGt2OR9QFx2VI16F8Hegb9O2KGUfNI/wkcdMqGlxqf98Dbd1UGhNPlYQ7JGhF14sXL8//FOgmwgW5/ZDwgTF+EsugAmyvkfjzqMVyqMaAPkLc6eFtSpfgmToDJ/TFuM0coBwXMBbT7roJ7mVBpptNoZD3TxK3PHSTSjQdf634aLVDVnzwXK0L8qBCwUMWzfHIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoOXGdJnDbcyQzy1mLNWBguXK972w4ufsNfdQLdD+rA=;
 b=kYayAneapvVqAbTwMTej3E7FA4R25fdkCArtq5kMLte2B/fooOmawEa0mKuVesDEqq0ZWEnFlBlUYFUinrHtPbgGWgzqn/YQOLUf7H6cWF33OtQ9oQnFwttom5EUDw4PKh+Go77gWd4sPuh7f2z3Hi1NucOVEwPmYOCklpRJFF1wRpsCpetMpgJmAMtz9tT6LXdKwyZBo2g6Yq2un50jQZXsTUStk2w3dsyTWARX6/UMc9ef5+TlKepo1rsyGuUtVqZ417jmiCoc+HQOkLq428gqkVKvphNaKb1kBsxSD2k1CGQxPNZr+40qI4AvinMvCl42eBOKnPWa8GBOmVw3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoOXGdJnDbcyQzy1mLNWBguXK972w4ufsNfdQLdD+rA=;
 b=HMRx2tXQXdjPO/WBEWenM4Xa70B2LT16nG5Wg2fiHjVkArbf1N0YGM5hB/YI8oBot0nwTMipYq53aQk6z/+iXPLP7v3uGoHAqWcjQZcA6U71F55Ns1dClXv0O+ItWHWZM6+DGqyMbXeqjy3RH/3InuvEfxtN1UFJQRah93VsMxL5L2NN132dPwyZznKmw/FYFV8uGfAJVkb0N2ka0nubyiupx4/NVe15/ZpTGxQM+K/2sk0B0CFTm47rKoTa89/m/V5FFWo/HRXoD6uDR+qKPxbQDoCD8phaAFqjKrYjjuPNcmopdEc4Mdhpz1FhGmqe5xwlMfD8uX0tNzjKJlqOww==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AS8PR02MB6872.eurprd02.prod.outlook.com (2603:10a6:20b:255::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Sun, 2 Jun
 2024 17:24:11 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 17:24:11 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] iio: event: use sizeof(*pointer) instead of sizeof(type)
Date: Sun,  2 Jun 2024 19:23:54 +0200
Message-ID:
 <AS8PR02MB7237D024459C314CECE72EAF8BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [2Gh4QwnW7K3cdB+Q6ceNdfyHrZSWlBVY]
X-ClientProxiedBy: MA3P292CA0013.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::6) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240602172354.11432-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AS8PR02MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2c5dce-4729-4664-c0e0-08dc8328d145
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	QW3BewbwJ4MoffCr2GE6IwAs3JPUkE3mkb29ErF7bo7r07oIk8ObBQXB8Kl9b1JX/T6mK32lyCJ0CvkIHgUW14XE6hfnaJyTsRMPaz/NxH9k3RhiW22gCKNC6fl/V1im0OkFQMerGbipjSUFZ/cTDuBFOfHOva+InvCG39FM7Y9NGmsFMZXYUSd8PJTSNBiOslwQ6A675YmHwpKLJNGLQbibE9nUb+oid21oBRb42cVSlMFO0e+jE5x5L8W79jvshwv66GOudHGVG/NiLpP36EHGuvMV/0Y9sklXgwlbmoADEQaupZbOVcNR7w1kMd8BtK/7uU8V6sJbjhBSynToBo9vufX0Q9ZFtt5Knt1i60yFe55299+P4P0p5kWb3jkeVWfNUifuO5c/JzpLWF2PtCTXXsSadlpRxFcEiWd+PoGAWoN2guuopd3TUGA3tIi34U9kkN0+dQ5FYwbbONK9iRsy5DUUqQr0i2wyTpptRoKKB/qBsx7vLXnuosyUZOigfcm3SY+SARfAF/x+aAJcZ8k0MQBS8iLvLRwWnPgVM4/dKhKQOnkFaowGPta3SGlVjCLv9GmvTQ/QQrVOUScyn4FMnTQhyDwVFTSThzueeXjwWH4XYjgRWF8dtAnunB4/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lmP4tPeBufkcPwQbDDRp0c0JA103gT4nz8oqBdt9MjGDoiCVLfK3XMgcqT4a?=
 =?us-ascii?Q?l2kk+7gQwel8qVTFfHDnXccu2De8sJJvuN0jYV7iyHzeux84Y0uU6mlUfFll?=
 =?us-ascii?Q?gActYym/ox5ukSNJ5UInNmA4fwM5iCE31Vdc0dXYxcKVfvi80ZYCbBvISHgU?=
 =?us-ascii?Q?UZom079v+PPt+dXZMXFuMb4Ey1/lYVrItgZnlbwbQiKcKK7D9/wlqkBaaoKR?=
 =?us-ascii?Q?0HIvVjO7XqP97dfKn46ssXiXtVJYi234JmDbivtsB44XghpOwAD4Qe6P8vGT?=
 =?us-ascii?Q?AJUhwuXckFrsOk1TH5KmyS3StEPuW+5V9g3QDhss5VrPYnVekDLeB2624whd?=
 =?us-ascii?Q?fu1HXW8CWItHl6jn8ca9VrtzToa9njNWwMouuaYKBeALvl/zaVELTmFmPex6?=
 =?us-ascii?Q?qLq4mYmbUjYTZvgQnUFDc+joxmsL/m8ax1QanCOGRQs/dRL/PNQfGD0Nt1ge?=
 =?us-ascii?Q?Ob3EaThln0K5INag8PLKnvUfLulIUH008qPhQ/eFOeatjrEy02/eZ/e1z1wx?=
 =?us-ascii?Q?qEDCZX7FTNNn3dTQBrNyBn9ANVnhUnLyizVEfhR8o75R4te/aI0kkQLLfuEg?=
 =?us-ascii?Q?6P1lF6yGJaWh4CLcB3QTtoTK8ARyDdP8x/s8eWLJvpgOBB5cyyLAeehb9Wjy?=
 =?us-ascii?Q?04VQ1vxQDJF+QmTZw1scdV+qibMuuS1r/U3ojARQ74UY9Tf26YB7A56UI4gq?=
 =?us-ascii?Q?kUgzW2OvVl2Y3zUJ2T4nCPmViGzs4OL2Frr6jKDasYFhFgTx/s6nDnmegIkn?=
 =?us-ascii?Q?J2cLzvXoAKQcnWnTvr6CCtqf18XGJhW8seyN+TZjgvfRfdr+sYkf5g/P9ra2?=
 =?us-ascii?Q?0izPjGQu7qMHNae0BEXmZ/cs0QsQNyUdpxpYecEa9gUQxA19j+rudaEBfl/q?=
 =?us-ascii?Q?uCh6JCy/NU1hrrEAH8RQ436fr39Uf/Q0DyZ5e37g0Ofd4fPK1YecC81K3Xh2?=
 =?us-ascii?Q?MWGPmxJ9w0MdM+Ns2zf9Clj4K8pTWC+tVJAso37VtNzCTfw3+aRVz5CL3qZK?=
 =?us-ascii?Q?IGgUGcZzSedbTV7t8nr19aGf8xKBcGtp+dga3wr/xori28WNXK1aIOH9B8I0?=
 =?us-ascii?Q?PnlcrG4t/1E6qfWwRWzcbMVGm7eL5lXiltn1DyShVXuW8RThRrngJZjqVDD4?=
 =?us-ascii?Q?rk1EUzfoP2A55J/Apvye//58jFQJTAUfH8ne9Q0MguunS4grjHoFvOS2iD6n?=
 =?us-ascii?Q?K2aegIdYdcwGhmLImFlRnk1bq3/6pyJA8dYgs55vXf7uPNEcAKJZjy3x0dwH?=
 =?us-ascii?Q?zVbUH52KmmB/KV8d80Dt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2c5dce-4729-4664-c0e0-08dc8328d145
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 17:24:11.4895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6872

It is preferred to use sizeof(*pointer) instead of sizeof(type)
due to the type of the variable can change and one needs not
change the former (unlike the latter). At the same time refactor
the NULL comparison.

This patch has no effect on runtime behavior.

Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 drivers/iio/industrialio-event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 910c1f14abd5..b99bfeff7d37 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -572,8 +572,8 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
 	      iio_check_for_dynamic_events(indio_dev)))
 		return 0;
 
-	ev_int = kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
-	if (ev_int == NULL)
+	ev_int = kzalloc(sizeof(*ev_int), GFP_KERNEL);
+	if (!ev_int)
 		return -ENOMEM;
 
 	iio_dev_opaque->event_interface = ev_int;
-- 
2.25.1



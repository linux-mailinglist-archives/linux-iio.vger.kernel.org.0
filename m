Return-Path: <linux-iio+bounces-2341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF73C84F8D3
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 16:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FA58B21210
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EA374E28;
	Fri,  9 Feb 2024 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qo6fDSoT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BAD1E504
	for <linux-iio@vger.kernel.org>; Fri,  9 Feb 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493695; cv=none; b=FAGxt+oNaWToeSAicX7OfGvZaPigaijjnJVgu2yiwxTf88shy4ZlLjTCOHm8FVsE7kRB+BJbByVxMJZZ7YDY2dWV7sowB1WR1gtFqxm7kfpMIriOdDbvcfUB1yzfO70Zvc+ikwRarQ7NQPeKDrYJVMhraEChQXbqW6RGh3YkHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493695; c=relaxed/simple;
	bh=z8TpMjyTgCknLwIHSWKLJoLmG6PLvch8Xeh7Wl5+83c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=C0zvRvFLtuyFW44BlT+QNqwAgnARVzjZkRl44o7N1EknpdRQzhpGWu2aqTwX2qWhjgyZ0HpWm/lKXMEj0DxdLz3bkqHtzK0JUVizODmFr/HDSEKZUqbzlgucuis8/LxDyC9Vu+Zu866H3rjJs/1irrYAJLyWzYrSYZiiRNZpa28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qo6fDSoT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419E0apc013498;
	Fri, 9 Feb 2024 10:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=DKIM; bh=qi+vcmQe
	fthaR6fESRj3JWgAt8cDsdD6DM9zfoyWvRo=; b=qo6fDSoTRmtpLk8ngHILLWcc
	DAj5DKqmJl7eiUAbmUS9fYnAMVlrNeGpUxlOyxGPvO6gVK/k9LQhwIx3sOV+YTqk
	mSEXCfPSqWybUZE+PtKeSodr4ZpyHg9GDk5iuhSbF4DASnsH+FwtwlghNn1Oj2Rh
	9ttcXRLJHUtCY4i/rRepshfkQAnR/jNZHPuI3xaBDtXRdmLGrIw6flt1iWJc7VMB
	r3njVrUmpnuqy3VYf0PF8F2sVnTj86NeVO9H2FN62bVHJTfCYXqZqmbcEm5UiokY
	ExOkgiIU7qxD1HzuCNNIgC1Xrivc8QmRTj/WjWybDoeGktbAqK53HNvsjdShXw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w53423rch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 10:48:07 -0500 (EST)
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 419FjnlS012238;
	Fri, 9 Feb 2024 10:48:07 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w53423rcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 10:48:07 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 419Fm6IO022697
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 10:48:06 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 Feb 2024
 10:48:05 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 Feb 2024 10:48:05 -0500
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 419FluOY013950;
	Fri, 9 Feb 2024 10:47:58 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 9 Feb 2024 16:50:34 +0100
Subject: [PATCH v2] counter: fix privdata alignment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240209-counter-align-fix-v2-1-5777ea0a2722@analog.com>
X-B4-Tracking: v=1; b=H4sIAMlJxmUC/x2MWwqAIBAAryL73YJY2OMq0YfZWguhoRVBePekz
 xmYeSFRZEowiBci3Zw4+AKqEmA341dCXgqDkqqRSvZow+VPimh2Xj06flC7ue76RhvXOijdEan
 o/zlOOX8S8GF6YwAAAA==
To: <linux-iio@vger.kernel.org>
CC: William Breathitt Gray <william.gray@linaro.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707493876; l=1732;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=z8TpMjyTgCknLwIHSWKLJoLmG6PLvch8Xeh7Wl5+83c=;
 b=ZqaFSq4iMxDoNo/0h11zw9y4InFyGcnW1CYZs0RbiKMN0iqAhC4Nly8gcBJVeeIYW605vAO3f
 toAbwkE75ZYCwX2ndjwHL/4NySWPRE1q5iYwekbvkrhGJHgUbXZWPSE
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: FQWlNH6NCkI9MVXRXNIXJbmp76Bz9PKR
X-Proofpoint-ORIG-GUID: LJX_D0Fu6jOFg5A6D4TJ5HweMfBgxd3c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_13,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090116

Aligning to the L1 cache does not guarantee the same alignment as
kmallocing an object [1]. Furthermore, in some platforms, that
alignment is not sufficient for DMA safety (in case someone wants
to have a DMA safe buffer in privdata) [2].

Sometime ago, we had the same fixes in IIO.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/devres.c#n35
[2]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kernel.org/

Fixes: c18e2760308e ("counter: Provide alternative counter registration functions")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
Changes in v2:
 * Fixed typo in commit message;
 * Updated the comment block above privdata.
---
 drivers/counter/counter-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 09c77afb33ca..3f24481fc04a 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -31,10 +31,11 @@ struct counter_device_allochelper {
 	struct counter_device counter;
 
 	/*
-	 * This is cache line aligned to ensure private data behaves like if it
-	 * were kmalloced separately.
+	 * This ensures private data behaves like if it were kmalloced
+	 * separately. Also ensures the minimum alignment for safe DMA
+	 * operations (which may or may not mean cache alignment).
 	 */
-	unsigned long privdata[] ____cacheline_aligned;
+	unsigned long privdata[] __aligned(ARCH_DMA_MINALIGN);
 };
 
 static void counter_device_release(struct device *dev)

---
base-commit: 81e8e40ea16329914f78ca1f454d04f570540ca8
change-id: 20240209-counter-align-fix-6fb38946af7f
--

Thanks!
- Nuno Sá



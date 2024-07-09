Return-Path: <linux-iio+bounces-7461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6521392B639
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 13:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F141C21AD8
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 11:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C191581E4;
	Tue,  9 Jul 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pWXyu4Af"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B2157A72
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523494; cv=none; b=g65PQw7MZgjCstvsAAJmbw+ymXdNlUR8asl1JrpE3rv6ZUUUX9sh6YLX7vW6tg9gMxH+dGzDpQfVL00OMIkei8MnJlNNudmPsu6h3mU40yjkrjXtiCgq5wGH4UAjbvtc9fgcB2Sg2HvW74jibOnCXZgVJFuc53bQyhifaoko8Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523494; c=relaxed/simple;
	bh=JmEnLymVEakXYCG8Gu6w27A4qKIHmUWngZwraQwLMbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CEvVAzH+67bD/KoMyFymYedm7udhPF0wMlPnq6S/xkS/pD789Moowkn+9mny9e9aVgf1c4vMTqIFe4YFOqVpVaeg/AlOXj9kVvoepoWJTXP9dmE6o6VJBbR3dUHV3ybpFitUEZ8f9QgucuOZs8MJRi800mgIETsWNhDW4vSmjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pWXyu4Af; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4696xnpm029771;
	Tue, 9 Jul 2024 07:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tFIuN
	vtrfGIkOVFgIf2UnJhYV/kpeSig03oC4Onw/rI=; b=pWXyu4Af/l2Z9ODo2l+03
	zUISM0NMTD1lQBAr1B90WoSzlmcnuNqxguVpfIKcXCCqsSB8sWFkznsm4y4acZQw
	XNwP/8YWx+XpsnlF0Pee9ZpcO/+hP0tk5ZPR+uYAKKlrHPW7QXmWmIVWLs18xFni
	Gu1RdGQ6I1FnH71lHdHrmkCE4GgihAdGfHa21ZDfCRRaP2x+40NuhwlHGDHKWz0j
	sP1IZlXdaq+mvjkadUSqoPBLqizV1azAW6VnnjoXnqHYwVuYL1UF0Ve9DZNvRpNU
	278QVPWg6GWlG4k2K7IUqaXvzB7O2UzLQEJdJWPvXN+pQFzrY/HdDGfOZEsmFhQk
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 408fy440yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 07:11:04 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 469BB3WL046281
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 07:11:03 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 9 Jul 2024 07:11:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 9 Jul 2024 07:11:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 9 Jul 2024 07:11:02 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 469BAlgn032387;
	Tue, 9 Jul 2024 07:10:57 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 9 Jul 2024 13:14:31 +0200
Subject: [PATCH 4/9] iio: backend: add a modified prbs23 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-dev-iio-backend-add-debugfs-v1-4-fb4b8f2373c7@analog.com>
References: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
In-Reply-To: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Olivier
 Moysan" <olivier.moysan@foss.st.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720523682; l=666;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JmEnLymVEakXYCG8Gu6w27A4qKIHmUWngZwraQwLMbM=;
 b=tFCIN1dUJOoDnP/jpU6e7rP0EEIV3LkHdb/I+yQ4hw4sj9dNbhLImvxsr9gYDoRM2LOsWX6Wx
 gePism3w9jkDibJehPmWJb9mRc/PQNSzRfumL+dHr58AuMn0vA0vZpS
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: peAsANirFbniL4836hT326w9WHdqFn1j
X-Proofpoint-ORIG-GUID: peAsANirFbniL4836hT326w9WHdqFn1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=567
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090077

Support ADI specific prb23 sequence that can be used both for
calibrating or debugging digital interfaces.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 include/linux/iio/backend.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index a643d86c7487..7cdcab6ded66 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -57,6 +57,8 @@ enum iio_backend_test_pattern {
 	IIO_BACKEND_NO_TEST_PATTERN,
 	/* modified prbs9 */
 	IIO_BACKEND_ADI_PRBS_9A = 32,
+	/* modified prbs23 */
+	IIO_BACKEND_ADI_PRBS_23A,
 	IIO_BACKEND_TEST_PATTERN_MAX
 };
 

-- 
2.45.2



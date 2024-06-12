Return-Path: <linux-iio+bounces-6212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB3B9054EE
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 16:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 843F7B243E8
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 14:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5DF17E91D;
	Wed, 12 Jun 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fa/7c4+6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455FB17E915
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201854; cv=none; b=WzL4s5B2bkMlhCdyyWCOIoLqLO3GGewFuNCShisZ5CWniMBe8UaVYv2AL5Y7O6cjmBfpim/BioIy03sFd59zEnAy2izICuDuznIIqBSvAigolx1eaToKKvSVx9waD8fBGScFTZNjscr0uIPHhqSYpu1jx2EhpS/93Cnz+NnnXx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201854; c=relaxed/simple;
	bh=3F6OnbBb0AIU0NcJf3ocuW0qrtTru+HnRObdH34cHE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bcQxg28WJ3VGGfjVnD5LF9wYJXu9Jein1/EgoE7/xXryMEM+QNNE3/vCMj97CbOYQaNZNT4/dLwx5Pn8iaTYBOUk1XhkJccOXcr7oGSoQLcn4W77zlbcBz8PlqUzfaz6qeFzs8TJ2t95+LfNLRL6YJLWMp9B2syCLWWjE/jTFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fa/7c4+6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CB0hgF012438;
	Wed, 12 Jun 2024 10:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5HKi8
	nLro6cTmVwKLwDFViJTkuqueWrVIkQI6B0561E=; b=fa/7c4+66FFq521Nun/nN
	0qLJV5ONtlTiRj1i+UXs2vlqonP5IHoetRJJLmy3Np6aQ3MrrEWVpGI6AEmeqOnG
	RBiE3jW3cgY34XG/LtDYXvUoByO+hqYv3udAOAk9BZ1kgoyeDbpwGkwBkavfaRnq
	yiTE7UOBUiutlboe2DOlyhW7LZQIgSJXu/CKaRw7F9S71LZKHEFkOFW/JLW9WUL7
	CYUTpiFaPZGxwEvcvTiEY/MB4nKL/3JW0dBv0LFVwNvyl519gUyFKKx08N5gjEs1
	6ftkqbI7TP7GdGp3Bhn6ch2skLPFIufGI2d8wN3t9RqG/ZIgcgJumgbfNldjF8+9
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yprwjv5y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 10:17:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45CEHHGS054191
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 10:17:17 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Jun 2024 10:17:16 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 12 Jun 2024 10:17:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Jun 2024 10:17:16 -0400
Received: from [127.0.0.1] ([10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45CEH4Aw027005;
	Wed, 12 Jun 2024 10:17:10 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 12 Jun 2024 16:20:49 +0200
Subject: [PATCH RFC 2/3] iio: imu: adis16475: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-dev-iio-scan-private-v1-2-7c75c8e3d30b@analog.com>
References: <20240612-dev-iio-scan-private-v1-0-7c75c8e3d30b@analog.com>
In-Reply-To: <20240612-dev-iio-scan-private-v1-0-7c75c8e3d30b@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718202053; l=783;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3F6OnbBb0AIU0NcJf3ocuW0qrtTru+HnRObdH34cHE8=;
 b=dzc3i4lMtv1X2oKZexGBNaT9vNW6SYwALsKzKJQ35kDtIJ3HBuPyMHPwmstDK69mSd1QDOxBi
 yuvftx6DoMZBkSPimqG2dcYYlZfffgmFhQMLdbZ+gknlYhNG7D8uCiq
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 0tH8Bsph-puLdxb6y8V2U4vFzaRVjNbM
X-Proofpoint-ORIG-GUID: 0tH8Bsph-puLdxb6y8V2U4vFzaRVjNbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=715 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120101

Use the new IIO accessor for iterating over the active channels.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16475.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index cf73c6f46c79..1cc2a66a78ff 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1608,8 +1608,7 @@ static int adis16475_push_single_sample(struct iio_poll_func *pf)
 		return -EINVAL;
 	}
 
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		/*
 		 * When burst mode is used, system flags is the first data
 		 * channel in the sequence, but the scan index is 7.

-- 
2.45.2



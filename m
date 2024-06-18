Return-Path: <linux-iio+bounces-6480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0B690D32B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B38B6B2981C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D7514BF86;
	Tue, 18 Jun 2024 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ft0BfAOE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B04149E1D
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717332; cv=none; b=qYQnbZeNiL96gSqHbJN3yuZdgR9FxgsgscADc44+dWGWQB/8Qmqv5Pw7u5gJGnTaejuwR9jDqd7JNG57u2hROrWX3LQQ0O8dr7+dcA6GNsK60KuOB20jkmN0nKHFPN6JdoG1m4TKGk2e2qRyDzJmVL+r3xLw/98N8EaPeQuoh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717332; c=relaxed/simple;
	bh=NXCEuesAxD61/Cj+BxV5P6vSUV/s+WfS0Pf4grK7Z1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Bt9aHfutYiGXxVXJr5lFsmvdP5EVec0ZFOSBFtLdIdldN8uN98aArD8kmWB8ki+2ro4PGCxk5IXN0Cwk1pW+/36inTljo4qX5dkokpXOwjxVnqdCoBEYSpWVeZkb2GPjsBUIAaPwdxScK7x4sE6qCr6/F2ib4CmwMLqelEAQPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ft0BfAOE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ID4J3g007182;
	Tue, 18 Jun 2024 09:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rUHSd
	P+O6aaeaSqfmtw3+7o6aGHA6ocFsIzOIs7aJmM=; b=ft0BfAOEssOUqV6tOfoC+
	jDtm5tRM3XyfRujo2yHiS6NMnynKMFe6elrYAamdToygpvTYtcfkUoEtBA57OZhS
	uz0K40Ub2qLwWrNxF7YGM5RR6eiw4/HtAoUXC2d5ATPwLVoZD7+k3nqAltWERJ4K
	kIzn2txnmOWFwT5hbL7b0+SgeUkn9XfBFErrKktFY4cgKhrecVg1eg73/6jAqBuz
	V7VG0JBGIubcfrwzVcbKVCa1t1oakPDPlbCL/fbCM6JZj5P0sQFbHZrO+rLv4iXq
	UNkKbyWbnAWZXibK6/x7oI64raJ/OOXESj+jMMA4tUD+9u0OEGsNcTHCsjakvYCR
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ys4t33by3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:28:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45IDSaS6062009
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 09:28:36 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 18 Jun
 2024 09:28:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 09:28:35 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45IDSLWP025769;
	Tue, 18 Jun 2024 09:28:30 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 18 Jun 2024 15:32:08 +0200
Subject: [PATCH 5/9] iio: gyro: adis16260: make use of the new lock helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-dev-iio-adis-cleanup-v1-5-bd93ce7845c7@analog.com>
References: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
In-Reply-To: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718717531; l=1757;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=NXCEuesAxD61/Cj+BxV5P6vSUV/s+WfS0Pf4grK7Z1U=;
 b=0Oy6xemPdUDE6cb7NdTYdelMOAti/N+hqHEbCgltWp1iK033JoGgmWd0SJ1kmNm/mTmgmAyjp
 ql8wlUvTBn9AiOqiYhtCT6QxjQL/TLan0xOqOwO964ONOKpJ8U1QW5I
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: KzH_mv5RI_Ney4a0YekI27-P1vTMVu-C
X-Proofpoint-ORIG-GUID: KzH_mv5RI_Ney4a0YekI27-P1vTMVu-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=578 spamscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180100

Use the new auto cleanup based locks so error paths are simpler.

While at it, reduce a bit the scope of the lock as we did not needed it
protecting all the data in the switch() branch.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/gyro/adis16260.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 112d635b7dfd..495b64a27061 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -270,7 +270,6 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 {
 	struct adis16260 *adis16260 = iio_priv(indio_dev);
 	struct adis *adis = &adis16260->adis;
-	int ret;
 	u8 addr;
 	u8 t;
 
@@ -288,7 +287,6 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 		addr = adis16260_addresses[chan->scan_index][1];
 		return adis_write_reg_16(adis, addr, val);
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		adis_dev_lock(adis);
 		if (spi_get_device_id(adis->spi)->driver_data)
 			t = 256 / val;
 		else
@@ -298,15 +296,14 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 			t = ADIS16260_SMPL_PRD_DIV_MASK;
 		else if (t > 0)
 			t--;
-
-		if (t >= 0x0A)
-			adis->spi->max_speed_hz = ADIS16260_SPI_SLOW;
-		else
-			adis->spi->max_speed_hz = ADIS16260_SPI_FAST;
-		ret = __adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
-
-		adis_dev_unlock(adis);
-		return ret;
+		adis_dev_auto_scoped_lock(adis) {
+			if (t >= 0x0A)
+				adis->spi->max_speed_hz = ADIS16260_SPI_SLOW;
+			else
+				adis->spi->max_speed_hz = ADIS16260_SPI_FAST;
+			return __adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
+		}
+		unreachable();
 	}
 	return -EINVAL;
 }

-- 
2.45.2



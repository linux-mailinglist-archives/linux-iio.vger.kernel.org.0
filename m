Return-Path: <linux-iio+bounces-6484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF1890D2C9
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AE9284440
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F1814D43E;
	Tue, 18 Jun 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YDtARu0c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF526AC1
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717334; cv=none; b=mmksgkF1lQKgryaHjz9Ax2nNnLlBu+sZ7X1Z8QAjO5Z+CBPs8k4Vj2zrd7RvKL9pqUib5JosTdBz08O/HR/BjnkGoYCOy1rffcDL/DPouzCNlgLEF6lgtDNBhD1PgteA64vBWOPQMphQtbOOdOojw6dWs1OsC2mvtb0cqr/HTVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717334; c=relaxed/simple;
	bh=Q1I1AC77Y3cb8NDSHhD2lI3hMnbD7i1XWO21YelJXF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DDmkHN1c5biipfzuL0Np65VlR6FLPjjbTwVA11KcL8ayDzEGePATvEsbF5/z/m0h/2Dhq2Fv0nRYFWvqJGD0d+EdjnhDRIYLmulEuL7FDDUrCEmahEqNQUY1ev6d/A9ToDo+ktTLG7if9oEa5QY+MgrKR0n3ZoxvI9IeSZmHI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YDtARu0c; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IC3wj4003904;
	Tue, 18 Jun 2024 09:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yGJPO
	CISfz2ddBjC/8i8gny/RieMYIMdkzH1KtuZblk=; b=YDtARu0cY+lEMYkjyL85w
	0irI1NiKsUh7q6L6dNxZKOBALB7kdSfcV51Y4tPXsFeV9Wi1OYA+4lIdVYQNwFfN
	m4WP/OUvL6PomM64qBYwAQ1WEXCV0R0vPp/BLkhjjEAzw3PrBTH8w9w5R2M61Mrh
	anIBmXxm4ivWL9s9NdF8VveupL1Rsw9wkZbZ3MBr+lPKm2NOpv7p5bRbgYxHxzYa
	wYnkF3/Mqsh4c4o2xsaUGekCTTucoBd11TSitSigOFTVSxIT/6VvnDhMZlqr0sWJ
	OK5eiStELo9jC4W7CT3D2ZwqraBe4ruLoXKp32HLENlYHk8j56wGC7xC9q++VhQU
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yu9wtgb20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:28:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45IDSccY062018
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 09:28:38 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 09:28:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 09:28:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 09:28:37 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45IDSLWR025769;
	Tue, 18 Jun 2024 09:28:31 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 18 Jun 2024 15:32:10 +0200
Subject: [PATCH 7/9] iio: imu: adis16480: make use of the new lock helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-dev-iio-adis-cleanup-v1-7-bd93ce7845c7@analog.com>
References: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
In-Reply-To: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718717531; l=4526;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Q1I1AC77Y3cb8NDSHhD2lI3hMnbD7i1XWO21YelJXF0=;
 b=KZUdnO9uYgV/WdkR+uEnlBWMJtQhAJPAFcmA4aoKlZMvdtZq+e7bpbvZ06KbthcPXS6FCvVG3
 p0pfLs4PyWuCbqHeJrJWC3JihRtdoX23YPKf6Sn0Klu88z0T0wNMzLf
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Sci9cL4IrFbXON8PwiYglxmlm8p0kZQR
X-Proofpoint-GUID: Sci9cL4IrFbXON8PwiYglxmlm8p0kZQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=960 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180100

Use the new auto cleanup based locks so error paths are simpler.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16480.c | 65 +++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 56ca5a09fbbf..c59ef6f7cfd4 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -345,7 +345,7 @@ static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
 	if (t == 0)
 		return -EINVAL;
 
-	adis_dev_lock(&st->adis);
+	adis_dev_auto_lock(&st->adis);
 	/*
 	 * When using PPS mode, the input clock needs to be scaled so that we have an IMU
 	 * sample rate between (optimally) 4000 and 4250. After this, we can use the
@@ -388,7 +388,7 @@ static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
 		sync_scale = scaled_rate / st->clk_freq;
 		ret = __adis_write_reg_16(&st->adis, ADIS16495_REG_SYNC_SCALE, sync_scale);
 		if (ret)
-			goto error;
+			return ret;
 
 		sample_rate = scaled_rate;
 	}
@@ -400,10 +400,7 @@ static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
 	if (t > st->chip_info->max_dec_rate)
 		t = st->chip_info->max_dec_rate;
 
-	ret = __adis_write_reg_16(&st->adis, ADIS16480_REG_DEC_RATE, t);
-error:
-	adis_dev_unlock(&st->adis);
-	return ret;
+	return __adis_write_reg_16(&st->adis, ADIS16480_REG_DEC_RATE, t);
 }
 
 static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
@@ -413,23 +410,21 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
 	int ret;
 	unsigned int freq, sample_rate = st->clk_freq;
 
-	adis_dev_lock(&st->adis);
+	adis_dev_auto_lock(&st->adis);
 
 	if (st->clk_mode == ADIS16480_CLK_PPS) {
 		u16 sync_scale;
 
 		ret = __adis_read_reg_16(&st->adis, ADIS16495_REG_SYNC_SCALE, &sync_scale);
 		if (ret)
-			goto error;
+			return ret;
 
 		sample_rate = st->clk_freq * sync_scale;
 	}
 
 	ret = __adis_read_reg_16(&st->adis, ADIS16480_REG_DEC_RATE, &t);
 	if (ret)
-		goto error;
-
-	adis_dev_unlock(&st->adis);
+		return ret;
 
 	freq = DIV_ROUND_CLOSEST(sample_rate, (t + 1));
 
@@ -437,9 +432,6 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
 	*val2 = (freq % 1000) * 1000;
 
 	return IIO_VAL_INT_PLUS_MICRO;
-error:
-	adis_dev_unlock(&st->adis);
-	return ret;
 }
 
 enum {
@@ -630,11 +622,11 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 	offset = ad16480_filter_data[chan->scan_index][1];
 	enable_mask = BIT(offset + 2);
 
-	adis_dev_lock(&st->adis);
+	adis_dev_auto_lock(&st->adis);
 
 	ret = __adis_read_reg_16(&st->adis, reg, &val);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	if (freq == 0) {
 		val &= ~enable_mask;
@@ -656,11 +648,7 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 		val |= enable_mask;
 	}
 
-	ret = __adis_write_reg_16(&st->adis, reg, val);
-out_unlock:
-	adis_dev_unlock(&st->adis);
-
-	return ret;
+	return __adis_write_reg_16(&st->adis, reg, val);
 }
 
 static int adis16480_read_raw(struct iio_dev *indio_dev,
@@ -1355,29 +1343,26 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 	u32 crc;
 	bool valid;
 
-	adis_dev_lock(adis);
-	if (adis->current_page != 0) {
-		adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
-		adis->tx[1] = 0;
-		ret = spi_write(adis->spi, adis->tx, 2);
-		if (ret) {
-			dev_err(dev, "Failed to change device page: %d\n", ret);
-			adis_dev_unlock(adis);
-			goto irq_done;
+	adis_dev_auto_scoped_lock(adis) {
+		if (adis->current_page != 0) {
+			adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
+			adis->tx[1] = 0;
+			ret = spi_write(adis->spi, adis->tx, 2);
+			if (ret) {
+				dev_err(dev, "Failed to change device page: %d\n", ret);
+				goto irq_done;
+			}
+
+			adis->current_page = 0;
 		}
 
-		adis->current_page = 0;
+		ret = spi_sync(adis->spi, &adis->msg);
+		if (ret) {
+			dev_err(dev, "Failed to read data: %d\n", ret);
+			goto irq_done;
+		}
 	}
 
-	ret = spi_sync(adis->spi, &adis->msg);
-	if (ret) {
-		dev_err(dev, "Failed to read data: %d\n", ret);
-		adis_dev_unlock(adis);
-		goto irq_done;
-	}
-
-	adis_dev_unlock(adis);
-
 	/*
 	 * After making the burst request, the response can have one or two
 	 * 16-bit responses containing the BURST_ID depending on the sclk. If

-- 
2.45.2



Return-Path: <linux-iio+bounces-6485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDEF90D2C8
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9F6284488
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0150C14D446;
	Tue, 18 Jun 2024 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="moVT/EID"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612BA14A60E
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717334; cv=none; b=I47RYOMpFl/ItgpbPkfkCnAcTfC2RTcLaBQ5gLzTIe2xDKbS3tV54+HSbzhpPytXRLC1FuDmRmnbcBs+zdEkE9UJR9btWNiwkGAECNy/eMHMiqRwCbBggXYlyPc+gY17fqpCrDP0OIbCXmmTRBDMQTj8cq3rQwtNMchMnZf1Ylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717334; c=relaxed/simple;
	bh=yh08EatI96HoRvnVij694r8zNAX7E/Q/hGB1eFMYGYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IB0szFxO4yUYYeCBaOvtBdGvhXDKdWz6LaZMqNXN4HX9saJiKjL+PpzOm2oeZyG48jVOPHmY+dlMhy+ZgDF80P0vjAe6qywQ31YqPO1BPzkqRQI82/Z/CSi2wy0kt+fQNUz7J6gJWo4Eyv6ZTHPkUE47tokG1kbMONuXM5I2m0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=moVT/EID; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IAaQF9007831;
	Tue, 18 Jun 2024 09:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZIQGp
	PTSDFxBRRqrq3ffJ/Bk5SDUpTBjdN6kz2SIAAg=; b=moVT/EIDm4ps24ifUKUUr
	dN7cmsCOCzDD3zCs4dNfsJblzOZIYqqdxG8w9nySZ5KJJKt2MzFeqfZ10KsQGIWh
	nSVUvG8xDRpPNxhM39q7ZUOJmsy/M0JoRY7kCIQhPJhTay0yB+Nz36BLvie8vgER
	XPySTv4AFDIsU/y4rjOrUfkbUjU/hNmbeSm9moqVFzHwrzylhsqvBcLomOhVyTN/
	24nLL4QZHADLv3zxDl9SZqyVBNVv9ieLw3K+Qa5DuvyiCpTeg8pRIRcAlbTMrzzR
	+5dV403yM61T96KJ+bge+Arv4npw5Zk+c9xkYzvPWtbtT867UnVMOZTtj+MEHBTO
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ys7v32x7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:28:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45IDSdBE062024
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 09:28:39 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 09:28:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 09:28:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 09:28:38 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45IDSLWQ025769;
	Tue, 18 Jun 2024 09:28:30 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 18 Jun 2024 15:32:09 +0200
Subject: [PATCH 6/9] iio: imu: adis16400: make use of the new lock helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-dev-iio-adis-cleanup-v1-6-bd93ce7845c7@analog.com>
References: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
In-Reply-To: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718717531; l=3642;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=yh08EatI96HoRvnVij694r8zNAX7E/Q/hGB1eFMYGYo=;
 b=R867S1FktY06HpadTk8OmcX81x9NDZ8P/3MJ5ZIn5p6LdRMDnghanLziIQTBI04o09Ar9fVy+
 N0YkxxZ+X7IBOPIpWNo9oL0Nlq6wWYulDNbLV2inoe0GbUn3Kk7g5To
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: mH8N_bRLzj2gYJYjOnkX6myNyk1E4J8D
X-Proofpoint-GUID: mH8N_bRLzj2gYJYjOnkX6myNyk1E4J8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180100

Use the new auto cleanup based locks so error paths are simpler.

While at it, removed 'ret' from adis16400_write_raw() by doing

	return adis_write_reg_16();

instead of

	ret = adis_write_reg_16();
	return ret;

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16400.c | 72 ++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 3eda32e12a53..0bfd6205f5f6 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -497,41 +497,38 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int val, int val2, long info)
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
-	int ret, sps;
+	int sps;
 
 	switch (info) {
 	case IIO_CHAN_INFO_CALIBBIAS:
-		ret = adis_write_reg_16(&st->adis,
-				adis16400_addresses[chan->scan_index], val);
-		return ret;
+		return adis_write_reg_16(&st->adis,
+					 adis16400_addresses[chan->scan_index],
+					 val);
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		/*
 		 * Need to cache values so we can update if the frequency
 		 * changes.
 		 */
-		adis_dev_lock(&st->adis);
-		st->filt_int = val;
-		/* Work out update to current value */
-		sps = st->variant->get_freq(st);
-		if (sps < 0) {
-			adis_dev_unlock(&st->adis);
-			return sps;
-		}
+		adis_dev_auto_scoped_lock(&st->adis) {
+			st->filt_int = val;
+			/* Work out update to current value */
+			sps = st->variant->get_freq(st);
+			if (sps < 0)
+				return sps;
 
-		ret = __adis16400_set_filter(indio_dev, sps,
-			val * 1000 + val2 / 1000);
-		adis_dev_unlock(&st->adis);
-		return ret;
+			return __adis16400_set_filter(indio_dev, sps,
+						      val * 1000 + val2 / 1000);
+		}
+		unreachable();
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		sps = val * 1000 + val2 / 1000;
 
 		if (sps <= 0)
 			return -EINVAL;
 
-		adis_dev_lock(&st->adis);
-		ret = st->variant->set_freq(st, sps);
-		adis_dev_unlock(&st->adis);
-		return ret;
+		adis_dev_auto_scoped_lock(&st->adis)
+			return st->variant->set_freq(st, sps);
+		unreachable();
 	default:
 		return -EINVAL;
 	}
@@ -596,29 +593,30 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		*val = st->variant->temp_offset;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		adis_dev_lock(&st->adis);
-		/* Need both the number of taps and the sampling frequency */
-		ret = __adis_read_reg_16(&st->adis,
-						ADIS16400_SENS_AVG,
-						&val16);
-		if (ret) {
-			adis_dev_unlock(&st->adis);
-			return ret;
+		adis_dev_auto_scoped_lock(&st->adis) {
+			/*
+			 * Need both the number of taps and the sampling
+			 * frequency
+			 */
+			ret = __adis_read_reg_16(&st->adis, ADIS16400_SENS_AVG,
+						 &val16);
+			if (ret)
+				return ret;
+
+			ret = st->variant->get_freq(st);
+			if (ret)
+				return ret;
 		}
-		ret = st->variant->get_freq(st);
-		adis_dev_unlock(&st->adis);
-		if (ret)
-			return ret;
 		ret /= adis16400_3db_divisors[val16 & 0x07];
 		*val = ret / 1000;
 		*val2 = (ret % 1000) * 1000;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		adis_dev_lock(&st->adis);
-		ret = st->variant->get_freq(st);
-		adis_dev_unlock(&st->adis);
-		if (ret)
-			return ret;
+		adis_dev_auto_scoped_lock(&st->adis) {
+			ret = st->variant->get_freq(st);
+			if (ret)
+				return ret;
+		}
 		*val = ret / 1000;
 		*val2 = (ret % 1000) * 1000;
 		return IIO_VAL_INT_PLUS_MICRO;

-- 
2.45.2



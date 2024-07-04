Return-Path: <linux-iio+bounces-7305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EFE9272E4
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 11:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CD8287DD7
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 09:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD6B1AB500;
	Thu,  4 Jul 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1abDizql"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653C1A4F32;
	Thu,  4 Jul 2024 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084953; cv=none; b=fM22R8PslxCEoy25oz6JpLqpoHOZpD0hrmFK9lbtIua/bhpO5JUxJm1taoiKNlfaH1OpyaXTbiRQX2TFLI05B6pi7c5nRV4HXZ579V/RKP13TBEahv4tGMXhAAg0ZGR3Ee2thvSX2GR9msB5GzgxOSSCddtc5jNfM5vgkcmZH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084953; c=relaxed/simple;
	bh=yRfskaTF2zPa7EXtHE46Ww/VTq0tzOvJaJaeoJNxS4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N3Cr6nFunGNxvYc9jBnYeUXevzbCf4YlLh+NsFgAPu9/dK802sYm89rfj/57HqlwuwirdNdcTFEseI2mmfOdCoG1anws+pw+2X8XovGrab/R6iTYRamg8gzqvHMLbyTISBsJvTEE/KAwrwxOaXLakUry8oYqha4Skb7mDNekWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1abDizql; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4646Wch9003572;
	Thu, 4 Jul 2024 05:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ClJnX
	PiZY4h1loa1XU7bW6EiF9tBW593LtFo6OMUd3A=; b=1abDizqlV2X7OkoxKdu1Q
	upYf2Jh4IEV0J0lFbS0lcSySnbUULgZWwGsxB+KdrHSzcipmS3Nn28DAAgtiPi4V
	YVugTc3VqF5GulcTnx+DGbSxXoygdjhOkYd3dbJynNMqj1uHH3s9NzIXRdUuenBt
	06kyA6i7HcR8Zw0V0JWkvBrGR8cVMVSoOsGXu0kBRfgkXJrmguEqr8UwdPuMLwc5
	tARmkw0B1GWOzVK7oJpQV5O+puCu7rmCAD4YLmr58I5giNnkbz+c8p2pDJMN8xKa
	4tqFfhRhIa8RJCs59DU0mym6mMGAtv3TOMkhhCxS3RYGV9E/XQsH55L023O2GoE9
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 405a7natfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 05:22:17 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4649MG6K047969
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 05:22:16 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 05:22:15 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 05:22:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Jul 2024 05:22:15 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4649M1dj012858;
	Thu, 4 Jul 2024 05:22:07 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Jul 2024 11:25:21 +0200
Subject: [PATCH 1/5] iio: adc: ad9467: support multiple channels
 calibration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240704-dev-iio-ad9467-new-devs-v1-1-f1adfee921f7@analog.com>
References: <20240704-dev-iio-ad9467-new-devs-v1-0-f1adfee921f7@analog.com>
In-Reply-To: <20240704-dev-iio-ad9467-new-devs-v1-0-f1adfee921f7@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720085156; l=5343;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=yRfskaTF2zPa7EXtHE46Ww/VTq0tzOvJaJaeoJNxS4g=;
 b=QcVgaoD7UieVrz4j51mh7dDO7FnOsXdtQIhkc1Ls4eDxZdEC6X5tC67mIwrowZP2eEXc9p8DF
 ENGtGfqKklXB4fLKm0+Vr0JejO7g8YftwICTWNY7g/iAMXjLYuqJSr/
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: SniFzoezIV7yYScm4huN89FuCHC6zpL0
X-Proofpoint-GUID: SniFzoezIV7yYScm4huN89FuCHC6zpL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_06,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=936 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040064

The calibration process mixes the support for calibrating multiple
channels with only having one channel. Some paths do have 'num_channels'
into account while others don't.

As of now, the driver only supports devices with one channel so the
above is not really a problem. That said, we'll add support for devices
with more than one channel, hence let's properly make the calibration
process to work with it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 117 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 76 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 41c1b519c573..1d8270a5bccb 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -352,6 +352,34 @@ static int ad9467_outputmode_set(struct ad9467_state *st, unsigned int mode)
 				AN877_ADC_TRANSFER_SYNC);
 }
 
+static int ad9467_testmode_set(struct ad9467_state *st, unsigned int chan,
+			       unsigned int test_mode)
+{
+	int ret;
+
+	if (st->info->num_channels > 1) {
+		/* so that the test mode is only applied to one channel */
+		ret = ad9467_spi_write(st, AN877_ADC_REG_CHAN_INDEX, BIT(chan));
+		if (ret)
+			return ret;
+	}
+
+	ret = ad9467_spi_write(st, AN877_ADC_REG_TEST_IO, test_mode);
+	if (ret)
+		return ret;
+
+	if (st->info->num_channels > 1) {
+		/* go to default state where all channels get write commands */
+		ret = ad9467_spi_write(st, AN877_ADC_REG_CHAN_INDEX,
+				       GENMASK(st->info->num_channels - 1, 0));
+		if (ret)
+			return ret;
+	}
+
+	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
+				AN877_ADC_TRANSFER_SYNC);
+}
+
 static int ad9647_calibrate_prepare(struct ad9467_state *st)
 {
 	struct iio_backend_data_fmt data = {
@@ -360,32 +388,30 @@ static int ad9647_calibrate_prepare(struct ad9467_state *st)
 	unsigned int c;
 	int ret;
 
-	ret = ad9467_spi_write(st, AN877_ADC_REG_TEST_IO,
-			       AN877_ADC_TESTMODE_PN9_SEQ);
-	if (ret)
-		return ret;
-
-	ret = ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
-			       AN877_ADC_TRANSFER_SYNC);
-	if (ret)
-		return ret;
-
 	ret = ad9467_outputmode_set(st, st->info->default_output_mode);
 	if (ret)
 		return ret;
 
 	for (c = 0; c < st->info->num_channels; c++) {
+		ret = ad9467_testmode_set(st, c, AN877_ADC_TESTMODE_PN9_SEQ);
+		if (ret)
+			return ret;
+
 		ret = iio_backend_data_format_set(st->back, c, &data);
 		if (ret)
 			return ret;
+
+		ret = iio_backend_test_pattern_set(st->back, c,
+						   IIO_BACKEND_ADI_PRBS_9A);
+		if (ret)
+			return ret;
+
+		ret = iio_backend_chan_enable(st->back, c);
+		if (ret)
+			return ret;
 	}
 
-	ret = iio_backend_test_pattern_set(st->back, 0,
-					   IIO_BACKEND_ADI_PRBS_9A);
-	if (ret)
-		return ret;
-
-	return iio_backend_chan_enable(st->back, 0);
+	return 0;
 }
 
 static int ad9647_calibrate_polarity_set(struct ad9467_state *st,
@@ -468,38 +494,32 @@ static int ad9647_calibrate_stop(struct ad9467_state *st)
 	unsigned int c, mode;
 	int ret;
 
-	ret = iio_backend_chan_disable(st->back, 0);
-	if (ret)
-		return ret;
-
-	ret = iio_backend_test_pattern_set(st->back, 0,
-					   IIO_BACKEND_NO_TEST_PATTERN);
-	if (ret)
-		return ret;
-
 	for (c = 0; c < st->info->num_channels; c++) {
+		ret = iio_backend_chan_disable(st->back, c);
+		if (ret)
+			return ret;
+
+		ret = iio_backend_test_pattern_set(st->back, c,
+						   IIO_BACKEND_NO_TEST_PATTERN);
+		if (ret)
+			return ret;
+
 		ret = iio_backend_data_format_set(st->back, c, &data);
 		if (ret)
 			return ret;
+
+		ret = ad9467_testmode_set(st, c, AN877_ADC_TESTMODE_OFF);
+		if (ret)
+			return ret;
 	}
 
 	mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
-	ret = ad9467_outputmode_set(st, mode);
-	if (ret)
-		return ret;
-
-	ret = ad9467_spi_write(st, AN877_ADC_REG_TEST_IO,
-			       AN877_ADC_TESTMODE_OFF);
-	if (ret)
-		return ret;
-
-	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
-			       AN877_ADC_TRANSFER_SYNC);
+	return ad9467_outputmode_set(st, mode);
 }
 
 static int ad9467_calibrate(struct ad9467_state *st)
 {
-	unsigned int point, val, inv_val, cnt, inv_cnt = 0;
+	unsigned int point, val, inv_val, cnt, inv_cnt = 0, c;
 	/*
 	 * Half of the bitmap is for the inverted signal. The number of test
 	 * points is the same though...
@@ -526,11 +546,26 @@ static int ad9467_calibrate(struct ad9467_state *st)
 		if (ret)
 			return ret;
 
-		ret = iio_backend_chan_status(st->back, 0, &stat);
-		if (ret)
-			return ret;
+		for (c = 0; c < st->info->num_channels; c++) {
+			ret = iio_backend_chan_status(st->back, c, &stat);
+			if (ret)
+				return ret;
 
-		__assign_bit(point + invert * test_points, st->calib_map, stat);
+			/*
+			 * A point is considered valid if all channels report no
+			 * error. If one reports an error, then we consider the
+			 * point as invalid and we can break the loop right away.
+			 */
+			if (stat) {
+				dev_dbg(dev, "Invalid point(%u, inv:%u) for CH:%u\n",
+					point, invert, c);
+				break;
+			}
+
+			if (c == st->info->num_channels - 1)
+				__clear_bit(point + invert * test_points,
+					    st->calib_map);
+		}
 	}
 
 	if (!invert) {

-- 
2.45.2



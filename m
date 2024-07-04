Return-Path: <linux-iio+bounces-7306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27EF9272E7
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 11:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99158287EDC
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 09:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78E41AB513;
	Thu,  4 Jul 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="McZnubDo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E93B1AAE15;
	Thu,  4 Jul 2024 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084953; cv=none; b=NW6LcBQjuHkMErEuY1IfShMbOuF76SgUY5SGtOfWhMPb7ADyqcWakKy1gwtAr2VmX7KMzc5gXEfdL6hIRiMfpVeNx49Nk6pDHXjBwPhznz4hw+o97Egqfvsw1VeZkKpOL/0PaWimxkTPpGMhpqi+6djNLv4I+4F06gBcXK6mue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084953; c=relaxed/simple;
	bh=fRhh1wi0phWAUPnn4AUVYgDau6R2WoroOFT7i9aJ4o8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KQ7vICvowcokzLux3o5t5tE97Pya4NLYX2OgY7Pu1NEDcKDQ2j5SfZ6XH9myx4BNhYoDhG5SUp/JvO7WqZoMysyvStK05A+IG8+5+8yo4h5WHLfQ5d5AGgH2wohjRlP1A4i6l/tStAfSIq8sjfFvgKlYRliKM32Tw1dVO6909oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=McZnubDo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4646Yp7E003583;
	Thu, 4 Jul 2024 05:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oUJjy
	r4iHuFNczKWpssEjsOfWgmV5Uf+YLWCk7fBono=; b=McZnubDou2cauxgwKZgFd
	L6tyB3ZUmZgbU8EzZUOHhqDtA9Lmb+mgHjfR7ILrb1Tsk3i9MudHQauQP+GdF2Ez
	0+ihFPfZe/P2xzfZci6sVPWyqhrHpJwjdNufixAiSRqlGzrUcqhzeqWY7WxUaeE0
	wJ6Cdg/adxSkmxMcmHHkQB+y/NIAUK9UTxUdemACaApCZL7NCYaPAkq8/apLezC/
	c3pBxr3Kp6TFCzBhgp3Hl/QH+uvbXg+7xOF0EGb5KZXICtulYi4sXKe5nxz8llIt
	T2JoZkq9TdA5VAnsd8J8s10qadRfoYuq4Fxgs4H/1WMOyDEL/Ut1jHltrBDe6nQ8
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 405a7natfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 05:22:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4649MI3n058897
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 05:22:18 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 05:22:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 05:22:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Jul 2024 05:22:16 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4649M1dl012858;
	Thu, 4 Jul 2024 05:22:09 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Jul 2024 11:25:23 +0200
Subject: [PATCH 3/5] iio: adc: ad9467: don't allow reading vref if not
 available
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240704-dev-iio-ad9467-new-devs-v1-3-f1adfee921f7@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720085156; l=3454;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=fRhh1wi0phWAUPnn4AUVYgDau6R2WoroOFT7i9aJ4o8=;
 b=ikxWg2k77EE8lxhexSD1ZdQuIAdclSksFp6LobiL8SeB2cVyl6M78OdHODooPGMwm0IK5gCyN
 vk0Gj1LhNzNBmEJkxZmB+sEvn8+oym+zLpJfouzpRsK3OUkJrODa1yP
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: JRXSAUntWKDFgRhv20LoMy3KvgQMUmKV
X-Proofpoint-GUID: JRXSAUntWKDFgRhv20LoMy3KvgQMUmKV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_06,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=894 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040064

If there's only one possible scale, there's no way to change the Vref
select in the device so avoid reading the register in ad9467_get_scale().
In this case, it makes no sense to provide the .read_available()
callback nor allowing for writing the scale attribute.

Note this is in preparation for supporting a new device that only has
one possible scale.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 077c3a594bfc..d06a5fcc4ee8 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -231,14 +231,14 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
 	*val2 = tmp % 1000000;
 }
 
-#define AD9467_CHAN(_chan, _si, _bits, _sign)				\
+#define AD9467_CHAN(_chan, avai_mask, _si, _bits, _sign)		\
 {									\
 	.type = IIO_VOLTAGE,						\
 	.indexed = 1,							\
 	.channel = _chan,						\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
-	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_type_available = avai_mask,		\
 	.scan_index = _si,						\
 	.scan_type = {							\
 		.sign = _sign,						\
@@ -248,11 +248,11 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
 }
 
 static const struct iio_chan_spec ad9434_channels[] = {
-	AD9467_CHAN(0, 0, 12, 's'),
+	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
 };
 
 static const struct iio_chan_spec ad9467_channels[] = {
-	AD9467_CHAN(0, 0, 16, 's'),
+	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 16, 's'),
 };
 
 static const struct ad9467_chip_info ad9467_chip_tbl = {
@@ -301,9 +301,13 @@ static const struct ad9467_chip_info ad9265_chip_tbl = {
 static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
 {
 	const struct ad9467_chip_info *info = st->info;
-	unsigned int i, vref_val;
+	unsigned int i = 0, vref_val;
 	int ret;
 
+	/* nothing to read if we only have one possible scale */
+	if (info->num_scales == 1)
+		goto out_get_scale;
+
 	ret = ad9467_spi_read(st, AN877_ADC_REG_VREF);
 	if (ret < 0)
 		return ret;
@@ -318,6 +322,7 @@ static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
 	if (i == info->num_scales)
 		return -ERANGE;
 
+out_get_scale:
 	__ad9467_get_scale(st, i, val, val2);
 
 	return IIO_VAL_INT_PLUS_MICRO;
@@ -332,6 +337,8 @@ static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
 
 	if (val != 0)
 		return -EINVAL;
+	if (info->num_scales == 1)
+		return -EOPNOTSUPP;
 
 	for (i = 0; i < info->num_scales; i++) {
 		__ad9467_get_scale(st, i, &scale_val[0], &scale_val[1]);
@@ -730,7 +737,7 @@ static int ad9467_update_scan_mode(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static const struct iio_info ad9467_info = {
+static struct iio_info ad9467_info = {
 	.read_raw = ad9467_read_raw,
 	.write_raw = ad9467_write_raw,
 	.update_scan_mode = ad9467_update_scan_mode,
@@ -905,6 +912,8 @@ static int ad9467_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
+	if (st->info->num_scales > 1)
+		ad9467_info.read_avail = ad9467_read_avail;
 	indio_dev->name = st->info->name;
 	indio_dev->channels = st->info->channels;
 	indio_dev->num_channels = st->info->num_channels;

-- 
2.45.2



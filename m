Return-Path: <linux-iio+bounces-23047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559A1B2DC0D
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDD9A0473D
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 12:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA0E2F0C6A;
	Wed, 20 Aug 2025 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sA9hxJPx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8482E8889;
	Wed, 20 Aug 2025 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691434; cv=none; b=gQ9xFbMu7pVb3uawF8Aw/ydxWjQeMAD3n/quuyF/8ditUAwAQkbb6hzm1Hlp0k44WDRQjJfJVsUf7K6W1XMR9UdS+17hEC0kQ9sI00goaFpFcfzAz104+BBdFl8NdkuyLmMvAtm/fRTrmLSaajJrnVoxgw7R5MVEsE/N/iItZg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691434; c=relaxed/simple;
	bh=Ksl/P0FewlvtlAM4h8GRfzNWfnApy8twRnod3sBzruo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJekBwBZ6UhZmCcs2MqPWoztQU+0ZRyQMhSXu731xBm6JXrzYZqGx346fxbAgBqOYKR7UBQWg1JY5FR/vK6bryGhClJi8lgKJpv2tG1sfHfoDU0QWrMLBnm5u8C5z/dZz5OkYWMUgRRqtUzu9kCp8vcSo0VXEB5mnwh9TFy+yWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sA9hxJPx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KAeT6E009192;
	Wed, 20 Aug 2025 08:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=szKwJ
	DHvtugDHsPzhtNq0i+ZtQ0tz1Z1J3+jkQRTVn0=; b=sA9hxJPx3OTi6QXz/RiAt
	4wBhjxWlgmGEzbLNzprFuFVc2nUSpW3FB/IoBnQPoPW5/zHgM62j0rQ1ANLOQ0vn
	MSC5QCz6D5Eh7k1zEdacXYlp5hjrPA8uTn6M4YFbZ+Vh6FlDBnVnY7NK+aKaKH/F
	/64KadhfJpiejZKYPmZPC1cULSuChMIh7THFpR3oBVUwZ+7LEyFJpVkm9HSOGPyY
	VH3TXZ+8p+df1wCJ3lSioMaQ+hlvO9kvlkIR/NTvYZBDW5rMovTwQEOh+Gncv+EL
	uWEhNF04RnWxQs+BX3C2qLCPLWMBlTNj700G0IcQhlTuSHdy663zfIcrgKfGku44
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48n0tdufhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 08:03:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57KC3aqH037366
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Aug 2025 08:03:36 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 20 Aug 2025 08:03:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 20 Aug 2025 08:03:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 20 Aug 2025 08:03:36 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.173])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57KC31n4020092;
	Wed, 20 Aug 2025 08:03:29 -0400
From: Ioana Risteiu <Ioana.Risteiu@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Ramona Nechita <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Ioana Risteiu <Ioana.Risteiu@analog.com>
Subject: [PATCH v4 4/4] iio: adc: update ad7779 to use IIO backend
Date: Wed, 20 Aug 2025 15:02:45 +0300
Message-ID: <20250820120247.3012-5-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250820120247.3012-1-Ioana.Risteiu@analog.com>
References: <20250820120247.3012-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NSBTYWx0ZWRfX0B6s+v+BXogx
 u4PCRGjlJMqip62mE7N/4AUl3x9rqeoqeVjhZHMrGKVdj/mZBto2vFnFz0auUJOqzYkpffuqZjf
 Ire7Py9W9FH/0BtRnNTGHSjGsVMhySNADIAdT+xSe7NSJ+iMnq0GeZLjgRTPmNEUTfbvrIxTeyA
 j/XbYPC/jXbZ7wTeC5tWNkRQwnAfHttMLlST8yV3lzjIIPMKu6YVOWVi4gwW/MRaSA16mLI04v2
 IuH9uX7AsrNMWbkoDIuw4ChovZ7T5bLGDIIg2o8FA5ArYHWKdIABirDRZbbNxuO5IwYhXq9MTZu
 gNwvNc/+RASmRs5aaHUcg86v90EVA3jr6gK9gF1H2Zg9yPV0sFvIv19HnhrbCSvpDms6ajlIfuu
 3iz4SOspI9OiItlAt0s0274dFe1d2g==
X-Proofpoint-ORIG-GUID: hiXJFulbev_dI0BC2Put3c1GCiTAzDcB
X-Authority-Analysis: v=2.4 cv=BoHEAYX5 c=1 sm=1 tr=0 ts=68a5b999 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=VjRcvFoKhyOr0kwuT1sA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: hiXJFulbev_dI0BC2Put3c1GCiTAzDcB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190195

Add a new functionality to ad7779 driver that streams data through data
output interface using IIO backend interface.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
changes in v4:
 - grouped includes in alphabetical order
 - reordered fields in struct ad7779_state
 - modified logic of setting the number of lanes 
 - validating devicetree value
 drivers/iio/adc/ad7779.c | 116 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index f7e681c0e8c0..adca490061c9 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -25,6 +25,7 @@
 #include <linux/units.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/backend.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -116,6 +117,12 @@
 #define AD7779_CRC8_POLY			0x07
 DECLARE_CRC8_TABLE(ad7779_crc8_table);
 
+enum ad7779_data_lines {
+	AD7779_1LINE = 1,
+	AD7779_2LINES = 2,
+	AD7779_4LINES = 4,
+};
+
 enum ad7779_filter {
 	AD7779_SINC3,
 	AD7779_SINC5,
@@ -145,6 +152,7 @@ struct ad7779_state {
 	struct completion completion;
 	unsigned int sampling_freq;
 	enum ad7779_filter filter_enabled;
+	struct iio_backend *back;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -630,12 +638,38 @@ static int ad7779_reset(struct iio_dev *indio_dev, struct gpio_desc *reset_gpio)
 	return ret;
 }
 
+static int ad7779_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+	unsigned int c;
+	int ret;
+
+	for (c = 0; c < AD7779_NUM_CHANNELS; c++) {
+		if (test_bit(c, scan_mask))
+			ret = iio_backend_chan_enable(st->back, c);
+		else
+			ret = iio_backend_chan_disable(st->back, c);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct iio_info ad7779_info = {
 	.read_raw = ad7779_read_raw,
 	.write_raw = ad7779_write_raw,
 	.debugfs_reg_access = &ad7779_reg_access,
 };
 
+static const struct iio_info ad7779_info_data = {
+	.read_raw = ad7779_read_raw,
+	.write_raw = ad7779_write_raw,
+	.debugfs_reg_access = &ad7779_reg_access,
+	.update_scan_mode = &ad7779_update_scan_mode,
+};
+
 static const struct iio_enum ad7779_filter_enum = {
 	.items = ad7779_filter_type,
 	.num_items = ARRAY_SIZE(ad7779_filter_type),
@@ -752,6 +786,49 @@ static int ad7779_conf(struct ad7779_state *st, struct gpio_desc *start_gpio)
 	return 0;
 }
 
+static int ad7779_set_data_lines(struct iio_dev *indio_dev,
+				 unsigned int num_lanes)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	if (num_lanes != AD7779_1LINE &&
+		num_lanes != AD7779_2LINES &&
+		num_lanes != AD7779_4LINES)
+		return ret;
+
+	ret = ad7779_set_sampling_frequency(st, num_lanes * AD7779_DEFAULT_SAMPLING_1LINE);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_num_lanes_set(st->back, num_lanes);
+	if (ret)
+		return ret;
+
+	return ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
+				    AD7779_DOUT_FORMAT_MSK,
+				    FIELD_PREP(AD7779_DOUT_FORMAT_MSK, 2 - ilog2(num_lanes)));
+}
+
+static int ad7779_setup_channels(struct iio_dev *indio_dev, const struct ad7779_state *st)
+{
+	struct iio_chan_spec *channels;
+	struct device *dev = &st->spi->dev;
+
+	channels = devm_kmemdup_array(dev, st->chip_info->channels,
+					ARRAY_SIZE(ad7779_channels),
+					sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	for (int i = 0; i < ARRAY_SIZE(ad7779_channels); i++)
+		channels[i].scan_type.endianness = IIO_CPU;
+
+	indio_dev->channels = channels;
+
+	return 0;
+}
+
 static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev *indio_dev)
 {
 	int ret;
@@ -796,6 +873,39 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
 				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
 }
 
+static int ad7779_setup_backend(struct ad7779_state *st, struct iio_dev *indio_dev)
+{
+	struct device *dev = &st->spi->dev;
+	int ret = -EINVAL;
+	int num_lanes;
+
+	indio_dev->info = &ad7779_info_data;
+
+	ret = ad7779_setup_channels(indio_dev, st);
+	if (ret)
+		return ret;
+
+	st->back = devm_iio_backend_get(dev, NULL);
+	if (IS_ERR(st->back))
+		return dev_err_probe(dev, PTR_ERR(st->back),
+				     "failed to get iio backend");
+
+	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_backend_enable(dev, st->back);
+	if (ret)
+		return ret;
+
+	num_lanes = 4;
+	ret = device_property_read_u32(dev, "adi,num-lanes", &num_lanes);
+	if (ret && ret != -EINVAL)
+		return ret;
+
+	return ad7779_set_data_lines(indio_dev, num_lanes);
+}
+
 static int ad7779_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -848,7 +958,10 @@ static int ad7779_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
 
-	ret = ad7779_setup_without_backend(st, indio_dev);
+	if (device_property_present(dev, "io-backends"))
+		ret = ad7779_setup_backend(st, indio_dev);
+	else
+		ret = ad7779_setup_without_backend(st, indio_dev);
 
 	if (ret)
 		return ret;
@@ -943,3 +1056,4 @@ module_spi_driver(ad7779_driver);
 MODULE_AUTHOR("Ramona Alexandra Nechita <ramona.nechita@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7779 ADC");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");
-- 
2.47.2



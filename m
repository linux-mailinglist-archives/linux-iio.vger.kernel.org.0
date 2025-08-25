Return-Path: <linux-iio+bounces-23295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABECB3578C
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 10:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B247B558D
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 08:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B953D2FFDFB;
	Tue, 26 Aug 2025 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yFgmWeKm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE00285C99;
	Tue, 26 Aug 2025 08:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197965; cv=none; b=ImVRwZ2mujN5Kk8osH3ByYVwHuiyPmDXUbA+sOGPqdPTuHNayXRRPFZlRjKuug3Umzm+J8bH1FVhcfwdqHKq6S+Th5YbBJFAi8Ytx4gQpwpbUftWjG/CiVwuQG4EYczHFrUyqc1gNkGTrmz3ySHPy079zYJh9noJcBy4yjEoFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197965; c=relaxed/simple;
	bh=Qlw+1P9ovwUgOWuNRMaugYkmxAuDA7Tk/eEOUOLdkNA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6EJKHxoCTIofsob063LQ9F07AQ02zyJixC/ipxGtqR59AypdLOmJLox3i+OBJC644Qc6b3y72cn43yGct2zEZWknRZa+183X/sONc3dURHCs9yO8MnrbxTnWykjFNrqr0F39agnyZ/YXvvQbLDeVYX9N/qF7OPrhIV9FiuuEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yFgmWeKm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q5ve4M017762;
	Tue, 26 Aug 2025 04:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BvAn1
	A2PVkDCeVAzJEmW736Wow2ZR5COMYy58RwA9uY=; b=yFgmWeKmz/RKD8yQ2y4ja
	cO0rqTivwngGeiATYfxPVsyq5eDfqbJqyBeRAgAKj6G80aLFPOiBYN9T10GGW2W3
	usrw5GsFacIF4w7BSX4COwJok+eJkuuayZ2COyb2MNP1YNk1zycPtz3HjsZCwTwy
	01Pe7zZXSUZ+/vaNqyj1PWHCNdykMhnG2hojaDoawP2eWc5XypNCzl5LCHI3Dd+5
	LwvzW/GxXILWacVRVi/szJjwW9vhNmDZXhv9z4s+9ovu+qZrmaOKeE/v7pxf9TyI
	VhVWJl+4nn0ZhhJmv6ifJ+mAxrDZgQcJMuT8Df8pLCNU93C/lxB9mCd5Jxx6qVQD
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmafnwjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 04:45:48 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57Q8jli8018650
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Aug 2025 04:45:47 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 26 Aug 2025 04:45:47 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 26 Aug 2025 04:45:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 26 Aug 2025 04:45:47 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.166])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57Q8jHo0015527;
	Tue, 26 Aug 2025 04:45:41 -0400
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
CC: Ioana Risteiu <Ioana.Risteiu@analog.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v6 4/4] iio: adc: update ad7779 to use IIO backend
Date: Tue, 26 Aug 2025 01:13:52 +0300
Message-ID: <20250825221355.6214-5-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825221355.6214-1-Ioana.Risteiu@analog.com>
References: <20250825221355.6214-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA3NSBTYWx0ZWRfX2PiWhj44zDvO
 F2hQq5mGY801faLKW3+KfYqOjcxwI2g/ogap90dRG4vNGsWZQnII9PvoeeVHoQNWWwyx7MUz3SP
 zeU1O/zrnKtq/K9nTahBOZtCqSKn9h6fETXoBqTxbT1taJpQtL+VQqTZZ8j2BDbTnRHPXUBUAAD
 Hvsn1nSWUTEnCeeTwq1jj721FBnoJRtsuxc5P8Enof79dqd0rRD/aVw2nCtyepSWOdwiW6tsUBM
 Pa4fLk4fZ4tsYvFuPpyA/7ylTUeYZPCzyABaq39YA1GVCxX+Gb1rnn6+R0/3bjefK2rLoF7CZM8
 ZbjqGuWSaipvFwAteaTR4ZSD9FWP/nif5KF0LIW8S4uvV6/wHfeTzmjNeTG7P6Djr6Z4u5J4223
 lVgFlGcN
X-Proofpoint-ORIG-GUID: 98tuE9Y6rQGwoUi7b00tNERNTXT6OMZy
X-Proofpoint-GUID: 98tuE9Y6rQGwoUi7b00tNERNTXT6OMZy
X-Authority-Analysis: v=2.4 cv=AoXu3P9P c=1 sm=1 tr=0 ts=68ad743d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=VjRcvFoKhyOr0kwuT1sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250075

Add a new functionality to ad7779 driver that streams data through data
output interface using IIO backend interface.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
changes in v6:
 - fix indentation
 - remove ad7779_data_lines enum
 - move channels and num_channels assignment together in ad7779_setup_channels()
 drivers/iio/adc/ad7779.c | 108 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index 4e6fa6370593..aac5049c9a07 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -25,6 +25,7 @@
 #include <linux/units.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/backend.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -145,6 +146,7 @@ struct ad7779_state {
 	struct completion completion;
 	unsigned int sampling_freq;
 	enum ad7779_filter filter_enabled;
+	struct iio_backend *back;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -630,12 +632,38 @@ static int ad7779_reset(struct iio_dev *indio_dev, struct gpio_desc *reset_gpio)
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
@@ -752,6 +780,47 @@ static int ad7779_conf(struct ad7779_state *st, struct gpio_desc *start_gpio)
 	return 0;
 }
 
+static int ad7779_set_data_lines(struct iio_dev *indio_dev, u32 num_lanes)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (num_lanes != 1 && num_lanes != 2 && num_lanes != 4)
+		return -EINVAL;
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
+				     AD7779_DOUT_FORMAT_MSK,
+				     FIELD_PREP(AD7779_DOUT_FORMAT_MSK, 2 - ilog2(num_lanes)));
+}
+
+static int ad7779_setup_channels(struct iio_dev *indio_dev, const struct ad7779_state *st)
+{
+	struct iio_chan_spec *channels;
+	struct device *dev = &st->spi->dev;
+
+	channels = devm_kmemdup_array(dev, st->chip_info->channels,
+				      ARRAY_SIZE(ad7779_channels),
+				      sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(ad7779_channels); i++)
+		channels[i].scan_type.endianness = IIO_CPU;
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
+
+	return 0;
+}
+
 static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev *indio_dev)
 {
 	int ret;
@@ -797,6 +866,39 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
 				     FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
 }
 
+static int ad7779_setup_backend(struct ad7779_state *st, struct iio_dev *indio_dev)
+{
+	struct device *dev = &st->spi->dev;
+	int ret;
+	u32 num_lanes;
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
@@ -848,7 +950,10 @@ static int ad7779_probe(struct spi_device *spi)
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = ad7779_setup_without_backend(st, indio_dev);
+	if (device_property_present(dev, "io-backends"))
+		ret = ad7779_setup_backend(st, indio_dev);
+	else
+		ret = ad7779_setup_without_backend(st, indio_dev);
 	if (ret)
 		return ret;
 
@@ -942,3 +1047,4 @@ module_spi_driver(ad7779_driver);
 MODULE_AUTHOR("Ramona Alexandra Nechita <ramona.nechita@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7779 ADC");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");
-- 
2.47.2



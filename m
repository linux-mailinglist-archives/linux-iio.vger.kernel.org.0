Return-Path: <linux-iio+bounces-23211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F02B33D3A
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 12:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECAE484020
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663C62E0B5D;
	Mon, 25 Aug 2025 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RsCv72ze"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894A92DCF64;
	Mon, 25 Aug 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119183; cv=none; b=OEoljmCvi7sOnNbxvhS/ChUgg6SToq6mxax/0aZr7fcIwBFPXHajzR7rg9tynSdMuD77UrCYtuvoeXlJmg9/CAaUkrXC9H884JDbJWG7W+BjwS3QLmgrySjfpxs3PWLlyMfNNdjAVLLERPHkDLFKJ0xFbLqrexPuKFQALmYhTTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119183; c=relaxed/simple;
	bh=wdZYUMne+Lmr0HjcxpIYc7EqPbXB+XMoJW+5h2pW0F8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMneXJnzttBW2gQvEJy9Aw8AERXejvXsjrle5p5wKr+NZu/9RXJJFRcDF4OImZeRAehCnlUs13kl2qP9N8UJpnVkw35TyctKqPtL7So24IRyBznwxbgZEiBR4YkEaOdwtDdUS2+SfczP/9p/6UljqMqDOKg3v9+PHgkSXv5+9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RsCv72ze; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8PZs9017762;
	Mon, 25 Aug 2025 06:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pxIR4
	7s3gDl8iPSUtYmYSVY9J+7YMVUQgVKh9fvUCsQ=; b=RsCv72ze+4T2SAa2RIJkt
	9D9lV4n1Ol5WAYuhVWmC53jXHsYI4pOGIxHfwBADEzR+7rsRkRAeZX//JkMb1Pei
	KeMHUvxgGVr7vSDiz5IfXTbCjaOrkTwfyyl3XwyuAaiM08l9I+UKVeoH9cHyLI1g
	7v0g1r9GsXxkuMSjib+CBv91x63isWVoFVsT8ZIrF461xKg/MWMcsf8kpuGRzKu0
	vZlhanZ14vp9BTPYm/ryJ8VzEGXMSjef3NEEm/po1syoRFS+BBZ8L9owzwe61fnP
	wHRZ1J4TpdDCslAFAM7T+41qdxfID5+f1cl7A9oHxk6uZctd+09PMxft+heyZEOP
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmafgj9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 06:52:46 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57PAqjcF006419
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Aug 2025 06:52:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 25 Aug 2025 06:52:45 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 25 Aug 2025 06:52:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 25 Aug 2025 06:52:45 -0400
Received: from IRISTEIU-L01.ad.analog.com ([10.65.213.1])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57PAq60B026383;
	Mon, 25 Aug 2025 06:52:37 -0400
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
Subject: [PATCH v5 4/4] iio: adc: update ad7779 to use IIO backend
Date: Mon, 25 Aug 2025 13:51:19 +0300
Message-ID: <20250825105121.19848-5-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825105121.19848-1-Ioana.Risteiu@analog.com>
References: <20250825105121.19848-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA3NSBTYWx0ZWRfX1UULtcJjLjvm
 7SJjunQf8QKBVexsrrVFQ54v9MfbUzSbHeI+X24i7tj27T0DkIzf+mrJoDZp79lV4jQ5sRPTdcB
 ko1mZ8xYp5FRzweRk5u8CyAOwf2SmFVsduPpdMwnD4SKh7kowQO43coOx19NavSjGobGAeQwV22
 uImhcUaGlAtHs585Qo5qKFqXkJyrTJ1BMQ+Uqu3EKi/q7eYfr9/2y/H8paEiQoXEppsS5syf8Yl
 3gGP1A5QWlXDgLzEHywHgv9+JZI6QPgggg92HX1KFPFsLmbN/3ubV+wB9f24YEDWJgNj5qEjtWn
 MZ8YXpI1e7aPNkCbLkVa2bI5nbMG2+NoaS05CrlCKOogT663TamSKBTgvRpGIjBh7p0e79m7Ajn
 Aplr/8yV
X-Proofpoint-ORIG-GUID: k7_6OvaCPGVdfNNqJ24mrhrJWZtPrzx0
X-Proofpoint-GUID: k7_6OvaCPGVdfNNqJ24mrhrJWZtPrzx0
X-Authority-Analysis: v=2.4 cv=AoXu3P9P c=1 sm=1 tr=0 ts=68ac407f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=VjRcvFoKhyOr0kwuT1sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250075

Add a new functionality to ad7779 driver that streams data through data
output interface using IIO backend interface.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
changes in v5:
 - fix indentation 
 - change num_lanes variable from int to u32 type
 - use unsigned int in for loop declaration
 drivers/iio/adc/ad7779.c | 115 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index b4e56983201c..3776af1c65e9 100644
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
@@ -752,6 +786,48 @@ static int ad7779_conf(struct ad7779_state *st, struct gpio_desc *start_gpio)
 	return 0;
 }
 
+static int ad7779_set_data_lines(struct iio_dev *indio_dev, u32 num_lanes)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (num_lanes != AD7779_1LINE &&
+		num_lanes != AD7779_2LINES &&
+		num_lanes != AD7779_4LINES)
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
+
+	return 0;
+}
+
 static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev *indio_dev)
 {
 	int ret;
@@ -796,6 +872,39 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
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
@@ -848,7 +957,10 @@ static int ad7779_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
 
-	ret = ad7779_setup_without_backend(st, indio_dev);
+	if (device_property_present(dev, "io-backends"))
+		ret = ad7779_setup_backend(st, indio_dev);
+	else
+		ret = ad7779_setup_without_backend(st, indio_dev);
 	if (ret)
 		return ret;
 
@@ -942,3 +1054,4 @@ module_spi_driver(ad7779_driver);
 MODULE_AUTHOR("Ramona Alexandra Nechita <ramona.nechita@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7779 ADC");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");
-- 
2.47.2



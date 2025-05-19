Return-Path: <linux-iio+bounces-19677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C50C4ABC03C
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D888189E344
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16D628468C;
	Mon, 19 May 2025 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ObxpKFEr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D5284682;
	Mon, 19 May 2025 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663460; cv=none; b=Xfzwjf3MunBfcy0Qq5u/o1ZiZg2on+sbGiSGezQfnXspj44jdtMX2QxJSTuX5X7nUuqn4RIjtCGQ3Igi8XoU+XdCZv2f37oDUDr7jMGrboMl2p7WKKo908/Vr3b97pxX5X4rDwoluJfHEonwCinZqeUYuLQXM3GTzC92W6ttUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663460; c=relaxed/simple;
	bh=IZtetJB/92NWxxvlLFSaouVDfN624TnDTljXTHTJAFU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0+Z5wS0EwzRo5kthm9CctZe7R3l5JpgyqDqGC91pOVI35v1euf3EvN0KgNrouCkL+GmFg++Z1g5gvOwLc+DbpuejKDNFTVFIqRRx6H3u9pmGp7PFQV3vmChE8jqbu7ykVuBmK4g8QrexeC4e5M8wKLNzUFFbQ3l/gT08KRRS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ObxpKFEr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JD7DK3012950;
	Mon, 19 May 2025 10:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LQ/95
	ZYRq3Vd4upu32+zTsTHxCwfiiEz+RX9Qg85Cqc=; b=ObxpKFErIU9zV+tPiib15
	mQSEgETV5K3lUKyx57Fa5wAPZokWV5T5iAod1tYNuK4T7AKgNxQi4D43loQ5fib8
	Hc3G9hTiut6AsMKEgkzsO5V4xMaI7qynj7ngCaPJLsUNgI2G5mKkfLWZWC7kNd3k
	duES6+yBqVIBSzgAlzjHMWr1t2TXwZpaSqtCy34cm3sPQaWcQCJKXfnJRMT/xoWb
	wA6h5azo8QPZP4u7345ZF1C6zbnQRhxiIFxgRJdkAOVvKa3Ur3lkvqXxr+efQyjk
	RuA5vadv9AkRMkr/m2Lw16JJanzOvopPyLHNiYO3AA/DwErGhwDH01Ha2YlfLcJe
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46psveqt93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 10:03:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54JE3uTi038248
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 May 2025 10:03:56 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 19 May 2025 10:03:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 19 May 2025 10:03:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 19 May 2025 10:03:55 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54JE2bPI016713;
	Mon, 19 May 2025 10:03:48 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
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
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        "Dragos Bogdan" <dragos.bogdan@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/6] iio: adc: ad7405: add ad7405 driver
Date: Mon, 19 May 2025 17:02:14 +0300
Message-ID: <20250519140220.81489-7-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: TEK-gKbzGyuFIdF2iVCea4BbAWyZxavu
X-Proofpoint-ORIG-GUID: TEK-gKbzGyuFIdF2iVCea4BbAWyZxavu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEzMCBTYWx0ZWRfXzPXPLGY+gMBz
 tqfF+VAz87O8g0uk49dTo1wXoXg0baAdgx+BOSeZHL+tPggAGfGnDCoBHsxrzV8YDWP+0rj7oZL
 ha4w0m35EgLpcOqXK7gyJpnENYGpoJBadEhFJ+YHUzTutY0W0pVf6qSzhSj35NPyxuZHpk0Uloh
 uOm8Z8QPDlACydNZg/GUO8gWE6Kq3Fp/3vT5NjV1d6ynky8oB0NpQ3feXw+4uaQYVS9vuoIzqvD
 ZGfJNbDdrXoj2RMvamzVjv7Gcdu0tL8Qs3r7b0a8kIHP/K6cjRBqCdaV+hETgsanTrybRTL0DTm
 qIaVVyAJQINOkoKnGBYYaGdgdBzcjLltDVIMdAIAwhSofz/hWWchuwtWe6sjiYlnPIVbwzaUDVZ
 i3tjnbGkX8nst52SqLrLIhSd5+QDbumzUUPvYFylJY/lEdfvnUXjPLXa5GvehZKEHsj0UyVT
X-Authority-Analysis: v=2.4 cv=PqSTbxM3 c=1 sm=1 tr=0 ts=682b3a4d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=xMrnY01I1BIIJWUPG5oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190130

Add support for the AD7405/ADUM770x, a high performance isolated ADC,
1-channel, 16-bit with a second-order Σ-Δ modulator that converts an
analog input signal into a high speed, single-bit data stream.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v4:
 - changes in "depends on" instead of "select" for IIO_BACKEND in Kconfig
 - remove scale_tables variables
 - remove sample_frequency_tbl, sample_frequency
 - remove ad7405_fill_samp_freq_table function
 - rewrite ad7405_get_scale function as suggested
 - make sampling_frequency read-only
 - implement IIO_CHAN_INFO_OFFSET as suggested
 - fix code style

 drivers/iio/adc/Kconfig  |  10 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7405.c | 250 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+)
 create mode 100644 drivers/iio/adc/ad7405.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ad06cf556785..43af2070e27f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -251,6 +251,16 @@ config AD7380
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7380.
 
+config AD7405
+	tristate "Analog Device AD7405 ADC Driver"
+	depends on IIO_BACKEND
+	help
+	  Say yes here to build support for Analog Devices AD7405, ADUM7701,
+	  ADUM7702, ADUM7703 analog to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7405.
+
 config AD7476
 	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD and TI"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 07d4b832c42e..8115f30b7862 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7292) += ad7292.o
 obj-$(CONFIG_AD7298) += ad7298.o
 obj-$(CONFIG_AD7380) += ad7380.o
+obj-$(CONFIG_AD7405) += ad7405.o
 obj-$(CONFIG_AD7476) += ad7476.o
 obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
 obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c
new file mode 100644
index 000000000000..fb249c83b87b
--- /dev/null
+++ b/drivers/iio/adc/ad7405.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD7405 driver
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/util_macros.h>
+
+#include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
+
+static const unsigned int ad7405_dec_rates[] = {
+	4096, 2048, 1024, 512, 256, 128, 64, 32,
+};
+
+struct ad7405_chip_info {
+	const char *name;
+	struct iio_chan_spec channel;
+	const unsigned int full_scale_mv;
+};
+
+struct ad7405_state {
+	struct iio_backend *back;
+	const struct ad7405_chip_info *info;
+	unsigned int ref_frequency;
+	unsigned int dec_rate;
+};
+
+static int ad7405_set_dec_rate(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       unsigned int dec_rate)
+{
+	struct ad7405_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_backend_oversampling_ratio_set(st->back, chan->scan_index, dec_rate);
+	if (ret)
+		return ret;
+
+	st->dec_rate = dec_rate;
+
+	return 0;
+}
+
+static int ad7405_get_scale(struct ad7405_state *st, int *val, int *val2)
+{
+	*val = st->info->full_scale_mv;
+	*val2 = st->info->channel.scan_type.realbits - 1;
+
+	return IIO_VAL_FRACTIONAL_LOG2;
+}
+
+static int ad7405_read_raw(struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan, int *val,
+			   int *val2, long info)
+{
+	struct ad7405_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		return ad7405_get_scale(st, val, val2);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = st->dec_rate;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, st->dec_rate);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 2 << (st->info->channel.scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7405_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val,
+			    int val2, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return ad7405_set_dec_rate(indio_dev, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7405_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = ad7405_dec_rates;
+		*length = ARRAY_SIZE(ad7405_dec_rates);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ad7405_iio_info = {
+	.read_raw = &ad7405_read_raw,
+	.write_raw = &ad7405_write_raw,
+	.read_avail = &ad7405_read_avail,
+};
+
+#define AD7405_IIO_CHANNEL {					\
+	.type = IIO_VOLTAGE,					\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+			BIT(IIO_CHAN_INFO_OFFSET),		\
+	.info_mask_shared_by_all = IIO_CHAN_INFO_SAMP_FREQ |	\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+	.info_mask_shared_by_all_available =			\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+	.indexed = 1,						\
+	.channel = 0,						\
+	.channel2 = 1,						\
+	.differential = 1,					\
+	.scan_index = 0,					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+	},							\
+}
+
+static const struct ad7405_chip_info ad7405_chip_info = {
+	.name = "AD7405",
+	.full_scale_mv = 320,
+	.channel = AD7405_IIO_CHANNEL,
+};
+
+static const struct ad7405_chip_info adum7701_chip_info = {
+	.name = "ADUM7701",
+	.full_scale_mv = 320,
+	.channel = AD7405_IIO_CHANNEL,
+};
+
+static const struct ad7405_chip_info adum7702_chip_info = {
+	.name = "ADUM7702",
+	.full_scale_mv = 64,
+	.channel = AD7405_IIO_CHANNEL,
+};
+
+static const struct ad7405_chip_info adum7703_chip_info = {
+	.name = "ADUM7703",
+	.full_scale_mv = 320,
+	.channel = AD7405_IIO_CHANNEL,
+};
+
+static const char * const ad7405_power_supplies[] = {
+	"vdd1",	"vdd2",
+};
+
+static int ad7405_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct ad7405_state *st;
+	struct clk *clk;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->info = device_get_match_data(dev);
+	if (!st->info)
+		return dev_err_probe(dev, -EINVAL, "no chip info\n");
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad7405_power_supplies),
+					     ad7405_power_supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get and enable supplies");
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	st->ref_frequency = clk_get_rate(clk);
+	if (!st->ref_frequency)
+		return -EINVAL;
+
+	indio_dev->dev.parent = dev;
+	indio_dev->name = st->info->name;
+	indio_dev->channels = &st->info->channel;
+	indio_dev->num_channels = 1;
+	indio_dev->info = &ad7405_iio_info;
+
+	st->back = devm_iio_backend_get(dev, NULL);
+	if (IS_ERR(st->back))
+		return dev_err_probe(dev, PTR_ERR(st->back),
+				     "failed to get IIO backend");
+
+	ret = iio_backend_chan_enable(st->back, 0);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_backend_enable(dev, st->back);
+	if (ret)
+		return ret;
+
+	ret = ad7405_set_dec_rate(indio_dev, &indio_dev->channels[0], 256);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+/* Match table for of_platform binding */
+static const struct of_device_id ad7405_of_match[] = {
+	{ .compatible = "adi,ad7405", .data = &ad7405_chip_info, },
+	{ .compatible = "adi,adum7701", .data = &adum7701_chip_info, },
+	{ .compatible = "adi,adum7702", .data = &adum7702_chip_info, },
+	{ .compatible = "adi,adum7703", .data = &adum7703_chip_info, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7405_of_match);
+
+static struct platform_driver ad7405_driver = {
+	.driver = {
+		.name = "ad7405",
+		.owner = THIS_MODULE,
+		.of_match_table = ad7405_of_match,
+	},
+	.probe = ad7405_probe,
+};
+module_platform_driver(ad7405_driver);
+
+MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
+MODULE_AUTHOR("Pop Ioan Daniel <pop.ioan-daniel@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7405 driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");
-- 
2.34.1



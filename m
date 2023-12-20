Return-Path: <linux-iio+bounces-1157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C5381A2AA
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 16:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341571F251FA
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 15:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E9940C04;
	Wed, 20 Dec 2023 15:31:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A133FE20;
	Wed, 20 Dec 2023 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKFBbLW020663;
	Wed, 20 Dec 2023 10:31:38 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3v42psr46g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 10:31:37 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3BKFVS3K005312
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Dec 2023 10:31:28 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 20 Dec
 2023 10:31:27 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 20 Dec 2023 10:31:26 -0500
Received: from [127.0.0.1] ([10.44.3.57])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BKFUxXC006998;
	Wed, 20 Dec 2023 10:31:20 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 20 Dec 2023 16:34:10 +0100
Subject: [PATCH v4 7/8] iio: adc: ad9467: convert to backend framework
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-iio-backend-v4-7-998e9148b692@analog.com>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
In-Reply-To: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703086446; l=16250;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=NJK5h0BB+nnLQ1F17BwWXT+FKdcJH1Y3+0ebPgCII78=;
 b=e3e9McOch8HWvz1eEJPQNRj8BTx+H+OH2VoyogL2a11xxWxmvKIq1datwhEuZidAaviCmXTug
 DhXzzipGty9Cbbfm9kgeTdkETuYCjWa3/FYFzwgdcHy8pp3HSfrD1Fa
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Khey_189yA8CSjUFgcwLwS4rKibI9s5v
X-Proofpoint-GUID: Khey_189yA8CSjUFgcwLwS4rKibI9s5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312200111

Convert the driver to use the new IIO backend framework. The device
functionality is expected to be the same (meaning no added or removed
features).

Also note this patch effectively breaks ABI and that's needed so we can
properly support this device and add needed features making use of the
new IIO framework.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +-
 drivers/iio/adc/ad9467.c | 282 ++++++++++++++++++++++++++++++-----------------
 2 files changed, 182 insertions(+), 102 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 4eebd5161419..10e0e340cdae 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -275,7 +275,7 @@ config AD799X
 config AD9467
 	tristate "Analog Devices AD9467 High Speed ADC driver"
 	depends on SPI
-	depends on ADI_AXI_ADC
+	select IIO_BACKEND
 	help
 	  Say yes here to build support for Analog Devices:
 	  * AD9467 16-Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 6581fce4ba95..c9f48ac19cd2 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -17,13 +17,12 @@
 #include <linux/of.h>
 
 
+#include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
 #include <linux/clk.h>
 
-#include <linux/iio/adc/adi-axi-adc.h>
-
 /*
  * ADI High-Speed ADC common spi interface registers
  * See Application-Note AN-877:
@@ -102,15 +101,20 @@
 #define AD9467_REG_VREF_MASK		0x0F
 
 struct ad9467_chip_info {
-	struct adi_axi_adc_chip_info	axi_adc_info;
-	unsigned int			default_output_mode;
-	unsigned int			vref_mask;
+	const char		*name;
+	unsigned int		id;
+	const struct		iio_chan_spec *channels;
+	unsigned int		num_channels;
+	const unsigned int	(*scale_table)[2];
+	int			num_scales;
+	unsigned long		max_rate;
+	unsigned int		default_output_mode;
+	unsigned int		vref_mask;
 };
 
-#define to_ad9467_chip_info(_info)	\
-	container_of(_info, struct ad9467_chip_info, axi_adc_info)
-
 struct ad9467_state {
+	const struct ad9467_chip_info	*info;
+	struct iio_backend		*back;
 	struct spi_device		*spi;
 	struct clk			*clk;
 	unsigned int			output_mode;
@@ -151,10 +155,10 @@ static int ad9467_spi_write(struct spi_device *spi, unsigned int reg,
 	return spi_write(spi, buf, ARRAY_SIZE(buf));
 }
 
-static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
+static int ad9467_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
 {
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	struct ad9467_state *st = iio_priv(indio_dev);
 	struct spi_device *spi = st->spi;
 	int ret;
 
@@ -191,14 +195,13 @@ static const unsigned int ad9467_scale_table[][2] = {
 	{2300, 8}, {2400, 9}, {2500, 10},
 };
 
-static void __ad9467_get_scale(struct adi_axi_adc_conv *conv, int index,
+static void __ad9467_get_scale(struct ad9467_state *st, int index,
 			       unsigned int *val, unsigned int *val2)
 {
-	const struct adi_axi_adc_chip_info *info = conv->chip_info;
-	const struct iio_chan_spec *chan = &info->channels[0];
+	const struct iio_chan_spec *chan = &st->info->channels[0];
 	unsigned int tmp;
 
-	tmp = (info->scale_table[index][0] * 1000000ULL) >>
+	tmp = (st->info->scale_table[index][0] * 1000000ULL) >>
 			chan->scan_type.realbits;
 	*val = tmp / 1000000;
 	*val2 = tmp % 1000000;
@@ -229,52 +232,43 @@ static const struct iio_chan_spec ad9467_channels[] = {
 };
 
 static const struct ad9467_chip_info ad9467_chip_tbl = {
-	.axi_adc_info = {
-		.name = "ad9467",
-		.id = CHIPID_AD9467,
-		.max_rate = 250000000UL,
-		.scale_table = ad9467_scale_table,
-		.num_scales = ARRAY_SIZE(ad9467_scale_table),
-		.channels = ad9467_channels,
-		.num_channels = ARRAY_SIZE(ad9467_channels),
-	},
+	.name = "ad9467",
+	.id = CHIPID_AD9467,
+	.max_rate = 250000000UL,
+	.scale_table = ad9467_scale_table,
+	.num_scales = ARRAY_SIZE(ad9467_scale_table),
+	.channels = ad9467_channels,
+	.num_channels = ARRAY_SIZE(ad9467_channels),
 	.default_output_mode = AD9467_DEF_OUTPUT_MODE,
 	.vref_mask = AD9467_REG_VREF_MASK,
 };
 
 static const struct ad9467_chip_info ad9434_chip_tbl = {
-	.axi_adc_info = {
-		.name = "ad9434",
-		.id = CHIPID_AD9434,
-		.max_rate = 500000000UL,
-		.scale_table = ad9434_scale_table,
-		.num_scales = ARRAY_SIZE(ad9434_scale_table),
-		.channels = ad9434_channels,
-		.num_channels = ARRAY_SIZE(ad9434_channels),
-	},
+	.name = "ad9434",
+	.id = CHIPID_AD9434,
+	.max_rate = 500000000UL,
+	.scale_table = ad9434_scale_table,
+	.num_scales = ARRAY_SIZE(ad9434_scale_table),
+	.channels = ad9434_channels,
+	.num_channels = ARRAY_SIZE(ad9434_channels),
 	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
 	.vref_mask = AD9434_REG_VREF_MASK,
 };
 
 static const struct ad9467_chip_info ad9265_chip_tbl = {
-	.axi_adc_info = {
-		.name = "ad9265",
-		.id = CHIPID_AD9265,
-		.max_rate = 125000000UL,
-		.scale_table = ad9265_scale_table,
-		.num_scales = ARRAY_SIZE(ad9265_scale_table),
-		.channels = ad9467_channels,
-		.num_channels = ARRAY_SIZE(ad9467_channels),
-	},
+	.name = "ad9265",
+	.id = CHIPID_AD9265,
+	.max_rate = 125000000UL,
+	.scale_table = ad9265_scale_table,
+	.num_scales = ARRAY_SIZE(ad9265_scale_table),
+	.channels = ad9467_channels,
+	.num_channels = ARRAY_SIZE(ad9467_channels),
 	.default_output_mode = AD9265_DEF_OUTPUT_MODE,
 	.vref_mask = AD9265_REG_VREF_MASK,
 };
 
-static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
+static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
 {
-	const struct adi_axi_adc_chip_info *info = conv->chip_info;
-	const struct ad9467_chip_info *info1 = to_ad9467_chip_info(info);
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
 	unsigned int i, vref_val;
 	int ret;
 
@@ -282,25 +276,23 @@ static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	vref_val = ret & info1->vref_mask;
+	vref_val = ret & st->info->vref_mask;
 
-	for (i = 0; i < info->num_scales; i++) {
-		if (vref_val == info->scale_table[i][1])
+	for (i = 0; i < st->info->num_scales; i++) {
+		if (vref_val == st->info->scale_table[i][1])
 			break;
 	}
 
-	if (i == info->num_scales)
+	if (i == st->info->num_scales)
 		return -ERANGE;
 
-	__ad9467_get_scale(conv, i, val, val2);
+	__ad9467_get_scale(st, i, val, val2);
 
 	return IIO_VAL_INT_PLUS_MICRO;
 }
 
-static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
+static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
 {
-	const struct adi_axi_adc_chip_info *info = conv->chip_info;
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
 	unsigned int scale_val[2];
 	unsigned int i;
 	int ret;
@@ -308,14 +300,14 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
 	if (val != 0)
 		return -EINVAL;
 
-	for (i = 0; i < info->num_scales; i++) {
-		__ad9467_get_scale(conv, i, &scale_val[0], &scale_val[1]);
+	for (i = 0; i < st->info->num_scales; i++) {
+		__ad9467_get_scale(st, i, &scale_val[0], &scale_val[1]);
 		if (scale_val[0] != val || scale_val[1] != val2)
 			continue;
 
 		guard(mutex)(&st->lock);
 		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
-				       info->scale_table[i][1]);
+				       st->info->scale_table[i][1]);
 		if (ret < 0)
 			return ret;
 
@@ -326,15 +318,15 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
 	return -EINVAL;
 }
 
-static int ad9467_read_raw(struct adi_axi_adc_conv *conv,
+static int ad9467_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long m)
 {
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	struct ad9467_state *st = iio_priv(indio_dev);
 
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
-		return ad9467_get_scale(conv, val, val2);
+		return ad9467_get_scale(st, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = clk_get_rate(st->clk);
 
@@ -344,20 +336,19 @@ static int ad9467_read_raw(struct adi_axi_adc_conv *conv,
 	}
 }
 
-static int ad9467_write_raw(struct adi_axi_adc_conv *conv,
+static int ad9467_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
 {
-	const struct adi_axi_adc_chip_info *info = conv->chip_info;
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	struct ad9467_state *st = iio_priv(indio_dev);
 	long r_clk;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		return ad9467_set_scale(conv, val, val2);
+		return ad9467_set_scale(st, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		r_clk = clk_round_rate(st->clk, val);
-		if (r_clk < 0 || r_clk > info->max_rate) {
+		if (r_clk < 0 || r_clk > st->info->max_rate) {
 			dev_warn(&st->spi->dev,
 				 "Error setting ADC sample rate %ld", r_clk);
 			return -EINVAL;
@@ -369,26 +360,53 @@ static int ad9467_write_raw(struct adi_axi_adc_conv *conv,
 	}
 }
 
-static int ad9467_read_avail(struct adi_axi_adc_conv *conv,
+static int ad9467_read_avail(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     const int **vals, int *type, int *length,
 			     long mask)
 {
-	const struct adi_axi_adc_chip_info *info = conv->chip_info;
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	struct ad9467_state *st = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		*vals = (const int *)st->scales;
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		/* Values are stored in a 2D matrix */
-		*length = info->num_scales * 2;
+		*length = st->info->num_scales * 2;
 		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
 }
 
+static int ad9467_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad9467_state *st = iio_priv(indio_dev);
+	unsigned int c;
+	int ret;
+
+	for (c = 0; c < st->info->num_channels; c++) {
+		if (test_bit(c, scan_mask))
+			ret = iio_backend_chan_enable(st->back, c);
+		else
+			ret = iio_backend_chan_disable(st->back, c);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct iio_info ad9467_info = {
+	.read_raw = ad9467_read_raw,
+	.write_raw = ad9467_write_raw,
+	.update_scan_mode = ad9467_update_scan_mode,
+	.debugfs_reg_access = ad9467_reg_access,
+	.read_avail = ad9467_read_avail,
+};
+
 static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
 {
 	int ret;
@@ -401,19 +419,17 @@ static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
 				AN877_ADC_TRANSFER_SYNC);
 }
 
-static int ad9467_scale_fill(struct adi_axi_adc_conv *conv)
+static int ad9467_scale_fill(struct ad9467_state *st)
 {
-	const struct adi_axi_adc_chip_info *info = conv->chip_info;
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
 	unsigned int i, val1, val2;
 
-	st->scales = devm_kmalloc_array(&st->spi->dev, info->num_scales,
+	st->scales = devm_kmalloc_array(&st->spi->dev, st->info->num_scales,
 					sizeof(*st->scales), GFP_KERNEL);
 	if (!st->scales)
 		return -ENOMEM;
 
-	for (i = 0; i < info->num_scales; i++) {
-		__ad9467_get_scale(conv, i, &val1, &val2);
+	for (i = 0; i < st->info->num_scales; i++) {
+		__ad9467_get_scale(st, i, &val1, &val2);
 		st->scales[i][0] = val1;
 		st->scales[i][1] = val2;
 	}
@@ -421,11 +437,27 @@ static int ad9467_scale_fill(struct adi_axi_adc_conv *conv)
 	return 0;
 }
 
-static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
+static int ad9467_setup(struct ad9467_state *st)
 {
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	struct iio_backend_data_fmt data = {
+		.sign_extend = true,
+		.enable = true,
+	};
+	unsigned int c, mode;
+	int ret;
+
+	mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+	ret = ad9467_outputmode_set(st->spi, mode);
+	if (ret)
+		return ret;
 
-	return ad9467_outputmode_set(st->spi, st->output_mode);
+	for (c = 0; c < st->info->num_channels; c++) {
+		ret = iio_backend_data_format_set(st->back, c, &data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int ad9467_reset(struct device *dev)
@@ -443,25 +475,63 @@ static int ad9467_reset(struct device *dev)
 	return 0;
 }
 
+static int ad9467_iio_backend_get(struct ad9467_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct device_node *__back;
+
+	st->back = devm_iio_backend_get_optional(&st->spi->dev, NULL);
+	if (IS_ERR(st->back))
+		return PTR_ERR(st->back);
+	if (st->back)
+		return 0;
+	/*
+	 * if we don't get the backend using the normal API's, use the legacy
+	 * 'adi,adc-dev' property. So we get all nodes with that property, and
+	 * look for the one pointing at us. Then we directly lookup that fwnode
+	 * on the backend list of registered devices. This is done so we don't
+	 * make io-backends mandatory which would break DT ABI.
+	 */
+	for_each_node_with_property(__back, "adi,adc-dev") {
+		struct device_node *__me;
+
+		__me = of_parse_phandle(__back, "adi,adc-dev", 0);
+		if (!__me)
+			continue;
+
+		if (!device_match_of_node(dev, __me)) {
+			of_node_put(__me);
+			continue;
+		}
+
+		of_node_put(__me);
+		st->back = devm_iio_backend_get_from_fwnode_lookup(dev,
+								   of_fwnode_handle(__back));
+		of_node_put(__back);
+		return PTR_ERR_OR_ZERO(st->back);
+	}
+
+	return -ENODEV;
+}
+
 static int ad9467_probe(struct spi_device *spi)
 {
-	const struct ad9467_chip_info *info;
-	struct adi_axi_adc_conv *conv;
+	struct iio_dev *indio_dev;
 	struct ad9467_state *st;
 	unsigned int id;
 	int ret;
 
-	info = spi_get_device_match_data(spi);
-	if (!info)
-		return -ENODEV;
-
-	conv = devm_adi_axi_adc_conv_register(&spi->dev, sizeof(*st));
-	if (IS_ERR(conv))
-		return PTR_ERR(conv);
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
 
-	st = adi_axi_adc_conv_priv(conv);
+	st = iio_priv(indio_dev);
 	st->spi = spi;
 
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -ENODEV;
+
 	st->clk = devm_clk_get_enabled(&spi->dev, "adc-clk");
 	if (IS_ERR(st->clk))
 		return PTR_ERR(st->clk);
@@ -475,29 +545,39 @@ static int ad9467_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	conv->chip_info = &info->axi_adc_info;
-
-	ret = ad9467_scale_fill(conv);
+	ret = ad9467_scale_fill(st);
 	if (ret)
 		return ret;
 
 	id = ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
-	if (id != conv->chip_info->id) {
+	if (id != st->info->id) {
 		dev_err(&spi->dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
-			id, conv->chip_info->id);
+			id, st->info->id);
 		return -ENODEV;
 	}
 
-	conv->reg_access = ad9467_reg_access;
-	conv->write_raw = ad9467_write_raw;
-	conv->read_raw = ad9467_read_raw;
-	conv->read_avail = ad9467_read_avail;
-	conv->preenable_setup = ad9467_preenable_setup;
+	indio_dev->name = st->info->name;
+	indio_dev->channels = st->info->channels;
+	indio_dev->num_channels = st->info->num_channels;
+	indio_dev->info = &ad9467_info;
 
-	st->output_mode = info->default_output_mode |
-			  AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+	ret = ad9467_iio_backend_get(st);
+	if (ret)
+		return ret;
 
-	return 0;
+	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_enable(st->back);
+	if (ret)
+		return ret;
+
+	ret = ad9467_setup(st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id ad9467_of_match[] = {
@@ -529,4 +609,4 @@ module_spi_driver(ad9467_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD9467 ADC driver");
 MODULE_LICENSE("GPL v2");
-MODULE_IMPORT_NS(IIO_ADI_AXI);
+MODULE_IMPORT_NS(IIO_BACKEND);

-- 
2.43.0



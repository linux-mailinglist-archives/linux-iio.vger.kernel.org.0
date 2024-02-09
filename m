Return-Path: <linux-iio+bounces-2339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAE984F875
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 16:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD6D1F23255
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 15:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DD4745DD;
	Fri,  9 Feb 2024 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cc0MVBJO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49696BB36;
	Fri,  9 Feb 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492388; cv=none; b=hBXtcifBarrAN2uHxqDkx6UwJMieiY5UOYxxty8reaHZEz4fj1q3ww5h8zTBkkEdkC/V1tUjBhfvBx3jQ3IPSItrf9wcGooXDhDn4YrPhrxLuJXblJBzgLA/wCGvVVpEMSf21095xqX1aGOZx+c6QA4IKlW51keZLHOYi5ghzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492388; c=relaxed/simple;
	bh=OsJU1gZVxQgLXk1PC4JBlad9jwNjENv4tpEuk2moH80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=grSzEn6LiE6daieEe+y3KWktmQa+mo2Qfikxos+f8/OLm9uDJsJySXTzxcCUcrJS2BYand4gwOEKQiGMJgtzwYeCDytwdPj48FipdBBLjomYfhBN5n9YWybV6kROjPCQ/JhAa/zyr7a8eChRUs1JZ2KwVXd++JbC1cSUCb9atS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cc0MVBJO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419B1XNH025442;
	Fri, 9 Feb 2024 10:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=VouaXdiYj/ocA4s3fUZJPZmmIdV+2bovkrSrNEAMis0=; b=
	cc0MVBJOQaLUnQOWBPPGHiUYB495B+dLUmthed2fLhYMecZtxsI0LajhLchBZosK
	CpQoSzWJKX0sZ7vtKeDyT4kR633M50/a9/FAW/3kKFfOs21GUXwP/vcH6e+W1X9n
	BWMLbptM39rkWp6TYDequaEtDwnSxNZAk+gJaol4p4mEFmFQS41/e3qZ/SwO7y8y
	NE3QJ+7U770+P4x7mnfy86JXGSPTfNYkDn7YCnoL54OHXguMTMne+vYeDprfhKAP
	UdJPmOYOwLvvNLtb92mp+PH50IOXSFxrbPsc+4/pyh9lG0CgXovSdwiRGDMZ8Zjp
	OeLt7IDXCKGXUCeIwH6Iug==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3w5bh6hvhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 10:26:04 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 419FPsNF047851
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 10:25:54 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 Feb 2024
 10:25:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 Feb 2024 10:25:53 -0500
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 419FPVJ6013228;
	Fri, 9 Feb 2024 10:25:48 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 9 Feb 2024 16:28:56 +0100
Subject: [PATCH v10 6/7] iio: adc: ad9467: convert to backend framework
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240209-iio-backend-v10-6-3ed842064318@analog.com>
References: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
In-Reply-To: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        <andy.shevchenko@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707492532; l=15974;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=OsJU1gZVxQgLXk1PC4JBlad9jwNjENv4tpEuk2moH80=;
 b=w86VOkkES5BOnPWiirVJpq5/5s13espa5AEAZjDfCplQJcqtcVsyxmdj0QhYhAPMyHCFPhDBD
 kp9X5/QazLoC6zLm2tPgboS4BFMMnG39Zke2dL3vXxi/7Ztyt/kCP15
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Jd7Cgi5FQK2VrYyH2in4omKG_lxQk9K-
X-Proofpoint-ORIG-GUID: Jd7Cgi5FQK2VrYyH2in4omKG_lxQk9K-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_12,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090114

Convert the driver to use the new IIO backend framework. The device
functionality is expected to be the same (meaning no added or removed
features).

Also note this patch effectively breaks ABI and that's needed so we can
properly support this device and add needed features making use of the
new IIO framework.

Given the lack of features (and devices supported) in the ad9467 driver
compared with the ADI out of tree version, we don't expect any user of
the upstream driver so no one should notice the ABI breakage. However,
if someone is affected by this, ADI will happily support transitioning
to the backend framework.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +-
 drivers/iio/adc/ad9467.c | 267 +++++++++++++++++++++++++++++++----------------
 2 files changed, 178 insertions(+), 91 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 59ae1d17b50d..61736dc21d2a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -307,7 +307,7 @@ config AD799X
 config AD9467
 	tristate "Analog Devices AD9467 High Speed ADC driver"
 	depends on SPI
-	depends on ADI_AXI_ADC
+	select IIO_BACKEND
 	help
 	  Say yes here to build support for Analog Devices:
 	  * AD9467 16-Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 6581fce4ba95..80b9e891c848 100644
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
 
@@ -191,10 +195,10 @@ static const unsigned int ad9467_scale_table[][2] = {
 	{2300, 8}, {2400, 9}, {2500, 10},
 };
 
-static void __ad9467_get_scale(struct adi_axi_adc_conv *conv, int index,
+static void __ad9467_get_scale(struct ad9467_state *st, int index,
 			       unsigned int *val, unsigned int *val2)
 {
-	const struct adi_axi_adc_chip_info *info = conv->chip_info;
+	const struct ad9467_chip_info *info = st->info;
 	const struct iio_chan_spec *chan = &info->channels[0];
 	unsigned int tmp;
 
@@ -229,52 +233,44 @@ static const struct iio_chan_spec ad9467_channels[] = {
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
+	const struct ad9467_chip_info *info = st->info;
 	unsigned int i, vref_val;
 	int ret;
 
@@ -282,7 +278,7 @@ static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	vref_val = ret & info1->vref_mask;
+	vref_val = ret & info->vref_mask;
 
 	for (i = 0; i < info->num_scales; i++) {
 		if (vref_val == info->scale_table[i][1])
@@ -292,15 +288,14 @@ static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
 	if (i == info->num_scales)
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
+	const struct ad9467_chip_info *info = st->info;
 	unsigned int scale_val[2];
 	unsigned int i;
 	int ret;
@@ -309,7 +304,7 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
 		return -EINVAL;
 
 	for (i = 0; i < info->num_scales; i++) {
-		__ad9467_get_scale(conv, i, &scale_val[0], &scale_val[1]);
+		__ad9467_get_scale(st, i, &scale_val[0], &scale_val[1]);
 		if (scale_val[0] != val || scale_val[1] != val2)
 			continue;
 
@@ -326,15 +321,15 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
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
 
@@ -344,17 +339,17 @@ static int ad9467_read_raw(struct adi_axi_adc_conv *conv,
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
+	const struct ad9467_chip_info *info = st->info;
 	long r_clk;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		return ad9467_set_scale(conv, val, val2);
+		return ad9467_set_scale(st, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		r_clk = clk_round_rate(st->clk, val);
 		if (r_clk < 0 || r_clk > info->max_rate) {
@@ -369,13 +364,13 @@ static int ad9467_write_raw(struct adi_axi_adc_conv *conv,
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
+	const struct ad9467_chip_info *info = st->info;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -389,6 +384,33 @@ static int ad9467_read_avail(struct adi_axi_adc_conv *conv,
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
@@ -401,10 +423,9 @@ static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
 				AN877_ADC_TRANSFER_SYNC);
 }
 
-static int ad9467_scale_fill(struct adi_axi_adc_conv *conv)
+static int ad9467_scale_fill(struct ad9467_state *st)
 {
-	const struct adi_axi_adc_chip_info *info = conv->chip_info;
-	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	const struct ad9467_chip_info *info = st->info;
 	unsigned int i, val1, val2;
 
 	st->scales = devm_kmalloc_array(&st->spi->dev, info->num_scales,
@@ -413,7 +434,7 @@ static int ad9467_scale_fill(struct adi_axi_adc_conv *conv)
 		return -ENOMEM;
 
 	for (i = 0; i < info->num_scales; i++) {
-		__ad9467_get_scale(conv, i, &val1, &val2);
+		__ad9467_get_scale(st, i, &val1, &val2);
 		st->scales[i][0] = val1;
 		st->scales[i][1] = val2;
 	}
@@ -421,11 +442,27 @@ static int ad9467_scale_fill(struct adi_axi_adc_conv *conv)
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
@@ -443,25 +480,65 @@ static int ad9467_reset(struct device *dev)
 	return 0;
 }
 
+static int ad9467_iio_backend_get(struct ad9467_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct device_node *__back;
+
+	st->back = devm_iio_backend_get(&st->spi->dev, NULL);
+	/* If not found, don't error out as we might have legacy DT property */
+	if (!IS_ERR(st->back))
+		return 0;
+	if (PTR_ERR(st->back) != -ENOENT)
+		return PTR_ERR(st->back);
+
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
+		st->back = __devm_iio_backend_get_from_fwnode_lookup(dev,
+								     of_fwnode_handle(__back));
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
@@ -475,29 +552,39 @@ static int ad9467_probe(struct spi_device *spi)
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
+	ret = devm_iio_backend_enable(&spi->dev, st->back);
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
@@ -529,4 +616,4 @@ module_spi_driver(ad9467_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD9467 ADC driver");
 MODULE_LICENSE("GPL v2");
-MODULE_IMPORT_NS(IIO_ADI_AXI);
+MODULE_IMPORT_NS(IIO_BACKEND);

-- 
2.43.0



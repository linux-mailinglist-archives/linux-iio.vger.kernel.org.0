Return-Path: <linux-iio+bounces-2389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D43E4850666
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 21:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C5FB24566
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 20:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCCE5FDDC;
	Sat, 10 Feb 2024 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjCIVWen"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F375FDB0;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707598642; cv=none; b=cxRjqKi6kn1jOxWZxA/Y645XQspU57BOLfosNrkVLG+tfOOFgYpmotRbmH6x5qNufa9FetbkJoo+IM+GebAKbQ/XaJbljx7fucMXinFfTGtt7SCfyRB/SA+8fCfIXyONPjFzURlvsBMpYePKpAM4nUAjCQyUIp+EeKK8hxxCVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707598642; c=relaxed/simple;
	bh=8vmHJ9AK4LD0hpXcrOHaXhkO7e/JxJtgNMDOYYXnNRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z4k24FKxZLi0JvBViyHsT9IRl/cPWNJW0N8rAiN5/ErO9OwsW5mE7P9tNTQt82gjlT04u/dwCbdslOBY0BQkeXUxwVGIPLDq87sAww1kSgL1226w1SElHEoabOzuWYDceBnHnn21PvCL90UozOd66ReuWL6+ujkSMOwERgFowyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjCIVWen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45869C43141;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707598641;
	bh=8vmHJ9AK4LD0hpXcrOHaXhkO7e/JxJtgNMDOYYXnNRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AjCIVWen3922HtmXMAdv6MSQChEslDqjCBIwNhT0TSHYaW9uDetyKh2pbdUV7ACC8
	 wGV338/k8beHVMUVjBdltKjC+s31b9oVyDwNSYLAVyB+a3CtkziIuN+MXlGs7E0wa7
	 lzcE+E4A5CIhLXPKBgkQ+zLFjN40U/uno5OtCmJ8aefJdqJH5AOZVxsIBhEUAE+W/H
	 h6sOx/FTW9h2Bnga+ECu9cLGxScMvsYsrTDmvPQyoB3ejblVV5rhOvFjceQ8HB9cE4
	 At1qBz7oBFmFq63BFceDmonLu0qDqq4V+q9qDQjq/WXMfDTsvhDCoTpT9W1M+qF5wL
	 W16xJyzJJWAgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE03C48260;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Sat, 10 Feb 2024 21:57:18 +0100
Subject: [PATCH v11 6/7] iio: adc: ad9467: convert to backend framework
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-iio-backend-v11-6-f5242a5fb42a@analog.com>
References: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com>
In-Reply-To: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, andy.shevchenko@gmail.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707598639; l=15964;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JFjg0ED5Ett8IddcCaR4E91FJQibiw/VeVq+dYn8GZ4=;
 b=sXtCHtYupRl4BcT+cNOcYI6eGv4ipOo2MuTVCmtjx7DZna0XlwgktNeZHwyhw4rTmrE/hXxgf
 Iw6aapU/oMEDab5VH+orTu18haEln6maN/a/FshInKMtxBQhvjIHAZf
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

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
index 6581fce4ba95..7475ec2a56c7 100644
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
+	st->back = devm_iio_backend_get(dev, NULL);
+	if (!IS_ERR(st->back))
+		return 0;
+	/* If not found, don't error out as we might have legacy DT property */
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



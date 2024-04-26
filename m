Return-Path: <linux-iio+bounces-4548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F038B3BF1
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 17:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBF3B24562
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83031156F48;
	Fri, 26 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0zVGimU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9E156647;
	Fri, 26 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146150; cv=none; b=iU0ufySnb5xaqRR7k6QxYGUXMXY7aZB6sbLyygbORujT56HY8iH33MYuPLBjUU7GzYlUXUw6Q116R2u1FFAXVWCejtdpuj5sTmhjD7eXN7gwUy17kIYAYi6GLPlGJaHT23xVo2SYlYQRkG8KkwmcPJlFJra3S7S6rEyjHNnC+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146150; c=relaxed/simple;
	bh=bFXzZE8rp8xYtcNt17dPfzmcWbRwDJSvsfBAhSRN8es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eABtCwQuGPkZYHi96Jy53SGV2IxL4qUziCOTLu/uj18Xz/V+PAwBWQlM0FC2b0fmFKYtlHJ65mXPRLmH9mTFspe/LcRTfvYtnSPrC3KldRLg8GeFQX7kICr0aWnalBtuHRyIdzRmevu6mFFuWsN00XNmcSITfWtvGI5Ry/iuQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0zVGimU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E27B1C4AF17;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714146149;
	bh=bFXzZE8rp8xYtcNt17dPfzmcWbRwDJSvsfBAhSRN8es=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Q0zVGimU3Zi6DoZZ/KMg+weAfhnnR86cAdFa4GjDQDD9jYdZXnYrrQifLDipsJv5k
	 KVN55zxSg1HWfIqmj2nX9UOMqv8n7rYh1VCiBCUEpIV2T4i1yYPHfYNrtlSTPvGlDS
	 EnLrR++7TnKPuvwPy2Bbl4SfVob81lKYgGvamEjUZaYeBuG8MFRWh0jZ+7b4nNpQJN
	 PTUwrPB23itcXW10iUjOeWB2gBapgRY5r9UcGb3+ag9cbT8zwGETvw3K8IHPBq8+He
	 sj0h1F4ioOXApac89+RM7wgZmAYmEpmAxZVVZdY6t0YT5q4u52ZWKKRNz+RPZ6kPZ3
	 4r5c4WFFSV7+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92A7C25B4F;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Apr 2024 17:42:16 +0200
Subject: [PATCH v2 7/7] iio: adc: ad9467: support digital interface
 calibration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-ad9467-new-features-v2-7-6361fc3ba1cc@analog.com>
References: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
In-Reply-To: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714146147; l=13813;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=i70w3MTt/Sp8zZWwI0DZ2SxpTPdPrQ43/++pS/Ib7LU=;
 b=/cu8Vn07lNwpvUlfh4ebNQppG0NAgs6aw+8HpXF2t26ME5wCSU4/Mql56K7ya5Fog7bMYZJKh
 JBGNJNnxi/YB4oAq4nnuJrUrikGWhIkfZaHm+7QZyMFA4q1AZ3PXstO
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

To make sure that we have the best timings on the serial data interface
we should calibrate it. This means going through the device supported
values and see for which ones we get a successful result. To do that, we
use a prbs test pattern both in the IIO backend and in the frontend
devices. Then for each of the test points we see if there are any
errors. Note that the backend is responsible to look for those errors.

As calibrating the interface also requires that the data format is disabled
(the one thing being done in ad9467_setup()), ad9467_setup() was removed
and configuring the data fomat is now part of the calibration process.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 374 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 335 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 7475ec2a56c7..e85b763b9ffc 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -4,7 +4,11 @@
  *
  * Copyright 2012-2020 Analog Devices Inc.
  */
+
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
 #include <linux/cleanup.h>
+#include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
@@ -100,6 +104,8 @@
 #define AD9467_DEF_OUTPUT_MODE		0x08
 #define AD9467_REG_VREF_MASK		0x0F
 
+#define AD9647_MAX_TEST_POINTS		32
+
 struct ad9467_chip_info {
 	const char		*name;
 	unsigned int		id;
@@ -110,6 +116,9 @@ struct ad9467_chip_info {
 	unsigned long		max_rate;
 	unsigned int		default_output_mode;
 	unsigned int		vref_mask;
+	unsigned int		num_lanes;
+	/* data clock output */
+	bool			has_dco;
 };
 
 struct ad9467_state {
@@ -119,7 +128,16 @@ struct ad9467_state {
 	struct clk			*clk;
 	unsigned int			output_mode;
 	unsigned int                    (*scales)[2];
-
+	/*
+	 * Times 2 because we may also invert the signal polarity and run the
+	 * calibration again. For some reference on the test points (ad9265) see:
+	 * https://www.analog.com/media/en/technical-documentation/data-sheets/ad9265.pdf
+	 * at page 38 for the dco output delay. On devices as ad9467, the
+	 * calibration is done at the backend level. For the ADI axi-adc:
+	 * https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+	 * at the io delay control section.
+	 */
+	DECLARE_BITMAP(calib_map, AD9647_MAX_TEST_POINTS * 2);
 	struct gpio_desc		*pwrdown_gpio;
 	/* ensure consistent state obtained on multiple related accesses */
 	struct mutex			lock;
@@ -242,6 +260,7 @@ static const struct ad9467_chip_info ad9467_chip_tbl = {
 	.num_channels = ARRAY_SIZE(ad9467_channels),
 	.default_output_mode = AD9467_DEF_OUTPUT_MODE,
 	.vref_mask = AD9467_REG_VREF_MASK,
+	.num_lanes = 8,
 };
 
 static const struct ad9467_chip_info ad9434_chip_tbl = {
@@ -254,6 +273,7 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
 	.num_channels = ARRAY_SIZE(ad9434_channels),
 	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
 	.vref_mask = AD9434_REG_VREF_MASK,
+	.num_lanes = 6,
 };
 
 static const struct ad9467_chip_info ad9265_chip_tbl = {
@@ -266,6 +286,7 @@ static const struct ad9467_chip_info ad9265_chip_tbl = {
 	.num_channels = ARRAY_SIZE(ad9467_channels),
 	.default_output_mode = AD9265_DEF_OUTPUT_MODE,
 	.vref_mask = AD9265_REG_VREF_MASK,
+	.has_dco = true,
 };
 
 static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
@@ -321,6 +342,246 @@ static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
 	return -EINVAL;
 }
 
+static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
+{
+	int ret;
+
+	ret = ad9467_spi_write(spi, AN877_ADC_REG_OUTPUT_MODE, mode);
+	if (ret < 0)
+		return ret;
+
+	return ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
+				AN877_ADC_TRANSFER_SYNC);
+}
+
+static int ad9647_calibrate_prepare(const struct ad9467_state *st)
+{
+	struct iio_backend_data_fmt data = {
+		.enable = false,
+	};
+	unsigned int c;
+	int ret;
+
+	ret = ad9467_spi_write(st->spi, AN877_ADC_REG_TEST_IO,
+			       AN877_ADC_TESTMODE_PN9_SEQ);
+	if (ret)
+		return ret;
+
+	ret = ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+			       AN877_ADC_TRANSFER_SYNC);
+	if (ret)
+		return ret;
+
+	ret = ad9467_outputmode_set(st->spi, st->info->default_output_mode);
+	if (ret)
+		return ret;
+
+	for (c = 0; c < st->info->num_channels; c++) {
+		ret = iio_backend_data_format_set(st->back, c, &data);
+		if (ret)
+			return ret;
+	}
+
+	ret = iio_backend_test_pattern_set(st->back, 0,
+					   IIO_BACKEND_ADI_PRBS_9A);
+	if (ret)
+		return ret;
+
+	return iio_backend_chan_enable(st->back, 0);
+}
+
+static int ad9647_calibrate_polarity_set(const struct ad9467_state *st,
+					 bool invert)
+{
+	enum iio_backend_sample_trigger trigger;
+
+	if (st->info->has_dco) {
+		unsigned int phase = AN877_ADC_OUTPUT_EVEN_ODD_MODE_EN;
+
+		if (invert)
+			phase |= AN877_ADC_INVERT_DCO_CLK;
+
+		return ad9467_spi_write(st->spi, AN877_ADC_REG_OUTPUT_PHASE,
+					phase);
+	}
+
+	if (invert)
+		trigger = IIO_BACKEND_SAMPLE_TRIGGER_EDGE_FALLING;
+	else
+		trigger = IIO_BACKEND_SAMPLE_TRIGGER_EDGE_RISING;
+
+	return iio_backend_data_sample_trigger(st->back, trigger);
+}
+
+/*
+ * The idea is pretty simple. Find the max number of successful points in a row
+ * and get the one in the middle.
+ */
+static unsigned int ad9467_find_optimal_point(const unsigned long *calib_map,
+					      unsigned int start,
+					      unsigned int nbits,
+					      unsigned int *val)
+{
+	unsigned int bit = start, end, start_cnt, cnt = 0;
+
+	for_each_clear_bitrange_from(bit, end, calib_map, nbits + start) {
+		if (end - bit > cnt) {
+			cnt = end - bit;
+			start_cnt = bit;
+		}
+	}
+
+	if (cnt)
+		*val = start_cnt + cnt / 2;
+
+	return cnt;
+}
+
+static int ad9467_calibrate_apply(const struct ad9467_state *st,
+				  unsigned int val)
+{
+	unsigned int lane;
+	int ret;
+
+	if (st->info->has_dco) {
+		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_OUTPUT_DELAY,
+				       val);
+		if (ret)
+			return ret;
+
+		return ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+					AN877_ADC_TRANSFER_SYNC);
+	}
+
+	for (lane = 0; lane < st->info->num_lanes; lane++) {
+		ret = iio_backend_iodelay_set(st->back, lane, val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ad9647_calibrate_stop(const struct ad9467_state *st)
+{
+	struct iio_backend_data_fmt data = {
+		.sign_extend = true,
+		.enable = true,
+	};
+	unsigned int c, mode;
+	int ret;
+
+	ret = iio_backend_chan_disable(st->back, 0);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_test_pattern_set(st->back, 0,
+					   IIO_BACKEND_NO_TEST_PATTERN);
+	if (ret)
+		return ret;
+
+	for (c = 0; c < st->info->num_channels; c++) {
+		ret = iio_backend_data_format_set(st->back, c, &data);
+		if (ret)
+			return ret;
+	}
+
+	mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+	ret = ad9467_outputmode_set(st->spi, mode);
+	if (ret)
+		return ret;
+
+	ret = ad9467_spi_write(st->spi, AN877_ADC_REG_TEST_IO,
+			       AN877_ADC_TESTMODE_OFF);
+	if (ret)
+		return ret;
+
+	return ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+			       AN877_ADC_TRANSFER_SYNC);
+}
+
+static int ad9467_calibrate(struct ad9467_state *st)
+{
+	unsigned int point, val, inv_val, cnt, inv_cnt = 0;
+	/*
+	 * Half of the bitmap is for the inverted signal. The number of test
+	 * points is the same though...
+	 */
+	unsigned int test_points = AD9647_MAX_TEST_POINTS;
+	unsigned long sample_rate = clk_get_rate(st->clk);
+	struct device *dev = &st->spi->dev;
+	bool invert = false, stat;
+	int ret;
+
+	/* all points invalid */
+	bitmap_fill(st->calib_map, BITS_PER_TYPE(st->calib_map));
+
+	ret = ad9647_calibrate_prepare(st);
+	if (ret)
+		return ret;
+retune:
+	ret = ad9647_calibrate_polarity_set(st, invert);
+	if (ret)
+		return ret;
+
+	for (point = 0; point < test_points; point++) {
+		ret = ad9467_calibrate_apply(st, point);
+		if (ret)
+			return ret;
+
+		ret = iio_backend_chan_status(st->back, 0, &stat);
+		if (ret)
+			return ret;
+
+		__assign_bit(point + invert * test_points, st->calib_map, stat);
+	}
+
+	if (!invert) {
+		cnt = ad9467_find_optimal_point(st->calib_map, 0, test_points,
+						&val);
+		/*
+		 * We're happy if we find, at least, three good test points in
+		 * a row.
+		 */
+		if (cnt < 3) {
+			invert = true;
+			goto retune;
+		}
+	} else {
+		inv_cnt = ad9467_find_optimal_point(st->calib_map, test_points,
+						    test_points, &inv_val);
+		if (!inv_cnt && !cnt)
+			return -EIO;
+	}
+
+	if (inv_cnt < cnt) {
+		ret = ad9647_calibrate_polarity_set(st, false);
+		if (ret)
+			return ret;
+	} else {
+		/*
+		 * polarity inverted is the last test to run. Hence, there's no
+		 * need to re-do any configuration. We just need to "normalize"
+		 * the selected value.
+		 */
+		val = inv_val - test_points;
+	}
+
+	if (st->info->has_dco)
+		dev_dbg(dev, "%sDCO 0x%X CLK %lu Hz\n", inv_cnt >= cnt ? "INVERT " : "",
+			val, sample_rate);
+	else
+		dev_dbg(dev, "%sIDELAY 0x%x\n", inv_cnt >= cnt ? "INVERT " : "",
+			val);
+
+	ret = ad9467_calibrate_apply(st, val);
+	if (ret)
+		return ret;
+
+	/* finally apply the optimal value */
+	return ad9647_calibrate_stop(st);
+}
+
 static int ad9467_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long m)
@@ -345,7 +606,9 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad9467_state *st = iio_priv(indio_dev);
 	const struct ad9467_chip_info *info = st->info;
+	unsigned long sample_rate;
 	long r_clk;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -358,7 +621,23 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
-		return clk_set_rate(st->clk, r_clk);
+		sample_rate = clk_get_rate(st->clk);
+		/*
+		 * clk_set_rate() would also do this but since we would still
+		 * need it for avoiding an unnecessary calibration, do it now.
+		 */
+		if (sample_rate == r_clk)
+			return 0;
+
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			ret = clk_set_rate(st->clk, r_clk);
+			if (ret)
+				return ret;
+
+			guard(mutex)(&st->lock);
+			ret = ad9467_calibrate(st);
+		}
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -411,18 +690,6 @@ static const struct iio_info ad9467_info = {
 	.read_avail = ad9467_read_avail,
 };
 
-static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
-{
-	int ret;
-
-	ret = ad9467_spi_write(spi, AN877_ADC_REG_OUTPUT_MODE, mode);
-	if (ret < 0)
-		return ret;
-
-	return ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
-				AN877_ADC_TRANSFER_SYNC);
-}
-
 static int ad9467_scale_fill(struct ad9467_state *st)
 {
 	const struct ad9467_chip_info *info = st->info;
@@ -442,29 +709,6 @@ static int ad9467_scale_fill(struct ad9467_state *st)
 	return 0;
 }
 
-static int ad9467_setup(struct ad9467_state *st)
-{
-	struct iio_backend_data_fmt data = {
-		.sign_extend = true,
-		.enable = true,
-	};
-	unsigned int c, mode;
-	int ret;
-
-	mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
-	ret = ad9467_outputmode_set(st->spi, mode);
-	if (ret)
-		return ret;
-
-	for (c = 0; c < st->info->num_channels; c++) {
-		ret = iio_backend_data_format_set(st->back, c, &data);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static int ad9467_reset(struct device *dev)
 {
 	struct gpio_desc *gpio;
@@ -521,6 +765,52 @@ static int ad9467_iio_backend_get(struct ad9467_state *st)
 	return -ENODEV;
 }
 
+static ssize_t ad9467_dump_calib_table(struct file *file,
+				       char __user *userbuf,
+				       size_t count, loff_t *ppos)
+{
+	struct ad9467_state *st = file->private_data;
+	unsigned int bit, size = BITS_PER_TYPE(st->calib_map);
+	/* +2 for the newline and +1 for the string termination */
+	unsigned char map[AD9647_MAX_TEST_POINTS * 2 + 3];
+	ssize_t len = 0;
+
+	guard(mutex)(&st->lock);
+	if (*ppos)
+		goto out_read;
+
+	for (bit = 0; bit < size; bit++) {
+		if (bit == size / 2)
+			len += scnprintf(map + len, sizeof(map) - len, "\n");
+
+		len += scnprintf(map + len, sizeof(map) - len, "%c",
+				 test_bit(bit, st->calib_map) ? 'x' : 'o');
+	}
+
+	len += scnprintf(map + len, sizeof(map) - len, "\n");
+out_read:
+	return simple_read_from_buffer(userbuf, count, ppos, map, len);
+}
+
+static const struct file_operations ad9467_calib_table_fops = {
+	.open = simple_open,
+	.read = ad9467_dump_calib_table,
+	.llseek = default_llseek,
+	.owner = THIS_MODULE,
+};
+
+static void ad9467_debugfs_init(struct iio_dev *indio_dev)
+{
+	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+	struct ad9467_state *st = iio_priv(indio_dev);
+
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+
+	debugfs_create_file("calibration_table_dump", 0400, d, st,
+			    &ad9467_calib_table_fops);
+}
+
 static int ad9467_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -580,11 +870,17 @@ static int ad9467_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = ad9467_setup(st);
+	ret = ad9467_calibrate(st);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	ad9467_debugfs_init(indio_dev);
+
+	return 0;
 }
 
 static const struct of_device_id ad9467_of_match[] = {

-- 
2.44.0




Return-Path: <linux-iio+bounces-4372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FB78AB21A
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 17:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D847285E81
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABBB136669;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTFmBzYT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF5A134416;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541012; cv=none; b=qHrd11TzzV36rFwqjTU+X59dowAEBeFJIHHKCmOAan/v0YSGGydBuD26h9rp/O6rrv6LWfnxnV5KAqI2UacThr9DVvtcf3vwIz5x3kWjIQ1TIlEdM72XOBCfVPdCZWzw+VuY7QJNhQgr+/9rKcLl3XDabR7u2ZW7y+IW0Dix7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541012; c=relaxed/simple;
	bh=+DGHBdnrTYRitHjsY9XAZPyW9GtYKlA/s3wxV5NPYoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8j81m6iizLh51jfFTPk2huriPtZsCfks9ojCfuY5W/LnU3inxuo09ax3Bd4z7u2SeV1zxwBrA9O0SUBrDKOb1mUkqGmGygtwtF9No7PXUnYuwUW/IoEQJGHVa27C1aXDBZ3YKfa4aFMO4G8lMq1kJ+1vcKHpfgDavIOREmRYZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTFmBzYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EA68C2BD10;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713541012;
	bh=+DGHBdnrTYRitHjsY9XAZPyW9GtYKlA/s3wxV5NPYoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pTFmBzYTOiHB3krBGT2/jQxXh5Fa+34mBEQRjv4IQmBR/spD514a2XrPcC502smuJ
	 FYyXQh4WcrRsW/uPwepBq/v6ebu3LTbs7OXf3usHJDV2qcE9ddcdW4xXLi67Zx85Xj
	 65WsjPDVF6uyKbnK+h/2sobP6LyhYp2Bq5qyWHQjtJF8bjQuTJCnxqIAqN0W6uDd5g
	 ysCFGa8QbQSUfZqn86GcMOBKNlf2VdClJtT4HLd5TeiJHR+1VpgrDfYDxeZkmIssA3
	 5fAHMuHGtVJ11r/mYknu8KuyfDy8BkvqhGGAwXMgXZom5oiULRgDFjBKNmLRsuXUek
	 MTGc86jVEtcQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758DAC4345F;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Apr 2024 17:36:51 +0200
Subject: [PATCH 8/8] iio: adc: ad9467: support digital interface
 calibration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-ad9467-new-features-v1-8-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
In-Reply-To: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713541010; l=11433;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=u8Tbte3YlvHi71mA8qJNTe770otJEy1OCeXGxPuLYyg=;
 b=brBhJ2v2ZGqz3S/MqlvurO/FklUWTZlyFe1cfBPLd1IJv4TxJCLGHTKAxSWOvF/X7zWEvEij3
 QAQ8H+/R+dRCMO4y8ugyU0a/Q+Xj0ikIILYmaxL5lWRQybbF9ncul4K
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
 drivers/iio/adc/ad9467.c | 337 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 296 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 7db87ccc1ea4..44552dd6f4c6 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -4,6 +4,9 @@
  *
  * Copyright 2012-2020 Analog Devices Inc.
  */
+
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -100,6 +103,8 @@
 #define AD9467_DEF_OUTPUT_MODE		0x08
 #define AD9467_REG_VREF_MASK		0x0F
 
+#define AD9647_MAX_TEST_POINTS		32
+
 struct ad9467_chip_info {
 	const char		*name;
 	unsigned int		id;
@@ -110,6 +115,8 @@ struct ad9467_chip_info {
 	unsigned long		max_rate;
 	unsigned int		default_output_mode;
 	unsigned int		vref_mask;
+	unsigned int		num_lanes;
+	bool			has_dco;
 };
 
 struct ad9467_state {
@@ -243,6 +250,7 @@ static const struct ad9467_chip_info ad9467_chip_tbl = {
 	.num_channels = ARRAY_SIZE(ad9467_channels),
 	.default_output_mode = AD9467_DEF_OUTPUT_MODE,
 	.vref_mask = AD9467_REG_VREF_MASK,
+	.num_lanes = 8,
 };
 
 static const struct ad9467_chip_info ad9434_chip_tbl = {
@@ -255,6 +263,7 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
 	.num_channels = ARRAY_SIZE(ad9434_channels),
 	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
 	.vref_mask = AD9434_REG_VREF_MASK,
+	.num_lanes = 6,
 };
 
 static const struct ad9467_chip_info ad9265_chip_tbl = {
@@ -267,6 +276,7 @@ static const struct ad9467_chip_info ad9265_chip_tbl = {
 	.num_channels = ARRAY_SIZE(ad9467_channels),
 	.default_output_mode = AD9265_DEF_OUTPUT_MODE,
 	.vref_mask = AD9265_REG_VREF_MASK,
+	.has_dco = true,
 };
 
 static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
@@ -322,6 +332,276 @@ static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
 	return -EINVAL;
 }
 
+static void ad9467_dump_table(const unsigned long *err_map, unsigned int size,
+			      bool invert)
+{
+#ifdef DEBUG
+	unsigned int bit;
+
+	pr_debug("Dump calibration table:\n");
+	for (bit = 0; bit < size; bit++) {
+		if (bit == size / 2) {
+			if (!invert)
+				break;
+			pr_cont("\n");
+		}
+
+		pr_cont("%c", test_bit(bit, err_map) ? 'x' : 'o');
+	}
+#endif
+}
+
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
+static int ad9467_calibrate_status_check(const struct ad9467_state *st,
+					 bool *stat)
+{
+	struct iio_backend_chan_status status = {0};
+	int ret;
+
+	ret = iio_backend_chan_status(st->back, 0, &status);
+	if (ret)
+		return ret;
+
+	*stat = status.errors;
+
+	return 0;
+}
+
+/*
+ * The idea is pretty simple. Find the max number of successful points in a row
+ * and get the one in the middle.
+ */
+static unsigned int ad9467_find_optimal_point(const unsigned long *err_map,
+					      unsigned int start,
+					      unsigned int nbits,
+					      unsigned int *val)
+{
+	unsigned int bit = start, end, start_cnt, cnt = 0;
+
+	for_each_clear_bitrange_from(bit, end, err_map, nbits + start) {
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
+		int ret;
+
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
+static int ad9467_calibrate(const struct ad9467_state *st)
+{
+	DECLARE_BITMAP(err_map, AD9647_MAX_TEST_POINTS * 2);
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
+		ret = ad9467_calibrate_status_check(st, &stat);
+		if (ret < 0)
+			return ret;
+
+		__assign_bit(point + invert * test_points, err_map, stat);
+	}
+
+	if (!invert) {
+		cnt = ad9467_find_optimal_point(err_map, 0, test_points, &val);
+		/*
+		 * We're happy if we find, at least, three good test points in
+		 * a row.
+		 */
+		if (cnt < 3) {
+			invert = true;
+			goto retune;
+		}
+	} else {
+		inv_cnt = ad9467_find_optimal_point(err_map, test_points,
+						    test_points, &inv_val);
+		if (!inv_cnt && !cnt)
+			return -EIO;
+	}
+
+	ad9467_dump_table(err_map, BITS_PER_TYPE(err_map), invert);
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
@@ -360,12 +640,22 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
-		ret = clk_set_rate(st->clk, r_clk);
-		if (ret)
-			return ret;
+		/*
+		 * clk_set_rate() would also do this but since we would still
+		 * need it for avoiding an unnecessary calibration, do it now.
+		 */
+		if (st->sample_rate == r_clk)
+			return 0;
 
-		st->sample_rate = r_clk;
-		return 0;
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			ret = clk_set_rate(st->clk, r_clk);
+			if (ret)
+				return ret;
+
+			st->sample_rate = r_clk;
+			ret = ad9467_calibrate(st);
+		}
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -418,18 +708,6 @@ static const struct iio_info ad9467_info = {
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
@@ -449,29 +727,6 @@ static int ad9467_scale_fill(struct ad9467_state *st)
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
@@ -589,7 +844,7 @@ static int ad9467_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = ad9467_setup(st);
+	ret = ad9467_calibrate(st);
 	if (ret)
 		return ret;
 

-- 
2.44.0




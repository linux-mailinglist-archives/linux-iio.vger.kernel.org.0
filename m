Return-Path: <linux-iio+bounces-5174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152D48CC1A2
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 14:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA091C21CA1
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58C482498;
	Wed, 22 May 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cphe6hGg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E6817C9
	for <linux-iio@vger.kernel.org>; Wed, 22 May 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716382447; cv=none; b=CWAZ+76ddcSUV0HOrpsSdDxEQ2qO05D/EmzRWs7pqvLDDrtVGAn46Cy3STxtxnGP8AEvMP2mmK6dh7vTVhdt35emy10aUOBbFhJyzGyJuZQ9XgLZdu43ZbWuwclExeIzOmRrHk9Zm+x6k9xwEAOdutuQv+ivcnv/szcI6lByKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716382447; c=relaxed/simple;
	bh=PvzQvLW6BZ0EvGMt3Px/KrUIJ+RglGklVir5+/1nl7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLFh2yHUmh9mWBGygjAOQjmx+/9xONZobfdsmndM4h3D0gHvkdL6NtpiUST2ZX8AlB5hqN9zeNAlVopzmIuGdud+EU4xI/w2uQrXvCTzrDbDxmOmWh7g57G9Te7QGUUDfUOeKLwJdOEK6iDBhNaNjmXy3zHSVjzSDnA15XBDKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cphe6hGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01453C32789;
	Wed, 22 May 2024 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716382447;
	bh=PvzQvLW6BZ0EvGMt3Px/KrUIJ+RglGklVir5+/1nl7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cphe6hGg0HTpzsWyH5h3OrdKuH1qE5ZHaD39+w7rm+g5ddWS6ftA3+39wSV83KKnU
	 CUAbwBfci2TtUUdkNkRtRPtEwsELEuchoXVmCIC2/Sjds+a9wc7wFBCgw1v2HUP+Fg
	 olbujq9TYVplovcgYZeJv9NDvCT4KFAXs9FyI2CQAgF0gcsAWL2RvuFwllFq2O0U/D
	 prOP8I9EVfJT4wD2PnqGak4AVivSywm5Kpf6F38RpkB2jHDexNXFbznE3PlHDO3SJy
	 pFDj7ZbTF1akBoEddz+1RSEDvhkBQy958jUold2ZfictsXDDRSxOGIqMi4QAGbg6iH
	 reMxu0AKy+IjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC700C25B7C;
	Wed, 22 May 2024 12:54:06 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 22 May 2024 14:54:05 +0200
Subject: [PATCH v2 1/2] iio: adc: ad9467: use DMA safe buffer for spi
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-dev-ad9467-dma-v2-1-a37bec463632@analog.com>
References: <20240522-dev-ad9467-dma-v2-0-a37bec463632@analog.com>
In-Reply-To: <20240522-dev-ad9467-dma-v2-0-a37bec463632@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716382445; l=7496;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=EJrvFIZup8dEeo6Sd5E2b/bJwglBmPlzMRcY62m6/Z4=;
 b=EwNuA0b8mMaXbnW8gX/EANFxKOMTGC7j+IK72LGmHJh/8V7ywP4iZYKHOMUxjx358dFdrAzYw
 GGfE+dBfXNuBQN9dyfH2S1rvG5ocPsfjGVJ+eDKzgWamkWNB+QuWvHu
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Make sure we use a DMA safe buffer (IIO_DMA_MINALIGN) for all the spi
transfers. Only relevant for writes since for reads
spi_write_then_read() is used which does not require DMA safe buffers.

Also note that for consistency, ad9467_spi_read() is also taking struct
ad9467_state as a parameter (even if not really needed).

Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 65 +++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index e85b763b9ffcb..3571cfe0f9cc2 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -141,9 +141,10 @@ struct ad9467_state {
 	struct gpio_desc		*pwrdown_gpio;
 	/* ensure consistent state obtained on multiple related accesses */
 	struct mutex			lock;
+	u8				buf[3] __aligned(IIO_DMA_MINALIGN);
 };
 
-static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
+static int ad9467_spi_read(struct ad9467_state *st, unsigned int reg)
 {
 	unsigned char tbuf[2], rbuf[1];
 	int ret;
@@ -151,7 +152,7 @@ static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
 	tbuf[0] = 0x80 | (reg >> 8);
 	tbuf[1] = reg & 0xFF;
 
-	ret = spi_write_then_read(spi,
+	ret = spi_write_then_read(st->spi,
 				  tbuf, ARRAY_SIZE(tbuf),
 				  rbuf, ARRAY_SIZE(rbuf));
 
@@ -161,35 +162,32 @@ static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
 	return rbuf[0];
 }
 
-static int ad9467_spi_write(struct spi_device *spi, unsigned int reg,
+static int ad9467_spi_write(struct ad9467_state *st, unsigned int reg,
 			    unsigned int val)
 {
-	unsigned char buf[3];
+	st->buf[0] = reg >> 8;
+	st->buf[1] = reg & 0xFF;
+	st->buf[2] = val;
 
-	buf[0] = reg >> 8;
-	buf[1] = reg & 0xFF;
-	buf[2] = val;
-
-	return spi_write(spi, buf, ARRAY_SIZE(buf));
+	return spi_write(st->spi, st->buf, ARRAY_SIZE(st->buf));
 }
 
 static int ad9467_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
 {
 	struct ad9467_state *st = iio_priv(indio_dev);
-	struct spi_device *spi = st->spi;
 	int ret;
 
 	if (!readval) {
 		guard(mutex)(&st->lock);
-		ret = ad9467_spi_write(spi, reg, writeval);
+		ret = ad9467_spi_write(st, reg, writeval);
 		if (ret)
 			return ret;
-		return ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
+		return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
 					AN877_ADC_TRANSFER_SYNC);
 	}
 
-	ret = ad9467_spi_read(spi, reg);
+	ret = ad9467_spi_read(st, reg);
 	if (ret < 0)
 		return ret;
 	*readval = ret;
@@ -295,7 +293,7 @@ static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
 	unsigned int i, vref_val;
 	int ret;
 
-	ret = ad9467_spi_read(st->spi, AN877_ADC_REG_VREF);
+	ret = ad9467_spi_read(st, AN877_ADC_REG_VREF);
 	if (ret < 0)
 		return ret;
 
@@ -330,31 +328,31 @@ static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
 			continue;
 
 		guard(mutex)(&st->lock);
-		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
+		ret = ad9467_spi_write(st, AN877_ADC_REG_VREF,
 				       info->scale_table[i][1]);
 		if (ret < 0)
 			return ret;
 
-		return ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+		return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
 					AN877_ADC_TRANSFER_SYNC);
 	}
 
 	return -EINVAL;
 }
 
-static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
+static int ad9467_outputmode_set(struct ad9467_state *st, unsigned int mode)
 {
 	int ret;
 
-	ret = ad9467_spi_write(spi, AN877_ADC_REG_OUTPUT_MODE, mode);
+	ret = ad9467_spi_write(st, AN877_ADC_REG_OUTPUT_MODE, mode);
 	if (ret < 0)
 		return ret;
 
-	return ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
+	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
 				AN877_ADC_TRANSFER_SYNC);
 }
 
-static int ad9647_calibrate_prepare(const struct ad9467_state *st)
+static int ad9647_calibrate_prepare(struct ad9467_state *st)
 {
 	struct iio_backend_data_fmt data = {
 		.enable = false,
@@ -362,17 +360,17 @@ static int ad9647_calibrate_prepare(const struct ad9467_state *st)
 	unsigned int c;
 	int ret;
 
-	ret = ad9467_spi_write(st->spi, AN877_ADC_REG_TEST_IO,
+	ret = ad9467_spi_write(st, AN877_ADC_REG_TEST_IO,
 			       AN877_ADC_TESTMODE_PN9_SEQ);
 	if (ret)
 		return ret;
 
-	ret = ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+	ret = ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
 			       AN877_ADC_TRANSFER_SYNC);
 	if (ret)
 		return ret;
 
-	ret = ad9467_outputmode_set(st->spi, st->info->default_output_mode);
+	ret = ad9467_outputmode_set(st, st->info->default_output_mode);
 	if (ret)
 		return ret;
 
@@ -390,7 +388,7 @@ static int ad9647_calibrate_prepare(const struct ad9467_state *st)
 	return iio_backend_chan_enable(st->back, 0);
 }
 
-static int ad9647_calibrate_polarity_set(const struct ad9467_state *st,
+static int ad9647_calibrate_polarity_set(struct ad9467_state *st,
 					 bool invert)
 {
 	enum iio_backend_sample_trigger trigger;
@@ -401,7 +399,7 @@ static int ad9647_calibrate_polarity_set(const struct ad9467_state *st,
 		if (invert)
 			phase |= AN877_ADC_INVERT_DCO_CLK;
 
-		return ad9467_spi_write(st->spi, AN877_ADC_REG_OUTPUT_PHASE,
+		return ad9467_spi_write(st, AN877_ADC_REG_OUTPUT_PHASE,
 					phase);
 	}
 
@@ -437,19 +435,18 @@ static unsigned int ad9467_find_optimal_point(const unsigned long *calib_map,
 	return cnt;
 }
 
-static int ad9467_calibrate_apply(const struct ad9467_state *st,
-				  unsigned int val)
+static int ad9467_calibrate_apply(struct ad9467_state *st, unsigned int val)
 {
 	unsigned int lane;
 	int ret;
 
 	if (st->info->has_dco) {
-		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_OUTPUT_DELAY,
+		ret = ad9467_spi_write(st, AN877_ADC_REG_OUTPUT_DELAY,
 				       val);
 		if (ret)
 			return ret;
 
-		return ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+		return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
 					AN877_ADC_TRANSFER_SYNC);
 	}
 
@@ -462,7 +459,7 @@ static int ad9467_calibrate_apply(const struct ad9467_state *st,
 	return 0;
 }
 
-static int ad9647_calibrate_stop(const struct ad9467_state *st)
+static int ad9647_calibrate_stop(struct ad9467_state *st)
 {
 	struct iio_backend_data_fmt data = {
 		.sign_extend = true,
@@ -487,16 +484,16 @@ static int ad9647_calibrate_stop(const struct ad9467_state *st)
 	}
 
 	mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
-	ret = ad9467_outputmode_set(st->spi, mode);
+	ret = ad9467_outputmode_set(st, mode);
 	if (ret)
 		return ret;
 
-	ret = ad9467_spi_write(st->spi, AN877_ADC_REG_TEST_IO,
+	ret = ad9467_spi_write(st, AN877_ADC_REG_TEST_IO,
 			       AN877_ADC_TESTMODE_OFF);
 	if (ret)
 		return ret;
 
-	return ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
 			       AN877_ADC_TRANSFER_SYNC);
 }
 
@@ -846,7 +843,7 @@ static int ad9467_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	id = ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
+	id = ad9467_spi_read(st, AN877_ADC_REG_CHIP_ID);
 	if (id != st->info->id) {
 		dev_err(&spi->dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
 			id, st->info->id);

-- 
2.44.0




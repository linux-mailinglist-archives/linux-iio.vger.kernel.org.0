Return-Path: <linux-iio+bounces-4850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 410018BD0D3
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 16:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A861F217C7
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B3E13CFA5;
	Mon,  6 May 2024 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfXIi3Mi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83938F66
	for <linux-iio@vger.kernel.org>; Mon,  6 May 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007342; cv=none; b=rNpoG/YIzsgn8Ac0DE+N1jHSGGza/G0yO4+IKXNZACsiMnbR3udvtGMvu3lGXKEVJ0Z6+3u0WiC9Wri5fwQKITHe9TaQMA5sC3cMrw8DFn1b+tCelDF/vxqzQtKsw6OXRIXg6H2E+37W16qiOyGkxsSs5BzCl848PFp9XJVv2T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007342; c=relaxed/simple;
	bh=DX/tIk+jsPa6PLF5rS+UWiW39PRyaqu9HQ3eVd1eKCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WtEAfi5SObyBcysqfswVqJtQFJ2FcYgCBGWoyK6HJ3WY2MHabZI1E8vg02ZP1zs8UDGr0lpwlJZEIDMvgwe8vPrrYAN6mryymZwYgMmP6Q+B9VQtZBdp12vntCbVNqCgxjR6EPSlg+qqoCTITUF0ceO0vRTXiqvXoQha3cFDLaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfXIi3Mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37722C116B1;
	Mon,  6 May 2024 14:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715007342;
	bh=DX/tIk+jsPa6PLF5rS+UWiW39PRyaqu9HQ3eVd1eKCc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=OfXIi3MiHeTWn3S0TGmVvAL7ShYcc6TFgTL9ZRUPl8iUhbkA77fbutfBcP9N9Fl1A
	 IU+gQldSCjBj4FMELxNtAay20DbZyKkdmCldxf0v6KIv1/t0Fy4uWv7XVG9K15MN2Y
	 ZKVa/s9ZrvLUFUUuMGWgWD/al9IwFInBrmo86d3I4VC5Xk6SZ8X7wZ3E4E2eh/vCqK
	 eUYAngbIXCPQMcK7h+BFMXfKcrmMATpbooM965F5xxASL+/OLO//97wsHCY3zI/K0b
	 gewCCefpukNMZSWqD34PxIlwotq6+pfQ7zv3LdmkUF9Jza0WBZOcEgde5NN7Ei8JDg
	 67nDJvE2/kTYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30002C10F16;
	Mon,  6 May 2024 14:55:42 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 06 May 2024 16:55:37 +0200
Subject: [PATCH] iio: adc: ad9467: use DMA safe buffer for spi
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240506-dev-ad9467-dma-v1-1-e5c31b464e8f@analog.com>
X-B4-Tracking: v=1; b=H4sIAGjvOGYC/x3MTQqAIBBA4avErBtQM6WuEi2kGWsW/aAQgXT3p
 OW3eK9A5iScYWwKJL4ly3lU6LaBZQvHyihUDUYZq3rlkPjGQIN1HmkP2GltI5Hxi45QoytxlOc
 fTvP7fsxiP/hgAAAA
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715007341; l=7669;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=yjQ9Kl1CO2VbhiML81IVUgm28c6D981/Lxk8Db/pIek=;
 b=qnSAAgMAnAPS5lkFzcc2IX6M8ZZvFlEJtAe2Uqv6bWp8Idqblkte1+MymrdLbxNBytaQArBAT
 KuMHwbL1cwGBPoECCkVfFPSpF6XUwnmzfU3HFpGS0XH0xjoxB0nHS8e
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Make sure we use a DMA safe buffer (IIO_DMA_MINALIGN) for all the spi
transfers.

Note that as we noe use a shared buffer, lock guards had to be added
accordingly.

Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 87 ++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index e85b763b9ffcb..368546b032891 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -141,55 +141,55 @@ struct ad9467_state {
 	struct gpio_desc		*pwrdown_gpio;
 	/* ensure consistent state obtained on multiple related accesses */
 	struct mutex			lock;
+	union {
+		u8 buf[3];
+		u8 tbuf[2];
+		u8 rbuf[1];
+	} __aligned(IIO_DMA_MINALIGN);
 };
 
-static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
+static int ad9467_spi_read(struct ad9467_state *st, unsigned int reg)
 {
-	unsigned char tbuf[2], rbuf[1];
 	int ret;
 
-	tbuf[0] = 0x80 | (reg >> 8);
-	tbuf[1] = reg & 0xFF;
+	st->tbuf[0] = 0x80 | (reg >> 8);
+	st->tbuf[1] = reg & 0xFF;
 
-	ret = spi_write_then_read(spi,
-				  tbuf, ARRAY_SIZE(tbuf),
-				  rbuf, ARRAY_SIZE(rbuf));
+	ret = spi_write_then_read(st->spi, st->tbuf, ARRAY_SIZE(st->tbuf),
+				  st->rbuf, ARRAY_SIZE(st->rbuf));
 
 	if (ret < 0)
 		return ret;
 
-	return rbuf[0];
+	return st->rbuf[0];
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
 
+	guard(mutex)(&st->lock);
 	if (!readval) {
-		guard(mutex)(&st->lock);
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
@@ -295,9 +295,11 @@ static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
 	unsigned int i, vref_val;
 	int ret;
 
-	ret = ad9467_spi_read(st->spi, AN877_ADC_REG_VREF);
-	if (ret < 0)
-		return ret;
+	scoped_guard(mutex, &st->lock) {
+		ret = ad9467_spi_read(st, AN877_ADC_REG_VREF);
+		if (ret < 0)
+			return ret;
+	}
 
 	vref_val = ret & info->vref_mask;
 
@@ -330,31 +332,31 @@ static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
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
@@ -362,17 +364,17 @@ static int ad9647_calibrate_prepare(const struct ad9467_state *st)
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
 
@@ -390,7 +392,7 @@ static int ad9647_calibrate_prepare(const struct ad9467_state *st)
 	return iio_backend_chan_enable(st->back, 0);
 }
 
-static int ad9647_calibrate_polarity_set(const struct ad9467_state *st,
+static int ad9647_calibrate_polarity_set(struct ad9467_state *st,
 					 bool invert)
 {
 	enum iio_backend_sample_trigger trigger;
@@ -401,7 +403,7 @@ static int ad9647_calibrate_polarity_set(const struct ad9467_state *st,
 		if (invert)
 			phase |= AN877_ADC_INVERT_DCO_CLK;
 
-		return ad9467_spi_write(st->spi, AN877_ADC_REG_OUTPUT_PHASE,
+		return ad9467_spi_write(st, AN877_ADC_REG_OUTPUT_PHASE,
 					phase);
 	}
 
@@ -437,19 +439,18 @@ static unsigned int ad9467_find_optimal_point(const unsigned long *calib_map,
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
 
@@ -462,7 +463,7 @@ static int ad9467_calibrate_apply(const struct ad9467_state *st,
 	return 0;
 }
 
-static int ad9647_calibrate_stop(const struct ad9467_state *st)
+static int ad9647_calibrate_stop(struct ad9467_state *st)
 {
 	struct iio_backend_data_fmt data = {
 		.sign_extend = true,
@@ -487,16 +488,16 @@ static int ad9647_calibrate_stop(const struct ad9467_state *st)
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
 
@@ -846,7 +847,7 @@ static int ad9467_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	id = ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
+	id = ad9467_spi_read(st, AN877_ADC_REG_CHIP_ID);
 	if (id != st->info->id) {
 		dev_err(&spi->dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
 			id, st->info->id);

---
base-commit: 5e3c5871138da700796587aa5f096d39135f9d36
change-id: 20240506-dev-ad9467-dma-3114fdd27c1f
--

Thanks!
- Nuno Sá




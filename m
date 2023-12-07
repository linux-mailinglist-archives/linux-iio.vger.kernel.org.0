Return-Path: <linux-iio+bounces-707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A40808800
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 13:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6227C1C21E57
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 12:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9073D0A9;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckElbbTW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A192E39AE1
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39F5AC433C7;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701952769;
	bh=UzqvIfwbzNLDtbEGUVXpSxx0Kaj/yLNeEm0FpZ6Iu/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ckElbbTWvCU0FoDDp7EyQJD2Fnu/Zkuv9LYFL6HTAFZJhXftd+g4COl8rBxgO7pWN
	 XKV9Ln2XbWQb9PhqnReO2qqHZdECqjDOT2N4mRIRfUPQTveff2/gp8jYBkXviIJYyF
	 W+lSWk5BOHLh4jNJ7fNieGOlN+c+Obw2SGUbXOzCZJfvXPuBx0nuEl7NiIQQrZPMB8
	 WSF9NZ1BWYbS1l6pkZW2shd03RA7NJuQnZIbRi9AB2TDzKnrhC4ZIW0kQkCUR96zKK
	 /sNxCKYMH79k1hRl/iY523/oEBx5PfxNnHfiftArFwaf16BgATC3H6fiAJv4x9BneE
	 0p1tlIXOUte6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E20C46CA3;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 07 Dec 2023 13:39:24 +0100
Subject: [PATCH v2 1/8] iio: adc: ad9467: fix reset gpio handling
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-iio-backend-prep-v2-1-a4a33bc4d70e@analog.com>
References: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
In-Reply-To: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701952767; l=2538;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=B6eyyG1aIQxQT74CqknvJxoPEm4wonIOTUp1kxSCdDc=;
 b=kDv6ob2xz3EKaGreSCbvO5HCzgnbM7/DtA/RGPj6pz1YjfcCXPesSQoQZGIE8ki2fAwl+Qmqu
 yvEs5BUUnViCm9FmxOdQGsmkugQVW/xY9jpyTtFEI0k2gzRaRvNwOp1
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

The reset gpio was being handled with inverted polarity. This means that
as far as gpiolib is concerned we were actually leaving the pin asserted
(in theory, this would mean reset). However, inverting the polarity in
devicetree made things work. Fix it by doing it the proper way and how
gpiolib expects it to be done.

While at it, moved the handling to it's own function and dropped
'reset_gpio' from the 'struct ad9467_state' as we only need it during
probe. On top of that, refactored things so that we now request the gpio
asserted (i.e in reset) and then de-assert it. Also note that we now use
gpiod_set_value_cansleep() instead of gpiod_direction_output() as we
already request the pin as output.

Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 39eccc28debe..4fb9e48dc782 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -121,7 +121,6 @@ struct ad9467_state {
 	unsigned int			output_mode;
 
 	struct gpio_desc		*pwrdown_gpio;
-	struct gpio_desc		*reset_gpio;
 };
 
 static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
@@ -378,6 +377,21 @@ static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
 	return ad9467_outputmode_set(st->spi, st->output_mode);
 }
 
+static int ad9467_reset(struct device *dev)
+{
+	struct gpio_desc *gpio;
+
+	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR_OR_NULL(gpio))
+		return PTR_ERR_OR_ZERO(gpio);
+
+	fsleep(1);
+	gpiod_set_value_cansleep(gpio, 0);
+	fsleep(10 * USEC_PER_MSEC);
+
+	return 0;
+}
+
 static int ad9467_probe(struct spi_device *spi)
 {
 	const struct ad9467_chip_info *info;
@@ -408,18 +422,9 @@ static int ad9467_probe(struct spi_device *spi)
 	if (IS_ERR(st->pwrdown_gpio))
 		return PTR_ERR(st->pwrdown_gpio);
 
-	st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
-						 GPIOD_OUT_LOW);
-	if (IS_ERR(st->reset_gpio))
-		return PTR_ERR(st->reset_gpio);
-
-	if (st->reset_gpio) {
-		udelay(1);
-		ret = gpiod_direction_output(st->reset_gpio, 1);
-		if (ret)
-			return ret;
-		mdelay(10);
-	}
+	ret = ad9467_reset(&spi->dev);
+	if (ret)
+		return ret;
 
 	conv->chip_info = &info->axi_adc_info;
 

-- 
2.43.0



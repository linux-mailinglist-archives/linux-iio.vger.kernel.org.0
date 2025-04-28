Return-Path: <linux-iio+bounces-18794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 782A2A9FA7C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 22:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D743817CA57
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 20:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603220F062;
	Mon, 28 Apr 2025 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t3/bqhjm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE891E2858
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871860; cv=none; b=hZDFWjIBOgOuum5tiGiV/htwfHd+DLzsZ2DDh50lHHQvRXRhoTL4ngdS5ZFstbZfrTWwlY/82e8F08yU8c3sXoITHym0g2cJ0ERyeEe9Wy94A0vo5XUN0CLHyjuaYaLgIBV4PHYaRKmJuPADQiMS5Ir3M3O6wRg/o2UpkLWH5Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871860; c=relaxed/simple;
	bh=htzNMPXlRVfXDBCUzoC72qPIY7Dbustt/aeF0u587HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hM3UVLNvf5AqwQ/d2DHxS2IhSq9Rj6eiBtfl65j6lq7u3JucPDAHA/3gT3a43ldBO6KcgWZcDNHj4ah0DnjW21IG3wih8MxPRoOI1T/tU0ETJ0DnYXXVBB3bpVACBb4UZV89lxJpo++J/ic8yhEXcZK4ju6F3/OprwteXwN8ifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t3/bqhjm; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3feaedb4085so3688322b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 13:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745871855; x=1746476655; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ml14j4CWVwjgejgx5bGL2isKAmgSSnndW82GfrPbAUk=;
        b=t3/bqhjmULtzHwK4Rc8GXB9vjCVLfKFWnbe7WR9eY9kYIdoBaIGPUtWAA3PaRgxC9y
         Btm0bxouFWq9IG9Su4QjBIrOo4JN9CfZUoaUZGfcnkPVqFRHWRzqfuqPDmfjcxaZPsl5
         JgjGcTizkQiqyZ18VMbr4Y03hgrEkCX309h6kvDyCljK7wOqTJcapayK2Gsrst3FWCwJ
         IFU2Fy0pSMjVPHwaLSC6vq7igTDqV8rJqVrkfLimj7HQzED6c56qGBA6d8Y3XVQURJDp
         fiIlfFlMNfiNxjrFT7RH+BDaknTQfq3Jn3vVYpfcWtQzZYou03ldNP5A5/LQTpgwROuO
         Rb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745871855; x=1746476655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ml14j4CWVwjgejgx5bGL2isKAmgSSnndW82GfrPbAUk=;
        b=XfjipRLnVyI7quAyMqzYiLGNAINzrWI40EhZ4R4p224N4s+nceAHWPN1iXYPTkPR7L
         DvD2/iOuv9tKO8NnujC6LqUuHBI3WLR/AkaM/FXn+Gef7NKFGt8GIWW3RFv1kZMILrX8
         uFGLnGpxAY4PDhnpoXoGrHRLx7u9oqXau8qN2fDoE8VxLaEAXJuJIejOiU0R7bSxzNQ7
         5cOac2bHdjaOyp+EwMVLNu9f6NFLn5azBZ6gx8K73rQq8WG8T7iLHXbS8ZgZ6N04QBMp
         T7RMuLwmWFXNuVtQiexzjarOJP12XBAuWu22rDIKcbEnl8MOsXmCJuR/Euw0G2Eg2cwt
         V3Tg==
X-Gm-Message-State: AOJu0YxLgrVLj9HH4Kz/YNvaZGpEZ8eHZNbna4qUzaDzh609kHmgqwLD
	D60oYhFWAjh7A21uWvvMAgHa7WaOONo4M9H/2KjEtczrWATrL4nya/x7qN1kyR4=
X-Gm-Gg: ASbGnctygWajEepybCmxxar33dS+pt+0zGt+kOV4aLskDIeuI9v/q5d5zEFRcTQtNoB
	xi4MD2LAl63YYKCLEJQ1bwMwyhaXtUjgpozK0oMZffEHnSOW9/t1gljqYZJd7yp305zj7+G3B4y
	tzbnz2U1tLvIs9i/30vWEcfqX//oCd8t+3GZ71RaYAQahUG92eAFZfgo2Ex8Q0aLWEt9Eb2jFac
	Lw7aHkGZ9cQxwnUfgDUWv1+Nfc8XmgkS2Arzbv+7ynB5DA1Ozldl/5RxO9Lhz9uvt9Zeh/jdPVl
	jw9jMS6+UiSNxcH3NHzlqpWm/KH7qfI6rZg0jAdjL9knSUX5hte8kAH96g==
X-Google-Smtp-Source: AGHT+IHWDYsPV4NitcaTYpgE7UhDjAc/dkOOE3bAqOcW2gABkaCTrsjM84VlpdSsucL1H4N7hzx65w==
X-Received: by 2002:a05:6808:330a:b0:401:e949:6381 with SMTP id 5614622812f47-40211577993mr179164b6e.19.1745871854968;
        Mon, 28 Apr 2025 13:24:14 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401ec970ec5sm2196187b6e.34.2025.04.28.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:24:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 28 Apr 2025 15:23:08 -0500
Subject: [PATCH v4 6/7] iio: accel: sca3300: use IIO_DECLARE_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-6-6f7f6126f1cb@baylibre.com>
References: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
In-Reply-To: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2980; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=htzNMPXlRVfXDBCUzoC72qPIY7Dbustt/aeF0u587HA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoD+PTGYK6ltZUKAz6ARjAhcxo37S0yYyvXAfZ8
 IeVDjBAieyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaA/j0wAKCRDCzCAB/wGP
 wE5PCACauVxdlLd4SV1hK2nzoW85CFCUCnNXbPIlokdEh+LfKhvlbt8S3RI9cGDMwumFDlZPZq0
 7Z3BqalYsLPvdH6nQfN5DZSWSeS/cywoHGkyJjFGWJ85e1NdC2XptNEu6GV0gYnp4XXQpsxjzq3
 CYd8GXj4eehMVbOhOOoT/p4Lfd2tj5uaXDVL8TPik9wRlxSdwhhg38Gh7fqxrrPDmzyht60T3pF
 Gcp3eYRkT1F1RljVJIam/foR+bogJEy6bX9w7+SM5JpXmeX8EJoDE69w8lXHFPDdfGRDfLB8Qla
 R6yXv1ErpZzFeweqLdaSp6fpqSy0FdPezOTS33hsc9b/Xd67
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS() to declare the buffer that gets used
with iio_push_to_buffers_with_ts(). This makes the code a bit easier to
read and understand.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is an alternative to [1]. Also, this serves as a test to see if we
can get a rule of thumb to decide how much is too much to put on the
stack vs. needing to put the buffer in a static struct. SCA3300_SCAN_MAX
is 7, so this add a bit over 64 bytes to the stack, make the stack now
roughly double what it was before.

[1]: https://lore.kernel.org/linux-iio/20250418-iio-prefer-aligned_s64-timestamp-v1-1-4c6080710516@baylibre.com/
---
 drivers/iio/accel/sca3300.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 1132bbaba75bcca525fac2f3e19f63546380fd4f..67416a406e2f43e4e417210410904d44c93111d2 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -58,15 +58,6 @@ enum sca3300_scan_indexes {
 	SCA3300_SCAN_MAX
 };
 
-/*
- * Buffer size max case:
- * Three accel channels, two bytes per channel.
- * Temperature channel, two bytes.
- * Three incli channels, two bytes per channel.
- * Timestamp channel, eight bytes.
- */
-#define SCA3300_MAX_BUFFER_SIZE (ALIGN(sizeof(s16) * SCA3300_SCAN_MAX, sizeof(s64)) + sizeof(s64))
-
 #define SCA3300_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -193,9 +184,6 @@ struct sca3300_chip_info {
  * @spi: SPI device structure
  * @lock: Data buffer lock
  * @chip: Sensor chip specific information
- * @buffer: Triggered buffer:
- *          -SCA3300: 4 channel 16-bit data + 64-bit timestamp
- *          -SCL3300: 7 channel 16-bit data + 64-bit timestamp
  * @txbuf: Transmit buffer
  * @rxbuf: Receive buffer
  */
@@ -203,7 +191,6 @@ struct sca3300_data {
 	struct spi_device *spi;
 	struct mutex lock;
 	const struct sca3300_chip_info *chip;
-	u8 buffer[SCA3300_MAX_BUFFER_SIZE] __aligned(sizeof(s64));
 	u8 txbuf[4] __aligned(IIO_DMA_MINALIGN);
 	u8 rxbuf[4];
 };
@@ -492,7 +479,7 @@ static irqreturn_t sca3300_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct sca3300_data *data = iio_priv(indio_dev);
 	int bit, ret, val, i = 0;
-	s16 *channels = (s16 *)data->buffer;
+	IIO_DECLARE_BUFFER_WITH_TS(s16, channels, SCA3300_SCAN_MAX);
 
 	iio_for_each_active_channel(indio_dev, bit) {
 		ret = sca3300_read_reg(data, indio_dev->channels[bit].address, &val);
@@ -505,8 +492,7 @@ static irqreturn_t sca3300_trigger_handler(int irq, void *p)
 		channels[i++] = val;
 	}
 
-	iio_push_to_buffers_with_ts(indio_dev, data->buffer,
-				    sizeof(data->buffer),
+	iio_push_to_buffers_with_ts(indio_dev, channels, sizeof(channels),
 				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0



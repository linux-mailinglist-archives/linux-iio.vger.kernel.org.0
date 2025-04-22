Return-Path: <linux-iio+bounces-18540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9DA97A23
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECF83BB4E0
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF922D190D;
	Tue, 22 Apr 2025 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ufPjDR1+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9252C2569
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359733; cv=none; b=Uq9AunGsVr7XIHFdIDB42gd8y7Vy1zoy3NN22RXTC53FomjD1yWXiLCcPP/hAfFWdXA/GRbKDCtnRGlplzloW2fYwNLTGmplipuKr6nLxvAUfbHtnHNjTZ0wOsDhAtzl7JnGgubulQvNvr4GkjAF8MAIqofyYlAQcVyH6lF90sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359733; c=relaxed/simple;
	bh=COjNIZhPuNt4S3954Fn2UL7GTZFMh/VIXCBpDzwE6Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkTBe/nZyNA7ARF6Gd7R9DvUdz6h6GAlJmm9YtHeOyCc6bRYBPnFFdPrsQ2Qj14/SrhWSNU0PY5TR0oqp2H17WYZQ4++EEw+52LhKMF3GnQHvBKHw01o/dwNUi+wk/3owcYy6wmBo/uQGcyOgtR7tp/PrwdLruqYNwlGACEXPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ufPjDR1+; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c09f8369cso1821204a34.3
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 15:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745359729; x=1745964529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxcllqlAxGqsvqgkY1jmnRBvrU6YNyliNCeWX4COibA=;
        b=ufPjDR1+ob53cWSzxml8+PuOWXQTC1OdmUiarUrYbaz46nW/M56/aL5CNN8WuXFD8s
         NB1aRvARtZnrRWelW9CmYxKVtNvncVaJsF8KzyE2Sjm0vOWObBMOVnn7x9U4+u8rkSef
         KXiIlj9SC659NZh4NWS8R6QoMN2A4FV5JxzqpmRnZwpcjBGn5Qv28ggpBGi0WGz3IPbF
         PLi80uteuyN+JF3GYfEquYFphJbfV5Gai1ZedMNcWCe06bZeyFa54BUUfsrZQZk+oUwN
         L52wrsjqew7wfVX/LtnvslgIWsMf717lQPrF6HhZBmHtybD3Hbw7tj4Et6xqBuSC9SH2
         Lk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745359729; x=1745964529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxcllqlAxGqsvqgkY1jmnRBvrU6YNyliNCeWX4COibA=;
        b=EfM5ql9TPMAIhru1/0mVGuxo1CpSmXVowZHXj/ElfwIbfoilBy/WLFypsduukGTxHk
         MiaOAxHFU5I7HVkSfNJs66SOXNrdT/zu9YeqS85qxBi4IozK7qsDj/8sYyfYf8v4GkZz
         XeupiAKGsi2JQfAa2fn4DP8O24bWMsiKRbCTnNT6jf/rM9TNWXO+/fld+70/1v6Z6ACM
         6rAqzT3NN34GH8LUvZD0RU4RRGqccsQvLHZAPSMtxpwHkeoOMPfaIFlkM8/SIMIZFTm5
         F4eOMSs0HGWatYvwbwSv9WF3fMULZp4TwGwoG06yogKrxPg97NKT4ROpCaaak1XfHiDc
         nfRQ==
X-Gm-Message-State: AOJu0Yy7cjDaOS/jRaFiKHl9l6TcR2jr2iJsIF4siVY+7Ty9YCp4jGgN
	lUsc1scsWSLJ9vgt0CDIWsHO1iY44lut4kyufvOCR1kmRPtghx77/Y3x5o8hpeE=
X-Gm-Gg: ASbGnculKLFsP/XtQCt0hCpseRJYVcx4Uv8tGTPbCdx4CloHzJ/MOUBUFa7Uh7Gy4rj
	+2M0GZYTzdqmVDvI/7MKZf2d0z/a12dkbrqwKUEhXlGqEs61UsaMX+xqalFxzcKbVGDLEtKzFj/
	DxSFLddZp2jslzgx1h7iTWQnoYxTJEIMbxaqMnNhWwRHos2Ke2SoSoFXDev+E07+EM3FLbSOX5q
	h6hwtJ30ArrMnBg+YBE8sth0fWBbxthJiFunGbKQ9NDUQR4v7oIgS7yorzxFmOevhL5VpBH/y81
	xOLu8qMClvRRT5B836Vxhchk/WgNMLjU+hlXmKAayAKaG4U=
X-Google-Smtp-Source: AGHT+IEHQ1xlklPGq2GZ44BS1JT8PZ0bjGyLk9c5dWYPUyG84Suj7pcBUnv1TneF5QAxVGuSMQf2Hg==
X-Received: by 2002:a05:6830:264b:b0:72b:9993:118e with SMTP id 46e09a7af769-730062f8177mr11792393a34.22.1745359729568;
        Tue, 22 Apr 2025 15:08:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-730048848dfsm2265938a34.52.2025.04.22.15.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:08:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Apr 2025 17:07:50 -0500
Subject: [PATCH v2 5/6] iio: accel: sca3300: use IIO_DECLARE_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-5-3fd36475c706@baylibre.com>
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
In-Reply-To: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=COjNIZhPuNt4S3954Fn2UL7GTZFMh/VIXCBpDzwE6Cs=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoCBNbRITiIrOuOBiNd6+w5vU0Q+H8NcTHgrQrU
 wLSWJRb19CJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAgTWwAKCRDCzCAB/wGP
 wBTnB/9W3nNh7c5a7hXZRRRgX27QxylG6YYb6ppn7Xw65rFs9kwK77c2XZJ0mvMb2GtkwdRJTi/
 gl3MYrnC4UO8Fa0QYFI86FvSwrL/Csc0KUdtxnoLwen4TidL0q/LrDC5juRb6mA15H4PxMU/7tV
 exHDy6eWEe4Mcr0HAkaWXpjKFp+uPdkC4fo+O+Z8mgP/68Yh5bRqYXoI7J/w/apXcV288ZzZjqv
 Rn9UvvZhMoS3u5jPkZKIoGhf2P8H3oPLCsresOruS7yjQ90ZC+hgnfSN7PTSd8X2QS/ldSmhabx
 4oGYoytUtH0tST5kio2IoJVgt8p121obveXOAH7573ErgxVp
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with
iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
and understand.

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



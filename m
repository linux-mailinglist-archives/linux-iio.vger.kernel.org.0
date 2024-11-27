Return-Path: <linux-iio+bounces-12739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4399DAA44
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 16:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B6916762C
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD151CCB4B;
	Wed, 27 Nov 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p1q/tJuL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D14246447
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719615; cv=none; b=ampQBqRyGoNXw3vTxaIj6QeyxnWWLfD0pFaeCpzGrXv7t9m3129+CErJhnBP7/mS/uK7B9BTACX/qH89JsnBF7/UF7qI2VaGReoHRUxf/3DWq3O+0Qdikg0fKlU5qRY3NzwQDMOQenN+sIYU+fXakAJceQgd1CvNSFiw/9CSUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719615; c=relaxed/simple;
	bh=3VYK2lqcXHXpyUFZjq+zgESMLPVepCyq2JNbLTqaCCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/R7EGG9JHKV5/lZA5KMMhltYpRHGn2V7JK8peFB/11NzlSAFCKNbMeNN7cvFcNNtKyibYyUbE/ur1xTJJD9ymPIpcw9fAw8oRSVWsVLDxghEC5QZONE/r4UkjZw544oZLU2phRgeyLyC+s9TEAbfnlS8iS5P4zx3DgZcEgzbmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p1q/tJuL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a90fed23so12365185e9.1
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732719612; x=1733324412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXqiwyOCn9KgPUbNo99Xcjj0+MMaaSIu7O76gHJWUsY=;
        b=p1q/tJuLgJQFu4uVsozk4JJL9+8foHLcAyQMXwDQ5wRoxjMrZdnmHeK6NCeA8AbtBJ
         C3sc0CbOlUK4CP4duW6NYem4c+1/N+xJ+EsfLKATu+9xH684GEGd5lhtbVInjwNYcvIp
         qH+LzFkG5nGRKcYJfDnZhKDMovV7PGv+EEH36Hp+VfMaloDBXn3Sn2NhS7NmFC4yMRsI
         7g1Vk9MU0GwHQtCxSjZ0tWBVJ0F481Fa4GBvHsna6l3Arrzaei89hy1pa+XjqSFd4lQw
         FOKP7nM10vvOiwW6lkhWXgTEVm9t9Hsz/bhw6nZr+ud/CUR5AdQtmDGEQnUF6hFAS+sp
         Q4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732719612; x=1733324412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXqiwyOCn9KgPUbNo99Xcjj0+MMaaSIu7O76gHJWUsY=;
        b=qN0kq8fO8wowFXrxMdNB++JCszCOiWWQYhFiuRjHEaLpDn6yEVU17+mSYPGb8QjtiV
         qucDxWCDXX8O/BmNb5IIYfkXmfHkkyAcf1s6Kqjmtz9dQTakAmqYoRA7AkR2RxDE8Rw5
         2yfLzMA/WywTIEvOR3yuKIXu5SYK/8xzpe6XJglMkZkkkeOb3PBKNOjH5q3QlS5M4pZu
         hXLHdUn3qo7AarrArhpbR43KfFmWC4NhBnX0xsKYRUWUiRrvH+XJPAwRTeWVGbXfhR7t
         GBEwDJKzr+eWWtNQo4Hncdr7b4K2vZUQx20gGJI/E429Zmssu/u6FRP2n+3urj03CPp9
         SblQ==
X-Forwarded-Encrypted: i=1; AJvYcCV78oxBLhLmOQnFvVCQ2w69ctFpE0kIcrhI1u8y43fzhtSLe8uG5nsW/w0WMsrSAk3RydnA9+nsmaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpx1CghtMQvrTvG4M1ST6q/Fm4+cZi8PUtHQ+8mfVaeGwcj3/x
	Wi8Wv2Lg2Yp1Pdm6akHzipjcctzCiQTIQAJrgOEiqnHs0DkE1A27aUTmchzob8s=
X-Gm-Gg: ASbGnctCHjX2HuuDnHuKc4vENiZDZWTnXGdhS4D4lX+Y9RuvJrEyIpCZl5+uxD2gbs/
	3L1Psfb8X/yVAsj00dYRpMZ7oKmg+Gg6HxDhh5IscMXxbOYt91QmT5iCei7Kkmjlg5Nd5ps1R5t
	kEL1iBHo9ZTTu78fYDBkJS4wh46vAYfty0CWPGsfYeNnCl/wB/Wt6ROzWf2bppPIbDVDtPSoyZW
	VFwDYi5YLrF624XgKsRgEtX6xarw4Nw1sJfbv4GjAC7UsbMmEXEen+pAmBE/CwieuTxc52eWTdp
	i0Mv
X-Google-Smtp-Source: AGHT+IHxtcDZV6SnZr/qyz0FcDhgA32vf0vMVOU08X8jSxOUDKH6eZqwNjDsSH7GoRtVumnfeIoW4w==
X-Received: by 2002:a05:600c:4fc9:b0:434:a315:19c with SMTP id 5b1f17b1804b1-434a9dbc455mr35225795e9.3.1732719611855;
        Wed, 27 Nov 2024 07:00:11 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a9728460sm20689275e9.1.2024.11.27.07.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:00:11 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v4 04/10] iio: adc: ad_sigma_delta: Add support for reading irq status using a GPIO
Date: Wed, 27 Nov 2024 15:59:33 +0100
Message-ID: <20241127145929.679408-16-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
References: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4052; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=3VYK2lqcXHXpyUFZjq+zgESMLPVepCyq2JNbLTqaCCM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnRzPbPIMxf/kANGRxUASya61ZjKGNpN0xlaFan tfW8FmkCwmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0cz2wAKCRCPgPtYfRL+ TiMDCACmImK7KoDWgUAjlqgrZp9d+6bB4TxTG9Ad2I87B3VAo32g4xT7je5VATJLOovjUW9J0d3 x8ZSmzN7QvndvPxM9HDc7fwPHtWqNEuQnNOTyI9DDM7IMeZJ7yVDM/4civu7gSfC3xXP0zCb2/8 qx1DML5LfXECZq/GTIZYQV00nyubcC+mdyQpzC0ZNaDt4PZU75WqCI6cB5HD5AuIsZyeV/u2hn7 vBf+AK035oBIxqVtXzi+UrmraqH1YNjaxHpFz/dsnTzpK6hoJ1PJD/APiz2XZ5FoRwjLWeW0rV4 z0FDx+rB7kJJ0qLWKqeu8MJjYk3Y4nUASscnTF6E5kQUf97C
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Some of the ADCs by Analog signal their irq condition on the MISO line.
So typically that line is connected to an SPI controller and a GPIO. The
GPIO is used as input and the respective interrupt is enabled when the
last SPI transfer is completed.

Depending on the GPIO controller the toggling MISO line might make the
interrupt pending even while it's masked. In that case the irq handler
is called immediately after irq_enable() and so before the device
actually pulls that line low which results in non-sense values being
reported to the upper layers.

The only way to find out if the line was actually pulled low is to read
the GPIO. (There is a flag in AD7124's status register that also signals
if an interrupt was asserted, but reading that register toggles the MISO
line and so might trigger another spurious interrupt.)

Add the possibility to specify an interrupt GPIO in the machine
description in addition to the plain interrupt. This GPIO is used then
to check if the irq line is actually active in the irq handler.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 38 ++++++++++++++++++++++----
 include/linux/iio/adc/ad_sigma_delta.h |  2 ++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index ea4aabd3960a..7f4eae5244dc 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -539,12 +539,29 @@ static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
 {
 	struct ad_sigma_delta *sigma_delta = private;
 
-	complete(&sigma_delta->completion);
-	disable_irq_nosync(irq);
-	sigma_delta->irq_dis = true;
-	iio_trigger_poll(sigma_delta->trig);
+	/*
+	 * AD7124 and a few others use the same physical line for interrupt
+	 * reporting (nRDY) and MISO.
+	 * As MISO toggles when reading a register, this likely results in a
+	 * pending interrupt. This has two consequences: a) The irq might
+	 * trigger immediately after it's enabled even though the conversion
+	 * isn't done yet; and b) checking the STATUS register's nRDY flag is
+	 * off-limits as reading that would trigger another irq event.
+	 *
+	 * So read the MOSI line as GPIO (if available) and only trigger the irq
+	 * if the line is active. Without such a GPIO assume this is a valid
+	 * interrupt.
+	 */
+	if (!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod)) {
+		complete(&sigma_delta->completion);
+		disable_irq_nosync(irq);
+		sigma_delta->irq_dis = true;
+		iio_trigger_poll(sigma_delta->trig);
 
-	return IRQ_HANDLED;
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
 }
 
 /**
@@ -679,6 +696,17 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 	else
 		sigma_delta->irq_line = spi->irq;
 
+	sigma_delta->rdy_gpiod = devm_gpiod_get_optional(&spi->dev, "rdy", GPIOD_IN);
+	if (IS_ERR(sigma_delta->rdy_gpiod))
+		return dev_err_probe(&spi->dev, PTR_ERR(sigma_delta->rdy_gpiod),
+				     "Failed to find rdy gpio\n");
+
+	if (sigma_delta->rdy_gpiod && !sigma_delta->irq_line) {
+		sigma_delta->irq_line = gpiod_to_irq(sigma_delta->rdy_gpiod);
+		if (sigma_delta->irq_line < 0)
+			return sigma_delta->irq_line;
+	}
+
 	iio_device_set_drvdata(indio_dev, sigma_delta);
 
 	return 0;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index f8c1d2505940..126b187d70e9 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -29,6 +29,7 @@ struct ad_sd_calib_data {
 
 struct ad_sigma_delta;
 struct device;
+struct gpio_desc;
 struct iio_dev;
 
 /**
@@ -96,6 +97,7 @@ struct ad_sigma_delta {
 	unsigned int		active_slots;
 	unsigned int		current_slot;
 	unsigned int		num_slots;
+	struct gpio_desc	*rdy_gpiod;
 	int		irq_line;
 	bool			status_appended;
 	/* map slots to channels in order to know what to expect from devices */
-- 
2.45.2



Return-Path: <linux-iio+bounces-11488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7765A9B35D8
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1781F22189
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 16:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8BB1DED75;
	Mon, 28 Oct 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2CB50Nqx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C6B1DED6F
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131701; cv=none; b=MDd3AcCZYS57TDMzxqSxaUP1glvqsEyYh7BhLeo1WwJIG3kXKILjtY4/w1fsV6a7Hpi3Gv1h0d6rGw5qMvQgJwDSY4YLE8y5c3plZoC8APsioraywgrfQ4IPHr9ipdKBRNCmp/j1ZJDirKC24zAR8HlGXaOHAzZTai311l9Duwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131701; c=relaxed/simple;
	bh=1PjbfDi2WiXCR4YQF91keQyXtP/5XX0xLQMKTfHRFrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDAmq7E94ikClGo2d8RoApQisQx0yYw02wyqbx0qFC1kYlVDjLj7qHa10LTnagIOQTdrdYQ1M1inQ7KQd5kLszUL6zwUHYpy2QueSKJvArqbO1GiN/jt1hkZ5G107MFtP0TSyOMeB8hQF374C3cLb5NujK4gSsOfIBNRFmGt7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2CB50Nqx; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so43075951fa.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730131697; x=1730736497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUsu5FO65zLiIzYZufFdK/BD4939obrHxW8POIWF8hc=;
        b=2CB50NqxGGLAo3NhR/Rml7TpEPjTYNpadvBJZb7pF1H32edg/4mqPZJez3I/ndZDe9
         YTTwSYXQ4Xmhdwv5170iC4CHB8usxaxPi9kWp8QkSyx134xQCwxhxBF7JmliHgbA/lmL
         Il7XES19ylba0m46bUb0Dn4wgguZ3Fy3cydZGsjWEXOpEGgaw1845Ce2sy9PbG2/q1EB
         xf7dOn3kcogcfxfJHs048GW1Rh8HyHKp0wH4f9AP6TQ2K0fCf4RFPp60C7d1eJE9ANZO
         oNFkbOfugQziew0Bdr8eyT/qU7TEBuSkJvIPNg74onKdHCt+TUyc1YnrGXpx7f9V6pvm
         udLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730131697; x=1730736497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUsu5FO65zLiIzYZufFdK/BD4939obrHxW8POIWF8hc=;
        b=TmUMrHqBvWMYEhOJahFp7Cgxq7Zrnj6LDwe9gg3dPYBxwpxYOr9OxyyY2NccFxUuYS
         MKhTn6TuoYazArrCZXm0iuGIUflZzjGfvGhPEWGD6zvtCj8Lk9czTLYhatOkKkh/e3yB
         P7L5/kAKdbbTGxWTkE7RKq3jnKYwRyiRAA9evYGUnLczjkR5ghbq7Hd4t5KLOB0v9PjW
         bviV5yZl/ZK1B5P654nMl0+telBUWA5AwFPG26/1M+yAMYw7Aasu6A6pToE7s2UjzG9I
         ojJ3cCo+d0eVo5xE0ynflclU4WdP72uenMZzXqW07z3VYn4OhHA1CkLmFrUmFfvEiX2O
         wlrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvhcYgKb6SGK7by92vdzzgdavFJT9KpOZnz/OKoH1dq4G6bQ1RlaU5mtRaaL5xu7FxawmlSJiyS5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMBaOfFQpR/DM96C8Sf6jk2ZNIb9aHoaXBGpZAwyE99H5xgUC
	Sd5zrqBKOiEP14uRktc8v3fojHnvBb7jo2hnIGEKSRnctDhTEn5Pqw7Xa48dT/8=
X-Google-Smtp-Source: AGHT+IH7o1YWzKnQ5bvdNo6Q/BHCkqLAbNNlrmLxFP1lEijk8232M78nJfz/F6glUx7lqCYmW6Qj0A==
X-Received: by 2002:a2e:d11:0:b0:2fb:5786:251f with SMTP id 38308e7fff4ca-2fcbe0792b7mr27505701fa.37.1730131696661;
        Mon, 28 Oct 2024 09:08:16 -0700 (PDT)
Received: from localhost (p200300f65f0c3200f401bf2b6011cd64.dip0.t-ipconnect.de. [2003:f6:5f0c:3200:f401:bf2b:6011:cd64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b13251sm9913799f8f.6.2024.10.28.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:08:16 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 3/4] iio: adc: ad_sigma_delta: Add support for reading irq status using a GPIO
Date: Mon, 28 Oct 2024 17:07:52 +0100
Message-ID: <20241028160748.489596-9-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
References: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3804; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=1PjbfDi2WiXCR4YQF91keQyXtP/5XX0xLQMKTfHRFrQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnH7bdZRlKMt2ZAaypotKzVsdIu+fdIy+h3Jwfz gwxZznQxMSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZx+23QAKCRCPgPtYfRL+ TjyWB/9b3izawgl7UnP5UDU7yHZRNi1IWYKCO0oEotnJtAGCowG+dYGsZmj9qrIQcOx//nUlVJe Fc65rFnrZ76NG0BpnYmVk/4eNsVKJvDFp5NhpwvoyG0oA9l6e5b/BEEZiBVgTIe9xrfMge6quSV z+SbsNY7up2Y+PLl6yZT1vplgBkKBK4EFv2AGBSpmniMMWbf2MpgZIuKY5mrY99tWrlIdK1x2Az yJJ3FpwH9rsdDcBYzFEqU5V93jX+B/lhZIwNiiBCgBipsmpCn5yBI9L13bK0rXUKw/SlRp+V7wr UzxZDKGunWq8T/4FbWCiqB1izJ64aDlfmmTZ7Eb9xKYoPkji
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
description instead of a plain interrupt. This GPIO is used as interrupt
source and to check if the irq line is actually active in the irq
handler.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 35 ++++++++++++++++++++++----
 include/linux/iio/adc/ad_sigma_delta.h |  1 +
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index e2bed2d648f2..b5785f2a0abe 100644
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
+	 * if the line is active.
+	 */
 
-	return IRQ_HANDLED;
+	if (!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod)) {
+		complete(&sigma_delta->completion);
+		disable_irq_nosync(irq);
+		sigma_delta->irq_dis = true;
+		iio_trigger_poll(sigma_delta->trig);
+
+		return IRQ_HANDLED;
+	} else {
+		return IRQ_NONE;
+	}
 }
 
 /**
@@ -679,6 +696,14 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 	else
 		sigma_delta->irq_line = spi->irq;
 
+	sigma_delta->rdy_gpiod = devm_gpiod_get_optional(&spi->dev, "rdy", GPIOD_IN);
+	if (IS_ERR(sigma_delta->rdy_gpiod))
+		return dev_err_probe(&spi->dev, PTR_ERR(sigma_delta->rdy_gpiod),
+				     "Failed to find rdy gpio\n");
+
+	if (sigma_delta->rdy_gpiod && !sigma_delta->irq_line)
+		sigma_delta->irq_line = gpiod_to_irq(sigma_delta->rdy_gpiod);
+
 	iio_device_set_drvdata(indio_dev, sigma_delta);
 
 	return 0;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index f8c1d2505940..866b4c21794b 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -96,6 +96,7 @@ struct ad_sigma_delta {
 	unsigned int		active_slots;
 	unsigned int		current_slot;
 	unsigned int		num_slots;
+	struct gpio_desc	*rdy_gpiod;
 	int		irq_line;
 	bool			status_appended;
 	/* map slots to channels in order to know what to expect from devices */
-- 
2.45.2



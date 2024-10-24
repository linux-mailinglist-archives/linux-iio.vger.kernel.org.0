Return-Path: <linux-iio+bounces-11156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AFC9AED8F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34735B26582
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291EC1FAF1E;
	Thu, 24 Oct 2024 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zDlvrsM0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF171F9EB5
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790247; cv=none; b=UaGHApuLKhCmI2G9zh0mBdAwE43oe8BttKznZMpZ4bvGGoCwDU9aqwL0D1eBX+2kC/dlMb/PQvjri42MsJKDrz8YsaXwpUtpxl8lEZfOj+yLvuxsGnuvQxyIpYQ4IwP/BiVdz3KtrsRxQZs97Asew2yAIILDgkdCW8ME6u8hedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790247; c=relaxed/simple;
	bh=7c3XPE4sMerF2DKbilOR+hTQTWJgS2t/eqp8pnU8OZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nidSORP/LfHplSAsCyPkQVMnCi/wxTdhpzYmdgUGxmMFV15tNRnFxnPAyhwQ259Mp9dXDkv81RJxarX2/Fp5PK6q8ib9TIXWKxBpm1Niv+iRilJEtdXUlWw9YHmOhSuXhCOvmLrybT7DwAttqzyAQqrt/QKyHT26b4MbKd+m/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zDlvrsM0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso11111425e9.3
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729790244; x=1730395044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJ0YkQuoJdLlVLGTP0MTDUu5okEHNcKdbWjh3yi4wVk=;
        b=zDlvrsM0JGoTE1PoMeN5m2kmeHglOQdFbTgfWmQOo0t4foYW4R5Hbie35KDV739tCW
         bw8a3swL+ZxLDqNcjqsD9CMLHHdQ85aQTQtS5NyHn0aKscfg2iRqWtI27ZnVGsE6STCL
         ki+YvqOceQy9hn/8P8W642IgKsDT8XZ02d7TRJ0nqqm48yUKbO3tybjpF3YpgeRwF92s
         hbtPwJhH4WojujQwLBb4OGWp4i6PX5GDhWAwb4Dr2FQVGk+Jjuw8BKGtQHXy3N3V9jeb
         NlBg3zh9A7UHwyc9P03+FcuGUzCQQ7ptAAIvzR1+X9pnfVeL+R1XPctuHQ+yz01tt2TB
         n+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790244; x=1730395044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJ0YkQuoJdLlVLGTP0MTDUu5okEHNcKdbWjh3yi4wVk=;
        b=hCiaJX8lsygxTIOMq2+fo682iPuetap0plcZlPPGGujdx/bSI8K6sEpOQTsjrIc5Jw
         ZDB1r7eIHtnaJ+Z46+/Ke//Y9estJa8JVXVBFwrpEcGucsgqzwFkwrwmgGPA3t134jDb
         p+kt6Zq5GmMOCeGythzAk4BWkOUC4ZBTpMXep2kZ9Tjca7mPU+/Zfjw9yyDDCkdpOTCU
         a9Pzu7YWSA1yu7Wc4Wa93Yq0LO+PgS2Nn1h447Lqa8C17StNu8yACCvDQCgPPMQ4BKnY
         HdeHYniFKi9wNK3zfbtXqEKm6EsSwegfgZkqKYx4LbLK7K2mlIo/r5R2x57Mr6b7doHQ
         6Etg==
X-Forwarded-Encrypted: i=1; AJvYcCVAx8VtUr6ARkyOR4/3ykYg3bRayv2W51seWHAEal9xqtmJo+4rwS6Zm/qjgXy0V5RTskThmaJPDL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrFlNl/fzjOmqTr8jDFX5+vvFJl3w8Pzsmdq7PROFmIUpBwoDl
	UTQEeoKaysBbgfgTJ4WwVCWxDUm0DUjXmSUfwHziGOUo2SpajaXgzjGs6YAWAUk=
X-Google-Smtp-Source: AGHT+IEeQwpYwVOIs9arLkIWI0SEfT5C+CW6ck7pWIh7VXvYuWJ66pPGwXx2a3vFVKI6taFA+heREA==
X-Received: by 2002:a5d:504f:0:b0:37c:c9ae:23fb with SMTP id ffacd0b85a97d-37efcf733acmr5051507f8f.40.1729790243666;
        Thu, 24 Oct 2024 10:17:23 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9433asm11781980f8f.80.2024.10.24.10.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:17:23 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alexandru Tachici <alexandru.tachici@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH 2/3] iio: adc: ad_sigma_delta: Add support for reading irq status using a GPIO
Date: Thu, 24 Oct 2024 19:17:04 +0200
Message-ID: <20241024171703.201436-7-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024171703.201436-5-u.kleine-koenig@baylibre.com>
References: <20241024171703.201436-5-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3842; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=7c3XPE4sMerF2DKbilOR+hTQTWJgS2t/eqp8pnU8OZI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnGoEVEZsspt+rE5gBgarNkTUfUGB8QUH6E+iQu coE3+JY4+yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZxqBFQAKCRCPgPtYfRL+ TnVoB/97RBd2e0HgkMAwOs9HQodMWzGat9MW3Y7nlpNfvhalzzVNgoJFmYoGPTTucueDbWxbLBt DcbjxJ+dSwcL0Dmchtj2l0XjwFjJuMWQ2a6v9hAriJfRnVD39SfVs24qH8BWP7/2Orx5xcghksq jokgIFJCIlz7D9O8EXX/IPxZYXU/VCXHLXQYeE+CmHBHv7ufbxTjq4wazGcy2vZ6YdVidSOsm/w O+zSALmHi4/wD0G5hPtB27n+ENQ7+0UHBUwAdx0Cbnyuo+m5S7GEr4pWvYHpzMnwhmWpVsG1OqN h192+nJ6l5cAU4jBEnaSf9tvspsxMotCd7OAuyFVsvh+Xsdl
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
 drivers/iio/adc/ad_sigma_delta.c       | 36 +++++++++++++++++++++-----
 include/linux/iio/adc/ad_sigma_delta.h |  1 +
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index e2bed2d648f2..d35602cfb093 100644
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
+	if (!sigma_delta->irq_gpiod || gpiod_get_value(sigma_delta->irq_gpiod)) {
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
@@ -676,8 +693,15 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 
 	if (info->irq_line)
 		sigma_delta->irq_line = info->irq_line;
-	else
+	else if (spi->irq)
 		sigma_delta->irq_line = spi->irq;
+	else {
+		sigma_delta->irq_gpiod = devm_gpiod_get(&spi->dev, "interrupt", GPIOD_IN);
+		if (IS_ERR(sigma_delta->irq_gpiod))
+			return dev_err_probe(&spi->dev, PTR_ERR(sigma_delta->irq_gpiod),
+					     "Failed to find interrupt gpio\n");
+		sigma_delta->irq_line = gpiod_to_irq(sigma_delta->irq_gpiod);
+	}
 
 	iio_device_set_drvdata(indio_dev, sigma_delta);
 
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index f8c1d2505940..fc0141e0f0ef 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -96,6 +96,7 @@ struct ad_sigma_delta {
 	unsigned int		active_slots;
 	unsigned int		current_slot;
 	unsigned int		num_slots;
+	struct gpio_desc	*irq_gpiod;
 	int		irq_line;
 	bool			status_appended;
 	/* map slots to channels in order to know what to expect from devices */
-- 
2.45.2



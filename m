Return-Path: <linux-iio+bounces-13172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01869E776C
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 18:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814601888C64
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB32135C4;
	Fri,  6 Dec 2024 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1nAl8jZa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BEA2206A3
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506162; cv=none; b=J/GhM7pQfFCyYNyFZndmfj9T0oThSwaf1jGYmCvUpBzdI5PcQQJGj9M7+WQu/Ut3T4XJaRFPzOuctqFJx1xJtBu90fwrCn8S+ZdFRrVKCxEo0xt+OF2FcCPKfhibACuYH4Yk+NBdQBiu/gAf1XdJbY0sUGUDZ7oLzCoN9uUTHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506162; c=relaxed/simple;
	bh=Vn/ELfht9W9fFl9T7RxrKmgdJePzkYd4eCJaOLGeJgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSryMDNpnrBNZsDEzlGSRJUnk89uOWjSwF0HjJNvCThtjDjq6sIZyJcVQ4tUTmZ0W1rjF0ukq6YqJn9NXVuVGC/SvrifofgqjeCkmSB+tvtBhv2gj+IkK4Kg+aLpECg4Kg84/DElMpC3CQqWezGILkMI+rapOFICPefWMiK+AXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1nAl8jZa; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e0e224cbso1209807f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 09:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733506158; x=1734110958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxBxAaEjhII8E7HCCD0eAkPaxql5c0moDKYrsrB8SOc=;
        b=1nAl8jZawuydU5uvs8RojqXlCsyYhiLF6uccLXm4rq06h9sniiP+oFabqGe9shsGgt
         dHK/BTfNsRTgIe2n7KaeBC9FSG+fOV4dDPoSiOTxMWZpxFkZ1v1aXmnN8TVzEW8j8Fxg
         OilycyCKM4vgPX7l5VICyUxLcEXIX+HfWEV2HGCk7ddgP5V8wjUndy+rRP/6tGnfZ9jW
         CxbR8SciFsiD9KBwcWR/K6XgKFCjJN49PuE0oFOtB1CPyIalF3OtUOECzHNmiMP3o5OY
         Z5II7Imxh4HwWqMLf/8yYmY17j5cTXu2dc7f3ljIUJjBLHlqYe0PFcLR3rH9Q6XSQwf9
         8wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733506158; x=1734110958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxBxAaEjhII8E7HCCD0eAkPaxql5c0moDKYrsrB8SOc=;
        b=D3mNsfX87tZvhDyrBumibQ9BPwZ/xj+/oIQUrpRHKHvBPed0o2cSe5JFE8aLB3slls
         JRwxjkEqoTRfC2D8Es0l7dMd95lvLEF38XOirfyAQvC+QG3MoKhsW+qfDUaaVIbdrQMc
         nLmTHc2oORc7Nwu4/3wqUy9tnzoUOqS+kaqgTzBbrpZxJOLN3+vpjn97ATOe6ZNe14n8
         RPpygaLlfFplr25Zx4xOtCqbTfPJqImpjoW44X0wGf3feuGOI1jUkCl26qD1WVpTYyyx
         rbgjto0HV+o/JhqO8+LuLvS68phl+1FM9UlH/HCXF8ePO4O65M5v10OD1HYmyStau3uf
         LdDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFGT4Q5LQffBNLw0C3mSCMV2TOHOzSIwTsh7ww3MG32YHNDrmJuPkBgOJduZG7T9vJmAspB4YJM0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4w/cQXY/er6urChAORL8EloenAuokHdI8isynuIcxNV+zeUy
	EbnOCD3yTr9hFIbwvHfKeF5AmRphGezw6wb8KohzqNdGJn0y3yamrsPt3gacYR8=
X-Gm-Gg: ASbGnctGR2tdYqj5xDPx2m/pKQ1vP7WLduf1IfGeWAFlrBjKuo2+JoY6yXn4z8r8deu
	SEDG/LUpV3sVGRMZPxVInmELBdRugoXTLv+Lw3yFYpJgB+jXgYyC7yZRtCrj5Mr7fBUDn0gd0jM
	7dzfCrFusLhfBBUjAs15J07fDEt55rdre5nu9Hznwb+hZs8XRzrzILwfcatujBb0Er9Tu7DYE0l
	YWpTeO5/h7dkg6+MFL7OYWrRLhzRD4wyGqoRGtuMn2lzpL9ZG77XoUGb3JPtTiOM66PtoIcyKH8
	1LRY
X-Google-Smtp-Source: AGHT+IHhIeS+Yff7Ds+otbPrfa05itifmrflWcBqtVJC8PoXxesyS6H40O72SKfm7jW/kb+9E0VLnA==
X-Received: by 2002:a05:6000:4918:b0:385:fac7:89ba with SMTP id ffacd0b85a97d-3862b3d8207mr3368307f8f.47.1733506158342;
        Fri, 06 Dec 2024 09:29:18 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862f02f5c3sm1264715f8f.65.2024.12.06.09.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:29:17 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v6 04/10] iio: adc: ad_sigma_delta: Add support for reading irq status using a GPIO
Date: Fri,  6 Dec 2024 18:28:36 +0100
Message-ID:  <5be9a4cc4dc600ec384c88db01dd661a21506b9c.1733504533.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4062; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Vn/ELfht9W9fFl9T7RxrKmgdJePzkYd4eCJaOLGeJgY=; b=owGbwMvMwMXY3/A7olbonx/jabUkhvRgE5+4cMcQpdtMKzV/ie6UDYjku/RGm10vJ/2MdryUi GFhu04nozELAyMXg6yYIot945pMqyq5yM61/y7DDGJlApnCwMUpABO558HB0HhaaoJratGccMnH 5zo87t/uOnVa/N3XhR2Ft/kqrKIDm6O+6O37oj9nRoyLqJF+n805y48qJw6aHn3xLFdWfsbNmWU nl7BK6GmwMX7h39776IQS58kTBu+kLX1zlXRVD675uynxiessQyd7L8uQa1dOtNSmnfhl/PqEZk Te9TchMgaeymuWNvrpP31nUPlv26f5Dxr/njNZWzjDeKnaBrGJlg7v6oRufokwlHvstnKyNr/f8 bzk1jWvagTOVx5+NvPcbbEFUadFT3e2XmAQCl7EWe8hNz9ljcF92zsnHngF/Z09bbVFnt6rij+s HvbMhv2iLCb7bvsp+k++y2T6jDN1RZW3xkY95fA/a7gtAA==
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
index 2f3b61765055..f25850f4965a 100644
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
+	 * reporting (R̅D̅Y̅) and MISO.
+	 * As MISO toggles when reading a register, this likely results in a
+	 * pending interrupt. This has two consequences: a) The irq might
+	 * trigger immediately after it's enabled even though the conversion
+	 * isn't done yet; and b) checking the STATUS register's R̅D̅Y̅ flag is
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



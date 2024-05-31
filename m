Return-Path: <linux-iio+bounces-5565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5908D6B73
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 23:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311A41F223CC
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 21:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE5481ABF;
	Fri, 31 May 2024 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TagLpnQC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAA78276
	for <linux-iio@vger.kernel.org>; Fri, 31 May 2024 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190388; cv=none; b=ks4zEhtGMo/9G7qwOASC3euYtRh+bezrA9JfsoEEbxFgEv/hk2a+6KaIfte2LlFZmhMyWFSvgcZwDAxKYCegg+c6BwNTVzfv315HsSAYBdhXhACP2nZgFI+TC5rDOg5xYg8sUV35A5sjl1amoDH6oNEp69IPfHCLs2uq0OCRA+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190388; c=relaxed/simple;
	bh=Js0YVyBPm/E3WxsjG5z4McvboiBRBwpr7xybmk/0tP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grQlP8QagM6XG6wGDd03DUnVfQUHSnvJUwF3Mrod1WYYRpiACzSSS6K0KewIs/T/XX5azj/KvbXBZN7S3WO6A/OEu6gjivu2zb+R064DKixgj3ychAiFi1gOdFYo3eEyVsmag0xIfTgFR+8HaqVyS6cldoGA9OVrBND9Hym7Wk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TagLpnQC; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f8d2ec8652so1504670a34.3
        for <linux-iio@vger.kernel.org>; Fri, 31 May 2024 14:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717190385; x=1717795185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6K6MHKU/orn8S+VKImZw/DZY35U7Zc26RBfAXI+Msw=;
        b=TagLpnQCDNYhpxS3acth5vPJhgVXybe8PVEs3xxaFsMZEry4W5oOfAQ4lLWzlA5UgH
         4LP88Gj+SmwKcd8dA7TamR9BKdUvo/j72PEyq988UxC/ycnpa+aWdMC3QgMC96g0SMDf
         yZQiqddRzSwWS6bEtmVBPdULaF9ooJkRyir7UYqAxlnpzPfvvusleZM3kZtimTkrpxmz
         TPDMovmw0ZJJkzKOVcxvexKiyqII/iK1BcYfH0wsPUH/x+lwpRwg4EHrOHUgsOjq5lvU
         Op7MP7oyvf4v+U4VvtWAP3GVg2FkBQ22IcNSiB+uQPlOZo2lcDfUEp0YrKEVzP/fUU9I
         ZsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717190385; x=1717795185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6K6MHKU/orn8S+VKImZw/DZY35U7Zc26RBfAXI+Msw=;
        b=ZjmZOjalcv8QIAAC5jklQOJRRugpeYoXpWvdKIGHZo1Fn2Ov2eZdA1dXKVXtoOul0/
         6CgkjiZgdTNFhusmHtUmfFJRc8VkVCqUzfZ9zOYHT6aInXiZyiMS+1i1xKdvKxNindLj
         Og9dkbRV8afXScgEgGlVvpkD366yPl5aYm4VhX/5E9qiD9izCC7tf4Yb2NVYkoLDItFR
         tWWcSSY2EpvT6K0uFxqR5q2m/j3fUjFkBtEP8uE7xIzBhLy7uEWhs6QiOhs4Vw9JdDbA
         NtikNIlm5Epu0LKELPoToNxQ3upaXg7PLTYPdaYaROz0pJn9AVxI03rvt1f23Hzrc3p6
         juqA==
X-Forwarded-Encrypted: i=1; AJvYcCXivcL2XZyGrYN+OjxHR2trY12ooXPdaUSg+weNYI4PYOAsrOfTJriw1KEiMItJ+i1MCg8HkSJI6X/I9KcaMsg6doqbYm1IMBIn
X-Gm-Message-State: AOJu0YzDfTZQpOPp5fxu5TJMO7k3AbIY2AW9w34HR8JdnCyd796tN6H1
	LbyjckjkdfmFuN9sfhdZcigOTUB3DqDA29M7vA44ihGJ4Mx7b5S/Q/LTHlywoSk=
X-Google-Smtp-Source: AGHT+IE0Vyt+zzbJTkqMnIXs9WS274qnPNRombwHnz/DhsObFIFbFv8rZmMnOeEGBJQY3G9nmBrm3Q==
X-Received: by 2002:a9d:6206:0:b0:6f0:e4b1:587a with SMTP id 46e09a7af769-6f911f23d9bmr3449349a34.8.1717190385136;
        Fri, 31 May 2024 14:19:45 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91054f6c5sm470176a34.38.2024.05.31.14.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 14:19:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] iio: adc: ad7266: use devm_regulator_get_enable_read_voltage
Date: Fri, 31 May 2024 16:19:33 -0500
Message-ID: <20240531-iio-adc-ref-supply-refactor-v1-2-4b313c0615ad@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
References: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This makes use of the new devm_regulator_get_enable_read_voltage()
function to reduce boilerplate code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7266.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 353a97f9c086..026db1bedc0a 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -25,7 +25,6 @@
 
 struct ad7266_state {
 	struct spi_device	*spi;
-	struct regulator	*reg;
 	unsigned long		vref_mv;
 
 	struct spi_transfer	single_xfer[3];
@@ -377,11 +376,6 @@ static const char * const ad7266_gpio_labels[] = {
 	"ad0", "ad1", "ad2",
 };
 
-static void ad7266_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int ad7266_probe(struct spi_device *spi)
 {
 	struct ad7266_platform_data *pdata = spi->dev.platform_data;
@@ -396,28 +390,17 @@ static int ad7266_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(&spi->dev, ad7266_reg_disable, st->reg);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->reg);
-		if (ret < 0)
-			return ret;
-
-		st->vref_mv = ret / 1000;
-	} else {
-		/* Any other error indicates that the regulator does exist */
-		if (PTR_ERR(st->reg) != -ENODEV)
-			return PTR_ERR(st->reg);
-		/* Use internal reference */
+	/*
+	 * Use external reference from vref if present, otherwise use 2.5V
+	 * internal reference.
+	 */
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret == -ENODEV)
 		st->vref_mv = 2500;
-	}
+	else if (ret < 0)
+		return ret;
+	else
+		st->vref_mv = ret / 1000;
 
 	if (pdata) {
 		st->fixed_addr = pdata->fixed_addr;

-- 
2.45.1



Return-Path: <linux-iio+bounces-6701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A16291302F
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 00:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26914289387
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 22:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2148317DE0D;
	Fri, 21 Jun 2024 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VwU5B7Po"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525EE17D88E
	for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007932; cv=none; b=DCoY741bsmR3OfpmxcKimO1/C0clHNUz6AUgV9YZDWNu5y22ThKYVKeux5mQpGdd45th/hPw6i1Ddfi+NeN53r3bW3+2XEHwBxj8J15Jb/9ZGJno7Q2EyrLq9CIQpLve97NVKqohKvHMg+Vi+n6sw5L5XO8XbQkOGG/AaG8i1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007932; c=relaxed/simple;
	bh=fdN4UTM42tGULrKfSGBfArLaIVy8R7BeIJUcbSoqK6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUz9aWoGvOIoRlP+9m5/HsprTm+74IwHzbu3X1VezvPFY4mycCY/+wWVHtHerdYwtDH23n8y1Z5MA3Nr7os0c5UXIWYwiV/AW3p7lSR938/fxGB3R1UHaHxnbOVOMowdlQK8AIHWbBB7Pee9UpwRisZhFqeggSl9uJTSHCLbl0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VwU5B7Po; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f977acff19so1206615a34.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 15:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719007930; x=1719612730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTLhWXGcYPpFvPhVLNSGQecQSX/f3kZ7bOMANlmHk/s=;
        b=VwU5B7PoNp11r06RbQ+TMgiTRPSaJNvNFXUBE+ZSoKADWzWFoitZOgL7PghP/SNSxX
         ZN/4d9ma+LqWcbMcZAFzPhhg6KL7bxHBij/KbDPqq3KePnw0zXzdO9WNXH9XRYUX/+uM
         tPq/LnMCbOGAHS6OFcasAYs8nCd0tu/WJdADavDIN6r1SWItXh4M6AhXpjqK5scwTiBb
         thE4aRa0lYpJPkoW7qOOEnEXeat7inb/Ve3+yNooGgLSSG1GyQiLOYCeZIIay0PRcpPw
         XozL06vSgERRotolhjV3MYXELs6MHyUK66koVI9nYJGuUQ46UQ4iiGx/Bp4R8POcpvWJ
         V6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007930; x=1719612730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTLhWXGcYPpFvPhVLNSGQecQSX/f3kZ7bOMANlmHk/s=;
        b=IoH55dKxryJrCCDZVfzGjq5/TAlWReUtcVh0+VdUJqKGuIjLqa3RD2/+qrdgggq50+
         kV/G4c9HCv5UDQkgaiBdlM0PYSCVbqGFbDZFQFUh9wcAFOJzQxr0qZesH2M4Qm9eOI9g
         oKWk0dz6zsJ4NDuPl7ymv5BeVnGINahY+MfmxO8jUQfBqXq7wJ9h6wn/tgvNUmZ+y3zG
         M3xTJxMFbZQL1/41eh2XSbiVojBL/TtH/mtgh7QXkmnmfQY4WuvU15biDjw8B060KXZm
         UAwL2+LnDa7V5zue07EJMCQ+aH28bdbOtlNh84II8tJCriHiInz4pw4X9J2ToDPqliwm
         J1AA==
X-Forwarded-Encrypted: i=1; AJvYcCWtlvxcSHVMFmiCyKfJNO2NIX7/ohqzn+YpFEIKFT8Y8KHHj1hJEPZlY43SdQlHRTop3KBQjpbUcz6qOOM2daLSqB+USiYIEGuD
X-Gm-Message-State: AOJu0Yz/wPfmmbbCC282+YMvLzwViFQbG4nnAToXei5BlXckOUgxVQjA
	SfRe9lmlxxymTw1lbciygeq7Ti98aXTSm3ffUja53N2XivDQBp2eFZb3P7qMaV0=
X-Google-Smtp-Source: AGHT+IF2SgOBJxuK1mN8+m/jYX05pEOQGH/eglbTypLzjQRP70yZxGSEzwMMU70XpDgEFsNdBCoitQ==
X-Received: by 2002:a05:6830:4121:b0:6fb:d9b0:c17e with SMTP id 46e09a7af769-700767308a6mr11026891a34.35.1719007930440;
        Fri, 21 Jun 2024 15:12:10 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d94fb2a4sm329837eaf.10.2024.06.21.15.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:12:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] iio: adc: ti-ads8688: drop ads8688_remove()
Date: Fri, 21 Jun 2024 17:11:56 -0500
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-9-49e50cd0b99a@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

By using a few devm_ functions, we can simplify the driver and remove
the ads8688_remove() function.

spi_set_drvdata() is removed since there are no more callers of
spi_get_drvdata().

Also use dev_err_probe() to simplify error return.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads8688.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index fca3032c59d9..7a79f0cebfbf 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -432,8 +432,6 @@ static int ads8688_probe(struct spi_device *spi)
 
 	spi->mode = SPI_MODE_1;
 
-	spi_set_drvdata(spi, indio_dev);
-
 	st->spi = spi;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
@@ -446,30 +444,13 @@ static int ads8688_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL, ads8688_trigger_handler, NULL);
-	if (ret < 0) {
-		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
-		return ret;
-	}
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto err_buffer_cleanup;
-
-	return 0;
-
-err_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
-}
-
-static void ads8688_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
+					      ads8688_trigger_handler, NULL);
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
+				     "iio triggered buffer setup failed\n");
 
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ads8688_id[] = {
@@ -492,7 +473,6 @@ static struct spi_driver ads8688_driver = {
 		.of_match_table = ads8688_of_match,
 	},
 	.probe		= ads8688_probe,
-	.remove		= ads8688_remove,
 	.id_table	= ads8688_id,
 };
 module_spi_driver(ads8688_driver);

-- 
2.45.2



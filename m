Return-Path: <linux-iio+bounces-12434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074259D4383
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 22:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF531F2250C
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 21:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EC51C878B;
	Wed, 20 Nov 2024 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OiLx6adM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CAC1C7292
	for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138448; cv=none; b=lbpMxsn8eaFSHwHd3Nz6MK7DQ9f5euaQKzZfgOiPyOEJjDqnN/dlhXQGxNPh2hL6wL3t7FazrVFJEZHcSKiMFn4hLBLcsA4HzvZC0FUmz7gPC38BuowrHi12WKnYlhyQHsryHM7T4ckuN4cVrK8T5lg9FaXN7elFW9mrw/Flrjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138448; c=relaxed/simple;
	bh=zb0iu3LsZDbGiMZnDHvWU/LC6XEX03tvjXgY85pW72E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QKLEIF46GZ1ETzcC6tppQReiE0scMJ3KN2U/6BPbJoxcg5ugwvTyiNDs1gJJ4sWkvWXakHFW82l0wzlITK0j5MNtNJqMnHTG5JeGtMSnWDNJLe4jnMQiGTn2iHdXhqkDzPzdCK21lWP28jIuBbE3BM4rwgXLYiI81l53UOBik90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OiLx6adM; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-296c184ed6bso213549fac.0
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 13:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138446; x=1732743246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4a61Dd9tLHdovtexXvQ3Ave9sPehtoMEhgbGtikgl0=;
        b=OiLx6adMjziyZAY/MTplYcT/Fg/+82HsOmZsltwuX2c7G1Jg6/pRecrRky2v/Hz5Po
         alZQDr0Z5LGXdZCu6SpPMOh9qMyIkVEQpFyNy6wcZAskpLvM24x7cUEfJkGdEUsVRnuM
         RcVxHLdZASEPHvTqffguQ+orpAH9o/tcMI46H0CkPB1+inb41VxYQoVo7iSF4C9SMwob
         Ymle3v0jbXbz+eGR3AB4L7BgQAZmQ7WaHRDpoiPth3M8vxmtfVW25Y83XpP4jH8LYhzO
         airYjxcaIyVlGAorZFl1eindLJ0YGxc9WzDBlQSU1mtaR9BNEvpXr2Ll4dw5yO1/fCHB
         B1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138446; x=1732743246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4a61Dd9tLHdovtexXvQ3Ave9sPehtoMEhgbGtikgl0=;
        b=PxP8tdg//DFId9TpNmcCbXQku4v+aKxW7Jsg1pl3hPv8aJHjfF6rLU7fIZsrFYUAbb
         n3u2e4W1gyu8ks/wHoZcuWVSXzZcZFK4PJ0XIZA2owhh9PzbvYZ08n6rL7VxQ+UFdHj0
         6gI38Q/xregHxBfPiFV9FOHuKDFiLU6Hf01Gw2f15vEtXi2BcnKKICcgFcx3vcBT/5iD
         VXkHJtZdxyHSR1vYQiNXsYRpbiybM5Niy6ApFYK+tYOtwqMBfKC67bmFF4l7lizoV8lr
         cHp2NK4pkGh7HEiLTiDT8x5m6IZOy7lgb3/vvKqooeovhAAJ1pXA+J8UCnh7vIB30tuV
         d3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWVHTkwwL1Jo76KRyqLDhayw4cO1KPlAEGFgtzRCimp0STPpUaUGW4Xq3rBGrM4sn5JZgvyIqnX590=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVgCvtTDmwmdbmR+id701gAhsp8hgbpSOKcbRVP6eI5Xx/pKYD
	SZNJ+DhGtx1na3x0OJ5ez2Zik/Lgy1AMnTmxk9Te478Tioc7fwkrnsf/MpT0LZ8=
X-Google-Smtp-Source: AGHT+IH0OnevfIErmH2Ja2B5PLvY8pZDo/UqVPro9E1gpKlbBh56WhUqCHUnie2nukWwp5F+H26sJg==
X-Received: by 2002:a05:6871:112:b0:297:212:81c7 with SMTP id 586e51a60fabf-2970212a7demr252983fac.37.1732138445804;
        Wed, 20 Nov 2024 13:34:05 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:05 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:27 -0600
Subject: [PATCH 04/11] iio: dac: ad5686: drop driver remove function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-4-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Remove driver remove callback for ad5686 SPI and I2C drivers.

By making use of devm_iio_device_register(), we no longer need a driver
remove callback. Also since this was the last user of dev_get_drvdata(),
we can drop the call to dev_set_drvdata().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5686-spi.c |  6 ------
 drivers/iio/dac/ad5686.c     | 11 +----------
 drivers/iio/dac/ad5686.h     |  2 --
 drivers/iio/dac/ad5696-i2c.c |  6 ------
 4 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 8ba2ea70451a..79cfae7a1048 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -95,11 +95,6 @@ static int ad5686_spi_probe(struct spi_device *spi)
 			    ad5686_spi_write, ad5686_spi_read);
 }
 
-static void ad5686_spi_remove(struct spi_device *spi)
-{
-	ad5686_remove(&spi->dev);
-}
-
 static const struct spi_device_id ad5686_spi_id[] = {
 	{"ad5310r", ID_AD5310R},
 	{"ad5672r", ID_AD5672R},
@@ -126,7 +121,6 @@ static struct spi_driver ad5686_spi_driver = {
 		.name = "ad5686",
 	},
 	.probe = ad5686_spi_probe,
-	.remove = ad5686_spi_remove,
 	.id_table = ad5686_spi_id,
 };
 
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index a8a38879fc40..b848b076851c 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -464,7 +464,6 @@ int ad5686_probe(struct device *dev,
 		return  -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	dev_set_drvdata(dev, indio_dev);
 
 	st->dev = dev;
 	st->write = write;
@@ -521,18 +520,10 @@ int ad5686_probe(struct device *dev,
 	if (ret)
 		return ret;
 
-	return iio_device_register(indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad5686_probe, IIO_AD5686);
 
-void ad5686_remove(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-
-	iio_device_unregister(indio_dev);
-}
-EXPORT_SYMBOL_NS_GPL(ad5686_remove, IIO_AD5686);
-
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5686/85/84 DAC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 62eb309711af..e7d36bae3e59 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -155,7 +155,5 @@ int ad5686_probe(struct device *dev,
 		 const char *name, ad5686_write_func write,
 		 ad5686_read_func read);
 
-void ad5686_remove(struct device *dev);
-
 
 #endif /* __DRIVERS_IIO_DAC_AD5686_H__ */
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 81541f755a3e..a56a7a410111 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -65,11 +65,6 @@ static int ad5686_i2c_probe(struct i2c_client *i2c)
 			    ad5686_i2c_write, ad5686_i2c_read);
 }
 
-static void ad5686_i2c_remove(struct i2c_client *i2c)
-{
-	ad5686_remove(&i2c->dev);
-}
-
 static const struct i2c_device_id ad5686_i2c_id[] = {
 	{"ad5311r", ID_AD5311R},
 	{"ad5337r", ID_AD5337R},
@@ -116,7 +111,6 @@ static struct i2c_driver ad5686_i2c_driver = {
 		.of_match_table = ad5686_of_match,
 	},
 	.probe = ad5686_i2c_probe,
-	.remove = ad5686_i2c_remove,
 	.id_table = ad5686_i2c_id,
 };
 

-- 
2.43.0



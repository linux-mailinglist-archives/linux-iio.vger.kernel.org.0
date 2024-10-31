Return-Path: <linux-iio+bounces-11678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6BE9B7537
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 08:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC2B3B20AC5
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 07:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC30015853C;
	Thu, 31 Oct 2024 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SLmNCP0p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A51154BEA
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359081; cv=none; b=JDZ5rb/3yEC253tdT02OwOg7XZZw3lDzepvp+pmLPTSvFXP6+3pK/fpzKgNcpo7X35kJrjRVPUtBK+KS2VeeJyQUb74iHJ22U7uYPCMmB71f4RV3JYl5ytwWuyyY/y1H/e30zEsBoG1TaLp07jdhah8zMVM5rg3yY4lBhQtR+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359081; c=relaxed/simple;
	bh=Wpo8Oj/klmyH5vH0z1jaegb5OcJIFZ72Wg0pt5glQAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HU3PC8AccPW4vcr5n/IUcejeR1TfTlO7vXIOH6JmbWfEMONOoAcBpypgHXJdj6c9VaMPyTAfHBxlO1+R/z7m2toFapl+Jwcw3HbeiWf0+YRFV1gw7IDvS+oxp1JP4xOyr1q/9/2TyLjoaAB67rTTUxoEEVScCj89c01UwBaCbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SLmNCP0p; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so4814845e9.1
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730359078; x=1730963878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta8KKdF2jcNVKVs5pCv9tj8EzXOBx+/a1iWRb1D6Seo=;
        b=SLmNCP0pbhwRhyQijQmytLoOPxPwgYWw6lRGZ841HjhOHC030QRUGftl9jVcK/77/r
         n3D4Uy2s0V3LNcm3w9JKgNL31pOmIHGm7N9D7RKKxXLaamunoXVGzkftDvkNhydly/vT
         6CCF8hfbDTT4y61/U5UORJKqiNQqdehlXxuv1mAYgmewffpUMZH9sPMjHgAI6XXlRbu8
         ubQpFiVpG+6+wTcDVapuEqFExWBlXX7xMT0eJpj+rl2K22/8pcw7ITIBfxvqJq6Ui+Kg
         XeDZ6Z6wH34oDsX6j/lpc9hHIbJo+1vgzGsN4bPAuILjwwjcV1ULO5qz8ODlGL6rRxwq
         FjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359078; x=1730963878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta8KKdF2jcNVKVs5pCv9tj8EzXOBx+/a1iWRb1D6Seo=;
        b=IlSLnzjF0ieCvlYg988UJndqIliaIs9PD9aeLMZY6qjMLfuV/p81wnLECJ/zo6/K9L
         eaYq9/kr8EaVLG5TtcLvTv2txkxSUQV0uqxv4eQ2ZLVmg3G7Rn52AhHchfowAB3/cMJl
         HII2d7msfPRANT6reLN/Qn+YqrPcKZIODkOeNU6c7YD6jGJznUSIza8u8w5csw/JMhEh
         oe+sCxUQX0nIfqsKVwPOXlUEfoqDP3Kqd0S8BFVadqHp5N/83U58qbuQ/uGBarqXp/I6
         wMG7PV06ECnlyOQ3xqt/R4RPi4KpBPEhsTP33qvhs7ZubMTdrA2QlpxTBiMt9Ac4TEn6
         x0Bw==
X-Gm-Message-State: AOJu0YwMv6SSpBHXqwVHOXqAa4OAZDPeW+yNaN6k70kajg5QYIZdRKSd
	4Bjs/sIa8qmVMzDQBS/ULMVgK11wWm2C1h0XfAJQHYHD9oRxPi5hayHrGa/6EMU=
X-Google-Smtp-Source: AGHT+IFApzsnUKOt+RjkBsEFLWnDMKMhhkMDsz9e5PgIwP+GShRdVqxyiVYzdBFrvcfuDkSiF/a0ww==
X-Received: by 2002:a05:600c:4ecd:b0:431:6060:8b22 with SMTP id 5b1f17b1804b1-431bb9855a2mr50657975e9.10.1730359077813;
        Thu, 31 Oct 2024 00:17:57 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e694sm1187547f8f.86.2024.10.31.00.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 00:17:56 -0700 (PDT)
From: ahaslam@baylibre.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH v3 6/6] iio: dac: ad5791: Use devm_iio_device_register
Date: Thu, 31 Oct 2024 08:17:46 +0100
Message-Id: <20241031071746.848694-7-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031071746.848694-1-ahaslam@baylibre.com>
References: <20241031071746.848694-1-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Axel Haslam <ahaslam@baylibre.com>

Use devm_iio_device_register to automatically free the iio device.
since this is the last remaining resource that was not automatically
freed, we can drop the ".remove" callback.

Suggested-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/iio/dac/ad5791.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 92d47e766fd3..57374f78f6b8 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -411,24 +411,12 @@ static int ad5791_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(&spi->dev, ret, "fail to write ctrl register\n");
 
-	spi_set_drvdata(spi, indio_dev);
 	indio_dev->info = &ad5791_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
 	indio_dev->name = st->chip_info->name;
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		return dev_err_probe(&spi->dev, ret, "unable to register iio device\n");
-
-	return 0;
-}
-
-static void ad5791_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id ad5791_of_match[] = {
@@ -457,7 +445,6 @@ static struct spi_driver ad5791_driver = {
 		   .of_match_table = ad5791_of_match,
 		   },
 	.probe = ad5791_probe,
-	.remove = ad5791_remove,
 	.id_table = ad5791_id,
 };
 module_spi_driver(ad5791_driver);
-- 
2.34.1



Return-Path: <linux-iio+bounces-11550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663D89B4350
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 08:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983C81C22091
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 07:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9436D20402F;
	Tue, 29 Oct 2024 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fbcy3+bk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351522038CE
	for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187551; cv=none; b=VRrrRl5s/FsNcurMtlsZ7liCsfb0gbPpG5/NvJHjsdg4vQpa9JvkbDfp97L61xDMXNe1p4SY5bXy4hpEdJOR6ym4bFIrh6kFfEhvCVntBQo4CQEiGnNDr4i3Ncdcbr2BCs4cBOF8HxrNgLiZHQUleZXd7/qDx7VqKklSy/XXQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187551; c=relaxed/simple;
	bh=0LS4Nk7GxQswpk0mdmgm07qQ4l3m0gGDqtMeepATNMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cIuqNuiFk46quRFOtTkoAPmbppTdYflrVCTadJgG000pLkUFDfvjMJsZFFD3Px3vcbScRsTguth+5PkMfryfKQJoXSimx9rkkU/Cgy4D5ULuEI/ltHkk2EQxVT5aMMaoMtsnSQbRfdJOW4TDmUHE/z59wu8VSyb0Q4bjzFw+S8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fbcy3+bk; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e3f35268so6049869e87.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 00:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730187547; x=1730792347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6Vvaw4QQl678ABTGYPX4ibvi1CFPbTWqdFOgu4tkL8=;
        b=fbcy3+bkpLx1BiBqPj3IlB9tBQxsKlZHDtIgUqULePLjp0PLP0yHEOty2cxsQ6p1RD
         r03/e6oaftcjHUZTiy9nvsz18UGopD8r2A52rnbm+K6RnYUuCueJDkTWmxk0ImKnjZB9
         Q1V2y1r5ChIazP98EdUlZblANaJGC+zQd+eAqcfVSHDf/PZZPFrj+siXTK3Auz0J/4Ww
         8DKnH0sKnoCzseDYlV2EH5CYZfpCgSFl21mHGGU1qw0le75y7mSb6mNNw9YjLsOdfngc
         dJFJ3ktC69EiofRXkNDVVfe3+cqg4/JlIHD7iZMlT+hiWGjMDW41R1lvLGfPju5zAP3v
         NJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730187547; x=1730792347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6Vvaw4QQl678ABTGYPX4ibvi1CFPbTWqdFOgu4tkL8=;
        b=vXXq4rBYAE6jgp950hhAm7ym6LQUqtyJ8BSuR+sMjrOvNNxsINrFb+hmNO8C0pWgad
         9tgJlHh9Uj6rxuCOd06kQGm8N43zI7aAFBa1ks/lx9QYNQ207u7JCFqHfnjFKuIAoRln
         oRESvSrGRCJsV0HajknBp7DPXZ9ZI9e0ixCVwInVmk4K8NzNj8EPz5Oi2oq0pL5xl7Mr
         rk/C5sL1jI4ksKvLGLhkDNf4F0BFgrGU+tz43y65XgJz+Oa+avavcX4wuD/WK17fvLsH
         2Tv92tYbDnnp7ylzTtJ04G+K4/sLvAOoUyld8BJWGKPH4EQR8n9hdXBe5FUcL2GjAZEu
         Eclg==
X-Gm-Message-State: AOJu0YxsU89NT+qYPVMYOkQ/BmD1UquSD61Vdiu2emM9UiVTOOY4G8jS
	AT1BCYx6u0HtwVQO0aJ+2vmtERIsVhI+NTVKmkWnrzmpdZ2lD+haKkUGH+S/dyc=
X-Google-Smtp-Source: AGHT+IFZE6j7vlkB96lH6neBxbdHVX2qml3l5Zo78hM65bkBjrNAS5Ve75+Y/ZU10cnIOJEUj6Twkw==
X-Received: by 2002:a05:6512:3ba7:b0:536:796b:4d94 with SMTP id 2adb3069b0e04-53b3491cf63mr4722710e87.41.1730187547070;
        Tue, 29 Oct 2024 00:39:07 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b714fesm11692939f8f.71.2024.10.29.00.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 00:39:06 -0700 (PDT)
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
Subject: [PATCH 6/6] iio: dac: ad5791: Use devm_iio_device_register
Date: Tue, 29 Oct 2024 08:38:57 +0100
Message-Id: <20241029073857.753782-7-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029073857.753782-1-ahaslam@baylibre.com>
References: <20241029073857.753782-1-ahaslam@baylibre.com>
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



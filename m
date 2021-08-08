Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6D33E37E7
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 03:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhHHB6B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 21:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhHHB5y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 21:57:54 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C31C061760;
        Sat,  7 Aug 2021 18:57:35 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id js7so7185389qvb.4;
        Sat, 07 Aug 2021 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gD90amiT9YOyeKllxReMYt4NwrWNc35BmzbD4M2saFY=;
        b=EZtl5AHp+Pb02/ZMz2IKhSGMmiHPJZITQTTnMUFJZKqRvL3RV9vOPEMZl/uma2WXKy
         VREWmDFvf3S3+hEwJ/+MYn8h9ddsPoongUw/2OQkWw7/x/QcTRycVauBAx1RNquF/Ry/
         Lui4iMMhYGVz32BvdhrJl6YOap9tubx0dr0AXGGZj5hevuq21Z8/WnDYHoZkyM16/lYo
         DMtj88morEj/yiIgciwfIglnohFUIexODtbPM8Njqc0h3F+jgqLRGXWjLXHo5oFp1Q7i
         Tez8gkWI5Gpb6G5ZPFiMNpHzT+QrU0bWGajtU26TxtfAfkAYYV/2t9d4EfFu2vIsyihq
         ndbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gD90amiT9YOyeKllxReMYt4NwrWNc35BmzbD4M2saFY=;
        b=Zx5vaZNXfX3cBMGw8shjL1Cm+TfRWLr0iowkGcAWwpBjmGbbUEZQIDmVJ2jNx904w3
         5Ii6ojlQmrVDmWyLDA4QSy3WUmTrjBrV/NXxxMDceRuukt3psygQqA2NjdyvnjWkYGx6
         OhnJe7bzdxX1ex660VZioWmDvmdFGnz7JQAzV4KhDiz/O1GkfN0NQPK/yI9LqcTGaKRu
         9rYFaIkUE9X6zieDrdaJuOtM79Gj7uzZjfzLlpmiykXfKosOPmDipnkzC+azXH6jITMS
         NpMcq6HeIodWYIcwpN36oNTJlyRvNSuPrAh8OXgU9mIeaURBc6Dho85LY5rMCX/aVIQ1
         Q8xQ==
X-Gm-Message-State: AOAM530vAhnC0nhETlqoeiWbj43z5/DYB2CAdnsquJtPG/xO6qJers37
        O+InaJV86lGRMSxRAFT0IN8=
X-Google-Smtp-Source: ABdhPJyPFnuyJGoPvZRayd0TKP+lE12TNqhsQhABnKW06y8imG2MVHYODNASrMTqsWWuiJo0hsR4Pg==
X-Received: by 2002:a0c:e6cc:: with SMTP id l12mr6896739qvn.48.1628387855002;
        Sat, 07 Aug 2021 18:57:35 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id k24sm1569612qki.11.2021.08.07.18.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 18:57:34 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 5/5] iio: adc: ad7949: use devm managed functions
Date:   Sat,  7 Aug 2021 21:56:59 -0400
Message-Id: <20210808015659.2955443-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210808015659.2955443-1-liambeguin@gmail.com>
References: <20210808015659.2955443-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Switch to devm_iio_device_register to finalize devm migration.
This removes the use for iio_device_unregister() and since
mutex_destroy() is not necessary here, remove it altogether.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/adc/ad7949.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 14a7c79d637e..71561eb7898e 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -466,34 +466,16 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	ret = ad7949_spi_init(ad7949_adc);
 	if (ret) {
 		dev_err(dev, "enable to init this device: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
 		dev_err(dev, "fail to register iio device: %d\n", ret);
-		goto err;
-	}
-
-	return 0;
-
-err:
-	mutex_destroy(&ad7949_adc->lock);
 
 	return ret;
 }
 
-static int ad7949_spi_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7949_adc_chip *ad7949_adc = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	mutex_destroy(&ad7949_adc->lock);
-
-	return 0;
-}
-
 static const struct of_device_id ad7949_spi_of_id[] = {
 	{ .compatible = "adi,ad7949" },
 	{ .compatible = "adi,ad7682" },
@@ -516,7 +498,6 @@ static struct spi_driver ad7949_spi_driver = {
 		.of_match_table	= ad7949_spi_of_id,
 	},
 	.probe	  = ad7949_spi_probe,
-	.remove   = ad7949_spi_remove,
 	.id_table = ad7949_spi_id,
 };
 module_spi_driver(ad7949_spi_driver);
-- 
2.32.0.452.g940fe202adcb


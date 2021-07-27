Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CA73D8402
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 01:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhG0X3c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 19:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbhG0X32 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 19:29:28 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00767C061760;
        Tue, 27 Jul 2021 16:29:26 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 184so510220qkh.1;
        Tue, 27 Jul 2021 16:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Csc8wT/95G9747ozFthDCH/y0the7872d54YDDPRcbw=;
        b=R8lSn+PkPn1WSVxtrB4LEJ7u2NOHgF3okdWNJ7xzOeyy+7P9UTaQvTDvHgOadoWXd+
         TjrIpwi5jM/N2LoG24fvC2kAzzpO0ewfd8z04v3nyGbssOOgHD7FlJBUBe76gMsFkPsY
         vj5fla4/G3G+z4DcMWna13jiFz+93+9GdDBojaaNVBHjty/oeMSCUb7pc1Vfnq2GyGKb
         jq2XbnoDxnGX39jsIGyaRfuccYgoIIs8PS0+fu5lS6pOREKGOznsj96qpMMlEbT9X+md
         oaCXrySgTc99/VnYmddL/5nMjfKfC7lv83cXA7Wh41DSseJhsDCHAyZtEevK9qOGBB0R
         Er7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Csc8wT/95G9747ozFthDCH/y0the7872d54YDDPRcbw=;
        b=JXTvnHC7JOfhEgtzpMZyXbcf1h4fdtnz00KfUv+u7lrU09mRiH7SCS7BOT53CZD7LX
         4iwklvYUfi7OtIMMKnVOQ1T4mErX9YlfgVwxVe0s22ICRWox/oRgsXXhVcbFDLMSJY7r
         WTN/BSip3QOw0Dlu72U/ptQt1Cz7/TlKVBnJkDf7RXwqvqgrYTdRjBjuFLfcAPEEyXaX
         diZ9t3tSsJeM16bofCemzCO4/FEJZEGuWSZ6XC4k5q4GKgsUAjFRQdSo5OH1r8bn7Nz/
         XmwSHW3g+coKmxfhCmH5DfFVSRsaN1GZILszh/GUBP5dNWmVlCok0jJLoLbcLZxwNrXc
         sNJw==
X-Gm-Message-State: AOAM532b5/q7C49ESrNytHWEt8bMDap5AsddRBpBaPgIQ7c0r03lXEJR
        ffBgvgTrPTqRyxmgZ2yqWA0=
X-Google-Smtp-Source: ABdhPJzw3Glsh4KII0L97nq3gobiOH4Z1doCcqH+8rVV3Qtokh+NZCPlAx9NogU/F9cHuH3KOA5vRQ==
X-Received: by 2002:a37:66d6:: with SMTP id a205mr24218043qkc.422.1627428566232;
        Tue, 27 Jul 2021 16:29:26 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id p188sm2380514qka.114.2021.07.27.16.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:29:25 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 5/5] iio: adc: ad7949: use devm managed functions
Date:   Tue, 27 Jul 2021 19:29:06 -0400
Message-Id: <20210727232906.980769-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210727232906.980769-1-liambeguin@gmail.com>
References: <20210727232906.980769-1-liambeguin@gmail.com>
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
index eaea8f5e87d8..29a87a12e551 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -452,34 +452,16 @@ static int ad7949_spi_probe(struct spi_device *spi)
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
@@ -502,7 +484,6 @@ static struct spi_driver ad7949_spi_driver = {
 		.of_match_table	= ad7949_spi_of_id,
 	},
 	.probe	  = ad7949_spi_probe,
-	.remove   = ad7949_spi_remove,
 	.id_table = ad7949_spi_id,
 };
 module_spi_driver(ad7949_spi_driver);
-- 
2.30.1.489.g328c10930387


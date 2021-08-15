Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC793ECB6D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 23:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhHOVfO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 17:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbhHOVfK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Aug 2021 17:35:10 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4B2C06124A;
        Sun, 15 Aug 2021 14:33:57 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t68so17125837qkf.8;
        Sun, 15 Aug 2021 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=paVSC5jFhWBtvyWQP2dPKvlBYJAW6pw4Z4wd3QzT2mk=;
        b=ZY+OddLCosEBVnS1NclkUB7itP5bkV4QGWa9fMies0b0DUNHnF9BDBDfMlCUS4vT2+
         lbHGw42JCzu9dRorcc0lcjjjrlzdDPVtMbYE3OZx0wGRNHo+5gW5kZYrP+IqXosn8nzo
         nPFSCb/QHuIWoWYX60gfSiGXIJ6LptmpVfWHDmINaTaRKpDUqvXIjY2557R0iHymmpdj
         7Q/CiIIt80FkjpWPmtUxsbY3J7cn0o/qnfdJzsXi2NbN+rrEorUJu8WBe8pvG0h2eb3n
         m9K0nIa7XA7TwyyMXOGiEIJKUAKtzPsU4QCV0GfNFqJl3MfZRz0rHzuYr9vXUaPHVN37
         3o4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=paVSC5jFhWBtvyWQP2dPKvlBYJAW6pw4Z4wd3QzT2mk=;
        b=Me4rGX71Gyhr2alhSQ3ku/LNNB7wx9GXq2kMMy+Cpnf2DFVUUQu/sXuk0e/K41urcI
         e2KDFOG7XUNwTnJq6dejP9x/CuXnZYAOTIQBOXXFIaklaKzhMjSGrAzFY4qj0sZdxhew
         DXHeYzPvlkuFuV5pAab5Oghfv0/YoDLfKzn9Lf/nSpsDevhlDLu3ya2F0e4dpkfsohTO
         cORcW2uGBhVH9FpG6ojjSmcwzy2QupfWUsUL0nOAbG1oBilga7uLk9prS+zzZoccLWBq
         PB15PMh59DDJiQpBmTsx53joyfAt3Wnq33AkwZPxM5NpDMeXYd51L5z1o2xrObdjSH1U
         mFPA==
X-Gm-Message-State: AOAM530BFPbGRm+7/VYHMnz+triCoSz8W0f3Ao02ph2jYGIXT8JiEqqE
        MFLm/e8aaQ/HSK8ggFTUzLo=
X-Google-Smtp-Source: ABdhPJwq/UWom4p95vS41sMqqWmTEZIE4onXSsswaWS2YsM+IYxsHaavsS1sEunNLkNA4qYCFYBGlQ==
X-Received: by 2002:a37:8e44:: with SMTP id q65mr12972514qkd.372.1629063237157;
        Sun, 15 Aug 2021 14:33:57 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id u19sm3870988qtx.48.2021.08.15.14.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 14:33:56 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 5/5] iio: adc: ad7949: use devm managed functions
Date:   Sun, 15 Aug 2021 17:33:09 -0400
Message-Id: <20210815213309.2847711-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210815213309.2847711-1-liambeguin@gmail.com>
References: <20210815213309.2847711-1-liambeguin@gmail.com>
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
index 5168d687687d..5b8858719b53 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -405,34 +405,16 @@ static int ad7949_spi_probe(struct spi_device *spi)
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
@@ -455,7 +437,6 @@ static struct spi_driver ad7949_spi_driver = {
 		.of_match_table	= ad7949_spi_of_id,
 	},
 	.probe	  = ad7949_spi_probe,
-	.remove   = ad7949_spi_remove,
 	.id_table = ad7949_spi_id,
 };
 module_spi_driver(ad7949_spi_driver);
-- 
2.32.0.452.g940fe202adcb


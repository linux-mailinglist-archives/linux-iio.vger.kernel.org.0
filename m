Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF9B188FDF
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2019 07:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfHKFp4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Aug 2019 01:45:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41163 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfHKFp4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Aug 2019 01:45:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so46469966pls.8;
        Sat, 10 Aug 2019 22:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWYbNtmjE1k1tu/MG+O0SFJsDideswIxOdaCbUQYasE=;
        b=gAitQKL09xt88JIc9HbcMcn5r6YHPlFY6Stsy+ekKMLsMjyjdnmvXogx2xJpdezGM/
         GtaGZMe4nl5Y0ZclMD8q/R8Y+VU1hFOSh2GGUDdGTlOEqb1E8EAiPPjc6YvfH6LOkolD
         P5TI7VD2ILniW4EjGWkEKIPL4lVApDP1GVoo11qGfioaMfqYlLYjaZJyTyegnQLUvV8K
         9VQ1jXZJqjvIcuJ0Uc20QsM95+ZznWNInBnou8iv0XirTb5HI8/0riuZsZmVLU0BU+vm
         pOCbos//McDeRoxsglO6iQ8umSbg4E0dB7uDoe4IE4cQPbvF/IzPV7h0F/DYIL2zmCV4
         W1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWYbNtmjE1k1tu/MG+O0SFJsDideswIxOdaCbUQYasE=;
        b=KgUfLPAM8Vv/1VYqwIcOee0OMEaCIN2gqyn9zlOeNKq582UH1UnHL0iTqG/BzTtN3Z
         sWPi8L/a8ElWm968i6LgfwcwkC4izU189K1Cd8M6lXHMqb0sxT32iAs5t/6u7adcVX3x
         BwAWRV4OkIFvlOgCWI0MDxtuTsHRcEsBLOg/7ylCQZgOcTeF1njQIb6QLp5LoeSv4hPH
         cONETbJiEGUTdtgMa9QTvJKz6l1DEE8lB7X/7uE29p+RtK/OSi6d5gmvMD8RUqCdlDlN
         nYpJLlUBeKA6LDaR4gUMY7iCwZlGRVlw2QVtjk2tig5LOl0HPHgkW6FtLaltuHYTo8BV
         7Brw==
X-Gm-Message-State: APjAAAWizWBydvylgWBf+aC7S9tazg8aLxNEyA6fUeAnnnawYGDzKRkv
        fROzCPr/tNMQVepuy4CXiRYHQ2Od
X-Google-Smtp-Source: APXvYqxDOsjZw2MrMD89MTU/Yx7aNmuQbi22YJCxYY94JXex1TJ4Y86oE98mc8cKHbfxjvCkPAlp5g==
X-Received: by 2002:a17:902:1aa:: with SMTP id b39mr27712195plb.333.1565502354929;
        Sat, 10 Aug 2019 22:45:54 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id u16sm10998429pjb.2.2019.08.10.22.45.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 22:45:54 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Chris Healy <cphealy@gmail.com>
Subject: [PATCH] iio: hi8435: Drop hi8435_remove()
Date:   Sat, 10 Aug 2019 22:45:45 -0700
Message-Id: <20190811054545.6922-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the remainder of hi8435_probe() to use devres and get rid of
hi8435_remove().

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
---
 drivers/iio/adc/hi8435.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index c15f0e154e4d..fe1341383d30 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -456,6 +456,11 @@ static irqreturn_t hi8435_trigger_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static void hi8435_triggered_event_cleanup(void *data)
+{
+	iio_triggered_event_cleanup(data);
+}
+
 static int hi8435_probe(struct spi_device *spi)
 {
 	struct iio_dev *idev;
@@ -513,26 +518,18 @@ static int hi8435_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = iio_device_register(idev);
+	ret = devm_add_action_or_reset(&spi->dev,
+				       hi8435_triggered_event_cleanup,
+				       idev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(&spi->dev, idev);
 	if (ret < 0) {
 		dev_err(&spi->dev, "unable to register device\n");
-		goto unregister_triggered_event;
+		return ret;
 	}
 
-	return 0;
-
-unregister_triggered_event:
-	iio_triggered_event_cleanup(idev);
-	return ret;
-}
-
-static int hi8435_remove(struct spi_device *spi)
-{
-	struct iio_dev *idev = spi_get_drvdata(spi);
-
-	iio_device_unregister(idev);
-	iio_triggered_event_cleanup(idev);
-
 	return 0;
 }
 
@@ -554,7 +551,6 @@ static struct spi_driver hi8435_driver = {
 		.of_match_table	= of_match_ptr(hi8435_dt_ids),
 	},
 	.probe		= hi8435_probe,
-	.remove		= hi8435_remove,
 	.id_table	= hi8435_id,
 };
 module_spi_driver(hi8435_driver);
-- 
2.21.0


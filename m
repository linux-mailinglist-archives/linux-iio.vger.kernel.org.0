Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 920D2891B6
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2019 14:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfHKMvy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Aug 2019 08:51:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46707 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfHKMvy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Aug 2019 08:51:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so120133pfc.13;
        Sun, 11 Aug 2019 05:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9vaOsX6xjsXhfgGchvNQGFFfuLtXqJtssGmMQXkZBaE=;
        b=aJ4ML8UBq0EMN3lbtl5fIskSyMSoFQd1sjRYEGSfzg3X4NSo/Zvzb6qCEeUFMoLCpZ
         8T7uUMYctR/eq+VswZWaYd3XJkm7rvk+c5l+9sRUl3eNwJcQZbiMJ6COfiaX+909QP8z
         v+O8U7Of7JHA3XWOvaA9deqxaBsrfGcODARASOuN5ZvySO7JYwMfuS+nJyn89WJCOOmh
         rkr622UtmNtn4hgX2r9BlT1RX1utpEbn6A22HRjMrmcu2OEyS38eHkPcmJqs7v1Pv7CB
         m3tGed8JRAZ4ePcI7DkXbtSmDen6Lm1KYeN6z+wGWlJpGxkWNFQuA7qcoVU5GYx6vHrJ
         VCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9vaOsX6xjsXhfgGchvNQGFFfuLtXqJtssGmMQXkZBaE=;
        b=geF9i8u6edY5hzsxwQ4PZmLmD7n7A2vdbNwDAAEFLITW0UZjrDede15mwvw/j/tzy7
         xbISaxYXYTltJ6p3KRUU/Wt0MeEhBK9u6qZfTuz4YXm3HdVZZUV26wPEBIFuzhvSyqVp
         uLDnznX/TfW6Uma9Z+3ax09HYFNg45BhKv6AOffjhaSV5Yt+dmP3dAAmHFxAR7BqcMEP
         cnt3w26Isr3UrHmpZRFzQ2tHac6yFc3/FNdnxHpECZ7GKrwDXln6URVLxrPzPcQH2Cff
         RD2H7mF9o4Bom2ICE/VZIUam1l9qH1kh/W7Wxnc5dv2vmB3UvQaDQBPqkSiHyz7p19me
         mVpQ==
X-Gm-Message-State: APjAAAVVPpGUtGODFPwOQHd/OVeIQPvQLAB4kg96jcASgEJznfVtCUZv
        mc2nceSrKoRqPUEyjh3vG9o=
X-Google-Smtp-Source: APXvYqwByWhxupnx1SrLkMZznaYmlTnoc9+D/BV9YZx8LHuRDAcracIy4O0BUoe95HVVtmp/fTk7Nw==
X-Received: by 2002:a62:1a45:: with SMTP id a66mr5354560pfa.142.1565527913856;
        Sun, 11 Aug 2019 05:51:53 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id p13sm12664500pjb.30.2019.08.11.05.51.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 05:51:52 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] iio: adc: max1027: Use device-managed APIs
Date:   Sun, 11 Aug 2019 20:51:46 +0800
Message-Id: <20190811125146.21355-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use device-managed APIs to simplify the code.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Delete the debug print and _remove.

 drivers/iio/adc/max1027.c | 38 +++++++-------------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index da84adfdb819..214883458582 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -427,8 +427,9 @@ static int max1027_probe(struct spi_device *spi)
 		return -ENOMEM;
 	}
 
-	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-					 &max1027_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					&iio_pollfunc_store_time,
+					&max1027_trigger_handler, NULL);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev, "Failed to setup buffer\n");
 		return ret;
@@ -439,7 +440,7 @@ static int max1027_probe(struct spi_device *spi)
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
 		dev_err(&indio_dev->dev, "Failed to allocate iio trigger\n");
-		goto fail_trigger_alloc;
+		return ret;
 	}
 
 	st->trig->ops = &max1027_trigger_ops;
@@ -454,7 +455,7 @@ static int max1027_probe(struct spi_device *spi)
 					spi->dev.driver->name, st->trig);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
-		goto fail_dev_register;
+		return ret;
 	}
 
 	/* Disable averaging */
@@ -462,34 +463,10 @@ static int max1027_probe(struct spi_device *spi)
 	ret = spi_write(st->spi, &st->reg, 1);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev, "Failed to configure averaging register\n");
-		goto fail_dev_register;
-	}
-
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&indio_dev->dev, "Failed to register iio device\n");
-		goto fail_dev_register;
+		return ret;
 	}
 
-	return 0;
-
-fail_dev_register:
-fail_trigger_alloc:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
-}
-
-static int max1027_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	pr_debug("%s: remove(spi = 0x%p)\n", __func__, spi);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static struct spi_driver max1027_driver = {
@@ -498,7 +475,6 @@ static struct spi_driver max1027_driver = {
 		.of_match_table = of_match_ptr(max1027_adc_dt_ids),
 	},
 	.probe		= max1027_probe,
-	.remove		= max1027_remove,
 	.id_table	= max1027_id,
 };
 module_spi_driver(max1027_driver);
-- 
2.20.1


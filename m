Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D32F5F175
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2019 04:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfGDCgU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jul 2019 22:36:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45447 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfGDCgU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2019 22:36:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi6so2228637plb.12;
        Wed, 03 Jul 2019 19:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=17cMyJgkH0HXIw8s34At2XEgsBcEyQIQIxsPseRkodQ=;
        b=AhZu6qwNvuKVgc2zCyQWl3kpfq9nrUQ7ZGdN6X84iD8N/26u0xKL81+p3gtxhrdzRM
         dkALJCpyzfrpqDiWLEFCxSZCRZtI24uPKw+ybheFuYW13A/G+LAD/5AvTvnXCLuRibCu
         qgM54t5LaflpwC0jfVCB8IXB+SKa9zmbWUuY0fbv/eGHf8BdAfYqMU0M6T2WGKlhURcr
         y6t7IZeZViNno5SMudoWsdRUqWEaLYJuJik5mmMAuypDU2IjJ8o59XQlFm0mPBCX1OFs
         OOCqxWrshJm24ozgbcJIdPC39PF+ryUu5A04bKgrxFDcCGQ2Kr3OXr+mrpqmraUPOi7u
         PbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=17cMyJgkH0HXIw8s34At2XEgsBcEyQIQIxsPseRkodQ=;
        b=nTa6ENsna82i80cz9TDER2N/LtdIQr5Qm+Jkpvo+AQRAzcnQktnIl4Ok5TbG3GNufT
         F7nRzpnzwmVzA1sDoLURf+WbJocQIgZ/XmYI0vnMvn+2etKvnUWK2HpTtFOPbn9ArglR
         E1U7RJqw0o6Blw3crBYkH44ZubWa2v1Gd/A/HJNASbrk/ugjyTLXp8sRfEUje3QErGGk
         YmFQIz8282tiAV3vQYLZh1oY5T+ZRcDX5DJhLB5y2l5uEONlUjd8V83ujcAXHFC2rPWh
         F/g4zGABlGVvN4qfz2ffiYVNvFQxOrWvcAk2LY0wSLgrMBtOBfIIQg7kpkZogSr2L60e
         +MpQ==
X-Gm-Message-State: APjAAAVI5dQvZWUox6sNl888HlUSo5DKQHBs8F8U+mlzRfJzyl340wq+
        HsIFpgyrQMS0y/Z6zJvfLdE=
X-Google-Smtp-Source: APXvYqyYa/qQjBq+L2gVp4kXx/POPivUqzYoxZec3adveil5Y74g248FhWBgTXuiScCpCkSHU+aWog==
X-Received: by 2002:a17:902:a03:: with SMTP id 3mr45646324plo.302.1562207779601;
        Wed, 03 Jul 2019 19:36:19 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id n26sm4055726pfa.83.2019.07.03.19.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 19:36:19 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [Patch v2 05/10] iio: using dev_get_drvdata directly
Date:   Thu,  4 Jul 2019 10:36:13 +0800
Message-Id: <20190704023613.4643-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Several drivers cast a struct device pointer to a struct
platform_device pointer only to then call platform_get_drvdata().
To improve readability, these constructs can be simplified
by using dev_get_drvdata() directly.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Make the commit message more clearly.

 drivers/iio/adc/at91-sama5d2_adc.c | 12 ++++--------
 drivers/iio/adc/at91_adc.c         |  4 ++--
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index d384cf0250ff..a2837a0e7cba 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1578,8 +1578,7 @@ static void at91_adc_hw_init(struct at91_adc_state *st)
 static ssize_t at91_adc_get_fifo_state(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
-	struct iio_dev *indio_dev =
-			platform_get_drvdata(to_platform_device(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n", !!st->dma_st.dma_chan);
@@ -1588,8 +1587,7 @@ static ssize_t at91_adc_get_fifo_state(struct device *dev,
 static ssize_t at91_adc_get_watermark(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
-	struct iio_dev *indio_dev =
-			platform_get_drvdata(to_platform_device(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n", st->dma_st.watermark);
@@ -1841,8 +1839,7 @@ static int at91_adc_remove(struct platform_device *pdev)
 
 static __maybe_unused int at91_adc_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev =
-			platform_get_drvdata(to_platform_device(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	/*
@@ -1862,8 +1859,7 @@ static __maybe_unused int at91_adc_suspend(struct device *dev)
 
 static __maybe_unused int at91_adc_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev =
-			platform_get_drvdata(to_platform_device(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 	int ret;
 
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index d23709ed9049..32f1c4a33b20 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1359,7 +1359,7 @@ static int at91_adc_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int at91_adc_suspend(struct device *dev)
 {
-	struct iio_dev *idev = platform_get_drvdata(to_platform_device(dev));
+	struct iio_dev *idev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(idev);
 
 	pinctrl_pm_select_sleep_state(dev);
@@ -1370,7 +1370,7 @@ static int at91_adc_suspend(struct device *dev)
 
 static int at91_adc_resume(struct device *dev)
 {
-	struct iio_dev *idev = platform_get_drvdata(to_platform_device(dev));
+	struct iio_dev *idev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(idev);
 
 	clk_prepare_enable(st->clk);
-- 
2.11.0


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FB43FFB1F
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 09:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347978AbhICHak (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 03:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347983AbhICHag (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 03:30:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A34C0613CF
        for <linux-iio@vger.kernel.org>; Fri,  3 Sep 2021 00:29:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u14so10126602ejf.13
        for <linux-iio@vger.kernel.org>; Fri, 03 Sep 2021 00:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/2bGRX6h2ShjY2Ue+ETXCUOUj7+vt7FE17ZT3HOV+8=;
        b=Lvrc4VxY92tToYNa/OcJfuMJMmDvqrpBTZJCKToRaG7VWGR68hJ1446jXykOL/5w18
         C4wN0v7li4i53cC69kh0QRxfqj15o199V7ddMOOLKu+IZ8uFk5z8CvRJ2P5eO8cLmSeY
         2Yxsrfrckc0tc68ZUAPcHrX0f0QVoaol8AS+1WDLvElOCt8i+nH3Wf0csvAR22q5Ry+0
         w+a3ZORE1SaFwtVvNarPg6ZDUC+VWW//l/G/b9g++QxWeeVZtMUA38pieCIFXE6S1T1N
         /3pthPe1rQ8Ivd4tWLkuzK9fcaq5x25kFHyf1UzSe/qv6/WLhc+Pev75Rz/FWXq54C5l
         biNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/2bGRX6h2ShjY2Ue+ETXCUOUj7+vt7FE17ZT3HOV+8=;
        b=jP8oOsBLz1OjCuJYUpqPJxQrFq5ds1KYOgvJ0hxBpMsrB0gi0IRY03kCXLS3dqlIPs
         KAege/35uVW21GFFxP6owGniMyMUruG0GK3DLI1awb8F+TqZoctFBieAq6Hg2DFtDxvW
         LDnEj4tTrvlCwK80cXNLr/FpYvIu8vkFH9W6J0qa82pt+fNebn4lVh2d4UyIiXCUW0H/
         3rVpIqTyc8fBSdf5GIi+RJl1MBLUpAqvcM4QS1xRcO/xueaWDW2rQAG+gcL/VEvasMlI
         fkSe4Md+Dr7tfwVA/J31lkObNwYXZPWUn/sQfd6IzJJW9QOh8fhCyZRueKqExSIUF8wO
         kwow==
X-Gm-Message-State: AOAM533xVltTcwpuockwNcyuqUrqEwIrUoZ4Gs6OPbxtJMBxyNbY7GLX
        Z7yMi9TgGglOwZW0LL44LhaB77MWPHq4ww==
X-Google-Smtp-Source: ABdhPJxg0pseOGWd1vWo2NudsDVj5BE/f7evKJG5rPT7E2j7RfWRsClIqJXNCaLzXo2utpB+Pm5rIA==
X-Received: by 2002:a17:906:f2d8:: with SMTP id gz24mr2648681ejb.343.1630654174478;
        Fri, 03 Sep 2021 00:29:34 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id a15sm2376969edr.2.2021.09.03.00.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 00:29:34 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     jic23@kernel.org, hdegoede@redhat.com, wens@csie.org,
        andriy.shevchenko@linux.intel.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 4/5] iio: adc: lp8788_adc: convert probe to full-device managed
Date:   Fri,  3 Sep 2021 10:29:16 +0300
Message-Id: <20210903072917.45769-5-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903072917.45769-1-aardelean@deviqon.com>
References: <20210903072917.45769-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change converts the probe of this driver to use device-managed
functions only, which means that the remove hook can be removed.
The remove hook has only 2 calls to iio_device_unregister() and
iio_map_array_unregister(). Both these can now be done via devm register
functions, now that there's also a devm_iio_map_array_register() function.

The platform_set_drvdata() can also be removed now.

This change also removes the error print for when the iio_device_register()
call fails. This isn't required now.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/lp8788_adc.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
index 8fb57e375529..6d9b354bc705 100644
--- a/drivers/iio/adc/lp8788_adc.c
+++ b/drivers/iio/adc/lp8788_adc.c
@@ -163,7 +163,8 @@ static struct iio_map lp8788_default_iio_maps[] = {
 	{ }
 };
 
-static int lp8788_iio_map_register(struct iio_dev *indio_dev,
+static int lp8788_iio_map_register(struct device *dev,
+				struct iio_dev *indio_dev,
 				struct lp8788_platform_data *pdata,
 				struct lp8788_adc *adc)
 {
@@ -173,7 +174,7 @@ static int lp8788_iio_map_register(struct iio_dev *indio_dev,
 	map = (!pdata || !pdata->adc_pdata) ?
 		lp8788_default_iio_maps : pdata->adc_pdata;
 
-	ret = iio_map_array_register(indio_dev, map);
+	ret = devm_iio_map_array_register(dev, indio_dev, map);
 	if (ret) {
 		dev_err(&indio_dev->dev, "iio map err: %d\n", ret);
 		return ret;
@@ -196,9 +197,8 @@ static int lp8788_adc_probe(struct platform_device *pdev)
 
 	adc = iio_priv(indio_dev);
 	adc->lp = lp;
-	platform_set_drvdata(pdev, indio_dev);
 
-	ret = lp8788_iio_map_register(indio_dev, lp->pdata, adc);
+	ret = lp8788_iio_map_register(&pdev->dev, indio_dev, lp->pdata, adc);
 	if (ret)
 		return ret;
 
@@ -210,32 +210,11 @@ static int lp8788_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = lp8788_adc_channels;
 	indio_dev->num_channels = ARRAY_SIZE(lp8788_adc_channels);
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "iio dev register err: %d\n", ret);
-		goto err_iio_device;
-	}
-
-	return 0;
-
-err_iio_device:
-	iio_map_array_unregister(indio_dev);
-	return ret;
-}
-
-static int lp8788_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-
-	iio_device_unregister(indio_dev);
-	iio_map_array_unregister(indio_dev);
-
-	return 0;
+	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
 static struct platform_driver lp8788_adc_driver = {
 	.probe = lp8788_adc_probe,
-	.remove = lp8788_adc_remove,
 	.driver = {
 		.name = LP8788_DEV_ADC,
 	},
-- 
2.31.1


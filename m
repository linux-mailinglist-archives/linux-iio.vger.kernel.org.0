Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD823B4536
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jun 2021 16:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhFYOEY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Jun 2021 10:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhFYOEX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Jun 2021 10:04:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD25C061766
        for <linux-iio@vger.kernel.org>; Fri, 25 Jun 2021 07:02:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bg14so15249328ejb.9
        for <linux-iio@vger.kernel.org>; Fri, 25 Jun 2021 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D1tsMvDAeuRYczhDgVUkekdSjLDiyIzg0pQFMOQgYwE=;
        b=USDJkxqNofnXE1O9aVxZ2a0KZfneORrPKVeXjdKXYnGUruc9otkm3oF7JI+punj3Dr
         PbD5yqeoc5mwE6fxs2HShcb4dNHkt6hDqvI6KBv76WUWDf5Q6KV5J+j1JQSRlKzfaa75
         9UKuh524GKV40adPXM5eKskCd8H1/UFjltCW46l1UawkrSas2EpYPSGUUBxqc/v4086A
         sNxyGbNNRxU/omf83drSmMmMN55S2tV5VTG1rUIYQ15aEpFRhtHD6sIVC5K1yKPvBfk3
         gxUvIXrbr/Vh5Szu9f8k0jTdp4fvkwc1ZHTP9hYxC+S3Xun2jwUosazOdAjxDPURe79x
         NXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1tsMvDAeuRYczhDgVUkekdSjLDiyIzg0pQFMOQgYwE=;
        b=a8ugTcQhcF0xwMYgQ03BBBN4suefZingU7TtwcH+FNbQqErq5DtsEig6Q1WlGCSMq1
         adisryptC9jtkgwb7y6n/YwTy3lqVN6yrFlRCA5MMQdQozDYx2FtTHFAQOdR0YyNhlg4
         nhNILBBXHVjtp15W9UTIMEENg+/vzF5hP/+1VSHrLHNGWvALNfx1vx5pXk+eExo7K3Gw
         ywH4WF1R4D1XzoS8ZnLabv1IT3vcOHxVS7P3iRnpcNlw/+xjHcmmxBELVpQHVJYsWZph
         X/Uhsyj98dtRbUlYbC2IHfXxydUsvcMQIRBOba8tv9e5SI1SEm9bgH2AsmhFp25H/Vh+
         DjiQ==
X-Gm-Message-State: AOAM532pTnWbeFiBzlE547PYttUH0IAYwmJ9gAh5ZYNqHiZrNFqYN54J
        OAtJ/RLRn64pxMw/rn6dw+qyIBjmYDPyJrKb
X-Google-Smtp-Source: ABdhPJw+7UXY5n7f8Utlr/NO8COcUPMZqLn2DvnPK4SgD9CtKDtIGgFdQKNUGUdVd7f62pNtSBumlw==
X-Received: by 2002:a17:907:9813:: with SMTP id ji19mr11118539ejc.318.1624629720334;
        Fri, 25 Jun 2021 07:02:00 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id g23sm2767853ejh.116.2021.06.25.07.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 07:01:59 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 2/2] iio: accel: bma220: make suspend state setting more robust
Date:   Fri, 25 Jun 2021 17:01:37 +0300
Message-Id: <20210625140137.362282-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625140137.362282-1-aardelean@deviqon.com>
References: <20210625140137.362282-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The datasheet mentions that the suspend mode is toggled by reading the
suspend register. The reading returns value 0xFF if the system was in
suspend mode, otherwise it returns value 0x00.

The bma220_deinit() function does up to 2 reads, in case the device was in
suspend mode, which suggests a level of paranoia that makes the logic in
bma220_suspend() and bma220_resume() look insufficient.

This change implements a bma220_power() function which does up to 2 reads
of the suspend register to make sure that the chip enters a desired
(suspended or normal) mode.

If the transition fails, then -EBUSY is returned.

Since only a reference to SPI device is required, we can remove the
spi_set_drvdata() call and get the SPI device object from the base device
object in the suspend/resume routines.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/bma220_spi.c | 41 ++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 0095931a11f8..bc4c626e454d 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -218,14 +218,33 @@ static int bma220_init(struct spi_device *spi)
 	return 0;
 }
 
-static void bma220_deinit(void *spi)
+static int bma220_power(struct spi_device *spi, bool up)
 {
-	int ret;
+	int i, ret;
+
+	/**
+	 * The chip can be suspended/woken up by a simple register read.
+	 * So, we need up to 2 register reads of the suspend register
+	 * to make sure that the device is in the desired state.
+	 */
+	for (i = 0; i < 2; i++) {
+		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
+		if (ret < 0)
+			return ret;
 
-	/* Make sure the chip is powered off */
-	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-	if (ret == BMA220_SUSPEND_SLEEP)
-		bma220_read_reg(spi, BMA220_REG_SUSPEND);
+		if (up && ret == BMA220_SUSPEND_SLEEP)
+			return 0;
+
+		if (!up && ret == BMA220_SUSPEND_WAKE)
+			return 0;
+	}
+
+	return -EBUSY;
+}
+
+static void bma220_deinit(void *spi)
+{
+	bma220_power(spi, false);
 }
 
 static int bma220_probe(struct spi_device *spi)
@@ -242,7 +261,6 @@ static int bma220_probe(struct spi_device *spi)
 
 	data = iio_priv(indio_dev);
 	data->spi_device = spi;
-	spi_set_drvdata(spi, indio_dev);
 	mutex_init(&data->lock);
 
 	indio_dev->info = &bma220_info;
@@ -273,17 +291,16 @@ static int bma220_probe(struct spi_device *spi)
 
 static __maybe_unused int bma220_suspend(struct device *dev)
 {
-	struct bma220_data *data = iio_priv(dev_get_drvdata(dev));
+	struct spi_device *spi = to_spi_device(dev);
 
-	/* The chip can be suspended/woken up by a simple register read. */
-	return bma220_read_reg(data->spi_device, BMA220_REG_SUSPEND);
+	return bma220_power(spi, false);
 }
 
 static __maybe_unused int bma220_resume(struct device *dev)
 {
-	struct bma220_data *data = iio_priv(dev_get_drvdata(dev));
+	struct spi_device *spi = to_spi_device(dev);
 
-	return bma220_read_reg(data->spi_device, BMA220_REG_SUSPEND);
+	return bma220_power(spi, true);
 }
 static SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume);
 
-- 
2.31.1


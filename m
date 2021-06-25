Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4CE3B4535
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jun 2021 16:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhFYOEW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Jun 2021 10:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFYOEV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Jun 2021 10:04:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CD0C061766
        for <linux-iio@vger.kernel.org>; Fri, 25 Jun 2021 07:02:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c7so13539498edn.6
        for <linux-iio@vger.kernel.org>; Fri, 25 Jun 2021 07:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z+KMbze32Ri6x52TPJK4QM4wxVfroiCmkS67qVQBUE4=;
        b=YGYUui9WFUDmI+j+Sb9qMHMQ20BKewTTNR3O6qy3UpLr6U7t0zXQUoYKyteFgXhgkb
         1AUaxQpsD1E0OCYS7eIFg3vhok2ubkg2YWOfMA8NSQ3apMJ/enCVdyPFrr9Zc9EDPlcQ
         3s5qQCPQWkRifKuTCcBBL1hcjerEm4JG0gymiPbLST+SiOyc+LqtNpyOHgi8EB/j9Xgm
         pWj7TcKoEzDR+BszEw0Z5UJbzOUGANWcjHqBSOOctrQU1gX+jfBW6C5BYYKW5wXPw5xU
         xITMLa+1dWni/ccYBJaC4wikE+2UOqFkku6bk05Newy7ncXXbsn6fm5fehRFtQVRcqQ5
         X/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z+KMbze32Ri6x52TPJK4QM4wxVfroiCmkS67qVQBUE4=;
        b=jP6GYDVT6oYgGN/U/RxqWqFIL12ox6qcA3sDzF+xcdx1H+flfuolHp9IIdT3A7gucZ
         L0dDEpqz2e1bg4mXpjq/81COvZ8RI1qvYWnV73Gt6gwkrsCYkmSsGvl7aid3F70o2KYc
         vkScH+mcCLCL0UU/79QOFY7RkVQmAPUrsifNAozuBQahlLPwis3F18EUM6SD0zR6+5Jc
         mqOjetyb70hViyyJNLU7KSGq4hxcWFQ7thqR4UCGT10ROB+1cBBzuyMutBM98dT83nm0
         BKVidc03xUDV8GiKeIIjSCIOzMxwyhALJJa+gRyHQtGEOKac5OmV89ljOsgIv0HBM7XI
         O+pA==
X-Gm-Message-State: AOAM531zyDx5tSkwkMVNnK+YqvTNNWJ5d6b04nKVRhxittL0TJ/xejgL
        kjKQk8XY770WIiQ6lFyIL7XK8hGFvo4oqtPW
X-Google-Smtp-Source: ABdhPJyxNVPSI5D8gDTcai9x/u0+YfMQvhIDVqYK+Mo8+2uvN7ZVL43Lyx5ntksPcwk66ZPxVbveiw==
X-Received: by 2002:a05:6402:849:: with SMTP id b9mr6663053edz.270.1624629719342;
        Fri, 25 Jun 2021 07:01:59 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id g23sm2767853ejh.116.2021.06.25.07.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 07:01:58 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 1/2] iio: accel: bma220: convert probe to device-managed functions
Date:   Fri, 25 Jun 2021 17:01:36 +0300
Message-Id: <20210625140137.362282-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change converts the driver to use devm_iio_triggered_buffer_setup()
and devm_iio_device_register() for initializing and registering the IIO
device.

The bma220_deinit() is converted into a callback for a
devm_add_action_or_reset() hook, so that the device is put in stand-by when
the driver gets uninitialized.
The return value of the bma220_deinit() function isn't used as it does not
add any value. On the error path of the probe function, this can just
override the actual error with -EBUSY, or can even return 0 (no error), on
the error path.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/bma220_spi.c | 44 +++++++++-------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 0622c7936499..0095931a11f8 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -218,20 +218,14 @@ static int bma220_init(struct spi_device *spi)
 	return 0;
 }
 
-static int bma220_deinit(struct spi_device *spi)
+static void bma220_deinit(void *spi)
 {
 	int ret;
 
 	/* Make sure the chip is powered off */
 	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
 	if (ret == BMA220_SUSPEND_SLEEP)
-		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-	if (ret < 0)
-		return ret;
-	if (ret == BMA220_SUSPEND_SLEEP)
-		return -EBUSY;
-
-	return 0;
+		bma220_read_reg(spi, BMA220_REG_SUSPEND);
 }
 
 static int bma220_probe(struct spi_device *spi)
@@ -262,34 +256,19 @@ static int bma220_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
-					 bma220_trigger_handler, NULL);
-	if (ret < 0) {
-		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
-		goto err_suspend;
-	}
+	ret = devm_add_action_or_reset(&spi->dev, bma220_deinit, spi);
+	if (ret)
+		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      bma220_trigger_handler, NULL);
 	if (ret < 0) {
-		dev_err(&spi->dev, "iio_device_register failed\n");
-		iio_triggered_buffer_cleanup(indio_dev);
-		goto err_suspend;
+		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
+		return ret;
 	}
 
-	return 0;
-
-err_suspend:
-	return bma220_deinit(spi);
-}
-
-static int bma220_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return bma220_deinit(spi);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static __maybe_unused int bma220_suspend(struct device *dev)
@@ -326,7 +305,6 @@ static struct spi_driver bma220_driver = {
 		.acpi_match_table = bma220_acpi_id,
 	},
 	.probe =            bma220_probe,
-	.remove =           bma220_remove,
 	.id_table =         bma220_spi_id,
 };
 module_spi_driver(bma220_driver);
-- 
2.31.1


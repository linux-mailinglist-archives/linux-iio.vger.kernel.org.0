Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB94A398A
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356322AbiA3Uv0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:51:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57334 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356315AbiA3Uv0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:51:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EA8760DE6
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8322AC340E4;
        Sun, 30 Jan 2022 20:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575885;
        bh=XVg6XfAkK/67yGiaJDqjp8neIzPMRLiZIhgvPhhhV+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YKyC+R+S3B4FbaFUNFPKA3EJLawmVpvzy4IQ2QbT+3bpYOXd5AeHYNtWM2fHMmTKh
         E57wvV9PHqV5SeIv6Y+sz0s3cmv8zRM3K6W2NA3oJ5rR9JWgpMBijnN/pu3qVhHP6K
         DuMXf8WwxddLsBzA7O8Qbd19CosDnbmMUNAAO5evnD0eMX0Pp2CgQkUWmPRsoM/hZ1
         zzvjkW6+fEN/7Vxcec9X90vusztzJ4EpCm4ohuA4UMFUeQKHs1HyuUizaFkVsJVsqK
         yfgUX6E0VBDZfJOxPyHHURven41gbxJzdopk5h+gBoBpHT0ai9sllzy+ObJUydMTn3
         R/z9FCI5SP2zQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 15/16] iio:light:st_uvis25: Move exports to IIO_UVIS25 namespace
Date:   Sun, 30 Jan 2022 20:57:00 +0000
Message-Id: <20220130205701.334592-16-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130205701.334592-1-jic23@kernel.org>
References: <20220130205701.334592-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In order to avoid unnecessary pollution of the global symbol namespace
move the common/library functions into a specific namespace and import
that into the bus specific device drivers that use them.

For more information see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/st_uvis25_core.c | 4 ++--
 drivers/iio/light/st_uvis25_i2c.c  | 1 +
 drivers/iio/light/st_uvis25_spi.c  | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index 41a2ce5a2d53..3d4cc1180b6a 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -323,7 +323,7 @@ int st_uvis25_probe(struct device *dev, int irq, struct regmap *regmap)
 
 	return devm_iio_device_register(dev, iio_dev);
 }
-EXPORT_SYMBOL(st_uvis25_probe);
+EXPORT_SYMBOL_NS(st_uvis25_probe, IIO_UVIS25);
 
 static int __maybe_unused st_uvis25_suspend(struct device *dev)
 {
@@ -349,7 +349,7 @@ static int __maybe_unused st_uvis25_resume(struct device *dev)
 const struct dev_pm_ops st_uvis25_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(st_uvis25_suspend, st_uvis25_resume)
 };
-EXPORT_SYMBOL(st_uvis25_pm_ops);
+EXPORT_SYMBOL_NS(st_uvis25_pm_ops, IIO_UVIS25);
 
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>");
 MODULE_DESCRIPTION("STMicroelectronics uvis25 sensor driver");
diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
index 98cd49eefe45..b06d09af28a3 100644
--- a/drivers/iio/light/st_uvis25_i2c.c
+++ b/drivers/iio/light/st_uvis25_i2c.c
@@ -66,3 +66,4 @@ module_i2c_driver(st_uvis25_driver);
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>");
 MODULE_DESCRIPTION("STMicroelectronics uvis25 i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_UVIS25);
diff --git a/drivers/iio/light/st_uvis25_spi.c b/drivers/iio/light/st_uvis25_spi.c
index af9d94d12787..3a4dc6d7180c 100644
--- a/drivers/iio/light/st_uvis25_spi.c
+++ b/drivers/iio/light/st_uvis25_spi.c
@@ -66,3 +66,4 @@ module_spi_driver(st_uvis25_driver);
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>");
 MODULE_DESCRIPTION("STMicroelectronics uvis25 spi driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_UVIS25);
-- 
2.35.1


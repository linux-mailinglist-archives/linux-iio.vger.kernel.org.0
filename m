Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67804BD08D
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244490AbiBTSJ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 13:09:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244489AbiBTSJ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 13:09:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E726527E3
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 10:09:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB98FB80D9C
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 18:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDE8C340F4;
        Sun, 20 Feb 2022 18:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645380542;
        bh=ZxjMzJJikqH4l+DfN+MBGV4UeQhxj4P4Jh6x2AkWRDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ngDNrr3+BZoju0lFpVEAEemM6OsA3/SwJceESWbBWKE4elXhKFdFUd++ScWw4kfbx
         BmmIekpcDLqlZO0mJYbInHuzi2YUVFqd+fiR1IL2wg4foQzXZrJ67bVjZWBWcBBzz2
         kFnCkHqq/VcNqFfHABxeLAQKbdMNtDJdOBVICAD9m/ROpg0ZcYVZQpNkdMoHUhvtlA
         FzzDehq3i/Y0JTSp6+n/UtS8tieTAg9my2plPDuCK/FL+sSLaGFMb8h5ojRfRv465Q
         GCbFhyjl3IVknwyCYD6TI/cPBMZ0SSsC+yJEn9bP6gYLMgvZkD4Md2RsUaKZ7/4GjO
         0q6ZVkVISzN2g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7/8] iio: imu: lsm6dsx: Use new pm_sleep_ptr() and EXPORT_SIMPLE_DEV_PM_OPS()
Date:   Sun, 20 Feb 2022 18:15:21 +0000
Message-Id: <20220220181522.541718-8-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220181522.541718-1-jic23@kernel.org>
References: <20220220181522.541718-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions move the burden of removing unused code when
CONFIG_PM_SLEEP is not defined onto the compiler rather than requiring
the use of CONFIG_PM guards and similar.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 10 ++++------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c  |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 727b4b6ac696..0a86534bd1dd 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2283,7 +2283,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 }
 EXPORT_SYMBOL(st_lsm6dsx_probe);
 
-static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
+static int st_lsm6dsx_suspend(struct device *dev)
 {
 	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
 	struct st_lsm6dsx_sensor *sensor;
@@ -2322,7 +2322,7 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 	return err;
 }
 
-static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
+static int st_lsm6dsx_resume(struct device *dev)
 {
 	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
 	struct st_lsm6dsx_sensor *sensor;
@@ -2358,10 +2358,8 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 	return err;
 }
 
-const struct dev_pm_ops st_lsm6dsx_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(st_lsm6dsx_suspend, st_lsm6dsx_resume)
-};
-EXPORT_SYMBOL(st_lsm6dsx_pm_ops);
+EXPORT_SIMPLE_DEV_PM_OPS(st_lsm6dsx_pm_ops, st_lsm6dsx_suspend,
+			 st_lsm6dsx_resume);
 
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 8b4fc2c15622..faf4e67f0f4c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -129,7 +129,7 @@ MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
 static struct i2c_driver st_lsm6dsx_driver = {
 	.driver = {
 		.name = "st_lsm6dsx_i2c",
-		.pm = &st_lsm6dsx_pm_ops,
+		.pm = pm_sleep_ptr(&st_lsm6dsx_pm_ops),
 		.of_match_table = st_lsm6dsx_i2c_of_match,
 	},
 	.probe = st_lsm6dsx_i2c_probe,
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
index 8d4201b86e87..aaa6b29be3be 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
@@ -44,7 +44,7 @@ static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
 static struct i3c_driver st_lsm6dsx_driver = {
 	.driver = {
 		.name = "st_lsm6dsx_i3c",
-		.pm = &st_lsm6dsx_pm_ops,
+		.pm = pm_sleep_ptr(&st_lsm6dsx_pm_ops),
 	},
 	.probe = st_lsm6dsx_i3c_probe,
 	.id_table = st_lsm6dsx_i3c_ids,
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index e80110b6b280..6180110a1379 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -129,7 +129,7 @@ MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
 static struct spi_driver st_lsm6dsx_driver = {
 	.driver = {
 		.name = "st_lsm6dsx_spi",
-		.pm = &st_lsm6dsx_pm_ops,
+		.pm = pm_sleep_ptr(&st_lsm6dsx_pm_ops),
 		.of_match_table = st_lsm6dsx_spi_of_match,
 	},
 	.probe = st_lsm6dsx_spi_probe,
-- 
2.35.1


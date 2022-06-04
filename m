Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D12F53D79C
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbiFDQDn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbiFDQDm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:03:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1309286DA
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 09:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C685B8070D
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 16:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1456C36AE5;
        Sat,  4 Jun 2022 16:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654358619;
        bh=0J10Zn3+jeOQvbAvatRYZsyjd3qtmvlN3vkoNStEc74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DRRQ7DwEiuKvJnsSqjJqJcO1slUApqhSa65G/dmqafm7FSXy+9GF3/3JZw4EGu3xZ
         DysHrG1nU+nTNNd5mnpnJ7Rq0jTpowVEvii/Ff8/YrSGbtC+SSOooC6EwlK0K4nywr
         3rRxITWD0AVfpX0egUrbLYtE14cje3gPPmaxqu80srwLA5VT00yCEw8ef6FtDP7xVV
         1wyWDxwOMF/HBDrBxG2Y1K4Vh3lQhuXTnWLDsWgorgMfFdP0Ya2qo0QXsPgv7m8n3Y
         X80bBIuS6CuuWYUWLAX6Fezdnc9kTe+/lSfLf3mEpcVwN3DfIV9iswE4ynyCW/Hhml
         E2qHlh4NaXS1Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RESEND PATCH 4/5] iio: imu: lsm6dsx: Use new pm_sleep_ptr() and EXPORT_SIMPLE_DEV_PM_OPS()
Date:   Sat,  4 Jun 2022 17:12:22 +0100
Message-Id: <20220604161223.461847-5-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220604161223.461847-1-jic23@kernel.org>
References: <20220604161223.461847-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Link: https://lore.kernel.org/r/20220220181522.541718-8-jic23@kernel.org
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 10 ++++------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c  |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 910397716833..9e4aa5c1c8d6 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2291,7 +2291,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 }
 EXPORT_SYMBOL(st_lsm6dsx_probe);
 
-static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
+static int st_lsm6dsx_suspend(struct device *dev)
 {
 	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
 	struct st_lsm6dsx_sensor *sensor;
@@ -2330,7 +2330,7 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 	return err;
 }
 
-static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
+static int st_lsm6dsx_resume(struct device *dev)
 {
 	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
 	struct st_lsm6dsx_sensor *sensor;
@@ -2366,10 +2366,8 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
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
index 715fbdc8190e..5bd565b93a8c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -134,7 +134,7 @@ MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
 static struct i2c_driver st_lsm6dsx_driver = {
 	.driver = {
 		.name = "st_lsm6dsx_i2c",
-		.pm = &st_lsm6dsx_pm_ops,
+		.pm = pm_sleep_ptr(&st_lsm6dsx_pm_ops),
 		.of_match_table = st_lsm6dsx_i2c_of_match,
 	},
 	.probe = st_lsm6dsx_i2c_probe,
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
index 35556cd04284..4df186499802 100644
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
index f5767cf76c1d..3a206fd4d92c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -134,7 +134,7 @@ MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
 static struct spi_driver st_lsm6dsx_driver = {
 	.driver = {
 		.name = "st_lsm6dsx_spi",
-		.pm = &st_lsm6dsx_pm_ops,
+		.pm = pm_sleep_ptr(&st_lsm6dsx_pm_ops),
 		.of_match_table = st_lsm6dsx_spi_of_match,
 	},
 	.probe = st_lsm6dsx_spi_probe,
-- 
2.36.1


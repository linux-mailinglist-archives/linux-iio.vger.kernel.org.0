Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109E645AE05
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbhKWVKa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239635AbhKWVKZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3C766023D;
        Tue, 23 Nov 2021 21:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701636;
        bh=1h2ZngHrSurqRcGyTzrdC7RJlzxn0swjgFcC6yUGkT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/1PulOmA5L0QlRP4zIe8HkBirNy0tbe++LW8WK/UELTXQJl6RZBCXLQRWcTYb26T
         8Q0FxAeviNp4PLV6i32egI2q6mVdrGxQ3pB+rLzSpLqQo3WUz6UNcCoVAeg5a7bTLC
         MhF0X8SjJakauFhhLGlHjxTI2foNGShv60XyFZVXLNz/tgLnI7kConbb74K2Uh+b/V
         TpYC1ZBxFUFUhQCF/19jRMvsVbT1q86yQoOuHZJ+KABArGsHTYTeyoggLdfSTjNOxA
         uCSn3qtj3DvVDIv5mJ0eswFg01lmTt4JS2tcwfSSAP+TLWMoaF4774GvXN9/xrURmb
         ozfIHwqNGC/SA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 43/49] iio:proximity:pulsedlight: Switch from CONFIG_PM guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:13 +0000
Message-Id: <20211123211019.2271440-44-jic23@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123211019.2271440-1-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 27026c060ab9..6adc2a0c27cb 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -338,8 +338,7 @@ static const struct of_device_id lidar_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, lidar_dt_ids);
 
-#ifdef CONFIG_PM
-static int lidar_pm_runtime_suspend(struct device *dev)
+static __maybe_unused int lidar_pm_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct lidar_data *data = iio_priv(indio_dev);
@@ -347,7 +346,7 @@ static int lidar_pm_runtime_suspend(struct device *dev)
 	return lidar_write_power(data, 0x0f);
 }
 
-static int lidar_pm_runtime_resume(struct device *dev)
+static __maybe_unused int lidar_pm_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct lidar_data *data = iio_priv(indio_dev);
@@ -358,9 +357,8 @@ static int lidar_pm_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops lidar_pm_ops = {
+static __maybe_unused const struct dev_pm_ops lidar_pm_ops = {
 	SET_RUNTIME_PM_OPS(lidar_pm_runtime_suspend,
 			   lidar_pm_runtime_resume, NULL)
 };
@@ -369,7 +367,7 @@ static struct i2c_driver lidar_driver = {
 	.driver = {
 		.name	= LIDAR_DRV_NAME,
 		.of_match_table	= lidar_dt_ids,
-		.pm	= &lidar_pm_ops,
+		.pm	= pm_ptr(&lidar_pm_ops),
 	},
 	.probe		= lidar_probe,
 	.remove		= lidar_remove,
-- 
2.34.0


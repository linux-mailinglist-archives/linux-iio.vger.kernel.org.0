Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DB945AE01
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbhKWVKZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239594AbhKWVKQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0069660FE3;
        Tue, 23 Nov 2021 21:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701628;
        bh=4wuW/1YiilLk7lzlGptyP6drdNxu52X3SrhEokC6ZoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UaQkoTdotQad4hAXdPSzzbjfYMMi9h7z896skdPlVmenu7tYZ5nCR1f5yw1jm7WtR
         FH8G9TzRs+5qqG2+aVUh9zNwGDR0zq71ZbPxY1Bisk0R7GgIBH8v2ycWANIAdiSUx4
         f3Dn5qgUjnBbUx5VtoTfP9z0cSzuAJ+0mmz4zooZNt1Pep4Jt9rk1YQWyJHz1HmcS0
         BkmQXHrL467K5OmjjvRXfURT09Cv1Z5str1kAQ059QUcRVRDrHiCCzPG4N87HgIe4G
         BLIJeJY0szNs93vHy5jYpUpsq5UVcMNSjZwwrcSAghbY/Tubf+dqQ3vaTIeGNrDFpw
         fEUnDHFVM+O7g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 39/49] iio:magn:mmc35240: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:09 +0000
Message-Id: <20211123211019.2271440-40-jic23@kernel.org>
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
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards. Also use SIMPLE_DEV_PM_OPS instead
of open-coding the equivalent.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/mmc35240.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 65f3d1ed0d59..57ecb6adeb1b 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -521,8 +521,7 @@ static int mmc35240_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mmc35240_suspend(struct device *dev)
+static __maybe_unused int mmc35240_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mmc35240_data *data = iio_priv(indio_dev);
@@ -532,7 +531,7 @@ static int mmc35240_suspend(struct device *dev)
 	return 0;
 }
 
-static int mmc35240_resume(struct device *dev)
+static __maybe_unused int mmc35240_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mmc35240_data *data = iio_priv(indio_dev);
@@ -548,11 +547,8 @@ static int mmc35240_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops mmc35240_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mmc35240_suspend, mmc35240_resume)
-};
+static SIMPLE_DEV_PM_OPS(mmc35240_pm_ops, mmc35240_suspend, mmc35240_resume);
 
 static const struct of_device_id mmc35240_of_match[] = {
 	{ .compatible = "memsic,mmc35240", },
@@ -576,7 +572,7 @@ static struct i2c_driver mmc35240_driver = {
 	.driver = {
 		.name = MMC35240_DRV_NAME,
 		.of_match_table = mmc35240_of_match,
-		.pm = &mmc35240_pm_ops,
+		.pm = pm_ptr(&mmc35240_pm_ops),
 		.acpi_match_table = ACPI_PTR(mmc35240_acpi_match),
 	},
 	.probe		= mmc35240_probe,
-- 
2.34.0


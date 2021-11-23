Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB3D45ADFD
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbhKWVKJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239571AbhKWVKI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01C6860FE3;
        Tue, 23 Nov 2021 21:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701620;
        bh=ghdBt6rfGotqcNIj5gAlkWkQtXRoZzErXq0ogcvPUvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4FR8DX4n369Y0j37X4cQBabAEs8DU20YykjornE6yfH+ntDWxEAcVghLNLzp//Of
         xZUifXoE5Q2xl8cCAS+SJCvWQOptn+MnfG789zusQRzs0PA1AuhYUn0cCJoxVd47At
         ZQg8fDvthOVyN33wIbTb64aCC09g2//P9BX1R/x4+23SlE1ak9HW7lwe57wQ91jbei
         FohTeq/7JgS5DBpmv8axwGvaMp8cmunXRIahlvSV9yHFHoQJcy3ilmTPq5HPLlk+ab
         2HCjGmLG5i5l6S99q6PwuLDZ2/CY96QHTIDSw0vI4CeZZFBW0PG9LNwjJUqNdn/1/P
         D5vXpDgR3ziaw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 35/49] iio:light:us5182: Switch from CONFIG_PM guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:05 +0000
Message-Id: <20211123211019.2271440-36-jic23@kernel.org>
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
---
 drivers/iio/light/us5182d.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 96e4a66ddf28..79d589f2fb79 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -916,8 +916,7 @@ static int us5182d_remove(struct i2c_client *client)
 	return us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
 }
 
-#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM)
-static int us5182d_suspend(struct device *dev)
+static __maybe_unused int us5182d_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct us5182d_data *data = iio_priv(indio_dev);
@@ -928,7 +927,7 @@ static int us5182d_suspend(struct device *dev)
 	return 0;
 }
 
-static int us5182d_resume(struct device *dev)
+static __maybe_unused int us5182d_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct us5182d_data *data = iio_priv(indio_dev);
@@ -939,9 +938,8 @@ static int us5182d_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops us5182d_pm_ops = {
+static __maybe_unused const struct dev_pm_ops us5182d_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(us5182d_suspend, us5182d_resume)
 	SET_RUNTIME_PM_OPS(us5182d_suspend, us5182d_resume, NULL)
 };
@@ -969,7 +967,7 @@ MODULE_DEVICE_TABLE(of, us5182d_of_match);
 static struct i2c_driver us5182d_driver = {
 	.driver = {
 		.name = US5182D_DRV_NAME,
-		.pm = &us5182d_pm_ops,
+		.pm = pm_ptr(&us5182d_pm_ops),
 		.of_match_table = us5182d_of_match,
 		.acpi_match_table = ACPI_PTR(us5182d_acpi_match),
 	},
-- 
2.34.0


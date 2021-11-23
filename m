Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4CB45ADE1
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhKWVJS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234770AbhKWVJS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80DBB6023D;
        Tue, 23 Nov 2021 21:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701569;
        bh=YSAF/cR1QrA94lzb39v6u1KPLGp6BBtsaNFmQiq2Dfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=grV3/ghxjnujyqIagWH+N0DJiBfw1EQg/WpuFpb1aCnjAzB4oM40ar+Vsyd1QaNh4
         2aA46b9410GmHrGyJRGnpOWekxWs410ZwM8d2GNhy1yjzo3tbr5Wl8wuzSVbxaFLha
         fsveaMDGkqD0Qp86ifN/X5bVXDTI24Hfjc6PklhVG0WBoWoTyZGM4R/HdACuL9pizy
         LKU9sJgm9Dlpe3INdKs6TC7g2jD784hqbqOjo6NFsHRMoY78xkltdWqAmmiUPEHGjT
         sPn+v8a5hlVk7efGiKMqfZLlLv+CmGrrplnGy53TLtPRQpB/HUV7kXQcBqIm1n0E4l
         j+qN4z2qTFlRw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 10/49] iio:accel:kxsd9: Switch from CONFIG_PM guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:40 +0000
Message-Id: <20211123211019.2271440-11-jic23@kernel.org>
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
 drivers/iio/accel/kxsd9-i2c.c | 2 +-
 drivers/iio/accel/kxsd9-spi.c | 2 +-
 drivers/iio/accel/kxsd9.c     | 8 +++-----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index 274b41a6e603..ffe8066b4025 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -55,7 +55,7 @@ static struct i2c_driver kxsd9_i2c_driver = {
 	.driver = {
 		.name	= "kxsd9",
 		.of_match_table = kxsd9_of_match,
-		.pm = &kxsd9_dev_pm_ops,
+		.pm = pm_ptr(&kxsd9_dev_pm_ops),
 	},
 	.probe		= kxsd9_i2c_probe,
 	.remove		= kxsd9_i2c_remove,
diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index 441e6b764281..44edf39fc5ff 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -54,7 +54,7 @@ MODULE_DEVICE_TABLE(of, kxsd9_of_match);
 static struct spi_driver kxsd9_spi_driver = {
 	.driver = {
 		.name = "kxsd9",
-		.pm = &kxsd9_dev_pm_ops,
+		.pm = pm_ptr(&kxsd9_dev_pm_ops),
 		.of_match_table = kxsd9_of_match,
 	},
 	.probe = kxsd9_spi_probe,
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 2faf85ca996e..f9954288914b 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -492,8 +492,7 @@ void kxsd9_common_remove(struct device *dev)
 }
 EXPORT_SYMBOL(kxsd9_common_remove);
 
-#ifdef CONFIG_PM
-static int kxsd9_runtime_suspend(struct device *dev)
+static __maybe_unused int kxsd9_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct kxsd9_state *st = iio_priv(indio_dev);
@@ -501,16 +500,15 @@ static int kxsd9_runtime_suspend(struct device *dev)
 	return kxsd9_power_down(st);
 }
 
-static int kxsd9_runtime_resume(struct device *dev)
+static __maybe_unused int kxsd9_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct kxsd9_state *st = iio_priv(indio_dev);
 
 	return kxsd9_power_up(st);
 }
-#endif /* CONFIG_PM */
 
-const struct dev_pm_ops kxsd9_dev_pm_ops = {
+const __maybe_unused struct dev_pm_ops kxsd9_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(kxsd9_runtime_suspend,
-- 
2.34.0


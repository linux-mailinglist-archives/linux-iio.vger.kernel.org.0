Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0051845ADFB
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbhKWVKF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239571AbhKWVKF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C49B660FE8;
        Tue, 23 Nov 2021 21:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701616;
        bh=hodLaVDOQkVWgw05MUzW5K4MEOG8iM86rm9dYa8Yuds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QEWd4Z5/xIb52V5P24S++CHfXYyO14eLUezauJQb8yk1F/p0o0eT9Tid9DqatiMFM
         zmoIln6j84Sq/XXpQUhJMzt6+JvtNBAH6FKAizFd0YtgS2X9LG0XmMuzGwc1xVqLtO
         SMARO3Ww1CrwMlk468ytGmJUy3jhuc15lFXp2wV6LHhYZPEe0Z7Z1byfhFmZM9yXGo
         tp5st9RcHlBcjrbdC4Pjtk4q662adBoC2XpQh7CZzgdywcjeLRHohMDMSylIOZOFmz
         4W4iBGAuwpo430alj5hUmZt2XYxBnZdhUpZDqT7D2eBwfuDTpAfXEoUquuTUjA+NwH
         lgJPIVHjBR5wg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vaishnav M A <vaishnav@beagleboard.org>
Subject: [PATCH 33/49] iio:light:tsl2563: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:03 +0000
Message-Id: <20211123211019.2271440-34-jic23@kernel.org>
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
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Vaishnav M A <vaishnav@beagleboard.org>
---
 drivers/iio/light/tsl2563.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 5bf2bfbc5379..49a45c78603c 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -814,8 +814,7 @@ static int tsl2563_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int tsl2563_suspend(struct device *dev)
+static __maybe_unused int tsl2563_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
@@ -834,7 +833,7 @@ static int tsl2563_suspend(struct device *dev)
 	return ret;
 }
 
-static int tsl2563_resume(struct device *dev)
+static __maybe_unused int tsl2563_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
@@ -858,10 +857,6 @@ static int tsl2563_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(tsl2563_pm_ops, tsl2563_suspend, tsl2563_resume);
-#define TSL2563_PM_OPS (&tsl2563_pm_ops)
-#else
-#define TSL2563_PM_OPS NULL
-#endif
 
 static const struct i2c_device_id tsl2563_id[] = {
 	{ "tsl2560", 0 },
@@ -885,7 +880,7 @@ static struct i2c_driver tsl2563_i2c_driver = {
 	.driver = {
 		.name	 = "tsl2563",
 		.of_match_table = tsl2563_of_match,
-		.pm	= TSL2563_PM_OPS,
+		.pm	= pm_ptr(&tsl2563_pm_ops),
 	},
 	.probe		= tsl2563_probe,
 	.remove		= tsl2563_remove,
-- 
2.34.0


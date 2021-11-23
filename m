Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C244245ADF3
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbhKWVJs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239320AbhKWVJs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E77E6023D;
        Tue, 23 Nov 2021 21:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701599;
        bh=hdzghaUgu3uQBrZh2Cb1l7A2SL5hUsybDvMwvcUh7jU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdki1Alg69TTfBm8VieT2JWStMGqchtk5S1x6+iXhf25kSRE4ZnexU8u3MHqPYybB
         qjvu10X1pEeOL1rR8hX4n6dqtjK9QwyiescNhoVYx1sA3LLV2aBMsR0MVeYEFhXKIH
         a4O50HUX6MSXFUlg/GYdDYbapLcUwQzsj2QuFYzREZis6Mqi5TSRS4ApBmE87+sYjg
         u4cTiVVZO/3EKlqyrhHF39B4vumVSATNba02Zr3Y8ixhOrsUZNinFQSeI9NoTvC+Fj
         jKnQnq5AJZy6s8VKSN4gI+LL3VbPVC8EhykU6Up+Ttbnxm0lFIgwVhqp7qo5+sV5+y
         hsMGIe3rSXSSg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 25/49] iio:light:cm3232: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:55 +0000
Message-Id: <20211123211019.2271440-26-jic23@kernel.org>
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
use of #ifdef based config guards.  Also switch to SIMPLE_DEV_PM_OPS rather
than opencoding the same.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/cm3232.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index 18a410340dc5..660f3204dc18 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -374,8 +374,7 @@ static const struct i2c_device_id cm3232_id[] = {
 	{}
 };
 
-#ifdef CONFIG_PM_SLEEP
-static int cm3232_suspend(struct device *dev)
+static __maybe_unused int cm3232_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct cm3232_chip *chip = iio_priv(indio_dev);
@@ -389,7 +388,7 @@ static int cm3232_suspend(struct device *dev)
 	return ret;
 }
 
-static int cm3232_resume(struct device *dev)
+static __maybe_unused int cm3232_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct cm3232_chip *chip = iio_priv(indio_dev);
@@ -403,9 +402,7 @@ static int cm3232_resume(struct device *dev)
 	return ret;
 }
 
-static const struct dev_pm_ops cm3232_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(cm3232_suspend, cm3232_resume)};
-#endif
+static SIMPLE_DEV_PM_OPS(cm3232_pm_ops, cm3232_suspend, cm3232_resume);
 
 MODULE_DEVICE_TABLE(i2c, cm3232_id);
 
@@ -419,9 +416,7 @@ static struct i2c_driver cm3232_driver = {
 	.driver = {
 		.name	= "cm3232",
 		.of_match_table = cm3232_of_match,
-#ifdef CONFIG_PM_SLEEP
-		.pm	= &cm3232_pm_ops,
-#endif
+		.pm	= pm_ptr(&cm3232_pm_ops),
 	},
 	.id_table	= cm3232_id,
 	.probe		= cm3232_probe,
-- 
2.34.0


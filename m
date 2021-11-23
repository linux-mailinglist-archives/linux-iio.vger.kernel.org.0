Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1045ADD9
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhKWVJF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234240AbhKWVJE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4612760FC1;
        Tue, 23 Nov 2021 21:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701555;
        bh=pTulFIQj2QTy//8it93U4MTzZbwk7N6xAurBVbdoAjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pgq8Bpp4yh5+7q9f8JmU8QOfRWspRNNwphteHTQ/hP+zKV5ICl3vh1cc2n7YF3NTD
         9b/w9AgpSye4g+diFJ6jWWnD6QesH87fb5KK2xfxlcE+9zhq+g6VEe2Fydk1qVWSH2
         ghc6ovou97Wd6pgtZ1Llnbz2U4ojEaDX4hbFJRjTUBEQHzrz1g7FKsGp64xcdKBWh7
         Em5dKScRJIz8DCcqLWw0syXrPtZ0HQO1BhZ7otffNdY8aQrAvxFqI1PTklnkYEAQx/
         2Bk5vCCpGRW7ighQl6WOnlLEE7Ls3Z0bZyZLoSCdD5Thu0FyWAvjJ/n4DcA/l91qcK
         96biqZxiwyb9g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 02/49] iio:accel:da280: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:32 +0000
Message-Id: <20211123211019.2271440-3-jic23@kernel.org>
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
---
 drivers/iio/accel/da280.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 9633bdae5fd4..91ac478891ce 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -153,17 +153,15 @@ static int da280_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int da280_suspend(struct device *dev)
+static __maybe_unused int da280_suspend(struct device *dev)
 {
 	return da280_enable(to_i2c_client(dev), false);
 }
 
-static int da280_resume(struct device *dev)
+static __maybe_unused int da280_resume(struct device *dev)
 {
 	return da280_enable(to_i2c_client(dev), true);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(da280_pm_ops, da280_suspend, da280_resume);
 
-- 
2.34.0


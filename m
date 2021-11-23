Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F91A45ADF1
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbhKWVJo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239516AbhKWVJn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF6A360FED;
        Tue, 23 Nov 2021 21:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701595;
        bh=u0MtymLFV3NgSDPa2ZVX2jGe0TufuKjzvYOYOsYsiCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YtHfuhtoFenKegy4D9BQ+319Amdc/HfOowiEze8L0OGsUws5mNpEZnDVWTCgwVT0/
         YrURCFD7/yWeA0qBdVOJQjATStxpD1a/fthsMVFBbT0PKwebFIk273IJzdDIG9DzTB
         1DPu3M7u3Ue8zAqZZjDByvTwN8q2K1keaY2s+ykWaPnfZBFsICCAzg1v+0Bd7lOKb8
         ubD0Lv1T0xTn8nOTA7hBviV2beC/cJSPS3tlDrzF3n56sIRkvo28whfgim3FnD+gnC
         DFC8NUVFD4iIB1z5LvWyG9B9Gkvnqjp28VeWwNbMAniamEc7E2adYRlUTHjEh8ozXs
         k42O3Z1/oi1Rg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 23/49] iio:light:apds9300: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:53 +0000
Message-Id: <20211123211019.2271440-24-jic23@kernel.org>
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
 drivers/iio/light/apds9300.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index baaf202dce05..56dcd255a649 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -466,8 +466,7 @@ static int apds9300_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int apds9300_suspend(struct device *dev)
+static __maybe_unused int apds9300_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct apds9300_data *data = iio_priv(indio_dev);
@@ -480,7 +479,7 @@ static int apds9300_suspend(struct device *dev)
 	return ret;
 }
 
-static int apds9300_resume(struct device *dev)
+static __maybe_unused int apds9300_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct apds9300_data *data = iio_priv(indio_dev);
@@ -494,10 +493,6 @@ static int apds9300_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(apds9300_pm_ops, apds9300_suspend, apds9300_resume);
-#define APDS9300_PM_OPS (&apds9300_pm_ops)
-#else
-#define APDS9300_PM_OPS NULL
-#endif
 
 static const struct i2c_device_id apds9300_id[] = {
 	{ APDS9300_DRV_NAME, 0 },
@@ -509,7 +504,7 @@ MODULE_DEVICE_TABLE(i2c, apds9300_id);
 static struct i2c_driver apds9300_driver = {
 	.driver = {
 		.name	= APDS9300_DRV_NAME,
-		.pm	= APDS9300_PM_OPS,
+		.pm	= pm_ptr(&apds9300_pm_ops),
 	},
 	.probe		= apds9300_probe,
 	.remove		= apds9300_remove,
-- 
2.34.0


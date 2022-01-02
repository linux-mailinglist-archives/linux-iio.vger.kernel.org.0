Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B509A482B37
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbiABMv6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42300 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiABMv6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4321860E9C
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9008BC36AEE;
        Sun,  2 Jan 2022 12:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127917;
        bh=OsR4uLiflqXTOkVbxayRoG124ge6ry+RgvKPUAosPIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+EYfOgjVXAD/Fa1BpYNK8Fz6mQdsxiSAmqEKp9VnKET2BKLAlbzSLpWR+QkkULUY
         AVLV1aMVam35Y0dM7BEGLTp7USMQLzLyeTW/y0mC8PzUoE8Vvtcs26rxi/rxlb1v3p
         EVxK14c8eFf/ZUqEIZ/9tPgGSXH16pe84yTMBmK13OPuKV+zANyw28cpOTYhmmJ5ym
         21pNCjcefhW24Tmz42FYMphku9HsE9qDoKAErYi/67MTfWX0Cvz68IYfCm95lgm4CN
         GKP4lHwnGGR+2ds30/TYeb1XzLzRwN22gsmQF+9Wvo8FsMagc8x01QFcKXdSk0W/3T
         g5PheS6wWqTzg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 24/51] iio:light:cm3232: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:50 +0000
Message-Id: <20220102125617.1259804-25-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102125617.1259804-1-jic23@kernel.org>
References: <20220102125617.1259804-1-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/cm3232.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index 18a410340dc5..122130f1a683 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -374,7 +374,6 @@ static const struct i2c_device_id cm3232_id[] = {
 	{}
 };
 
-#ifdef CONFIG_PM_SLEEP
 static int cm3232_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -403,9 +402,7 @@ static int cm3232_resume(struct device *dev)
 	return ret;
 }
 
-static const struct dev_pm_ops cm3232_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(cm3232_suspend, cm3232_resume)};
-#endif
+DEFINE_SIMPLE_DEV_PM_OPS(cm3232_pm_ops, cm3232_suspend, cm3232_resume);
 
 MODULE_DEVICE_TABLE(i2c, cm3232_id);
 
@@ -419,9 +416,7 @@ static struct i2c_driver cm3232_driver = {
 	.driver = {
 		.name	= "cm3232",
 		.of_match_table = cm3232_of_match,
-#ifdef CONFIG_PM_SLEEP
-		.pm	= &cm3232_pm_ops,
-#endif
+		.pm	= pm_sleep_ptr(&cm3232_pm_ops),
 	},
 	.id_table	= cm3232_id,
 	.probe		= cm3232_probe,
-- 
2.34.1


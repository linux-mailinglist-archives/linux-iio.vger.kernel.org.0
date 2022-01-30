Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015074A38A3
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355948AbiA3T1G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51806 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355951AbiA3T0w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C20D2B829AD
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E24C340EF;
        Sun, 30 Jan 2022 19:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570810;
        bh=sHJZzAacRvwCMdFgTfMD8jeDKiY7BZo2VxcnPHDXS6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AfM5TCmp767VkpysT/tGCIkN8L4b3HVVr/ntA3r4UfVuPvgp1z+piRCQVvB7TTc/a
         bU23yY+Ej+QGtxtQOBF0WZWqnaDCt8tzEl+vE5lKsju1KgvYUyQgqT0UOCJgAYFPia
         vrbXQeA4xvwVTsvapAchpO3eGVVRnR6slgavoepIi9X+DnY/jB74dlpCuN3GGKpLe3
         cDiy+0ENp1157kPuu3LB4xxjRt/CF1Ej/DLnVplxlOTxcnQFUmGeLxkA8tH1KqE+05
         Mh4nzUEEMnBU98q74x4vFDN8sgqWEyLII2o6TKXuvF6L7Ebs1KUn6gbJx4auJ/xoao
         pr/bfjAfk24XQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 35/50] iio:proximity:sx9500: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:32 +0000
Message-Id: <20220130193147.279148-36-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130193147.279148-1-jic23@kernel.org>
References: <20220130193147.279148-1-jic23@kernel.org>
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

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/sx9500.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 3e4ddb2e8c2b..42589d6200ad 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -993,7 +993,6 @@ static int sx9500_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sx9500_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1030,11 +1029,8 @@ static int sx9500_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static const struct dev_pm_ops sx9500_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sx9500_suspend, sx9500_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(sx9500_pm_ops, sx9500_suspend, sx9500_resume);
 
 static const struct acpi_device_id sx9500_acpi_match[] = {
 	{"SSX9500", 0},
@@ -1060,7 +1056,7 @@ static struct i2c_driver sx9500_driver = {
 		.name	= SX9500_DRIVER_NAME,
 		.acpi_match_table = ACPI_PTR(sx9500_acpi_match),
 		.of_match_table = of_match_ptr(sx9500_of_match),
-		.pm = &sx9500_pm_ops,
+		.pm = pm_sleep_ptr(&sx9500_pm_ops),
 	},
 	.probe		= sx9500_probe,
 	.remove		= sx9500_remove,
-- 
2.35.1


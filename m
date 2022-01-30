Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC14A3893
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355904AbiA3T0R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51578 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355910AbiA3T0R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 495D5B829AB
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE7FC340F2;
        Sun, 30 Jan 2022 19:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570774;
        bh=1vAmtdxc+ZdlFQFMjF6UWGf9xPK/8kX0cXiQvukvy2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNd1deYIjx+++qoAr2SA0ytqmpgCxcnntNXTgwJfLW8lRp347T2kGJEPT6v1cxFsr
         CVB5wfi1TYamRc+uCjqgCNJlhy38ljzzFMgxEkeq7tP/n6sfkL7raGneH2XawYevSQ
         LYWjSA86dXr0ZiJLrZ1wMM/4hX6SOu/ANILgjwWFsVemhICNdXKpz+e7nNIDUr10a+
         8g/fVbmiB4Bszta2vHkFS6z774W9TGYLRTka9vpd5bF0ifaj+au+4JCxeenIq0IXJK
         nyPYq0885UdFzC4q3YuGIEpUwcxI/6F/J6qWxTnV+w5oTD7qQ1FFhsadgQZWCWypnI
         iZKEC5SzKQR9w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 19/50] iio:light:cm3232: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:16 +0000
Message-Id: <20220130193147.279148-20-jic23@kernel.org>
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
use of #ifdef based config guards.  Also switch to SIMPLE_DEV_PM_OPS rather
than opencoding the same.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/cm3232.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index 18a410340dc5..2c80a0535d2c 100644
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
+static DEFINE_SIMPLE_DEV_PM_OPS(cm3232_pm_ops, cm3232_suspend, cm3232_resume);
 
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
2.35.1


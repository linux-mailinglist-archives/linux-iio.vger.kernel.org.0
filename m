Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838C5482B49
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiABMwu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42912 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMwu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BA4060E98
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F00C36AEF;
        Sun,  2 Jan 2022 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127969;
        bh=jT8yJlHLU6OsRfS6vM3QNXbyNLBjmK+bc7qZ3JI8xd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jfgqrU1RwZXD+c1onfVrYMlqJHB6Sli8tEGUQ7pdF0xxUeNlGKm1vGV61Dbt2LvY3
         ovsdFO2gf80ri3rkrB8uavWAHJcJHQuuCD0twUfPEt4kHx1AhDoCPXiI8vNGpXz9r0
         OEhMb/UG3tziYwL36hb7/JbKwAqNxdeuCCs71evYlGdNKRV/Jt1uBeURNAp8sIGraK
         p9jmAEKbbyZEtUyqXAmg04vG3UtOvamSF7oj51mZqGxEWPTO8HasTylCcmWH4WhhdV
         wHK8WCR5vhwMUIZq211ksvtblaCsjhhPp7HLvMYNbmpJIJMOLlYFQ+VKuU5KCl902Y
         Ojp6SKqmdiVSA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 42/51] iio:proximity:sx9500: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:08 +0000
Message-Id: <20220102125617.1259804-43-jic23@kernel.org>
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
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/sx9500.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 3e4ddb2e8c2b..01bfd748d820 100644
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
+DEFINE_SIMPLE_DEV_PM_OPS(sx9500_pm_ops, sx9500_suspend, sx9500_resume);
 
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
2.34.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8EB482B50
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiABMxL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMxK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:53:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EF4C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:53:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 479E5B80D63
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72D8C36AEE;
        Sun,  2 Jan 2022 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127988;
        bh=DtfF42whwQdM0j8CLapkd97awWHo0IOCpOukAxl7rYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxvahdJtc7TK6Ifq3zd+usU0yonhux6RAtX1zKewLM5sF58wwrD7JsewBZ5KlIbqI
         HEXOlG1DlAdsy5v0hYfRM9OVQxSdtvMIjeVDO4Z2NXlLlrv+1i7iMsBBHrWHduN6os
         /vaTa3fGEsUUs8xcTzKeEb0tuoKtR2cqFxnaqdqVVCRqa55tMkFvpSK1UDdw6ysgRK
         euSiXSztxG3prd+s+EqcVrGYq9G9dfC4UOKR9RnXWrkOci5Dr0D6Rgw7stn19kxv6Y
         1fv5jSnv4vI78xBWLz2+ERXuY34LwScZpYHXoQOUFwGxBuYwEcKSV+1suTTcCFoD2S
         tGKA/lSuneeyw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 49/51] iio:imu:kmx61: Switch from CONFIG_PM* guards to pm_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:15 +0000
Message-Id: <20220102125617.1259804-50-jic23@kernel.org>
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
without one or  more of CONFIG_PM/CONFIG_PM_SLEEP support is simpler and
less error prone than the use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/kmx61.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 1dabfd615dab..20ac1b4c8923 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1440,7 +1440,6 @@ static int kmx61_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int kmx61_suspend(struct device *dev)
 {
 	int ret;
@@ -1466,9 +1465,7 @@ static int kmx61_resume(struct device *dev)
 
 	return kmx61_set_mode(data, stby, KMX61_ACC | KMX61_MAG, true);
 }
-#endif
 
-#ifdef CONFIG_PM
 static int kmx61_runtime_suspend(struct device *dev)
 {
 	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));
@@ -1493,11 +1490,10 @@ static int kmx61_runtime_resume(struct device *dev)
 
 	return kmx61_set_mode(data, stby, KMX61_ACC | KMX61_MAG, true);
 }
-#endif
 
 static const struct dev_pm_ops kmx61_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(kmx61_suspend, kmx61_resume)
-	SET_RUNTIME_PM_OPS(kmx61_runtime_suspend, kmx61_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(kmx61_suspend, kmx61_resume)
+	RUNTIME_PM_OPS(kmx61_runtime_suspend, kmx61_runtime_resume, NULL)
 };
 
 static const struct acpi_device_id kmx61_acpi_match[] = {
@@ -1518,7 +1514,7 @@ static struct i2c_driver kmx61_driver = {
 	.driver = {
 		.name = KMX61_DRV_NAME,
 		.acpi_match_table = ACPI_PTR(kmx61_acpi_match),
-		.pm = &kmx61_pm_ops,
+		.pm = pm_ptr(&kmx61_pm_ops),
 	},
 	.probe		= kmx61_probe,
 	.remove		= kmx61_remove,
-- 
2.34.1


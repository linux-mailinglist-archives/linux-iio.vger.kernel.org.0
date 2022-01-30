Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256434A38A6
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355945AbiA3T1T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51842 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355959AbiA3T1B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:27:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 922A6B829B2
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C7DC340EB;
        Sun, 30 Jan 2022 19:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570818;
        bh=27VzIMRtqDX5BBrqXOHmYq6872M01fWtXnnHaFVPLOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P6CPAzd+8fUHbuWRT6miAhxS09aKr1X8dNlSv6RuuPBwbdinDqLwzsWfOTJFxzm95
         vg1zSiPZv4tuiP0n42sliLuUC04ac6FzHpzen+ARS3vmeE9zIZNoXZsmw7DykKCAIA
         vKu4wkcKu/YnbmcZsvozgohp0uvWhygKPgzZs0PfNj6Ti6BFwVuKoHOgt8nov/xaKR
         ClPJ3vwXSkObmLrVdNruD9AekGyaUSzKzoAgBtJOsR7EJ5JiVfTnErpzhSF05PjvBw
         uRaIs+xaNrOCOiEgBxwKpcjEYBS66C5Ma/qldYREYQokcyukPvBVyS2pp2Uh0FzWKH
         1xyIBO8lig3Zg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 38/50] iio:accel:stk8312: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:35 +0000
Message-Id: <20220130193147.279148-39-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/stk8312.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index de0cdf8c1f94..a71dfff3ca4a 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -611,7 +611,6 @@ static int stk8312_remove(struct i2c_client *client)
 	return stk8312_set_mode(data, STK8312_MODE_STANDBY);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stk8312_suspend(struct device *dev)
 {
 	struct stk8312_data *data;
@@ -630,12 +629,8 @@ static int stk8312_resume(struct device *dev)
 	return stk8312_set_mode(data, data->mode | STK8312_MODE_ACTIVE);
 }
 
-static SIMPLE_DEV_PM_OPS(stk8312_pm_ops, stk8312_suspend, stk8312_resume);
-
-#define STK8312_PM_OPS (&stk8312_pm_ops)
-#else
-#define STK8312_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(stk8312_pm_ops, stk8312_suspend,
+				stk8312_resume);
 
 static const struct i2c_device_id stk8312_i2c_id[] = {
 	/* Deprecated in favour of lowercase form */
@@ -648,7 +643,7 @@ MODULE_DEVICE_TABLE(i2c, stk8312_i2c_id);
 static struct i2c_driver stk8312_driver = {
 	.driver = {
 		.name = STK8312_DRIVER_NAME,
-		.pm = STK8312_PM_OPS,
+		.pm = pm_sleep_ptr(&stk8312_pm_ops),
 	},
 	.probe =            stk8312_probe,
 	.remove =           stk8312_remove,
-- 
2.35.1


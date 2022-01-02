Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCAC482B3C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiABMwO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50822 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiABMwO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82474B80CFC
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982E1C36AEF;
        Sun,  2 Jan 2022 12:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127932;
        bh=OYXPc+gRbfWU+eZ65WIQfsD549fa2w+MG+zmau1eB4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vI8oxpPajPmwj+QoTS2WSreOt4hh5e++ETWkaVb30dP7ukXu1I8ItKOEbh9K1RKgW
         1xZ6fF3SeezjvzuaS+k4P035VEgBUUqf73Oa1wp+uU14y9T4GeflwkJ7zbPqHEOsRB
         O8Lm5t5sqqR/NdVs3MMo6IebaER9Erj6eJcQrt3Yoyc12LBmvjxH/A4+ToyBVZccWV
         481pz19gJYr4AJW/nWPT2zeuRiHoQgDXwkUGsYJtXjLcKW4b+iQWRjTtEWTzXGZKGA
         BVq312+1h1yad5OOV36qSmmTd0NjXhd69sg10hjrk8y8PwFzqfHhgYKYzMr6unR53l
         MxMj9eRPlLYwQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Icenowy Zheng <icenowy@aosc.io>, Luca Weiss <luca@z3ntu.xyz>,
        Martijn Braam <martijn@brixit.nl>
Subject: [PATCH v2 29/51] iio:light:stk3310: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:55 +0000
Message-Id: <20220102125617.1259804-30-jic23@kernel.org>
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
Cc: Icenowy Zheng <icenowy@aosc.io>
Cc: Luca Weiss <luca@z3ntu.xyz>
Cc: Martijn Braam <martijn@brixit.nl>
---
 drivers/iio/light/stk3310.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index fc63856ed54d..36f8227ac800 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -632,7 +632,6 @@ static int stk3310_remove(struct i2c_client *client)
 	return stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stk3310_suspend(struct device *dev)
 {
 	struct stk3310_data *data;
@@ -656,12 +655,7 @@ static int stk3310_resume(struct device *dev)
 	return stk3310_set_state(data, state);
 }
 
-static SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend, stk3310_resume);
-
-#define STK3310_PM_OPS (&stk3310_pm_ops)
-#else
-#define STK3310_PM_OPS NULL
-#endif
+DEFINE_SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend, stk3310_resume);
 
 static const struct i2c_device_id stk3310_i2c_id[] = {
 	{"STK3310", 0},
@@ -692,7 +686,7 @@ static struct i2c_driver stk3310_driver = {
 	.driver = {
 		.name = "stk3310",
 		.of_match_table = stk3310_of_match,
-		.pm = STK3310_PM_OPS,
+		.pm = pm_sleep_ptr(&stk3310_pm_ops),
 		.acpi_match_table = ACPI_PTR(stk3310_acpi_id),
 	},
 	.probe =            stk3310_probe,
-- 
2.34.1


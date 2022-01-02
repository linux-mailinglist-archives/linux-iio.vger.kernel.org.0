Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF30C482B4D
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiABMxC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMxB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:53:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D94C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:53:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2817F60DB7
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725E1C36AE7;
        Sun,  2 Jan 2022 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127980;
        bh=bnWvFctZXx/SWLo2yWO3MfCmGW7XgjkIULl4o+2FpkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRNe9036YOpBXnuEBWihDoARwLW0CO72qa43ERmC862btZbHkbUFj5FWXIVDP3tm9
         hVGdUawgY0yGtDFv5Thv7vlwvwukCJ5wKBrDVxeTTnFsa2tCLY8Zj0KSWJqPZq76l/
         mduEBwSREjAH3Pf++erjthTpnKtUmsDijz8aBbqUti4HTvI4YNnVJBMSB+becR5xQS
         o63GnYsTk5qGawS/jJcGoG+76R/Q6LQg2KTzGsWYDhsguYRE8wrA9YBHg6LS5n0NQJ
         PHP6k8O/1Ofv2Zn/wsfrO2b59kfvaK7E1jHTczlBILja1zdB6ZRJVWKnRxUpxKJqHh
         hkKLyDvp0bSUA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 46/51] iio:accel:stk8312: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:12 +0000
Message-Id: <20220102125617.1259804-47-jic23@kernel.org>
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
 drivers/iio/accel/stk8312.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index de0cdf8c1f94..48d9090862e0 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -611,7 +611,6 @@ static int stk8312_remove(struct i2c_client *client)
 	return stk8312_set_mode(data, STK8312_MODE_STANDBY);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stk8312_suspend(struct device *dev)
 {
 	struct stk8312_data *data;
@@ -630,12 +629,7 @@ static int stk8312_resume(struct device *dev)
 	return stk8312_set_mode(data, data->mode | STK8312_MODE_ACTIVE);
 }
 
-static SIMPLE_DEV_PM_OPS(stk8312_pm_ops, stk8312_suspend, stk8312_resume);
-
-#define STK8312_PM_OPS (&stk8312_pm_ops)
-#else
-#define STK8312_PM_OPS NULL
-#endif
+DEFINE_SIMPLE_DEV_PM_OPS(stk8312_pm_ops, stk8312_suspend, stk8312_resume);
 
 static const struct i2c_device_id stk8312_i2c_id[] = {
 	/* Deprecated in favour of lowercase form */
@@ -648,7 +642,7 @@ MODULE_DEVICE_TABLE(i2c, stk8312_i2c_id);
 static struct i2c_driver stk8312_driver = {
 	.driver = {
 		.name = STK8312_DRIVER_NAME,
-		.pm = STK8312_PM_OPS,
+		.pm = pm_sleep_ptr(&stk8312_pm_ops),
 	},
 	.probe =            stk8312_probe,
 	.remove =           stk8312_remove,
-- 
2.34.1


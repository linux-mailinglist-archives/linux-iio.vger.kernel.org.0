Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEDA45ADF6
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbhKWVJy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239320AbhKWVJx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CF3360FE6;
        Tue, 23 Nov 2021 21:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701605;
        bh=uZeKK14C/d9jNKkJ30OHM7Xw7jyH54xEnkRwSmjuHLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pNZIW4Sgt+RS0Vv07mws1XlSGQbAPaIzxXe7nWHGmqoJer8zDn+KIZRF2JEqYPR5Q
         S95gabwHBQb2TszxpeBwbs0GY246BPa7t9FrZ0zUfvw9K6S3Ppqjqw7B5QglXYzR85
         dy02EFQvr6rIXbS56E+7506pXMpGhlv5F91ulrSgyQ8/8MmvlotnHLDUKWpNbHe4Bf
         v0p7HMFWKVJA4oVxHEnJ3YWEZIloSV1h62Bgr/Tn9YJ87qYLJNMwN350aaAAfQXItP
         yFBIUmj4E99cdFyDn6gqnocwhh8PYVKGMqcmVT7B+cYxFyv0OfshE82GJxhYx/HxFB
         3xEQwNyCyjwRQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 28/49] iio:light:jsa1212: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:58 +0000
Message-Id: <20211123211019.2271440-29-jic23@kernel.org>
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
 drivers/iio/light/jsa1212.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
index 724a0ec9f35c..218b61595436 100644
--- a/drivers/iio/light/jsa1212.c
+++ b/drivers/iio/light/jsa1212.c
@@ -383,8 +383,7 @@ static int jsa1212_remove(struct i2c_client *client)
 	return jsa1212_power_off(data);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int jsa1212_suspend(struct device *dev)
+static __maybe_unused int jsa1212_suspend(struct device *dev)
 {
 	struct jsa1212_data *data;
 
@@ -393,7 +392,7 @@ static int jsa1212_suspend(struct device *dev)
 	return jsa1212_power_off(data);
 }
 
-static int jsa1212_resume(struct device *dev)
+static __maybe_unused int jsa1212_resume(struct device *dev)
 {
 	int ret = 0;
 	struct jsa1212_data *data;
@@ -423,11 +422,6 @@ static int jsa1212_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(jsa1212_pm_ops, jsa1212_suspend, jsa1212_resume);
 
-#define JSA1212_PM_OPS (&jsa1212_pm_ops)
-#else
-#define JSA1212_PM_OPS NULL
-#endif
-
 static const struct acpi_device_id jsa1212_acpi_match[] = {
 	{"JSA1212", 0},
 	{ },
@@ -443,7 +437,7 @@ MODULE_DEVICE_TABLE(i2c, jsa1212_id);
 static struct i2c_driver jsa1212_driver = {
 	.driver = {
 		.name	= JSA1212_DRIVER_NAME,
-		.pm	= JSA1212_PM_OPS,
+		.pm	= pm_ptr(&jsa1212_pm_ops),
 		.acpi_match_table = ACPI_PTR(jsa1212_acpi_match),
 	},
 	.probe		= jsa1212_probe,
-- 
2.34.0


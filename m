Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1866B4A3897
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355922AbiA3T00 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36128 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355927AbiA3T0W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6BC8612E3
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEEAC340EB;
        Sun, 30 Jan 2022 19:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570781;
        bh=5uZX+UsXZmfnr1qKL9UlL0XW9SZiYM8jPvMyZBvvvXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqaGhDOV1KRq9fHG1aNbtyAbDo4IY3LQjnyObZnXlAQRPnyChsEKpNrYEbxxM77lP
         3CusITx/B24pd5v8/38z/nEk758s0eVo9GAdS0g6Yo1q2gikVNZjqgAaPrQ2u3fU4l
         YtPmno/AL97/PrRegGsgr/eYAs/uucLVjpzDqNtlIxDAM1fZHk6UFZe9pcQzyjoPsb
         PDQ/4KzsNcIm+UGTsPFKThY9PMfgy1AZvNw1AxNJDL7ypDw07A0MzTsrB7RdI1ugW9
         ieE/tsJREuJFcK9zMIeJOPcUugMtdLQmZ7BVcR93Sll/UsTytEVgcgdcO9Ew62L6Yo
         KPWqGXy032Lew==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 22/50] iio:light:jsa1212: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:19 +0000
Message-Id: <20220130193147.279148-23-jic23@kernel.org>
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
 drivers/iio/light/jsa1212.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
index 724a0ec9f35c..a55194263d23 100644
--- a/drivers/iio/light/jsa1212.c
+++ b/drivers/iio/light/jsa1212.c
@@ -383,7 +383,6 @@ static int jsa1212_remove(struct i2c_client *client)
 	return jsa1212_power_off(data);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int jsa1212_suspend(struct device *dev)
 {
 	struct jsa1212_data *data;
@@ -421,12 +420,8 @@ static int jsa1212_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(jsa1212_pm_ops, jsa1212_suspend, jsa1212_resume);
-
-#define JSA1212_PM_OPS (&jsa1212_pm_ops)
-#else
-#define JSA1212_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(jsa1212_pm_ops, jsa1212_suspend,
+				jsa1212_resume);
 
 static const struct acpi_device_id jsa1212_acpi_match[] = {
 	{"JSA1212", 0},
@@ -443,7 +438,7 @@ MODULE_DEVICE_TABLE(i2c, jsa1212_id);
 static struct i2c_driver jsa1212_driver = {
 	.driver = {
 		.name	= JSA1212_DRIVER_NAME,
-		.pm	= JSA1212_PM_OPS,
+		.pm	= pm_sleep_ptr(&jsa1212_pm_ops),
 		.acpi_match_table = ACPI_PTR(jsa1212_acpi_match),
 	},
 	.probe		= jsa1212_probe,
-- 
2.35.1


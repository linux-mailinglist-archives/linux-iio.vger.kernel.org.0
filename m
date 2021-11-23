Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559E645ADE0
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhKWVJS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234379AbhKWVJQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D940060FE3;
        Tue, 23 Nov 2021 21:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701568;
        bh=pF36MvC4kT2tIIwg6PxC4mZfFP7pT8Uy4mU6tq2moEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NvSg3xVq7WkZrVkS9s9L+mFbrDLDHvChqLc36VUR3o7s9fSC8y83penxZHIgY5pxV
         BVydFq+wUbzIDcOfQTwQfe+b2Xv9QJzYwh6HIEGJKSPu7bmohszRJlYKhLBgkwD/pL
         dXsOruJhEd3RifEWFsppgAb2ePa+woIIRbddKXbLPnj8pyVamAUkn9SCfQp18oG7VV
         6r9VyaryhAAex1ffDzGpoxpM2L0nIEg0WgpabBnP67voQJ2NxjaYQ1gLb1F+CdkYH9
         BBM2t6woNGEFmhah6+g2tYlEhaIWpgeeVk7vn/9nfEnP3AWM7X8kb03StDFcCUfRyr
         0MPFfL58SNfMA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/49] iio:accel:stk8ba50: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:39 +0000
Message-Id: <20211123211019.2271440-10-jic23@kernel.org>
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
 drivers/iio/accel/stk8ba50.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 517c57ed9e94..88506a5e9402 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -504,8 +504,7 @@ static int stk8ba50_remove(struct i2c_client *client)
 	return stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int stk8ba50_suspend(struct device *dev)
+static __maybe_unused int stk8ba50_suspend(struct device *dev)
 {
 	struct stk8ba50_data *data;
 
@@ -514,7 +513,7 @@ static int stk8ba50_suspend(struct device *dev)
 	return stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
 }
 
-static int stk8ba50_resume(struct device *dev)
+static __maybe_unused int stk8ba50_resume(struct device *dev)
 {
 	struct stk8ba50_data *data;
 
@@ -525,11 +524,6 @@ static int stk8ba50_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(stk8ba50_pm_ops, stk8ba50_suspend, stk8ba50_resume);
 
-#define STK8BA50_PM_OPS (&stk8ba50_pm_ops)
-#else
-#define STK8BA50_PM_OPS NULL
-#endif
-
 static const struct i2c_device_id stk8ba50_i2c_id[] = {
 	{"stk8ba50", 0},
 	{}
@@ -546,7 +540,7 @@ MODULE_DEVICE_TABLE(acpi, stk8ba50_acpi_id);
 static struct i2c_driver stk8ba50_driver = {
 	.driver = {
 		.name = "stk8ba50",
-		.pm = STK8BA50_PM_OPS,
+		.pm = pm_ptr(&stk8ba50_pm_ops),
 		.acpi_match_table = ACPI_PTR(stk8ba50_acpi_id),
 	},
 	.probe =            stk8ba50_probe,
-- 
2.34.0


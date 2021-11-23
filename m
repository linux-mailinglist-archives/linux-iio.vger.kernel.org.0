Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8829B45ADDD
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhKWVJO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234849AbhKWVJN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB08F60FE8;
        Tue, 23 Nov 2021 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701562;
        bh=zjTDKYtu7+xOmlLzT29F3c1xP32583MjmftScP85638=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clc+6V/eR5Je7ci/0bD1TgQ964w/cA7TXaVUSUaCmQbrEF5kGBeK5eO2RDS7IG5cv
         aOUsmvl5sC+uN0N3GLyyJqjvdvuPZOygh8H6NcR7SJ2wL45OoUhf0Jmuj0rZdKS5K2
         HdjD9kjwLPflMKAuCPRrIPt9WUllh5qal3M7f63w4OnivHjXx0L5JyaUmn3VZo5bES
         RqhN3XWqz3rboULcdVFr1b/YzLVgHawjEUemjwkUZbFSKzOKoMASFOQ8oSPXCSPtbh
         UkSRypTt9UBi2CK0rA0BcP/MDqLlmsu84SXP0uAKNDImVyM+YGipd/boi32kLQ0H8o
         kaMXm7NV56ixw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 06/49] iio:accel:mma7660: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:36 +0000
Message-Id: <20211123211019.2271440-7-jic23@kernel.org>
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
 drivers/iio/accel/mma7660.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 24b83ccdb950..e90463b88b91 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -222,8 +222,7 @@ static int mma7660_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mma7660_suspend(struct device *dev)
+static __maybe_unused int mma7660_suspend(struct device *dev)
 {
 	struct mma7660_data *data;
 
@@ -232,7 +231,7 @@ static int mma7660_suspend(struct device *dev)
 	return mma7660_set_mode(data, MMA7660_MODE_STANDBY);
 }
 
-static int mma7660_resume(struct device *dev)
+static __maybe_unused int mma7660_resume(struct device *dev)
 {
 	struct mma7660_data *data;
 
@@ -243,11 +242,6 @@ static int mma7660_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(mma7660_pm_ops, mma7660_suspend, mma7660_resume);
 
-#define MMA7660_PM_OPS (&mma7660_pm_ops)
-#else
-#define MMA7660_PM_OPS NULL
-#endif
-
 static const struct i2c_device_id mma7660_i2c_id[] = {
 	{"mma7660", 0},
 	{}
@@ -270,7 +264,7 @@ MODULE_DEVICE_TABLE(acpi, mma7660_acpi_id);
 static struct i2c_driver mma7660_driver = {
 	.driver = {
 		.name = "mma7660",
-		.pm = MMA7660_PM_OPS,
+		.pm = pm_ptr(&mma7660_pm_ops),
 		.of_match_table = mma7660_of_match,
 		.acpi_match_table = ACPI_PTR(mma7660_acpi_id),
 	},
-- 
2.34.0


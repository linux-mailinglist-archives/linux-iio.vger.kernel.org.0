Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1CC482B29
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiABMvV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiABMvV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82C0C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:51:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4829B80D61
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE869C36AEE;
        Sun,  2 Jan 2022 12:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127878;
        bh=t2ujGpt3T2sdyU2QyGPTc3eLz7u4hEGwzQs1uTbmnv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9kZ1SKEZ97DrOuuitU3OUk1DrzvrnlFr9aAsSZ0mkOlCT531IgMVL09lnSguOC/J
         RdtvPOPdespLc+SmyawRII0/Mi/PbDnEMVIvRexpKbwbUMUe5TrsW/6xN4jf6xfi3G
         MRzG2VR4oX7GkYpqs+DoH5rmFPCQc3eHy7jvjDg1HHrJQOCO7/MTjDyApAqELfovMg
         dNsgD2UXYE2lWz+lVFBvPd+GJMhbxbwQ8HWSxdlHEp43dc2xBwT0FtyANMTAVSXlOq
         xUBxpOo9ERtZZDHAGlAj6dOr+jtizAccqUKlG5K/WQpzAKCeJMrqX9dahgiK12gLD2
         F9HGZPIC+Z4xw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 10/51] iio:accel:kxsd9: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:36 +0000
Message-Id: <20220102125617.1259804-11-jic23@kernel.org>
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
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/kxsd9-i2c.c | 2 +-
 drivers/iio/accel/kxsd9-spi.c | 2 +-
 drivers/iio/accel/kxsd9.c     | 8 ++------
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index 274b41a6e603..ffe8066b4025 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -55,7 +55,7 @@ static struct i2c_driver kxsd9_i2c_driver = {
 	.driver = {
 		.name	= "kxsd9",
 		.of_match_table = kxsd9_of_match,
-		.pm = &kxsd9_dev_pm_ops,
+		.pm = pm_ptr(&kxsd9_dev_pm_ops),
 	},
 	.probe		= kxsd9_i2c_probe,
 	.remove		= kxsd9_i2c_remove,
diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index 441e6b764281..44edf39fc5ff 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -54,7 +54,7 @@ MODULE_DEVICE_TABLE(of, kxsd9_of_match);
 static struct spi_driver kxsd9_spi_driver = {
 	.driver = {
 		.name = "kxsd9",
-		.pm = &kxsd9_dev_pm_ops,
+		.pm = pm_ptr(&kxsd9_dev_pm_ops),
 		.of_match_table = kxsd9_of_match,
 	},
 	.probe = kxsd9_spi_probe,
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 552eba5e8b4f..39059ddca441 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -492,7 +492,6 @@ void kxsd9_common_remove(struct device *dev)
 }
 EXPORT_SYMBOL(kxsd9_common_remove);
 
-#ifdef CONFIG_PM
 static int kxsd9_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -508,13 +507,10 @@ static int kxsd9_runtime_resume(struct device *dev)
 
 	return kxsd9_power_up(st);
 }
-#endif /* CONFIG_PM */
 
 const struct dev_pm_ops kxsd9_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(kxsd9_runtime_suspend,
-			   kxsd9_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(kxsd9_runtime_suspend, kxsd9_runtime_resume, NULL)
 };
 EXPORT_SYMBOL(kxsd9_dev_pm_ops);
 
-- 
2.34.1


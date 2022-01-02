Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0413E482B41
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiABMw1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42642 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiABMw0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8361360DB7
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7263C36AEE;
        Sun,  2 Jan 2022 12:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127946;
        bh=L8aHmyGD1HHVsREoZBI8NyJXu2QqgRt8FB6TZa5fteg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A84b+pYQenP0fedj/DSd7wvtfaGmrm4XbRg7FjC7EI5fmwwMfkGD2aIoXhVKuhzWL
         buHOEWd6VVqD82BSrkagnCW8pZh3awJ79kn9qlFGqJ861ZMzpcmuEmawSsGtzSajnu
         K2BhN7M3gaIwzFm6QTcCFq55azuW7jU7MUCmqk1oBjdFseRlMDlxpKSVvtGMYGeoif
         V3d7y3LdCoBZtoZwGvPCkwWtgUqx9q5SFIbJF1+giqz+Lk4YQpS2uylwlHsNoovmNt
         hDpJnpewwLM1Ujozdp/cAZZsIHbWWEvhcbW7Sx1oi9FmE1JLBVxt004LpAi6BGSrsA
         NsW5kxsI3+bmA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 34/51] iio:light:us5182: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:00 +0000
Message-Id: <20220102125617.1259804-35-jic23@kernel.org>
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
 drivers/iio/light/us5182d.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 96e4a66ddf28..fdabf601d15e 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -916,7 +916,6 @@ static int us5182d_remove(struct i2c_client *client)
 	return us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
 }
 
-#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM)
 static int us5182d_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -939,11 +938,10 @@ static int us5182d_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops us5182d_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(us5182d_suspend, us5182d_resume)
-	SET_RUNTIME_PM_OPS(us5182d_suspend, us5182d_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(us5182d_suspend, us5182d_resume)
+	RUNTIME_PM_OPS(us5182d_suspend, us5182d_resume, NULL)
 };
 
 static const struct acpi_device_id us5182d_acpi_match[] = {
@@ -969,7 +967,7 @@ MODULE_DEVICE_TABLE(of, us5182d_of_match);
 static struct i2c_driver us5182d_driver = {
 	.driver = {
 		.name = US5182D_DRV_NAME,
-		.pm = &us5182d_pm_ops,
+		.pm = pm_ptr(&us5182d_pm_ops),
 		.of_match_table = us5182d_of_match,
 		.acpi_match_table = ACPI_PTR(us5182d_acpi_match),
 	},
-- 
2.34.1


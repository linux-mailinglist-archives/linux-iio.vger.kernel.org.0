Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C19482B28
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiABMvR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiABMvR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE21C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:51:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C037960E9A
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36422C36AEF;
        Sun,  2 Jan 2022 12:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127876;
        bh=92xmStm+o1tIGFa1+nE5CbFAFHHHqxb+4qlu8mFBtaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bd9hQfI5qP+aB0F3yO1YPemAQp+gpiQDKcpTFS9S+4B6Pud38WrDVhYdeZmu4n9r/
         5m0WCGFjTbcDO5NSqVzzgQgCINeATj+/eslBdcAlAwMENArFXWrpzvEM2LliNlcm2l
         LzQpKLwuAvP/kY+G6nG1j49qVo5ot3nnmL7roQrWdtkYcSqJVbm5EP58itmsVx1Be9
         rOa0/1BZ/uqZCVzFjTCSIIAlHfJz0QvboDu3vMZK5TsyFbVY6ZjSftwcpCHF8dbS5g
         tQVwgZByuGwkg7yS8AkdMj4f1im0E02649WWvPyQST8lenC6xhj7H5ZHZEre8dJj73
         ZIAYjYacl4Lgg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 09/51] iio:accel:stk8ba50: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:35 +0000
Message-Id: <20220102125617.1259804-10-jic23@kernel.org>
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
 drivers/iio/accel/stk8ba50.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 517c57ed9e94..0c86cefbe2e2 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -504,7 +504,6 @@ static int stk8ba50_remove(struct i2c_client *client)
 	return stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stk8ba50_suspend(struct device *dev)
 {
 	struct stk8ba50_data *data;
@@ -523,12 +522,7 @@ static int stk8ba50_resume(struct device *dev)
 	return stk8ba50_set_power(data, STK8BA50_MODE_NORMAL);
 }
 
-static SIMPLE_DEV_PM_OPS(stk8ba50_pm_ops, stk8ba50_suspend, stk8ba50_resume);
-
-#define STK8BA50_PM_OPS (&stk8ba50_pm_ops)
-#else
-#define STK8BA50_PM_OPS NULL
-#endif
+DEFINE_SIMPLE_DEV_PM_OPS(stk8ba50_pm_ops, stk8ba50_suspend, stk8ba50_resume);
 
 static const struct i2c_device_id stk8ba50_i2c_id[] = {
 	{"stk8ba50", 0},
@@ -546,7 +540,7 @@ MODULE_DEVICE_TABLE(acpi, stk8ba50_acpi_id);
 static struct i2c_driver stk8ba50_driver = {
 	.driver = {
 		.name = "stk8ba50",
-		.pm = STK8BA50_PM_OPS,
+		.pm = pm_sleep_ptr(&stk8ba50_pm_ops),
 		.acpi_match_table = ACPI_PTR(stk8ba50_acpi_id),
 	},
 	.probe =            stk8ba50_probe,
-- 
2.34.1


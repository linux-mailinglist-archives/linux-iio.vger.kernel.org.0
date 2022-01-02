Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EF5482B4E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiABMxE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:53:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43092 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMxD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:53:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93C4460E9A
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF8AC36AEF;
        Sun,  2 Jan 2022 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127983;
        bh=EBKsbqi/xnSuX+xKn8qJJDhcpjMG4aDqCZs4UXVnHMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UpqAvqrFmR2As39WAiOp1I27iVFlBK321tqT0zGSGg8Dg29ecnN0brA/BAdLcjqTf
         aNPVWsxAk+6aeNl23Vn75pFuIR/Rp9eC2Lv3aIsuGgHVVNK2wR8pScfgL7SHNT6y0m
         PglhSXKX2QIBrhIfGkvuBrgxozJoZRWR97sqpweA6+C8t8MYHgv11tcvxTiszrbW02
         wG7j23qdmohf8lUH0Wl58GLxGj9y6v94+aujXRdtmPUSg2NbqFG9zQGSKqOR6VHC1f
         JmTr3h3L3Y3pPvAW1GQKchhYSMjGdfZBrdYzpI8TjOLT+Dw0qES8+/NEK6Kgd3zzzC
         4iZTHw4qdZ0rg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 47/51] iio:accel:bma180: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:13 +0000
Message-Id: <20220102125617.1259804-48-jic23@kernel.org>
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
 drivers/iio/accel/bma180.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index d8a454c266d5..4d99c61bec82 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -1065,7 +1065,6 @@ static int bma180_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int bma180_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1092,11 +1091,7 @@ static int bma180_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
-#define BMA180_PM_OPS (&bma180_pm_ops)
-#else
-#define BMA180_PM_OPS NULL
-#endif
+DEFINE_SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
 
 static const struct i2c_device_id bma180_ids[] = {
 	{ "bma023", BMA023 },
@@ -1137,7 +1132,7 @@ MODULE_DEVICE_TABLE(of, bma180_of_match);
 static struct i2c_driver bma180_driver = {
 	.driver = {
 		.name	= "bma180",
-		.pm	= BMA180_PM_OPS,
+		.pm	= pm_sleep_ptr(&bma180_pm_ops),
 		.of_match_table = bma180_of_match,
 	},
 	.probe		= bma180_probe,
-- 
2.34.1


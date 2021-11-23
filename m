Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D511345ADF7
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbhKWVJ4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239459AbhKWVJ4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3DBD60FC1;
        Tue, 23 Nov 2021 21:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701607;
        bh=UYxuwQkI3/Lxj+mbASO4rnuQcbu8D+8LTICp4HksXT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=No4vWbxssgfeSgU7Vc3W3uVN/2yr0W+D4E4moG2LLcfIK92L6y8baR56G7fa55mBq
         4Ndo2N6Ua4L9Xe8GXG8qdS6rWXVlSjbLyuYPZY0PUksHn2cHdTsFFOQGg16x//bYhy
         sXAejhPojUny3QJYnZVx5FDh1qeGMAizpqlIGycyQd6R2Wv01BKU9JNnTN2ZPOEV5L
         nlq5GqXt5FBsyDJu4XZB6W5yk88gYE5Pa2PuyYjZ3pL7FbuQ2TDRow5OF56Zf2FlYU
         PwbvjDi6cigWmS9YnoDHAJZsXgv8c0ynK00lRKBRI4GdPWt2ccDV1Kh1B9Rv1OvWlS
         GdM071vXMKODw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maslov Dmitry <maslovdmitry@seeed.cc>
Subject: [PATCH 29/49] iio:light:ltr501: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:59 +0000
Message-Id: <20211123211019.2271440-30-jic23@kernel.org>
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
Cc: Maslov Dmitry <maslovdmitry@seeed.cc>
---
 drivers/iio/light/ltr501.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index bab5b78f2e30..f64135a4bd0c 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1586,15 +1586,14 @@ static int ltr501_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ltr501_suspend(struct device *dev)
+static __maybe_unused int ltr501_suspend(struct device *dev)
 {
 	struct ltr501_data *data = iio_priv(i2c_get_clientdata(
 					    to_i2c_client(dev)));
 	return ltr501_powerdown(data);
 }
 
-static int ltr501_resume(struct device *dev)
+static __maybe_unused int ltr501_resume(struct device *dev)
 {
 	struct ltr501_data *data = iio_priv(i2c_get_clientdata(
 					    to_i2c_client(dev)));
@@ -1602,7 +1601,6 @@ static int ltr501_resume(struct device *dev)
 	return ltr501_write_contr(data, data->als_contr,
 		data->ps_contr);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
@@ -1636,7 +1634,7 @@ static struct i2c_driver ltr501_driver = {
 	.driver = {
 		.name   = LTR501_DRV_NAME,
 		.of_match_table = ltr501_of_match,
-		.pm	= &ltr501_pm_ops,
+		.pm	= pm_ptr(&ltr501_pm_ops),
 		.acpi_match_table = ACPI_PTR(ltr_acpi_match),
 	},
 	.probe  = ltr501_probe,
-- 
2.34.0


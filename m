Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A9F482B34
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiABMvw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiABMvw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E254CC061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:51:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3651B80D62
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629DCC36AEF;
        Sun,  2 Jan 2022 12:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127909;
        bh=WspfA/RlQHDLMQ5QvroT9uNUHmG7w9deaaKaBafsW5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G89BErdvmL8qgjhF91qgJsoAlZx23BWxnPAa9xSPd6+6d64yruNBuvhmj2gF6pw0n
         nWNopgHKK1A6fvzVxpZXKIIl8Lnc6YV+6EWQa/SBhg58y0oEWixRFB/MZNho2Bkr3W
         vBaZjL3o7j8Gsby/4Kdc74RnARaGtSzistJKE4Xmp+Pq1gSrWv34FMipBpKHycgVhw
         SGaV7F/qowfv0T9pTYBjkti1t5dx3bWyYAAFSzLmM9+uu8NtQuCK7g0MG4LB9LcDAJ
         VGJLDz9RScyLAZPAAE8jNMVRbe03blQLGn4QhZ1TPKoH5wSXyH+hwzngnleqLeddC5
         DvxOu/1YrzkMA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 21/51] iio:dac:vf610: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:47 +0000
Message-Id: <20220102125617.1259804-22-jic23@kernel.org>
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
 drivers/iio/dac/vf610_dac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index 636b4009f763..8f937d1b3c56 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -242,7 +242,6 @@ static int vf610_dac_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int vf610_dac_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -268,9 +267,8 @@ static int vf610_dac_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(vf610_dac_pm_ops, vf610_dac_suspend, vf610_dac_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(vf610_dac_pm_ops, vf610_dac_suspend, vf610_dac_resume);
 
 static struct platform_driver vf610_dac_driver = {
 	.probe          = vf610_dac_probe,
@@ -278,7 +276,7 @@ static struct platform_driver vf610_dac_driver = {
 	.driver         = {
 		.name   = "vf610-dac",
 		.of_match_table = vf610_dac_match,
-		.pm     = &vf610_dac_pm_ops,
+		.pm     = pm_sleep_ptr(&vf610_dac_pm_ops),
 	},
 };
 module_platform_driver(vf610_dac_driver);
-- 
2.34.1


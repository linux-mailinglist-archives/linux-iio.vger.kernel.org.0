Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A484A389C
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355925AbiA3T0k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51706 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355926AbiA3T0g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95AACB829A0
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FBDC340F1;
        Sun, 30 Jan 2022 19:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570794;
        bh=NLx4fvotkaWJRnnxuPczz5wZdCuFFZRPQYnMdj44wEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npNGpycb4sjq81iKgFNaAkrGDr6qVTmTDpH2/N4KtX8WlF7L8dJ/+AVS0NumH271x
         JUP5FbJhmQS/EvIKTzDSwtLRdS8axPUHuES3JiYv/J+0Lyu/bbUfRlp825tyAUgEQb
         bs7uPSKBXdQ67BDo5DU2DNK30VoJQ/xETpdAc1/IMrE7Ttic+HedDNd+Aj+0yALZwD
         3+77CaDDrQBvjFnxCTZBMcvWUFqGwaKcGB7glRTb1LWhUpyZeYtY4vogcdPrgvTRwI
         HzMVChYvQHwdXALXi5gNfG3zB+e5i8yGCiP3EvaGTEQBFc+ktG8uJEADAtiXQVpAFr
         f+y+DNjGDQf1A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 28/50] iio:light:tsl4531: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:25 +0000
Message-Id: <20220130193147.279148-29-jic23@kernel.org>
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
 drivers/iio/light/tsl4531.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
index 70505ba6d858..6ae1b27e50b6 100644
--- a/drivers/iio/light/tsl4531.c
+++ b/drivers/iio/light/tsl4531.c
@@ -215,7 +215,6 @@ static int tsl4531_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tsl4531_suspend(struct device *dev)
 {
 	return tsl4531_powerdown(to_i2c_client(dev));
@@ -227,11 +226,8 @@ static int tsl4531_resume(struct device *dev)
 		TSL4531_MODE_NORMAL);
 }
 
-static SIMPLE_DEV_PM_OPS(tsl4531_pm_ops, tsl4531_suspend, tsl4531_resume);
-#define TSL4531_PM_OPS (&tsl4531_pm_ops)
-#else
-#define TSL4531_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(tsl4531_pm_ops, tsl4531_suspend,
+				tsl4531_resume);
 
 static const struct i2c_device_id tsl4531_id[] = {
 	{ "tsl4531", 0 },
@@ -242,7 +238,7 @@ MODULE_DEVICE_TABLE(i2c, tsl4531_id);
 static struct i2c_driver tsl4531_driver = {
 	.driver = {
 		.name   = TSL4531_DRV_NAME,
-		.pm	= TSL4531_PM_OPS,
+		.pm	= pm_sleep_ptr(&tsl4531_pm_ops),
 	},
 	.probe  = tsl4531_probe,
 	.remove = tsl4531_remove,
-- 
2.35.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C964A38A9
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355949AbiA3T1Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355942AbiA3T1G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:27:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7C3C061741
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:27:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B072E612BD
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3BAC340EB;
        Sun, 30 Jan 2022 19:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570825;
        bh=GpdeolEp5zO3pXt24sEBL8tMcS13ZpqLXyPt0BHefFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLfoxn5PeOML6tR5vvS8Sx5jCJWNWSTV+wjbwvev8cDgDyEUkV2JBI2U/3TyqdGAm
         fM1jRc76Jo/7VJAK7QwzZRpm2Wmxan2hQllSGUny69G6W1OnyXLcnwHWb2Xm63x0aT
         bN/Xcm2bG+oTV3B/5emRdcWkKhQKz2oi+mxExGVDlf+kvsWOnW8rjVxyXv/8qZ5+aL
         CpT4VArDqMc9WmlO3Rlt7y+nMnjK4sOBz3kCSkQVJpWtL1FuwrmFgJdLhmNG16pLp5
         YMTHElO6HtXr3bQ7H2+LFsV/RnmbZiT75mzljWdGF0Vx6FjIvWnP8qw5OurPMuxDqc
         3++DMS0YeFK/Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 41/50] iio:imu:kmx61: Switch from CONFIG_PM* guards to pm_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:38 +0000
Message-Id: <20220130193147.279148-42-jic23@kernel.org>
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
without one or  more of CONFIG_PM/CONFIG_PM_SLEEP support is simpler and
less error prone than the use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/kmx61.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 1dabfd615dab..20ac1b4c8923 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1440,7 +1440,6 @@ static int kmx61_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int kmx61_suspend(struct device *dev)
 {
 	int ret;
@@ -1466,9 +1465,7 @@ static int kmx61_resume(struct device *dev)
 
 	return kmx61_set_mode(data, stby, KMX61_ACC | KMX61_MAG, true);
 }
-#endif
 
-#ifdef CONFIG_PM
 static int kmx61_runtime_suspend(struct device *dev)
 {
 	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));
@@ -1493,11 +1490,10 @@ static int kmx61_runtime_resume(struct device *dev)
 
 	return kmx61_set_mode(data, stby, KMX61_ACC | KMX61_MAG, true);
 }
-#endif
 
 static const struct dev_pm_ops kmx61_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(kmx61_suspend, kmx61_resume)
-	SET_RUNTIME_PM_OPS(kmx61_runtime_suspend, kmx61_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(kmx61_suspend, kmx61_resume)
+	RUNTIME_PM_OPS(kmx61_runtime_suspend, kmx61_runtime_resume, NULL)
 };
 
 static const struct acpi_device_id kmx61_acpi_match[] = {
@@ -1518,7 +1514,7 @@ static struct i2c_driver kmx61_driver = {
 	.driver = {
 		.name = KMX61_DRV_NAME,
 		.acpi_match_table = ACPI_PTR(kmx61_acpi_match),
-		.pm = &kmx61_pm_ops,
+		.pm = pm_ptr(&kmx61_pm_ops),
 	},
 	.probe		= kmx61_probe,
 	.remove		= kmx61_remove,
-- 
2.35.1


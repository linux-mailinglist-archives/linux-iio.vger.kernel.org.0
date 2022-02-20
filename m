Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456F14BD076
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 18:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiBTRp3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 12:45:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiBTRp3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 12:45:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEFE4C43A
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 09:45:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A97D660E8F
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 17:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0CBC340E8;
        Sun, 20 Feb 2022 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645379107;
        bh=0Wp4B5Wu8d5FljfumTcxNwSuo35Diwmq4YC69Zdcyqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWmD0JDruaOTLPanfekzp5wsNm9/DA7udeb4XoQNcmo8R1OVyfvZCUpDghR5gRddF
         Ej6lTD53qxfgns67rk8r4pZqldY08qjwrYlFJ42x9JT5M/pS6k0//5Bc0yruuWJe/F
         JUxN3leoebM2sFLuO8G3eBNCqgLJBibJa/MiAU46xx8ScZVkOikCpb4hVnrc+qRxuy
         K/7od0uB2gG9mEfuVPffaAWvjkRo3wqnld5pxna0jDqv5WnyX5wzbYMqDTpPmtPiTs
         xI65eQO99079Iif+CbZX132HpiOcbT2vTLqM2oPxrJKu0fI+Y+GQfZyZyiRihsOR8q
         k3KSK2lVWU4ew==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/2] iio: gyro: mpu3050: Use pm_ptr() and DEFINE_RUNTIME_DEV_PM_OPS()
Date:   Sun, 20 Feb 2022 17:51:49 +0000
Message-Id: <20220220175149.503495-3-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220175149.503495-1-jic23@kernel.org>
References: <20220220175149.503495-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Using this approach as opposed to CONFIG_PM guards allows the compiler to
remove the unused code instead of doing it manually.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/gyro/mpu3050-core.c | 11 ++---------
 drivers/iio/gyro/mpu3050-i2c.c  |  2 +-
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 8486261beb90..b3ecb5571057 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1279,7 +1279,6 @@ int mpu3050_common_remove(struct device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int mpu3050_runtime_suspend(struct device *dev)
 {
 	return mpu3050_power_down(iio_priv(dev_get_drvdata(dev)));
@@ -1289,15 +1288,9 @@ static int mpu3050_runtime_resume(struct device *dev)
 {
 	return mpu3050_power_up(iio_priv(dev_get_drvdata(dev)));
 }
-#endif /* CONFIG_PM */
-
-const struct dev_pm_ops mpu3050_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(mpu3050_runtime_suspend,
-			   mpu3050_runtime_resume, NULL)
-};
 
+DEFINE_RUNTIME_DEV_PM_OPS(mpu3050_dev_pm_ops, mpu3050_runtime_suspend,
+			  mpu3050_runtime_resume, NULL);
 MODULE_AUTHOR("Linus Walleij");
 MODULE_DESCRIPTION("MPU3050 gyroscope driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
index ef5bcbc4b45b..820133cad601 100644
--- a/drivers/iio/gyro/mpu3050-i2c.c
+++ b/drivers/iio/gyro/mpu3050-i2c.c
@@ -114,7 +114,7 @@ static struct i2c_driver mpu3050_i2c_driver = {
 	.driver = {
 		.of_match_table = mpu3050_i2c_of_match,
 		.name = "mpu3050-i2c",
-		.pm = &mpu3050_dev_pm_ops,
+		.pm = pm_ptr(&mpu3050_dev_pm_ops),
 	},
 };
 module_i2c_driver(mpu3050_i2c_driver);
-- 
2.35.1


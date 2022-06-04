Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A13453D799
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiFDQDi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbiFDQDh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:03:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1F9286DA
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 09:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE515B8069B
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 16:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335B6C36AE2;
        Sat,  4 Jun 2022 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654358613;
        bh=8P5cgBoQ0LFx+OobuC2cThdTEUmGj4AiNCg9VClTIl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X/YSEcXWiFM5oOKdqNbxXCyG3DBYxPTvmI8WrpWJblKs6hBZU8nEf/FcEP4OEjD/I
         H5gr71OtlphzSi4+GJ+lYASqZRozG1GkHzaAAuvF8KWNe5CRZcftvwMe26zm+jAj2k
         hlhgxYBUZYWJiCin+OzeOd0qOyFUQz2hwgGpyWLU3Gac7G6ZLupxxyI/cN9td+n3fi
         820+hcgO0lrZi59Jf8RmvYSyqws4D2DKtv2tR8GS/PT7JFThPgeWCoynhX2BJva0wm
         yXexD9qL/Rdi4pmiB5BN/uDmZ4atyMFZ0BJHicoQN3VHAW1YVLr6AkwZZl2Ys71WvG
         CF13ZVwdvy/Qw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RESEND PATCH 1/5] iio:accel:kxsd9: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sat,  4 Jun 2022 17:12:19 +0100
Message-Id: <20220604161223.461847-2-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220604161223.461847-1-jic23@kernel.org>
References: <20220604161223.461847-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Link: https://lore.kernel.org/r/20220220181522.541718-5-jic23@kernel.org
---
 drivers/iio/accel/kxsd9-i2c.c |  2 +-
 drivers/iio/accel/kxsd9-spi.c |  2 +-
 drivers/iio/accel/kxsd9.c     | 11 ++---------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index c8dc52f11037..d57f264bd6c8 100644
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
index b7b5af45429e..07f14a9f22c7 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -52,7 +52,7 @@ MODULE_DEVICE_TABLE(of, kxsd9_of_match);
 static struct spi_driver kxsd9_spi_driver = {
 	.driver = {
 		.name = "kxsd9",
-		.pm = &kxsd9_dev_pm_ops,
+		.pm = pm_ptr(&kxsd9_dev_pm_ops),
 		.of_match_table = kxsd9_of_match,
 	},
 	.probe = kxsd9_spi_probe,
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 3975860331a6..ba99649fe195 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -492,7 +492,6 @@ void kxsd9_common_remove(struct device *dev)
 }
 EXPORT_SYMBOL_NS(kxsd9_common_remove, IIO_KXSD9);
 
-#ifdef CONFIG_PM
 static int kxsd9_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -508,15 +507,9 @@ static int kxsd9_runtime_resume(struct device *dev)
 
 	return kxsd9_power_up(st);
 }
-#endif /* CONFIG_PM */
 
-const struct dev_pm_ops kxsd9_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(kxsd9_runtime_suspend,
-			   kxsd9_runtime_resume, NULL)
-};
-EXPORT_SYMBOL_NS(kxsd9_dev_pm_ops, IIO_KXSD9);
+EXPORT_NS_RUNTIME_DEV_PM_OPS(kxsd9_dev_pm_ops, kxsd9_runtime_suspend,
+			     kxsd9_runtime_resume, NULL, IIO_KXSD9);
 
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("Kionix KXSD9 driver");
-- 
2.36.1


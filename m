Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9304A3895
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355913AbiA3T0Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355914AbiA3T0U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D46C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:26:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A41DB612EC
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9848C340F1;
        Sun, 30 Jan 2022 19:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570779;
        bh=JLpvIonVCWdO5f2RxVnL5Gjcdsb17rV6YEkcppAgpFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGZmcykPvLDtg4gkMEnce5FHZY0WDuTqhvPnNBZybi+cW77634DrvxlWqW4zRC/CP
         S8FkSLiKlQNwMZm8lLVmOEuoFqXll7m+uV93UHIsyrtVsGMkJBbcNYFKcCQBB3QaJe
         TcuKUs2PCQJ7Jc4327FLulKzCetvh1gRYwJjJB01w9yAyMOxfHh7Xl5Sk3dlO7PsPG
         P5qqkAxeU57BrHJzW0IKyhySuRNlLlGF4xcOaZY/rTmJyrjDpbMTUA3297EfPEwcsT
         Sj3kAPx/3va8GKrlioGZi2StQnwiLoXL2BBY59DrqaJZShiQqdhIFjfViY7Sg+j9E7
         l/gLakvLLoSNg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 21/50] iio:light:isl29125: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:18 +0000
Message-Id: <20220130193147.279148-22-jic23@kernel.org>
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
 drivers/iio/light/isl29125.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index ba53b50d711a..eb68a52aab82 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -311,7 +311,6 @@ static int isl29125_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int isl29125_suspend(struct device *dev)
 {
 	struct isl29125_data *data = iio_priv(i2c_get_clientdata(
@@ -326,9 +325,9 @@ static int isl29125_resume(struct device *dev)
 	return i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
 		data->conf1);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(isl29125_pm_ops, isl29125_suspend, isl29125_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(isl29125_pm_ops, isl29125_suspend,
+				isl29125_resume);
 
 static const struct i2c_device_id isl29125_id[] = {
 	{ "isl29125", 0 },
@@ -339,7 +338,7 @@ MODULE_DEVICE_TABLE(i2c, isl29125_id);
 static struct i2c_driver isl29125_driver = {
 	.driver = {
 		.name	= ISL29125_DRV_NAME,
-		.pm	= &isl29125_pm_ops,
+		.pm	= pm_sleep_ptr(&isl29125_pm_ops),
 	},
 	.probe		= isl29125_probe,
 	.remove		= isl29125_remove,
-- 
2.35.1


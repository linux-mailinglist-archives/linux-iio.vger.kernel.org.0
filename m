Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A554A388C
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355900AbiA3T0E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355898AbiA3T0D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E94C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:26:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9DBAB829AC
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DE8C340EB;
        Sun, 30 Jan 2022 19:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570760;
        bh=H4Ta2bz+7129RlQcOqndFh9qfK7IAsUkAMTNDEWZ930=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7sgjx28jTel58IU+L8UuqyKDiaDl0C3k7WULJl8CRcxQDcKnVzA9L+qqJ9fPOxlg
         yPNVqLtMAhe1Aaye2EQgv1ApEPY7IvC2tjjQ17luLSRrr6EC3xP4hH7MniCE9PuPGE
         63I0SdvlB1S4hslWWGyyGrnek6IQg7E5B8HqUFlc5q8kSBGm3jZ6LncoZBDn5BAFp+
         xrZCKC6Y0kfdsvPVXdhXmBBA21jXLJfbJSM1jvREepr4977jz8D1fciDoz1cA3XYoC
         M6xeSSZjMDUk/wLDWAbtkM0iwRwsEq6O0uN/vwWJTaDBAlSU/YOJnZeMc2Awp3Av3K
         QdxrgNUy8ho/A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 12/50] iio:adc:palmas_gpadc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date:   Sun, 30 Jan 2022 19:31:09 +0000
Message-Id: <20220130193147.279148-13-jic23@kernel.org>
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

In this case SIMPLE_DEV_PM_OPS() could have been used previously.
Now we have DEFINE_SIMPLE_DEV_PM_OPS() which also deals with letting
the compiler remove the structure and functions so use that instead.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/palmas_gpadc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index f9c8385c72d3..61e80bf3d05e 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -653,7 +653,6 @@ static int palmas_gpadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
 {
 	int adc_period, conv;
@@ -822,12 +821,9 @@ static int palmas_gpadc_resume(struct device *dev)
 
 	return 0;
 };
-#endif
 
-static const struct dev_pm_ops palmas_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(palmas_gpadc_suspend,
-				palmas_gpadc_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(palmas_pm_ops, palmas_gpadc_suspend,
+				palmas_gpadc_resume);
 
 static const struct of_device_id of_palmas_gpadc_match_tbl[] = {
 	{ .compatible = "ti,palmas-gpadc", },
@@ -840,7 +836,7 @@ static struct platform_driver palmas_gpadc_driver = {
 	.remove = palmas_gpadc_remove,
 	.driver = {
 		.name = MOD_NAME,
-		.pm = &palmas_pm_ops,
+		.pm = pm_sleep_ptr(&palmas_pm_ops),
 		.of_match_table = of_palmas_gpadc_match_tbl,
 	},
 };
-- 
2.35.1


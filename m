Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E8B482B2D
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiABMvd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50416 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiABMvc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A51DCB80CFC
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF20C36AE7;
        Sun,  2 Jan 2022 12:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127890;
        bh=Z6RFNiEAUiFuHZEi26BB2FYS2FkecMuqX6mAxKfmueE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FZB/Kb2w5Dj88S+WokjZKwFxgK0hWd9XGoAyavqYv0/kt3PaKppeuG1Y6aje+pexf
         J2EkYnabnT1C/7cqeNp1xHw1U7UKZVfQUbBagn1Z4xPYX2LMeUWQq3Mbb2/F9IUelZ
         5TCjfA7seAiqiLaHbMDHDWkLPMJySd+ppGH5lt4Ph92nrjaVg2XVZyx5JnculFqEEB
         9L8dkW7Yd2YzJr5ZPkVgDU2nECmUi483dPsm8TdexqOvq+S73ryFufdi87rStItmcz
         PPqQ9WmKpWqqdGjWLwfypOmIX4QWPPlCxJ8u1+/F8MU3HHyYJPwQrWs2Jy8lmAdbwo
         zR56z+V/HcH0A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 14/51] iio:adc:palmas_gpadc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date:   Sun,  2 Jan 2022 12:55:40 +0000
Message-Id: <20220102125617.1259804-15-jic23@kernel.org>
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

In this case SIMPLE_DEV_PM_OPS() could have been used previously.
Now we have DEFINE_SIMPLE_DEV_PM_OPS() which also deals with letting
the compiler remove the structure and functions so use that instead.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/palmas_gpadc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index f9c8385c72d3..a8febe487b2b 100644
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
+DEFINE_SIMPLE_DEV_PM_OPS(palmas_pm_ops, palmas_gpadc_suspend,
+			 palmas_gpadc_resume);
 
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
2.34.1


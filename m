Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550674A38AB
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355952AbiA3T1g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355965AbiA3T1L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:27:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688BDC06174A
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:27:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B842B829AC
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED752C340F0;
        Sun, 30 Jan 2022 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570829;
        bh=Axk6oH2mMWkUvmu8G5W54MKrxBW4itgOJLD9rp143aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1f6cN0U9H4J0qk7sghxmlgOPQEv23gsHUxpceRBYdODMitStF4DwzW01WI8Nc3Nl
         wTpJ8XzjEIlktOWbfLKgYlIRZbxdKlK/YgXUi0owhmuYP+un47ZN3s1rmyBs8/wS+R
         ppEP4buECjwB8tBy1PNpdrIT+J3ysZ2r4aR6TL2bEHY7H1JwaEnt/cDz65R+gPRpz2
         y9LVtndwynuZVTRhYKXSKnIHW3SR0zWWKBaEm4aguDspCmcY7aKz/IUymJu0EH+eyG
         lgWqHxdSOrYYT9rwFbYP/E5evCEh6RGrE0r6H+XU+gvben2A/a1GELO3v3URmzmTI1
         mPAMXATWsIoHg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 43/50] iio:adc:ab8500: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:40 +0000
Message-Id: <20220130193147.279148-44-jic23@kernel.org>
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
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

This case uses the new DEFINE_RUNTIME_DEV_PM_OPS() to reduce
boilerplate.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/adc/ab8500-gpadc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
index 4c46a201d4ef..78c2bd8bb91d 100644
--- a/drivers/iio/adc/ab8500-gpadc.c
+++ b/drivers/iio/adc/ab8500-gpadc.c
@@ -942,7 +942,6 @@ static const struct iio_info ab8500_gpadc_info = {
 	.read_raw = ab8500_gpadc_read_raw,
 };
 
-#ifdef CONFIG_PM
 static int ab8500_gpadc_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -965,7 +964,6 @@ static int ab8500_gpadc_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 /**
  * ab8500_gpadc_parse_channel() - process devicetree channel configuration
@@ -1199,20 +1197,15 @@ static int ab8500_gpadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct dev_pm_ops ab8500_gpadc_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(ab8500_gpadc_runtime_suspend,
-			   ab8500_gpadc_runtime_resume,
-			   NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(ab8500_gpadc_runtime_suspend,
+				 ab8500_gpadc_runtime_resume, NULL);
 
 static struct platform_driver ab8500_gpadc_driver = {
 	.probe = ab8500_gpadc_probe,
 	.remove = ab8500_gpadc_remove,
 	.driver = {
 		.name = "ab8500-gpadc",
-		.pm = &ab8500_gpadc_pm_ops,
+		.pm = pm_ptr(&ab8500_gpadc_pm_ops),
 	},
 };
 builtin_platform_driver(ab8500_gpadc_driver);
-- 
2.35.1


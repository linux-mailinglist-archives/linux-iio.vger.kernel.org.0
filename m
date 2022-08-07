Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF9058BCA0
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiHGS4z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiHGS4y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:56:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966F3312
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1017260FF8
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF84C433C1;
        Sun,  7 Aug 2022 18:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659898612;
        bh=NnhVukDwHajVEv1t05r6QizVMhrpeWiLXsk6LSLrJs0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZWKuDjc2RROua1htK8jHNh6cG1NfUxeddmeCbFFqK9u0ZGJn78PDW1PwLRdYOYf9H
         o5UT+J4Bm6uD/hh9Xd/2YZvOFelL6rFPuqgSOjGgTlT/zcFn2RWV0IJckTNom6WBYa
         PWjBumu9wGWEXsmTMpZSG4tXv3Ev2DwFH7RZ4N1MQPaM0tEm7VK0iFvCR7YOFFfAlc
         HQm0VfAZXKD712DWo4CceNjKZgcj30LnbKwUD/UutnA5xzIPCpQVMjrADz8Xr9OSi8
         0gXOVS/8WMbFJB5YBluy3XfbAWGj05dx8uvsqROUa0CZx1SBtVUxktaTgM+32KY7Sb
         LzKTaj2zGKZMw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iio: adc: rzg2l: Use RUNTIME_PM_OPS() instead of SET_*
Date:   Sun,  7 Aug 2022 20:07:12 +0100
Message-Id: <20220807190712.1039403-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
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

Here we could use DEFINE_RUNTIME_DEV_PM_OPS() but that would have the
side effect of providing suspend and resume support.  That would be
harmless but also of little purpose as this driver does very simplistic
power management with synchronous power up and down around individual
channel reads.

In general these new PM macros avoid the need to mark functions
__maybe_unused, whilst still allowing the compiler to remove them
if they are unused.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iio/adc/rzg2l_adc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 0921ff2d9b3a..b859a2db6b13 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -547,7 +547,7 @@ static const struct of_device_id rzg2l_adc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
 
-static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
+static int rzg2l_adc_pm_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
@@ -559,7 +559,7 @@ static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
+static int rzg2l_adc_pm_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
@@ -581,9 +581,9 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops rzg2l_adc_pm_ops = {
-	SET_RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
-			   rzg2l_adc_pm_runtime_resume,
-			   NULL)
+	RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
+		       rzg2l_adc_pm_runtime_resume,
+		       NULL)
 };
 
 static struct platform_driver rzg2l_adc_driver = {
@@ -591,7 +591,7 @@ static struct platform_driver rzg2l_adc_driver = {
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.of_match_table = rzg2l_adc_match,
-		.pm		= &rzg2l_adc_pm_ops,
+		.pm		= pm_ptr(&rzg2l_adc_pm_ops),
 	},
 };
 
-- 
2.37.1


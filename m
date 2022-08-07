Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170C358BC8C
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiHGSqT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbiHGSqS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:46:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4E12DFB
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4160CB80DD0
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB5DC433C1;
        Sun,  7 Aug 2022 18:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659897975;
        bh=yHxom/j6lLU4c8f8dLH2Segi9W2UPZI6Bwb0VQ3qAyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=deXdUDIFwyIH6P6j/2+mogTyTT9icJmrkjfZfA7qOsrQIxl9m0Z6FHpO4CnyPC8pa
         EIa2LLfE4wQYtOfYrY8Cj15jcMt6BML1Ar2/bc4OqtKp/2I7PW8kE6pH/yHb0gxe1E
         tw1VQp1glNHqqtilnNGI+3b9eH2cq618OXpeGdnzIogc1b39EexbffMjBDi+cbl/68
         H/KkjYVs8BvCQ9OZHeXmuvdythbjQkh2syysnkrCxBp6hclumBN4xbDlwgckh53vE5
         E5hLRLSB+tG5L8JZgWaA8ayckyvAl8mK2y/T5O+RKno0h6ovZIiIvla4XnLZvlSY3t
         ah6FD7dczSIYA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/6] iio: proximity: srf04: Use pm_ptr() to remove unused struct dev_pm_ops
Date:   Sun,  7 Aug 2022 19:56:16 +0100
Message-Id: <20220807185618.1038812-5-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807185618.1038812-1-jic23@kernel.org>
References: <20220807185618.1038812-1-jic23@kernel.org>
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

If CONFIG_PM is not set, the pm_ptr() will ensure that the struct
dev_pm_ops and callbacks are removed without the need for __maybe_unused
markings.

In this case we can't simply use DEFINE_RUNTIME_DEV_PM_OPS() because
that would provide suspend and resume functions without the
checks the driver is doing before calling runtime_pm functions
(whether the necessary GPIO is provided).  It may be possible to
clean that up in future by moving the checks into the callbacks.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/srf04.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 05015351a34a..faf2f806ce80 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -359,7 +359,7 @@ static int srf04_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused srf04_pm_runtime_suspend(struct device *dev)
+static int  srf04_pm_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = container_of(dev,
 						struct platform_device, dev);
@@ -371,7 +371,7 @@ static int __maybe_unused srf04_pm_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused srf04_pm_runtime_resume(struct device *dev)
+static int srf04_pm_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = container_of(dev,
 						struct platform_device, dev);
@@ -385,8 +385,8 @@ static int __maybe_unused srf04_pm_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops srf04_pm_ops = {
-	SET_RUNTIME_PM_OPS(srf04_pm_runtime_suspend,
-				srf04_pm_runtime_resume, NULL)
+	RUNTIME_PM_OPS(srf04_pm_runtime_suspend,
+		       srf04_pm_runtime_resume, NULL)
 };
 
 static struct platform_driver srf04_driver = {
@@ -395,7 +395,7 @@ static struct platform_driver srf04_driver = {
 	.driver		= {
 		.name		= "srf04-gpio",
 		.of_match_table	= of_srf04_match,
-		.pm		= &srf04_pm_ops,
+		.pm		= pm_ptr(&srf04_pm_ops),
 	},
 };
 
-- 
2.37.1


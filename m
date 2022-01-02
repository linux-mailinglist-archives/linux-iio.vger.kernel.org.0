Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FF0482B2F
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiABMvi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50468 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiABMvi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51A19B80D61
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155A1C36AF0;
        Sun,  2 Jan 2022 12:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127896;
        bh=j0VmH+iuAGeL4CIMed+zLG7HtqEOQ4rth/BZgPt/s+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pr6AHrss4l+KmuLVwDdmhjeN64DeKvXdRl+ngNX1RipHJVSsFcannsq/G2fGEpDyi
         CixedSgw4R+o520dkSsdwcbYLoxF786t4OMKFRtmYAzHun4qHI4Mi0NSXlqwH/Ttb3
         ocW30puRyGHQ6dyck5iFyPJMMmUkGeKcWSMMHZv4RTlplD4gt/ZvGlBMB0Xf+LaLKb
         JoyFFF/hyvWTuE7qhLsmaDT99qYsD8+0kNjfdQedpeBNs0o8J5eQ6FrAU4qP3M4Yjy
         6a84rI+TM40lU2scEVZSGz7dHgrZHKUO5J3OC0yXpmkrTVKDmSLm3vNc5whpoMUNIN
         1WppPZ7hnQ8cA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 16/51] iio:adc:rcar: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:42 +0000
Message-Id: <20220102125617.1259804-17-jic23@kernel.org>
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
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rcar-gyroadc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 727ea6c68049..27d9e147b4b7 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -577,7 +577,6 @@ static int rcar_gyroadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_PM)
 static int rcar_gyroadc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -597,10 +596,9 @@ static int rcar_gyroadc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops rcar_gyroadc_pm_ops = {
-	SET_RUNTIME_PM_OPS(rcar_gyroadc_suspend, rcar_gyroadc_resume, NULL)
+	RUNTIME_PM_OPS(rcar_gyroadc_suspend, rcar_gyroadc_resume, NULL)
 };
 
 static struct platform_driver rcar_gyroadc_driver = {
@@ -609,7 +607,7 @@ static struct platform_driver rcar_gyroadc_driver = {
 	.driver         = {
 		.name		= DRIVER_NAME,
 		.of_match_table	= rcar_gyroadc_match,
-		.pm		= &rcar_gyroadc_pm_ops,
+		.pm		= pm_ptr(&rcar_gyroadc_pm_ops),
 	},
 };
 
-- 
2.34.1


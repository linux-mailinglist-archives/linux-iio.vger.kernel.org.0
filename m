Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755904A3891
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiA3T0O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51556 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiA3T0N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C34FB8290B
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61763C340F1;
        Sun, 30 Jan 2022 19:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570770;
        bh=IBUKa9IRInVumAHUKp9Q2gFS1kjKYIMKYXkY68LclRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=urjfjgQ8B5zXnSn3TDHyn2zFk9s8Pp1jT0SYBBDG7/rTl9wUZbzqFogY+7oZxpTBR
         sZMAkfd2TBPfJ4Tcxf5u9IJ+bbXOa6eK1adjl+CiGEF5HChXz00O3sXNSgwwEzsbae
         /yelfSe4sL+luq6rqslic5G8MYaOVDbd6w1sN8ugX6cs7VHDlPGLOYS0IOepTGtUHR
         DvLNlOzZZGEnQL7k1qARNtpf9tuHZEKTPN58AJ5wISZ2t6rtyK1tzp5T1iJ5PfsFSe
         9p+g4lY84Gtp6ggWkKvhGvM1054vKDl4kM6xncHYI2S+ytBjqjW4aPNdEKHdxBa+0D
         +idAI3dRnoUvg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 17/50] iio:dac:vf610: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:14 +0000
Message-Id: <20220130193147.279148-18-jic23@kernel.org>
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
 drivers/iio/dac/vf610_dac.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index 636b4009f763..92429c0d2685 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -242,7 +242,6 @@ static int vf610_dac_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int vf610_dac_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -268,9 +267,9 @@ static int vf610_dac_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(vf610_dac_pm_ops, vf610_dac_suspend, vf610_dac_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(vf610_dac_pm_ops, vf610_dac_suspend,
+				vf610_dac_resume);
 
 static struct platform_driver vf610_dac_driver = {
 	.probe          = vf610_dac_probe,
@@ -278,7 +277,7 @@ static struct platform_driver vf610_dac_driver = {
 	.driver         = {
 		.name   = "vf610-dac",
 		.of_match_table = vf610_dac_match,
-		.pm     = &vf610_dac_pm_ops,
+		.pm     = pm_sleep_ptr(&vf610_dac_pm_ops),
 	},
 };
 module_platform_driver(vf610_dac_driver);
-- 
2.35.1


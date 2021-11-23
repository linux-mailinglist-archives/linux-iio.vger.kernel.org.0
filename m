Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96D445ADF0
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbhKWVJm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239569AbhKWVJl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D393660FE7;
        Tue, 23 Nov 2021 21:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701593;
        bh=6QM/i4nkv5NQYTsBGGF+1XgambBgPZHGFMGofgxK1lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKRfjub/s0avOcrX1sZU5ACiE34g86K38nsdQE1QxREBlJSLVHsd+rGwcODdX/xXf
         vzAnleSUKiVDh+pT/1s8TVoALyp2Wh+1LI0VLHvT79lNIkrKUYj/i3fkTO70vFvEhH
         IbeaiKAOF/oT/OfFrgdqU4qKwJrPmr9VsKyLyzrH+G88ua+ku4fQGmiNg3WGooZGrw
         TSzGlgELFZhSN7PeS3WHO758F12kYb8hKa5ekcpgAIckweCXi+jvPxbzIqgAZtkrzL
         WCQo/MeVQECAIZaFAOkXkfLEtTUc8EZnDuoFJcxXMSrQDMisGfQVeSqUHohW1SyCYy
         HTuN62x+thHKw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 22/49] iio:dac:vf610: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:52 +0000
Message-Id: <20211123211019.2271440-23-jic23@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123211019.2271440-1-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
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

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/vf610_dac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index 636b4009f763..44b290da078d 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -242,8 +242,7 @@ static int vf610_dac_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int vf610_dac_suspend(struct device *dev)
+static __maybe_unused int vf610_dac_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct vf610_dac *info = iio_priv(indio_dev);
@@ -254,7 +253,7 @@ static int vf610_dac_suspend(struct device *dev)
 	return 0;
 }
 
-static int vf610_dac_resume(struct device *dev)
+static __maybe_unused int vf610_dac_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct vf610_dac *info = iio_priv(indio_dev);
@@ -268,7 +267,6 @@ static int vf610_dac_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(vf610_dac_pm_ops, vf610_dac_suspend, vf610_dac_resume);
 
@@ -278,7 +276,7 @@ static struct platform_driver vf610_dac_driver = {
 	.driver         = {
 		.name   = "vf610-dac",
 		.of_match_table = vf610_dac_match,
-		.pm     = &vf610_dac_pm_ops,
+		.pm     = pm_ptr(&vf610_dac_pm_ops),
 	},
 };
 module_platform_driver(vf610_dac_driver);
-- 
2.34.0


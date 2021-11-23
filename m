Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DB945AE06
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbhKWVKa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239711AbhKWVK0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C832F60FE6;
        Tue, 23 Nov 2021 21:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701638;
        bh=5LtgAxXohh70ur3tDRHwz++fztttROg74AfN39J5tpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QF+8fFrG9KT7IpBivJQz4Qa+BYaar4S+/RQ3YXJdTFMxxs1cYE9PTwyK210E1G5B/
         o2SYLMJiczjaD2huE25rd0wViDhCKxlo/lLU5z+hychzWpaOTOZSinhULoI2R9cxd/
         Q04ZDKQhhDWrBIEOJh6Qap+h8G3GTZfT4LcOCr2BK/4OjnVcPV0p39orLwwnzAJzui
         aDESWpny+H6JfyBSorDEN6SJb7XS3eupsU5H5w1VXRxii4zcgN8yzz/Q6TO1GxDoyj
         fGLWKVSE2yT3T61XvOTrq24HHAlOLAs9z0kXUyFc/15n7pgmD8Gc39VeOF0I9KF1pt
         7BSDYLKArfy8w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 44/49] iio:proximity:rfd77492: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:14 +0000
Message-Id: <20211123211019.2271440-45-jic23@kernel.org>
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
 drivers/iio/proximity/rfd77402.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 8c06d02139b6..456afeb71db1 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -295,17 +295,15 @@ static int rfd77402_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int rfd77402_suspend(struct device *dev)
+static __maybe_unused int rfd77402_suspend(struct device *dev)
 {
 	return rfd77402_powerdown(to_i2c_client(dev));
 }
 
-static int rfd77402_resume(struct device *dev)
+static __maybe_unused int rfd77402_resume(struct device *dev)
 {
 	return rfd77402_init(to_i2c_client(dev));
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(rfd77402_pm_ops, rfd77402_suspend, rfd77402_resume);
 
@@ -318,7 +316,7 @@ MODULE_DEVICE_TABLE(i2c, rfd77402_id);
 static struct i2c_driver rfd77402_driver = {
 	.driver = {
 		.name   = RFD77402_DRV_NAME,
-		.pm     = &rfd77402_pm_ops,
+		.pm     = pm_ptr(&rfd77402_pm_ops),
 	},
 	.probe  = rfd77402_probe,
 	.id_table = rfd77402_id,
-- 
2.34.0


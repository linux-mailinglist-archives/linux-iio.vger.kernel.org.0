Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F134145AE08
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbhKWVKd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239859AbhKWVKa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 647A360FC1;
        Tue, 23 Nov 2021 21:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701641;
        bh=RP7Gu9UT6Yh2RoNNNNIQ+sAlrgRpgy7qPy5NzZu3qYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDWvEIbHFNPwSYQswJiMGc97tu056kfq1kFwlglY96fqpovf7e2m+WAIQGZ+QGJ+/
         Bfvo2wtzUMMLiLAet/krwJRrHZQ+3sMKagSZlZeU4xNFXlls5Hz+7wluuAhOWTYYID
         N/oY7ev51bOF617pDTtl+3FlUyEkY00Tod+vxJkvIPrIe8x/PiywZpLZ80aoIhyxC2
         Q3Z5RF/jVM2tg2SiTZrl6N6KTL86WUiB5ByU6A9UkUdSHSdi6+onxGfdInL8qIN06Q
         7ywc7vxi7NkFMGayU2kG61NAuf6oi7YQXvKJvAo7Euy8BXVo5Y2bRlAOPhVFez/suP
         COo+mGs8aFYSg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 46/49] iio:temperature:tmp006: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:16 +0000
Message-Id: <20211123211019.2271440-47-jic23@kernel.org>
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
 drivers/iio/temperature/tmp006.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index e4943a0bc9aa..beac388e56f5 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -261,17 +261,15 @@ static int tmp006_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int tmp006_suspend(struct device *dev)
+static __maybe_unused int tmp006_suspend(struct device *dev)
 {
 	return tmp006_power(dev, false);
 }
 
-static int tmp006_resume(struct device *dev)
+static __maybe_unused int tmp006_resume(struct device *dev)
 {
 	return tmp006_power(dev, true);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(tmp006_pm_ops, tmp006_suspend, tmp006_resume);
 
@@ -284,7 +282,7 @@ MODULE_DEVICE_TABLE(i2c, tmp006_id);
 static struct i2c_driver tmp006_driver = {
 	.driver = {
 		.name	= "tmp006",
-		.pm	= &tmp006_pm_ops,
+		.pm	= pm_ptr(&tmp006_pm_ops),
 	},
 	.probe = tmp006_probe,
 	.id_table = tmp006_id,
-- 
2.34.0


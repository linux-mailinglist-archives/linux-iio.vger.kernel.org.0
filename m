Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9B245ADFA
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239569AbhKWVKD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239519AbhKWVKC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D19B460FC3;
        Tue, 23 Nov 2021 21:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701614;
        bh=MWnxfnxQN8e/ifm51CPV9IJI8JaJcetotdBLKgy3r78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JEyvTkNN3Z3VhHjuD2mbky/GglnmRnh2tKk8atyoXyi8MXiv1eoIwafSpVsEVQO5o
         foW2EHuoAQj9iigWfhSKqL03v66HIs/CGKrYVOv2kymwVFMO5OdlmUpH/TxiE7uycV
         jt9CZVansQfTWiHwiGoHLhaMddxyKOY7hmjOSdkx4hDUhN8u67617LQQ78i9a6QTFu
         xCvcbJ5GUBh9KpNTNWnIb31M5eMMbJOi6fXBjEoQ1HOYJKhQhWodjhP748hzTSt2Xv
         t3YOwFH+EdyJpfpgthKaD8/wo14STm43XkJQSmGpB+mbHcXo0VkFU5PFfoYotwCPL3
         3QBCpoiWXnJXg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 32/49] iio:light:tcs3472: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:02 +0000
Message-Id: <20211123211019.2271440-33-jic23@kernel.org>
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
 drivers/iio/light/tcs3472.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 371c6a39a165..ff548a562fc2 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -572,15 +572,14 @@ static int tcs3472_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int tcs3472_suspend(struct device *dev)
+static __maybe_unused int tcs3472_suspend(struct device *dev)
 {
 	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	return tcs3472_powerdown(data);
 }
 
-static int tcs3472_resume(struct device *dev)
+static __maybe_unused int tcs3472_resume(struct device *dev)
 {
 	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
@@ -598,7 +597,6 @@ static int tcs3472_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(tcs3472_pm_ops, tcs3472_suspend, tcs3472_resume);
 
@@ -611,7 +609,7 @@ MODULE_DEVICE_TABLE(i2c, tcs3472_id);
 static struct i2c_driver tcs3472_driver = {
 	.driver = {
 		.name	= TCS3472_DRV_NAME,
-		.pm	= &tcs3472_pm_ops,
+		.pm	= pm_ptr(&tcs3472_pm_ops),
 	},
 	.probe		= tcs3472_probe,
 	.remove		= tcs3472_remove,
-- 
2.34.0


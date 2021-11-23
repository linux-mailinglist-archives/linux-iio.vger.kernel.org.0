Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A545845ADF9
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239542AbhKWVKB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239519AbhKWVKA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5E516023D;
        Tue, 23 Nov 2021 21:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701612;
        bh=OqUrZbNfrw/lxzw5nXiwZa24qMe74byFZ+1ZbGr5xLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSCAHs07OzHNoic4yo0ilRMRzFfKPCcFKu8j3BZs1DVEfPsX7W1IimmZ/7gHCI5Ue
         xhVsvV0XhCaEBCoQYTNZ1TfkiU5ohTZ3rVH0PUeCGYe07T7d7h1HM67PiThrA70IzT
         8gIMbaYzEzB/B/cKoBjcCukgr1JGdfAd2bIbH3X8OFSzX+p4BVSKpXFtb1TYuNX013
         awt7/yQi0byPToeiD39q8Kictgr0gCbuG5gelGWNzGuWQK+M3zGPJqLysiYmS/yZeZ
         nYHmTIacMiiraCR7QuAj6g6c+QuSCiA1kjv0i5XoNYOLCDOiQZdyjcYr1eARm2uilx
         KcCKIp0uu5LpQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 31/49] iio:light:tcs3414: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:01 +0000
Message-Id: <20211123211019.2271440-32-jic23@kernel.org>
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
 drivers/iio/light/tcs3414.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index b87222141429..e6e49054ddfa 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -345,22 +345,20 @@ static int tcs3414_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int tcs3414_suspend(struct device *dev)
+static __maybe_unused int tcs3414_suspend(struct device *dev)
 {
 	struct tcs3414_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	return tcs3414_powerdown(data);
 }
 
-static int tcs3414_resume(struct device *dev)
+static __maybe_unused int tcs3414_resume(struct device *dev)
 {
 	struct tcs3414_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
 		data->control);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(tcs3414_pm_ops, tcs3414_suspend, tcs3414_resume);
 
@@ -373,7 +371,7 @@ MODULE_DEVICE_TABLE(i2c, tcs3414_id);
 static struct i2c_driver tcs3414_driver = {
 	.driver = {
 		.name	= TCS3414_DRV_NAME,
-		.pm	= &tcs3414_pm_ops,
+		.pm	= pm_ptr(&tcs3414_pm_ops),
 	},
 	.probe		= tcs3414_probe,
 	.id_table	= tcs3414_id,
-- 
2.34.0


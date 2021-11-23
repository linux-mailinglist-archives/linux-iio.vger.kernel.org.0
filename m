Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D55245ADF5
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbhKWVJw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239320AbhKWVJw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6556D60FC3;
        Tue, 23 Nov 2021 21:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701603;
        bh=ymDI8wRdV9Eja860ZewgU0/u4hcE+TNXgg7UHb+sfFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FMiqBsSLW8PaiyOA+NPF/G/xepTYADTXLqyJXLNRAEy7TgQ2LbrCmzthik6pk8Vyo
         Q4RJqG0hiWpZBk+oL70ontV5rDPmzy3elilDzpeKJZThWCu4uFGQrWUWJ1vDEFsBps
         gMr9xCVWrjD+jtbfO+X6jQAhc7egmQ9IVtY/H+7TZWHGol+W7QuZlKKsUWB8HviqgN
         gmBXd2gHLbf+RIh31RMCNDn5KKr1MeToyBkd9SOTvL5HggCdzZdIcDa3wEPecGvVq2
         XkjDTQe2Eoh9NJwiQBHVK7BLu50dOogP/f7hgf7HUfZe4gbMnzEtQBp/E2yFoXQw8m
         gfZ5gBu0SN8/g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 27/49] iio:light:isl29125: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:57 +0000
Message-Id: <20211123211019.2271440-28-jic23@kernel.org>
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
 drivers/iio/light/isl29125.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index ba53b50d711a..334267595199 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -311,22 +311,20 @@ static int isl29125_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int isl29125_suspend(struct device *dev)
+static __maybe_unused int isl29125_suspend(struct device *dev)
 {
 	struct isl29125_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	return isl29125_powerdown(data);
 }
 
-static int isl29125_resume(struct device *dev)
+static __maybe_unused int isl29125_resume(struct device *dev)
 {
 	struct isl29125_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	return i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
 		data->conf1);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(isl29125_pm_ops, isl29125_suspend, isl29125_resume);
 
@@ -339,7 +337,7 @@ MODULE_DEVICE_TABLE(i2c, isl29125_id);
 static struct i2c_driver isl29125_driver = {
 	.driver = {
 		.name	= ISL29125_DRV_NAME,
-		.pm	= &isl29125_pm_ops,
+		.pm	= pm_ptr(&isl29125_pm_ops),
 	},
 	.probe		= isl29125_probe,
 	.remove		= isl29125_remove,
-- 
2.34.0


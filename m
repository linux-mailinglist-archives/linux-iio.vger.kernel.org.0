Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B9945ADF2
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbhKWVJq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239320AbhKWVJq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D22A060FE3;
        Tue, 23 Nov 2021 21:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701597;
        bh=7G0a8YPoOWSZImMW7Kwgif5EC2GNEuuyiOI7Jf6bGBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASp2aPDqAe6SWpVkMKAs086elM03GaPGZaQ83adq0fDJPeT39VJ7HFaT4Sbm8KwLH
         5kwIUuAXHUNIovG7pqH9na50Dy9v6B98eE8cyKQh4TrPdvmLgnjKjH/S6ObqH2VBgI
         +Wl55PJbsUDK5Alnx4ryhQLw0Ytbltv8tzXpC9znOtIR+CazvudmQ09/E08z2gTCAO
         kjiUHa7fgLp2u1qVvM+eEB6iYVQUa7WOf4VNXqOudBYjgWZbWB1JmE4aTH62Q4rfcR
         o8VWbMsMJiI/U8dtNQzqGYoTmIAXAn3cVrCa4MFuPaVXPKhBrkRT0hDTMBnG6yoxt8
         lyfDlmpLRjWaw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 24/49] iio:light:bh1780: Switch from CONFIG_PM guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:54 +0000
Message-Id: <20211123211019.2271440-25-jic23@kernel.org>
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
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/light/bh1780.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index abbf2e662e7d..d72dd825368a 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -221,8 +221,7 @@ static int bh1780_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int bh1780_runtime_suspend(struct device *dev)
+static __maybe_unused int bh1780_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
@@ -238,7 +237,7 @@ static int bh1780_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int bh1780_runtime_resume(struct device *dev)
+static __maybe_unused int bh1780_runtime_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
@@ -256,9 +255,8 @@ static int bh1780_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
-static const struct dev_pm_ops bh1780_dev_pm_ops = {
+static __maybe_unused const struct dev_pm_ops bh1780_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(bh1780_runtime_suspend,
@@ -284,7 +282,7 @@ static struct i2c_driver bh1780_driver = {
 	.id_table	= bh1780_id,
 	.driver = {
 		.name = "bh1780",
-		.pm = &bh1780_dev_pm_ops,
+		.pm = pm_ptr(&bh1780_dev_pm_ops),
 		.of_match_table = of_bh1780_match,
 	},
 };
-- 
2.34.0


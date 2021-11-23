Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081DF45ADFC
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbhKWVKH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239571AbhKWVKH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BA0B60FC1;
        Tue, 23 Nov 2021 21:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701618;
        bh=73PuKOO4Dz4H/DaAL4fi2zwV/ilxX4Dad4HOXn4Y6+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uioIur6VdNYEMGn9CXjHXYyWRrn7hQiuyagKwsMUF6JN1ltqNL5QCfWz41WW8U/kZ
         XIvxH2TkIyf1zU/L0fcVcBLA+D8LrYbX78oR8PRm/fYi+vhqaxjvG5WOiLTOLGerrt
         Uci0S6zu/xtrqQ3kqhJ7in50UD2wCGhw6HoSmxkTBW9Tmlv/bYIekiYpSGlmebb+GJ
         cK/f+4rc7i+nL+ZKMQjDzjm08eAA31Bva9qiyHoDELmbpnJ1jkK6fKscKVCtnDpoQd
         FQc2L0wz7Xs/SSPUtzbIV7ONhLsw/3PG1DBRYjRRTIWGs0uDHCjkonGiM4J1T1V4Jj
         O+Df4npF9ZhGQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 34/49] iio:light:tsl4531: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:04 +0000
Message-Id: <20211123211019.2271440-35-jic23@kernel.org>
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
 drivers/iio/light/tsl4531.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
index 70505ba6d858..8632927bc077 100644
--- a/drivers/iio/light/tsl4531.c
+++ b/drivers/iio/light/tsl4531.c
@@ -215,23 +215,18 @@ static int tsl4531_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int tsl4531_suspend(struct device *dev)
+static __maybe_unused int tsl4531_suspend(struct device *dev)
 {
 	return tsl4531_powerdown(to_i2c_client(dev));
 }
 
-static int tsl4531_resume(struct device *dev)
+static __maybe_unused int tsl4531_resume(struct device *dev)
 {
 	return i2c_smbus_write_byte_data(to_i2c_client(dev), TSL4531_CONTROL,
 		TSL4531_MODE_NORMAL);
 }
 
 static SIMPLE_DEV_PM_OPS(tsl4531_pm_ops, tsl4531_suspend, tsl4531_resume);
-#define TSL4531_PM_OPS (&tsl4531_pm_ops)
-#else
-#define TSL4531_PM_OPS NULL
-#endif
 
 static const struct i2c_device_id tsl4531_id[] = {
 	{ "tsl4531", 0 },
@@ -242,7 +237,7 @@ MODULE_DEVICE_TABLE(i2c, tsl4531_id);
 static struct i2c_driver tsl4531_driver = {
 	.driver = {
 		.name   = TSL4531_DRV_NAME,
-		.pm	= TSL4531_PM_OPS,
+		.pm	= pm_ptr(&tsl4531_pm_ops),
 	},
 	.probe  = tsl4531_probe,
 	.remove = tsl4531_remove,
-- 
2.34.0


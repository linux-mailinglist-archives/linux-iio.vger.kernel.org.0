Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603D545ADF8
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239459AbhKWVJ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239539AbhKWVJ6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2445A60FD8;
        Tue, 23 Nov 2021 21:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701610;
        bh=F/EJWo6E1jNEivAjaJledJVVyIbAhzPUs2zWFymEK54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+L2wgkeRTpkKtl8d/fi0KDc+x0kMZvnvNX+EUqzfDRaX3DJ3g7X5dpgeT4XR+cSb
         pvdy7XU+qFDGYFTaBcr3oFSvEOrC/NhPDRPvgyoVhk6WXBA9MA2qAxrsusmn5wrIoL
         6soRsd5I9iQ7vO+iBe+mHdhFnIc7Qt9I9kadjPspXWCCV2XhfQXwx8HRDz6+vrGJ0l
         dXjbIxq3b5yAI3DQ5UqQFfLbrpMp2EeowW7g/KwH9qJ08dkuis/BBGRx3tYtaSZ3CJ
         EwN897E9PwRr5reiqzTPqF5oShRAQfoh01mGGqckSiopmD5gp/VXHqMFcRoHG39LiV
         FF2PNXFR+6ZLw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Icenowy Zheng <icenowy@aosc.io>, Luca Weiss <luca@z3ntu.xyz>,
        Martijn Braam <martijn@brixit.nl>
Subject: [PATCH 30/49] iio:light:stk3310: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:00 +0000
Message-Id: <20211123211019.2271440-31-jic23@kernel.org>
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
Cc: Icenowy Zheng <icenowy@aosc.io>
Cc: Luca Weiss <luca@z3ntu.xyz>
Cc: Martijn Braam <martijn@brixit.nl>
---
 drivers/iio/light/stk3310.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 07e91846307c..fc2d5ebf0d68 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -632,8 +632,7 @@ static int stk3310_remove(struct i2c_client *client)
 	return stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int stk3310_suspend(struct device *dev)
+static __maybe_unused int stk3310_suspend(struct device *dev)
 {
 	struct stk3310_data *data;
 
@@ -642,7 +641,7 @@ static int stk3310_suspend(struct device *dev)
 	return stk3310_set_state(data, STK3310_STATE_STANDBY);
 }
 
-static int stk3310_resume(struct device *dev)
+static __maybe_unused int stk3310_resume(struct device *dev)
 {
 	u8 state = 0;
 	struct stk3310_data *data;
@@ -658,11 +657,6 @@ static int stk3310_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend, stk3310_resume);
 
-#define STK3310_PM_OPS (&stk3310_pm_ops)
-#else
-#define STK3310_PM_OPS NULL
-#endif
-
 static const struct i2c_device_id stk3310_i2c_id[] = {
 	{"STK3310", 0},
 	{"STK3311", 0},
@@ -692,7 +686,7 @@ static struct i2c_driver stk3310_driver = {
 	.driver = {
 		.name = "stk3310",
 		.of_match_table = stk3310_of_match,
-		.pm = STK3310_PM_OPS,
+		.pm = pm_ptr(&stk3310_pm_ops),
 		.acpi_match_table = ACPI_PTR(stk3310_acpi_id),
 	},
 	.probe =            stk3310_probe,
-- 
2.34.0


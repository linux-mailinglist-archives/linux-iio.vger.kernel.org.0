Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD436482B3E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiABMwS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42532 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiABMwS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A79E660DB7
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ABFC36AE7;
        Sun,  2 Jan 2022 12:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127937;
        bh=Bf/pd/fiOKd/DtOINUcGbJE/viay5VGBRp0xOn+FqNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OH4otGdEkvTpyPFLM6OXc1sI0ZLLYNmkDjiZmZAUpq0e6Jq9G+d88HqHeM+IsOMwj
         zFqFPwQKdK1B/V7Qgzd6TwTVOrVRfmUjbSmMSJODLubGF4in+/TkyQKPitHB27abX0
         gwkjU0/AAJWVvSFyrCYeu8XlI2PEwX78PGyJ6S222H+F1L9f5kQG2kz466XRhd0hTA
         Rg8QHBV82sDfPF0zv7Szfovs/SxAj0w0KcNkYY0LlQzFEc0xWHSUOMKDgwIVuSGBY3
         UZPSRi2dXay943BBAHiu6UZVEObQVMH9uYIJQydEl6UtJOy7WmSPauqt4ZSTuqb/kd
         4cHLC4ojf5QuQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 31/51] iio:light:tcs3472: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:57 +0000
Message-Id: <20220102125617.1259804-32-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102125617.1259804-1-jic23@kernel.org>
References: <20220102125617.1259804-1-jic23@kernel.org>
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
 drivers/iio/light/tcs3472.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 371c6a39a165..a886b1cd11ce 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -572,7 +572,6 @@ static int tcs3472_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tcs3472_suspend(struct device *dev)
 {
 	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
@@ -598,9 +597,8 @@ static int tcs3472_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(tcs3472_pm_ops, tcs3472_suspend, tcs3472_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(tcs3472_pm_ops, tcs3472_suspend, tcs3472_resume);
 
 static const struct i2c_device_id tcs3472_id[] = {
 	{ "tcs3472", 0 },
@@ -611,7 +609,7 @@ MODULE_DEVICE_TABLE(i2c, tcs3472_id);
 static struct i2c_driver tcs3472_driver = {
 	.driver = {
 		.name	= TCS3472_DRV_NAME,
-		.pm	= &tcs3472_pm_ops,
+		.pm	= pm_sleep_ptr(&tcs3472_pm_ops),
 	},
 	.probe		= tcs3472_probe,
 	.remove		= tcs3472_remove,
-- 
2.34.1


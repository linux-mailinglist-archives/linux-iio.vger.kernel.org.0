Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01B14A3892
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiA3T0O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36042 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355904AbiA3T0N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 645F3612EC
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEB4C340EF;
        Sun, 30 Jan 2022 19:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570772;
        bh=BnANxcBt51ZAuShungESptRElbJqEWGEP6JtV+EBrsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hm+VHPGeqUiFE558653oT4c36KRKtDSxYWC5p0MaDDGUpaLY/MMJAL/2U/kt2nvv8
         YofaE5osbDFx9o39yfsOMNBwEX93Yn844mALnrTDaIusGwVXoAXygFAf8S3umYlVhq
         fw2AHyUN2WCQtCZm7iLlCuMerjZ/olHNc5TarGsrORrL3+DWH9vOrGm12XxiIOtBqH
         JAT8xt0Zzam9a9ljFXFUdJFXmhGkNnX2qANrn53MfSVUrjY8P495WENVfw40Q+NJMv
         VEuUA9ttC+uwTUXFslpckRcceg8C5ypjjkoZwsQC8CUIojj1Fy0j6OTBZ5EFdKsMjj
         4nhFdDRMda6gw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 18/50] iio:light:apds9300: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:15 +0000
Message-Id: <20220130193147.279148-19-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130193147.279148-1-jic23@kernel.org>
References: <20220130193147.279148-1-jic23@kernel.org>
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
 drivers/iio/light/apds9300.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index baaf202dce05..0f9d77598997 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -466,7 +466,6 @@ static int apds9300_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int apds9300_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -493,11 +492,8 @@ static int apds9300_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(apds9300_pm_ops, apds9300_suspend, apds9300_resume);
-#define APDS9300_PM_OPS (&apds9300_pm_ops)
-#else
-#define APDS9300_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(apds9300_pm_ops, apds9300_suspend,
+				apds9300_resume);
 
 static const struct i2c_device_id apds9300_id[] = {
 	{ APDS9300_DRV_NAME, 0 },
@@ -509,7 +505,7 @@ MODULE_DEVICE_TABLE(i2c, apds9300_id);
 static struct i2c_driver apds9300_driver = {
 	.driver = {
 		.name	= APDS9300_DRV_NAME,
-		.pm	= APDS9300_PM_OPS,
+		.pm	= pm_sleep_ptr(&apds9300_pm_ops),
 	},
 	.probe		= apds9300_probe,
 	.remove		= apds9300_remove,
-- 
2.35.1


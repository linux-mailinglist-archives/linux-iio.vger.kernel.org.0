Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56342482B22
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiABMvD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiABMvD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D36AC061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:51:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAE38B80D61
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC2CC36AF0;
        Sun,  2 Jan 2022 12:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127860;
        bh=f0rZhwLDQvWiN8GiNtPw4ETQwa+5czed31gj7xg2GJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPwMw8i6eejKFo92CKhkU0+90M5Xx3V46KcQ1vg+sdMehPruU4fYBA5xV2bGmwuhm
         EtBAJDcceJt1rVjmjJ/FJbwS1k1VAivTY7jsrFHb+1BeJTYlnPNNWmZrPYL1r2Vq4/
         mhaGazGt+rX5fDXe3xY14rP6o0FNPht7fF9NmuCXpWO+lubE1HqwvJmdEI2i/3UDnP
         xPZsKMKTnczRgDzqmjf9Kkm48TGCAhTFBvPV+8idMNuK7lvlK6ry7UziOzo9KMIaZo
         P3Dz4MDzcAOjNoTTFDVC9jcjX3SUYmjil/ENIayKbaszGnWKvKOy6ue8yCo1F25Zdr
         C7JEcZXFKmryg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 03/51] iio:accel:dmard06: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:29 +0000
Message-Id: <20220102125617.1259804-4-jic23@kernel.org>
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
 drivers/iio/accel/dmard06.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
index de2868c28d95..ab9cd6a5369b 100644
--- a/drivers/iio/accel/dmard06.c
+++ b/drivers/iio/accel/dmard06.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/compiler.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
@@ -170,7 +171,6 @@ static int dmard06_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dmard06_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -199,11 +199,7 @@ static int dmard06_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(dmard06_pm_ops, dmard06_suspend, dmard06_resume);
-#define DMARD06_PM_OPS (&dmard06_pm_ops)
-#else
-#define DMARD06_PM_OPS NULL
-#endif
+DEFINE_SIMPLE_DEV_PM_OPS(dmard06_pm_ops, dmard06_suspend, dmard06_resume);
 
 static const struct i2c_device_id dmard06_id[] = {
 	{ "dmard05", 0 },
@@ -227,7 +223,7 @@ static struct i2c_driver dmard06_driver = {
 	.driver = {
 		.name = DMARD06_DRV_NAME,
 		.of_match_table = dmard06_of_match,
-		.pm = DMARD06_PM_OPS,
+		.pm = pm_sleep_ptr(&dmard06_pm_ops),
 	},
 };
 module_i2c_driver(dmard06_driver);
-- 
2.34.1


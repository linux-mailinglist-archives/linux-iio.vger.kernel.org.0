Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875CE4A3881
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355865AbiA3TZj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:25:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51362 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355830AbiA3TZi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:25:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB78BB829AA
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A755BC340EB;
        Sun, 30 Jan 2022 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570736;
        bh=1UtJ/ZaZV8SOwmxfvLb0zyiYkCQip8BtNomzd6o1QVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvwDHX53NOBlC5w7QD2LDz95NteSzuiJgbs92YB3IjKh5NV+EW0vO/Ln6+T5BQzHg
         25Why6FNJQz/VQ61skGg0muGFqciYpwTnHduF7SfRFKYl4/JJdoz7LMGiCAFqlvQAA
         zBMjvxdNP2g/LRCzOJyhV4b8GQRkzI+ZB72Kf2fKNEwBJP+RnszcC3UncLWY2G8hVx
         0ECT29Oky9H9pxX6YmeaLGM1Kr32k2UELsCRY8tZyhkMSxzWivMiC3ifD5OTfYZbLh
         A07+cS45Yk1vmvlCUIuBpvxMU4jWcJquEmKJhW+eLiSfG98XzlHifzbj/01IUTiXyM
         FHhvkVfkdadDA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 01/50] iio:accel:da311: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:30:58 +0000
Message-Id: <20220130193147.279148-2-jic23@kernel.org>
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
 drivers/iio/accel/da311.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
index 04e13487e706..ec4e29d260f7 100644
--- a/drivers/iio/accel/da311.c
+++ b/drivers/iio/accel/da311.c
@@ -256,7 +256,6 @@ static int da311_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int da311_suspend(struct device *dev)
 {
 	return da311_enable(to_i2c_client(dev), false);
@@ -266,9 +265,8 @@ static int da311_resume(struct device *dev)
 {
 	return da311_enable(to_i2c_client(dev), true);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resume);
 
 static const struct i2c_device_id da311_i2c_id[] = {
 	{"da311", 0},
@@ -279,7 +277,7 @@ MODULE_DEVICE_TABLE(i2c, da311_i2c_id);
 static struct i2c_driver da311_driver = {
 	.driver = {
 		.name = "da311",
-		.pm = &da311_pm_ops,
+		.pm = pm_sleep_ptr(&da311_pm_ops),
 	},
 	.probe		= da311_probe,
 	.id_table	= da311_i2c_id,
-- 
2.35.1


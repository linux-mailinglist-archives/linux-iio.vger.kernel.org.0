Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CC94A3883
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355881AbiA3TZo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:25:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35762 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355869AbiA3TZn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:25:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB4A612EC
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855A9C340EB;
        Sun, 30 Jan 2022 19:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570743;
        bh=6EDm6IJMdRbzGeW+hstHVokDqL96T67GjhUf8JziKZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dGOtUTTEy2DdfP86nNADp4SEpCad8eqtMcDZ2+93fGSJqsDCIKoibD6KJn1nUBJ01
         XznDk+bLeNsXIUzSRf3e3d3xDQb7BR/+H+cN36FwdFE7tR4ZdcqCFhRORT7fWt0ORE
         ErYjbybfeXZ79YEyEfq2NzQSBkZKAnM5uMrp6tuo4fjbUFemIrBPMPc1I3FjlT9TzG
         i+cSicpnWtTQDQI+zkK1n4wIF8COblEzQhsUzB08dhvjU1szXwROINLMuaTvR4UQQ9
         FWB9+4Sw+tqp+cy3FUpPHrQZJol8HD5SyaWkhMToiGAqj65m6VTOv9kafj24gEseUI
         0awcAbHKcCFvA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 04/50] iio:accel:dmard10: Switch from CONFIG_PM guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:01 +0000
Message-Id: <20220130193147.279148-5-jic23@kernel.org>
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
 drivers/iio/accel/dmard10.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index f9f173eec202..8ac62ec0a04a 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -218,7 +218,6 @@ static int dmard10_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dmard10_suspend(struct device *dev)
 {
 	return dmard10_shutdown(to_i2c_client(dev));
@@ -228,9 +227,9 @@ static int dmard10_resume(struct device *dev)
 {
 	return dmard10_reset(to_i2c_client(dev));
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(dmard10_pm_ops, dmard10_suspend, dmard10_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(dmard10_pm_ops, dmard10_suspend,
+				dmard10_resume);
 
 static const struct i2c_device_id dmard10_i2c_id[] = {
 	{"dmard10", 0},
@@ -241,7 +240,7 @@ MODULE_DEVICE_TABLE(i2c, dmard10_i2c_id);
 static struct i2c_driver dmard10_driver = {
 	.driver = {
 		.name = "dmard10",
-		.pm = &dmard10_pm_ops,
+		.pm = pm_sleep_ptr(&dmard10_pm_ops),
 	},
 	.probe		= dmard10_probe,
 	.id_table	= dmard10_i2c_id,
-- 
2.35.1


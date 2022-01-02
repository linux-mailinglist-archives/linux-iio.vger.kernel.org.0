Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90988482B20
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiABMu6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiABMu5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:50:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919A4C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:50:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 326BD60E9A
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7E3C36AF2;
        Sun,  2 Jan 2022 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127855;
        bh=GGLKlY71b9znJlNqlXiFzrK38BHRaq5JEPG1QTp+wf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryRywvqR7GNTcdNhjLOFiZWdQKWxqNnMtn0M3kwQzpbPMeYk3HXu+K5zA35Wg9kJK
         fujXt1Fc/ClIYYyeg+x6D0P9be3WfwyHzhCxAKXfGS1xlEz/gvu7HHA4zqenJADbj1
         JI9mE4mjuoEeHOuKOpduKBPsKRUp+E3zK20P4yXAGpFYMeE8oXenF4xlee2xL8L4gW
         Y1Z+uAhkDvh1s19rG+Y9gYoknK6DLRJGOdlds69yjocolYUlteWPdMiNVaKu2WLzg4
         FYPvUJVrKSDTk+DwuQPSSAXxFuT9gu9LPb04bJGMbTHHzteBStQpGtiJygD1+4QGKL
         7bw7HwUARN4Ow==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 01/51] iio:accel:da311: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:27 +0000
Message-Id: <20220102125617.1259804-2-jic23@kernel.org>
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
 drivers/iio/accel/da311.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
index 04e13487e706..a239ec5b5089 100644
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
+DEFINE_SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resume);
 
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
2.34.1


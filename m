Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA144A389E
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355939AbiA3T0m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355936AbiA3T0j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C767DC06173B
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:26:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67A56612EE
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5647EC340F0;
        Sun, 30 Jan 2022 19:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570798;
        bh=9niVJijj33UjpFrdTlQ01Cn4CCg7BYi1vJKPUjLJs9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNYvpLTtMO+RrplxjoFcCoNmgF9/miETmbEYImuu0IL589GO4uDXEvtwSjf0+54JF
         7bj64n29+RmF8JuC4YU7m+0VVkdfhOSSuN6XeuizHucEd03DwKrPTok5qfn67G+k8Y
         dA5kMyf2uLQPF5ZumcLt07fORHRCYyykz6BAGD/dU3GYebnJfDI6VGkm3y+rJNswXS
         o5sRwL/GqLt8ZXkPP8oYlEEJjEY6DUsqbR0l+lagtI8Cqfhp7Mm3v/o6dfP6jceXBp
         gu57ieVAQaPuWJXPDdsTfuavI3JZSiPZMRbDcddrQwsVmlUmLxr/7ZCB6kwgl8NScC
         3OYvnBnx8bqIQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 30/50] iio:magn:mag3110: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:27 +0000
Message-Id: <20220130193147.279148-31-jic23@kernel.org>
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
 drivers/iio/magnetometer/mag3110.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 17c62d806218..226439d0bfb5 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -573,7 +573,6 @@ static int mag3110_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mag3110_suspend(struct device *dev)
 {
 	struct mag3110_data *data = iio_priv(i2c_get_clientdata(
@@ -623,11 +622,8 @@ static int mag3110_resume(struct device *dev)
 		data->ctrl_reg1);
 }
 
-static SIMPLE_DEV_PM_OPS(mag3110_pm_ops, mag3110_suspend, mag3110_resume);
-#define MAG3110_PM_OPS (&mag3110_pm_ops)
-#else
-#define MAG3110_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(mag3110_pm_ops, mag3110_suspend,
+				mag3110_resume);
 
 static const struct i2c_device_id mag3110_id[] = {
 	{ "mag3110", 0 },
@@ -645,7 +641,7 @@ static struct i2c_driver mag3110_driver = {
 	.driver = {
 		.name	= "mag3110",
 		.of_match_table = mag3110_of_match,
-		.pm	= MAG3110_PM_OPS,
+		.pm	= pm_sleep_ptr(&mag3110_pm_ops),
 	},
 	.probe = mag3110_probe,
 	.remove = mag3110_remove,
-- 
2.35.1


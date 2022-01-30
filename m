Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC7C4A3899
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355937AbiA3T0e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51666 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355914AbiA3T0a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29E13B829AA
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C252C340F0;
        Sun, 30 Jan 2022 19:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570788;
        bh=FxY+g7LKhZ3hfNAOgLMeGLxlhmrPrlkW9IVSEU+FDIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQYhk9MjfYW8+da9OcJMUJyh+oQ1SJskbGfYPJer/v6m29uu4ADlDSTUxSbVUzrBn
         d8cVi7Kz7sO3RBLDSm4kxebD74gBZlFPlgKHxbdkozrZdsgLMJsIdtIN5rSK4XqILZ
         Mrrpyrp4vNHcoa/G9WKM1jEcuUXubumJ9a8S3PpOkLHM59cDt5XslUl/AKCgRbxvjN
         q4IvffIQIybCc6yPQPj/IvkeZpMHoy7o4TeQI4lh4HsQJM62OAwdpU7yc5q0V4ix9Z
         ZrvlrN6DspDcwV9ntO083iQPalXA6++wsQ0WbCrh70Jy41S5TEuteB6bGB9CkU7y57
         lrGYQ/7q2S3ww==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 25/50] iio:light:tcs3414: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:22 +0000
Message-Id: <20220130193147.279148-26-jic23@kernel.org>
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
 drivers/iio/light/tcs3414.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index b87222141429..3951536022b3 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -345,7 +345,6 @@ static int tcs3414_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tcs3414_suspend(struct device *dev)
 {
 	struct tcs3414_data *data = iio_priv(i2c_get_clientdata(
@@ -360,9 +359,9 @@ static int tcs3414_resume(struct device *dev)
 	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
 		data->control);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(tcs3414_pm_ops, tcs3414_suspend, tcs3414_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(tcs3414_pm_ops, tcs3414_suspend,
+				tcs3414_resume);
 
 static const struct i2c_device_id tcs3414_id[] = {
 	{ "tcs3414", 0 },
@@ -373,7 +372,7 @@ MODULE_DEVICE_TABLE(i2c, tcs3414_id);
 static struct i2c_driver tcs3414_driver = {
 	.driver = {
 		.name	= TCS3414_DRV_NAME,
-		.pm	= &tcs3414_pm_ops,
+		.pm	= pm_sleep_ptr(&tcs3414_pm_ops),
 	},
 	.probe		= tcs3414_probe,
 	.id_table	= tcs3414_id,
-- 
2.35.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BEE4A38A2
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355947AbiA3T1E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51788 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355948AbiA3T0v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A507B829AB
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59720C340F0;
        Sun, 30 Jan 2022 19:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570808;
        bh=rtGOhhdzD+LUzMFwpwxVa0UpJtDUmyYavEfyS6k/r/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hDrb7TZ+rsghkaeC6uaWzKsHIUZAFYTFzBd4WhVcC/aAVmDnJ3VfBAOmGRdED3nVC
         8NefCb16lqxXUHHXiLa7GAyE1GdmcdwagN+3qrSB0GW2xVB+Xm5hBMkl7/XLi7V/VL
         LWj25P5RPkzdoe5N1xl1Hbh5SnrqnbZD6sYaD574wOEf6hGW9rtiHoiG5rA0JS+GGR
         HzghDHy8t2qZbAEjLauhbopSF5OdGO2OiChhDu/dkrptOJe8lgbayE3YV52htim3p/
         fwng1A3L4PIf1AWGdYsqOkgSRgGJIhZTUrLRKuhnOeWtkwtKzB7nTJjFDy7EOdPJmq
         lWLb0NArEnJiQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 34/50] iio:proximity:rfd77492: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:31 +0000
Message-Id: <20220130193147.279148-35-jic23@kernel.org>
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
 drivers/iio/proximity/rfd77402.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 0ae91963b570..cb80b3c9d073 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -295,7 +295,6 @@ static int rfd77402_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int rfd77402_suspend(struct device *dev)
 {
 	return rfd77402_powerdown(to_i2c_client(dev));
@@ -305,9 +304,9 @@ static int rfd77402_resume(struct device *dev)
 {
 	return rfd77402_init(to_i2c_client(dev));
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(rfd77402_pm_ops, rfd77402_suspend, rfd77402_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(rfd77402_pm_ops, rfd77402_suspend,
+				rfd77402_resume);
 
 static const struct i2c_device_id rfd77402_id[] = {
 	{ "rfd77402", 0 },
@@ -318,7 +317,7 @@ MODULE_DEVICE_TABLE(i2c, rfd77402_id);
 static struct i2c_driver rfd77402_driver = {
 	.driver = {
 		.name   = RFD77402_DRV_NAME,
-		.pm     = &rfd77402_pm_ops,
+		.pm     = pm_sleep_ptr(&rfd77402_pm_ops),
 	},
 	.probe  = rfd77402_probe,
 	.id_table = rfd77402_id,
-- 
2.35.1


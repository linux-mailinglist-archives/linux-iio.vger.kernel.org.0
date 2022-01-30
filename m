Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689324A3884
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355830AbiA3TZp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355878AbiA3TZo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:25:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4234C06173B
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:25:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4580AB829AB
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B43AC340EF;
        Sun, 30 Jan 2022 19:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570741;
        bh=4uHgsMIuhyxzLZW+KbJu7whKpIc+9p10mFJG9h4C2sU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tt4apVDTZC0AALLDTUiBdOZuaaJ7t2wZoVmvW0pYEJXgn9w1uU4/sEt74ux32LhoN
         z6AtGOr8jSv+WV6LrqcwIfttM/X/IehNg5gbmN1BP7Bz2liMU3PdUxscg7oDuzfBeq
         NQIg5jq3DQU5pxsgop8Gqmr/Qp5hPa/+V6iseRpXX3DsgLlc+ufvZjiJN/BwhmRHcL
         BS1kGWsJ4WXBnVlp3awgI3wFiFUg0zE4Yzdu02bStxKUeWOoM3mEvTlOmQWDUZJMyR
         6z0RBm/G41bEDPnDuNiDOWhwWkuSVZScnWCPMdTqfkyk+cWQQBZyQY/2tYPCBtwDsd
         3ktlfS7UTc87w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 03/50] iio:accel:dmard06: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:00 +0000
Message-Id: <20220130193147.279148-4-jic23@kernel.org>
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
 drivers/iio/accel/dmard06.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
index de2868c28d95..4b69c8530f5e 100644
--- a/drivers/iio/accel/dmard06.c
+++ b/drivers/iio/accel/dmard06.c
@@ -170,7 +170,6 @@ static int dmard06_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dmard06_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -199,11 +198,8 @@ static int dmard06_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(dmard06_pm_ops, dmard06_suspend, dmard06_resume);
-#define DMARD06_PM_OPS (&dmard06_pm_ops)
-#else
-#define DMARD06_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(dmard06_pm_ops, dmard06_suspend,
+				dmard06_resume);
 
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
2.35.1


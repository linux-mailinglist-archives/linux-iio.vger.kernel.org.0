Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300EE3A478B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFKROM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhFKROL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:14:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CCC2613D3;
        Fri, 11 Jun 2021 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431533;
        bh=Bor6MdOhk4NxRancSRh1CNhzkAeiiPyTTJF3RyUXjv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hf8WCR8KkGjj8OB+wqzn8oVJEjzo66dfbnKwM+qpiTcZ+mLZDZoxSKdhuhwgBWLOc
         9bFRzwIhGIY3Q02+F/Fj00A+Q0JinPSMn7rLMN3pGsKztptsAbrBSMQjx2BZZPmD4m
         fgrfUGKfTZxIYVJxxcTH2bJeteqXOHq+31ZHisIYA5tn1Y8w/t/VNzHPS1qghEXhAa
         NaD27zfAfd4NavRf1hgGD6yaA0XOzJWk9uvDyGS1hwDYewOo3i4NOofpzYwUG/H9tb
         3AQqQMXtoJFJOfNfazpMqwirx7jd8q5oQgZKYHjFBamQPOeSfhU71+Nj3goOn7C0dx
         M43eCxmnq8H6w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 02/12] iio:accel:bma180: Use generic device properties.
Date:   Fri, 11 Jun 2021 18:13:44 +0100
Message-Id: <20210611171355.202903-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611171355.202903-1-jic23@kernel.org>
References: <20210611171355.202903-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst doing header cleanup I noticed this driver makes very superficial
use of of_* interfaces.  Hence move to the generic firmware forms.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Bakker <xc-racer2@live.ca>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/bma180.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 4a07e60c0e21..0e0d9317c084 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -17,8 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/of_device.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/bitops.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -995,8 +994,8 @@ static int bma180_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
-	if (client->dev.of_node)
-		chip = (enum chip_ids)of_device_get_match_data(dev);
+	if (dev_fwnode(dev))
+		chip = (enum chip_ids)device_get_match_data(dev);
 	else
 		chip = id->driver_data;
 	data->part_info = &bma180_part_info[chip];
-- 
2.31.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60F2460801
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 18:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358705AbhK1RZ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 12:25:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35740 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358888AbhK1RX2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 12:23:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD85FB80B55
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 17:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4ADC53FCB;
        Sun, 28 Nov 2021 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638120010;
        bh=/agjTQvjlvaF4+MzG+LGqkSrqQ1WyOJe5RYL+5DmPxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E243GRITY/81tkPyCEqIbo4TFHiw6sQSKyg0eAL7eeTcbm1fA+wyVRUR/4dgv9t65
         AbLN06GgeyY12022t2UqPTN6uT/TK9BdAlDx9my65l/fDQ0K5YjchN0+dZwk9UR6VB
         tPXwmgDHuQ/a6QCDTHzDrm+c8SmywAFdmgVD2bFwP3plY2xmxVK0NpxKceUt3osMHL
         uNwCeHzEWop7oRxRYJ1xgS43RwhcvShSYsdteIP7LPrJvgzLuJxQ0Lpb0z7h07cdZi
         n5vFUMu01Vl5fQg9cBEnSgHtfURYiCfHJSHOuPFnqhGkV0OJqd/E+QHfy8QSuT92uw
         BjlmKoHL2T3tg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Baptiste Mansuy <bmansuy@invensense.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/12] iio:imu:inv_mpu6050: Suppress clang W=1 warning about pointer to enum conversion.
Date:   Sun, 28 Nov 2021 17:24:41 +0000
Message-Id: <20211128172445.2616166-9-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128172445.2616166-1-jic23@kernel.org>
References: <20211128172445.2616166-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Cast to a uintptr_t rather than directly to the enum.

As per the discussion in below linked media patch.

Link: https://lore.kernel.org/linux-media/CAK8P3a2ez6nEw4d+Mqa3XXAz0RFTZHunqqRj6sCt7Y_Eqqs0rw@mail.gmail.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Baptiste Mansuy <bmansuy@invensense.com>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 3ef17e3f50e2..fe03707ec2d3 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -110,7 +110,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 
 	match = device_get_match_data(&client->dev);
 	if (match) {
-		chip_type = (enum inv_devices)match;
+		chip_type = (uintptr_t)match;
 		name = client->name;
 	} else if (id) {
 		chip_type = (enum inv_devices)
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index b056f3fe2561..6800356b25fb 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -45,7 +45,7 @@ static int inv_mpu_probe(struct spi_device *spi)
 		chip_type = (enum inv_devices)spi_id->driver_data;
 		name = spi_id->name;
 	} else if ((match = device_get_match_data(&spi->dev))) {
-		chip_type = (enum inv_devices)match;
+		chip_type = (uintptr_t)match;
 		name = dev_name(&spi->dev);
 	} else {
 		return -ENODEV;
-- 
2.34.1


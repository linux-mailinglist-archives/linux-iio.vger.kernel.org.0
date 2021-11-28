Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47B8460800
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 18:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346302AbhK1RZZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 12:25:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56294 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358876AbhK1RXY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 12:23:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75DD56103E
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 17:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AF6C53FC1;
        Sun, 28 Nov 2021 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638120007;
        bh=FRoGdIkDAOyOmcuRcysS449DkfmSWLO81MnDGGwXteY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0C9agFJpDx2Msw5ZAnHd44eecqiiIDSm0qabItl9ythKAfHssQ+lGgCjGcHuttVe
         /KGSNImLLLg6lMJOLv1vHvUrxCZItXgZ94BmTZDwh9QqPWS18O5yQzuiuAkkShdYl3
         BdaEqWGBgIRzgbwM9m7bvbEb2fMEyP+xs204e4gUFcZEN/mfsQm1ZBDR1Er6MJDN13
         g227En0DGfDNTcKg0HpZca22HVW5QIxiShlSHq98F0bKpRNrgb4MZRS7pI32+c+lIn
         tBemCEuRZIw9r/HCfoq/SuIDMIit1m24l8IV8ZGy/sUd2aKAjbcoucvD6INSZWSpKv
         p1+dtaSM0+mRA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 07/12] iio:imu:inv_icm42600: Suppress clang W=1 warning about pointer to enum conversion.
Date:   Sun, 28 Nov 2021 17:24:40 +0000
Message-Id: <20211128172445.2616166-8-jic23@kernel.org>
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
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index 85b1934cec60..33d9afb1ba91 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -58,7 +58,7 @@ static int inv_icm42600_probe(struct i2c_client *client)
 	match = device_get_match_data(&client->dev);
 	if (!match)
 		return -EINVAL;
-	chip = (enum inv_icm42600_chip)match;
+	chip = (uintptr_t)match;
 
 	regmap = devm_regmap_init_i2c(client, &inv_icm42600_regmap_config);
 	if (IS_ERR(regmap))
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 323789697a08..e6305e5fa975 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -57,7 +57,7 @@ static int inv_icm42600_probe(struct spi_device *spi)
 	match = device_get_match_data(&spi->dev);
 	if (!match)
 		return -EINVAL;
-	chip = (enum inv_icm42600_chip)match;
+	chip = (uintptr_t)match;
 
 	regmap = devm_regmap_init_spi(spi, &inv_icm42600_regmap_config);
 	if (IS_ERR(regmap))
-- 
2.34.1


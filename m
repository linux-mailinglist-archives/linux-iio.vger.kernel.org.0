Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFE56ABDB5
	for <lists+linux-iio@lfdr.de>; Mon,  6 Mar 2023 12:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCFLIh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Mar 2023 06:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCFLIh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2023 06:08:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE38CEF99;
        Mon,  6 Mar 2023 03:08:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A66B60DF3;
        Mon,  6 Mar 2023 11:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4852CC433EF;
        Mon,  6 Mar 2023 11:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678100914;
        bh=v5nzudHHd/R/CJTchkPC7uDf81TrkpR6VaBBytf0a9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtvXsCe5ZBl92jzGjPwrEdNOBMMZceVScOVJXPoy4GNNBRfepvzufk+WcEXmBDFer
         RpE2vggTYorkgFsk0Ch2Z/d8ko2jqEIR/i9NLpqZ4hlX6AmhYFQ9D/+tp3MpesGYb1
         kS7UrS9qNLi4NCm3vNEVwiZnBfsFi/QYEwR7da+8AMGRj6K3acJDutAs2b+p7UDeuN
         y1+ps8omq0RcKnRPoE6Hk1Ry3LZvXNrc6QbxD9W8PV9XsNT43uzu8h75CnFNRhD/CL
         WXVaZyy8hhAMtIFxgi7oQ8LCXXubRGW+XVaGMoa3AF5r+wro7iAAkniwuzKvZ1v8LJ
         8NbAmBlEwtnNg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to ASM330LHB
Date:   Mon,  6 Mar 2023 12:08:00 +0100
Message-Id: <a1d675457da7aa9e979d8cabea410e942e015e71.1678100533.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678100533.git.lorenzo@kernel.org>
References: <cover.1678100533.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to STM ASM330LHB (acc + gyro) automotive Mems sensor.
The ASM330LHB sensor can use ASM330LHH as fallback device since it
implements all the ASM330LHB features currently implemented in
st_lsm6dsx.

Datasheet: https://www.st.com/resource/en/datasheet/asm330lhb.pdf
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig             | 4 ++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 4 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    | 5 +++++
 6 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index f6660847fb58..caa82ba6fce5 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -13,8 +13,8 @@ config IIO_ST_LSM6DSX
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
 	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx, lsm6dsr,
 	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, lsm6dstx,
-	  lsm6dsv, lsm6dsv16x, lsm6dso16is, ism330is, lsm6dst and the
-	  accelerometer/gyroscope of lsm9ds1.
+	  lsm6dsv, lsm6dsv16x, lsm6dso16is, ism330is, asm330lhb, lsm6dst
+	  and the accelerometer/gyroscope of lsm9ds1.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm6dsx.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 8e119d78730b..9dfe4917a386 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -37,6 +37,7 @@
 #define ST_LSM6DSV16X_DEV_NAME	"lsm6dsv16x"
 #define ST_LSM6DSO16IS_DEV_NAME	"lsm6dso16is"
 #define ST_ISM330IS_DEV_NAME	"ism330is"
+#define ST_ASM330LHB_DEV_NAME	"asm330lhb"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID,
@@ -61,6 +62,7 @@ enum st_lsm6dsx_hw_id {
 	ST_LSM6DSV16X_ID,
 	ST_LSM6DSO16IS_ID,
 	ST_ISM330IS_ID,
+	ST_ASM330LHB_ID,
 	ST_LSM6DSX_MAX_ID,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index f6c11d6fb0b0..066fe561c5e8 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -15,7 +15,7 @@
  * value of the decimation factor and ODR set for each FIFO data set.
  *
  * LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/LSM6DSRX/ISM330DHCX/
- * LSM6DST/LSM6DSOP/LSM6DSTX/LSM6DSV:
+ * LSM6DST/LSM6DSOP/LSM6DSTX/LSM6DSV/ASM330LHB:
  * The FIFO buffer can be configured to store data from gyroscope and
  * accelerometer. Each sample is queued with a tag (1B) indicating data
  * source (gyroscope, accelerometer, hw timer).
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 966df6ffe874..455e5edd3a80 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1032,6 +1032,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.hw_id = ST_LSM6DSOP_ID,
 				.name = ST_LSM6DSOP_DEV_NAME,
 				.wai = 0x6c,
+			}, {
+				.hw_id = ST_ASM330LHB_ID,
+				.name = ST_ASM330LHB_DEV_NAME,
+				.wai = 0x6b,
 			},
 		},
 		.channels = {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index df5f60925260..ccdc4ceffd85 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -125,6 +125,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,ism330is",
 		.data = (void *)ST_ISM330IS_ID,
 	},
+	{
+		.compatible = "st,asm330lhb",
+		.data = (void *)ST_ASM330LHB_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
@@ -152,6 +156,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_LSM6DSV16X_DEV_NAME, ST_LSM6DSV16X_ID },
 	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
 	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
+	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 974584bda875..f56c170c41a9 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -125,6 +125,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,ism330is",
 		.data = (void *)ST_ISM330IS_ID,
 	},
+	{
+		.compatible = "st,asm330lhb",
+		.data = (void *)ST_ASM330LHB_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
@@ -152,6 +156,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_LSM6DSV16X_DEV_NAME, ST_LSM6DSV16X_ID },
 	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
 	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
+	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
-- 
2.39.2


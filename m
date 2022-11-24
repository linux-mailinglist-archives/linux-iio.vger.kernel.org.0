Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D370463746B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Nov 2022 09:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiKXItp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Nov 2022 03:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKXItn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2022 03:49:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14107CFA47;
        Thu, 24 Nov 2022 00:49:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C4F362028;
        Thu, 24 Nov 2022 08:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B349C433D6;
        Thu, 24 Nov 2022 08:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669279782;
        bh=S66AhnvTdmAWqY3RJs/70AMerc47/gGcTbaNAaFKtk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmfHvSLeKiTCEf6TCZMWARlbyU/TuS4z9ySwMBSiusg0N6ZGfIUohQBEM76uB2thJ
         QZuqdvMmV+6gYsMvoTVwMvPrQeCk7NXVIElPPSaWRUfBPE9ipW82gQbjeKGynGfYkW
         188zpN66weTCgQJiUMvXthcO10qbSdTDjOXrizAODVdXTIJuuavV9arfbxPH5oFY+r
         Sih5Tmue8QLxcJTyiSRiRivToZbIqt3+ajCfEG26XG4u2rYSUQqBNjXfE1qv8uqVBe
         cJ6gIEQRSRkg8GwdsTXkeZ2PnDuC9zli+pSpSC0lmzUkotMl644yEBt7rt7kzHhgMr
         Dv86a2I3Sqrgw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     mario.tesi@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.bianconi@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to ISM330IS
Date:   Thu, 24 Nov 2022 09:49:27 +0100
Message-Id: <4cd1614060e06f49cd92f5930d8fd40117c07920.1669279604.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669279604.git.lorenzo@kernel.org>
References: <cover.1669279604.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to STM ISM330IS (accelerometer and gyroscope) Mems sensor.
The ISM330IS sensor can use LSM6DSO16IS as fallback device since it
implements all the ISM330IS features currently implemented in
st_lsm6dsx.

Datasheet: https://www.st.com/resource/en/datasheet/ism330is.pdf
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig           | 4 ++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 8 ++++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  | 5 +++++
 5 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 0096035728cd..f6660847fb58 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -13,8 +13,8 @@ config IIO_ST_LSM6DSX
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
 	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx, lsm6dsr,
 	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, lsm6dstx,
-	  lsm6dsv, lsm6dsv16x, lsm6dso16is, the accelerometer/gyroscope
-	  of lsm9ds1 and lsm6dst.
+	  lsm6dsv, lsm6dsv16x, lsm6dso16is, ism330is, lsm6dst and the
+	  accelerometer/gyroscope of lsm9ds1.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm6dsx.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index abf14a2ce0e9..5b6f195748fc 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -36,6 +36,7 @@
 #define ST_LSM6DSV_DEV_NAME	"lsm6dsv"
 #define ST_LSM6DSV16X_DEV_NAME	"lsm6dsv16x"
 #define ST_LSM6DSO16IS_DEV_NAME	"lsm6dso16is"
+#define ST_ISM330IS_DEV_NAME	"ism330is"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID,
@@ -59,6 +60,7 @@ enum st_lsm6dsx_hw_id {
 	ST_LSM6DSV_ID,
 	ST_LSM6DSV16X_ID,
 	ST_LSM6DSO16IS_ID,
+	ST_ISM330IS_ID,
 	ST_LSM6DSX_MAX_ID,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 57a79bf35bba..3f6060c64f32 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -27,7 +27,7 @@
  *   - FIFO size: 4KB
  *
  * - LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/ISM330DHCX/LSM6DST/LSM6DSOP/
- *   LSM6DSTX/LSM6DSO16IS:
+ *   LSM6DSTX/LSM6DSO16IS/ISM330IS:
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416,
  *     833
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
@@ -1393,7 +1393,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.hw_id = ST_LSM6DSO16IS_ID,
 				.name = ST_LSM6DSO16IS_DEV_NAME,
 				.wai = 0x22,
-			},
+			}, {
+				.hw_id = ST_ISM330IS_ID,
+				.name = ST_ISM330IS_DEV_NAME,
+				.wai = 0x22,
+			}
 		},
 		.channels = {
 			[ST_LSM6DSX_ID_ACC] = {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index c34ccc85e4c7..df5f60925260 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -121,6 +121,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,lsm6dso16is",
 		.data = (void *)ST_LSM6DSO16IS_ID,
 	},
+	{
+		.compatible = "st,ism330is",
+		.data = (void *)ST_ISM330IS_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
@@ -147,6 +151,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_LSM6DSV_DEV_NAME, ST_LSM6DSV_ID },
 	{ ST_LSM6DSV16X_DEV_NAME, ST_LSM6DSV16X_ID },
 	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
+	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 24d5e51a8662..974584bda875 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -121,6 +121,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,lsm6dso16is",
 		.data = (void *)ST_LSM6DSO16IS_ID,
 	},
+	{
+		.compatible = "st,ism330is",
+		.data = (void *)ST_ISM330IS_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
@@ -147,6 +151,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_LSM6DSV_DEV_NAME, ST_LSM6DSV_ID },
 	{ ST_LSM6DSV16X_DEV_NAME, ST_LSM6DSV16X_ID },
 	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
+	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
-- 
2.38.1


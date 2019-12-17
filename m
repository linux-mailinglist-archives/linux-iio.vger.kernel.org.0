Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A844F12333A
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 18:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfLQRKm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 12:10:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:63803 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfLQRKm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Dec 2019 12:10:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 09:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="212633812"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 17 Dec 2019 09:10:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 36C9312A; Tue, 17 Dec 2019 19:10:38 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: [PATCH v1] iio: st_gyro: Correct data for LSM9DS0 gyro
Date:   Tue, 17 Dec 2019 19:10:38 +0200
Message-Id: <20191217171038.17004-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The commit 41c128cb25ce ("iio: st_gyro: Add lsm9ds0-gyro support")
assumes that gyro in LSM9DS0 is the same as others with 0xd4 WAI ID,
but datasheet tells slight different story, i.e. the first scale factor
for the chip is 245 dps, and not 250 dps.

Correct this by introducing a separate settings for LSM9DS0.

Fixes: 41c128cb25ce ("iio: st_gyro: Add lsm9ds0-gyro support")
Depends-on: 45a4e4220bf4 ("iio: gyro: st_gyro: fix L3GD20H support")
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/gyro/st_gyro_core.c | 75 ++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 57be68b291fa..26c50b24bc08 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -138,7 +138,6 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 			[2] = LSM330DLC_GYRO_DEV_NAME,
 			[3] = L3G4IS_GYRO_DEV_NAME,
 			[4] = LSM330_GYRO_DEV_NAME,
-			[5] = LSM9DS0_GYRO_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_gyro_16bit_channels,
 		.odr = {
@@ -208,6 +207,80 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
+	{
+		.wai = 0xd4,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = LSM9DS0_GYRO_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_gyro_16bit_channels,
+		.odr = {
+			.addr = 0x20,
+			.mask = GENMASK(7, 6),
+			.odr_avl = {
+				{ .hz = 95, .value = 0x00, },
+				{ .hz = 190, .value = 0x01, },
+				{ .hz = 380, .value = 0x02, },
+				{ .hz = 760, .value = 0x03, },
+			},
+		},
+		.pw = {
+			.addr = 0x20,
+			.mask = BIT(3),
+			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = 0x23,
+			.mask = GENMASK(5, 4),
+			.fs_avl = {
+				[0] = {
+					.num = ST_GYRO_FS_AVL_245DPS,
+					.value = 0x00,
+					.gain = IIO_DEGREE_TO_RAD(8750),
+				},
+				[1] = {
+					.num = ST_GYRO_FS_AVL_500DPS,
+					.value = 0x01,
+					.gain = IIO_DEGREE_TO_RAD(17500),
+				},
+				[2] = {
+					.num = ST_GYRO_FS_AVL_2000DPS,
+					.value = 0x02,
+					.gain = IIO_DEGREE_TO_RAD(70000),
+				},
+			},
+		},
+		.bdu = {
+			.addr = 0x23,
+			.mask = BIT(7),
+		},
+		.drdy_irq = {
+			.int2 = {
+				.addr = 0x22,
+				.mask = BIT(3),
+			},
+			/*
+			 * The sensor has IHL (active low) and open
+			 * drain settings, but only for INT1 and not
+			 * for the DRDY line on INT2.
+			 */
+			.stat_drdy = {
+				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
+				.mask = GENMASK(2, 0),
+			},
+		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
+		.multi_read_bit = true,
+		.bootime = 2,
+	},
 	{
 		.wai = 0xd7,
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
-- 
2.24.0


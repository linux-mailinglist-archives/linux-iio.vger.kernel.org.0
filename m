Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A225ECE465
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 15:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfJGN4w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 09:56:52 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1240 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727490AbfJGN4w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 09:56:52 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97Dtu6P014646;
        Mon, 7 Oct 2019 15:56:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=KREQBSMcdwwczT3WINjcFPrAMUXWrqvZP/odq0qpxfY=;
 b=hIhRo9gpPQiAPfZWizJkJf0hwNE3LDqxMVsXxNUeE+PGZtF9QdpLM6/GOz6rBgaS1ApH
 ghPe99FSRp7Cj07+37+BZW8LJZJT3SpiHUIiGHohLOXQ+N+A5VrqYEJVmaFa95OxMufj
 F/VTJEieOhWnppHs5IQv/C9uEm1x25rnnX6jkwcmCAheWs5H0M2iCfCD3yCkBmEnjr2J
 xhdTi+e/hgvQ9iz9Rfa0gfCFv04eBuTIeuES9iQECDhE8Sioodv5YJ+kFNaNxGK9jFyO
 1j0mLxn39OnC043cZK6nE3+LcLU88nwLdr4zaXJ1yWgeZ9w/YZM+JM43s08ll9Vkiqon ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vegagu2ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 15:56:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B3CFF10002A;
        Mon,  7 Oct 2019 15:56:33 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag4node3.st.com [10.75.127.12])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A9A2C2B0A4C;
        Mon,  7 Oct 2019 15:56:33 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG4NODE3.st.com (10.75.127.12)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Oct 2019 15:56:33
 +0200
From:   Mario Tesi <mario.tesi@st.com>
To:     <lorenzo.bianconi83@gmail.com>
CC:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        Mario Tesi <mario.tesi@st.com>
Subject: [PATCH] iio: imu: st_lsm6dsx: add odr calibration feature
Date:   Mon, 7 Oct 2019 15:56:26 +0200
Message-ID: <1570456586-16696-1-git-send-email-mario.tesi@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG4NODE3.st.com
 (10.75.127.12)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_02:2019-10-07,2019-10-07 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

	On LSM6DSO/LSM6DSR/LSM6DSOX/ASM330LHH and ISH330DHCX
	devices it is possible to trim the hardware timestamp
	resolution through the FREQ_FINE[7:0] bits of the
	INTERNAL_FREQ_FINE register, which contains the difference
	in percentage of the effective ODR (and timestamp rate)
	with respect to the typical value.

	The formula for calculating the effective ODR reported
	in the application notes has been linearized to the first
	order to simplify the calculation (pls. see note on source
	code).

	This change may be useful in the outcome of CTS
	tests regarding the SingleSensorTests and the
	SensorTest#testSensorTimeStamps for high ODRs

Signed-off-by: Mario Tesi <mario.tesi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        |  4 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |  5 ++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 7485423..9a40587 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -153,12 +153,14 @@ struct st_lsm6dsx_fifo_ops {
  * @hr_timer: Hw timer resolution register info (addr + mask).
  * @fifo_en: Hw timer FIFO enable register info (addr + mask).
  * @decimator: Hw timer FIFO decimator register info (addr + mask).
+ * @freq_fine: Difference in % of ODR with respect to the typical.
  */
 struct st_lsm6dsx_hw_ts_settings {
 	struct st_lsm6dsx_reg timer_en;
 	struct st_lsm6dsx_reg hr_timer;
 	struct st_lsm6dsx_reg fifo_en;
 	struct st_lsm6dsx_reg decimator;
+	u8 freq_fine;
 };
 
 /**
@@ -344,6 +346,7 @@ struct st_lsm6dsx_sensor {
  * @fifo_mode: FIFO operating mode supported by the device.
  * @suspend_mask: Suspended sensor bitmask.
  * @enable_mask: Enabled sensor bitmask.
+ * @ts_gain: Hw timestamp rate after internal calibration.
  * @ts_sip: Total number of timestamp samples in a given pattern.
  * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
  * @buff: Device read buffer.
@@ -365,6 +368,7 @@ struct st_lsm6dsx_hw {
 	enum st_lsm6dsx_fifo_mode fifo_mode;
 	u8 suspend_mask;
 	u8 enable_mask;
+	s64 ts_gain;
 	u8 ts_sip;
 	u8 sip;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index cabd4bf..d7cacb9 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -50,7 +50,6 @@
 
 #define ST_LSM6DSX_MAX_FIFO_ODR_VAL		0x08
 
-#define ST_LSM6DSX_TS_SENSITIVITY		25000UL /* 25us */
 #define ST_LSM6DSX_TS_RESET_VAL			0xaa
 
 struct st_lsm6dsx_decimator_entry {
@@ -423,7 +422,7 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 				 */
 				if (!reset_ts && ts >= 0xff0000)
 					reset_ts = true;
-				ts *= ST_LSM6DSX_TS_SENSITIVITY;
+				ts *= hw->ts_gain;
 
 				offset += ST_LSM6DSX_SAMPLE_SIZE;
 			}
@@ -566,7 +565,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 				 */
 				if (!reset_ts && ts >= 0xffff0000)
 					reset_ts = true;
-				ts *= ST_LSM6DSX_TS_SENSITIVITY;
+				ts *= hw->ts_gain;
 			} else {
 				st_lsm6dsx_push_tagged_data(hw, tag, iio_buff,
 							    ts);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index bacc908..2b54ce1 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -63,6 +63,8 @@
 
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
 
+#define ST_LSM6DSX_TS_SENSITIVITY		25000UL /* 25us */
+
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
 	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
 	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
@@ -832,6 +834,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x0a,
 				.mask = GENMASK(7, 6),
 			},
+			.freq_fine = 0x63,
 		},
 		.shub_settings = {
 			.page_mux = {
@@ -1020,6 +1023,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x0a,
 				.mask = GENMASK(7, 6),
 			},
+			.freq_fine = 0x63,
 		},
 		.event_settings = {
 			.enable_reg = {
@@ -1185,6 +1189,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x0a,
 				.mask = GENMASK(7, 6),
 			},
+			.freq_fine = 0x63,
 		},
 		.shub_settings = {
 			.page_mux = {
@@ -1874,6 +1879,24 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
 		if (err < 0)
 			return err;
 	}
+
+	/* calibrate timestamp sensitivity */
+	hw->ts_gain = ST_LSM6DSX_TS_SENSITIVITY;
+	if (ts_settings->freq_fine) {
+		err = regmap_read(hw->regmap, ts_settings->freq_fine, &val);
+		if (err < 0)
+			return err;
+
+		/*
+		 * linearize the AN5192 formula:
+		 * 1 / (1 + x) ~= 1 - x (Taylor’s Series)
+		 * ttrim[s] = 1 / (40000 * (1 + 0.0015 * val))
+		 * ttrim[ns] ~= 25000 - 37.5 * val
+		 * ttrim[ns] ~= 25000 - (37500 * val) / 1000
+		 */
+		hw->ts_gain -= ((s8)val * 37500) / 1000;
+	}
+
 	return 0;
 }
 
-- 
2.7.4


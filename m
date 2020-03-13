Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A397184E08
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 18:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCMRzL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 13:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCMRzL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Mar 2020 13:55:11 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C66206EB;
        Fri, 13 Mar 2020 17:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584122109;
        bh=pP/kh4TzAUmZr1IFqh1ECEaMLA6t5DguYM3btJYvFm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=umVDiPMyJqXIKdx3CZKPINnytHe5YYFfNUF19sx47DD+YxoZXxX3qEfKcbGBeYCix
         CJTmODaVSlUy+8eylQ1fwa9A2F7KCGGfga4YHYJM4eKZp0ipb2AkBw5B7taBnOoiOL
         oXoYAutfRyDHVwAdhaJQLA+Rb+RaESpjIJBngEpY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, mario.tesi@st.com, denis.ciocca@st.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: fix read misalignment on untagged FIFO
Date:   Fri, 13 Mar 2020 18:54:41 +0100
Message-Id: <f9cdf1a1f69013417a5aaaf11a548e9585bdac20.1584121851.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584121851.git.lorenzo@kernel.org>
References: <cover.1584121851.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

st_lsm6dsx suffers of a read misalignment on untagged FIFO when
all 3 supported sensors (accel, gyro and ext device) are running
at different ODRs (the use-case is reported in the LSM6DSM Application
Note at pag 100).
Fix the issue taking into account decimation factor reading the FIFO
pattern.

Fixes: e485e2a2cfd6 ("iio: imu: st_lsm6dsx: enable sensor-hub support for lsm6dsm")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 ++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 23 +++++++++++++------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index f2113a63721a..e9e756b1e92f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -337,6 +337,7 @@ enum st_lsm6dsx_fifo_mode {
  * @gain: Configured sensor sensitivity.
  * @odr: Output data rate of the sensor [Hz].
  * @watermark: Sensor watermark level.
+ * @decimator: Sensor decimation factor.
  * @sip: Number of samples in a given pattern.
  * @ts_ref: Sensor timestamp reference for hw one.
  * @ext_info: Sensor settings if it is connected to i2c controller
@@ -350,6 +351,7 @@ struct st_lsm6dsx_sensor {
 	u32 odr;
 
 	u16 watermark;
+	u8 decimator;
 	u8 sip;
 	s64 ts_ref;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index bb899345f2bb..afd00daeefb2 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -93,6 +93,7 @@ st_lsm6dsx_get_decimator_val(struct st_lsm6dsx_sensor *sensor, u32 max_odr)
 			break;
 	}
 
+	sensor->decimator = decimator;
 	return i == max_size ? 0 : st_lsm6dsx_decimator_table[i].val;
 }
 
@@ -337,7 +338,7 @@ static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 addr,
 int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 {
 	struct st_lsm6dsx_sensor *acc_sensor, *gyro_sensor, *ext_sensor = NULL;
-	int err, acc_sip, gyro_sip, ts_sip, ext_sip, read_len, offset;
+	int err, sip, acc_sip, gyro_sip, ts_sip, ext_sip, read_len, offset;
 	u16 fifo_len, pattern_len = hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
 	u16 fifo_diff_mask = hw->settings->fifo_ops.fifo_diff.mask;
 	u8 gyro_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
@@ -399,19 +400,20 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 		acc_sip = acc_sensor->sip;
 		ts_sip = hw->ts_sip;
 		offset = 0;
+		sip = 0;
 
 		while (acc_sip > 0 || gyro_sip > 0 || ext_sip > 0) {
-			if (gyro_sip > 0) {
+			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
 				memcpy(gyro_buff, &hw->buff[offset],
 				       ST_LSM6DSX_SAMPLE_SIZE);
 				offset += ST_LSM6DSX_SAMPLE_SIZE;
 			}
-			if (acc_sip > 0) {
+			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
 				memcpy(acc_buff, &hw->buff[offset],
 				       ST_LSM6DSX_SAMPLE_SIZE);
 				offset += ST_LSM6DSX_SAMPLE_SIZE;
 			}
-			if (ext_sip > 0) {
+			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
 				memcpy(ext_buff, &hw->buff[offset],
 				       ST_LSM6DSX_SAMPLE_SIZE);
 				offset += ST_LSM6DSX_SAMPLE_SIZE;
@@ -441,18 +443,25 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 				offset += ST_LSM6DSX_SAMPLE_SIZE;
 			}
 
-			if (gyro_sip-- > 0)
+			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
 				iio_push_to_buffers_with_timestamp(
 					hw->iio_devs[ST_LSM6DSX_ID_GYRO],
 					gyro_buff, gyro_sensor->ts_ref + ts);
-			if (acc_sip-- > 0)
+				gyro_sip--;
+			}
+			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
 				iio_push_to_buffers_with_timestamp(
 					hw->iio_devs[ST_LSM6DSX_ID_ACC],
 					acc_buff, acc_sensor->ts_ref + ts);
-			if (ext_sip-- > 0)
+				acc_sip--;
+			}
+			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
 				iio_push_to_buffers_with_timestamp(
 					hw->iio_devs[ST_LSM6DSX_ID_EXT0],
 					ext_buff, ext_sensor->ts_ref + ts);
+				ext_sip--;
+			}
+			sip++;
 		}
 	}
 
-- 
2.24.1


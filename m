Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC08B229BEA
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgGVPxd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 11:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgGVPxd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 11:53:33 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E95206F5;
        Wed, 22 Jul 2020 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595433212;
        bh=BrMikSOSP8rQfuWua//rncDQlSlapCNNxsWOW25/l14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4mtAlA83544RlA4UcAlrsCNvm6Lv/JzmG71IvQFUUacScFctovXqNauLKB9hyu7R
         FuBDnDPvuCETgeB18nuNT9MT8pNKSIY3ZhmBNmdO7wU+rOkg6IqKvhtwDvI7GPweD5
         36jsa99k4GuQq7hDVHffTz/fSk5utbBAJ4Uhx36M=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: [PATCH v3 16/27] iio:imu:st_lsm6dsx Fix alignment and data leak issues
Date:   Wed, 22 Jul 2020 16:50:52 +0100
Message-Id: <20200722155103.979802-17-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722155103.979802-1-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses an array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to an array of suitable structures in the iio_priv() data.

This data is allocated with kzalloc so no data can leak apart from
previous readings.

For the tagged path the data is aligned by using __aligned(8) for
the buffer on the stack.

There has been a lot of churn in this driver, so likely backports
may be needed for stable.

Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  6 ++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 36 ++++++++++---------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index d80ba2e688ed..9275346a9cc1 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -383,6 +383,7 @@ struct st_lsm6dsx_sensor {
  * @iio_devs: Pointers to acc/gyro iio_dev instances.
  * @settings: Pointer to the specific sensor settings in use.
  * @orientation: sensor chip orientation relative to main hardware.
+ * @scan: Temporary buffers used to align data before iio_push_to_buffers()
  */
 struct st_lsm6dsx_hw {
 	struct device *dev;
@@ -411,6 +412,11 @@ struct st_lsm6dsx_hw {
 	const struct st_lsm6dsx_settings *settings;
 
 	struct iio_mount_matrix orientation;
+	/* Ensure natural alignment of buffer elements */
+	struct {
+		__le16 channels[3];
+		s64 ts __aligned(8);
+	} scan[3];
 };
 
 static __maybe_unused const struct iio_event_spec st_lsm6dsx_event = {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 7de10bd636ea..9e0404e3581d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -353,9 +353,6 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	int err, sip, acc_sip, gyro_sip, ts_sip, ext_sip, read_len, offset;
 	u16 fifo_len, pattern_len = hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
 	u16 fifo_diff_mask = hw->settings->fifo_ops.fifo_diff.mask;
-	u8 gyro_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
-	u8 acc_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
-	u8 ext_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
 	bool reset_ts = false;
 	__le16 fifo_status;
 	s64 ts = 0;
@@ -416,19 +413,22 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 
 		while (acc_sip > 0 || gyro_sip > 0 || ext_sip > 0) {
 			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
-				memcpy(gyro_buff, &hw->buff[offset],
-				       ST_LSM6DSX_SAMPLE_SIZE);
-				offset += ST_LSM6DSX_SAMPLE_SIZE;
+				memcpy(hw->scan[ST_LSM6DSX_ID_GYRO].channels,
+				       &hw->buff[offset],
+				       sizeof(hw->scan[ST_LSM6DSX_ID_GYRO].channels));
+				offset += sizeof(hw->scan[ST_LSM6DSX_ID_GYRO].channels);
 			}
 			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
-				memcpy(acc_buff, &hw->buff[offset],
-				       ST_LSM6DSX_SAMPLE_SIZE);
-				offset += ST_LSM6DSX_SAMPLE_SIZE;
+				memcpy(hw->scan[ST_LSM6DSX_ID_ACC].channels,
+				       &hw->buff[offset],
+				       sizeof(hw->scan[ST_LSM6DSX_ID_ACC].channels));
+				offset += sizeof(hw->scan[ST_LSM6DSX_ID_ACC].channels);
 			}
 			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
-				memcpy(ext_buff, &hw->buff[offset],
-				       ST_LSM6DSX_SAMPLE_SIZE);
-				offset += ST_LSM6DSX_SAMPLE_SIZE;
+				memcpy(hw->scan[ST_LSM6DSX_ID_EXT0].channels,
+				       &hw->buff[offset],
+				       sizeof(hw->scan[ST_LSM6DSX_ID_EXT0].channels));
+				offset += sizeof(hw->scan[ST_LSM6DSX_ID_EXT0].channels);
 			}
 
 			if (ts_sip-- > 0) {
@@ -458,19 +458,22 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
 				iio_push_to_buffers_with_timestamp(
 					hw->iio_devs[ST_LSM6DSX_ID_GYRO],
-					gyro_buff, gyro_sensor->ts_ref + ts);
+					&hw->scan[ST_LSM6DSX_ID_GYRO],
+					gyro_sensor->ts_ref + ts);
 				gyro_sip--;
 			}
 			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
 				iio_push_to_buffers_with_timestamp(
 					hw->iio_devs[ST_LSM6DSX_ID_ACC],
-					acc_buff, acc_sensor->ts_ref + ts);
+					&hw->scan[ST_LSM6DSX_ID_ACC],
+					acc_sensor->ts_ref + ts);
 				acc_sip--;
 			}
 			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
 				iio_push_to_buffers_with_timestamp(
 					hw->iio_devs[ST_LSM6DSX_ID_EXT0],
-					ext_buff, ext_sensor->ts_ref + ts);
+					&hw->scan[ST_LSM6DSX_ID_EXT0],
+					ext_sensor->ts_ref + ts);
 				ext_sip--;
 			}
 			sip++;
@@ -555,7 +558,8 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 {
 	u16 pattern_len = hw->sip * ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
 	u16 fifo_len, fifo_diff_mask;
-	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE], tag;
+	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);
+	u8 tag;
 	bool reset_ts = false;
 	int i, err, read_len;
 	__le16 fifo_status;
-- 
2.27.0


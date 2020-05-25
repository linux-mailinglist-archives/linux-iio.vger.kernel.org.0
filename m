Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CD21E133C
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391299AbgEYRJS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391278AbgEYRJP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:15 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48E382087D;
        Mon, 25 May 2020 17:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426555;
        bh=i9veCVP76NNaz3ItuFgqknUChsXzi53dbAYJ5UM7laA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Gx+MtQFr3M4QCPjt/s/olu2mNnkUskC0jaVIkRvNx8wmeXv922ZSV9MIVKs5lPqE
         qoF5y7Fm657sy2QLivYkzAn9wECPYFKhC5mx9K/PSuaK1F/4YueHNDHuCoU+gywEZO
         Dp/8cDU7wBQvJw14zGKxAlZmURB7sFVjgO/08upg=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: [PATCH 12/25] iio:imu:st_lsm6dsx Fix alignment and data leak issues
Date:   Mon, 25 May 2020 18:06:15 +0100
Message-Id: <20200525170628.503283-13-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525170628.503283-1-jic23@kernel.org>
References: <20200525170628.503283-1-jic23@kernel.org>
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
moving to a set of suitable structures in the iio_priv() data.

This data is allocated with kzalloc so no data can leak apart from
previous readings.

There has been a lot of churn in this driver, so likely backports
may be needed for stable.

Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  5 ++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 27 ++++++++++---------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index b56df409ed0f..5bc724eadc83 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -411,6 +411,11 @@ struct st_lsm6dsx_hw {
 	const struct st_lsm6dsx_settings *settings;
 
 	struct iio_mount_matrix orientation;
+	/* Ensure natural alignment of buffer elements */
+	struct {
+		__le16 channels[3];
+		s64 ts;
+	} gyro_scan, acc_scan, ext_scan;
 };
 
 static __maybe_unused const struct iio_event_spec st_lsm6dsx_event = {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index afd00daeefb2..9bcffbfac797 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -341,9 +341,6 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	int err, sip, acc_sip, gyro_sip, ts_sip, ext_sip, read_len, offset;
 	u16 fifo_len, pattern_len = hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
 	u16 fifo_diff_mask = hw->settings->fifo_ops.fifo_diff.mask;
-	u8 gyro_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
-	u8 acc_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
-	u8 ext_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
 	bool reset_ts = false;
 	__le16 fifo_status;
 	s64 ts = 0;
@@ -404,18 +401,21 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 
 		while (acc_sip > 0 || gyro_sip > 0 || ext_sip > 0) {
 			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
-				memcpy(gyro_buff, &hw->buff[offset],
-				       ST_LSM6DSX_SAMPLE_SIZE);
+				memcpy(hw->gyro_scan.channels,
+				       &hw->buff[offset],
+				       sizeof(hw->gyro_scan.channels));
 				offset += ST_LSM6DSX_SAMPLE_SIZE;
 			}
 			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
-				memcpy(acc_buff, &hw->buff[offset],
-				       ST_LSM6DSX_SAMPLE_SIZE);
+				memcpy(hw->acc_scan.channels,
+				       &hw->buff[offset],
+				       sizeof(hw->acc_scan.channels));
 				offset += ST_LSM6DSX_SAMPLE_SIZE;
 			}
 			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
-				memcpy(ext_buff, &hw->buff[offset],
-				       ST_LSM6DSX_SAMPLE_SIZE);
+				memcpy(hw->ext_scan.channels,
+				       &hw->buff[offset],
+				       sizeof(hw->ext_scan.channels));
 				offset += ST_LSM6DSX_SAMPLE_SIZE;
 			}
 
@@ -446,19 +446,22 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 			if (gyro_sip > 0 && !(sip % gyro_sensor->decimator)) {
 				iio_push_to_buffers_with_timestamp(
 					hw->iio_devs[ST_LSM6DSX_ID_GYRO],
-					gyro_buff, gyro_sensor->ts_ref + ts);
+					&hw->gyro_scan,
+					gyro_sensor->ts_ref + ts);
 				gyro_sip--;
 			}
 			if (acc_sip > 0 && !(sip % acc_sensor->decimator)) {
 				iio_push_to_buffers_with_timestamp(
 					hw->iio_devs[ST_LSM6DSX_ID_ACC],
-					acc_buff, acc_sensor->ts_ref + ts);
+					&hw->acc_scan,
+					acc_sensor->ts_ref + ts);
 				acc_sip--;
 			}
 			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
 				iio_push_to_buffers_with_timestamp(
 					hw->iio_devs[ST_LSM6DSX_ID_EXT0],
-					ext_buff, ext_sensor->ts_ref + ts);
+					&hw->ext_scan,
+					ext_sensor->ts_ref + ts);
 				ext_sip--;
 			}
 			sip++;
-- 
2.26.2


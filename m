Return-Path: <linux-iio+bounces-10842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F5A9A5ECF
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 10:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14011F2288C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 08:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14FA1E22F8;
	Mon, 21 Oct 2024 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpD6Jwjo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30C1E1C2D;
	Mon, 21 Oct 2024 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499933; cv=none; b=k6BO1ZctrpSa5l8YMre+YQoUX/kAC8reK0FSTFmr7wOTVidxP3Mje8dHMymyYE1io2jYn5cv5TZk6McL+gUcZW4rzDr8oPQKPa/x26w4olfSZSTxLz4Ik9CFTDgbJ1rQYvKtKA5tzcZCKcb71/xwCR4aaFENIeiU8Wi3DlTMU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499933; c=relaxed/simple;
	bh=WbYlBVy0U1GnLrIaCO/CCGOrRCmdbhg78fXAroW8hGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ILIsVZ3ZN9YB0zVKsYiotYSEOcFdakGNiJKIP5p4PX6epjo5aGO/TB6Bc5X27607Qhq/0e5TnT8obGWqDQEQ7DsP4V7Nuj0PaUCivS2in/mHiE4E0NSwdw+vwymp1NOrWiYaSS1DW2IUOlaY13Z5cerHlSlwxBAFcnj2p3HbL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpD6Jwjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 264FFC4CEC3;
	Mon, 21 Oct 2024 08:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729499933;
	bh=WbYlBVy0U1GnLrIaCO/CCGOrRCmdbhg78fXAroW8hGI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=OpD6JwjoEbpXWdXRei8CEF7VlerKKO3JhBHq2c+VxPlqZvPw4728gWC3WOECXySBL
	 Mn4pNZIYCdAkuB0GX3nXJrWUWWeANaiiwMcpM1lYDVh6YKvjiJPuLDhDvq+JLFg4pa
	 iE4HLfClPYo708F69LKJUXTnEyX4DpxMweljx25MqEXcLjPTx5T0ngDNMoq6t4fssY
	 NneMJPKNdfCH/5v9xpqY95TIjUPukB+ROBA4cKYcyU6uEgC8MAkzCMX+zXdNi3gv/0
	 YKMsx2cUitz46diDiKFzDbaGrswf3ERyTH6JHlNrOWkjoPoqIQlIdMGIbup+hiArYk
	 FTnkuR1vFwGRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA02D0E6CE;
	Mon, 21 Oct 2024 08:38:53 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Mon, 21 Oct 2024 10:38:42 +0200
Subject: [PATCH v2] iio: invensense: fix multiple odr switch when FIFO is
 off
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-invn-inv-sensors-timestamp-fix-switch-fifo-off-v2-1-39ffd43edcc4@tdk.com>
X-B4-Tracking: v=1; b=H4sIABETFmcC/52N0QrCMAxFf2X02UhbJ2U++R+yh65LXZC1oylVG
 ft3u32CBEJOuNyzCsZEyOLWrCJhIaYYKuhTI9xkwxOBxspCS90qqQxQKGFfwBg4JoZMM3K28wK
 ePsBvym6qp48QvYeL151SErvrKEUtXRLW2CF89JUn4hzT9/AXtX//VhUFdQbnrZHWtGa45/F1d
 nEW/bZtP/cHZmDqAAAA
X-Change-ID: 20241017-invn-inv-sensors-timestamp-fix-switch-fifo-off-3f29110e95d0
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729499932; l=4913;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=HwKkaznxa/GtKkxWPn8/QMQwIOns9lkHLrxgztbXJrs=;
 b=/sQVEhyGw77DuiPXFRVEer1YQBIacJXR2hYlZQwCLOik+ZPXySdxk1USKK4w3JDsy4VFRjklU
 v5nmDzjaHoyC++TpxnT4m2GYvVMc7wwyJIUh73MoyP9kJGq2pZsJ6V+
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

When multiple ODR switch happens during FIFO off, the change could
not be taken into account if you get back to previous FIFO on value.
For example, if you run sensor buffer at 50Hz, stop, change to
200Hz, then back to 50Hz and restart buffer, data will be timestamped
at 200Hz. This due to testing against mult and not new_mult.

To prevent this, let's just run apply_odr automatically when FIFO is
off. It will also simplify driver code.

Update inv_mpu6050 and inv_icm42600 to delete now useless apply_odr.

Fixes: 95444b9eeb8c ("iio: invensense: fix odr switching to same value")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Changes in v2:
- Delete unused anymore local variables.
- Link to v1: https://lore.kernel.org/r/20241017-invn-inv-sensors-timestamp-fix-switch-fifo-off-v1-1-1bcfa70a747b@tdk.com
---
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c      | 2 --
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c       | 3 ---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c          | 1 -
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index f44458c380d92823ce2e7e5f78ca877ea4c06118..37d0bdaa8d824f79dcd2f341be7501d249926951 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -70,6 +70,10 @@ int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
 	if (mult != ts->mult)
 		ts->new_mult = mult;
 
+	/* When FIFO is off, directly apply the new ODR */
+	if (!fifo)
+		inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 56ac198142500a2e1fc40b62cdd465cc736d8bf0..7968aa27f9fd798f206e72891f1c9b483811dea2 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -200,7 +200,6 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
-	struct inv_sensors_timestamp *ts = &accel_st->ts;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_temp = 0;
@@ -229,7 +228,6 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
-	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 
 out_unlock:
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 938af5b640b00f58d2b8185f752c4755edfb0d25..c6bb68bf5e1449d4b961ac962311cbc5aa3c0a97 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -99,8 +99,6 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 					      const unsigned long *scan_mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	struct inv_icm42600_sensor_state *gyro_st = iio_priv(indio_dev);
-	struct inv_sensors_timestamp *ts = &gyro_st->ts;
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
 	unsigned int fifo_en = 0;
 	unsigned int sleep_gyro = 0;
@@ -128,7 +126,6 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
-	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 
 out_unlock:
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 3bfeabab0ec4f6fa28fbbcd47afe92af5b8a58e2..5b1088cc3704f1ad1288a0d65b2f957b91455d7f 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -112,7 +112,6 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
 	if (enable) {
 		/* reset timestamping */
 		inv_sensors_timestamp_reset(&st->timestamp);
-		inv_sensors_timestamp_apply_odr(&st->timestamp, 0, 0, 0);
 		/* reset FIFO */
 		d = st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
 		ret = regmap_write(st->map, st->reg->user_ctrl, d);

---
base-commit: c3e9df514041ec6c46be83801b1891392f4522f7
change-id: 20241017-invn-inv-sensors-timestamp-fix-switch-fifo-off-3f29110e95d0

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>




Return-Path: <linux-iio+bounces-10684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0809A2481
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 16:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2EE1C26141
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7254C1DE3D2;
	Thu, 17 Oct 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dugwrwc5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E51DE3CB;
	Thu, 17 Oct 2024 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174007; cv=none; b=m69zyAhrfYYvcsz+agax0UitZ3d0y3BWSPB7G2VqRUFCCGJkzfKaObewAQCXRTwyj9aKxIkG+E0md/s7QWl8x5MSS7lnB5bLsz8kS30StXZnEMoSF/3QdehVGtEBthl/5Dmk6s1Iur0keNygMGTDWIHN4E8+/x9qMHX/DGKWq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174007; c=relaxed/simple;
	bh=Cd2ptOu9IhlY69+bEHrkg5ABhxuLTtueNlNdkEdviW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hS+b0KA/j9vrMNTKzrTHRn01ifTY5ubbE9BhViDPGaqJc2LLYvi7W7wqT6C0YiP1mIxI1TdFRC4l5F7N5eDhHzNOIDG7BccCtQGZKYMdnsaCFlrBXlT+Pm2GMzFq4f+Cg9XUUVF5YfOjx+GFr+a+RdRQa14yOmm2EyH6Or9vKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dugwrwc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3360EC4CEC3;
	Thu, 17 Oct 2024 14:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729174006;
	bh=Cd2ptOu9IhlY69+bEHrkg5ABhxuLTtueNlNdkEdviW8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=dugwrwc51sVaj5d6US1kboxNQ23SEAgVL+OLhep8b2ZQgE11gj+utmdYkKobfyu2q
	 +Yohb6aa+pbB5s8e+47md8wOxHYbtTn5aRFobzA9zz7kXw2qXpFB7X8OY0tfCjrzDN
	 jl6ahAefRkX6dZRoIAJA94DHbjNmg05wEcYo9ODNEUMT7ls7/EvamNa7kpniQWPzV3
	 6HZzCTMQFOI7HA3iRLCiQIpAwAKexVPLqjsdu4/rJtpy6Bo9iujyXd3lQsQgdEK+ME
	 09OKnp+tXaPMnPfXljDQf3QDp7JUn7aw00L+p1gSTHohb5DXYY98ZGIOhJr/nlNfai
	 9JTEoO2+dyeAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286F5D37488;
	Thu, 17 Oct 2024 14:06:46 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 17 Oct 2024 16:06:28 +0200
Subject: [PATCH] iio: invensense: fix multiple odr switch when FIFO is off
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-invn-inv-sensors-timestamp-fix-switch-fifo-off-v1-1-1bcfa70a747b@tdk.com>
X-B4-Tracking: v=1; b=H4sIAOMZEWcC/x2NwQrCQAxEf6XkbGCzKlJ/RTyUNrE5NFs2SxVK/
 93oZZgHj5kdnKuyw73bofKmrsUC6NTBOA/2YtQpGHLKF0p0Q7XNfoHO5qU6Nl3Y27CsKPpBf2s
 b56hSsIjgWXJPlLi/TglidK0c2v/w8TyOL0kefi6AAAAA
X-Change-ID: 20241017-invn-inv-sensors-timestamp-fix-switch-fifo-off-3f29110e95d0
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729174005; l=3834;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=hwc0VtUPDpKzrpf0zfGK0OY2bFJH+QWRh4z9/VaDmA8=;
 b=TguYYGKHfPKqJ15J+qhEfByNDFrMqxGAzxCEh92LM4i5xFtK5rtY/ehj4dTlnurQZVP89akYk
 Llm/g42P0yDC49mGFhH2FJs/sfLoYpZafKCZJRIkVVdonXPGMHYksqR
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
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c      | 1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c       | 1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c          | 1 -
 4 files changed, 4 insertions(+), 3 deletions(-)

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
index 56ac198142500a2e1fc40b62cdd465cc736d8bf0..d061a64ebbf71859a3bc44644a14137dff0f9efe 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -229,7 +229,6 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 	}
 
 	/* update data FIFO write */
-	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
 	ret = inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
 
 out_unlock:
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 938af5b640b00f58d2b8185f752c4755edfb0d25..f1e5a9648c4f5dd34f40136d02c72c90473eff37 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -128,7 +128,6 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
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




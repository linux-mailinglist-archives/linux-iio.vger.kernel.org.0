Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C68B26E112
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgIQQrd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgIQQrY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Sep 2020 12:47:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3359BC06174A;
        Thu, 17 Sep 2020 09:47:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e11so4829663wme.0;
        Thu, 17 Sep 2020 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLsb98yk30q0vci/VJiQwkTXfIwu9FcPvlE+y2lBvRk=;
        b=n4oYXJE/LJ7nvSujhZUHbQ8Yk42uI5TojsybSxLfyj83Wb7YtzJW4p2OBC9zpxpAtV
         y2xn8oosqFs/MkUHMxMY0iPCM6iYoXvLhu1fBhdKh5PaV7O/Thn/C7W//BpFSovl78p7
         snu2eIPwlG/kcbQQZ6WOz5bH0IWMJYS5YY1P5MfcEFIlHMlusojF8yDLPkafMCiMEqsR
         74UiBfaltUxjHUo0fnasDMsOoX6OSCsp+L1ibasE3tPHC3cvKjKf0JBEAmNXIC0egKbR
         HiVCuf6Z3aXlReIxtr84vtmmHYIR/gVs10Kj7EU9VSsG4n8zqAX8tEZXPlyV6jNWgXAg
         kEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLsb98yk30q0vci/VJiQwkTXfIwu9FcPvlE+y2lBvRk=;
        b=L+wPa7nszFjP0COgG+FUz03sgiX2w3DE4UUE+fyJJnwgomHnVG2FTkOa8WhEi8hgsL
         erfSpy6Wjr+ARQ8dHMf08ERCEqgnLG2l4FMK+DFE6JL7J6B80V4BqNOYliE4EJUJ88Cy
         1vfvjRiBaRCvkGiOZTdQnHAfc5nEM80fOTlhItF8DajTPGoGepUaQSD+E6G6nB7cz7Ep
         +oVgriQv49InzsaOum11QTXkBHtaDMvr3RBQ46GGEOCOBuSeZnj+zP51fo0iD2u8vgWt
         MeB3wHvuEm8Fz5HRIpenvq2NkktCmxouieObax18sLF+q72AO2ohFM67ZwW1mrUkLUp1
         1FmA==
X-Gm-Message-State: AOAM532BrhzhVRqeFhnR2QOQmVp6rzOGJs4ioacF9wxy3j+X9te5pQbq
        ykV+L3sKx5DsIFu6UkfM6SQ=
X-Google-Smtp-Source: ABdhPJzOm/vljtXe+W8gUU0SbAD5RWHffGQ2LQ9h7JH4oSv4nHnaofmRodTCOxyKKkRXAUOKtPwKpg==
X-Received: by 2002:a1c:9a50:: with SMTP id c77mr11153303wme.150.1600361241547;
        Thu, 17 Sep 2020 09:47:21 -0700 (PDT)
Received: from ctocxl0004.cto.st.com (net-109-115-13-182.cust.vodafonedsl.it. [109.115.13.182])
        by smtp.gmail.com with ESMTPSA id a83sm74573wmh.48.2020.09.17.09.47.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 09:47:20 -0700 (PDT)
From:   Mario Tesi <martepisa@gmail.com>
To:     lorenzo.bianconi83@gmail.com
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.tesi@st.com
Subject: [PATCH] iio: imu: st_lsm6dsx: Scaling factor type set to IIO_VAL_INT_PLUS_NANO
Date:   Thu, 17 Sep 2020 18:47:16 +0200
Message-Id: <1600361236-2285-1-git-send-email-martepisa@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Mario Tesi <mario.tesi@st.com>

Scaling factor values for Acc lead to an unacceptable rounding of the
full scale (FS) calculated by some SensorHAL on Android devices. For examples
setting FS to 4g the in_accel_x_scale, in_accel_y_scale and in_accel_z_scale
are 0.001196 on 6 decimal digits and the FS is
0.001196 × ((2^15) − 1) ~= 39.1893 m/s^2.

Android CTS R10 SensorParameterRangeTest test expects a value greater than
39.20 m/s^2 so this test fails (ACCELEROMETER_MAX_RANGE = 4 * 9.80).

Using 9 decimal digits the new scale factor is 0.001196411 and the FS now
is 0.001196411 × ((2^15)−1) ~= 39.2028 m/s^2.

This patch extends to IIO_VAL_INT_PLUS_NANO type the scaling factor to all
IMU devices where SensorParameterRangeTest CTS test fails.

Signed-off-by: Mario Tesi <mario.tesi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 134 +++++++++++++++------------
 1 file changed, 77 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 346c242..42f4856 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -157,10 +157,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x20,
 					.mask = GENMASK(4, 3),
 				},
-				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
-				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
-				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
-				.fs_avl[3] = { IIO_G_TO_M_S_2(732), 0x1 },
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61000), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122000), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244000), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(732000), 0x1 },
 				.fs_len = 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
@@ -169,9 +169,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.mask = GENMASK(4, 3),
 				},
 
-				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
-				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
-				.fs_avl[2] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500000), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(70000000), 0x3 },
 				.fs_len = 3,
 			},
 		},
@@ -259,10 +259,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(3, 2),
 				},
-				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
-				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
-				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
-				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61000), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122000), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244000), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(488000), 0x1 },
 				.fs_len = 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
@@ -270,10 +270,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x11,
 					.mask = GENMASK(3, 2),
 				},
-				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
-				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
-				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
-				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500000), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000000), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000000), 0x3 },
 				.fs_len = 4,
 			},
 		},
@@ -425,10 +425,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(3, 2),
 				},
-				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
-				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
-				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
-				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61000), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122000), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244000), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(488000), 0x1 },
 				.fs_len = 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
@@ -436,10 +436,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x11,
 					.mask = GENMASK(3, 2),
 				},
-				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
-				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
-				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
-				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500000), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000000), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000000), 0x3 },
 				.fs_len = 4,
 			},
 		},
@@ -600,10 +600,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(3, 2),
 				},
-				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
-				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
-				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
-				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61000), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122000), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244000), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(488000), 0x1 },
 				.fs_len = 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
@@ -611,10 +611,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x11,
 					.mask = GENMASK(3, 2),
 				},
-				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
-				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
-				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
-				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500000), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000000), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000000), 0x3 },
 				.fs_len = 4,
 			},
 		},
@@ -816,10 +816,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(3, 2),
 				},
-				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
-				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
-				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
-				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61000), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122000), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244000), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(488000), 0x1 },
 				.fs_len = 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
@@ -827,10 +827,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x11,
 					.mask = GENMASK(3, 2),
 				},
-				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
-				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
-				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
-				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500000), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000000), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000000), 0x3 },
 				.fs_len = 4,
 			},
 		},
@@ -1021,10 +1021,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(3, 2),
 				},
-				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
-				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
-				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
-				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61000), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122000), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244000), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(488000), 0x1 },
 				.fs_len = 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
@@ -1032,10 +1032,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x11,
 					.mask = GENMASK(3, 2),
 				},
-				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
-				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
-				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
-				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500000), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000000), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000000), 0x3 },
 				.fs_len = 4,
 			},
 		},
@@ -1200,10 +1200,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(3, 2),
 				},
-				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
-				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
-				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
-				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61000), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122000), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244000), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(488000), 0x1 },
 				.fs_len = 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
@@ -1211,10 +1211,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x11,
 					.mask = GENMASK(3, 2),
 				},
-				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
-				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
-				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
-				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500000), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000000), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000000), 0x3 },
 				.fs_len = 4,
 			},
 		},
@@ -1598,7 +1598,7 @@ static int st_lsm6dsx_read_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = sensor->gain;
-		ret = IIO_VAL_INT_PLUS_MICRO;
+		ret = IIO_VAL_INT_PLUS_NANO;
 		break;
 	default:
 		ret = -EINVAL;
@@ -1836,13 +1836,31 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
 
 	fs_table = &hw->settings->fs_table[sensor->id];
 	for (i = 0; i < fs_table->fs_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
+		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
 				 fs_table->fs_avl[i].gain);
 	buf[len - 1] = '\n';
 
 	return len;
 }
 
+static int st_lsm6dsx_write_raw_get_fmt(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+		case IIO_ACCEL:
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return IIO_VAL_INT_PLUS_MICRO;
+		}
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sysfs_sampling_frequency_avail);
 static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
 		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
@@ -1868,6 +1886,7 @@ static const struct iio_info st_lsm6dsx_acc_info = {
 	.read_event_config = st_lsm6dsx_read_event_config,
 	.write_event_config = st_lsm6dsx_write_event_config,
 	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
+	.write_raw_get_fmt = st_lsm6dsx_write_raw_get_fmt,
 };
 
 static struct attribute *st_lsm6dsx_gyro_attributes[] = {
@@ -1885,6 +1904,7 @@ static const struct iio_info st_lsm6dsx_gyro_info = {
 	.read_raw = st_lsm6dsx_read_raw,
 	.write_raw = st_lsm6dsx_write_raw,
 	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
+	.write_raw_get_fmt = st_lsm6dsx_write_raw_get_fmt,
 };
 
 static int st_lsm6dsx_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_pin)
-- 
2.7.4


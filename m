Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7803541D1
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 13:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhDELpe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 07:45:34 -0400
Received: from www381.your-server.de ([78.46.137.84]:55594 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbhDELpd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Apr 2021 07:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=kQhWpdmhuZnWdHoj6MiiwAn6XDoLFk+qxTyJgcTJzJw=; b=WUibpzRjwCDXwfBAC/DO59UHIi
        Zsh7vSrSbiIIxZdFLq6B9ArJ1A4QFrk2ZZaxGNW7GXxNezdf9yILfrL5PtLYWfliTXsvANWEgN/s5
        uxAGg2hVGaUcFtUANYmY10+RVyh42BnV8qGcUmasAKVtvNHgy6jJWN0Jw+UWdZN0CNJijYtrmMabT
        sowdRaLRn9a7PrkmFqORvwUfr4LQQOZBQ3UlW4YU+S4qLvc/cxyVa3goJuYY1NlSAATRtg1uAY6Io
        WSl0PqIXHPW5V6oD5mC3asQqfmnUF0iSHjm0T5/xDrwzZFfAnDAiNrNc6qdifZzqa8gLmnJqo9/mt
        Tx8cNsVg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lTNfT-000CHg-Ms; Mon, 05 Apr 2021 13:45:19 +0200
Received: from [2001:a61:2bab:901:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lTNfT-000FLb-F6; Mon, 05 Apr 2021 13:45:19 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: inv_mpu6050: Fully validate gyro and accel scale writes
Date:   Mon,  5 Apr 2021 13:44:41 +0200
Message-Id: <20210405114441.24167-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26130/Sun Apr  4 13:11:08 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When setting the gyro or accelerometer scale the inv_mpu6050 driver ignores
the integer part of the value. As a result e.g. all of 0.13309, 1.13309,
12345.13309, ... are accepted as a valid gyro scale and 0.13309 is the
scale that gets set in all those cases.

Make sure to check that the integer part of the scale value is 0 and reject
it otherwise.

Fixes: 09a642b78523 ("Invensense MPU6050 Device Driver.")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 453c51c79655..69ab94ab7297 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -731,12 +731,16 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val)
+static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val,
+					int val2)
 {
 	int result, i;
 
+	if (val != 0)
+		return -EINVAL;
+
 	for (i = 0; i < ARRAY_SIZE(gyro_scale_6050); ++i) {
-		if (gyro_scale_6050[i] == val) {
+		if (gyro_scale_6050[i] == val2) {
 			result = inv_mpu6050_set_gyro_fsr(st, i);
 			if (result)
 				return result;
@@ -767,13 +771,17 @@ static int inv_write_raw_get_fmt(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, int val)
+static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, int val,
+					 int val2)
 {
 	int result, i;
 	u8 d;
 
+	if (val != 0)
+		return -EINVAL;
+
 	for (i = 0; i < ARRAY_SIZE(accel_scale); ++i) {
-		if (accel_scale[i] == val) {
+		if (accel_scale[i] == val2) {
 			d = (i << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
 			result = regmap_write(st->map, st->reg->accl_config, d);
 			if (result)
@@ -814,10 +822,10 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			result = inv_mpu6050_write_gyro_scale(st, val2);
+			result = inv_mpu6050_write_gyro_scale(st, val, val2);
 			break;
 		case IIO_ACCEL:
-			result = inv_mpu6050_write_accel_scale(st, val2);
+			result = inv_mpu6050_write_accel_scale(st, val, val2);
 			break;
 		default:
 			result = -EINVAL;
-- 
2.20.1


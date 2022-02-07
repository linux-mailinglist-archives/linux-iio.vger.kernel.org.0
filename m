Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18C04AC212
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 15:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbiBGO5B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 09:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243658AbiBGOiv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 09:38:51 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AB9C0401C2
        for <linux-iio@vger.kernel.org>; Mon,  7 Feb 2022 06:38:50 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 95D2810000B;
        Mon,  7 Feb 2022 14:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644244729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtbQnhEz81lneaKZcLKPAztyGhNuQuVYHxbxMr65pPI=;
        b=BTjYW0Nm/01jAISATEVlG9q1hNFmJpZD0jpQ8wKVWcZhxBoyUGddwOWcYH38Y8IBvr3kkj
        6RJrPDDiJKmcV4hWF65/k8gu7tNq8M89c8pk7ddjRcirstYNBTwfp5/udQmSA1XoI0p/X6
        LYQBtD9B7ylNrccviTHUoE1zaL8iS72zMwVQveFAiDqktqPbh2asJ5UvPwGd6zBdniQtRr
        QA8PmR+s1mtRCb3cSuBYv6JGxGr021x8naxmagGh0Pw+ntnfdA0twwaPbZm9qnT+ZhH8JH
        wybD6n759T7604I6Bf69l6zlqA0HZhcdrt2wwxztxUstVOJa9nqLf+amtLt/aw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v3 07/13] iio: st_sensors: Stop abusing mlock to ensure internal coherency
Date:   Mon,  7 Feb 2022 15:38:34 +0100
Message-Id: <20220207143840.707510-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220207143840.707510-1-miquel.raynal@bootlin.com>
References: <20220207143840.707510-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

An odr_lock has been introduced to protect local accesses to the odr
internal cache and ensure the cached value always reflected the actual
value. Using the mlock() for this purpose is no longer needed, so let's
drop these extra mutex_lock/unlock() calls.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/accel/st_accel_core.c       | 8 ++------
 drivers/iio/gyro/st_gyro_core.c         | 8 ++------
 drivers/iio/magnetometer/st_magn_core.c | 8 ++------
 drivers/iio/pressure/st_pressure_core.c | 8 ++------
 4 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index ae0e6414e8f4..2ac13b3f2f58 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1126,8 +1126,6 @@ static int st_accel_read_raw(struct iio_dev *indio_dev,
 static int st_accel_write_raw(struct iio_dev *indio_dev,
 		struct iio_chan_spec const *chan, int val, int val2, long mask)
 {
-	int err;
-
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE: {
 		int gain;
@@ -1138,10 +1136,8 @@ static int st_accel_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&indio_dev->mlock);
-		err = st_sensors_set_odr(indio_dev, val);
-		mutex_unlock(&indio_dev->mlock);
-		return err;
+
+		return st_sensors_set_odr(indio_dev, val);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index f574ee7aca95..626f1f45dbcc 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -406,18 +406,14 @@ static int st_gyro_read_raw(struct iio_dev *indio_dev,
 static int st_gyro_write_raw(struct iio_dev *indio_dev,
 		struct iio_chan_spec const *chan, int val, int val2, long mask)
 {
-	int err;
-
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		return st_sensors_set_fullscale_by_gain(indio_dev, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&indio_dev->mlock);
-		err = st_sensors_set_odr(indio_dev, val);
-		mutex_unlock(&indio_dev->mlock);
-		return err;
+
+		return st_sensors_set_odr(indio_dev, val);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 34a0503bc571..e54fb7f09544 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -540,18 +540,14 @@ static int st_magn_read_raw(struct iio_dev *indio_dev,
 static int st_magn_write_raw(struct iio_dev *indio_dev,
 		struct iio_chan_spec const *chan, int val, int val2, long mask)
 {
-	int err;
-
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		return st_sensors_set_fullscale_by_gain(indio_dev, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&indio_dev->mlock);
-		err = st_sensors_set_odr(indio_dev, val);
-		mutex_unlock(&indio_dev->mlock);
-		return err;
+
+		return st_sensors_set_odr(indio_dev, val);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 26a1ee43d56e..05a909eeaff0 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -560,16 +560,12 @@ static int st_press_write_raw(struct iio_dev *indio_dev,
 			      int val2,
 			      long mask)
 {
-	int err;
-
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&indio_dev->mlock);
-		err = st_sensors_set_odr(indio_dev, val);
-		mutex_unlock(&indio_dev->mlock);
-		return err;
+
+		return st_sensors_set_odr(indio_dev, val);
 	default:
 		return -EINVAL;
 	}
-- 
2.27.0


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEDD4AC224
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 15:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358842AbiBGO5L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 09:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbiBGOiu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 09:38:50 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F20C0401C6
        for <linux-iio@vger.kernel.org>; Mon,  7 Feb 2022 06:38:48 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 06D3110000E;
        Mon,  7 Feb 2022 14:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644244726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ry6myupu84aZtV75/bByECo3fbRZ0TuCh6kABlxb/PY=;
        b=bmiVsAz3MWX8KQ7mYH+touwwaRBKjFtuGOGj4jWPHUvwisXJLMJs3/GcDz6TmZ4pmfSPad
        GeNG3n+4QNpK7RLoAu2tuYXcK8nRd4vSpYvG8t+dPVJV+CI+T5zgolVhcvFRbpJWjl+cfp
        rStdnF+Fe8A4DbCGBYL9fb7tmBvbTQtAYvpTkfTfpDuQ8iR0Eq9UqfftE8x17dHwHM5kaX
        7jTt51kPABsXb9lv+n1TsHDOcjwsEj09HaNW28elq7MLjEEq4BMcyIJ4FUrUnU0R+a4GKl
        BJ7WpGk5UmUKfG4KSragaJ167bX5xUGz1bDO085L+QxAVlVv3w1g/2TfmaEL7Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v3 04/13] iio: st_sensors: Return as early as possible from the _write_raw() callbacks
Date:   Mon,  7 Feb 2022 15:38:31 +0100
Message-Id: <20220207143840.707510-5-miquel.raynal@bootlin.com>
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

As there is no cleanup to do, let's return as early as possible in the
various ST sensor drivers _write_raw() callback functions.

There is no functional change.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/accel/st_accel_core.c       | 5 +----
 drivers/iio/gyro/st_gyro_core.c         | 7 ++-----
 drivers/iio/magnetometer/st_magn_core.c | 7 ++-----
 3 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 31ea19d0ba71..ae0e6414e8f4 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1133,8 +1133,7 @@ static int st_accel_write_raw(struct iio_dev *indio_dev,
 		int gain;
 
 		gain = val * 1000000 + val2;
-		err = st_sensors_set_fullscale_by_gain(indio_dev, gain);
-		break;
+		return st_sensors_set_fullscale_by_gain(indio_dev, gain);
 	}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
@@ -1146,8 +1145,6 @@ static int st_accel_write_raw(struct iio_dev *indio_dev,
 	default:
 		return -EINVAL;
 	}
-
-	return err;
 }
 
 static ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL();
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 201050b76fe5..f574ee7aca95 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -410,8 +410,7 @@ static int st_gyro_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		err = st_sensors_set_fullscale_by_gain(indio_dev, val2);
-		break;
+		return st_sensors_set_fullscale_by_gain(indio_dev, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
 			return -EINVAL;
@@ -420,10 +419,8 @@ static int st_gyro_write_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&indio_dev->mlock);
 		return err;
 	default:
-		err = -EINVAL;
+		return -EINVAL;
 	}
-
-	return err;
 }
 
 static ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL();
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 0806a1e65ce4..34a0503bc571 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -544,8 +544,7 @@ static int st_magn_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		err = st_sensors_set_fullscale_by_gain(indio_dev, val2);
-		break;
+		return st_sensors_set_fullscale_by_gain(indio_dev, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
 			return -EINVAL;
@@ -554,10 +553,8 @@ static int st_magn_write_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&indio_dev->mlock);
 		return err;
 	default:
-		err = -EINVAL;
+		return -EINVAL;
 	}
-
-	return err;
 }
 
 static ST_SENSORS_DEV_ATTR_SAMP_FREQ_AVAIL();
-- 
2.27.0


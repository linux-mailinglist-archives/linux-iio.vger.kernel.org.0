Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0659D4A728C
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 15:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344677AbiBBOCS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 09:02:18 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:59427 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiBBOCR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 09:02:17 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 5CF3720000A;
        Wed,  2 Feb 2022 14:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643810536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bt9AGrqWWyEM6RMruLH+3+eGpiiHTY/1iZcat4wi6lA=;
        b=RGY/qXxZMfKKNbFRBnWCuGvI67yJoNSJWo6m+5Iaq7nXH4IXtBONwDV8+LHes/uZNs7Wib
        dsxRARc/ChGUdnYcfKslqI5gw0bTq8uc7wTqtK1Rgy7eZXPz01wJWKqkniOU7mG39KrNBz
        TrpVSaw8URI+P404XADBvXs2cCe3q31qTqIwADcRoWnGGfz6Q6/R354N0cvqPm55F5A5oX
        u8QEUmZm7HiK57QGJoJ6SntgfmR0eY0p11D3gwb31L8NUCgd0v790iVoO1MP6hGQhgAYUX
        ZXamM1aOeuWU8cBJbUyOA0TcLKwkCXUaw3ts/m2Nx3f09hRJQU0ibc8i/yo8bQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v2 06/12] iio: st_sensors: Stop abusing mlock to ensure internal coherency
Date:   Wed,  2 Feb 2022 15:02:02 +0100
Message-Id: <20220202140208.391394-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220202140208.391394-1-miquel.raynal@bootlin.com>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
 drivers/iio/accel/st_accel_core.c       | 5 ++---
 drivers/iio/gyro/st_gyro_core.c         | 5 ++---
 drivers/iio/magnetometer/st_magn_core.c | 5 ++---
 drivers/iio/pressure/st_pressure_core.c | 8 ++------
 4 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 31ea19d0ba71..d314125269e4 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1139,10 +1139,9 @@ static int st_accel_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&indio_dev->mlock);
+
 		err = st_sensors_set_odr(indio_dev, val);
-		mutex_unlock(&indio_dev->mlock);
-		return err;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 201050b76fe5..46e3df1bfacb 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -415,10 +415,9 @@ static int st_gyro_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&indio_dev->mlock);
+
 		err = st_sensors_set_odr(indio_dev, val);
-		mutex_unlock(&indio_dev->mlock);
-		return err;
+		break;
 	default:
 		err = -EINVAL;
 	}
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 0806a1e65ce4..7b48e7a29cee 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -549,10 +549,9 @@ static int st_magn_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&indio_dev->mlock);
+
 		err = st_sensors_set_odr(indio_dev, val);
-		mutex_unlock(&indio_dev->mlock);
-		return err;
+		break;
 	default:
 		err = -EINVAL;
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


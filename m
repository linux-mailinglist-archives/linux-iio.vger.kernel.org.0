Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1E53ED043
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 10:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhHPIao (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 04:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbhHPIan (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 04:30:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453BC0613C1
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 01:30:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dj8so17280466edb.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5WMr44yPAMXR7U++aypQuBSuQpWu0zm/8yXjvAvdLxE=;
        b=H71IE2ezU7i4vmqOy956D6R5WpAa8yBdvbDU8iAIfAXbyEnWkCMEhWsUvjhbZ804YA
         XXS6ArFuaByhPuiNDhOYCYLkLmKkTbNm52h8CkLDrH0YuOPtAB5hzbCGCj96YKXdkF1m
         nHYsIaoaEP2jzary0gTK3YVSkVAtF9c9+zFx9CRfDtOz242ix3lBfcXtWdBUG2bXZqMZ
         SvHkWWW0JyUjiPXcccExKr5gT7xBgwH9cCSN/juFUTKn4JtjwIbBjH2yw32VpdWmpCta
         5uWN/fLc440JEsT5KwvQdrMHf23zwmY8oqQVLiMyhcOoWpH5J3GMA24mA6qpd3g1l2gR
         JTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5WMr44yPAMXR7U++aypQuBSuQpWu0zm/8yXjvAvdLxE=;
        b=EpnS4gDO2QshLC0btpEp4J06fBpTSRGn4EYZQrBPWTN9zXJNnQnv4I3BrvQ9oKWhIW
         OsaUNIJOkak5fS/wf4S7EqOGAHqcUukmOxxDit8fnXGwTqXz7Y8DkviBi3zgrgnPmqMY
         mRj3eefjfr9eZj//LWRQU+fI9VFBW3oINQP4+DbiXMRS+DwxBMD48bI8hRJkNguPUnwS
         5+ze6EhE/MURnat6NEM9YR6hOw7X2s4vwp2/n6HRTiKE2Rq1JnMKfhjF512WHLZmjeeN
         9+YV5dYir8UO56Yn9V+vB/SxbhtCdpq3t8XyNrLlbv7dWxA0hd+3M/EGcNyu+/hFhc7V
         c0IA==
X-Gm-Message-State: AOAM532pUdHvke6E+r/oqC7HoDOhcH3C2U/9WO76YUKesm1D9soeVzBd
        beNvTg5Va839sUa3LvKbsD4zZDs60ciWu5UD
X-Google-Smtp-Source: ABdhPJyWyjPeTJdTKsS1OTdHPZdN4O/7Wop/1dFFIYAkwQ4SPfhgo59urigk5bhM8QOrb0+3tU6stA==
X-Received: by 2002:a05:6402:17d7:: with SMTP id s23mr18483271edy.344.1629102610960;
        Mon, 16 Aug 2021 01:30:10 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id q30sm4516878edi.84.2021.08.16.01.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 01:30:10 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/5] iio: st_sensors: disable regulators after device unregistration
Date:   Mon, 16 Aug 2021 11:28:32 +0300
Message-Id: <20210816082836.67511-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816082836.67511-1-aardelean@deviqon.com>
References: <20210816082836.67511-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Up until commit ea7e586bdd331 ("iio: st_sensors: move regulator retrieveal
to core") only the ST pressure driver seems to have had any regulator
disable. After that commit, the regulator handling was moved into the
common st_sensors logic.

In all instances of this regulator handling, the regulators were disabled
before unregistering the IIO device.
This can cause issues where the device would be powered down and still be
available to userspace, allowing it to send invalid/garbage data.

This change moves the st_sensors_power_disable() after the common probe
functions. These common probe functions also handle unregistering the IIO
device.

Fixes: 774487611c949 ("iio: pressure-core: st: Provide support for the Vdd power supply")
Fixes: ea7e586bdd331 ("iio: st_sensors: move regulator retrieveal to core")
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Denis CIOCCA <denis.ciocca@st.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/st_accel_i2c.c       | 4 ++--
 drivers/iio/accel/st_accel_spi.c       | 4 ++--
 drivers/iio/gyro/st_gyro_i2c.c         | 4 ++--
 drivers/iio/gyro/st_gyro_spi.c         | 4 ++--
 drivers/iio/magnetometer/st_magn_i2c.c | 4 ++--
 drivers/iio/magnetometer/st_magn_spi.c | 4 ++--
 drivers/iio/pressure/st_pressure_i2c.c | 4 ++--
 drivers/iio/pressure/st_pressure_spi.c | 4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index f711756e41e3..cba57459e90a 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -193,10 +193,10 @@ static int st_accel_i2c_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_accel_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index bb45d9ff95b8..5167fae1ee8e 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -143,10 +143,10 @@ static int st_accel_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_accel_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 3ef86e16ee65..a8164fe48b85 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -106,10 +106,10 @@ static int st_gyro_i2c_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_gyro_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 41d835493347..9d8916871b4b 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -110,10 +110,10 @@ static int st_gyro_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_gyro_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 2dfe4ee99591..fa78f0a3b53e 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -102,10 +102,10 @@ static int st_magn_i2c_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_magn_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index fba978796395..ff43cbf61b05 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -96,10 +96,10 @@ static int st_magn_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_magn_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 52fa98f24478..6215de677017 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -119,10 +119,10 @@ static int st_press_i2c_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_press_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index ee393df54cee..5001aae8f00b 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -102,10 +102,10 @@ static int st_press_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	st_sensors_power_disable(indio_dev);
-
 	st_press_common_remove(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	return 0;
 }
 
-- 
2.31.1


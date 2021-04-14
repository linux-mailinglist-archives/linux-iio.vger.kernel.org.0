Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4E535F029
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 10:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345437AbhDNIuY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 04:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbhDNIuY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Apr 2021 04:50:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23330C061756
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 01:50:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id w23so14389085ejb.9
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKYXCW0j+tTrQuAe8GIX4MEDkI/Cgjtmucn5a1qWgnA=;
        b=EtzQmMnWkL9LGHP1xGfw8p/DZJHC3KSpHtK/JHwSEmR3o4kpZp14SR9OVGBDEMubYm
         jw3rYntByVaJlrcYnVuPk0Sa7+wqEMAXiSMvhWnuaa8nJ5xqG2fGzAzVJpH+C1iTHosR
         6sdemFHCEE2VoXAyeT5qpHClVPjzv7zof/6ZEEICUFLcfFqStL/TbXxhNmBl2sNka1W2
         rg2pVYNT275NoZ/x92zf1Xd5xO9SGwJcoHcyPsPKnGu3CmBOJ0wH+7C7i8io7GIZFI+Z
         O9FOwtVyTQTgD/lBP1x9V4p7FMynRV6wlwi8ATh8SjhcIf6jVIFZ3ufeDHKrwLkDSG2L
         wE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKYXCW0j+tTrQuAe8GIX4MEDkI/Cgjtmucn5a1qWgnA=;
        b=pbpIH2g74r35FQQwwEnaciEOfm461SGlckDs+vnD7rKjdW5GpmhpQnQXfqJ6lpp637
         1EzL96PrlTMP9vMrZooqUaffSNRBgQgzcwDB2DbHaHdZA+9/l0zdMViIvqsHaj/4ka7E
         1HhYsVRhhNWYB34dJyqcCcz/vx44WdHJ0NTRx2Hl88F/SbqVlC6hA0Q7UVK1sqg2/IIa
         OfriEBL+0957JEO6yZ0DfzWUnOiDDstDZIegMOIGjkVuGOh5hOXUL3gQOIWSDNGs5crD
         jVKDVOMgOdT3Tl+mDgRBMIpweac+bA86utdAqD32Qo4OYhd6AI0vsWIkhfB6e9oDasZk
         XPLQ==
X-Gm-Message-State: AOAM530zsteKgtWNaEDPHXd72WX99GPik6pZrULeb544c4k1zrYcb/mD
        ijaksahPMwP9HqBTZxjgB2LYY4moP34CvWJOQHW33A==
X-Google-Smtp-Source: ABdhPJz07DLU4OSds5Pwbn/zKcqDlfMXGhdWu97oY4cH/MvHnhkjhIzqsupkE+5Ut4u5NUb5khWLRg==
X-Received: by 2002:a17:906:aad9:: with SMTP id kt25mr35924599ejb.364.1618390201527;
        Wed, 14 Apr 2021 01:50:01 -0700 (PDT)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id y16sm11146038edc.62.2021.04.14.01.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 01:50:01 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Thomas Deutschmann <whissi@gentoo.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] iio: hid-sensors: select IIO_TRIGGERED_BUFFER under HID_SENSOR_IIO_TRIGGER
Date:   Wed, 14 Apr 2021 11:49:55 +0300
Message-Id: <20210414084955.260117-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

During commit 067fda1c065ff ("iio: hid-sensors: move triggered buffer
setup into hid_sensor_setup_trigger"), the
iio_triggered_buffer_{setup,cleanup}() functions got moved under the
hid-sensor-trigger module.

The above change works fine, if any of the sensors get built. However, when
only the common hid-sensor-trigger module gets built (and none of the
drivers), then the IIO_TRIGGERED_BUFFER symbol isn't selected/enforced.

Previously, each driver would enforce/select the IIO_TRIGGERED_BUFFER
symbol. With this change the HID_SENSOR_IIO_TRIGGER (for the
hid-sensor-trigger module) will enforce that IIO_TRIGGERED_BUFFER gets
selected.

All HID sensor drivers select the HID_SENSOR_IIO_TRIGGER symbol. So, this
change removes the IIO_TRIGGERED_BUFFER enforcement from each driver.

Fixes: 067fda1c065ff ("iio: hid-sensors: move triggered buffer setup into hid_sensor_setup_trigger")
Reported-by: Thomas Deutschmann <whissi@gentoo.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/Kconfig              | 1 -
 drivers/iio/common/hid-sensors/Kconfig | 1 +
 drivers/iio/gyro/Kconfig               | 1 -
 drivers/iio/humidity/Kconfig           | 1 -
 drivers/iio/light/Kconfig              | 2 --
 drivers/iio/magnetometer/Kconfig       | 1 -
 drivers/iio/orientation/Kconfig        | 2 --
 drivers/iio/pressure/Kconfig           | 1 -
 drivers/iio/temperature/Kconfig        | 1 -
 9 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index cceda3cecbcf..8b1723635cce 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -229,7 +229,6 @@ config DMARD10
 config HID_SENSOR_ACCEL_3D
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
 	select HID_SENSOR_IIO_COMMON
 	select HID_SENSOR_IIO_TRIGGER
 	tristate "HID Accelerometers 3D"
diff --git a/drivers/iio/common/hid-sensors/Kconfig b/drivers/iio/common/hid-sensors/Kconfig
index 24d492567336..2a3dd3b907be 100644
--- a/drivers/iio/common/hid-sensors/Kconfig
+++ b/drivers/iio/common/hid-sensors/Kconfig
@@ -19,6 +19,7 @@ config HID_SENSOR_IIO_TRIGGER
 	tristate "Common module (trigger) for all HID Sensor IIO drivers"
 	depends on HID_SENSOR_HUB && HID_SENSOR_IIO_COMMON && IIO_BUFFER
 	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build trigger support for HID sensors.
 	  Triggers will be send if all requested attributes were read.
diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 5824f2edf975..20b5ac7ab66a 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -111,7 +111,6 @@ config FXAS21002C_SPI
 config HID_SENSOR_GYRO_3D
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
 	select HID_SENSOR_IIO_COMMON
 	select HID_SENSOR_IIO_TRIGGER
 	tristate "HID Gyroscope 3D"
diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 6549fcf6db69..2de5494e7c22 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -52,7 +52,6 @@ config HID_SENSOR_HUMIDITY
 	tristate "HID Environmental humidity sensor"
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
 	select HID_SENSOR_IIO_COMMON
 	select HID_SENSOR_IIO_TRIGGER
 	help
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 33ad4dd0b5c7..917f9becf9c7 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -256,7 +256,6 @@ config ISL29125
 config HID_SENSOR_ALS
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
 	select HID_SENSOR_IIO_COMMON
 	select HID_SENSOR_IIO_TRIGGER
 	tristate "HID ALS"
@@ -270,7 +269,6 @@ config HID_SENSOR_ALS
 config HID_SENSOR_PROX
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
 	select HID_SENSOR_IIO_COMMON
 	select HID_SENSOR_IIO_TRIGGER
 	tristate "HID PROX"
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 5d4ffd66032e..74ad5701c6c2 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -95,7 +95,6 @@ config MAG3110
 config HID_SENSOR_MAGNETOMETER_3D
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
 	select HID_SENSOR_IIO_COMMON
 	select HID_SENSOR_IIO_TRIGGER
 	tristate "HID Magenetometer 3D"
diff --git a/drivers/iio/orientation/Kconfig b/drivers/iio/orientation/Kconfig
index a505583cc2fd..396cbbb867f4 100644
--- a/drivers/iio/orientation/Kconfig
+++ b/drivers/iio/orientation/Kconfig
@@ -9,7 +9,6 @@ menu "Inclinometer sensors"
 config HID_SENSOR_INCLINOMETER_3D
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
 	select HID_SENSOR_IIO_COMMON
 	select HID_SENSOR_IIO_TRIGGER
 	tristate "HID Inclinometer 3D"
@@ -20,7 +19,6 @@ config HID_SENSOR_INCLINOMETER_3D
 config HID_SENSOR_DEVICE_ROTATION
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
 	select HID_SENSOR_IIO_COMMON
 	select HID_SENSOR_IIO_TRIGGER
 	tristate "HID Device Rotation"
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 689b978db4f9..fc0d3cfca418 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -79,7 +79,6 @@ config DPS310
 config HID_SENSOR_PRESS
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
 	select HID_SENSOR_IIO_COMMON
 	select HID_SENSOR_IIO_TRIGGER
 	tristate "HID PRESS"
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index c5482983f568..f20ae3c963cb 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -45,7 +45,6 @@ config HID_SENSOR_TEMP
 	tristate "HID Environmental temperature sensor"
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
 	select HID_SENSOR_IIO_COMMON
 	select HID_SENSOR_IIO_TRIGGER
 	help
-- 
2.30.2


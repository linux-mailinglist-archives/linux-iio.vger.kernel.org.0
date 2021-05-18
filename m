Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F394388307
	for <lists+linux-iio@lfdr.de>; Wed, 19 May 2021 01:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbhERXTj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 19:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbhERXTj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 19:19:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E093EC061573
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 16:18:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i22so16124966lfl.10
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 16:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irolTlUJ/KdkzCKIeleRBgf1f1E4OAmrd8Ih0c8KsL0=;
        b=AK3fU8VyKkWLvM+Tz1N/bCkUUQZ2ujPDQdAvR+pzrObdsF27TPNkMpISOmr/DWYdVO
         8ZTRBbLsU/6XL1/xCQMvKmIJARgtUtbr3iIXEZj/p6W+ToZh0T2DfwrPajNtufPcOdJY
         ChLDEhM1TW474WLw0pTWgrWEe0yP2oPSawwzbjIFI50mUBVWTwExCfu1LcA3UDtQDgV2
         OdiG/Ta6/ICaD1oXDlUx0SJLFmlKoRq5MN9vBEvq/9UtroOgCQcNDBAyM27DEqsZLGWi
         k+DCMnpSwyfyODZlM37vKOO+RDdYFe5RpZ34Kur4Nzxn5F23gNUczNMuAq+BYiegn1I7
         iH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irolTlUJ/KdkzCKIeleRBgf1f1E4OAmrd8Ih0c8KsL0=;
        b=p4rOMGNCJtt69cdJ/b41mFL/5e8FydKN+0qwHqIRZQATBXlf+qSHUMYZdrzvswtdPV
         28Umf3xxANTW2x8bxNXNECfGw2K6RXjF7bnQ7ppXXa6AfkYfqJAWYLhCsmJbYTP8mcHt
         cUZGBBd75sy55PyrdjnC01eHBlUy5IW8IDkrgY/7i3ig9WmRukHOG7AvEk6jGVx2CCm5
         Sqx5rIPpSJoOTtpjdbMvqJ4Ubl7ThN9Wl+s4j26byoO/8JRtSOY7Jv10LSds45Pl6sQT
         EPCodqjARogv/44nfKHFZQdDMO4JPEvBl7EVKEeaOcFglsTdnr+hjMYxtFGGYN6kEHVt
         2ZTw==
X-Gm-Message-State: AOAM531DUQGGF+RnDPREV0D7zu8sZyhWyv6riNeQtd8yelThP3khrpn9
        CzfRQmL6ACYRFNgGibC7MoI36g==
X-Google-Smtp-Source: ABdhPJxldTA5tLnSfkCyYsQynXeiBrv4cUFnn65NwsRhF5Qp0wil5K9FegIBjG76NOeVYBLOY5Muxg==
X-Received: by 2002:a05:6512:3f21:: with SMTP id y33mr5888027lfa.430.1621379897379;
        Tue, 18 May 2021 16:18:17 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d10sm1666392lfi.79.2021.05.18.16.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:18:16 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/5 v3] iio: accel: st_sensors: Support generic mounting matrix
Date:   Wed, 19 May 2021 01:07:19 +0200
Message-Id: <20210518230722.522446-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518230722.522446-1-linus.walleij@linaro.org>
References: <20210518230722.522446-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ST accelerators support a special type of quirky mounting matrix found
in ACPI systems, but not a generic mounting matrix such as from the device
tree.

Augment the ACPI hack to be a bit more generic and accept a mounting
matrix from device properties.

This makes it possible to fix orientation on the Ux500 HREF device.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Daniel Drake <drake@endlessm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebase on Andy's patches and mount-matrix generalization
- Drop surplus comma after sentinel
- Reword ACPI quirk call site
ChangeLog v1->v2:
- Make the .mount_matrix member of st_sensor_data a full member
  instead of a pointer so we get rid of a bunch of unneeded
  allocations that could fail.
- Make a drive-by fix to the kerneldoc.
- Use the new ST_SENSORS_LSM_CHANNELS_EXT() to define the channels
  with the extended attribute for mounting matrix.
- Demote the error message at the end of apply_acpi_orientation()
  to dev_dbg() and only print it of ret != 0.
---
 drivers/iio/accel/st_accel_core.c     | 112 ++++++++++++++------------
 include/linux/iio/common/st_sensors.h |   4 +-
 2 files changed, 62 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index dc32ebefe3fc..9abcebf767b1 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -41,51 +41,74 @@
 #define ST_ACCEL_FS_AVL_200G			200
 #define ST_ACCEL_FS_AVL_400G			400
 
+static const struct iio_mount_matrix *
+st_accel_get_mount_matrix(const struct iio_dev *indio_dev,
+			  const struct iio_chan_spec *chan)
+{
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	return &adata->mount_matrix;
+}
+
+static const struct iio_chan_spec_ext_info st_accel_mount_matrix_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_accel_get_mount_matrix),
+	{ }
+};
+
 static const struct iio_chan_spec st_accel_8bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 8, 8,
-			ST_ACCEL_DEFAULT_OUT_X_L_ADDR+1),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			ST_ACCEL_DEFAULT_OUT_X_L_ADDR+1,
+			st_accel_mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 8, 8,
-			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR+1),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR+1,
+			st_accel_mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 8, 8,
-			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR+1),
+			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR+1,
+			st_accel_mount_matrix_ext_info),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
 static const struct iio_chan_spec st_accel_12bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 12, 16,
-			ST_ACCEL_DEFAULT_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			ST_ACCEL_DEFAULT_OUT_X_L_ADDR,
+			st_accel_mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 12, 16,
-			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR,
+			st_accel_mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 12, 16,
-			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR),
+			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR,
+			st_accel_mount_matrix_ext_info),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
 static const struct iio_chan_spec st_accel_16bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
-			ST_ACCEL_DEFAULT_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			ST_ACCEL_DEFAULT_OUT_X_L_ADDR,
+			st_accel_mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
-			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
+			ST_ACCEL_DEFAULT_OUT_Y_L_ADDR,
+			st_accel_mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
-			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR),
+			ST_ACCEL_DEFAULT_OUT_Z_L_ADDR,
+			st_accel_mount_matrix_ext_info),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
@@ -1162,25 +1185,10 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
 #endif
 
 #ifdef CONFIG_ACPI
-static const struct iio_mount_matrix *
-get_mount_matrix(const struct iio_dev *indio_dev,
-		 const struct iio_chan_spec *chan)
-{
-	struct st_sensor_data *adata = iio_priv(indio_dev);
-
-	return adata->mount_matrix;
-}
-
-static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
-	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),
-	{ },
-};
-
 /* Read ST-specific _ONT orientation data from ACPI and generate an
  * appropriate mount matrix.
  */
-static int apply_acpi_orientation(struct iio_dev *indio_dev,
-				  struct iio_chan_spec *channels)
+static int apply_acpi_orientation(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
@@ -1269,14 +1277,6 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
 	}
 
 	/* Convert our integer matrix to a string-based iio_mount_matrix */
-	adata->mount_matrix = devm_kmalloc(&indio_dev->dev,
-					   sizeof(*adata->mount_matrix),
-					   GFP_KERNEL);
-	if (!adata->mount_matrix) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
 	for (i = 0; i < 3; i++) {
 		for (j = 0; j < 3; j++) {
 			int matrix_val = final_ont[i][j];
@@ -1295,26 +1295,25 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
 			default:
 				goto out;
 			}
-			adata->mount_matrix->rotation[i * 3 + j] = str_value;
+			adata->mount_matrix.rotation[i * 3 + j] = str_value;
 		}
 	}
 
-	/* Expose the mount matrix via ext_info */
-	for (i = 0; i < indio_dev->num_channels; i++)
-		channels[i].ext_info = mount_matrix_ext_info;
-
 	ret = 0;
 	dev_info(&indio_dev->dev, "computed mount matrix from ACPI\n");
 
 out:
 	kfree(buffer.pointer);
+	if (ret)
+		dev_dbg(&indio_dev->dev,
+			"failed to apply ACPI orientation data: %d\n", ret);
+
 	return ret;
 }
 #else /* !CONFIG_ACPI */
-static int apply_acpi_orientation(struct iio_dev *indio_dev,
-				  struct iio_chan_spec *channels)
+static int apply_acpi_orientation(struct iio_dev *indio_dev)
 {
-	return 0;
+	return -EINVAL;
 }
 #endif
 
@@ -1361,9 +1360,16 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 	if (!channels)
 		return -ENOMEM;
 
-	if (apply_acpi_orientation(indio_dev, channels))
-		dev_warn(&indio_dev->dev,
-			 "failed to apply ACPI orientation data: %d\n", err);
+	/*
+	 * First try specific ACPI methods to retrieve orientation then try the
+	 * generic function.
+	 */
+	err = apply_acpi_orientation(indio_dev);
+	if (err) {
+		err = iio_read_mount_matrix(adata->dev, &adata->mount_matrix);
+		if (err)
+			return err;
+	}
 
 	indio_dev->channels = channels;
 	adata->current_fullscale = &adata->sensor_settings->fs.fs_avl[0];
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 8e0d76b42db9..8bdbaf3f3796 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/irqreturn.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 #include <linux/bitops.h>
 #include <linux/regulator/consumer.h>
@@ -221,6 +222,7 @@ struct st_sensor_settings {
  * struct st_sensor_data - ST sensor device status
  * @dev: Pointer to instance of struct device (I2C or SPI).
  * @trig: The trigger in use by the core driver.
+ * @mount_matrix: The mounting matrix of the sensor.
  * @sensor_settings: Pointer to the specific sensor settings in use.
  * @current_fullscale: Maximum range of measure by the sensor.
  * @vdd: Pointer to sensor's Vdd power supply
@@ -240,7 +242,7 @@ struct st_sensor_settings {
 struct st_sensor_data {
 	struct device *dev;
 	struct iio_trigger *trig;
-	struct iio_mount_matrix *mount_matrix;
+	struct iio_mount_matrix mount_matrix;
 	struct st_sensor_settings *sensor_settings;
 	struct st_sensor_fullscale_avl *current_fullscale;
 	struct regulator *vdd;
-- 
2.31.1


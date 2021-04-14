Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C1E35FC00
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 21:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353553AbhDNTzU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 15:55:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:14799 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234221AbhDNTzS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Apr 2021 15:55:18 -0400
IronPort-SDR: /fxuuKkazkpa2rtgmWsRig1SNOQI4y+ik3Z8mZzcIroWHEWSoGJ+R9M937hFqV/jVwWdEAqGWv
 2+606XTno94g==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="174221165"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="174221165"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 12:54:55 -0700
IronPort-SDR: iLzKHbDYxDY/qOMg+QfF3V+gEWyCDN3qxL3XDicwBuR28h+UuWNGVOCdirKxvkxDHENi6TuW5p
 WBf+xlJXSX2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="450893111"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Apr 2021 12:54:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BA8DD142; Wed, 14 Apr 2021 22:55:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Ga=C3=ABtan=20Andr=C3=A9?= <rvlander@gaetanandre.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v1 3/7] iio: magnetometer: st_magn: Provide default platform data
Date:   Wed, 14 Apr 2021 22:54:50 +0300
Message-Id: <20210414195454.84183-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
References: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Provide default platform data for magnetometer in case it supports DRDY.

One case is LSM9DS0 IMU, on which it is the case. Since accelerometer
is using INT1, default magnetometer to INT2.

While at it, update description of the drdy_int_pin field.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/st_magn_core.c        | 11 ++++++++++-
 include/linux/platform_data/st_sensors_pdata.h |  3 ++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 79de721e6015..cf3722e42419 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -382,6 +382,11 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 	},
 };
 
+/* Default magn DRDY is available on INT2 pin */
+static const struct st_sensors_platform_data default_magn_pdata = {
+	.drdy_int_pin = 2,
+};
+
 static int st_magn_read_raw(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *ch, int *val,
 							int *val2, long mask)
@@ -489,6 +494,7 @@ EXPORT_SYMBOL(st_magn_get_settings);
 int st_magn_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
+	struct st_sensors_platform_data *pdata = dev_get_platdata(mdata->dev);
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -509,7 +515,10 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	mdata->current_fullscale = &mdata->sensor_settings->fs.fs_avl[0];
 	mdata->odr = mdata->sensor_settings->odr.odr_avl[0].hz;
 
-	err = st_sensors_init_sensor(indio_dev, NULL);
+	if (!pdata)
+		pdata = (struct st_sensors_platform_data *)&default_magn_pdata;
+
+	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
 		goto st_magn_power_off;
 
diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
index e40b28ca892e..897051e51b78 100644
--- a/include/linux/platform_data/st_sensors_pdata.h
+++ b/include/linux/platform_data/st_sensors_pdata.h
@@ -13,8 +13,9 @@
 /**
  * struct st_sensors_platform_data - Platform data for the ST sensors
  * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
- *	Available only for accelerometer and pressure sensors.
+ *	Available only for accelerometer, magnetometer and pressure sensors.
  *	Accelerometer DRDY on LSM330 available only on pin 1 (see datasheet).
+ *	Magnetometer DRDY is supported only on LSM9DS0.
  * @open_drain: set the interrupt line to be open drain if possible.
  * @spi_3wire: enable spi-3wire mode.
  * @pullups: enable/disable i2c controller pullup resistors.
-- 
2.30.2


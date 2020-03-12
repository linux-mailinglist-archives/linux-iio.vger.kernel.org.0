Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B84F183013
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 13:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCLMTn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 08:19:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:22023 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgCLMTm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Mar 2020 08:19:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 05:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="243004379"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 12 Mar 2020 05:19:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 76B039C; Thu, 12 Mar 2020 14:19:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/5] iio: st_sensors: Use dev_get_platdata() to get platform_data
Date:   Thu, 12 Mar 2020 14:19:35 +0200
Message-Id: <20200312121938.45608-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312121938.45608-1-andriy.shevchenko@linux.intel.com>
References: <20200312121938.45608-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use dev_get_platdata() to get the platform_data instead of
referencing it directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/st_accel_core.c              | 3 +--
 drivers/iio/common/st_sensors/st_sensors_spi.c | 2 +-
 drivers/iio/pressure/st_pressure_core.c        | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 7320275c7e56..5f7bdb1f55d1 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1170,8 +1170,7 @@ EXPORT_SYMBOL(st_accel_get_settings);
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
-	struct st_sensors_platform_data *pdata =
-		(struct st_sensors_platform_data *)adata->dev->platform_data;
+	struct st_sensors_platform_data *pdata = dev_get_platdata(adata->dev);
 	struct iio_chan_spec *channels;
 	size_t channels_size;
 	int err;
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 1275fb0eda31..dcbdef4a77f8 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -44,7 +44,7 @@ static bool st_sensors_is_spi_3_wire(struct spi_device *spi)
 	if (device_property_read_bool(dev, "spi-3wire"))
 		return true;
 
-	pdata = (struct st_sensors_platform_data *)dev->platform_data;
+	pdata = dev_get_platdata(dev);
 	if (pdata && pdata->spi_3wire)
 		return true;
 
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index bd972cec4830..8bb47c3b4d6b 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -683,8 +683,7 @@ EXPORT_SYMBOL(st_press_get_settings);
 int st_press_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
-	struct st_sensors_platform_data *pdata =
-		(struct st_sensors_platform_data *)press_data->dev->platform_data;
+	struct st_sensors_platform_data *pdata = dev_get_platdata(press_data->dev);
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.25.1


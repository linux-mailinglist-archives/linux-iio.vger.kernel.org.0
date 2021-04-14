Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5FA35FBFF
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 21:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353546AbhDNTzS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 15:55:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:14799 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353523AbhDNTzR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Apr 2021 15:55:17 -0400
IronPort-SDR: nEZ3Umdn+EiA9XocrrnrFBJljyKSo08e3aZDvSv/IXLWOic+3MwpWJkqYH/XhTluoKm8n11ow6
 m9TLDeAYNhvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="174221160"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="174221160"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 12:54:55 -0700
IronPort-SDR: yx2x8CrA7R+ASkMpdtvlqkJM+5qLy77Y6P8ButzWonvj1yazytQcKuvIlAGevsWhEBv1F6gJzY
 UslturRF4h6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="424883258"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 14 Apr 2021 12:54:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2E77112A; Wed, 14 Apr 2021 22:55:08 +0300 (EEST)
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
Subject: [PATCH v1 2/7] iio: gyro: st_gyro: Move platform data from header to C file
Date:   Wed, 14 Apr 2021 22:54:49 +0300
Message-Id: <20210414195454.84183-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
References: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Platform data is solely used by one file. Don't share it with others.

While at it, drop unneeded anymore __maybe_unused and fix kernel doc
to avoid warning:

  st_gyro_core.c:366: error: Cannot parse struct or union!

by converting to a simple comment. It is described at the declaration.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/gyro/st_gyro.h      | 8 --------
 drivers/iio/gyro/st_gyro_core.c | 5 +++++
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index fd9171cc3aba..b385fe664dcc 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -24,14 +24,6 @@
 #define LSM330_GYRO_DEV_NAME		"lsm330_gyro"
 #define LSM9DS0_GYRO_DEV_NAME		"lsm9ds0_gyro"
 
-/**
- * struct st_sensors_platform_data - gyro platform data
- * @drdy_int_pin: DRDY on gyros is available only on INT2 pin.
- */
-static __maybe_unused const struct st_sensors_platform_data gyro_pdata = {
-	.drdy_int_pin = 2,
-};
-
 const struct st_sensor_settings *st_gyro_get_settings(const char *name);
 int st_gyro_common_probe(struct iio_dev *indio_dev);
 void st_gyro_common_remove(struct iio_dev *indio_dev);
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index c8aa051995d3..e000504e1df4 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -357,6 +357,11 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 	},
 };
 
+/* DRDY on gyros is available only on INT2 pin */
+static const struct st_sensors_platform_data gyro_pdata = {
+	.drdy_int_pin = 2,
+};
+
 static int st_gyro_read_raw(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *ch, int *val,
 							int *val2, long mask)
-- 
2.30.2


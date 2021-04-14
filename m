Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE69135FBFB
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 21:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhDNTzF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 15:55:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:24033 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234221AbhDNTzE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Apr 2021 15:55:04 -0400
IronPort-SDR: YJXZP66igMd6NYI1XTDQ3+PnEpZqOTM7e0KSD7A77EU1vzbGGfzVha9S0Hbexmnc2qcYQuooCH
 0Ojy/xDkAedg==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="194746787"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="194746787"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 12:54:42 -0700
IronPort-SDR: uIZik0HELf6Ho3DWaXwnW3kA6Ctv6iworPDgFeoiw1dnpyGBAWNEhcwykydtS0eKggA0Ft5qUW
 +pbAFTtA8o+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="424883201"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 14 Apr 2021 12:54:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 36FC712A; Wed, 14 Apr 2021 22:54:54 +0300 (EEST)
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
Subject: [PATCH v1 1/7] iio: accel: st_accel: Move platform data from header to C file
Date:   Wed, 14 Apr 2021 22:54:48 +0300
Message-Id: <20210414195454.84183-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Platform data is solely used by one file. Don't share it with others.

While at it, drop unneeded anymore __maybe_unused and fix kernel doc
to avoid warning:

  st_accel_core.c:1079: error: Cannot parse struct or union!

by converting to a simple comment. It is described at the declaration.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/st_accel.h      | 8 --------
 drivers/iio/accel/st_accel_core.c | 5 +++++
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 5d356288e001..181ebe79c4eb 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -62,14 +62,6 @@ enum st_accel_type {
 #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
 #define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
 
-/**
-* struct st_sensors_platform_data - default accel platform data
-* @drdy_int_pin: default accel DRDY is available on INT1 pin.
-*/
-static __maybe_unused const struct st_sensors_platform_data default_accel_pdata = {
-	.drdy_int_pin = 1,
-};
-
 const struct st_sensor_settings *st_accel_get_settings(const char *name);
 int st_accel_common_probe(struct iio_dev *indio_dev);
 void st_accel_common_remove(struct iio_dev *indio_dev);
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 43c50167d220..a1bd7e3b912e 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -983,6 +983,11 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 
 };
 
+/* Default accel DRDY is available on INT1 pin */
+static const struct st_sensors_platform_data default_accel_pdata = {
+	.drdy_int_pin = 1,
+};
+
 static int st_accel_read_raw(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *ch, int *val,
 							int *val2, long mask)
-- 
2.30.2


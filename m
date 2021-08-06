Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DF23E2B2F
	for <lists+linux-iio@lfdr.de>; Fri,  6 Aug 2021 15:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbhHFNJM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Aug 2021 09:09:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:14708 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343976AbhHFNJJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Aug 2021 09:09:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="201549752"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="201549752"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 06:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="467878389"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2021 06:08:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A7DE1DE; Fri,  6 Aug 2021 16:02:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Jason M ." <jason@montleon.com>
Subject: [PATCH v1 1/1] iio: cros_ec: Fix Kconfig dependency on CROS_EC_SENSORHUB
Date:   Fri,  6 Aug 2021 16:02:27 +0300
Message-Id: <20210806130227.69473-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When CONFIG_CROS_EC_SENSORHUB is set to m, the IIO_CROS_EC_SENSORS_CORE
can't be built-in.

Fixes: 53067471188c ("iio / platform: cros_ec: Add cros-ec-sensorhub driver")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213979
Reported-by: Jason M. <jason@montleon.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/common/cros_ec_sensors/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
index fefad9572790..b0d67ceaed55 100644
--- a/drivers/iio/common/cros_ec_sensors/Kconfig
+++ b/drivers/iio/common/cros_ec_sensors/Kconfig
@@ -4,7 +4,8 @@
 #
 config IIO_CROS_EC_SENSORS_CORE
 	tristate "ChromeOS EC Sensors Core"
-	depends on SYSFS && CROS_EC_SENSORHUB
+	depends on CROS_EC_SENSORHUB=y || (CROS_EC_SENSORHUB=m && m)
+	depends on SYSFS
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-- 
2.30.2


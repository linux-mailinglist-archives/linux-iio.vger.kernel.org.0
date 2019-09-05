Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FECEAA15F
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2019 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbfIEL2E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Sep 2019 07:28:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:52846 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfIEL2E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Sep 2019 07:28:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 04:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,470,1559545200"; 
   d="scan'208";a="199263001"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Sep 2019 04:28:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B19D52731; Thu,  5 Sep 2019 14:27:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v1] iio: hid-sensor-attributes: Fix divisions for 32-bit platforms
Date:   Thu,  5 Sep 2019 14:27:59 +0300
Message-Id: <20190905112759.13035-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The commit 473d12f7638c

  ("iio: hid-sensor-attributes: Convert to use int_pow()")

converted to use generic int_pow() helper. Though, the generic one returns
64-bit value and, in cases when it is used as divisor, it compels 64-bit
division from compiler.

In order to fix this, introduce a temporary 32-bit variable to hold the result
of int_pow() and use it as divisor afterwards.

In couple of cases, replace int_pow() with a predefined unit factors for time
and frequency.

Fixes: 473d12f7638c ("iio: hid-sensor-attributes: Convert to use int_pow()")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../hid-sensors/hid-sensor-attributes.c       | 42 ++++++++++++-------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index b9dd19b34267..442ff787f7af 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -10,10 +10,14 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/time.h>
+
 #include <linux/hid-sensor-hub.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
+#define HZ_PER_MHZ	1000000L
+
 static struct {
 	u32 usage_id;
 	int unit; /* 0 for default others from HID sensor spec */
@@ -93,8 +97,10 @@ static void simple_div(int dividend, int divisor, int *whole,
 
 static void split_micro_fraction(unsigned int no, int exp, int *val1, int *val2)
 {
-	*val1 = no / int_pow(10, exp);
-	*val2 = no % int_pow(10, exp) * int_pow(10, 6 - exp);
+	int divisor = int_pow(10, exp);
+
+	*val1 = no / divisor;
+	*val2 = no % divisor * int_pow(10, 6 - exp);
 }
 
 /*
@@ -129,6 +135,7 @@ static void convert_from_vtf_format(u32 value, int size, int exp,
 
 static u32 convert_to_vtf_format(int size, int exp, int val1, int val2)
 {
+	int divisor;
 	u32 value;
 	int sign = 1;
 
@@ -136,10 +143,13 @@ static u32 convert_to_vtf_format(int size, int exp, int val1, int val2)
 		sign = -1;
 	exp = hid_sensor_convert_exponent(exp);
 	if (exp < 0) {
+		divisor = int_pow(10, 6 + exp);
 		value = abs(val1) * int_pow(10, -exp);
-		value += abs(val2) / int_pow(10, 6 + exp);
-	} else
-		value = abs(val1) / int_pow(10, exp);
+		value += abs(val2) / divisor;
+	} else {
+		divisor = int_pow(10, exp);
+		value = abs(val1) / divisor;
+	}
 	if (sign < 0)
 		value =  ((1LL << (size * 8)) - value);
 
@@ -202,12 +212,12 @@ int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
 	if (val1 < 0 || val2 < 0)
 		return -EINVAL;
 
-	value = val1 * int_pow(10, 6) + val2;
+	value = val1 * HZ_PER_MHZ + val2;
 	if (value) {
 		if (st->poll.units == HID_USAGE_SENSOR_UNITS_MILLISECOND)
-			value = int_pow(10, 9) / value;
+			value = NSEC_PER_SEC / value;
 		else if (st->poll.units == HID_USAGE_SENSOR_UNITS_SECOND)
-			value = int_pow(10, 6) / value;
+			value = USEC_PER_SEC / value;
 		else
 			value = 0;
 	}
@@ -296,6 +306,7 @@ EXPORT_SYMBOL(hid_sensor_write_raw_hyst_value);
 static void adjust_exponent_nano(int *val0, int *val1, int scale0,
 				  int scale1, int exp)
 {
+	int divisor;
 	int i;
 	int x;
 	int res;
@@ -309,9 +320,10 @@ static void adjust_exponent_nano(int *val0, int *val1, int scale0,
 			return;
 		}
 		for (i = 0; i < exp; ++i) {
-			x = scale1 / int_pow(10, 8 - i);
+			divisor = int_pow(10, 8 - i);
+			x = scale1 / divisor;
 			res += int_pow(10, exp - 1 - i) * x;
-			scale1 = scale1 % int_pow(10, 8 - i);
+			scale1 = scale1 % divisor;
 		}
 		*val0 += res;
 		*val1 = scale1 * int_pow(10, exp);
@@ -321,13 +333,15 @@ static void adjust_exponent_nano(int *val0, int *val1, int scale0,
 			*val0 = *val1 = 0;
 			return;
 		}
-		*val0 = scale0 / int_pow(10, exp);
-		rem = scale0 % int_pow(10, exp);
+		divisor = int_pow(10, exp);
+		*val0 = scale0 / divisor;
+		rem = scale0 % divisor;
 		res = 0;
 		for (i = 0; i < (9 - exp); ++i) {
-			x = scale1 / int_pow(10, 8 - i);
+			divisor = int_pow(10, 8 - i);
+			x = scale1 / divisor;
 			res += int_pow(10, 8 - exp - i) * x;
-			scale1 = scale1 % int_pow(10, 8 - i);
+			scale1 = scale1 % divisor;
 		}
 		*val1 = rem * int_pow(10, 9 - exp) + res;
 	} else {
-- 
2.23.0.rc1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9614BABD
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2019 16:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfFSOHH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jun 2019 10:07:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:24467 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbfFSOHG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 Jun 2019 10:07:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 07:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="162222109"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 19 Jun 2019 07:07:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3BEEA177; Wed, 19 Jun 2019 17:07:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] iio: hid-sensor-attributes: Convert to use int_pow()
Date:   Wed, 19 Jun 2019 17:07:02 +0300
Message-Id: <20190619140702.18506-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Instead of linear approach to calculate power of 10, use generic int_pow()
which does it better.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../hid-sensors/hid-sensor-attributes.c       | 53 ++++++++-----------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index a8a3fe428d8d..b9dd19b34267 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/hid-sensor-hub.h>
 #include <linux/iio/iio.h>
@@ -68,16 +69,6 @@ static struct {
 	{HID_USAGE_SENSOR_HUMIDITY, 0, 1000, 0},
 };
 
-static int pow_10(unsigned power)
-{
-	int i;
-	int ret = 1;
-	for (i = 0; i < power; ++i)
-		ret = ret * 10;
-
-	return ret;
-}
-
 static void simple_div(int dividend, int divisor, int *whole,
 				int *micro_frac)
 {
@@ -96,14 +87,14 @@ static void simple_div(int dividend, int divisor, int *whole,
 			rem *= 10;
 			exp++;
 		}
-		*micro_frac = (rem / divisor) * pow_10(6-exp);
+		*micro_frac = (rem / divisor) * int_pow(10, 6 - exp);
 	}
 }
 
 static void split_micro_fraction(unsigned int no, int exp, int *val1, int *val2)
 {
-	*val1 = no/pow_10(exp);
-	*val2 = no%pow_10(exp) * pow_10(6-exp);
+	*val1 = no / int_pow(10, exp);
+	*val2 = no % int_pow(10, exp) * int_pow(10, 6 - exp);
 }
 
 /*
@@ -125,7 +116,7 @@ static void convert_from_vtf_format(u32 value, int size, int exp,
 	}
 	exp = hid_sensor_convert_exponent(exp);
 	if (exp >= 0) {
-		*val1 = sign * value * pow_10(exp);
+		*val1 = sign * value * int_pow(10, exp);
 		*val2 = 0;
 	} else {
 		split_micro_fraction(value, -exp, val1, val2);
@@ -145,10 +136,10 @@ static u32 convert_to_vtf_format(int size, int exp, int val1, int val2)
 		sign = -1;
 	exp = hid_sensor_convert_exponent(exp);
 	if (exp < 0) {
-		value = abs(val1) * pow_10(-exp);
-		value += abs(val2) / pow_10(6+exp);
+		value = abs(val1) * int_pow(10, -exp);
+		value += abs(val2) / int_pow(10, 6 + exp);
 	} else
-		value = abs(val1) / pow_10(exp);
+		value = abs(val1) / int_pow(10, exp);
 	if (sign < 0)
 		value =  ((1LL << (size * 8)) - value);
 
@@ -211,12 +202,12 @@ int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
 	if (val1 < 0 || val2 < 0)
 		return -EINVAL;
 
-	value = val1 * pow_10(6) + val2;
+	value = val1 * int_pow(10, 6) + val2;
 	if (value) {
 		if (st->poll.units == HID_USAGE_SENSOR_UNITS_MILLISECOND)
-			value = pow_10(9)/value;
+			value = int_pow(10, 9) / value;
 		else if (st->poll.units == HID_USAGE_SENSOR_UNITS_SECOND)
-			value = pow_10(6)/value;
+			value = int_pow(10, 6) / value;
 		else
 			value = 0;
 	}
@@ -311,34 +302,34 @@ static void adjust_exponent_nano(int *val0, int *val1, int scale0,
 	int rem;
 
 	if (exp > 0) {
-		*val0 = scale0 * pow_10(exp);
+		*val0 = scale0 * int_pow(10, exp);
 		res = 0;
 		if (exp > 9) {
 			*val1 = 0;
 			return;
 		}
 		for (i = 0; i < exp; ++i) {
-			x = scale1 / pow_10(8 - i);
-			res += (pow_10(exp - 1 - i) * x);
-			scale1 = scale1 % pow_10(8 - i);
+			x = scale1 / int_pow(10, 8 - i);
+			res += int_pow(10, exp - 1 - i) * x;
+			scale1 = scale1 % int_pow(10, 8 - i);
 		}
 		*val0 += res;
-		*val1 = scale1 * pow_10(exp);
+		*val1 = scale1 * int_pow(10, exp);
 	} else if (exp < 0) {
 		exp = abs(exp);
 		if (exp > 9) {
 			*val0 = *val1 = 0;
 			return;
 		}
-		*val0 = scale0 / pow_10(exp);
-		rem = scale0 % pow_10(exp);
+		*val0 = scale0 / int_pow(10, exp);
+		rem = scale0 % int_pow(10, exp);
 		res = 0;
 		for (i = 0; i < (9 - exp); ++i) {
-			x = scale1 / pow_10(8 - i);
-			res += (pow_10(8 - exp - i) * x);
-			scale1 = scale1 % pow_10(8 - i);
+			x = scale1 / int_pow(10, 8 - i);
+			res += int_pow(10, 8 - exp - i) * x;
+			scale1 = scale1 % int_pow(10, 8 - i);
 		}
-		*val1 = rem * pow_10(9 - exp) + res;
+		*val1 = rem * int_pow(10, 9 - exp) + res;
 	} else {
 		*val0 = scale0;
 		*val1 = scale1;
-- 
2.20.1


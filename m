Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E27ABCE0
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2019 17:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404907AbfIFPrK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Sep 2019 11:47:10 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41265 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394889AbfIFPrK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Sep 2019 11:47:10 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N1M4p-1iH0lp1SZ9-012o5x; Fri, 06 Sep 2019 17:46:14 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] Revert "iio: hid-sensor-attributes: Convert to use int_pow()"
Date:   Fri,  6 Sep 2019 17:45:55 +0200
Message-Id: <20190906154609.2421410-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RxAflYvFSgC4AQPKdZewqxKzyuLVpknAeQFNbvbpm4IWXhrJKE5
 ngA/qm5vcdBarsSA3ksUO+wW2JDquIuxHZeBCggIIdMe9ausS26Mr+sls8Fv2q5OKnQfy7t
 4RORQsBJIifBebjRCcr2jZUzxAt0Y/2sxEfm+xh8c+8nVyP2dud9U97619dGjF/P3I6kJFg
 EVW1oWZ0e5XaSwQuiR32w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9rRET29UyqE=:HHigNeMrYT6DOSZg/T67ZP
 zmPQGlUUEekOSFfotQvcxTShBrC1j6gqX/oZrkGM0528Xk+bVpy3VQ9aEXo4JHpPpiSCNmiwB
 6b3wyFiGX/spxJvaXlzCQgEq72Oo7LiahyBgz/EilX1dptyMi9X/7LV23aBikB3l/kM8gwsne
 XzzNHWNsNcSXXBfWlsahtcf3xMXk/GPJ7bj8pxqbb12nlXnUID/PlLSdAgCc7S64Pab/8ih4G
 phIEZs4Z1xLJ8P+8QiUOp9iF9s5UpVBtbow7ge07+cmkdQTsWevPLtIkifO3OMZHRXAuNFoav
 ZJI4Thqh5TOleh22pJ8LxjgDB1jvBmR3Am2jjZmGGPEMsWmDIY2M32Iikp1IxnjDsryqB0UIM
 b+AxbPyregLyhPMJam/oYbogTOaFbThCN7DaM2mlkZ81QKbGOXy8PEDF+HbyNvhNccZ5zCSPi
 z53oYZOS8dAjG71gccCv4zUVVdtAQgB1FAEvYwhS6iI+0ghnB/fLMQ3Mwiv4fjmxpeG6+X2tO
 x82N5ByY+0zf2v3pZVKLDLb5Tu9o7ghsYpycY6EVGbqHFDRlHYlj1poScvmHSL+nKYFT14Iet
 4EURBt2SCAUktCVBDi94UwRvm9geTZWddsQCxXojRhhl0G/z1tAYMaURjpmKsjoeG1r1v6eM5
 NrWBH8UFqy/d2K6uRn4ciC5CQqVq/pMdA49IpfpvXj22VW5MHmYQFv5E/QUiDS73FX27jTyQj
 +gxHhxuyed83f/OG/dYY/1CJfGAw0Vz7g7OiXpvB2ua7fdxP9z84VnusVd1MbnzSxMjZr2/Ay
 hcHh2MyMN/35zwwfzBA03hfg345QABAhe8ISXo49fD4pKiEV20=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The change to use the generic int_pow instead of the private version
caused a number of build issues on 32-bit architectures and makes
it generally less efficient because of the 64-bit math:

drivers/iio/common/hid-sensors/hid-sensor-attributes.o: In function `hid_sensor_write_samp_freq_value':
hid-sensor-attributes.c:(.text+0x29c): undefined reference to `__aeabi_uldivmod'
drivers/iio/common/hid-sensors/hid-sensor-attributes.o: In function `hid_sensor_read_raw_hyst_value':
hid-sensor-attributes.c:(.text+0x420): undefined reference to `__aeabi_uldivmod'
hid-sensor-attributes.c:(.text+0x448): undefined reference to `__aeabi_uldivmod'
drivers/iio/common/hid-sensors/hid-sensor-attributes.o: In function `hid_sensor_write_raw_hyst_value':
hid-sensor-attributes.c:(.text+0x570): undefined reference to `__aeabi_uldivmod'

There is probably a nicer solution to this, but for the moment,
the revert makes it compile again.

Fixes: 473d12f7638c ("iio: hid-sensor-attributes: Convert to use int_pow()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../hid-sensors/hid-sensor-attributes.c       | 53 +++++++++++--------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index b9dd19b34267..a8a3fe428d8d 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -8,7 +8,6 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/hid-sensor-hub.h>
 #include <linux/iio/iio.h>
@@ -69,6 +68,16 @@ static struct {
 	{HID_USAGE_SENSOR_HUMIDITY, 0, 1000, 0},
 };
 
+static int pow_10(unsigned power)
+{
+	int i;
+	int ret = 1;
+	for (i = 0; i < power; ++i)
+		ret = ret * 10;
+
+	return ret;
+}
+
 static void simple_div(int dividend, int divisor, int *whole,
 				int *micro_frac)
 {
@@ -87,14 +96,14 @@ static void simple_div(int dividend, int divisor, int *whole,
 			rem *= 10;
 			exp++;
 		}
-		*micro_frac = (rem / divisor) * int_pow(10, 6 - exp);
+		*micro_frac = (rem / divisor) * pow_10(6-exp);
 	}
 }
 
 static void split_micro_fraction(unsigned int no, int exp, int *val1, int *val2)
 {
-	*val1 = no / int_pow(10, exp);
-	*val2 = no % int_pow(10, exp) * int_pow(10, 6 - exp);
+	*val1 = no/pow_10(exp);
+	*val2 = no%pow_10(exp) * pow_10(6-exp);
 }
 
 /*
@@ -116,7 +125,7 @@ static void convert_from_vtf_format(u32 value, int size, int exp,
 	}
 	exp = hid_sensor_convert_exponent(exp);
 	if (exp >= 0) {
-		*val1 = sign * value * int_pow(10, exp);
+		*val1 = sign * value * pow_10(exp);
 		*val2 = 0;
 	} else {
 		split_micro_fraction(value, -exp, val1, val2);
@@ -136,10 +145,10 @@ static u32 convert_to_vtf_format(int size, int exp, int val1, int val2)
 		sign = -1;
 	exp = hid_sensor_convert_exponent(exp);
 	if (exp < 0) {
-		value = abs(val1) * int_pow(10, -exp);
-		value += abs(val2) / int_pow(10, 6 + exp);
+		value = abs(val1) * pow_10(-exp);
+		value += abs(val2) / pow_10(6+exp);
 	} else
-		value = abs(val1) / int_pow(10, exp);
+		value = abs(val1) / pow_10(exp);
 	if (sign < 0)
 		value =  ((1LL << (size * 8)) - value);
 
@@ -202,12 +211,12 @@ int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
 	if (val1 < 0 || val2 < 0)
 		return -EINVAL;
 
-	value = val1 * int_pow(10, 6) + val2;
+	value = val1 * pow_10(6) + val2;
 	if (value) {
 		if (st->poll.units == HID_USAGE_SENSOR_UNITS_MILLISECOND)
-			value = int_pow(10, 9) / value;
+			value = pow_10(9)/value;
 		else if (st->poll.units == HID_USAGE_SENSOR_UNITS_SECOND)
-			value = int_pow(10, 6) / value;
+			value = pow_10(6)/value;
 		else
 			value = 0;
 	}
@@ -302,34 +311,34 @@ static void adjust_exponent_nano(int *val0, int *val1, int scale0,
 	int rem;
 
 	if (exp > 0) {
-		*val0 = scale0 * int_pow(10, exp);
+		*val0 = scale0 * pow_10(exp);
 		res = 0;
 		if (exp > 9) {
 			*val1 = 0;
 			return;
 		}
 		for (i = 0; i < exp; ++i) {
-			x = scale1 / int_pow(10, 8 - i);
-			res += int_pow(10, exp - 1 - i) * x;
-			scale1 = scale1 % int_pow(10, 8 - i);
+			x = scale1 / pow_10(8 - i);
+			res += (pow_10(exp - 1 - i) * x);
+			scale1 = scale1 % pow_10(8 - i);
 		}
 		*val0 += res;
-		*val1 = scale1 * int_pow(10, exp);
+		*val1 = scale1 * pow_10(exp);
 	} else if (exp < 0) {
 		exp = abs(exp);
 		if (exp > 9) {
 			*val0 = *val1 = 0;
 			return;
 		}
-		*val0 = scale0 / int_pow(10, exp);
-		rem = scale0 % int_pow(10, exp);
+		*val0 = scale0 / pow_10(exp);
+		rem = scale0 % pow_10(exp);
 		res = 0;
 		for (i = 0; i < (9 - exp); ++i) {
-			x = scale1 / int_pow(10, 8 - i);
-			res += int_pow(10, 8 - exp - i) * x;
-			scale1 = scale1 % int_pow(10, 8 - i);
+			x = scale1 / pow_10(8 - i);
+			res += (pow_10(8 - exp - i) * x);
+			scale1 = scale1 % pow_10(8 - i);
 		}
-		*val1 = rem * int_pow(10, 9 - exp) + res;
+		*val1 = rem * pow_10(9 - exp) + res;
 	} else {
 		*val0 = scale0;
 		*val1 = scale1;
-- 
2.20.0


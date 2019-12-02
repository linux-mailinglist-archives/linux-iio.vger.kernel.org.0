Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D784110E726
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 09:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLBIz5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 03:55:57 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:39278 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfLBIz5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 03:55:57 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id Ywvn2100Q5USYZQ01wvopW; Mon, 02 Dec 2019 09:55:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ibhUh-0002ZA-RE; Mon, 02 Dec 2019 09:55:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ibhUh-0005lK-Oo; Mon, 02 Dec 2019 09:55:47 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] iio: adc: max9611: Fix too short conversion time delay
Date:   Mon,  2 Dec 2019 09:55:46 +0100
Message-Id: <20191202085546.21655-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As of commit b9ddd5091160793e ("iio: adc: max9611: Fix temperature
reading in probe"), max9611 initialization sometimes fails on the
Salvator-X(S) development board with:

    max9611 4-007f: Invalid value received from ADC 0x8000: aborting
    max9611: probe of 4-007f failed with error -5

The max9611 driver tests communications with the chip by reading the die
temperature during the probe function, which returns an invalid value.

According to the datasheet, the typical ADC conversion time is 2 ms, but
no minimum or maximum values are provided.  Maxim Technical Support
confirmed this was tested with temperature Ta=25 degreeC, and promised
to inform me if a maximum/minimum value is available (they didn't get
back to me, so I assume it is not).

However, the driver assumes a 1 ms conversion time.  Usually the
usleep_range() call returns after more than 1.8 ms, hence it succeeds.
When it returns earlier, the data register may be read too early, and
the previous measurement value will be returned.  After boot, this is
the temperature POR (power-on reset) value, causing the failure above.

Fix this by increasing the delay from 1000-2000 µs to 3000-3300 µs.

Note that this issue has always been present, but it was exposed by the
aformentioned commit.

Fixes: 69780a3bbc0b1e7e ("iio: adc: Add Maxim max9611 ADC driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
After this patch, probing of the two max9611 sensors succeeded during
ca. 3000 boot cycles on Salvator-X(S) boards, equipped with various
R-Car H3/M3-W/M3-N SoCs.

v2:
  - Add Reviewed-by,
  - Add feedback from Maxim Technical Support,
  - Increase delay from 2000-2200 µs to 3000-3300 µs to play safe.
---
 drivers/iio/adc/max9611.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index da073d72f649f829..135793db4fad6b2c 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -89,6 +89,12 @@
 #define MAX9611_TEMP_SCALE_NUM		1000000
 #define MAX9611_TEMP_SCALE_DIV		2083
 
+/*
+ * Conversion time is 2 ms (typically) at Ta=25 degreeC
+ * No maximum value is known, so play it safe.
+ */
+#define MAX9611_CONV_TIME_US_RANGE	3000, 3300
+
 struct max9611_dev {
 	struct device *dev;
 	struct i2c_client *i2c_client;
@@ -238,9 +244,9 @@ static int max9611_read_single(struct max9611_dev *max9611,
 
 	/*
 	 * need a delay here to make register configuration
-	 * stabilize. 1 msec at least, from empirical testing.
+	 * stabilize.
 	 */
-	usleep_range(1000, 2000);
+	usleep_range(MAX9611_CONV_TIME_US_RANGE);
 
 	ret = i2c_smbus_read_word_swapped(max9611->i2c_client, reg_addr);
 	if (ret < 0) {
@@ -507,7 +513,7 @@ static int max9611_init(struct max9611_dev *max9611)
 			MAX9611_REG_CTRL2, 0);
 		return ret;
 	}
-	usleep_range(1000, 2000);
+	usleep_range(MAX9611_CONV_TIME_US_RANGE);
 
 	return 0;
 }
-- 
2.17.1


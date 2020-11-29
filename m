Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BB22C7AC5
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 19:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgK2Srp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 13:47:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgK2Srp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Nov 2020 13:47:45 -0500
Received: from localhost.localdomain (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9650E20691;
        Sun, 29 Nov 2020 18:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606675624;
        bh=9CSSHZvnhjk9dOhPZ4fEUVcqkxHWKSOEquLowULXL3g=;
        h=From:To:Cc:Subject:Date:From;
        b=2uXCvQvcjnQAhWXkeUo1u1yX82yE2SGnW+/RxOK4g16W7WLzVAQsq3QNn6/b4uZM4
         amQFxHBu60GUbOMt6QoA7EY7lJ3EVD90nAyY6e0ED19KLh/RQM0EH3P400fil6Y50X
         gOxfor/M7+9gfNnMSHXNJKtVM6Z38trEFBPL/6EA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] iio:gyro:mpu3050 Treat otp value as a __le64 and use FIELD_GET() to break up
Date:   Sun, 29 Nov 2020 18:44:59 +0000
Message-Id: <20201129184459.647538-1-jic23@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Inspired by Andy Shevchenko's proposal to use get_unaligned_leXX().

The whole one time programable memory is treated as a single 64bit
little endian value.  Thus we can avoid a lot of messy handling
of fields overlapping byte boundaries by just loading and manipulating
it as an __le64 converted to a u64.  That lets us just use FIELD_GET()
and GENMASK() to extract the values desired.

Note only build tested. We need to use GENMASK_ULL and %llX formatters
to account for the larger types used in computing the various fields.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20201128185156.428327-1-jic23@kernel.org
---

Changes since v1:
* Fix 32 bit builds by using GENMASK_ULL (thanks to Linus + Andy)

 drivers/iio/gyro/mpu3050-core.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 00e58060968c..dfa31a23500f 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -13,6 +13,7 @@
  * TODO: add support for setting up the low pass 3dB frequency.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -784,7 +785,8 @@ static int mpu3050_read_mem(struct mpu3050 *mpu3050,
 static int mpu3050_hw_init(struct mpu3050 *mpu3050)
 {
 	int ret;
-	u8 otp[8];
+	__le64 otp_le;
+	u64 otp;
 
 	/* Reset */
 	ret = regmap_update_bits(mpu3050->map,
@@ -815,29 +817,31 @@ static int mpu3050_hw_init(struct mpu3050 *mpu3050)
 				MPU3050_MEM_USER_BANK |
 				MPU3050_MEM_OTP_BANK_0),
 			       0,
-			       sizeof(otp),
-			       otp);
+			       sizeof(otp_le),
+			       (u8 *)&otp_le);
 	if (ret)
 		return ret;
 
 	/* This is device-unique data so it goes into the entropy pool */
-	add_device_randomness(otp, sizeof(otp));
+	add_device_randomness(&otp_le, sizeof(otp_le));
+
+	otp = le64_to_cpu(otp_le);
 
 	dev_info(mpu3050->dev,
-		 "die ID: %04X, wafer ID: %02X, A lot ID: %04X, "
-		 "W lot ID: %03X, WP ID: %01X, rev ID: %02X\n",
+		 "die ID: %04llX, wafer ID: %02llX, A lot ID: %04llX, "
+		 "W lot ID: %03llX, WP ID: %01llX, rev ID: %02llX\n",
 		 /* Die ID, bits 0-12 */
-		 (otp[1] << 8 | otp[0]) & 0x1fff,
+		 FIELD_GET(GENMASK_ULL(12, 0), otp),
 		 /* Wafer ID, bits 13-17 */
-		 ((otp[2] << 8 | otp[1]) & 0x03e0) >> 5,
+		 FIELD_GET(GENMASK_ULL(17, 13), otp),
 		 /* A lot ID, bits 18-33 */
-		 ((otp[4] << 16 | otp[3] << 8 | otp[2]) & 0x3fffc) >> 2,
+		 FIELD_GET(GENMASK_ULL(33, 18), otp),
 		 /* W lot ID, bits 34-45 */
-		 ((otp[5] << 8 | otp[4]) & 0x3ffc) >> 2,
+		 FIELD_GET(GENMASK_ULL(45, 34), otp),
 		 /* WP ID, bits 47-49 */
-		 ((otp[6] << 8 | otp[5]) & 0x0380) >> 7,
+		 FIELD_GET(GENMASK_ULL(49, 47), otp),
 		 /* rev ID, bits 50-55 */
-		 otp[6] >> 2);
+		 FIELD_GET(GENMASK_ULL(55, 50), otp));
 
 	return 0;
 }
-- 
2.29.2


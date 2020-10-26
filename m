Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B3A299469
	for <lists+linux-iio@lfdr.de>; Mon, 26 Oct 2020 18:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788616AbgJZRxp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Oct 2020 13:53:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:41117 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1781494AbgJZRxo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Oct 2020 13:53:44 -0400
IronPort-SDR: osGpx0UyvnyfM5bidBHosjPIRq6kPB2YD7sOzM6wD4efP/8hZd0+2IH2uKoqpZ4k3yznEPG+2k
 18Qv5JcMv4pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="155744726"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="155744726"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 10:53:43 -0700
IronPort-SDR: dc6EMThW3luy0HstM61S4zuYfJylft7ZAMEG8LVFBWPAgWKwrMbuDtZ8k4A1zboHtdwcVEszJA
 uiGgF131u05g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="525586066"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 26 Oct 2020 10:53:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6FF7813C; Mon, 26 Oct 2020 19:53:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1] iio: gyro: mpu3050: Use get_unaligned_leXX()
Date:   Mon, 26 Oct 2020 19:53:40 +0200
Message-Id: <20201026175340.19570-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This makes the driver code slightly easier to read.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/gyro/mpu3050-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 00e58060968c..42b6ccb13568 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -827,15 +827,15 @@ static int mpu3050_hw_init(struct mpu3050 *mpu3050)
 		 "die ID: %04X, wafer ID: %02X, A lot ID: %04X, "
 		 "W lot ID: %03X, WP ID: %01X, rev ID: %02X\n",
 		 /* Die ID, bits 0-12 */
-		 (otp[1] << 8 | otp[0]) & 0x1fff,
+		 get_unaligned_le16(&otp[0]) & GENMASK(12, 0),
 		 /* Wafer ID, bits 13-17 */
-		 ((otp[2] << 8 | otp[1]) & 0x03e0) >> 5,
+		 (get_unaligned_le16(&otp[1]) & GENMASK(9, 5)) >> 5,
 		 /* A lot ID, bits 18-33 */
-		 ((otp[4] << 16 | otp[3] << 8 | otp[2]) & 0x3fffc) >> 2,
+		 (get_unaligned_le24(&otp[2]) & GENMASK(17, 2)) >> 2,
 		 /* W lot ID, bits 34-45 */
-		 ((otp[5] << 8 | otp[4]) & 0x3ffc) >> 2,
+		 (get_unaligned_le16(&otp[4]) & GENMASK(13, 2)) >> 2,
 		 /* WP ID, bits 47-49 */
-		 ((otp[6] << 8 | otp[5]) & 0x0380) >> 7,
+		 (get_unaligned_le16(&otp[5]) & GENMASK(9, 7)) >> 7,
 		 /* rev ID, bits 50-55 */
 		 otp[6] >> 2);
 
-- 
2.28.0


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF04257601
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 11:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgHaJIZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 05:08:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:5851 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgHaJIR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 05:08:17 -0400
IronPort-SDR: 1CmONOxCBFpw/yQa904zPft7JHBE3HhQ3H7tMw8t0BjYcN1P6kUV85j8/U/9vsMI798h1MK4Uo
 TXcEYSLQydEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="144613467"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="144613467"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 02:08:16 -0700
IronPort-SDR: /RCPWoiG/VFWw7ijVbGi0zCkQHFJuWUTXhTJiireBHbiczHJhqsv8ipezevhnyJCim28Ry/ipe
 /WFFyWb4QekA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="476649701"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 31 Aug 2020 02:08:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3447816D; Mon, 31 Aug 2020 12:08:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/8] iio: accel: bma220: Fix returned codes from bma220_init(), bma220_deinit()
Date:   Mon, 31 Aug 2020 12:08:06 +0300
Message-Id: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Potentially bma220_init() and bma220_deinit() may return positive codes.
Fix the logic to return proper error codes instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/bma220_spi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index da8b36cc8628..3247b9c8abcb 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -198,10 +198,12 @@ static int bma220_init(struct spi_device *spi)
 
 	/* Make sure the chip is powered on */
 	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
+	if (ret == BMA220_SUSPEND_WAKE)
+		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
 	if (ret < 0)
 		return ret;
-	else if (ret == BMA220_SUSPEND_WAKE)
-		return bma220_read_reg(spi, BMA220_REG_SUSPEND);
+	if (ret == BMA220_SUSPEND_WAKE)
+		return -EBUSY;
 
 	return 0;
 }
@@ -212,10 +214,12 @@ static int bma220_deinit(struct spi_device *spi)
 
 	/* Make sure the chip is powered off */
 	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
+	if (ret == BMA220_SUSPEND_SLEEP)
+		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
 	if (ret < 0)
 		return ret;
-	else if (ret == BMA220_SUSPEND_SLEEP)
-		return bma220_read_reg(spi, BMA220_REG_SUSPEND);
+	if (ret == BMA220_SUSPEND_SLEEP)
+		return -EBUSY;
 
 	return 0;
 }
@@ -245,7 +249,7 @@ static int bma220_probe(struct spi_device *spi)
 	indio_dev->available_scan_masks = bma220_accel_scan_masks;
 
 	ret = bma220_init(data->spi_device);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
-- 
2.28.0


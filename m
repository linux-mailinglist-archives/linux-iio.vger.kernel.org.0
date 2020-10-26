Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E02994CD
	for <lists+linux-iio@lfdr.de>; Mon, 26 Oct 2020 19:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789192AbgJZSFT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Oct 2020 14:05:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:19943 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1789191AbgJZSFT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Oct 2020 14:05:19 -0400
IronPort-SDR: 4dymrU10pfubaYVufyN4Kv7sXNbOopWzVSTMxRFUnZLAVgj2DNZ0Eh7v3pxpI1QiHfiSsPjN78
 PyQU8oLxgdTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="147250546"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="147250546"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 11:05:18 -0700
IronPort-SDR: Mee1dWXrz56i+td1JlzFotheIaObnp4fh3M9lht//TOF0ry1xz5CICIhsTGYDqUfxpI64hxZCm
 NZn5Zw/h7x/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="535455523"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 26 Oct 2020 11:05:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 28CD413C; Mon, 26 Oct 2020 20:05:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v1] iio: pressure: dps310: Use get_unaligned_beXX()
Date:   Mon, 26 Oct 2020 20:05:15 +0200
Message-Id: <20201026180515.19680-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This makes the driver code slightly easier to read.

Cc: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/pressure/dps310.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 0730380ceb69..6a21cb5d3d37 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -127,7 +127,7 @@ static int dps310_get_coefs(struct dps310_data *data)
 	c0 = (coef[0] << 4) | (coef[1] >> 4);
 	data->c0 = sign_extend32(c0, 11);
 
-	c1 = ((coef[1] & GENMASK(3, 0)) << 8) | coef[2];
+	c1 = get_unaligned_be16(&coef[1]) & GENMASK(11, 0);
 	data->c1 = sign_extend32(c1, 11);
 
 	/*
@@ -138,22 +138,22 @@ static int dps310_get_coefs(struct dps310_data *data)
 	c00 = (coef[3] << 12) | (coef[4] << 4) | (coef[5] >> 4);
 	data->c00 = sign_extend32(c00, 19);
 
-	c10 = ((coef[5] & GENMASK(3, 0)) << 16) | (coef[6] << 8) | coef[7];
+	c10 = get_unaligned_be24(&coef[5]) & GENMASK(19, 0);
 	data->c10 = sign_extend32(c10, 19);
 
-	c01 = (coef[8] << 8) | coef[9];
+	c01 = get_unaligned_be16(&coef[8]);
 	data->c01 = sign_extend32(c01, 15);
 
-	c11 = (coef[10] << 8) | coef[11];
+	c11 = get_unaligned_be16(&coef[10]);
 	data->c11 = sign_extend32(c11, 15);
 
-	c20 = (coef[12] << 8) | coef[13];
+	c20 = get_unaligned_be16(&coef[12]);
 	data->c20 = sign_extend32(c20, 15);
 
-	c21 = (coef[14] << 8) | coef[15];
+	c21 = get_unaligned_be16(&coef[14]);
 	data->c21 = sign_extend32(c21, 15);
 
-	c30 = (coef[16] << 8) | coef[17];
+	c30 = get_unaligned_be16(&coef[16]);
 	data->c30 = sign_extend32(c30, 15);
 
 	return 0;
@@ -323,7 +323,7 @@ static int dps310_read_pres_raw(struct dps310_data *data)
 	if (rc < 0)
 		goto done;
 
-	raw = (val[0] << 16) | (val[1] << 8) | val[2];
+	raw = get_unaligned_be24(&val[0]);
 	data->pressure_raw = sign_extend32(raw, 23);
 
 done:
@@ -342,7 +342,7 @@ static int dps310_read_temp_ready(struct dps310_data *data)
 	if (rc < 0)
 		return rc;
 
-	raw = (val[0] << 16) | (val[1] << 8) | val[2];
+	raw = get_unaligned_be24(&val[0]);
 	data->temp_raw = sign_extend32(raw, 23);
 
 	return 0;
-- 
2.28.0


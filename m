Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3DD1B1AC6
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgDUAbn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:31:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:20091 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgDUAbl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:41 -0400
IronPort-SDR: ItCgPnFJd5G99rqV5bV625d2n/5+EGxApajqlkp6aijxVeX7KsnIrnjDqt5Tyj2ioGGQDZL1B6
 29UaHg4kG61Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:41 -0700
IronPort-SDR: I/yaiVRXp1g4FoxCVFxrorLhD6mnpIw5vzhoJdd8y2ZvxyrnQ0NwxPgsA4h/Y6ZyEOVBYNt42c
 XlgLMO0QS+UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="255113827"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2020 17:31:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F2020796; Tue, 21 Apr 2020 03:31:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 14/16] iio: pressure: zpa2326: Use get_unaligned_le24()
Date:   Tue, 21 Apr 2020 03:31:33 +0300
Message-Id: <20200421003135.23060-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This makes the driver code slightly easier to read.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/pressure/zpa2326.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 99dfe33ee402..c2ad106e3d5b 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -1005,22 +1005,20 @@ static int zpa2326_fetch_raw_sample(const struct iio_dev *indio_dev,
 	struct regmap *regs = ((struct zpa2326_private *)
 			       iio_priv(indio_dev))->regmap;
 	int            err;
+	u8             v[3];
 
 	switch (type) {
 	case IIO_PRESSURE:
 		zpa2326_dbg(indio_dev, "fetching raw pressure sample");
 
-		err = regmap_bulk_read(regs, ZPA2326_PRESS_OUT_XL_REG, value,
-				       3);
+		err = regmap_bulk_read(regs, ZPA2326_PRESS_OUT_XL_REG, v, sizeof(v));
 		if (err) {
 			zpa2326_warn(indio_dev, "failed to fetch pressure (%d)",
 				     err);
 			return err;
 		}
 
-		/* Pressure is a 24 bits wide little-endian unsigned int. */
-		*value = (((u8 *)value)[2] << 16) | (((u8 *)value)[1] << 8) |
-			 ((u8 *)value)[0];
+		*value = get_unaligned_le24(&v[0]);
 
 		return IIO_VAL_INT;
 
-- 
2.26.1


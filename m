Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759AB1B1AC2
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgDUAbm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:31:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:54519 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbgDUAbl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:41 -0400
IronPort-SDR: gt7oVZaZooz3NyijR7vBzx6nSXffUvUewaBsroOc5W7UwFeEvn819pO/IXzuUYBjhdOO0Cdns5
 ynM0sT4F62uQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:41 -0700
IronPort-SDR: NK0nZThW8tBiJ0KD43QIzPLN7+Wpm637bmqDLUvB6/pI31ocnIH/5g1al2mv3llNumBwJqi7h7
 UeqKLXMCDcQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="300437801"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2020 17:31:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B50FE426; Tue, 21 Apr 2020 03:31:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v1 07/16] iio: gyro: adis16130: Use get_unaligned_be24()
Date:   Tue, 21 Apr 2020 03:31:26 +0300
Message-Id: <20200421003135.23060-7-andriy.shevchenko@linux.intel.com>
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

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/gyro/adis16130.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
index 79e63c8a2ea8..b8d626bc30ad 100644
--- a/drivers/iio/gyro/adis16130.c
+++ b/drivers/iio/gyro/adis16130.c
@@ -59,7 +59,7 @@ static int adis16130_spi_read(struct iio_dev *indio_dev, u8 reg_addr, u32 *val)
 
 	ret = spi_sync_transfer(st->us, &xfer, 1);
 	if (ret == 0)
-		*val = (st->buf[1] << 16) | (st->buf[2] << 8) | st->buf[3];
+		*val = get_unaligned_be24(&st->buf[1]);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
-- 
2.26.1


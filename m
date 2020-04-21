Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68DC1B1ABC
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDUAbj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:31:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:54519 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgDUAbj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:39 -0400
IronPort-SDR: 7BtgwoEoZM0GajdqgceMbpwvGN8wdCcz9EZVBWEm2VvUIFNI/2qdBVanFd1dS8+4Ego4Dqw5X0
 0o0es91iy44A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:39 -0700
IronPort-SDR: X1FMPXsp5KTf+RaL9L3bxflMNVUc5I8np2KoXJZOoRJ0OLkgsWQAsnZVwz8pdodhvZcmTDy+qL
 Nqtp9Yi2eJTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="300437795"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2020 17:31:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A083D29A; Tue, 21 Apr 2020 03:31:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v1 05/16] iio: dac: ad5624r_spi: Use put_unaligned_be24()
Date:   Tue, 21 Apr 2020 03:31:24 +0300
Message-Id: <20200421003135.23060-5-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/dac/ad5624r_spi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index e6c022e1dc1c..394d9d23ba63 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -35,11 +35,9 @@ static int ad5624r_spi_write(struct spi_device *spi,
 	 * for the AD5664R, AD5644R, and AD5624R, respectively.
 	 */
 	data = (0 << 22) | (cmd << 19) | (addr << 16) | (val << shift);
-	msg[0] = data >> 16;
-	msg[1] = data >> 8;
-	msg[2] = data;
+	put_unaligned_be24(data, &msg[0]);
 
-	return spi_write(spi, msg, 3);
+	return spi_write(spi, msg, sizeof(msg));
 }
 
 static int ad5624r_read_raw(struct iio_dev *indio_dev,
-- 
2.26.1


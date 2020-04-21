Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C6E1B1ABA
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgDUAbj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:31:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:20088 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgDUAbj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:39 -0400
IronPort-SDR: 5RhkfgyHtc9yrzkvxN64qXpHjthDH0G3Q4scxcfzIxdz3bQ6MTcAfatLqU6NohmXnCGXsSUysP
 YDYTQKzKgdCg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:38 -0700
IronPort-SDR: QUhch9b00CvjXDN7rloaIAg2mmkJBFHnbCl073WPPWK4LsjojfX4eiO/vl4Tg11m/VU5RMu4S5
 SK/US9/L3PCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="255113798"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2020 17:31:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 90E19206; Tue, 21 Apr 2020 03:31:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 04/16] iio: dac: ltc2632: Use put_unaligned_be24()
Date:   Tue, 21 Apr 2020 03:31:23 +0300
Message-Id: <20200421003135.23060-4-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/dac/ltc2632.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index 7adc91056aa1..5123776cb63e 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -75,9 +75,7 @@ static int ltc2632_spi_write(struct spi_device *spi,
 	 * 10-, 8-bit input code followed by 4, 6, or 8 don't care bits.
 	 */
 	data = (cmd << 20) | (addr << 16) | (val << shift);
-	msg[0] = data >> 16;
-	msg[1] = data >> 8;
-	msg[2] = data;
+	put_unaligned_be24(data, &msg[0]);
 
 	return spi_write(spi, msg, sizeof(msg));
 }
-- 
2.26.1


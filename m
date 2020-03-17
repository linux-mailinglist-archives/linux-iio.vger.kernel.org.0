Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A44A187E09
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 11:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgCQKSS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 06:18:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:4738 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbgCQKSR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Mar 2020 06:18:17 -0400
IronPort-SDR: L+KRsNYXHdLsxEmkgNMZvdPiAxvpGl/y3ZEm/UpvInMsWjSqA9gNTBwLQ9EDo0QgOP1Uf2ZqNs
 1m/3xIdleXGg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 03:18:17 -0700
IronPort-SDR: 2ed2QYFpxtb02Y6MOCgeXCKTXBu9aeFlmsea+gJ4UdQZhZ4wyR14ZiHTs/79QdOzwbPtm4jxvi
 inFNwLLLC0cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="233453315"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2020 03:18:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 30610178; Tue, 17 Mar 2020 12:18:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/5] iio: pressure: bmp280: Tolerate IRQ before registering
Date:   Tue, 17 Mar 2020 12:18:09 +0200
Message-Id: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With DEBUG_SHIRQ enabled we have a kernel crash

[  116.482696] BUG: kernel NULL pointer dereference, address: 0000000000000000

...

[  116.606571] Call Trace:
[  116.609023]  <IRQ>
[  116.611047]  complete+0x34/0x50
[  116.614206]  bmp085_eoc_irq+0x9/0x10 [bmp280]

because DEBUG_SHIRQ mechanism fires an IRQ before registration and drivers
ought to be able to handle an interrupt happening before request_irq() returns.

Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/pressure/bmp280-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 29c209cc1108..5e229b95308e 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -712,8 +712,7 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 	unsigned int delay_us;
 	unsigned int ctrl;
 
-	if (data->use_eoc)
-		init_completion(&data->done);
+	reinit_completion(&data->done);
 
 	ret = regmap_write(data->regmap, BMP280_REG_CTRL_MEAS, ctrl_meas);
 	if (ret)
@@ -969,6 +968,9 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 			"trying to enforce it\n");
 		irq_trig = IRQF_TRIGGER_RISING;
 	}
+
+	init_completion(&data->done);
+
 	ret = devm_request_threaded_irq(dev,
 			irq,
 			bmp085_eoc_irq,
-- 
2.25.1


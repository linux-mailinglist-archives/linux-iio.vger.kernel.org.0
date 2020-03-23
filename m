Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27818F305
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 11:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgCWKle (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 06:41:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:8223 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgCWKle (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 06:41:34 -0400
IronPort-SDR: AuGOJ7bRMS4hD9yMiSquavqJKJwCskMpVNkeHJ+4uq0W4gEAcci1WtZU72ImiJ8IVznxRX0NBE
 mVggKJaTve5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 03:41:33 -0700
IronPort-SDR: nIjE1w2NVAzmPPRscLd8e1X2bu8bHwn32kKtFY6Ctoovh7mmKG7ZzaezAE/MSyWgvz93scmoQW
 5/VcIigSEcIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,296,1580803200"; 
   d="scan'208";a="239892945"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2020 03:41:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 54AB614B; Mon, 23 Mar 2020 12:41:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/5] iio: pressure: bmp280: Tolerate IRQ before registering
Date:   Mon, 23 Mar 2020 12:41:25 +0200
Message-Id: <20200323104129.60466-1-andriy.shevchenko@linux.intel.com>
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
v2: put conditional logic back when re-initializing completion (Jonathan)
 drivers/iio/pressure/bmp280-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 29c209cc1108..2540e7c2358c 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -713,7 +713,7 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 	unsigned int ctrl;
 
 	if (data->use_eoc)
-		init_completion(&data->done);
+		reinit_completion(&data->done);
 
 	ret = regmap_write(data->regmap, BMP280_REG_CTRL_MEAS, ctrl_meas);
 	if (ret)
@@ -969,6 +969,9 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
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


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE32187E08
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 11:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgCQKSS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 06:18:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:6312 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgCQKSR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Mar 2020 06:18:17 -0400
IronPort-SDR: fAlNObKfoq6Z4guHbFNAPzfdwuYxFi/CSawrC0LKCgGoIj6GqX9Gpz4oURMI+2hnbwATslJ45C
 twxRrcJbaPqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 03:18:17 -0700
IronPort-SDR: DKrqioQIXbt4at0qExtnZ0pnnxB5MCXfOdcYevr456rlSIifVEW7vfzvF3pljHNF/0Pu3vQaf4
 0q8tMIahmMsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="238236412"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 17 Mar 2020 03:18:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6663E19D; Tue, 17 Mar 2020 12:18:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/5] iio: pressure: bmp280: Join string literals back
Date:   Tue, 17 Mar 2020 12:18:13 +0200
Message-Id: <20200317101813.30829-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
References: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For easy grepping on debug purposes join string literals back in
the messages.

No functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/pressure/bmp280-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 5db41b1df7eb..b8ff6806c00b 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -957,8 +957,7 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 
 	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
 	if (irq_trig != IRQF_TRIGGER_RISING) {
-		dev_err(dev, "non-rising trigger given for EOC interrupt, "
-			"trying to enforce it\n");
+		dev_err(dev, "non-rising trigger given for EOC interrupt, trying to enforce it\n");
 		irq_trig = IRQF_TRIGGER_RISING;
 	}
 
-- 
2.25.1


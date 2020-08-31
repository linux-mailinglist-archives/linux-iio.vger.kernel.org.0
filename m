Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A53D257607
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 11:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgHaJIa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 05:08:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:6895 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbgHaJIZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 05:08:25 -0400
IronPort-SDR: OBsRFUerX1qYP7ZrU9ZPTrFhsTWusPYzYnMu6NZmdQtlI2qLfpLtby91SPP2PqhE/a3ZlIyIwF
 8AMS4/OxtdMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="241747289"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="241747289"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 02:08:19 -0700
IronPort-SDR: MrSX938BfpmsnBoVuoy60s4iZbvjInNu574pEoTKLAXx7X5UjkUkxQcWGcB93IYFtL13UH/eK0
 pNupyzGLADYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="330630289"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 31 Aug 2020 02:08:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 65EB840D; Mon, 31 Aug 2020 12:08:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/8] iio: accel: bma220: Group IIO headers together
Date:   Mon, 31 Aug 2020 12:08:11 +0300
Message-Id: <20200831090813.78841-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Group IIO headers together and follow the common pattern of header inclusion,
i.e. more generic first.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/bma220_spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 105c1dece890..1a2cf486e546 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -8,10 +8,11 @@
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/spi/spi.h>
+
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/spi/spi.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-- 
2.28.0


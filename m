Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72E7257606
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 11:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgHaJIa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 05:08:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:58432 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbgHaJIZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 05:08:25 -0400
IronPort-SDR: STLay4dxQShfUTIibGRl6hBHsxGmEDd05wxIcn/RyrPmx4re8Ld+7vl1srjq8jCR2+zjH9Ifvn
 E4N2/XGRSm3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="174981584"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="174981584"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 02:08:19 -0700
IronPort-SDR: Te014Qfta5FWEB8Umt88y16eEW7Ef3nS6Kbxtr4rRPws3K+nlLUaBY0w4h+K/kmQlthemyTuPT
 Oc/so0lFwWRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="333274179"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 31 Aug 2020 02:08:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7546753F; Mon, 31 Aug 2020 12:08:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 7/8] iio: accel: bma220: Use BIT() and GENMASK() macros
Date:   Mon, 31 Aug 2020 12:08:12 +0300
Message-Id: <20200831090813.78841-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Code is better to read when numbers of bit are explicitly used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/bma220_spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 1a2cf486e546..a766a0e13efb 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2016, Intel Corporation.
  */
 
+#include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -24,8 +25,8 @@
 #define BMA220_REG_SUSPEND			0x18
 
 #define BMA220_CHIP_ID				0xDD
-#define BMA220_READ_MASK			0x80
-#define BMA220_RANGE_MASK			0x03
+#define BMA220_READ_MASK			BIT(7)
+#define BMA220_RANGE_MASK			GENMASK(1, 0)
 #define BMA220_DATA_SHIFT			2
 #define BMA220_SUSPEND_SLEEP			0xFF
 #define BMA220_SUSPEND_WAKE			0x00
-- 
2.28.0


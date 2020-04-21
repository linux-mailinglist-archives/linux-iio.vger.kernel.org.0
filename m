Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6612F1B1AC4
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgDUAbn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:31:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:43075 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgDUAbm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:42 -0400
IronPort-SDR: mcBSU+F0+cFdfBVJjkqnHO2h6/9gqn6YCHtbsbqkmCw7hVYFKQqqcG0RuHDWTg46SlQxTEGhZm
 j/8DcMRd2kSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:41 -0700
IronPort-SDR: YE7B1vJBS/5fNRUTiAVB0uvXr0Zbu4sCaeJamsZ+JBQE6OfRtyVtK76Go83ycD2sV3YbmO5vj8
 C2/dMp/6hsng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="244002922"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 20 Apr 2020 17:31:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 04B8A871; Tue, 21 Apr 2020 03:31:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 15/16] iio: temperature: max31856: Use get_unaligned_beXX()
Date:   Tue, 21 Apr 2020 03:31:34 +0300
Message-Id: <20200421003135.23060-15-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/temperature/max31856.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index b4cb21ab2e85..e1966889a962 100644
--- a/drivers/iio/temperature/max31856.c
+++ b/drivers/iio/temperature/max31856.c
@@ -168,7 +168,7 @@ static int max31856_thermocouple_read(struct max31856_data *data,
 		if (ret)
 			return ret;
 		/* Skip last 5 dead bits of LTCBL */
-		*val = (reg_val[0] << 16 | reg_val[1] << 8 | reg_val[2]) >> 5;
+		*val = get_unaligned_be24(&reg_val[0]) >> 5;
 		/* Check 7th bit of LTCBH reg. value for sign*/
 		if (reg_val[0] & 0x80)
 			*val -= 0x80000;
@@ -185,7 +185,7 @@ static int max31856_thermocouple_read(struct max31856_data *data,
 		/* Get Cold Junction Temp. offset register value */
 		offset_cjto = reg_val[0];
 		/* Get CJTH and CJTL value and skip last 2 dead bits of CJTL */
-		*val = (reg_val[1] << 8 | reg_val[2]) >> 2;
+		*val = get_unaligned_be16(&reg_val[1]) >> 2;
 		/* As per datasheet add offset into CJTH and CJTL */
 		*val += offset_cjto;
 		/* Check 7th bit of CJTH reg. value for sign */
-- 
2.26.1


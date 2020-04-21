Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD99D1B1ABD
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDUAbk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:31:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:1770 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgDUAbj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:39 -0400
IronPort-SDR: gUgr8fIGwCb+KesxVonCShvStQt9ikeXtsrkvTLkK+G8PWkKETBosF8m7qtTGN341Xue06nRii
 jyfsg7OkK3cg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:39 -0700
IronPort-SDR: iVHb9kVFSdraTjZD0PzJ9l6wUour1qaM4OXU6FeDa2+fOn5paTKzwFjDxec5TyhAZPdFfg3MZE
 Oda50asD/+MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="365175463"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2020 17:31:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 68AB6190; Tue, 21 Apr 2020 03:31:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v1 01/16] iio: adc: ad_sigma_delta: Use {get,put}_unaligned_be24()
Date:   Tue, 21 Apr 2020 03:31:20 +0300
Message-Id: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
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
 drivers/iio/adc/ad_sigma_delta.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 8115b6de1d6c..dd3d54b3bc8b 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -70,9 +70,7 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 
 	switch (size) {
 	case 3:
-		data[1] = val >> 16;
-		data[2] = val >> 8;
-		data[3] = val;
+		put_unaligned_be24(val, &data[1]);
 		break;
 	case 2:
 		put_unaligned_be16(val, &data[1]);
@@ -157,9 +155,7 @@ int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta,
 		*val = get_unaligned_be32(sigma_delta->data);
 		break;
 	case 3:
-		*val = (sigma_delta->data[0] << 16) |
-			(sigma_delta->data[1] << 8) |
-			sigma_delta->data[2];
+		*val = get_unaligned_be24(&sigma_delta->data[0]);
 		break;
 	case 2:
 		*val = get_unaligned_be16(sigma_delta->data);
-- 
2.26.1


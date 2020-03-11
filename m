Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1B51814A8
	for <lists+linux-iio@lfdr.de>; Wed, 11 Mar 2020 10:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgCKJW2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Mar 2020 05:22:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:36973 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbgCKJW1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Mar 2020 05:22:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 02:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; 
   d="scan'208";a="277304117"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2020 02:22:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CCC3616D; Wed, 11 Mar 2020 11:22:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] iio: adc: intel_mrfld_adc: Use be16_to_cpu() instead of get_unaligned_be16()
Date:   Wed, 11 Mar 2020 11:22:23 +0200
Message-Id: <20200311092223.9673-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is no need to call unaligned helpers on stack placed variables
because compiler will align them correctly, accordingly to architectural
ABI. Moreover, using bitwise type makes it explicit to see what we are
reading in bulk transfer. On top of that, use sizeof() instead of
magic value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/intel_mrfld_adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
index c35a1beb817c..a6d2e1f27e76 100644
--- a/drivers/iio/adc/intel_mrfld_adc.c
+++ b/drivers/iio/adc/intel_mrfld_adc.c
@@ -75,7 +75,7 @@ static int mrfld_adc_single_conv(struct iio_dev *indio_dev,
 	struct regmap *regmap = adc->regmap;
 	unsigned int req;
 	long timeout;
-	u8 buf[2];
+	__be16 value;
 	int ret;
 
 	reinit_completion(&adc->completion);
@@ -105,11 +105,11 @@ static int mrfld_adc_single_conv(struct iio_dev *indio_dev,
 		goto done;
 	}
 
-	ret = regmap_bulk_read(regmap, chan->address, buf, 2);
+	ret = regmap_bulk_read(regmap, chan->address, &value, sizeof(value));
 	if (ret)
 		goto done;
 
-	*result = get_unaligned_be16(buf);
+	*result = be16_to_cpu(value);
 	ret = IIO_VAL_INT;
 
 done:
-- 
2.25.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0363C1FEB
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 09:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhGIHUW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 03:20:22 -0400
Received: from first.geanix.com ([116.203.34.67]:34788 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230121AbhGIHUW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Jul 2021 03:20:22 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 5F6F44C629C;
        Fri,  9 Jul 2021 07:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1625815057; bh=Pe3FItGwFPBXDHQiYwt4pqtFmXwq7zrJ5hWntlDVFKo=;
        h=From:To:Cc:Subject:Date;
        b=WLknKA2kcRlWYDxOo1hdh5Ipzy/6OHRWFcGKMc6houLEfBuhv/ddafZJuGEy1DSHB
         r13tU8gEnQtCcwNvETIa2ZB1roVk7dHhwcyXLssE/a1xGu9in5jEQvB/h358CdrqbV
         im3Ie3GPb5GiBxXwwaMJV/AdLfWnMx/K/crwAX504STWa9dxMkH+Gz1ph0w/1egCFe
         FjWrF2NFXboVnbNpL5IeWQeOzRf9YzVt6DRh7ka7cAspt04l2zcVbFgAr7PZTR+Fo4
         m/vvvIwI51NP8gVzE58d3uR67+ShNEd4A/TxOw6C+b6jOdFeIc/zHege2LtS2LEdGF
         wW77RVE5SrRYg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>
Cc:     andy.shevchenko@gmail.com, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: accel: fxls8962af: fix potential use of uninitialized symbol
Date:   Fri,  9 Jul 2021 09:17:27 +0200
Message-Id: <20210709071727.2453536-1-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix this warning from kernel test robot:
smatch warnings:
drivers/iio/accel/fxls8962af-core.c:640
fxls8962af_i2c_raw_read_errata3() error: uninitialized symbol 'ret'.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Fixes: af959b7b96b8 ("iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads")
---
Changes since v2:
 - add commit msg

 drivers/iio/accel/fxls8962af-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 078d87865fde..0019f1ea7df2 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -637,7 +637,7 @@ static int fxls8962af_i2c_raw_read_errata3(struct fxls8962af_data *data,
 			return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
-- 
2.31.0


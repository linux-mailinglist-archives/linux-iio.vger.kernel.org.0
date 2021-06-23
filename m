Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98F93B18FE
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jun 2021 13:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFWLd5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Jun 2021 07:33:57 -0400
Received: from first.geanix.com ([116.203.34.67]:39692 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhFWLd5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Jun 2021 07:33:57 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 932304C3C67;
        Wed, 23 Jun 2021 11:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1624447897; bh=nUAgFgu7cSs+IeM1qSV85FLHqYX22lMVFLHZNr59TF0=;
        h=From:To:Cc:Subject:Date;
        b=F8DDThwiUMJSt77RFwNw5UwXZA8/Qy8F9wnFEv02PJLfjppXpAYageHpZpT2j1mXK
         mwojARzLUP+yoHdu6WAm6eteNpeRoqq5XndqKBBnxOM7zJEgaIfT7N3pqJCWrT1oJi
         hViXKF2Ub5YdXCYAlNw3V9Cwk4oFEfUJX0LiFABypxpFOAsZjtDAMYXD92dI1EUk9p
         rHI0c6i2ccjyGxxlatV5EE0GMNocwZ/7HGWvCi3O/BHTi+QYxjwUBZLUiR2UaOW1+d
         EYq1bronQ05FnF2BBTfykke7gTk4yjYF+WymnEtgV/V1ne8artnUh0IGwQrw5m/XHY
         Wma6hz985+nLg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: fxls8962af: fix potential use of uninitialized symbol
Date:   Wed, 23 Jun 2021 13:31:15 +0200
Message-Id: <20210623113115.581609-1-sean@geanix.com>
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

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Fixes: af959b7b96b8 ("iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads")
---
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


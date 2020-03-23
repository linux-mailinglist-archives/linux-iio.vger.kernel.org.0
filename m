Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B942D18F308
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 11:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgCWKle (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 06:41:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:23910 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbgCWKle (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 06:41:34 -0400
IronPort-SDR: MoVaULXp4KaKmaOO5VthNCeVk5/mWo+Wy5Gig7NXtEnbKx7DT/m8pZJ5hMOeTD2VSoXtbwvtmW
 6OL5YmmnzuSA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 03:41:33 -0700
IronPort-SDR: NYsDt6C1cICcgZ3fYkcDeWtKp7TaENsqaZsgzv4uLxBK0Ed9OLsMc7v8y5YNbfjzLXNym1F04O
 eC4RbWxr53Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,296,1580803200"; 
   d="scan'208";a="269834557"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 23 Mar 2020 03:41:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 731703BA; Mon, 23 Mar 2020 12:41:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/5] iio: pressure: bmp280: Explicitly mark GPIO optional
Date:   Mon, 23 Mar 2020 12:41:27 +0200
Message-Id: <20200323104129.60466-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323104129.60466-1-andriy.shevchenko@linux.intel.com>
References: <20200323104129.60466-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Show by using a corresponding API call that GPIO is optional.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no change
 drivers/iio/pressure/bmp280-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index ce0c1962d9f8..263a74666c1e 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1066,9 +1066,9 @@ int bmp280_common_probe(struct device *dev,
 	usleep_range(data->start_up_time, data->start_up_time + 100);
 
 	/* Bring chip out of reset if there is an assigned GPIO line */
-	gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	/* Deassert the signal */
-	if (!IS_ERR(gpiod)) {
+	if (gpiod) {
 		dev_info(dev, "release reset\n");
 		gpiod_set_value(gpiod, 0);
 	}
-- 
2.25.1


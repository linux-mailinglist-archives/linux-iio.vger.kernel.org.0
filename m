Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0945187E0C
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 11:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgCQKST (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 06:18:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:56031 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgCQKSR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Mar 2020 06:18:17 -0400
IronPort-SDR: zaXP5PnfHtxznsYlP1xIOw/giJ8T1+FBD/ndyGfstud32ZViw2YDSdBlSSnp4xjjB4IhgrVbnL
 fmqOjWYruo1A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 03:18:17 -0700
IronPort-SDR: 4p8dyT05L0WoVBKRSPo2LtHrsFjTiUqOlJEhfJKbPLu55TbAUUbSA9WHy+f6oE6Vhkmdm5Vr/N
 /noXgwroSSNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="323785168"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 17 Mar 2020 03:18:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4886418B; Tue, 17 Mar 2020 12:18:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] iio: pressure: bmp280: Explicitly mark GPIO optional
Date:   Tue, 17 Mar 2020 12:18:11 +0200
Message-Id: <20200317101813.30829-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
References: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Show by using a corresponding API call that GPIO is optional.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/pressure/bmp280-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 25be3ff1a6ab..6c2e47d92a11 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1080,9 +1080,9 @@ int bmp280_common_probe(struct device *dev,
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


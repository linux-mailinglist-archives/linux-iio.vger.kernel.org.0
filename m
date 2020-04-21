Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABC91B1AB9
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDUAbi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:31:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:14368 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgDUAbi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:38 -0400
IronPort-SDR: BcN4WwZbXe9SnogNRTQXFGBK6vaSss0UktJhwd230sDK+su/3LW67mSYagUwb/3nzYSHYweEbD
 zdtOTyKGLCXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:38 -0700
IronPort-SDR: meXAvUcpVOh42i9bLUwteUinHNOCl9wSQIUkGoCPEK09T3z+doRkCjbnShH8JcWPyeUQc2peAQ
 CVcssNkTYeYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="290282128"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2020 17:31:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 775A517F; Tue, 21 Apr 2020 03:31:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 02/16] iio: adc: mpc3422: Use get_unaligned_beXX()
Date:   Tue, 21 Apr 2020 03:31:21 +0300
Message-Id: <20200421003135.23060-2-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/adc/mcp3422.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index ea24d7c58b12..b247eb209f10 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -117,11 +117,11 @@ static int mcp3422_read(struct mcp3422 *adc, int *value, u8 *config)
 
 	if (sample_rate == MCP3422_SRATE_3) {
 		ret = i2c_master_recv(adc->i2c, buf, 4);
-		temp = buf[0] << 16 | buf[1] << 8 | buf[2];
+		temp = get_unaligned_be24(&buf[0]);
 		*config = buf[3];
 	} else {
 		ret = i2c_master_recv(adc->i2c, buf, 3);
-		temp = buf[0] << 8 | buf[1];
+		temp = get_unaligned_be16(&buf[0]);
 		*config = buf[2];
 	}
 
-- 
2.26.1


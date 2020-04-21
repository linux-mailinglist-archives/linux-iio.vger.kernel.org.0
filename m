Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8FC1B1AC5
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDUAbn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:31:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:58406 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbgDUAbm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:42 -0400
IronPort-SDR: uAJTQRTeDeaBTNa21S3CiELzbwg8iX2ZGBBHgxX0f+2uCfqKRRPChYrhvVH1b7rq3x9mqheFSR
 ISBpwakLZFaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:41 -0700
IronPort-SDR: 61i1H+BB99Ipc6Q5tjkfUjpPhlbU19LZCORx6vN38UV8Ttvf/PnloqvIX7xXidD5jc5S906Jaz
 Qj4n353Uvnog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="291433482"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 20 Apr 2020 17:31:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB48E70F; Tue, 21 Apr 2020 03:31:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 13/16] iio: pressure: ms5611: Use get_unaligned_be24()
Date:   Tue, 21 Apr 2020 03:31:32 +0300
Message-Id: <20200421003135.23060-13-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/pressure/ms5611_i2c.c | 2 +-
 drivers/iio/pressure/ms5611_spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
index 8089c59adce5..ced83162ae94 100644
--- a/drivers/iio/pressure/ms5611_i2c.c
+++ b/drivers/iio/pressure/ms5611_i2c.c
@@ -50,7 +50,7 @@ static int ms5611_i2c_read_adc(struct ms5611_state *st, s32 *val)
 	if (ret < 0)
 		return ret;
 
-	*val = (buf[0] << 16) | (buf[1] << 8) | buf[2];
+	*val = get_unaligned_be24(&buf[0]);
 
 	return 0;
 }
diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
index b463eaa799ab..517295616869 100644
--- a/drivers/iio/pressure/ms5611_spi.c
+++ b/drivers/iio/pressure/ms5611_spi.c
@@ -45,7 +45,7 @@ static int ms5611_spi_read_adc(struct device *dev, s32 *val)
 	if (ret < 0)
 		return ret;
 
-	*val = (buf[0] << 16) | (buf[1] << 8) | buf[2];
+	*val = get_unaligned_be24(&buf[0]);
 
 	return 0;
 }
-- 
2.26.1


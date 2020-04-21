Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B5F1B1AC0
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 02:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgDUAbm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 20:31:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:14371 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgDUAbl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:41 -0400
IronPort-SDR: ThDCAsS8TNmZ8ZPeMUNBuVenSKbV1wmtLaXOCW+ssIISDo0rwNwrBthMwUILrsihEJ0JEKAOvC
 4Lb28fRAp3hQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:41 -0700
IronPort-SDR: r4m44uXAf1E6UkhoqwsU7DPpk0BSIPKbq/aoBTqKJ6vVYTGmwLKwob12dUWVCxOSW0CVjs9748
 vhDylAxP6eiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="290282135"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2020 17:31:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DC9F46D8; Tue, 21 Apr 2020 03:31:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v1 11/16] iio: magnetometer: rm3100: Use get_unaligned_be24()
Date:   Tue, 21 Apr 2020 03:31:30 +0300
Message-Id: <20200421003135.23060-11-andriy.shevchenko@linux.intel.com>
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

Cc: Song Qiang <songqiang1304521@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/rm3100-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 7c20918d8108..b3ae9a6c439b 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -223,8 +223,7 @@ static int rm3100_read_mag(struct rm3100_data *data, int idx, int *val)
 		goto unlock_return;
 	mutex_unlock(&data->lock);
 
-	*val = sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | buffer[2],
-			     23);
+	*val = sign_extend32(get_unalinged_be24(&buffer[0]), 23);
 
 	return IIO_VAL_INT;
 
-- 
2.26.1


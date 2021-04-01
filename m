Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2065351AAF
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhDASCn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 14:02:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:34705 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235115AbhDAR4S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:56:18 -0400
IronPort-SDR: QQrT7Lv3r93+6Tp7g9Nh8UreNouC3Jn3bb1EAHkzpJJ3dRVHyjlElH4cdcOIiOtTidDcYkNj9r
 be282oNTgxbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179392886"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="179392886"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:54:49 -0700
IronPort-SDR: s6iDBroVq39H0T6xw7Oqd0VieF9lpLSatZ+p1i8nN+EMCq0EG2q2BMKeQzQiOFnU7PA14ciBo3
 TXNXU4XE9W6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="456013958"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 01 Apr 2021 07:54:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D2C9222B; Thu,  1 Apr 2021 17:55:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] iio: trigger: Replace explicit casting and wrong specifier with proper one
Date:   Thu,  1 Apr 2021 17:54:56 +0300
Message-Id: <20210401145457.12255-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

By unknown reason device name is set with an index casted from int
to unsigned long while at the same time with "%ld" specifier. Both parts
seems wrong to me, thus replace replace explicit casting and wrong specifier
with proper one, i.e. "%u".

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-trigger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 32ac1bec25e3..77fca24147b2 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -75,8 +75,7 @@ int __iio_trigger_register(struct iio_trigger *trig_info,
 		return trig_info->id;
 
 	/* Set the name used for the sysfs directory etc */
-	dev_set_name(&trig_info->dev, "trigger%ld",
-		     (unsigned long) trig_info->id);
+	dev_set_name(&trig_info->dev, "trigger%u", trig_info->id);
 
 	ret = device_add(&trig_info->dev);
 	if (ret)
-- 
2.30.2


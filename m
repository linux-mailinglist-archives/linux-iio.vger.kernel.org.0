Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC69352EB6
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhDBRtC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 13:49:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:17691 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234488AbhDBRtC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Apr 2021 13:49:02 -0400
IronPort-SDR: g5i2wSmf22gD10LloUMFeJDRVjwAxVdGtfdp4Q4A//DnefRSCYLqmBJEBnPfynAIDp9FYM6vdT
 AMwKyEqZ4OsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="190278002"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="190278002"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 10:49:00 -0700
IronPort-SDR: YWno7GKDwlS5K0URHqz6OiC8DPP806DO5xT5nrf4+SR9Vq6m35yVlBPwW34WZIN8pGmrPBcb2F
 OLsep7SJvfFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="439702770"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2021 10:48:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4305022B; Fri,  2 Apr 2021 20:49:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] iio: trigger: Replace explicit casting and wrong specifier with proper one
Date:   Fri,  2 Apr 2021 20:49:10 +0300
Message-Id: <20210402174911.44408-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

By unknown reason device name is set with an index casted from int
to unsigned long while at the same time with "%ld" specifier. Both parts
seems wrong to me, thus replace replace explicit casting and wrong specifier
with proper one, i.e. "%d".

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: used %d which is really correct one
 drivers/iio/industrialio-trigger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 32ac1bec25e3..78e30f0f915c 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -75,8 +75,7 @@ int __iio_trigger_register(struct iio_trigger *trig_info,
 		return trig_info->id;
 
 	/* Set the name used for the sysfs directory etc */
-	dev_set_name(&trig_info->dev, "trigger%ld",
-		     (unsigned long) trig_info->id);
+	dev_set_name(&trig_info->dev, "trigger%d", trig_info->id);
 
 	ret = device_add(&trig_info->dev);
 	if (ret)
-- 
2.30.2


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37DC01211E5
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfLPRjB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 12:39:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:19438 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfLPRjB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Dec 2019 12:39:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 09:39:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="221543290"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Dec 2019 09:38:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 27EE42E6; Mon, 16 Dec 2019 19:38:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 7/9] iio: st_sensors: Describe function parameters in kernel-doc
Date:   Mon, 16 Dec 2019 19:38:51 +0200
Message-Id: <20191216173853.75797-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kernel documentation script complains that some of the function parameters
are not described:

.../common/st_sensors/st_sensors_trigger.c:29: warning: Function parameter or member 'indio_dev' not described in 'st_sensors_new_samples_available'
.../common/st_sensors/st_sensors_trigger.c:29: warning: Function parameter or member 'sdata' not described in 'st_sensors_new_samples_available'

Describe function parameters where it's appropriate.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 4a2efa00f7f2..e817537cdfb5 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -19,6 +19,9 @@
 
 /**
  * st_sensors_new_samples_available() - check if more samples came in
+ * @indio_dev: IIO device reference.
+ * @sdata: Sensor data.
+ *
  * returns:
  * 0 - no new samples available
  * 1 - new samples available
-- 
2.24.0


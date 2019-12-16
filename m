Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931201211E1
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 18:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfLPRi6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 12:38:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:14035 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfLPRi6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Dec 2019 12:38:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 09:38:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="240111554"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 16 Dec 2019 09:38:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F355B238; Mon, 16 Dec 2019 19:38:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/9] iio: pressure: st_press: Drop unnecessary #else branch for ACPI
Date:   Mon, 16 Dec 2019 19:38:47 +0200
Message-Id: <20191216173853.75797-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
References: <20191216173853.75797-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ACPI_PTR() takes care of the argument in case of !CONFIG_ACPI.
Remove unnecessary #else branch.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/pressure/st_pressure_i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 71d2ed6b4948..6203bc9d5c2d 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -61,8 +61,6 @@ static const struct acpi_device_id st_press_acpi_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, st_press_acpi_match);
-#else
-#define st_press_acpi_match NULL
 #endif
 
 static const struct i2c_device_id st_press_id_table[] = {
-- 
2.24.0


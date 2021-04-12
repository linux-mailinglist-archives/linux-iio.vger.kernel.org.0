Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8667335C757
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 15:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbhDLNTQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 09:19:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:37895 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237380AbhDLNTH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Apr 2021 09:19:07 -0400
IronPort-SDR: 3aq8dvHLjLWZ1w/fKIAZpbJUje0AuFhg5jpWxCjunr7U5/jF6l3zYxOV6qRbjKb6WsAEMnBNZS
 r0gZ/+fjWHCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9952"; a="214653071"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="214653071"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 06:18:24 -0700
IronPort-SDR: G5N/oM2vGP8tn3O/s18NtNPCZrfKf9GLYDdPi6BYI86sL/lGJDFBT1yNxxcQ25XEsnmm2Y02OP
 YQTWL3ozGXPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="531877246"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2021 06:18:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A1403B9; Mon, 12 Apr 2021 16:18:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] iio: adc: ad7298: Enable on Intel Galileo Gen 1
Date:   Mon, 12 Apr 2021 16:18:35 +0300
Message-Id: <20210412131835.70212-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable ADC on Intel Galileo Gen 1 board.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed typo in ID
 drivers/iio/adc/ad7298.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 689ecd5dd563..e7e866433090 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -13,6 +13,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
@@ -352,6 +353,12 @@ static int ad7298_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
+static const struct acpi_device_id ad7298_acpi_ids[] = {
+	{ "INT3494", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, ad7298_acpi_ids);
+
 static const struct spi_device_id ad7298_id[] = {
 	{"ad7298", 0},
 	{}
@@ -361,6 +368,7 @@ MODULE_DEVICE_TABLE(spi, ad7298_id);
 static struct spi_driver ad7298_driver = {
 	.driver = {
 		.name	= "ad7298",
+		.acpi_match_table = ad7298_acpi_ids,
 	},
 	.probe		= ad7298_probe,
 	.id_table	= ad7298_id,
-- 
2.30.2


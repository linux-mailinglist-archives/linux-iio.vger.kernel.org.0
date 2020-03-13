Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8566818453B
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 11:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgCMKuC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 06:50:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:20465 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgCMKuC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Mar 2020 06:50:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 03:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="289994518"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Mar 2020 03:50:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DEC3D463; Fri, 13 Mar 2020 12:49:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 7/8] iio: humidity: hts221: Make use of device properties
Date:   Fri, 13 Mar 2020 12:49:54 +0200
Message-Id: <20200313104955.30423-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
References: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Device property API allows to gather device resources from different sources,
such as ACPI. Convert the drivers to unleash the power of device property API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/iio/humidity/hts221_buffer.c | 3 +--
 drivers/iio/humidity/hts221_i2c.c    | 2 +-
 drivers/iio/humidity/hts221_spi.c    | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 5f142a44c1dd..9fb3f33614d4 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -77,7 +77,6 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
 	struct st_sensors_platform_data *pdata = dev_get_platdata(hw->dev);
 	struct iio_dev *iio_dev = iio_priv_to_dev(hw);
 	bool irq_active_low = false, open_drain = false;
-	struct device_node *np = hw->dev->of_node;
 	unsigned long irq_type;
 	int err;
 
@@ -106,7 +105,7 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
 	if (err < 0)
 		return err;
 
-	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
+	if (device_property_read_bool(hw->dev, "drive-open-drain") ||
 	    (pdata && pdata->open_drain)) {
 		irq_type |= IRQF_SHARED;
 		open_drain = true;
diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
index 4272b7030c44..1398794e4bc7 100644
--- a/drivers/iio/humidity/hts221_i2c.c
+++ b/drivers/iio/humidity/hts221_i2c.c
@@ -63,7 +63,7 @@ static struct i2c_driver hts221_driver = {
 	.driver = {
 		.name = "hts221_i2c",
 		.pm = &hts221_pm_ops,
-		.of_match_table = of_match_ptr(hts221_i2c_of_match),
+		.of_match_table = hts221_i2c_of_match,
 		.acpi_match_table = ACPI_PTR(hts221_acpi_match),
 	},
 	.probe = hts221_i2c_probe,
diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts221_spi.c
index 055dba8897d2..ba1115489c2c 100644
--- a/drivers/iio/humidity/hts221_spi.c
+++ b/drivers/iio/humidity/hts221_spi.c
@@ -56,7 +56,7 @@ static struct spi_driver hts221_driver = {
 	.driver = {
 		.name = "hts221_spi",
 		.pm = &hts221_pm_ops,
-		.of_match_table = of_match_ptr(hts221_spi_of_match),
+		.of_match_table = hts221_spi_of_match,
 	},
 	.probe = hts221_spi_probe,
 	.id_table = hts221_spi_id_table,
-- 
2.25.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717894FF929
	for <lists+linux-iio@lfdr.de>; Wed, 13 Apr 2022 16:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiDMOoJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Apr 2022 10:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbiDMOoH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Apr 2022 10:44:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EE850448;
        Wed, 13 Apr 2022 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649860906; x=1681396906;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h0eLVFFWViG1x6V21DPemjegErPK0/jqGlo5FApwXHc=;
  b=BOQOilJaUo6u+3xPXSA8Yp/1wDYauNx1uNbh+j9p2xC/uYa+z+AdFSx2
   3Qq/y2DiD/HjBSK5rHTmdeVA3N/lPGd9ReipZiMXdHRjNSZYF1CG3Wg2N
   xFMDbUPpYeM47GmRGCanOTG9M/GOQSucSk8tDLn/Lpdq7eIPQYcVk0K97
   Yf2QtTx6hK8XzlpINXUW0GiQ0lF21PeWt/NBkq8CcZnW203OYIsQP2XW/
   QGP9YWLgpBKlu7wUSxNpOezKwO6rR6EWGT9cLIOnidjoqJQAESmbweq0T
   TPeolwLtzitbO/P9kLCt35pGN5vg0hQM64yUx3RETdTjLSfYYD7KvcRPq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="323129488"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323129488"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 07:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="526500571"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 13 Apr 2022 07:41:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D1E15191; Wed, 13 Apr 2022 17:41:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 1/3] iio: imu: adis16480: Make use of device properties
Date:   Wed, 13 Apr 2022 17:41:22 +0300
Message-Id: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/adis16480.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 44bbe3d19907..68eed088cca6 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -7,14 +7,16 @@
 
 #include <linux/clk.h>
 #include <linux/bitfield.h>
-#include <linux/of_irq.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/math.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/lcm.h>
+#include <linux/property.h>
 #include <linux/swab.h>
 #include <linux/crc32.h>
 
@@ -1239,9 +1241,10 @@ static int adis16480_enable_irq(struct adis *adis, bool enable)
 	return __adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
 }
 
-static int adis16480_config_irq_pin(struct device_node *of_node,
-				    struct adis16480 *st)
+static int adis16480_config_irq_pin(struct adis16480 *st)
 {
+	struct device *dev = &st->adis.spi->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct irq_data *desc;
 	enum adis16480_int_pin pin;
 	unsigned int irq_type;
@@ -1267,7 +1270,7 @@ static int adis16480_config_irq_pin(struct device_node *of_node,
 	 */
 	pin = ADIS16480_PIN_DIO1;
 	for (i = 0; i < ARRAY_SIZE(adis16480_int_pin_names); i++) {
-		irq = of_irq_get_byname(of_node, adis16480_int_pin_names[i]);
+		irq = fwnode_irq_get_byname(fwnode, adis16480_int_pin_names[i]);
 		if (irq > 0) {
 			pin = i;
 			break;
@@ -1295,15 +1298,15 @@ static int adis16480_config_irq_pin(struct device_node *of_node,
 	return adis_write_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, val);
 }
 
-static int adis16480_of_get_ext_clk_pin(struct adis16480 *st,
-					struct device_node *of_node)
+static int adis16480_fw_get_ext_clk_pin(struct adis16480 *st)
 {
+	struct device *dev = &st->adis.spi->dev;
 	const char *ext_clk_pin;
 	enum adis16480_int_pin pin;
 	int i;
 
 	pin = ADIS16480_PIN_DIO2;
-	if (of_property_read_string(of_node, "adi,ext-clk-pin", &ext_clk_pin))
+	if (device_property_read_string(dev, "adi,ext-clk-pin", &ext_clk_pin))
 		goto clk_input_not_found;
 
 	for (i = 0; i < ARRAY_SIZE(adis16480_int_pin_names); i++) {
@@ -1317,9 +1320,7 @@ static int adis16480_of_get_ext_clk_pin(struct adis16480 *st,
 	return pin;
 }
 
-static int adis16480_ext_clk_config(struct adis16480 *st,
-				    struct device_node *of_node,
-				    bool enable)
+static int adis16480_ext_clk_config(struct adis16480 *st, bool enable)
 {
 	unsigned int mode, mask;
 	enum adis16480_int_pin pin;
@@ -1330,7 +1331,7 @@ static int adis16480_ext_clk_config(struct adis16480 *st,
 	if (ret)
 		return ret;
 
-	pin = adis16480_of_get_ext_clk_pin(st, of_node);
+	pin = adis16480_fw_get_ext_clk_pin(st);
 	/*
 	 * Each DIOx pin supports only one function at a time. When a single pin
 	 * has two assignments, the enable bit for a lower priority function
@@ -1438,7 +1439,7 @@ static int adis16480_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	ret = adis16480_config_irq_pin(spi->dev.of_node, st);
+	ret = adis16480_config_irq_pin(st);
 	if (ret)
 		return ret;
 
@@ -1447,7 +1448,7 @@ static int adis16480_probe(struct spi_device *spi)
 		return ret;
 
 	if (!IS_ERR_OR_NULL(st->ext_clk)) {
-		ret = adis16480_ext_clk_config(st, spi->dev.of_node, true);
+		ret = adis16480_ext_clk_config(st, true);
 		if (ret)
 			return ret;
 
-- 
2.35.1


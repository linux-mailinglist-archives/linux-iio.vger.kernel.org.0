Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E03CD21B
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 15:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfJFNWq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 09:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFNWp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 09:22:45 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80A922087E;
        Sun,  6 Oct 2019 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570368165;
        bh=HWiROyqVHj52scWeZCx9IuF0DfAJWdxDz8Yg11/KS8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5SNEgu2FEUWbFEvARi3G+1Oz4EVcQRjXkbSFSsvnAo/XczF8NFuCkKniMSEbV28F
         DZ5yYcjhVZTm4cS6QKUpDJXEaOTUf45fa+C2yBmDg7QulGdyNCadms4qXmNSPg9d6a
         HGEBNf/EQpy0f3w0GNN8BUNjvswFWAp9fJFys3gw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: [PATCH 10/13] iio: imu: st_lsm6dsx: add wakeup_source in st_sensors_platform_data
Date:   Sun,  6 Oct 2019 15:22:04 +0200
Message-Id: <a237c2406825ff16c5606344420fd566b08525f9.1570367532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the possibility to enable/disable wakeup source through
st_sensors_platform_data and not only through device tree

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 6 ++++--
 include/linux/platform_data/st_sensors_pdata.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index b0623b837abd..a2a0ac81e3d3 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2089,7 +2089,9 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		     struct regmap *regmap)
 {
+	struct st_sensors_platform_data *pdata = dev->platform_data;
 	const struct st_lsm6dsx_shub_settings *hub_settings;
+	struct device_node *np = dev->of_node;
 	struct st_lsm6dsx_hw *hw;
 	const char *name = NULL;
 	int i, err;
@@ -2152,8 +2154,8 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
-	if (dev->of_node &&
-	    of_property_read_bool(dev->of_node, "wakeup-source"))
+	if ((np && of_property_read_bool(np, "wakeup-source")) ||
+	    (pdata && pdata->wakeup_source))
 		device_init_wakeup(dev, true);
 
 	return 0;
diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
index 30929c22227d..e40b28ca892e 100644
--- a/include/linux/platform_data/st_sensors_pdata.h
+++ b/include/linux/platform_data/st_sensors_pdata.h
@@ -18,12 +18,14 @@
  * @open_drain: set the interrupt line to be open drain if possible.
  * @spi_3wire: enable spi-3wire mode.
  * @pullups: enable/disable i2c controller pullup resistors.
+ * @wakeup_source: enable/disable device as wakeup generator.
  */
 struct st_sensors_platform_data {
 	u8 drdy_int_pin;
 	bool open_drain;
 	bool spi_3wire;
 	bool pullups;
+	bool wakeup_source;
 };
 
 #endif /* ST_SENSORS_PDATA_H */
-- 
2.21.0


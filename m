Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362DC11FBF2
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 01:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfLPAAu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 19:00:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43346 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfLPAAu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 19:00:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id p27so3661445pli.10
        for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2019 16:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Vu+p6r8ndnRT3v+F71va9D8kd+UdXPMbSeMrQKvqFU=;
        b=NXI6OvT+MlyG/+pIlnONLowEKkgIBLmkxgTlinIybYVS9lFG+yE2dQUA4+4+GJk9ZW
         BL4YN+obNb2ehlkrzoTVAi12cj8I91DZkS5lsabhgdFJKpzd4BHp5BYxMFKsLbLdzlFs
         MbNdLSx1mjyAxnkMSG4DJE/JVRRVO1DfIfe6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Vu+p6r8ndnRT3v+F71va9D8kd+UdXPMbSeMrQKvqFU=;
        b=Q6YtH+N06e7fGug413hVU08iReFCsM66CTcbuXIEYFDPjiHA2kFk6SqDmUFSMjxKPd
         1ElDixKAUvf+9rOlYyeIqA99BV7L3TgKE8XlK86uh2oRISF03eAEZxCCRjIWO/TIbo7w
         jNXkNi7YMpnMzcmzLzkcRiVBXg39DWc1yyCehG3YNEQmzKAwYOhOXg/2mNYMieR7RnLo
         WTynaRwwA0W3EpKE2m51kK2BJgTxVelPyR8XIc+AkRX9PQQp2XX1Ke+0f/J44Qc9FpWJ
         gBpmXlHR8z3PZEO1sngQV1WrIoROMkdjBuI7iMDt9rAT6U/ZNgPTEg19vgwAEdVVO1GK
         fEoA==
X-Gm-Message-State: APjAAAXoclFceTKOTEEx4v/7BksgYhJZVci6Q8SsT8tG+fXHRAm9W6md
        s1F+ZM5DirxUIYbGJdu1fLTzzmvKMk9pqw==
X-Google-Smtp-Source: APXvYqxkv/s5cDFZtXlyucGI3NWya4inHS5v6ou0mj9cHOUShPS2kTu0fwsrl65ZZXTykNyFHUdwyQ==
X-Received: by 2002:a17:90b:85:: with SMTP id bb5mr14146221pjb.22.1576454449266;
        Sun, 15 Dec 2019 16:00:49 -0800 (PST)
Received: from localhost.localdomain (50-196-3-218-static.hfc.comcastbusiness.net. [50.196.3.218])
        by smtp.gmail.com with ESMTPSA id m45sm16751404pje.32.2019.12.15.16.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 16:00:47 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: chemical: atlas-ph-sensor: rename atlas-ph-sensor to atlas-sensor
Date:   Sun, 15 Dec 2019 16:00:45 -0800
Message-Id: <20191216000045.30482-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since the orginal scope of the driver was to only support
the pH product from Atlas it has evolved to other sensors.

Rename the file, driver name, and regmap to atlas-sensor which
reflects this, although keep CONFIG_ATLAS_PH_SENSOR to not cause
regressions with current configurations.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/Makefile                          |  2 +-
 .../iio/chemical/{atlas-ph-sensor.c => atlas-sensor.c} | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/iio/chemical/{atlas-ph-sensor.c => atlas-sensor.c} (98%)

diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index f97270bc4034..33d3a595dda9 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -4,7 +4,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
-obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-ph-sensor.o
+obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-sensor.o
 obj-$(CONFIG_BME680) += bme680_core.o
 obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
 obj-$(CONFIG_BME680_SPI) += bme680_spi.o
diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-sensor.c
similarity index 98%
rename from drivers/iio/chemical/atlas-ph-sensor.c
rename to drivers/iio/chemical/atlas-sensor.c
index 6c175eb1c7a7..8cd76d828646 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * atlas-ph-sensor.c - Support for Atlas Scientific OEM pH-SM sensor
+ * atlas-sensor.c - Support for Atlas Scientific OEM SM sensors
  *
- * Copyright (C) 2015-2018 Matt Ranostay
+ * Copyright (C) 2015-2019 Konsulko Group
  * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  */
 
@@ -25,8 +25,8 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/pm_runtime.h>
 
-#define ATLAS_REGMAP_NAME	"atlas_ph_regmap"
-#define ATLAS_DRV_NAME		"atlas_ph"
+#define ATLAS_REGMAP_NAME	"atlas_regmap"
+#define ATLAS_DRV_NAME		"atlas"
 
 #define ATLAS_REG_DEV_TYPE		0x00
 #define ATLAS_REG_DEV_VERSION		0x01
@@ -681,5 +681,5 @@ static struct i2c_driver atlas_driver = {
 module_i2c_driver(atlas_driver);
 
 MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
-MODULE_DESCRIPTION("Atlas Scientific pH-SM sensor");
+MODULE_DESCRIPTION("Atlas Scientific SM sensors");
 MODULE_LICENSE("GPL");
-- 
2.20.1


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2E0481FDC
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 20:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbhL3T1v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 14:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbhL3T1v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 14:27:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555DCC061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 11:27:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8590361751
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 19:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A841BC36AE7;
        Thu, 30 Dec 2021 19:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640892470;
        bh=d58a3HD8sn4i9BdzOgv/KMothBAu+U9yXzw2rXzIKGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpVztk3pNrpW2+GD5goqMOAYVvs1T8klr/kCMtw/HueZFi5ejJ8RSRUA5HaVDr6jA
         ViEh4En3Y8uAVOo9Wkkj9OK1dRMlFgTdL8tcFtV3HtgCeP+xAt3ncXUCSaKoG8QNuV
         chmuIa/yr079TiflYxTeeK3Q+yfxB9lmOtMdBFZ5vpINFd+T+m2knuzq6QPp3N6pqD
         QqC3eq/S/QWNV8xjtdVnUPZnVx3QDNsGBZPDGmlopipihQlej5p8Zt+TmUAgu5mGfN
         hIofXyZ2c5BN2iViMpuCnLddl9qOrITXZoyygodmH+L8/JY0EUXBa3oDhXc/ZlNPED
         qqYVpnIhoszyQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/13] iio:accel:mma9551_core: Move exports into MMA9551 namespace
Date:   Thu, 30 Dec 2021 19:33:19 +0000
Message-Id: <20211230193331.283503-2-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230193331.283503-1-jic23@kernel.org>
References: <20211230193331.283503-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In order to avoid unnecessary pollution of the global symbol namespace
move the core mma9551 functions into an mma9551 specific namespace.

For more information see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mma9551.c      |  1 +
 drivers/iio/accel/mma9551_core.c | 36 ++++++++++++++++----------------
 drivers/iio/accel/mma9553.c      |  1 +
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 4c359fb05480..c5bccda55b23 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -622,3 +622,4 @@ MODULE_AUTHOR("Irina Tirdea <irina.tirdea@intel.com>");
 MODULE_AUTHOR("Vlad Dogaru <vlad.dogaru@intel.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MMA9551L motion-sensing platform driver");
+MODULE_IMPORT_NS(MMA9551);
diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
index fbf2e2c45678..67c116d4fbe9 100644
--- a/drivers/iio/accel/mma9551_core.c
+++ b/drivers/iio/accel/mma9551_core.c
@@ -219,7 +219,7 @@ int mma9551_read_config_byte(struct i2c_client *client, u8 app_id,
 	return mma9551_transfer(client, app_id, MMA9551_CMD_READ_CONFIG,
 				reg, NULL, 0, val, 1);
 }
-EXPORT_SYMBOL(mma9551_read_config_byte);
+EXPORT_SYMBOL_NS(mma9551_read_config_byte, MMA9551);
 
 /**
  * mma9551_write_config_byte() - write 1 configuration byte
@@ -244,7 +244,7 @@ int mma9551_write_config_byte(struct i2c_client *client, u8 app_id,
 	return mma9551_transfer(client, app_id, MMA9551_CMD_WRITE_CONFIG, reg,
 				&val, 1, NULL, 0);
 }
-EXPORT_SYMBOL(mma9551_write_config_byte);
+EXPORT_SYMBOL_NS(mma9551_write_config_byte, MMA9551);
 
 /**
  * mma9551_read_status_byte() - read 1 status byte
@@ -269,7 +269,7 @@ int mma9551_read_status_byte(struct i2c_client *client, u8 app_id,
 	return mma9551_transfer(client, app_id, MMA9551_CMD_READ_STATUS,
 				reg, NULL, 0, val, 1);
 }
-EXPORT_SYMBOL(mma9551_read_status_byte);
+EXPORT_SYMBOL_NS(mma9551_read_status_byte, MMA9551);
 
 /**
  * mma9551_read_config_word() - read 1 config word
@@ -300,7 +300,7 @@ int mma9551_read_config_word(struct i2c_client *client, u8 app_id,
 
 	return ret;
 }
-EXPORT_SYMBOL(mma9551_read_config_word);
+EXPORT_SYMBOL_NS(mma9551_read_config_word, MMA9551);
 
 /**
  * mma9551_write_config_word() - write 1 config word
@@ -327,7 +327,7 @@ int mma9551_write_config_word(struct i2c_client *client, u8 app_id,
 	return mma9551_transfer(client, app_id, MMA9551_CMD_WRITE_CONFIG, reg,
 				(u8 *)&v, 2, NULL, 0);
 }
-EXPORT_SYMBOL(mma9551_write_config_word);
+EXPORT_SYMBOL_NS(mma9551_write_config_word, MMA9551);
 
 /**
  * mma9551_read_status_word() - read 1 status word
@@ -358,7 +358,7 @@ int mma9551_read_status_word(struct i2c_client *client, u8 app_id,
 
 	return ret;
 }
-EXPORT_SYMBOL(mma9551_read_status_word);
+EXPORT_SYMBOL_NS(mma9551_read_status_word, MMA9551);
 
 /**
  * mma9551_read_config_words() - read multiple config words
@@ -397,7 +397,7 @@ int mma9551_read_config_words(struct i2c_client *client, u8 app_id,
 
 	return 0;
 }
-EXPORT_SYMBOL(mma9551_read_config_words);
+EXPORT_SYMBOL_NS(mma9551_read_config_words, MMA9551);
 
 /**
  * mma9551_read_status_words() - read multiple status words
@@ -436,7 +436,7 @@ int mma9551_read_status_words(struct i2c_client *client, u8 app_id,
 
 	return 0;
 }
-EXPORT_SYMBOL(mma9551_read_status_words);
+EXPORT_SYMBOL_NS(mma9551_read_status_words, MMA9551);
 
 /**
  * mma9551_write_config_words() - write multiple config words
@@ -471,7 +471,7 @@ int mma9551_write_config_words(struct i2c_client *client, u8 app_id,
 	return mma9551_transfer(client, app_id, MMA9551_CMD_WRITE_CONFIG,
 				reg, (u8 *)be_buf, len * sizeof(u16), NULL, 0);
 }
-EXPORT_SYMBOL(mma9551_write_config_words);
+EXPORT_SYMBOL_NS(mma9551_write_config_words, MMA9551);
 
 /**
  * mma9551_update_config_bits() - update bits in register
@@ -507,7 +507,7 @@ int mma9551_update_config_bits(struct i2c_client *client, u8 app_id,
 
 	return mma9551_write_config_byte(client, app_id, reg, tmp);
 }
-EXPORT_SYMBOL(mma9551_update_config_bits);
+EXPORT_SYMBOL_NS(mma9551_update_config_bits, MMA9551);
 
 /**
  * mma9551_gpio_config() - configure gpio
@@ -586,7 +586,7 @@ int mma9551_gpio_config(struct i2c_client *client, enum mma9551_gpio_pin pin,
 
 	return ret;
 }
-EXPORT_SYMBOL(mma9551_gpio_config);
+EXPORT_SYMBOL_NS(mma9551_gpio_config, MMA9551);
 
 /**
  * mma9551_read_version() - read device version information
@@ -616,7 +616,7 @@ int mma9551_read_version(struct i2c_client *client)
 
 	return 0;
 }
-EXPORT_SYMBOL(mma9551_read_version);
+EXPORT_SYMBOL_NS(mma9551_read_version, MMA9551);
 
 /**
  * mma9551_set_device_state() - sets HW power mode
@@ -646,7 +646,7 @@ int mma9551_set_device_state(struct i2c_client *client, bool enable)
 					  MMA9551_SLEEP_CFG_FLEEN :
 					  MMA9551_SLEEP_CFG_SNCEN);
 }
-EXPORT_SYMBOL(mma9551_set_device_state);
+EXPORT_SYMBOL_NS(mma9551_set_device_state, MMA9551);
 
 /**
  * mma9551_set_power_state() - sets runtime PM state
@@ -680,7 +680,7 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
 
 	return 0;
 }
-EXPORT_SYMBOL(mma9551_set_power_state);
+EXPORT_SYMBOL_NS(mma9551_set_power_state, MMA9551);
 
 /**
  * mma9551_sleep() - sleep
@@ -699,7 +699,7 @@ void mma9551_sleep(int freq)
 	else
 		msleep_interruptible(sleep_val);
 }
-EXPORT_SYMBOL(mma9551_sleep);
+EXPORT_SYMBOL_NS(mma9551_sleep, MMA9551);
 
 /**
  * mma9551_read_accel_chan() - read accelerometer channel
@@ -755,7 +755,7 @@ int mma9551_read_accel_chan(struct i2c_client *client,
 	mma9551_set_power_state(client, false);
 	return ret;
 }
-EXPORT_SYMBOL(mma9551_read_accel_chan);
+EXPORT_SYMBOL_NS(mma9551_read_accel_chan, MMA9551);
 
 /**
  * mma9551_read_accel_scale() - read accelerometer scale
@@ -773,7 +773,7 @@ int mma9551_read_accel_scale(int *val, int *val2)
 
 	return IIO_VAL_INT_PLUS_MICRO;
 }
-EXPORT_SYMBOL(mma9551_read_accel_scale);
+EXPORT_SYMBOL_NS(mma9551_read_accel_scale, MMA9551);
 
 /**
  * mma9551_app_reset() - reset application
@@ -792,7 +792,7 @@ int mma9551_app_reset(struct i2c_client *client, u32 app_mask)
 					 MMA9551_RSC_OFFSET(app_mask),
 					 MMA9551_RSC_VAL(app_mask));
 }
-EXPORT_SYMBOL(mma9551_app_reset);
+EXPORT_SYMBOL_NS(mma9551_app_reset, MMA9551);
 
 MODULE_AUTHOR("Irina Tirdea <irina.tirdea@intel.com>");
 MODULE_AUTHOR("Vlad Dogaru <vlad.dogaru@intel.com>");
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 0570ab1cc064..113d7a6c9e9a 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1260,3 +1260,4 @@ module_i2c_driver(mma9553_driver);
 MODULE_AUTHOR("Irina Tirdea <irina.tirdea@intel.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MMA9553L pedometer platform driver");
+MODULE_IMPORT_NS(MMA9551);
-- 
2.34.1


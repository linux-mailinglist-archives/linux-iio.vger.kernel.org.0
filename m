Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F361241BBF
	for <lists+linux-iio@lfdr.de>; Tue, 11 Aug 2020 15:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgHKNth (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Aug 2020 09:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgHKNtX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Aug 2020 09:49:23 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2536C061788
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2020 06:49:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so6756299pgf.0
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2020 06:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AoEr01AHk+SYGQZKnHRRnV24txmFcO6uqi01CjayjxM=;
        b=X8hLktlEAoM4pdHaz3vhlIbQpueL/IgSwm5xAC43zxAPboitI/UqBvNtmkmb2jxnrZ
         NgR9ANqBXywegMCQgjnFyVx3KJacdLrC+D3xwPT4CFaggEmhxlylHsbwG+AmtdrC0Vru
         M6LJbYdjo+inGiENt/4O2QmSA/BR3AxogYXXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AoEr01AHk+SYGQZKnHRRnV24txmFcO6uqi01CjayjxM=;
        b=E4ySPji8ryo+9b1bsYK/PX6Z5VeEWJPLtDUVsLmMY7HywVkAOYg0DuW0bNKtyOe8Lv
         F8R0/ne+PYVldz+IL9enNRZjW1yTWfmYRoG7V3hT7hlQzaJ4gYV56ErIGUOHixqWGF0l
         oweAOAvlJUmpR+9p7TmAHhvF7RBPP2vDBOJeKHIkq5Ndm7sXLShBeXd82WHqRxlMGPRL
         tevpD0T+VV5J1xxuEP41G3lycY4io0HBQwOBq9jlDo42TYf1pzFQC2y6E20iB8wMB5OU
         gRapIgg8X+GhNsbNS+8w37aeMITzQk5rI23uixtHtPj7RTPOe1vlGyy5tpvJTSB+iPlX
         +1Mg==
X-Gm-Message-State: AOAM53275JBG9mJf7mBw52fIJQcOdcNxpZ5g6H/bIqGuU3DBhDigQ9Oe
        7L1Set/EbyfIUT5BfRyikFGq9OXSOaE=
X-Google-Smtp-Source: ABdhPJwaBqSRdKnojPv03/xyuA0Kqod4EJMD5Lxer+PFw59YkPe2jxsOAgi6dHuWD1re0TJoapU/kQ==
X-Received: by 2002:a63:30c2:: with SMTP id w185mr907677pgw.15.1597153757117;
        Tue, 11 Aug 2020 06:49:17 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id w23sm20884447pgj.5.2020.08.11.06.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 06:49:16 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-iio@vger.kernel.org
Cc:     daniel@0x0f.com
Subject: [RFC PATCH 2/2] iio: st-accel: Add support for Silan SC7A20 and SC7A30E
Date:   Tue, 11 Aug 2020 22:48:46 +0900
Message-Id: <20200811134846.3981475-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200811134846.3981475-1-daniel@0x0f.com>
References: <20200811134846.3981475-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This chips are not from ST but seem to be clones of the ST parts.
The register and bit settings in the datasheets match those in the
LIS2DH datasheet.
---
 drivers/iio/accel/st_accel.h      |   4 +
 drivers/iio/accel/st_accel_core.c | 159 +++++++++++++++++++++++++++++-
 drivers/iio/accel/st_accel_i2c.c  |  10 ++
 3 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 5d356288e001..784c2df83dde 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -36,6 +36,8 @@ enum st_accel_type {
 	LIS3DHH,
 	LIS2DE12,
 	LIS2HH12,
+	SC7A20,
+	SC7A30E,
 	ST_ACCEL_MAX,
 };
 
@@ -61,6 +63,8 @@ enum st_accel_type {
 #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
 #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
 #define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
+#define SC7A20_ACCEL_DEV_NAME		"sc7a20"
+#define SC7A30E_ACCEL_DEV_NAME		"sc7a30e"
 
 /**
 * struct st_sensors_platform_data - default accel platform data
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 43c50167d220..23fdbf27d44c 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -980,7 +980,164 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
-
+	{
+		.wai = 0x11,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = SC7A20_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
+		.odr = {
+			.addr = 0x20,
+			.mask = 0xf0,
+			.odr_avl = {
+				{ .hz = 1, .value = 0x01, },
+				{ .hz = 10, .value = 0x02, },
+				{ .hz = 25, .value = 0x03, },
+				{ .hz = 50, .value = 0x04, },
+				{ .hz = 100, .value = 0x05, },
+				{ .hz = 200, .value = 0x06, },
+				{ .hz = 400, .value = 0x07, },
+				{ .hz = 1600, .value = 0x08, },
+			},
+		},
+		.pw = {
+			.addr = 0x20,
+			.mask = 0xf0,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = 0x23,
+			.mask = 0x30,
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_2G,
+					.value = 0x00,
+					.gain = IIO_G_TO_M_S_2(1000),
+				},
+				[1] = {
+					.num = ST_ACCEL_FS_AVL_4G,
+					.value = 0x01,
+					.gain = IIO_G_TO_M_S_2(2000),
+				},
+				[2] = {
+					.num = ST_ACCEL_FS_AVL_8G,
+					.value = 0x02,
+					.gain = IIO_G_TO_M_S_2(4000),
+				},
+				[3] = {
+					.num = ST_ACCEL_FS_AVL_16G,
+					.value = 0x03,
+					.gain = IIO_G_TO_M_S_2(12000),
+				},
+			},
+		},
+		.bdu = {
+			.addr = 0x23,
+			.mask = 0x80,
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x10,
+			},
+			.addr_ihl = 0x25,
+			.mask_ihl = 0x02,
+			.stat_drdy = {
+				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
+				.mask = 0x07,
+			},
+		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
+		.multi_read_bit = true,
+		.bootime = 2,
+	},
+	{
+		.wai = 0x33,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = SC7A30E_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
+		.odr = {
+			.addr = 0x20,
+			.mask = 0xf0,
+			.odr_avl = {
+				{ .hz = 1, .value = 0x01, },
+				{ .hz = 10, .value = 0x02, },
+				{ .hz = 25, .value = 0x03, },
+				{ .hz = 50, .value = 0x04, },
+				{ .hz = 100, .value = 0x05, },
+				{ .hz = 200, .value = 0x06, },
+				{ .hz = 400, .value = 0x07, },
+				{ .hz = 1600, .value = 0x08, },
+			},
+		},
+		.pw = {
+			.addr = 0x20,
+			.mask = 0xf0,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = 0x23,
+			.mask = 0x30,
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_2G,
+					.value = 0x00,
+					.gain = IIO_G_TO_M_S_2(1000),
+				},
+				[1] = {
+					.num = ST_ACCEL_FS_AVL_4G,
+					.value = 0x01,
+					.gain = IIO_G_TO_M_S_2(2000),
+				},
+				[2] = {
+					.num = ST_ACCEL_FS_AVL_8G,
+					.value = 0x02,
+					.gain = IIO_G_TO_M_S_2(4000),
+				},
+				[3] = {
+					.num = ST_ACCEL_FS_AVL_16G,
+					.value = 0x03,
+					.gain = IIO_G_TO_M_S_2(12000),
+				},
+			},
+		},
+		.bdu = {
+			.addr = 0x23,
+			.mask = 0x80,
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x10,
+			},
+			.addr_ihl = 0x25,
+			.mask_ihl = 0x02,
+			.stat_drdy = {
+				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
+				.mask = 0x07,
+			},
+		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
+		.multi_read_bit = true,
+		.bootime = 2,
+	},
 };
 
 static int st_accel_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 360e16f2cadb..2c9e91ef5e19 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -108,6 +108,14 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,lis2hh12",
 		.data = LIS2HH12_ACCEL_DEV_NAME,
 	},
+	{
+		.compatible = "silan,sc7a20-accel",
+		.data = SC7A20_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "silan,sc7a30e-accel",
+		.data = SC7A30E_ACCEL_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -143,6 +151,8 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LIS3DE_ACCEL_DEV_NAME },
 	{ LIS2DE12_ACCEL_DEV_NAME },
 	{ LIS2HH12_ACCEL_DEV_NAME },
+	{ SC7A20_ACCEL_DEV_NAME },
+	{ SC7A30E_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
-- 
2.27.0


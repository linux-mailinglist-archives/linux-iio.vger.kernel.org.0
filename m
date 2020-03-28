Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 098D31968A9
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 19:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgC1Spy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 14:45:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39096 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgC1Spy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 14:45:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id i20so13632271ljn.6
        for <linux-iio@vger.kernel.org>; Sat, 28 Mar 2020 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUsdNFpgnIaNR6yOO+Kv3b62V0TWAJjUUURX0oRUKHY=;
        b=Y44lZCNMqnjVhA+gybvKMybKldYWKWAdNjzeEIuv05ZmYKeFNEM57EBq0jrlkvRMXb
         7NEoLcyu+DUigFCy1i/Cdcvx16te+saWXEzZlZPF11XpAIAPro7wyMMSngLbSaKTQvvX
         sPArdq+2p2AkCZoghsBXcpT9xczigy9dQQ//Jxqi5khublfSA4GeBshGyF4Y8ic0fcwv
         2bzSUvCyHLJQ8nJwvf2BbBKEqFDYqCE7zDjC38RpW7KHzuJIczlppmV9I/1gZCXOP0JI
         x4vEsgxUDpokbI2dD43i6yvxVzchRQoCAWudTzupNW/uvquLRWprIUdX9tUlHLqkeCNA
         vuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUsdNFpgnIaNR6yOO+Kv3b62V0TWAJjUUURX0oRUKHY=;
        b=cYL8PsCNSqysnBQnSfOYjKfDZYwMOTpkEFmrlb5M9+Ku7rqoGJncyCi81XlIvN1I4h
         RNXahPimK6/tlsC4ewhgEoLSVq/Wn0d8ds6ZDLd1fifxR2TWFu1/7iD77ELvmb5kSCbt
         f0gp3/YVvJN0zdzIks0ieustrBPOMPgLoq1EaWGDD15XRVvwOF0kv3ReQyM06YaUKUY2
         gJt8/eSjoE4ZaGECuwsLGZ0cz+3ybS1lpK5dUzT0DBu7dHl3xXRqlz/nNNdYdpv/RGeZ
         ChMjUN8AtrL1bLi+71KSJ+60B2Jz23W6+ZrlGBC7XmQhr2CkBEce2YGk+Dvohg523cR7
         SRqg==
X-Gm-Message-State: AGi0PubZwsXDCuAk7aSufSxSSwfk0eYrJM12JmVzONonCL7PeXOkfIIS
        67u4H4b1G6uT5dkZtX71DeLEwU2q
X-Google-Smtp-Source: APiQypKcGaSXR7Rdd5T+h+vr7rq7erdsSD4yg7pqk52YV0kXymli9+US+2MHlQY3lERhZY2H4mkSkA==
X-Received: by 2002:a05:651c:404:: with SMTP id 4mr2852431lja.281.1585421149608;
        Sat, 28 Mar 2020 11:45:49 -0700 (PDT)
Received: from samarch.kvaser.se (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id l20sm3472145lji.74.2020.03.28.11.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 11:45:48 -0700 (PDT)
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 2/2] iio: imu: st_lsm6dsx: Add sensor hub device LIS3MDL
Date:   Sat, 28 Mar 2020 19:45:19 +0100
Message-Id: <20200328184519.2302703-1-jimmyassarsson@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add LIS3MDL register map to sensor hub device table.
Tested with LSM6DSM.

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
---
Changes in v2:
  - Use ST_SENSORS_DEFAULT_WAI_ADDRESS

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 64 ++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 95ddd19d1aa7..3b983e0cc5ce 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -28,6 +28,7 @@
 #include <linux/iio/sysfs.h>
 #include <linux/bitfield.h>
 
+#include <linux/iio/common/st_sensors.h>
 #include "st_lsm6dsx.h"
 
 #define ST_LSM6DSX_SLV_ADDR(n, base)		((base) + (n) * 3)
@@ -88,6 +89,69 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
 			.len = 6,
 		},
 	},
+	/* LIS3MDL */
+	{
+		.i2c_addr = { 0x1e },
+		.wai = {
+			.addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+			.val = 0x3d,
+		},
+		.id = ST_LSM6DSX_ID_MAGN,
+		.odr_table = {
+			.reg = {
+				.addr = 0x20,
+				.mask = GENMASK(4, 2),
+			},
+			.odr_avl[0] = {  1000, 0x0 },
+			.odr_avl[1] = {  2000, 0x1 },
+			.odr_avl[2] = {  3000, 0x2 },
+			.odr_avl[3] = {  5000, 0x3 },
+			.odr_avl[4] = { 10000, 0x4 },
+			.odr_avl[5] = { 20000, 0x5 },
+			.odr_avl[6] = { 40000, 0x6 },
+			.odr_avl[7] = { 80000, 0x7 },
+			.odr_len = 8,
+		},
+		.fs_table = {
+			.reg = {
+				.addr = 0x21,
+				.mask = GENMASK(6, 5),
+			},
+			.fs_avl[0] = {
+				.gain = 146,
+				.val = 0x00,
+			}, /* 4000 uG/LSB */
+			.fs_avl[1] = {
+				.gain = 292,
+				.val = 0x01,
+			}, /* 8000 uG/LSB */
+			.fs_avl[2] = {
+				.gain = 438,
+				.val = 0x02,
+			}, /* 12000 uG/LSB */
+			.fs_avl[3] = {
+				.gain = 584,
+				.val = 0x03,
+			}, /* 16000 uG/LSB */
+			.fs_len = 4,
+		},
+		.pwr_table = {
+			.reg = {
+				.addr = 0x22,
+				.mask = GENMASK(1, 0),
+			},
+			.off_val = 0x2,
+			.on_val = 0x0,
+		},
+		.bdu = {
+			.addr = 0x24,
+			.mask = BIT(6),
+		},
+		.out = {
+			.addr = 0x28,
+			.len = 6,
+		},
+	},
 };
 
 static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
-- 
2.26.0


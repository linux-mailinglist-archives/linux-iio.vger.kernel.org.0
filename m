Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4243F6D4D
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 04:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhHYCIl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 22:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhHYCIk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 22:08:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD02BC061757
        for <linux-iio@vger.kernel.org>; Tue, 24 Aug 2021 19:07:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id x11so48417367ejv.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Aug 2021 19:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mALU2OxiIEpDeQPoyzzGecoM8LDDe/irgGpVpeQGSjA=;
        b=OIax5qFi/IiMERcd/Jpo2h1N9p5ntKuapy4yhSVBcM1NGfMYJFhKac+fSpyn+k321n
         LUb1RH+GpbeIq/ZzCnpFDgLhgGu1VYUXWIqS1JvUgY2vI9Xk2nbBGRfkzWb2C490GVIc
         Uw225CYx/MQc2YC9YebMpZd7c4Yo/S2TD449o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mALU2OxiIEpDeQPoyzzGecoM8LDDe/irgGpVpeQGSjA=;
        b=hiyjl3oQS3Strjexj3/PShe2agwDSgd6VZuYlgUKrfAvEMmBN/0xClW5KpJCVGtoBm
         tY/yMli2WzBFyCgfxwoxjxnMAsOgDG7/hUZkKQ+tR7uVfpA/joZgOnAGzuZQClr954Mq
         4JBI/rpvwsDamzysSCCztkVJUoBA+W9fMuWNENMbFMt/VSCLqwstqDzjlfB9zURdoJE3
         oSI2g2FylpNwlxPK4dXSchNZ1peNMPd0Bpg3hOppSgLVw3TsDey7sKilsPhTcMCTxjPF
         eit58fHQ0798bjLA1zaKV7xmmplQ2lRlnnHYdcFjuUB/9e4DMhkHolArkVv0SHfIPl4K
         0qww==
X-Gm-Message-State: AOAM531iuWGz0W5Xjp1A/B4g9JHLhDQ3UxkcUSzihtZsVD2AbJVZ4JGx
        0j9JVl5KCQXNccqMMu7eTsTYmg==
X-Google-Smtp-Source: ABdhPJyOqJuZwxrIprkfcVEgJwgd5N9QqJj5Or6ftV8IKcDjXfwXyOgSZIkcig4UQRZYlPAk2B7XAQ==
X-Received: by 2002:a17:906:bcdb:: with SMTP id lw27mr44563471ejb.292.1629857274400;
        Tue, 24 Aug 2021 19:07:54 -0700 (PDT)
Received: from taos.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id ly7sm6793240ejb.109.2021.08.24.19.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 19:07:53 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: magnetometer: ak8975: add AK09116 support
Date:   Wed, 25 Aug 2021 05:07:38 +0300
Message-Id: <20210825020738.35877-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add additional AK09116 to the magnetometer driver which has the same
register mapping and scaling as the AK09112 device.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 .../iio/magnetometer/asahi-kasei,ak8975.yaml  |  2 ++
 drivers/iio/magnetometer/Kconfig              |  2 +-
 drivers/iio/magnetometer/ak8975.c             | 35 +++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
index a0a1ffe017df..c552b2b7751a 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
@@ -17,11 +17,13 @@ properties:
           - asahi-kasei,ak8963
           - asahi-kasei,ak09911
           - asahi-kasei,ak09912
+          - asahi-kasei,ak09916
       - enum:
           - ak8975
           - ak8963
           - ak09911
           - ak09912
+          - ak09916
         deprecated: true
 
   reg:
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 74ad5701c6c2..565ee41ccb3a 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -28,7 +28,7 @@ config AK8975
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Asahi Kasei AK8975, AK8963,
-	  AK09911 or AK09912 3-Axis Magnetometer.
+	  AK09911, AK09912 or AK09916 3-Axis Magnetometer.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called ak8975.
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 42b8a2680e3a..6e82dc54a417 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -78,6 +78,7 @@
  */
 #define AK09912_REG_WIA1		0x00
 #define AK09912_REG_WIA2		0x01
+#define AK09916_DEVICE_ID		0x09
 #define AK09912_DEVICE_ID		0x04
 #define AK09911_DEVICE_ID		0x05
 
@@ -208,6 +209,7 @@ enum asahi_compass_chipset {
 	AK8963,
 	AK09911,
 	AK09912,
+	AK09916,
 };
 
 enum ak_ctrl_reg_addr {
@@ -345,6 +347,31 @@ static const struct ak_def ak_def_array[] = {
 			AK09912_REG_HXL,
 			AK09912_REG_HYL,
 			AK09912_REG_HZL},
+	},
+	{
+		.type = AK09916,
+		.raw_to_gauss = ak09912_raw_to_gauss,
+		.range = 32752,
+		.ctrl_regs = {
+			AK09912_REG_ST1,
+			AK09912_REG_ST2,
+			AK09912_REG_CNTL2,
+			AK09912_REG_ASAX,
+			AK09912_MAX_REGS},
+		.ctrl_masks = {
+			AK09912_REG_ST1_DRDY_MASK,
+			AK09912_REG_ST2_HOFL_MASK,
+			0,
+			AK09912_REG_CNTL2_MODE_MASK},
+		.ctrl_modes = {
+			AK09912_REG_CNTL_MODE_POWER_DOWN,
+			AK09912_REG_CNTL_MODE_ONCE,
+			AK09912_REG_CNTL_MODE_SELF_TEST,
+			AK09912_REG_CNTL_MODE_FUSE_ROM},
+		.data_regs = {
+			AK09912_REG_HXL,
+			AK09912_REG_HYL,
+			AK09912_REG_HZL},
 	}
 };
 
@@ -425,6 +452,7 @@ static int ak8975_who_i_am(struct i2c_client *client,
 	/*
 	 * Signature for each device:
 	 * Device   |  WIA1      |  WIA2
+	 * AK09916  |  DEVICE_ID_|  AK09916_DEVICE_ID
 	 * AK09912  |  DEVICE_ID |  AK09912_DEVICE_ID
 	 * AK09911  |  DEVICE_ID |  AK09911_DEVICE_ID
 	 * AK8975   |  DEVICE_ID |  NA
@@ -452,6 +480,10 @@ static int ak8975_who_i_am(struct i2c_client *client,
 		if (wia_val[1] == AK09912_DEVICE_ID)
 			return 0;
 		break;
+	case AK09916:
+		if (wia_val[1] == AK09916_DEVICE_ID)
+			return 0;
+		break;
 	default:
 		dev_err(&client->dev, "Type %d unknown\n", type);
 	}
@@ -1057,6 +1089,7 @@ static const struct i2c_device_id ak8975_id[] = {
 	{"AK8963", AK8963},
 	{"ak09911", AK09911},
 	{"ak09912", AK09912},
+	{"ak09916", AK09916},
 	{}
 };
 
@@ -1071,6 +1104,8 @@ static const struct of_device_id ak8975_of_match[] = {
 	{ .compatible = "ak09911", },
 	{ .compatible = "asahi-kasei,ak09912", },
 	{ .compatible = "ak09912", },
+	{ .compatible = "asahi-kasei,ak09916", },
+	{ .compatible = "ak09916", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ak8975_of_match);
-- 
2.20.1


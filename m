Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6DF3BA7DC
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 10:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhGCIpT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 04:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhGCIpS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jul 2021 04:45:18 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12185C061762;
        Sat,  3 Jul 2021 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PFCM19IYyhz7jH3VrV8Q9fkUeAhfoXHRT3367WSPUVc=; b=D6+pjJDGxiqOuFTDwu62WS7x7O
        XacLijYjvp+DBB9APz5mEGC8TO3rYv/Oki/zn9/+MAeOpapdWONIp15/3ip8rGHfVP6yiMNcGL+Cg
        hTNgT7ABQtIIRI8sHuppY9lWRHgFJlYGeIqVrA8VB6uAwzy7JnkxYq3G8iCS+qk2YwAs=;
Received: from p200300ccff37da001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:da00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lzbEX-0006OU-DJ; Sat, 03 Jul 2021 10:42:41 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1lzbEX-0008Hu-2W; Sat, 03 Jul 2021 10:42:41 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        lars@metafoo.de, sre@kernel.org, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        leonard.crestez@nxp.com, letux-kernel@openphoenux.org
Subject: [PATCH 4/4] power: supply: rn5t618: Add voltage_now property
Date:   Sat,  3 Jul 2021 10:42:24 +0200
Message-Id: <20210703084224.31623-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210703084224.31623-1-andreas@kemnade.info>
References: <20210703084224.31623-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Read voltage_now via IIO and provide the property.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/power/supply/rn5t618_power.c | 56 ++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
index 819061918b2a..b062208c8a91 100644
--- a/drivers/power/supply/rn5t618_power.c
+++ b/drivers/power/supply/rn5t618_power.c
@@ -9,10 +9,12 @@
 #include <linux/device.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
+#include <linux/iio/consumer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mfd/rn5t618.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
@@ -64,6 +66,8 @@ struct rn5t618_power_info {
 	struct power_supply *battery;
 	struct power_supply *usb;
 	struct power_supply *adp;
+	struct iio_channel *channel_vusb;
+	struct iio_channel *channel_vadp;
 	int irq;
 };
 
@@ -77,6 +81,7 @@ static enum power_supply_usb_type rn5t618_usb_types[] = {
 static enum power_supply_property rn5t618_usb_props[] = {
 	/* input current limit is not very accurate */
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_USB_TYPE,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -85,6 +90,7 @@ static enum power_supply_property rn5t618_usb_props[] = {
 static enum power_supply_property rn5t618_adp_props[] = {
 	/* input current limit is not very accurate */
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 };
@@ -464,6 +470,16 @@ static int rn5t618_adp_get_property(struct power_supply *psy,
 
 		val->intval = FROM_CUR_REG(regval);
 		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if (!info->channel_vadp)
+			return -ENODATA;
+
+		ret = iio_read_channel_processed(info->channel_vadp, &val->intval);
+		if (ret < 0)
+			return ret;
+
+		val->intval *= 1000;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -589,6 +605,16 @@ static int rn5t618_usb_get_property(struct power_supply *psy,
 			val->intval = FROM_CUR_REG(regval);
 		}
 		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if (!info->channel_vusb)
+			return -ENODATA;
+
+		ret = iio_read_channel_processed(info->channel_vusb, &val->intval);
+		if (ret < 0)
+			return ret;
+
+		val->intval *= 1000;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -711,6 +737,28 @@ static int rn5t618_power_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, info);
 
+	info->channel_vusb = devm_iio_channel_get(&pdev->dev, "vusb");
+	if (IS_ERR(info->channel_vusb)) {
+		ret = PTR_ERR(info->channel_vusb);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		dev_warn(&pdev->dev, "could not request vusb iio channel (%d)",
+			 ret);
+		info->channel_vusb = NULL;
+	}
+
+	info->channel_vadp = devm_iio_channel_get(&pdev->dev, "vadp");
+	if (IS_ERR(info->channel_vadp)) {
+		ret = PTR_ERR(info->channel_vadp);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		dev_warn(&pdev->dev, "could not request vadp iio channel (%d)",
+			 ret);
+		info->channel_vadp = NULL;
+	}
+
 	ret = regmap_read(info->rn5t618->regmap, RN5T618_CONTROL, &v);
 	if (ret)
 		return ret;
@@ -778,9 +826,17 @@ static int rn5t618_power_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id rn5t618_power_of_match[] = {
+	{.compatible = "ricoh,rc5t619-power", },
+	{.compatible = "ricoh,rn5t618-power", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rn5t618_power_of_match);
+
 static struct platform_driver rn5t618_power_driver = {
 	.driver = {
 		.name   = "rn5t618-power",
+		.of_match_table = of_match_ptr(rn5t618_power_of_match),
 	},
 	.probe = rn5t618_power_probe,
 };
-- 
2.30.2


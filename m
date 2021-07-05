Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060513BBC44
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 13:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhGELjg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 07:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhGELjf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 07:39:35 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AB3C061574;
        Mon,  5 Jul 2021 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hBQwvrRZMyyx+hqSIGn7N5kouJhnwb/IRRG3Wnr0q7U=; b=d7gjOkIrTI1LRRGHNSJuK7RFq+
        f77lSBRyfJ6FqYttw7uDgx0ZlQWxj+lD/Gw7VqFUfaN+6kQICUkcODzTXlgTWDdtmlwU54PqFXupF
        0ibqeVoSkdep5Sgq2hRCTg8iJK2VTk2m4QbTZ4rOaoraOa5nA7Z2mJR7vn9aIGUewpKs=;
Received: from p200300ccff0e44001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0e:4400:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1m0MuE-0007D4-S9; Mon, 05 Jul 2021 13:36:55 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1m0MuE-0007XT-KK; Mon, 05 Jul 2021 13:36:54 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, lars@metafoo.de, sre@kernel.org,
        andreas@kemnade.info, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] power: supply: rn5t618: Add voltage_now property
Date:   Mon,  5 Jul 2021 13:36:37 +0200
Message-Id: <20210705113637.28908-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210705113637.28908-1-andreas@kemnade.info>
References: <20210705113637.28908-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Read voltage_now via IIO and provide the property.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes in v2:
- different error handling needed for iio_map usage
- fix dependencies in Kconfig

 drivers/power/supply/Kconfig         |  2 ++
 drivers/power/supply/rn5t618_power.c | 40 ++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e696364126f1..b2910d950929 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -790,6 +790,8 @@ config CHARGER_WILCO
 config RN5T618_POWER
 	tristate "RN5T618 charger/fuel gauge support"
 	depends on MFD_RN5T618
+	depends on RN5T618_ADC
+	depends on IIO
 	help
 	  Say Y here to have support for RN5T618 PMIC family fuel gauge and charger.
 	  This driver can also be built as a module. If so, the module will be
diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
index 819061918b2a..bca3fd86c14d 100644
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
@@ -711,6 +737,20 @@ static int rn5t618_power_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, info);
 
+	info->channel_vusb = devm_iio_channel_get(&pdev->dev, "vusb");
+	if (IS_ERR(info->channel_vusb)) {
+		if (PTR_ERR(info->channel_vusb) == -ENODEV)
+			return -EPROBE_DEFER;
+		return PTR_ERR(info->channel_vusb);
+	}
+
+	info->channel_vadp = devm_iio_channel_get(&pdev->dev, "vadp");
+	if (IS_ERR(info->channel_vadp)) {
+		if (PTR_ERR(info->channel_vadp) == -ENODEV)
+			return -EPROBE_DEFER;
+		return PTR_ERR(info->channel_vadp);
+	}
+
 	ret = regmap_read(info->rn5t618->regmap, RN5T618_CONTROL, &v);
 	if (ret)
 		return ret;
-- 
2.30.2


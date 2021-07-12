Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2C93C6560
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 23:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhGLVYN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 17:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbhGLVYM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 17:24:12 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F91C0613DD;
        Mon, 12 Jul 2021 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vzy3G2NfXwfFM+4q0UQkOtt0D4fxOjCAO0mtaT7X01Q=; b=bcPbc5v8EFeDBXKUb5Q1u4t0WZ
        1ZQwWvw3vgC+HUeypD14cLirr5AHsgcQJhlq5xOxJGUaWpFW/Cc3rCJXwdS2U6MOLWnlVHQlF3vvT
        EVWS8vdOT9K1XEe7MzH/DuSx/h/7VR5Emc5e0u8oVIwiQY3WOBGToW/1txXNhvloXojs=;
Received: from p200300ccff0a76001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0a:7600:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1m33Me-0001di-0r; Mon, 12 Jul 2021 23:21:20 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1m33Md-0004vy-Nr; Mon, 12 Jul 2021 23:21:19 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, lars@metafoo.de, sre@kernel.org,
        andreas@kemnade.info, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org
Cc:     kernel test robot <lkp@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 2/2] power: supply: rn5t618: Add voltage_now property
Date:   Mon, 12 Jul 2021 23:21:11 +0200
Message-Id: <20210712212111.18896-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210712212111.18896-1-andreas@kemnade.info>
References: <20210712212111.18896-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Read voltage_now via IIO and provide the property.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reported-by: kernel test robot <lkp@intel.com> # missing depends on IIO
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes in v3:
- use scaled reading function

Changes in v2:
- different error handling needed for iio_map usage
- fix dependencies in Kconfig

 drivers/power/supply/Kconfig         |  2 ++
 drivers/power/supply/rn5t618_power.c | 38 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

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
index 819061918b2a..a5e09ac78a50 100644
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
@@ -463,6 +469,15 @@ static int rn5t618_adp_get_property(struct power_supply *psy,
 			return ret;
 
 		val->intval = FROM_CUR_REG(regval);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if (!info->channel_vadp)
+			return -ENODATA;
+
+		ret = iio_read_channel_processed_scale(info->channel_vadp, &val->intval, 1000);
+		if (ret < 0)
+			return ret;
+
 		break;
 	default:
 		return -EINVAL;
@@ -588,6 +603,15 @@ static int rn5t618_usb_get_property(struct power_supply *psy,
 
 			val->intval = FROM_CUR_REG(regval);
 		}
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if (!info->channel_vusb)
+			return -ENODATA;
+
+		ret = iio_read_channel_processed_scale(info->channel_vusb, &val->intval, 1000);
+		if (ret < 0)
+			return ret;
+
 		break;
 	default:
 		return -EINVAL;
@@ -711,6 +735,20 @@ static int rn5t618_power_probe(struct platform_device *pdev)
 
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


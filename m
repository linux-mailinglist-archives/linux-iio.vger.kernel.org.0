Return-Path: <linux-iio+bounces-19791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 284DEAC0A7A
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 13:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8233BBAB7
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 11:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3347B288C0C;
	Thu, 22 May 2025 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZmFlUIc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59AA221FD0;
	Thu, 22 May 2025 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912738; cv=none; b=l4JuTB9MeXXrRtT84alyYAsfo3Gxg2U7E2aGjnX0oRYaXPEY+8VzfFntByAsQ53iBmplt/MqvCRNR6HTY2pBeVznId3Dxsx/0AGN3N0aHo1I4k1EXsOwWMoGhHik63xl40zV8XPp8pBT9y+SGga3TmDl8iSHznkQfwKIQBPt8vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912738; c=relaxed/simple;
	bh=KBLID+jtNRLgFwvcTMsh7IYTvwowb0BSNTX0NPN0se4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UuQubBPn43SNyf58ZEhkO72ZVsfKAC0yAl8dZDb4ai0qpiID2AmQHBErkfzwUgCgBSSHmjmb5AEw/P+Y9D4DwjUIJHSgWqEb8rc7WoXNbz+z7oCitrPsp8Ux7Z2Tqukv6vGz5EcepLIlbP7RRaGjeX/dMg/B2eMjXfukzQD2OV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZmFlUIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55286C4CEEF;
	Thu, 22 May 2025 11:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747912737;
	bh=KBLID+jtNRLgFwvcTMsh7IYTvwowb0BSNTX0NPN0se4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=NZmFlUIcetKOngKSccrTrzVyFvJaW2nzjMpzhSqs39zykds5wAUn+ThQNtsC0QE46
	 uQV5bMQxF9lt6lCyVSBjxAnqKksoqobSqRymbr+YsHvgiVB86oV72/lXN9vJxC5Fr/
	 ct3JkquEqyCnwWo67/RnZrAKZ2I8Tzu5O1PUb9aXKKq2gvYnjIou/9NfvwcAQPvPlN
	 TTSAaVLjSCyU4HIR5m24pa7GabOjCusi8bipOAc1CO3XCiB+23FQhQ05csgV63tf0A
	 cyhAgIpL2Sj4b+JUtyjXMKkwazAomdKAUm0BOlPRdeoUmZOUdmp/ZxBCESo42GL1DA
	 WxEr9YX620uqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42701C54E90;
	Thu, 22 May 2025 11:18:57 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 22 May 2025 13:18:55 +0200
Subject: [PATCH v2] iio: common: st_sensors: Fix use of uninitialize device
 structs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-st_iio_fix-v2-1-07a32655a996@gocontroll.com>
X-B4-Tracking: v=1; b=H4sIAB4IL2gC/22MywrCMBAAf6Xs2UiyNqV68j+kFM2jXahZSUJQS
 v/d2LPHGZhZIblILsGlWSG6Qok4VMBDA2a+h8kJspUBJWqpEUXKIxGPnt5CGd17a1vbooQavKK
 rep/dhsozpczxs7+L+tm/m6KEErbrz4+T9qpTeJ3YcMiRl+Vo+AnDtm1fcJxpz6kAAAA=
X-Change-ID: 20250522-st_iio_fix-1c58fdd4d420
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Christian Heusel <christian@heusel.eu>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747912736; l=10903;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=APnMHoj+TfkHT0STPSKBZxD7+b2G+KxvTYujirrX1D0=;
 b=66+hio8ym81pr1ZrXMT7/QSZWK+a+fHt4270M/hM2K7dhFAFxO7zXBany3dx9tWhYPx3WMjaU
 yUdY4EtMrlzAXOOFsQ+PGT83VAGFh8vUf/VfuvSLXyoyO13ihr0mfS2
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Throughout the various probe functions &indio_dev->dev is used before it
is initialized. This caused a kernel panic in st_sensors_power_enable
when the call to devm_regulator_bulk_get_enable() fails and then calls
dev_err_probe() with the uninitialized device.

This seems to only cause a panic with dev_err_probe(), dev_err,
dev_warn and dev_info don't seem to cause a panic, but are fixed
as well.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
When I search for general &indio_dev->dev usage, I see quite a lot more
hits, but I am not sure if there are issues with those too.

This issue has existed for a long time it seems and therefore it is
nearly impossible to find a proper fixes tag. I would love to see it at
least backported to 6.12 as that is where I encountered it, and I
believe the patch should apply without conflicts.

The investigation into this issue can be found in this thread [1]

[1]: https://lore.kernel.org/all/AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM/
---
Changes in v2:
- Added SoB in commit message
- Link to v1: https://lore.kernel.org/r/20250522-st_iio_fix-v1-1-d689b35f1612@gocontroll.com
---
 drivers/iio/accel/st_accel_core.c                  | 10 +++----
 drivers/iio/common/st_sensors/st_sensors_core.c    | 35 +++++++++++-----------
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 18 +++++------
 3 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 99cb661fabb2d9cc1943fa8d0a6f3becb71126e6..a7961c610ed203d039bbf298c8883031a578fb0b 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1353,6 +1353,7 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
 	union acpi_object *ont;
 	union acpi_object *elements;
 	acpi_status status;
+	struct device *parent = indio_dev->dev.parent;
 	int ret = -EINVAL;
 	unsigned int val;
 	int i, j;
@@ -1371,7 +1372,7 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
 	};
 
 
-	adev = ACPI_COMPANION(indio_dev->dev.parent);
+	adev = ACPI_COMPANION(parent);
 	if (!adev)
 		return -ENXIO;
 
@@ -1380,8 +1381,7 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
 	if (status == AE_NOT_FOUND) {
 		return -ENXIO;
 	} else if (ACPI_FAILURE(status)) {
-		dev_warn(&indio_dev->dev, "failed to execute _ONT: %d\n",
-			 status);
+		dev_warn(parent, "failed to execute _ONT: %d\n", status);
 		return status;
 	}
 
@@ -1457,12 +1457,12 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
 	}
 
 	ret = 0;
-	dev_info(&indio_dev->dev, "computed mount matrix from ACPI\n");
+	dev_info(parent, "computed mount matrix from ACPI\n");
 
 out:
 	kfree(buffer.pointer);
 	if (ret)
-		dev_dbg(&indio_dev->dev,
+		dev_dbg(parent,
 			"failed to apply ACPI orientation data: %d\n", ret);
 
 	return ret;
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 8ce1dccfea4f5aaff45d3d40f6542323dd1f0b09..11cbf561b16d41f429745abb516c137cfbb302bb 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -154,7 +154,7 @@ static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
 	return err;
 
 st_accel_set_fullscale_error:
-	dev_err(&indio_dev->dev, "failed to set new fullscale.\n");
+	dev_err(indio_dev->dev.parent, "failed to set new fullscale.\n");
 	return err;
 }
 
@@ -231,7 +231,7 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 					     ARRAY_SIZE(regulator_names),
 					     regulator_names);
 	if (err)
-		return dev_err_probe(&indio_dev->dev, err,
+		return dev_err_probe(parent, err,
 				     "unable to enable supplies\n");
 
 	return 0;
@@ -241,13 +241,14 @@ EXPORT_SYMBOL_NS(st_sensors_power_enable, "IIO_ST_SENSORS");
 static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
 {
+	struct device *parent = indio_dev->dev.parent;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
 	/* Sensor does not support interrupts */
 	if (!sdata->sensor_settings->drdy_irq.int1.addr &&
 	    !sdata->sensor_settings->drdy_irq.int2.addr) {
 		if (pdata->drdy_int_pin)
-			dev_info(&indio_dev->dev,
+			dev_info(parent,
 				 "DRDY on pin INT%d specified, but sensor does not support interrupts\n",
 				 pdata->drdy_int_pin);
 		return 0;
@@ -256,29 +257,27 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 	switch (pdata->drdy_int_pin) {
 	case 1:
 		if (!sdata->sensor_settings->drdy_irq.int1.mask) {
-			dev_err(&indio_dev->dev,
-					"DRDY on INT1 not available.\n");
+			dev_err(parent, "DRDY on INT1 not available.\n");
 			return -EINVAL;
 		}
 		sdata->drdy_int_pin = 1;
 		break;
 	case 2:
 		if (!sdata->sensor_settings->drdy_irq.int2.mask) {
-			dev_err(&indio_dev->dev,
-					"DRDY on INT2 not available.\n");
+			dev_err(parent, "DRDY on INT2 not available.\n");
 			return -EINVAL;
 		}
 		sdata->drdy_int_pin = 2;
 		break;
 	default:
-		dev_err(&indio_dev->dev, "DRDY on pdata not valid.\n");
+		dev_err(parent, "DRDY on pdata not valid.\n");
 		return -EINVAL;
 	}
 
 	if (pdata->open_drain) {
 		if (!sdata->sensor_settings->drdy_irq.int1.addr_od &&
 		    !sdata->sensor_settings->drdy_irq.int2.addr_od)
-			dev_err(&indio_dev->dev,
+			dev_err(parent,
 				"open drain requested but unsupported.\n");
 		else
 			sdata->int_pin_open_drain = true;
@@ -336,6 +335,7 @@ EXPORT_SYMBOL_NS(st_sensors_dev_name_probe, "IIO_ST_SENSORS");
 int st_sensors_init_sensor(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
 {
+	struct device *parent = indio_dev->dev.parent;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 	struct st_sensors_platform_data *of_pdata;
 	int err = 0;
@@ -343,7 +343,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 	mutex_init(&sdata->odr_lock);
 
 	/* If OF/DT pdata exists, it will take precedence of anything else */
-	of_pdata = st_sensors_dev_probe(indio_dev->dev.parent, pdata);
+	of_pdata = st_sensors_dev_probe(parent, pdata);
 	if (IS_ERR(of_pdata))
 		return PTR_ERR(of_pdata);
 	if (of_pdata)
@@ -370,7 +370,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 		if (err < 0)
 			return err;
 	} else
-		dev_info(&indio_dev->dev, "Full-scale not possible\n");
+		dev_info(parent, "Full-scale not possible\n");
 
 	err = st_sensors_set_odr(indio_dev, sdata->odr);
 	if (err < 0)
@@ -405,7 +405,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 			mask = sdata->sensor_settings->drdy_irq.int2.mask_od;
 		}
 
-		dev_info(&indio_dev->dev,
+		dev_info(parent,
 			 "set interrupt line to open drain mode on pin %d\n",
 			 sdata->drdy_int_pin);
 		err = st_sensors_write_data_with_mask(indio_dev, addr,
@@ -593,21 +593,20 @@ EXPORT_SYMBOL_NS(st_sensors_get_settings_index, "IIO_ST_SENSORS");
 int st_sensors_verify_id(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	struct device *parent = indio_dev->dev.parent;
 	int wai, err;
 
 	if (sdata->sensor_settings->wai_addr) {
 		err = regmap_read(sdata->regmap,
 				  sdata->sensor_settings->wai_addr, &wai);
 		if (err < 0) {
-			dev_err(&indio_dev->dev,
-				"failed to read Who-Am-I register.\n");
-			return err;
+			return dev_err_probe(parent, err,
+					     "failed to read Who-Am-I register.\n");
 		}
 
 		if (sdata->sensor_settings->wai != wai) {
-			dev_warn(&indio_dev->dev,
-				"%s: WhoAmI mismatch (0x%x).\n",
-				indio_dev->name, wai);
+			dev_warn(parent, "%s: WhoAmI mismatch (0x%x).\n",
+				 indio_dev->name, wai);
 		}
 	}
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 9d4bf822a15dfcdd6c2835f6b9d7698cd3cb0b08..32c3278968089699dff5329e943d92b151b55fdf 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -127,7 +127,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	sdata->trig = devm_iio_trigger_alloc(parent, "%s-trigger",
 					     indio_dev->name);
 	if (sdata->trig == NULL) {
-		dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
+		dev_err(parent, "failed to allocate iio trigger.\n");
 		return -ENOMEM;
 	}
 
@@ -143,7 +143,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	case IRQF_TRIGGER_FALLING:
 	case IRQF_TRIGGER_LOW:
 		if (!sdata->sensor_settings->drdy_irq.addr_ihl) {
-			dev_err(&indio_dev->dev,
+			dev_err(parent,
 				"falling/low specified for IRQ but hardware supports only rising/high: will request rising/high\n");
 			if (irq_trig == IRQF_TRIGGER_FALLING)
 				irq_trig = IRQF_TRIGGER_RISING;
@@ -156,21 +156,21 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 				sdata->sensor_settings->drdy_irq.mask_ihl, 1);
 			if (err < 0)
 				return err;
-			dev_info(&indio_dev->dev,
+			dev_info(parent,
 				 "interrupts on the falling edge or active low level\n");
 		}
 		break;
 	case IRQF_TRIGGER_RISING:
-		dev_info(&indio_dev->dev,
+		dev_info(parent,
 			 "interrupts on the rising edge\n");
 		break;
 	case IRQF_TRIGGER_HIGH:
-		dev_info(&indio_dev->dev,
+		dev_info(parent,
 			 "interrupts active high level\n");
 		break;
 	default:
 		/* This is the most preferred mode, if possible */
-		dev_err(&indio_dev->dev,
+		dev_err(parent,
 			"unsupported IRQ trigger specified (%lx), enforce rising edge\n", irq_trig);
 		irq_trig = IRQF_TRIGGER_RISING;
 	}
@@ -179,7 +179,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	if (irq_trig == IRQF_TRIGGER_FALLING ||
 	    irq_trig == IRQF_TRIGGER_RISING) {
 		if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr) {
-			dev_err(&indio_dev->dev,
+			dev_err(parent,
 				"edge IRQ not supported w/o stat register.\n");
 			return -EOPNOTSUPP;
 		}
@@ -214,13 +214,13 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 					sdata->trig->name,
 					sdata->trig);
 	if (err) {
-		dev_err(&indio_dev->dev, "failed to request trigger IRQ.\n");
+		dev_err(parent, "failed to request trigger IRQ.\n");
 		return err;
 	}
 
 	err = devm_iio_trigger_register(parent, sdata->trig);
 	if (err < 0) {
-		dev_err(&indio_dev->dev, "failed to register iio trigger.\n");
+		dev_err(parent, "failed to register iio trigger.\n");
 		return err;
 	}
 	indio_dev->trig = iio_trigger_get(sdata->trig);

---
base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718
change-id: 20250522-st_iio_fix-1c58fdd4d420

Best regards,
-- 
Maud Spierings <maudspierings@gocontroll.com>




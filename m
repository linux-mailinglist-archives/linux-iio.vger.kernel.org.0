Return-Path: <linux-iio+bounces-19960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EB5AC487B
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 08:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4540C179296
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 06:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ED61F463C;
	Tue, 27 May 2025 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAZpVFbR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99711D54FA;
	Tue, 27 May 2025 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748327772; cv=none; b=AP8zR0V/pZkw4+QVIZ0PJ9XywQ9FSgZbr2JL4Cclp4/D747fgOMLAMCyskG7Bn+9ALaGmi9wmqwSvFOglrQsy/q3NmRsJqG/B2xcR2VE2glxgDRz7NDhYO1GnvQqZdKAsFFsVL8+M1BnXMePmXY34fhPqqfnjsuSELfpXdOkD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748327772; c=relaxed/simple;
	bh=JosPeijci2jqEwxdfJiz6esq7LuAs4cgnbeh+/f7jq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LZ6jCAZ6VamSTYZFKYsLP+Aq7ZWyMRm5Wb0nw19JVXLcaLrcLjDoJJRmfbIju3+8e9yn+aMG3D1dnidFJThS+SIs75DNw3DbTyE4fRFp+fOHQH3uzjppLRcOD8gYvBm6rOcmCpboYQLzz+pF+jki3epTd2Wy6c0FQOeiMSX1fFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAZpVFbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 464D6C4CEED;
	Tue, 27 May 2025 06:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748327772;
	bh=JosPeijci2jqEwxdfJiz6esq7LuAs4cgnbeh+/f7jq0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CAZpVFbRKBSSE79VbsTSUv4qUG1u9dIXSsKjZTkqCISc1LGezazHSsHJii27SOV17
	 lZJL7DgVOcQpt55NOvZ8u1CbIrXv8evPtnzm491vr5wYVnzQMZFpBJCq+6DQmIxNw/
	 xo3vm+mR4hPBumxuAYPrlcuC/TpnzGnlUX7YwlSWcuO/xC3xaylktAgplcosK2xRDY
	 QXmfPfOraBOSEx03/uciQmdZfU0BhbH2LEpgIwX99yDNSOouuYhKceRX9tbE7SJhZa
	 yE896gF1J08Qbo56JEHbePLeK6I7y8lvbBwaKglluG2GyFUwyhEburfaQHAlyvpNbW
	 +qRlZRLx60LkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B9DC54F30;
	Tue, 27 May 2025 06:36:12 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Tue, 27 May 2025 08:36:08 +0200
Subject: [PATCH v4] iio: common: st_sensors: Fix use of uninitialize device
 structs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-st_iio_fix-v4-1-12d89801c761@gocontroll.com>
X-B4-Tracking: v=1; b=H4sIAFddNWgC/3XM3w6CIByG4VtxHEeDH4LSUffRmjP+KJtJA8dqz
 nsPPaplh9+3Pe+MognORHQqZhRMctH5MY/yUCDVt2NnsNN5IyDACQfAcWqc8411T0wVr63WpS6
 BoAweweR7i12uefcuTj68tnai67ubSRRTrEUtb4xbKiicO6/8OAU/DEfl72htJfjvIXtStQwE5
 62UYtezTy++PFs9k9YoVlekUj9+WZY3JEC0DykBAAA=
X-Change-ID: 20250522-st_iio_fix-1c58fdd4d420
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Christian Heusel <christian@heusel.eu>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748327771; l=11537;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=bNsmb74JepkNVghDEhHIZVD0SC/9NiFSAnP3/gKCLvo=;
 b=Y/Unbeak0niKl54flhmZgOlt0g1eFmM/SEd1jWXVYgImFCwmEMbF4E5zWGrTiydWNP3S+NnfR
 sSq05vZ5WnyDNk1mU7QhstY5bJ63h3hhNIKfQFInaWXSzoHiRH5Ow44
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Throughout the various probe functions &indio_dev->dev is used before it
is initialized. This caused a kernel panic in st_sensors_power_enable()
when the call to devm_regulator_bulk_get_enable() fails and then calls
dev_err_probe() with the uninitialized device.

This seems to only cause a panic with dev_err_probe(), dev_err(),
dev_warn() and dev_info() don't seem to cause a panic, but are fixed
as well.

The issue is reported and traced here: [1]

Link: https://lore.kernel.org/all/AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM/ [1]
Cc: stable@vger.kernel.org
Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
When I search for general &indio_dev->dev usage, I see quite a lot more
hits, but I am not sure if there are issues with those too.

This issue has existed for a long time it seems and therefore it is
nearly impossible to find a proper fixes tag. I would love to see it at
least backported to 6.12 as that is where I encountered it, and I
believe the patch should apply without conflicts.
---
Changes in v4:
- Put the link to the original issue in a proper link tag
- Remove stray newline
- Link to v3: https://lore.kernel.org/r/20250526-st_iio_fix-v3-1-039fec38707c@gocontroll.com

Changes in v3:
- Added the stable cc to the commit message
- Move the link to the original issue to the commit message
- Fix function notation in the commit message
- Move some more of the dev_*() calls to one line
- Link to v2: https://lore.kernel.org/r/20250522-st_iio_fix-v2-1-07a32655a996@gocontroll.com

Changes in v2:
- Added SoB in commit message
- Link to v1: https://lore.kernel.org/r/20250522-st_iio_fix-v1-1-d689b35f1612@gocontroll.com
---
 drivers/iio/accel/st_accel_core.c                  | 10 +++---
 drivers/iio/common/st_sensors/st_sensors_core.c    | 36 ++++++++++------------
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 20 ++++++------
 3 files changed, 31 insertions(+), 35 deletions(-)

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
index 8ce1dccfea4f5aaff45d3d40f6542323dd1f0b09..dac593be56958fd0be92e13f628350fcfd0f040d 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -154,7 +154,7 @@ static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
 	return err;
 
 st_accel_set_fullscale_error:
-	dev_err(&indio_dev->dev, "failed to set new fullscale.\n");
+	dev_err(indio_dev->dev.parent, "failed to set new fullscale.\n");
 	return err;
 }
 
@@ -231,8 +231,7 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 					     ARRAY_SIZE(regulator_names),
 					     regulator_names);
 	if (err)
-		return dev_err_probe(&indio_dev->dev, err,
-				     "unable to enable supplies\n");
+		return dev_err_probe(parent, err, "unable to enable supplies\n");
 
 	return 0;
 }
@@ -241,13 +240,14 @@ EXPORT_SYMBOL_NS(st_sensors_power_enable, "IIO_ST_SENSORS");
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
@@ -256,29 +256,27 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
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
@@ -336,6 +334,7 @@ EXPORT_SYMBOL_NS(st_sensors_dev_name_probe, "IIO_ST_SENSORS");
 int st_sensors_init_sensor(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
 {
+	struct device *parent = indio_dev->dev.parent;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 	struct st_sensors_platform_data *of_pdata;
 	int err = 0;
@@ -343,7 +342,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 	mutex_init(&sdata->odr_lock);
 
 	/* If OF/DT pdata exists, it will take precedence of anything else */
-	of_pdata = st_sensors_dev_probe(indio_dev->dev.parent, pdata);
+	of_pdata = st_sensors_dev_probe(parent, pdata);
 	if (IS_ERR(of_pdata))
 		return PTR_ERR(of_pdata);
 	if (of_pdata)
@@ -370,7 +369,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 		if (err < 0)
 			return err;
 	} else
-		dev_info(&indio_dev->dev, "Full-scale not possible\n");
+		dev_info(parent, "Full-scale not possible\n");
 
 	err = st_sensors_set_odr(indio_dev, sdata->odr);
 	if (err < 0)
@@ -405,7 +404,7 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 			mask = sdata->sensor_settings->drdy_irq.int2.mask_od;
 		}
 
-		dev_info(&indio_dev->dev,
+		dev_info(parent,
 			 "set interrupt line to open drain mode on pin %d\n",
 			 sdata->drdy_int_pin);
 		err = st_sensors_write_data_with_mask(indio_dev, addr,
@@ -593,21 +592,20 @@ EXPORT_SYMBOL_NS(st_sensors_get_settings_index, "IIO_ST_SENSORS");
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
index 9d4bf822a15dfcdd6c2835f6b9d7698cd3cb0b08..8a8ab688d7980f6dd43c660f90a0eba32c38388b 100644
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
@@ -156,21 +156,19 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
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
-			 "interrupts on the rising edge\n");
+		dev_info(parent, "interrupts on the rising edge\n");
 		break;
 	case IRQF_TRIGGER_HIGH:
-		dev_info(&indio_dev->dev,
-			 "interrupts active high level\n");
+		dev_info(parent, "interrupts active high level\n");
 		break;
 	default:
 		/* This is the most preferred mode, if possible */
-		dev_err(&indio_dev->dev,
+		dev_err(parent,
 			"unsupported IRQ trigger specified (%lx), enforce rising edge\n", irq_trig);
 		irq_trig = IRQF_TRIGGER_RISING;
 	}
@@ -179,7 +177,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	if (irq_trig == IRQF_TRIGGER_FALLING ||
 	    irq_trig == IRQF_TRIGGER_RISING) {
 		if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr) {
-			dev_err(&indio_dev->dev,
+			dev_err(parent,
 				"edge IRQ not supported w/o stat register.\n");
 			return -EOPNOTSUPP;
 		}
@@ -214,13 +212,13 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
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




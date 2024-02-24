Return-Path: <linux-iio+bounces-2990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B0A8624F6
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 13:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C121C20EA8
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 12:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD831AAD7;
	Sat, 24 Feb 2024 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbzXauHZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D801392
	for <linux-iio@vger.kernel.org>; Sat, 24 Feb 2024 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708777960; cv=none; b=Gcy8osd0gAW86N5mjTMXFjG+HofVgRri+Sd1FN+F74KzE2XSBn32iCYtkFF3kyFvTQlS0DMFVDdHT12Xpou5Tq/L5AQS4xWz1EJxilZiYsZczwB/IH6/vXSCdvtghBmMQ+tktXEVmyj9lG+3ITojpctaMwppd7i8fOzUBYFAYu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708777960; c=relaxed/simple;
	bh=g7P8BFC7UVt5OhkHHbMVRot0JK3hmmyssZqx+vth2V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5AcnizEPve4ROu9GDjXDFQ/w436Azk7YSZPDyEubaqcKDfixUudDTd3HxeZoyoWpBJ+OrrO5C5KNcjydcxW3ioABEhVBY1JYNGMdU0sq7P0tZ7U24UsN4AZQSrchIMZ24ECiS2nxMk0TXQ1zPECoyw4pYNZfBUGXerUgcnnGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbzXauHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24995C433C7;
	Sat, 24 Feb 2024 12:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708777960;
	bh=g7P8BFC7UVt5OhkHHbMVRot0JK3hmmyssZqx+vth2V4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbzXauHZx6ZGYl1HF9RANfh5yWISMyZeqqCoMxxPaxzj1n6palsCrCYKUUilR3JYw
	 noQNG+lLhdHF3ogrVRgRMGZQixoFumh7n0b69ZLzLGY2TdKTmQFW6n1nKinlYhuXL8
	 9tybfQ0oHpKwgRGuHZ1RPe1Jud7FBQAeZmkc08z/hltD3bGJGSlQZj6s7UciAMYYWy
	 fczxzblzvRu543DDOVPIKYET0XtJ7NuQov16PFN9SN2xbsvWFCt5I0eOmP2QAN+Kwj
	 B+4t+YIWlVn/JEtKBid6bXCdULnbPnF096My2BkAdH4GHOvM6HeXITmXarigEShUj/
	 WoW2/yWuT/HKA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 1/9] iio: temp: ltc2983: Use __free(fwnode_handle) and device_for_each_node_scoped()
Date: Sat, 24 Feb 2024 12:32:07 +0000
Message-ID: <20240224123215.161469-2-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224123215.161469-1-jic23@kernel.org>
References: <20240224123215.161469-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This use of the new cleanup.h scope based freeing infrastructure allows
us to exit directly from error conditions and in the good path with
the reference obtained from fwnode_find_reference() (which may be an error
pointer) automatically released.

Similarly the _scoped() version of device_for_each_child_node()
removes the need for the manual calling of fwnode_handl_put() in
paths where the code exits the loop early.

Tidy up some unusual indentation in a dev_dbg() whilst here.

Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5: Add the device_for_each_child_node_scoped() change (Nuno)
---
 drivers/iio/temperature/ltc2983.c | 137 +++++++++++-------------------
 1 file changed, 50 insertions(+), 87 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index fcb96c44d954..7d5473e7b500 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -656,7 +656,6 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 			 const struct ltc2983_sensor *sensor)
 {
 	struct ltc2983_thermocouple *thermo;
-	struct fwnode_handle *ref;
 	u32 oc_current;
 	int ret;
 
@@ -703,7 +702,8 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 		return ERR_PTR(-EINVAL);
 	}
 
-	ref = fwnode_find_reference(child, "adi,cold-junction-handle", 0);
+	struct fwnode_handle *ref __free(fwnode_handle) =
+		fwnode_find_reference(child, "adi,cold-junction-handle", 0);
 	if (IS_ERR(ref)) {
 		ref = NULL;
 	} else {
@@ -714,7 +714,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 			 * the error right away.
 			 */
 			dev_err(&st->spi->dev, "Property reg must be given\n");
-			goto fail;
+			return ERR_PTR(ret);
 		}
 	}
 
@@ -725,22 +725,15 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 		thermo->custom = __ltc2983_custom_sensor_new(st, child,
 							     propname, false,
 							     16384, true);
-		if (IS_ERR(thermo->custom)) {
-			ret = PTR_ERR(thermo->custom);
-			goto fail;
-		}
+		if (IS_ERR(thermo->custom))
+			return ERR_CAST(thermo->custom);
 	}
 
 	/* set common parameters */
 	thermo->sensor.fault_handler = ltc2983_thermocouple_fault_handler;
 	thermo->sensor.assign_chan = ltc2983_thermocouple_assign_chan;
 
-	fwnode_handle_put(ref);
 	return &thermo->sensor;
-
-fail:
-	fwnode_handle_put(ref);
-	return ERR_PTR(ret);
 }
 
 static struct ltc2983_sensor *
@@ -750,14 +743,14 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	struct ltc2983_rtd *rtd;
 	int ret = 0;
 	struct device *dev = &st->spi->dev;
-	struct fwnode_handle *ref;
 	u32 excitation_current = 0, n_wires = 0;
 
 	rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
 	if (!rtd)
 		return ERR_PTR(-ENOMEM);
 
-	ref = fwnode_find_reference(child, "adi,rsense-handle", 0);
+	struct fwnode_handle *ref __free(fwnode_handle) =
+		fwnode_find_reference(child, "adi,rsense-handle", 0);
 	if (IS_ERR(ref)) {
 		dev_err(dev, "Property adi,rsense-handle missing or invalid");
 		return ERR_CAST(ref);
@@ -766,7 +759,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	ret = fwnode_property_read_u32(ref, "reg", &rtd->r_sense_chan);
 	if (ret) {
 		dev_err(dev, "Property reg must be given\n");
-		goto fail;
+		return ERR_PTR(ret);
 	}
 
 	ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
@@ -787,8 +780,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			break;
 		default:
 			dev_err(dev, "Invalid number of wires:%u\n", n_wires);
-			ret = -EINVAL;
-			goto fail;
+			return ERR_PTR(-EINVAL);
 		}
 	}
 
@@ -798,8 +790,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			if (n_wires == 2 || n_wires == 3) {
 				dev_err(dev,
 					"Rotation not allowed for 2/3 Wire RTDs");
-				ret = -EINVAL;
-				goto fail;
+				return ERR_PTR(-EINVAL);
 			}
 			rtd->sensor_config |= LTC2983_RTD_C_ROTATE(1);
 		} else {
@@ -829,16 +820,14 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 				"Invalid rsense chann:%d to use in kelvin rsense",
 				rtd->r_sense_chan);
 
-			ret = -EINVAL;
-			goto fail;
+			return ERR_PTR(-EINVAL);
 		}
 
 		if (sensor->chan < min || sensor->chan > max) {
 			dev_err(dev, "Invalid chann:%d for the rtd config",
 				sensor->chan);
 
-			ret = -EINVAL;
-			goto fail;
+			return ERR_PTR(-EINVAL);
 		}
 	} else {
 		/* same as differential case */
@@ -846,8 +835,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			dev_err(&st->spi->dev,
 				"Invalid chann:%d for RTD", sensor->chan);
 
-			ret = -EINVAL;
-			goto fail;
+			return ERR_PTR(-EINVAL);
 		}
 	}
 
@@ -856,10 +844,8 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 		rtd->custom = __ltc2983_custom_sensor_new(st, child,
 							  "adi,custom-rtd",
 							  false, 2048, false);
-		if (IS_ERR(rtd->custom)) {
-			ret = PTR_ERR(rtd->custom);
-			goto fail;
-		}
+		if (IS_ERR(rtd->custom))
+			return ERR_CAST(rtd->custom);
 	}
 
 	/* set common parameters */
@@ -901,18 +887,13 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			dev_err(&st->spi->dev,
 				"Invalid value for excitation current(%u)",
 				excitation_current);
-			ret = -EINVAL;
-			goto fail;
+			return ERR_PTR(-EINVAL);
 		}
 	}
 
 	fwnode_property_read_u32(child, "adi,rtd-curve", &rtd->rtd_curve);
 
-	fwnode_handle_put(ref);
 	return &rtd->sensor;
-fail:
-	fwnode_handle_put(ref);
-	return ERR_PTR(ret);
 }
 
 static struct ltc2983_sensor *
@@ -921,7 +902,6 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 {
 	struct ltc2983_thermistor *thermistor;
 	struct device *dev = &st->spi->dev;
-	struct fwnode_handle *ref;
 	u32 excitation_current = 0;
 	int ret = 0;
 
@@ -929,7 +909,8 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 	if (!thermistor)
 		return ERR_PTR(-ENOMEM);
 
-	ref = fwnode_find_reference(child, "adi,rsense-handle", 0);
+	struct fwnode_handle *ref __free(fwnode_handle) =
+		fwnode_find_reference(child, "adi,rsense-handle", 0);
 	if (IS_ERR(ref)) {
 		dev_err(dev, "Property adi,rsense-handle missing or invalid");
 		return ERR_CAST(ref);
@@ -938,7 +919,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 	ret = fwnode_property_read_u32(ref, "reg", &thermistor->r_sense_chan);
 	if (ret) {
 		dev_err(dev, "rsense channel must be configured...\n");
-		goto fail;
+		return ERR_PTR(ret);
 	}
 
 	if (fwnode_property_read_bool(child, "adi,single-ended")) {
@@ -958,8 +939,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 		dev_err(&st->spi->dev,
 			"Invalid chann:%d for differential thermistor",
 			sensor->chan);
-		ret = -EINVAL;
-		goto fail;
+		return ERR_PTR(-EINVAL);
 	}
 
 	/* check custom sensor */
@@ -978,10 +958,8 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 								 propname,
 								 steinhart,
 								 64, false);
-		if (IS_ERR(thermistor->custom)) {
-			ret = PTR_ERR(thermistor->custom);
-			goto fail;
-		}
+		if (IS_ERR(thermistor->custom))
+			return ERR_CAST(thermistor->custom);
 	}
 	/* set common parameters */
 	thermistor->sensor.fault_handler = ltc2983_common_fault_handler;
@@ -1005,8 +983,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 			    LTC2983_SENSOR_THERMISTOR_STEINHART) {
 				dev_err(&st->spi->dev,
 					"Auto Range not allowed for custom sensors\n");
-				ret = -EINVAL;
-				goto fail;
+				return ERR_PTR(-EINVAL);
 			}
 			thermistor->excitation_current = 0x0c;
 			break;
@@ -1047,16 +1024,11 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 			dev_err(&st->spi->dev,
 				"Invalid value for excitation current(%u)",
 				excitation_current);
-			ret = -EINVAL;
-			goto fail;
+			return ERR_PTR(-EINVAL);
 		}
 	}
 
-	fwnode_handle_put(ref);
 	return &thermistor->sensor;
-fail:
-	fwnode_handle_put(ref);
-	return ERR_PTR(ret);
 }
 
 static struct ltc2983_sensor *
@@ -1349,8 +1321,7 @@ static irqreturn_t ltc2983_irq_handler(int irq, void *data)
 static int ltc2983_parse_dt(struct ltc2983_data *st)
 {
 	struct device *dev = &st->spi->dev;
-	struct fwnode_handle *child;
-	int ret = 0, chan = 0, channel_avail_mask = 0;
+	int ret, chan = 0, channel_avail_mask = 0;
 
 	device_property_read_u32(dev, "adi,mux-delay-config-us", &st->mux_delay_config);
 
@@ -1368,38 +1339,35 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 		return -ENOMEM;
 
 	st->iio_channels = st->num_channels;
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		struct ltc2983_sensor sensor;
 
 		ret = fwnode_property_read_u32(child, "reg", &sensor.chan);
-		if (ret) {
-			dev_err(dev, "reg property must given for child nodes\n");
-			goto put_child;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+				"reg property must given for child nodes\n");
 
 		/* check if we have a valid channel */
 		if (sensor.chan < LTC2983_MIN_CHANNELS_NR ||
-		    sensor.chan > st->info->max_channels_nr) {
-			ret = -EINVAL;
-			dev_err(dev, "chan:%d must be from %u to %u\n", sensor.chan,
-				LTC2983_MIN_CHANNELS_NR, st->info->max_channels_nr);
-			goto put_child;
-		} else if (channel_avail_mask & BIT(sensor.chan)) {
-			ret = -EINVAL;
-			dev_err(dev, "chan:%d already in use\n", sensor.chan);
-			goto put_child;
-		}
+		    sensor.chan > st->info->max_channels_nr)
+			return dev_err_probe(dev, -EINVAL,
+					     "chan:%d must be from %u to %u\n",
+					     sensor.chan,
+					     LTC2983_MIN_CHANNELS_NR,
+					     st->info->max_channels_nr);
+
+		if (channel_avail_mask & BIT(sensor.chan))
+			return dev_err_probe(dev, -EINVAL,
+					     "chan:%d already in use\n",
+					     sensor.chan);
 
 		ret = fwnode_property_read_u32(child, "adi,sensor-type", &sensor.type);
-		if (ret) {
-			dev_err(dev,
+		if (ret)
+			return dev_err_probe(dev, ret,
 				"adi,sensor-type property must given for child nodes\n");
-			goto put_child;
-		}
 
 		dev_dbg(dev, "Create new sensor, type %u, chann %u",
-								sensor.type,
-								sensor.chan);
+			sensor.type, sensor.chan);
 
 		if (sensor.type >= LTC2983_SENSOR_THERMOCOUPLE &&
 		    sensor.type <= LTC2983_SENSOR_THERMOCOUPLE_CUSTOM) {
@@ -1426,17 +1394,15 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 			   sensor.type == LTC2983_SENSOR_ACTIVE_TEMP) {
 			st->sensors[chan] = ltc2983_temp_new(child, st, &sensor);
 		} else {
-			dev_err(dev, "Unknown sensor type %d\n", sensor.type);
-			ret = -EINVAL;
-			goto put_child;
+			return dev_err_probe(dev, -EINVAL,
+					     "Unknown sensor type %d\n",
+					     sensor.type);
 		}
 
-		if (IS_ERR(st->sensors[chan])) {
-			dev_err(dev, "Failed to create sensor %ld",
-				PTR_ERR(st->sensors[chan]));
-			ret = PTR_ERR(st->sensors[chan]);
-			goto put_child;
-		}
+		if (IS_ERR(st->sensors[chan]))
+			return dev_err_probe(dev, PTR_ERR(st->sensors[chan]),
+					     "Failed to create sensor\n");
+
 		/* set generic sensor parameters */
 		st->sensors[chan]->chan = sensor.chan;
 		st->sensors[chan]->type = sensor.type;
@@ -1446,9 +1412,6 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
 	}
 
 	return 0;
-put_child:
-	fwnode_handle_put(child);
-	return ret;
 }
 
 static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
-- 
2.44.0



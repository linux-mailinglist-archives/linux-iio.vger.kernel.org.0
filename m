Return-Path: <linux-iio+bounces-1664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB66C82D1B4
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 18:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0EF281FCD
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0411747F;
	Sun, 14 Jan 2024 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNyRJFpN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98025C8DD;
	Sun, 14 Jan 2024 17:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ED4C433B1;
	Sun, 14 Jan 2024 17:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705252906;
	bh=3JL8R3J3IAmuDam7qF0jUSrP25FFmQp4qhJlTZMy7BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNyRJFpNmmZVmTKRdZH5pOF+QBFmvAQeNha2zqZltruLZ3BSYFl5PKz/rX2VqJliu
	 e3h8wRHX6Ur0gH45FTqHQmaxM/g5bRArbBDShp8+a+jbjUE0bBYMb6Tm0ktCdMZCid
	 9bj/eHpfKWwTWuJR9ZeGc7Ksz5ZBmmuFtVNnd4MnJKH/WynswtXV7AjKt/O9liZ27a
	 W7CPfGF4xIfNHCMcsCtVGHPcs/L5QQpGtvOiwJk5VJdhbcBHRSw+49qaAT2h3wdnz7
	 ZBPwh8EwXSVb1KPUIkNt2NkprIPAQ4IWMOolOpwRDVE8PeQOGJ/CIarRDJw4ya6T1V
	 pEe2OTB5bhFKA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
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
Subject: [PATCH 13/13] iio: temp: ltc2983: Use __free(fwnode_handle) to replace fwnode_handle_put() calls
Date: Sun, 14 Jan 2024 17:20:09 +0000
Message-ID: <20240114172009.179893-14-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114172009.179893-1-jic23@kernel.org>
References: <20240114172009.179893-1-jic23@kernel.org>
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

Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/ltc2983.c | 70 ++++++++++---------------------
 1 file changed, 21 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index fcb96c44d954..4357364e611e 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -656,7 +656,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 			 const struct ltc2983_sensor *sensor)
 {
 	struct ltc2983_thermocouple *thermo;
-	struct fwnode_handle *ref;
+	struct fwnode_handle *ref __free(fwnode_handle) = NULL;
 	u32 oc_current;
 	int ret;
 
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
@@ -750,7 +743,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	struct ltc2983_rtd *rtd;
 	int ret = 0;
 	struct device *dev = &st->spi->dev;
-	struct fwnode_handle *ref;
+	struct fwnode_handle *ref __free(fwnode_handle) = NULL;
 	u32 excitation_current = 0, n_wires = 0;
 
 	rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
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
@@ -921,7 +902,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 {
 	struct ltc2983_thermistor *thermistor;
 	struct device *dev = &st->spi->dev;
-	struct fwnode_handle *ref;
+	struct fwnode_handle *ref __free(fwnode_handle) = NULL;
 	u32 excitation_current = 0;
 	int ret = 0;
 
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
-- 
2.43.0



Return-Path: <linux-iio+bounces-2902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1320485F8DF
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 13:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC45328684C
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 12:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C377213248E;
	Thu, 22 Feb 2024 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ov+jd4/7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DC212FB30;
	Thu, 22 Feb 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606394; cv=none; b=sJkrnd832lZXzS7WIWu//SvKKDeqBIG8R96Z4Rcil4dOMYuUk9bKjtOJ/au7KK23o9+ssRpHU/pj0tm+kzrnX14FkE50uvUhSrCro9d4nnuu7kl3ZItgoiSqIzHnFx/HikPuwdkrTHVwb+aixC3LDBI2o/Nrnf6QXYdmqBn3T9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606394; c=relaxed/simple;
	bh=Pn0aueoTaFNTYznkk+Bdw5JxxyZ9XUi3tNSkzkTyPJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=K71L//koxJXvdm+E0rVweIDkgiicIQyF2/EGypcrCxpTis0YJuE/CJ3p6FQyC1+hoxuWfuw3KgoIG1EZIlkNVdA2/hBDdNkSLjdg1TToGZzfqYRKinvTmoQaWvqufiS8gthEOowFD/Ia8rNamBsclKZTI9CnVurjp34BlF8KoMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ov+jd4/7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M9C1Bj030385;
	Thu, 22 Feb 2024 07:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=qiolDx4DRN3VvMNQw7t/iZ++A0MYA0o8Z4ocfPigOuU=; b=
	ov+jd4/7GQkXPx677jhSrkrXeFxDp3SyEV6Qx+Ad3RnoQmu22/xEPuRqzNYwvSOS
	49YjJlwUzMg+h8CfgTzcEJDbGiVxdspmhto/Bq5MxqnQlKct3BooHL/CWq73b4aY
	OUgqP+EnvOomje3Sve6nwlMTGboHXG0LatnUd4w+EcC5TLqxnorfxcrxC1mgNP9W
	iPSeMFJHRQWT6l3AWxWS6MDER0t+8ZZsgqn9tkGsDJs6MQXPoWDsC7JxK/eze8t0
	914uT8v+QlxqyCBFMmge98+t6A5A2M+LFYLsiV0FKDlBs3cZLTKdfCoIwKRHFq4u
	6eecnrcHbwdZVZWaqxESuw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wd21ggpj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 07:52:45 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41MCqixk047596
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 07:52:44 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 22 Feb 2024 07:52:43 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 22 Feb 2024 07:52:43 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 22 Feb 2024 07:52:43 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41MCqTFA003844;
	Thu, 22 Feb 2024 07:52:39 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 22 Feb 2024 13:55:54 +0100
Subject: [PATCH 3/6] iio: temperature: ltc2983: convert to dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-ltc2983-misc-improv-v1-3-cf7d4457e98c@analog.com>
References: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
In-Reply-To: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708606552; l=17248;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Pn0aueoTaFNTYznkk+Bdw5JxxyZ9XUi3tNSkzkTyPJM=;
 b=n5bTgwiw99PGee0CZBefaral4qOukdXXgqifg8qr1PGc5MKB0y137Yl0x0UmZnQ3vblcjrV88
 WxKlBKFLb23BHDqnUQz4A6ZDkJh+qOvagjnOz/gCw/CbBHgEmfg3vHA
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: lJBrd0Br-ctmoNhUCd8e7NfSX0DYebjj
X-Proofpoint-ORIG-GUID: lJBrd0Br-ctmoNhUCd8e7NfSX0DYebjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_09,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220101

Use dev_err_probe() in the probe() path. While at it, made some simple
improvements:
 * Declare a struct device *dev helper. This also makes the style more
   consistent (some places the helper was used and not in other places);
 * Explicitly included the err.h and errno.h headers;
 * Removed an useless else if().

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 190 ++++++++++++++++++++------------------
 1 file changed, 98 insertions(+), 92 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 23f2d43fc040..4b096aa3fbd8 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -8,6 +8,8 @@
 #include <linux/bitfield.h>
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
@@ -656,11 +658,12 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 			 const struct ltc2983_sensor *sensor)
 {
 	struct ltc2983_thermocouple *thermo;
+	struct device *dev = &st->spi->dev;
 	struct fwnode_handle *ref;
 	u32 oc_current;
 	int ret;
 
-	thermo = devm_kzalloc(&st->spi->dev, sizeof(*thermo), GFP_KERNEL);
+	thermo = devm_kzalloc(dev, sizeof(*thermo), GFP_KERNEL);
 	if (!thermo)
 		return ERR_PTR(-ENOMEM);
 
@@ -687,8 +690,9 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 					LTC2983_THERMOCOUPLE_OC_CURR(3);
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid open circuit current:%u", oc_current);
+			dev_err_probe(dev, -EINVAL,
+				      "Invalid open circuit current:%u",
+				      oc_current);
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -697,9 +701,9 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 	/* validate channel index */
 	if (!(thermo->sensor_config & LTC2983_THERMOCOUPLE_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev,
-			"Invalid chann:%d for differential thermocouple",
-			sensor->chan);
+		dev_err_probe(dev, -EINVAL,
+			      "Invalid chann:%d for differential thermocouple",
+			      sensor->chan);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -713,7 +717,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 			 * This would be catched later but we can just return
 			 * the error right away.
 			 */
-			dev_err(&st->spi->dev, "Property reg must be given\n");
+			dev_err_probe(dev, ret, "Property reg must be given\n");
 			goto fail;
 		}
 	}
@@ -759,13 +763,14 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 
 	ref = fwnode_find_reference(child, "adi,rsense-handle", 0);
 	if (IS_ERR(ref)) {
-		dev_err(dev, "Property adi,rsense-handle missing or invalid");
+		dev_err_probe(dev, PTR_ERR(ref),
+			      "Property adi,rsense-handle missing or invalid");
 		return ERR_CAST(ref);
 	}
 
 	ret = fwnode_property_read_u32(ref, "reg", &rtd->r_sense_chan);
 	if (ret) {
-		dev_err(dev, "Property reg must be given\n");
+		dev_err_probe(dev, ret, "Property reg must be given\n");
 		goto fail;
 	}
 
@@ -786,8 +791,9 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			rtd->sensor_config = LTC2983_RTD_N_WIRES(3);
 			break;
 		default:
-			dev_err(dev, "Invalid number of wires:%u\n", n_wires);
-			ret = -EINVAL;
+			ret = dev_err_probe(dev, -EINVAL,
+					    "Invalid number of wires:%u\n",
+					    n_wires);
 			goto fail;
 		}
 	}
@@ -796,9 +802,8 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 		/* Current rotation is only available with rsense sharing */
 		if (fwnode_property_read_bool(child, "adi,current-rotate")) {
 			if (n_wires == 2 || n_wires == 3) {
-				dev_err(dev,
-					"Rotation not allowed for 2/3 Wire RTDs");
-				ret = -EINVAL;
+				ret = dev_err_probe(dev, -EINVAL,
+						    "Rotation not allowed for 2/3 Wire RTDs");
 				goto fail;
 			}
 			rtd->sensor_config |= LTC2983_RTD_C_ROTATE(1);
@@ -825,28 +830,24 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 		     == LTC2983_RTD_KELVIN_R_SENSE_MASK) &&
 		    (rtd->r_sense_chan <=  min)) {
 			/* kelvin rsense*/
-			dev_err(dev,
-				"Invalid rsense chann:%d to use in kelvin rsense",
-				rtd->r_sense_chan);
-
-			ret = -EINVAL;
+			ret = dev_err_probe(dev, -EINVAL,
+					    "Invalid rsense chann:%d to use in kelvin rsense",
+					    rtd->r_sense_chan);
 			goto fail;
 		}
 
 		if (sensor->chan < min || sensor->chan > max) {
-			dev_err(dev, "Invalid chann:%d for the rtd config",
-				sensor->chan);
-
-			ret = -EINVAL;
+			ret = dev_err_probe(dev, -EINVAL,
+					    "Invalid chann:%d for the rtd config",
+					    sensor->chan);
 			goto fail;
 		}
 	} else {
 		/* same as differential case */
 		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-			dev_err(&st->spi->dev,
-				"Invalid chann:%d for RTD", sensor->chan);
-
-			ret = -EINVAL;
+			ret = dev_err_probe(dev, -EINVAL,
+					    "Invalid chann:%d for RTD",
+					    sensor->chan);
 			goto fail;
 		}
 	}
@@ -898,10 +899,9 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			rtd->excitation_current = 0x08;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
-			ret = -EINVAL;
+			ret = dev_err_probe(dev, -EINVAL,
+					    "Invalid value for excitation current(%u)",
+					    excitation_current);
 			goto fail;
 		}
 	}
@@ -931,13 +931,15 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 
 	ref = fwnode_find_reference(child, "adi,rsense-handle", 0);
 	if (IS_ERR(ref)) {
-		dev_err(dev, "Property adi,rsense-handle missing or invalid");
+		dev_err_probe(dev, PTR_ERR(ref),
+			      "Property adi,rsense-handle missing or invalid");
 		return ERR_CAST(ref);
 	}
 
 	ret = fwnode_property_read_u32(ref, "reg", &thermistor->r_sense_chan);
 	if (ret) {
-		dev_err(dev, "rsense channel must be configured...\n");
+		dev_err_probe(dev, ret,
+			      "rsense channel must be configured...\n");
 		goto fail;
 	}
 
@@ -955,10 +957,9 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 	/* validate channel index */
 	if (!(thermistor->sensor_config & LTC2983_THERMISTOR_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev,
-			"Invalid chann:%d for differential thermistor",
-			sensor->chan);
-		ret = -EINVAL;
+		ret = dev_err_probe(dev, -EINVAL,
+				    "Invalid chann:%d for differential thermistor",
+				    sensor->chan);
 		goto fail;
 	}
 
@@ -1003,9 +1004,8 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 			/* auto range */
 			if (sensor->type >=
 			    LTC2983_SENSOR_THERMISTOR_STEINHART) {
-				dev_err(&st->spi->dev,
-					"Auto Range not allowed for custom sensors\n");
-				ret = -EINVAL;
+				ret = dev_err_probe(dev, -EINVAL,
+						    "Auto Range not allowed for custom sensors\n");
 				goto fail;
 			}
 			thermistor->excitation_current = 0x0c;
@@ -1044,10 +1044,9 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 			thermistor->excitation_current = 0x0b;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
-			ret = -EINVAL;
+			ret = dev_err_probe(dev, -EINVAL,
+					    "Invalid value for excitation current(%u)",
+					    excitation_current);
 			goto fail;
 		}
 	}
@@ -1063,11 +1062,12 @@ static struct ltc2983_sensor *
 ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *st,
 		  const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_diode *diode;
 	u32 temp = 0, excitation_current = 0;
 	int ret;
 
-	diode = devm_kzalloc(&st->spi->dev, sizeof(*diode), GFP_KERNEL);
+	diode = devm_kzalloc(dev, sizeof(*diode), GFP_KERNEL);
 	if (!diode)
 		return ERR_PTR(-ENOMEM);
 
@@ -1083,9 +1083,9 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 	/* validate channel index */
 	if (!(diode->sensor_config & LTC2983_DIODE_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev,
-			"Invalid chann:%d for differential thermistor",
-			sensor->chan);
+		dev_err_probe(dev, -EINVAL,
+			      "Invalid chann:%d for differential thermistor",
+			      sensor->chan);
 		return ERR_PTR(-EINVAL);
 	}
 	/* set common parameters */
@@ -1109,9 +1109,9 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 			diode->excitation_current = 0x03;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
+			dev_err_probe(dev, -EINVAL,
+				      "Invalid value for excitation current(%u)",
+				      excitation_current);
 			return ERR_PTR(-EINVAL);
 		}
 	}
@@ -1128,24 +1128,26 @@ static struct ltc2983_sensor *ltc2983_r_sense_new(struct fwnode_handle *child,
 					struct ltc2983_data *st,
 					const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_rsense *rsense;
 	int ret;
 	u32 temp;
 
-	rsense = devm_kzalloc(&st->spi->dev, sizeof(*rsense), GFP_KERNEL);
+	rsense = devm_kzalloc(dev, sizeof(*rsense), GFP_KERNEL);
 	if (!rsense)
 		return ERR_PTR(-ENOMEM);
 
 	/* validate channel index */
 	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chann:%d for r_sense",
-			sensor->chan);
+		dev_err_probe(dev, -EINVAL, "Invalid chann:%d for r_sense",
+			      sensor->chan);
 		return ERR_PTR(-EINVAL);
 	}
 
 	ret = fwnode_property_read_u32(child, "adi,rsense-val-milli-ohms", &temp);
 	if (ret) {
-		dev_err(&st->spi->dev, "Property adi,rsense-val-milli-ohms missing\n");
+		dev_err_probe(dev, -EINVAL,
+			      "Property adi,rsense-val-milli-ohms missing\n");
 		return ERR_PTR(-EINVAL);
 	}
 	/*
@@ -1166,9 +1168,10 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 					 struct ltc2983_data *st,
 					 const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_adc *adc;
 
-	adc = devm_kzalloc(&st->spi->dev, sizeof(*adc), GFP_KERNEL);
+	adc = devm_kzalloc(dev, sizeof(*adc), GFP_KERNEL);
 	if (!adc)
 		return ERR_PTR(-ENOMEM);
 
@@ -1177,8 +1180,9 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 
 	if (!adc->single_ended &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chan:%d for differential adc\n",
-			sensor->chan);
+		dev_err_probe(dev, -EINVAL,
+			      "Invalid chan:%d for differential adc\n",
+			      sensor->chan);
 		return ERR_PTR(-EINVAL);
 	}
 	/* set common parameters */
@@ -1192,9 +1196,10 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 					       struct ltc2983_data *st,
 					       const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_temp *temp;
 
-	temp = devm_kzalloc(&st->spi->dev, sizeof(*temp), GFP_KERNEL);
+	temp = devm_kzalloc(dev, sizeof(*temp), GFP_KERNEL);
 	if (!temp)
 		return ERR_PTR(-ENOMEM);
 
@@ -1203,8 +1208,8 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 
 	if (!temp->single_ended &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chan:%d for differential temp\n",
-			sensor->chan);
+		dev_err_probe(dev, -EINVAL, "Invalid chan:%d for differential temp\n",
+			      sensor->chan);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -1357,10 +1362,9 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 	device_property_read_u32(dev, "adi,filter-notch-freq", &st->filter_notch_freq);
 
 	st->num_channels = device_get_child_node_count(dev);
-	if (!st->num_channels) {
-		dev_err(&st->spi->dev, "At least one channel must be given!");
-		return -EINVAL;
-	}
+	if (!st->num_channels)
+		return dev_err_probe(dev, -EINVAL,
+				     "At least one channel must be given!");
 
 	st->sensors = devm_kcalloc(dev, st->num_channels, sizeof(*st->sensors),
 				   GFP_KERNEL);
@@ -1373,27 +1377,31 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 
 		ret = fwnode_property_read_u32(child, "reg", &sensor.chan);
 		if (ret) {
-			dev_err(dev, "reg property must given for child nodes\n");
+			dev_err_probe(dev, ret,
+				      "reg property must given for child nodes\n");
 			goto put_child;
 		}
 
 		/* check if we have a valid channel */
 		if (sensor.chan < LTC2983_MIN_CHANNELS_NR ||
 		    sensor.chan > st->info->max_channels_nr) {
-			ret = -EINVAL;
-			dev_err(dev, "chan:%d must be from %u to %u\n", sensor.chan,
-				LTC2983_MIN_CHANNELS_NR, st->info->max_channels_nr);
+			ret = dev_err_probe(dev, -EINVAL,
+					    "chan:%d must be from %u to %u\n",
+					    sensor.chan, LTC2983_MIN_CHANNELS_NR,
+					    st->info->max_channels_nr);
 			goto put_child;
-		} else if (channel_avail_mask & BIT(sensor.chan)) {
-			ret = -EINVAL;
-			dev_err(dev, "chan:%d already in use\n", sensor.chan);
+		}
+
+		if (channel_avail_mask & BIT(sensor.chan)) {
+			ret = dev_err_probe(dev, -EINVAL, "chan:%d already in use\n",
+					    sensor.chan);
 			goto put_child;
 		}
 
 		ret = fwnode_property_read_u32(child, "adi,sensor-type", &sensor.type);
 		if (ret) {
-			dev_err(dev,
-				"adi,sensor-type property must given for child nodes\n");
+			dev_err_probe(dev, ret,
+				      "adi,sensor-type property must given for child nodes\n");
 			goto put_child;
 		}
 
@@ -1426,15 +1434,14 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 			   sensor.type == LTC2983_SENSOR_ACTIVE_TEMP) {
 			st->sensors[chan] = ltc2983_temp_new(child, st, &sensor);
 		} else {
-			dev_err(dev, "Unknown sensor type %d\n", sensor.type);
-			ret = -EINVAL;
+			ret = dev_err_probe(dev, -EINVAL, "Unknown sensor type %d\n",
+					    sensor.type);
 			goto put_child;
 		}
 
 		if (IS_ERR(st->sensors[chan])) {
-			dev_err(dev, "Failed to create sensor %ld",
-				PTR_ERR(st->sensors[chan]));
-			ret = PTR_ERR(st->sensors[chan]);
+			ret = dev_err_probe(dev, PTR_ERR(st->sensors[chan]),
+					    "Failed to create sensor\n");
 			goto put_child;
 		}
 		/* set generic sensor parameters */
@@ -1602,13 +1609,14 @@ static const struct  iio_info ltc2983_iio_info = {
 
 static int ltc2983_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct ltc2983_data *st;
 	struct iio_dev *indio_dev;
 	struct gpio_desc *gpio;
 	const char *name = spi_get_device_id(spi)->name;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1619,10 +1627,9 @@ static int ltc2983_probe(struct spi_device *spi)
 		return -ENODEV;
 
 	st->regmap = devm_regmap_init_spi(spi, &ltc2983_regmap_config);
-	if (IS_ERR(st->regmap)) {
-		dev_err(&spi->dev, "Failed to initialize regmap\n");
-		return PTR_ERR(st->regmap);
-	}
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to initialize regmap\n");
 
 	mutex_init(&st->lock);
 	init_completion(&st->completion);
@@ -1634,7 +1641,7 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	gpio = devm_gpiod_get_optional(&st->spi->dev, "reset", GPIOD_OUT_HIGH);
+	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
@@ -1644,7 +1651,7 @@ static int ltc2983_probe(struct spi_device *spi)
 		gpiod_set_value_cansleep(gpio, 0);
 	}
 
-	st->iio_chan = devm_kzalloc(&spi->dev,
+	st->iio_chan = devm_kzalloc(dev,
 				    st->iio_channels * sizeof(*st->iio_chan),
 				    GFP_KERNEL);
 	if (!st->iio_chan)
@@ -1654,12 +1661,11 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(&spi->dev, spi->irq, ltc2983_irq_handler,
+	ret = devm_request_irq(dev, spi->irq, ltc2983_irq_handler,
 			       IRQF_TRIGGER_RISING, name, st);
-	if (ret) {
-		dev_err(&spi->dev, "failed to request an irq, %d", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request an irq, %d",
+				     ret);
 
 	if (st->info->has_eeprom) {
 		ret = ltc2983_eeprom_cmd(st, LTC2983_EEPROM_WRITE_CMD,
@@ -1676,7 +1682,7 @@ static int ltc2983_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ltc2983_iio_info;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int ltc2983_resume(struct device *dev)

-- 
2.43.2



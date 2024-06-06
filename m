Return-Path: <linux-iio+bounces-5885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E08FDF73
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 09:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594381C24817
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 07:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894E613D8B6;
	Thu,  6 Jun 2024 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qA4qBimm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49713C8F0;
	Thu,  6 Jun 2024 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658405; cv=none; b=IDh27eY4LTwNhSLwahgr2ndvSQ3cQHpGHh4cQKMWLumFyxh43qXrRK34IdBOFhy/x5iwFPG/xgVSshmuFyofNBIzNftmAjoyzxR/IkrcDG3HQIQdcuveakXNrU9pFzhv+4Y8wgHguCnMuPgmeXb2Jmi8z5F3ehS8eXF+q/hKYI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658405; c=relaxed/simple;
	bh=Chqw4IWUvxddkikqjAfix1FO2sPQBeLAymic5uqQjJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jw/OwhqRZji3In2okQlH2Q0mihGbiShOvQVEfo1slTf3e7bZPd3ZCXKgfB2noiysJ77a3o8JRtIv1gkKinPkXnJhBEdt1HN92MeZLkTFzd5mkv1rbC0OqBX8CXhxbAKWBK0ynXH1do9Rbzd5tnSa/TJ3HMvsf/oMJpPG8TELNVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qA4qBimm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45661lo8021306;
	Thu, 6 Jun 2024 03:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZEQhq
	p+ltB4VeV/H5nA7YU50U3m6myn+XnXQXJQ+kyk=; b=qA4qBimmZRE0US4eq4+hk
	lsAdI5qQCGU1ZjGtftmC1Ra5+Zb6+M77GtfvSCsaJraXlJiEtC9IL5M39ccgqTA+
	9VrG18dM+gij6nElhHrNHlhxqBA4lrbPGeZGB2OTmN581FPbQWM57AYF4BZHJy8E
	3K7ieEkUfyOQfNxsbg7W5/KfHATBVEBSlNbg3yqtcQIOtNsjthzOiLR0jAqF8mni
	f4Y1P3IIXZydFBCMkmxuqpf+anjZupytH1JaprqDC3+raL7OhxfrIVyXz4ObYeBf
	dLcz6WjaaJHjU8wNrDGIVrB76fez7cQRqqeKAOil38eDm3ftWgMPoxp0ywd9pXcR
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yk7g207r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 03:19:21 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4567JJSu030133
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 03:19:19 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Jun 2024 03:19:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Jun 2024 03:19:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Jun 2024 03:19:18 -0400
Received: from [127.0.0.1] ([10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4567ItBd025782;
	Thu, 6 Jun 2024 03:19:13 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 6 Jun 2024 09:22:38 +0200
Subject: [PATCH v3 2/4] iio: temperature: ltc2983: convert to
 dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-dev-add_dev_errp_probe-v3-2-51bb229edd79@analog.com>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
In-Reply-To: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
To: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Chris Down
	<chris@chrisdown.name>,
        John Ogness <john.ogness@linutronix.de>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andi Shyti
	<andi.shyti@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717658563; l=17392;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Chqw4IWUvxddkikqjAfix1FO2sPQBeLAymic5uqQjJQ=;
 b=8tVriCeDl9nYFARRygIhx0v00FnwHi7uzo0Hs5lDsOdx6+w8scK3lXP7pfqDK9MrH67xaRlH2
 6J2Ye1WU2zpDHAOzoJcIVikcLDdkYUUH6bp5n79yhCovFoFoL7bWGe7
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: B9D3KfBR_S25drwYJFjnIJmNHq5nv_-N
X-Proofpoint-GUID: B9D3KfBR_S25drwYJFjnIJmNHq5nv_-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060052

Use dev_err_probe() (and variants) in the probe() path. While at it, made
some simple improvements:
 * Explicitly included the err.h and errno.h headers;
 * Removed some unnecessary line breaks;
 * Removed a redundant 'else';
 * Added some missing \n to prink.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 260 +++++++++++++++++---------------------
 1 file changed, 113 insertions(+), 147 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 24d19f3c7292..21f2cfc55bf8 100644
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
@@ -432,10 +434,9 @@ __ltc2983_custom_sensor_new(struct ltc2983_data *st, const struct fwnode_handle
 	else
 		n_entries = fwnode_property_count_u64(fn, propname);
 	/* n_entries must be an even number */
-	if (!n_entries || (n_entries % 2) != 0) {
-		dev_err(dev, "Number of entries either 0 or not even\n");
-		return ERR_PTR(-EINVAL);
-	}
+	if (!n_entries || (n_entries % 2) != 0)
+		return dev_err_ptr_probe(dev, -EINVAL,
+					 "Number of entries either 0 or not even\n");
 
 	new_custom = devm_kzalloc(dev, sizeof(*new_custom), GFP_KERNEL);
 	if (!new_custom)
@@ -443,19 +444,17 @@ __ltc2983_custom_sensor_new(struct ltc2983_data *st, const struct fwnode_handle
 
 	new_custom->size = n_entries * n_size;
 	/* check Steinhart size */
-	if (is_steinhart && new_custom->size != LTC2983_CUSTOM_STEINHART_SIZE) {
-		dev_err(dev, "Steinhart sensors size(%zu) must be %u\n", new_custom->size,
-			LTC2983_CUSTOM_STEINHART_SIZE);
-		return ERR_PTR(-EINVAL);
-	}
+	if (is_steinhart && new_custom->size != LTC2983_CUSTOM_STEINHART_SIZE)
+		return dev_err_ptr_probe(dev, -EINVAL,
+					 "Steinhart sensors size(%zu) must be %u\n",
+					 new_custom->size, LTC2983_CUSTOM_STEINHART_SIZE);
+
 	/* Check space on the table. */
 	if (st->custom_table_size + new_custom->size >
-	    (LTC2983_CUST_SENS_TBL_END_REG -
-	     LTC2983_CUST_SENS_TBL_START_REG) + 1) {
-		dev_err(dev, "No space left(%d) for new custom sensor(%zu)",
-				st->custom_table_size, new_custom->size);
-		return ERR_PTR(-EINVAL);
-	}
+	    (LTC2983_CUST_SENS_TBL_END_REG - LTC2983_CUST_SENS_TBL_START_REG) + 1)
+		return dev_err_ptr_probe(dev, -EINVAL,
+					 "No space left(%d) for new custom sensor(%zu)\n",
+					 st->custom_table_size, new_custom->size);
 
 	/* allocate the table */
 	if (is_steinhart)
@@ -688,21 +687,19 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 					LTC2983_THERMOCOUPLE_OC_CURR(3);
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid open circuit current:%u", oc_current);
-			return ERR_PTR(-EINVAL);
+			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+						 "Invalid open circuit current:%u\n",
+						 oc_current);
 		}
 
 		thermo->sensor_config |= LTC2983_THERMOCOUPLE_OC_CHECK(1);
 	}
 	/* validate channel index */
 	if (!(thermo->sensor_config & LTC2983_THERMOCOUPLE_DIFF_MASK) &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev,
-			"Invalid chann:%d for differential thermocouple",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+					 "Invalid chann:%d for differential thermocouple\n",
+					 sensor->chan);
 
 	struct fwnode_handle *ref __free(fwnode_handle) =
 		fwnode_find_reference(child, "adi,cold-junction-handle", 0);
@@ -710,14 +707,13 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 		ref = NULL;
 	} else {
 		ret = fwnode_property_read_u32(ref, "reg", &thermo->cold_junction_chan);
-		if (ret) {
+		if (ret)
 			/*
 			 * This would be catched later but we can just return
 			 * the error right away.
 			 */
-			dev_err(&st->spi->dev, "Property reg must be given\n");
-			return ERR_PTR(ret);
-		}
+			return dev_err_ptr_probe(&st->spi->dev, ret,
+						 "Property reg must be given\n");
 	}
 
 	/* check custom sensor */
@@ -753,16 +749,14 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 
 	struct fwnode_handle *ref __free(fwnode_handle) =
 		fwnode_find_reference(child, "adi,rsense-handle", 0);
-	if (IS_ERR(ref)) {
-		dev_err(dev, "Property adi,rsense-handle missing or invalid");
-		return ERR_CAST(ref);
-	}
+	if (IS_ERR(ref))
+		return dev_err_cast_probe(dev, ref,
+					  "Property adi,rsense-handle missing or invalid\n");
 
 	ret = fwnode_property_read_u32(ref, "reg", &rtd->r_sense_chan);
-	if (ret) {
-		dev_err(dev, "Property reg must be given\n");
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		return dev_err_ptr_probe(dev, ret,
+					 "Property reg must be given\n");
 
 	ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
 	if (!ret) {
@@ -781,19 +775,19 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			rtd->sensor_config = LTC2983_RTD_N_WIRES(3);
 			break;
 		default:
-			dev_err(dev, "Invalid number of wires:%u\n", n_wires);
-			return ERR_PTR(-EINVAL);
+			return dev_err_ptr_probe(dev, -EINVAL,
+						 "Invalid number of wires:%u\n",
+						 n_wires);
 		}
 	}
 
 	if (fwnode_property_read_bool(child, "adi,rsense-share")) {
 		/* Current rotation is only available with rsense sharing */
 		if (fwnode_property_read_bool(child, "adi,current-rotate")) {
-			if (n_wires == 2 || n_wires == 3) {
-				dev_err(dev,
-					"Rotation not allowed for 2/3 Wire RTDs");
-				return ERR_PTR(-EINVAL);
-			}
+			if (n_wires == 2 || n_wires == 3)
+				return dev_err_ptr_probe(dev, -EINVAL,
+							 "Rotation not allowed for 2/3 Wire RTDs\n");
+
 			rtd->sensor_config |= LTC2983_RTD_C_ROTATE(1);
 		} else {
 			rtd->sensor_config |= LTC2983_RTD_R_SHARE(1);
@@ -816,29 +810,22 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 
 		if (((rtd->sensor_config & LTC2983_RTD_KELVIN_R_SENSE_MASK)
 		     == LTC2983_RTD_KELVIN_R_SENSE_MASK) &&
-		    (rtd->r_sense_chan <=  min)) {
+		    (rtd->r_sense_chan <=  min))
 			/* kelvin rsense*/
-			dev_err(dev,
-				"Invalid rsense chann:%d to use in kelvin rsense",
-				rtd->r_sense_chan);
+			return dev_err_ptr_probe(dev, -EINVAL,
+						 "Invalid rsense chann:%d to use in kelvin rsense\n",
+						 rtd->r_sense_chan);
 
-			return ERR_PTR(-EINVAL);
-		}
-
-		if (sensor->chan < min || sensor->chan > max) {
-			dev_err(dev, "Invalid chann:%d for the rtd config",
-				sensor->chan);
-
-			return ERR_PTR(-EINVAL);
-		}
+		if (sensor->chan < min || sensor->chan > max)
+			return dev_err_ptr_probe(dev, -EINVAL,
+						 "Invalid chann:%d for the rtd config\n",
+						 sensor->chan);
 	} else {
 		/* same as differential case */
-		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-			dev_err(&st->spi->dev,
-				"Invalid chann:%d for RTD", sensor->chan);
-
-			return ERR_PTR(-EINVAL);
-		}
+		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+						 "Invalid chann:%d for RTD\n",
+						 sensor->chan);
 	}
 
 	/* check custom sensor */
@@ -886,10 +873,9 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			rtd->excitation_current = 0x08;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
-			return ERR_PTR(-EINVAL);
+			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+						 "Invalid value for excitation current(%u)\n",
+						 excitation_current);
 		}
 	}
 
@@ -913,16 +899,14 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 
 	struct fwnode_handle *ref __free(fwnode_handle) =
 		fwnode_find_reference(child, "adi,rsense-handle", 0);
-	if (IS_ERR(ref)) {
-		dev_err(dev, "Property adi,rsense-handle missing or invalid");
-		return ERR_CAST(ref);
-	}
+	if (IS_ERR(ref))
+		return dev_err_cast_probe(dev, ref,
+					  "Property adi,rsense-handle missing or invalid\n");
 
 	ret = fwnode_property_read_u32(ref, "reg", &thermistor->r_sense_chan);
-	if (ret) {
-		dev_err(dev, "rsense channel must be configured...\n");
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		return dev_err_ptr_probe(dev, ret,
+					 "rsense channel must be configured...\n");
 
 	if (fwnode_property_read_bool(child, "adi,single-ended")) {
 		thermistor->sensor_config = LTC2983_THERMISTOR_SGL(1);
@@ -937,12 +921,10 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 	}
 	/* validate channel index */
 	if (!(thermistor->sensor_config & LTC2983_THERMISTOR_DIFF_MASK) &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev,
-			"Invalid chann:%d for differential thermistor",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+					 "Invalid chann:%d for differential thermistor\n",
+					 sensor->chan);
 
 	/* check custom sensor */
 	if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART) {
@@ -981,12 +963,10 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 		switch (excitation_current) {
 		case 0:
 			/* auto range */
-			if (sensor->type >=
-			    LTC2983_SENSOR_THERMISTOR_STEINHART) {
-				dev_err(&st->spi->dev,
-					"Auto Range not allowed for custom sensors\n");
-				return ERR_PTR(-EINVAL);
-			}
+			if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART)
+				return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+							 "Auto Range not allowed for custom sensors\n");
+
 			thermistor->excitation_current = 0x0c;
 			break;
 		case 250:
@@ -1023,10 +1003,9 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 			thermistor->excitation_current = 0x0b;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
-			return ERR_PTR(-EINVAL);
+			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+						 "Invalid value for excitation current(%u)\n",
+						 excitation_current);
 		}
 	}
 
@@ -1056,12 +1035,11 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 
 	/* validate channel index */
 	if (!(diode->sensor_config & LTC2983_DIODE_DIFF_MASK) &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev,
-			"Invalid chann:%d for differential thermistor",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+					 "Invalid chann:%d for differential thermistor\n",
+					 sensor->chan);
+
 	/* set common parameters */
 	diode->sensor.fault_handler = ltc2983_common_fault_handler;
 	diode->sensor.assign_chan = ltc2983_diode_assign_chan;
@@ -1083,10 +1061,9 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 			diode->excitation_current = 0x03;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
-			return ERR_PTR(-EINVAL);
+			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+						 "Invalid value for excitation current(%u)\n",
+						 excitation_current);
 		}
 	}
 
@@ -1111,17 +1088,15 @@ static struct ltc2983_sensor *ltc2983_r_sense_new(struct fwnode_handle *child,
 		return ERR_PTR(-ENOMEM);
 
 	/* validate channel index */
-	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chann:%d for r_sense",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+					 "Invalid chann:%d for r_sense\n",
+					 sensor->chan);
 
 	ret = fwnode_property_read_u32(child, "adi,rsense-val-milli-ohms", &temp);
-	if (ret) {
-		dev_err(&st->spi->dev, "Property adi,rsense-val-milli-ohms missing\n");
-		return ERR_PTR(-EINVAL);
-	}
+	if (ret)
+		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+					 "Property adi,rsense-val-milli-ohms missing\n");
 	/*
 	 * Times 1000 because we have milli-ohms and __convert_to_raw
 	 * expects scales of 1000000 which are used for all other
@@ -1149,12 +1124,11 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 	if (fwnode_property_read_bool(child, "adi,single-ended"))
 		adc->single_ended = true;
 
-	if (!adc->single_ended &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chan:%d for differential adc\n",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	if (!adc->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+					 "Invalid chan:%d for differential adc\n",
+					 sensor->chan);
+
 	/* set common parameters */
 	adc->sensor.assign_chan = ltc2983_adc_assign_chan;
 	adc->sensor.fault_handler = ltc2983_common_fault_handler;
@@ -1175,12 +1149,10 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 	if (fwnode_property_read_bool(child, "adi,single-ended"))
 		temp->single_ended = true;
 
-	if (!temp->single_ended &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chan:%d for differential temp\n",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	if (!temp->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+					 "Invalid chan:%d for differential temp\n",
+					 sensor->chan);
 
 	temp->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-temp",
 						   false, 4096, true);
@@ -1296,8 +1268,8 @@ static int ltc2983_reg_access(struct iio_dev *indio_dev,
 
 	if (readval)
 		return regmap_read(st->regmap, reg, readval);
-	else
-		return regmap_write(st->regmap, reg, writeval);
+
+	return regmap_write(st->regmap, reg, writeval);
 }
 
 static irqreturn_t ltc2983_irq_handler(int irq, void *data)
@@ -1330,10 +1302,9 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 	device_property_read_u32(dev, "adi,filter-notch-freq", &st->filter_notch_freq);
 
 	st->num_channels = device_get_child_node_count(dev);
-	if (!st->num_channels) {
-		dev_err(&st->spi->dev, "At least one channel must be given!");
-		return -EINVAL;
-	}
+	if (!st->num_channels)
+		return dev_err_probe(&st->spi->dev, -EINVAL,
+				     "At least one channel must be given!\n");
 
 	st->sensors = devm_kcalloc(dev, st->num_channels, sizeof(*st->sensors),
 				   GFP_KERNEL);
@@ -1438,19 +1409,17 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 
 	time = wait_for_completion_timeout(&st->completion,
 					   msecs_to_jiffies(wait_time));
-	if (!time) {
-		dev_err(&st->spi->dev, "EEPROM command timed out\n");
-		return -ETIMEDOUT;
-	}
+	if (!time)
+		return dev_err_probe(&st->spi->dev, -ETIMEDOUT,
+				     "EEPROM command timed out\n");
 
 	ret = regmap_read(st->regmap, status_reg, &val);
 	if (ret)
 		return ret;
 
-	if (val & status_fail_mask) {
-		dev_err(&st->spi->dev, "EEPROM command failed: 0x%02X\n", val);
-		return -EINVAL;
-	}
+	if (val & status_fail_mask)
+		return dev_err_probe(&st->spi->dev, -EINVAL,
+				     "EEPROM command failed: 0x%02X\n", val);
 
 	return 0;
 }
@@ -1464,10 +1433,9 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 	ret = regmap_read_poll_timeout(st->regmap, LTC2983_STATUS_REG, status,
 				       LTC2983_STATUS_UP(status) == 1, 25000,
 				       25000 * 10);
-	if (ret) {
-		dev_err(&st->spi->dev, "Device startup timed out\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&st->spi->dev, ret,
+				     "Device startup timed out\n");
 
 	ret = regmap_update_bits(st->regmap, LTC2983_GLOBAL_CONFIG_REG,
 				 LTC2983_NOTCH_FREQ_MASK,
@@ -1583,10 +1551,9 @@ static int ltc2983_probe(struct spi_device *spi)
 		return -ENODEV;
 
 	st->regmap = devm_regmap_init_spi(spi, &ltc2983_regmap_config);
-	if (IS_ERR(st->regmap)) {
-		dev_err(&spi->dev, "Failed to initialize regmap\n");
-		return PTR_ERR(st->regmap);
-	}
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
+				     "Failed to initialize regmap\n");
 
 	mutex_init(&st->lock);
 	init_completion(&st->completion);
@@ -1624,10 +1591,9 @@ static int ltc2983_probe(struct spi_device *spi)
 
 	ret = devm_request_irq(&spi->dev, spi->irq, ltc2983_irq_handler,
 			       IRQF_TRIGGER_RISING, st->info->name, st);
-	if (ret) {
-		dev_err(&spi->dev, "failed to request an irq, %d", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to request an irq\n");
 
 	if (st->info->has_eeprom) {
 		ret = ltc2983_eeprom_cmd(st, LTC2983_EEPROM_WRITE_CMD,

-- 
2.45.2



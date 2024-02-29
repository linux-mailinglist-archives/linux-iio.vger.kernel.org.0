Return-Path: <linux-iio+bounces-3232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F8F86CEBE
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 17:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CA31C22501
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E9414BD52;
	Thu, 29 Feb 2024 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aiGkMTvF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C513F43D;
	Thu, 29 Feb 2024 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222930; cv=none; b=mwPAy7/m065ay3xixG0HtZf+lOIW92841j05buY53xr2wPfNBsRgoxQImrinPp+5bi9J88a1nXo7Da9WKZV1Z7Eqa4AMfcbuxm7JTu6vjFmajASLOaENqyEPc1mVak5/1g8+9f/2DYBhVQw6CsCrJuPl/KV8PtJjqlQFl2PW/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222930; c=relaxed/simple;
	bh=brdIpZy6HgU4Z1utx3Cfeckp6H4nJAhQwlqvueLcjKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BUivhhESZiDeO3KIjPX9uE93wZolt7dCPxozvu2gF964sorYemEIfZU3k0cJjkFtbeq9FezVvKjp+2lhmzmt8V4HUtBn+B/8QpYijS9VK3KewbtRPVn5868r+cdCdOSL895QOiXe4ZmjBiDBG6QmPqzB6gdSV+KhM1Of4xruW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aiGkMTvF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TE4Rq1006976;
	Thu, 29 Feb 2024 11:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=h6wCrGx9LlrGWo3JX5Cyqt2Bihq0hGLTD3G6W6NL7ug=; b=
	aiGkMTvF9JeNfFwlS+3JH6pqPr9DlYQu1O9qwVDtYqznQuclKelFEzK3XdUwloFE
	sI5ihbdnZ7GO09TnQ4Jq1UZ4IdouJcIHhM1Yo+YylZ7lnYliEg+uQ35IYEi2MMAk
	N2kGyvhv8VpJEL8RWpSzugr/M7mYCaoq2fSvaRPPqPJG5ontQmKpXm5M9rKtnelZ
	TnNyOZmdYFaWKQnygKQ0wTPa5NBqIR17g/AocG2FB84lfjoGrLVJNzyeWa64kRBI
	NcW+MybKuKUjHIvbtCeTcYinRVEuDtRUxW7xhy7GSXLuWSgYgwL3ggyuIwkaKw8d
	MsZsJLEZ4g6Pk6M7RzJ1Sg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3wjp9qhnvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 11:08:33 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41TG8VRn025978
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 11:08:31 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 29 Feb 2024 11:08:31 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 29 Feb 2024 11:08:30 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 29 Feb 2024 11:08:30 -0500
Received: from [127.0.0.1] ([10.44.3.58])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41TG8J9F018856;
	Thu, 29 Feb 2024 11:08:26 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 29 Feb 2024 17:11:41 +0100
Subject: [PATCH v2 1/3] iio: temperature: ltc2983: convert to
 dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-ltc2983-misc-improv-v2-1-cc6f03da2529@analog.com>
References: <20240229-ltc2983-misc-improv-v2-0-cc6f03da2529@analog.com>
In-Reply-To: <20240229-ltc2983-misc-improv-v2-0-cc6f03da2529@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709223103; l=19506;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=brdIpZy6HgU4Z1utx3Cfeckp6H4nJAhQwlqvueLcjKk=;
 b=mYwEv3eSohn3wJjh+H3YR2nxVyJuJHBF7ILvcgxTN5ZSjcDHlJe6ZlckOGDbslpGaEVureWcK
 38j4aWr5eGJCPAjoMGvXcNsnCC4cS1ZkcsbRvyp49p6a8YHXZuXlwu4
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: cXzNBOt5uaOXKVhEZkSgQ9Pt6XKfF8Xh
X-Proofpoint-ORIG-GUID: cXzNBOt5uaOXKVhEZkSgQ9Pt6XKfF8Xh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290124

Use dev_err_probe() in the probe() path. While at it, made some simple
improvements:
 * Declare a struct device *dev helper. This also makes the style more
   consistent (some places the helper was used and not in other places);
 * Explicitly included the err.h and errno.h headers;
 * Removed an useless else if();
 * Removed some unnecessary line breaks.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 262 ++++++++++++++++++--------------------
 1 file changed, 122 insertions(+), 140 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 3c4524d57b8e..592887097117 100644
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
@@ -206,6 +208,13 @@ enum {
 #define to_temp(_sensor) \
 		container_of(_sensor, struct ltc2983_temp, sensor)
 
+/* Helper macro for returning error pointers in probe() paths. */
+#define ltc2983_errp_probe(dev, ret, fmt, ...)	({			\
+	int ___ret = dev_err_probe(dev, ret, fmt, ##__VA_ARGS__);	\
+									\
+	ERR_PTR(___ret);						\
+})
+
 struct ltc2983_chip_info {
 	const char *name;
 	unsigned int max_channels_nr;
@@ -657,10 +666,11 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 			 const struct ltc2983_sensor *sensor)
 {
 	struct ltc2983_thermocouple *thermo;
+	struct device *dev = &st->spi->dev;
 	u32 oc_current;
 	int ret;
 
-	thermo = devm_kzalloc(&st->spi->dev, sizeof(*thermo), GFP_KERNEL);
+	thermo = devm_kzalloc(dev, sizeof(*thermo), GFP_KERNEL);
 	if (!thermo)
 		return ERR_PTR(-ENOMEM);
 
@@ -687,21 +697,19 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 					LTC2983_THERMOCOUPLE_OC_CURR(3);
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid open circuit current:%u", oc_current);
-			return ERR_PTR(-EINVAL);
+			return ltc2983_errp_probe(dev, -EINVAL,
+						  "Invalid open circuit current:%u",
+						  oc_current);
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
+		return ltc2983_errp_probe(dev, -EINVAL,
+					  "Invalid chann:%d for differential thermocouple",
+					  sensor->chan);
 
 	struct fwnode_handle *ref __free(fwnode_handle) =
 		fwnode_find_reference(child, "adi,cold-junction-handle", 0);
@@ -709,14 +717,13 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
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
+			return ltc2983_errp_probe(dev, ret,
+						  "Property reg must be given\n");
 	}
 
 	/* check custom sensor */
@@ -752,16 +759,14 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 
 	struct fwnode_handle *ref __free(fwnode_handle) =
 		fwnode_find_reference(child, "adi,rsense-handle", 0);
-	if (IS_ERR(ref)) {
-		dev_err(dev, "Property adi,rsense-handle missing or invalid");
-		return ERR_CAST(ref);
-	}
+	if (IS_ERR(ref))
+		return ltc2983_errp_probe(dev, PTR_ERR(ref),
+					  "Property adi,rsense-handle missing or invalid");
 
 	ret = fwnode_property_read_u32(ref, "reg", &rtd->r_sense_chan);
-	if (ret) {
-		dev_err(dev, "Property reg must be given\n");
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		return ltc2983_errp_probe(dev, ret,
+					  "Property reg must be given\n");
 
 	ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
 	if (!ret) {
@@ -780,19 +785,19 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			rtd->sensor_config = LTC2983_RTD_N_WIRES(3);
 			break;
 		default:
-			dev_err(dev, "Invalid number of wires:%u\n", n_wires);
-			return ERR_PTR(-EINVAL);
+			return ltc2983_errp_probe(dev, -EINVAL,
+						  "Invalid number of wires:%u\n",
+						  n_wires);
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
+				return ltc2983_errp_probe(dev, -EINVAL,
+							  "Rotation not allowed for 2/3 Wire RTDs");
+
 			rtd->sensor_config |= LTC2983_RTD_C_ROTATE(1);
 		} else {
 			rtd->sensor_config |= LTC2983_RTD_R_SHARE(1);
@@ -815,29 +820,22 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 
 		if (((rtd->sensor_config & LTC2983_RTD_KELVIN_R_SENSE_MASK)
 		     == LTC2983_RTD_KELVIN_R_SENSE_MASK) &&
-		    (rtd->r_sense_chan <=  min)) {
+		    (rtd->r_sense_chan <=  min))
 			/* kelvin rsense*/
-			dev_err(dev,
-				"Invalid rsense chann:%d to use in kelvin rsense",
-				rtd->r_sense_chan);
+			return ltc2983_errp_probe(dev, -EINVAL,
+						  "Invalid rsense chann:%d to use in kelvin rsense",
+						  rtd->r_sense_chan);
 
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
+			return ltc2983_errp_probe(dev, -EINVAL,
+						  "Invalid chann:%d for the rtd config",
+						  sensor->chan);
 	} else {
 		/* same as differential case */
-		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-			dev_err(&st->spi->dev,
-				"Invalid chann:%d for RTD", sensor->chan);
-
-			return ERR_PTR(-EINVAL);
-		}
+		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+			return ltc2983_errp_probe(dev, -EINVAL,
+						  "Invalid chann:%d for RTD",
+						  sensor->chan);
 	}
 
 	/* check custom sensor */
@@ -885,10 +883,9 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			rtd->excitation_current = 0x08;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
-			return ERR_PTR(-EINVAL);
+			return ltc2983_errp_probe(dev, -EINVAL,
+						  "Invalid value for excitation current(%u)",
+						  excitation_current);
 		}
 	}
 
@@ -912,16 +909,14 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 
 	struct fwnode_handle *ref __free(fwnode_handle) =
 		fwnode_find_reference(child, "adi,rsense-handle", 0);
-	if (IS_ERR(ref)) {
-		dev_err(dev, "Property adi,rsense-handle missing or invalid");
-		return ERR_CAST(ref);
-	}
+	if (IS_ERR(ref))
+		return ltc2983_errp_probe(dev, PTR_ERR(ref),
+					  "Property adi,rsense-handle missing or invalid");
 
 	ret = fwnode_property_read_u32(ref, "reg", &thermistor->r_sense_chan);
-	if (ret) {
-		dev_err(dev, "rsense channel must be configured...\n");
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		return ltc2983_errp_probe(dev, ret,
+					  "rsense channel must be configured...\n");
 
 	if (fwnode_property_read_bool(child, "adi,single-ended")) {
 		thermistor->sensor_config = LTC2983_THERMISTOR_SGL(1);
@@ -936,12 +931,10 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
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
+		return ltc2983_errp_probe(dev, -EINVAL,
+					  "Invalid chann:%d for differential thermistor",
+					  sensor->chan);
 
 	/* check custom sensor */
 	if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART) {
@@ -980,12 +973,10 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
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
+				return ltc2983_errp_probe(dev, -EINVAL,
+							  "Auto Range not allowed for custom sensors\n");
+
 			thermistor->excitation_current = 0x0c;
 			break;
 		case 250:
@@ -1022,10 +1013,9 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 			thermistor->excitation_current = 0x0b;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
-			return ERR_PTR(-EINVAL);
+			return ltc2983_errp_probe(dev, -EINVAL,
+						  "Invalid value for excitation current(%u)",
+						  excitation_current);
 		}
 	}
 
@@ -1036,11 +1026,12 @@ static struct ltc2983_sensor *
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
 
@@ -1055,12 +1046,11 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 
 	/* validate channel index */
 	if (!(diode->sensor_config & LTC2983_DIODE_DIFF_MASK) &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev,
-			"Invalid chann:%d for differential thermistor",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return ltc2983_errp_probe(dev, -EINVAL,
+					  "Invalid chann:%d for differential thermistor",
+					  sensor->chan);
+
 	/* set common parameters */
 	diode->sensor.fault_handler = ltc2983_common_fault_handler;
 	diode->sensor.assign_chan = ltc2983_diode_assign_chan;
@@ -1082,10 +1072,9 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 			diode->excitation_current = 0x03;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
-			return ERR_PTR(-EINVAL);
+			return ltc2983_errp_probe(dev, -EINVAL,
+						  "Invalid value for excitation current(%u)",
+						  excitation_current);
 		}
 	}
 
@@ -1101,26 +1090,26 @@ static struct ltc2983_sensor *ltc2983_r_sense_new(struct fwnode_handle *child,
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
-	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chann:%d for r_sense",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return ltc2983_errp_probe(dev, -EINVAL,
+					  "Invalid chann:%d for r_sense",
+					  sensor->chan);
 
 	ret = fwnode_property_read_u32(child, "adi,rsense-val-milli-ohms", &temp);
-	if (ret) {
-		dev_err(&st->spi->dev, "Property adi,rsense-val-milli-ohms missing\n");
-		return ERR_PTR(-EINVAL);
-	}
+	if (ret)
+		return ltc2983_errp_probe(dev, -EINVAL,
+					  "Property adi,rsense-val-milli-ohms missing\n");
+
 	/*
 	 * Times 1000 because we have milli-ohms and __convert_to_raw
 	 * expects scales of 1000000 which are used for all other
@@ -1139,21 +1128,21 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 					 struct ltc2983_data *st,
 					 const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_adc *adc;
 
-	adc = devm_kzalloc(&st->spi->dev, sizeof(*adc), GFP_KERNEL);
+	adc = devm_kzalloc(dev, sizeof(*adc), GFP_KERNEL);
 	if (!adc)
 		return ERR_PTR(-ENOMEM);
 
 	if (fwnode_property_read_bool(child, "adi,single-ended"))
 		adc->single_ended = true;
 
-	if (!adc->single_ended &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chan:%d for differential adc\n",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	if (!adc->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return ltc2983_errp_probe(dev, -EINVAL,
+					  "Invalid chan:%d for differential adc\n",
+					  sensor->chan);
+
 	/* set common parameters */
 	adc->sensor.assign_chan = ltc2983_adc_assign_chan;
 	adc->sensor.fault_handler = ltc2983_common_fault_handler;
@@ -1165,21 +1154,20 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 					       struct ltc2983_data *st,
 					       const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_temp *temp;
 
-	temp = devm_kzalloc(&st->spi->dev, sizeof(*temp), GFP_KERNEL);
+	temp = devm_kzalloc(dev, sizeof(*temp), GFP_KERNEL);
 	if (!temp)
 		return ERR_PTR(-ENOMEM);
 
 	if (fwnode_property_read_bool(child, "adi,single-ended"))
 		temp->single_ended = true;
 
-	if (!temp->single_ended &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chan:%d for differential temp\n",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	if (!temp->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return ltc2983_errp_probe(dev, -EINVAL,
+					  "Invalid chan:%d for differential temp\n",
+					  sensor->chan);
 
 	temp->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-temp",
 						   false, 4096, true);
@@ -1329,10 +1317,9 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
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
@@ -1419,6 +1406,7 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 			      unsigned int wait_time, unsigned int status_reg,
 			      unsigned long status_fail_mask)
 {
+	struct device *dev = &st->spi->dev;
 	unsigned long time;
 	unsigned int val;
 	int ret;
@@ -1437,19 +1425,16 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 
 	time = wait_for_completion_timeout(&st->completion,
 					   msecs_to_jiffies(wait_time));
-	if (!time) {
-		dev_err(&st->spi->dev, "EEPROM command timed out\n");
-		return -ETIMEDOUT;
-	}
+	if (!time)
+		return dev_err_probe(dev, -ETIMEDOUT, "EEPROM command timed out\n");
 
 	ret = regmap_read(st->regmap, status_reg, &val);
 	if (ret)
 		return ret;
 
-	if (val & status_fail_mask) {
-		dev_err(&st->spi->dev, "EEPROM command failed: 0x%02X\n", val);
-		return -EINVAL;
-	}
+	if (val & status_fail_mask)
+		return dev_err_probe(dev, -EINVAL,
+				     "EEPROM command failed: 0x%02X\n", val);
 
 	return 0;
 }
@@ -1457,16 +1442,15 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 {
 	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
 	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
 	ret = regmap_read_poll_timeout(st->regmap, LTC2983_STATUS_REG, status,
 				       LTC2983_STATUS_UP(status) == 1, 25000,
 				       25000 * 10);
-	if (ret) {
-		dev_err(&st->spi->dev, "Device startup timed out\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Device startup timed out\n");
 
 	ret = regmap_update_bits(st->regmap, LTC2983_GLOBAL_CONFIG_REG,
 				 LTC2983_NOTCH_FREQ_MASK,
@@ -1566,12 +1550,13 @@ static const struct  iio_info ltc2983_iio_info = {
 
 static int ltc2983_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct ltc2983_data *st;
 	struct iio_dev *indio_dev;
 	struct gpio_desc *gpio;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1582,10 +1567,9 @@ static int ltc2983_probe(struct spi_device *spi)
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
@@ -1597,7 +1581,7 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	gpio = devm_gpiod_get_optional(&st->spi->dev, "reset", GPIOD_OUT_HIGH);
+	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
@@ -1607,7 +1591,7 @@ static int ltc2983_probe(struct spi_device *spi)
 		gpiod_set_value_cansleep(gpio, 0);
 	}
 
-	st->iio_chan = devm_kzalloc(&spi->dev,
+	st->iio_chan = devm_kzalloc(dev,
 				    st->iio_channels * sizeof(*st->iio_chan),
 				    GFP_KERNEL);
 	if (!st->iio_chan)
@@ -1617,12 +1601,10 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(&spi->dev, spi->irq, ltc2983_irq_handler,
+	ret = devm_request_irq(dev, spi->irq, ltc2983_irq_handler,
 			       IRQF_TRIGGER_RISING, st->info->name, st);
-	if (ret) {
-		dev_err(&spi->dev, "failed to request an irq, %d", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request an irq\n");
 
 	if (st->info->has_eeprom) {
 		ret = ltc2983_eeprom_cmd(st, LTC2983_EEPROM_WRITE_CMD,
@@ -1639,7 +1621,7 @@ static int ltc2983_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ltc2983_iio_info;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int ltc2983_resume(struct device *dev)

-- 
2.44.0



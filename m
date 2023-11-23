Return-Path: <linux-iio+bounces-295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 457E67F643E
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 17:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0C7B20FCA
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 16:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD8A35EE8;
	Thu, 23 Nov 2023 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1960B0;
	Thu, 23 Nov 2023 08:42:32 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ANFuJfM024636;
	Thu, 23 Nov 2023 11:42:19 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ueu27e3g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 11:42:19 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3ANGgHVi054285
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Nov 2023 11:42:17 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 23 Nov
 2023 11:42:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 23 Nov 2023 11:42:16 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ANGg1f2019831;
	Thu, 23 Nov 2023 11:42:03 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <paul.cercueil@analog.com>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: Marcelo Schmitt <marcelo.schmitt@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/7] iio: adc: ad7091r: Alloc IIO device before generic probe
Date: Thu, 23 Nov 2023 13:41:59 -0300
Message-ID: <0a648afb9a06471380a7993b20cb44a9026c8248.1700751907.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: JdG9Qju6YOo1hM2678gU_ELGZ3k1bmVJ
X-Proofpoint-GUID: JdG9Qju6YOo1hM2678gU_ELGZ3k1bmVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311060001 definitions=main-2311230122

Rework ad7091r probe functions so the IIO device is allocated before
the generic device probe function is called.
This change is needed for a follow up patch that passes a pointer to the
IIO device to a couple of regmap callback functions.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/iio/adc/ad7091r-base.c | 35 +++++++---------------------------
 drivers/iio/adc/ad7091r-base.h | 22 +++++++++++++++++----
 drivers/iio/adc/ad7091r5.c     | 14 ++++++++++++--
 3 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 1d84a57720ca..c752cd2283e6 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -27,21 +27,6 @@
 #define AD7091R_REG_CONF_MODE_MASK  \
 	(AD7091R_REG_CONF_AUTO | AD7091R_REG_CONF_CMD)
 
-enum ad7091r_mode {
-	AD7091R_MODE_SAMPLE,
-	AD7091R_MODE_COMMAND,
-	AD7091R_MODE_AUTOCYCLE,
-};
-
-struct ad7091r_state {
-	struct device *dev;
-	struct regmap *map;
-	struct regulator *vref;
-	const struct ad7091r_chip_info *chip_info;
-	enum ad7091r_mode mode;
-	struct mutex lock; /*lock to prevent concurent reads */
-};
-
 const struct iio_event_spec ad7091r_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -221,20 +206,14 @@ static void ad7091r_remove(void *data)
 	regulator_disable(st->vref);
 }
 
-int ad7091r_probe(struct device *dev, const char *name,
-		const struct ad7091r_chip_info *chip_info,
-		struct regmap *map, int irq)
+int ad7091r_probe(struct iio_dev *iio_dev, const char *name,
+		  const struct ad7091r_chip_info *chip_info,
+		  struct regmap *map, int irq)
 {
-	struct iio_dev *iio_dev;
 	struct ad7091r_state *st;
 	int ret;
 
-	iio_dev = devm_iio_device_alloc(dev, sizeof(*st));
-	if (!iio_dev)
-		return -ENOMEM;
-
 	st = iio_priv(iio_dev);
-	st->dev = dev;
 	st->chip_info = chip_info;
 	st->map = map;
 
@@ -252,7 +231,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 			return ret;
 
 		dev_set_drvdata(st->dev, iio_dev);
-		ret = devm_request_threaded_irq(dev, irq, NULL,
+		ret = devm_request_threaded_irq(st->dev, irq, NULL,
 						ad7091r_event_handler,
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT, name, st);
@@ -260,7 +239,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 			return ret;
 	}
 
-	st->vref = devm_regulator_get_optional(dev, "vref");
+	st->vref = devm_regulator_get_optional(st->dev, "vref");
 	if (IS_ERR(st->vref)) {
 		if (PTR_ERR(st->vref) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
@@ -269,7 +248,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 		ret = regulator_enable(st->vref);
 		if (ret)
 			return ret;
-		ret = devm_add_action_or_reset(dev, ad7091r_remove, st);
+		ret = devm_add_action_or_reset(st->dev, ad7091r_remove, st);
 		if (ret)
 			return ret;
 	}
@@ -279,7 +258,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(dev, iio_dev);
+	return devm_iio_device_register(st->dev, iio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad7091r_probe, IIO_AD7091R);
 
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 6ff539cd1d39..6997ea11998b 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -30,7 +30,21 @@
 }
 
 struct device;
-struct ad7091r_state;
+
+enum ad7091r_mode {
+	AD7091R_MODE_SAMPLE,
+	AD7091R_MODE_COMMAND,
+	AD7091R_MODE_AUTOCYCLE,
+};
+
+struct ad7091r_state {
+	struct device *dev;
+	struct regmap *map;
+	struct regulator *vref;
+	const struct ad7091r_chip_info *chip_info;
+	enum ad7091r_mode mode;
+	struct mutex lock; /*lock to prevent concurent reads */
+};
 
 struct ad7091r_chip_info {
 	unsigned int num_channels;
@@ -42,9 +56,9 @@ extern const struct iio_event_spec ad7091r_events[3];
 
 extern const struct regmap_config ad7091r_regmap_config;
 
-int ad7091r_probe(struct device *dev, const char *name,
-		const struct ad7091r_chip_info *chip_info,
-		struct regmap *map, int irq);
+int ad7091r_probe(struct iio_dev *iio_dev, const char *name,
+		  const struct ad7091r_chip_info *chip_info,
+		  struct regmap *map, int irq);
 
 bool ad7091r_volatile_reg(struct device *dev, unsigned int reg);
 
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 9d3ccfca94ec..1a27841d1bbc 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -42,8 +42,18 @@ static int ad7091r5_i2c_probe(struct i2c_client *i2c)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	const struct ad7091r_chip_info *chip_info;
-	struct regmap *map = devm_regmap_init_i2c(i2c, &ad7091r_regmap_config);
+	struct ad7091r_state *st;
+	struct iio_dev *iio_dev;
+	struct regmap *map;
 
+	iio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*st));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(iio_dev);
+	st->dev = &i2c->dev;
+
+	map = devm_regmap_init_i2c(i2c, &ad7091r_regmap_config);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
@@ -52,7 +62,7 @@ static int ad7091r5_i2c_probe(struct i2c_client *i2c)
 	else
 		chip_info = &ad7091r5_chip_info_noirq;
 
-	return ad7091r_probe(&i2c->dev, id->name, chip_info, map, i2c->irq);
+	return ad7091r_probe(iio_dev, id->name, chip_info, map, i2c->irq);
 }
 
 static const struct of_device_id ad7091r5_dt_ids[] = {
-- 
2.42.0



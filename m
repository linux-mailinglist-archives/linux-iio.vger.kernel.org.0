Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9865761A0
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jul 2022 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiGOMav (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jul 2022 08:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiGOMau (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2022 08:30:50 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249B459244
        for <linux-iio@vger.kernel.org>; Fri, 15 Jul 2022 05:30:49 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FBsOlT026930;
        Fri, 15 Jul 2022 08:29:58 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h9r37te8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 08:29:58 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 26FCTvHs061384
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jul 2022 08:29:57 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 15 Jul
 2022 08:29:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 15 Jul 2022 08:29:56 -0400
Received: from nsa.ad.analog.com ([10.44.3.55])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26FCRxO7001007;
        Fri, 15 Jul 2022 08:29:47 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <openbmc@lists.ozlabs.org>, <linux-imx@nxp.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-iio@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <chrome-platform@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-arm-msm@vger.kernel.org>
CC:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Fair <benjaminfair@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Patrick Venture <venture@google.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Nancy Yuen <yuenn@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Avi Fishman <avifishman70@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [PATCH v3 11/15] iio: adc: qcom-spmi-vadc: convert to device properties
Date:   Fri, 15 Jul 2022 14:28:59 +0200
Message-ID: <20220715122903.332535-12-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220715122903.332535-1-nuno.sa@analog.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: MVmGb0whldOE-JyoxEj31jVVL1mFsBM3
X-Proofpoint-ORIG-GUID: MVmGb0whldOE-JyoxEj31jVVL1mFsBM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_04,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150054
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make the conversion to firmware agnostic device properties. As part of
the conversion the IIO inkern interface 'of_xlate()' is also converted to
'fwnode_xlate()'. The goal is to completely drop 'of_xlate' and hence OF
dependencies from IIO.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 44 ++++++++++++++++----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 34202ba52469..bcff0f62b70e 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -13,8 +13,9 @@
 #include <linux/kernel.h>
 #include <linux/math64.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/log2.h>
@@ -481,8 +482,8 @@ static int vadc_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int vadc_of_xlate(struct iio_dev *indio_dev,
-			 const struct of_phandle_args *iiospec)
+static int vadc_fwnode_xlate(struct iio_dev *indio_dev,
+			     const struct fwnode_reference_args *iiospec)
 {
 	struct vadc_priv *vadc = iio_priv(indio_dev);
 	unsigned int i;
@@ -496,7 +497,7 @@ static int vadc_of_xlate(struct iio_dev *indio_dev,
 
 static const struct iio_info vadc_info = {
 	.read_raw = vadc_read_raw,
-	.of_xlate = vadc_of_xlate,
+	.fwnode_xlate = vadc_fwnode_xlate,
 };
 
 struct vadc_channels {
@@ -647,15 +648,15 @@ static const struct vadc_channels vadc_chans[] = {
 	VADC_CHAN_NO_SCALE(LR_MUX3_BUF_PU1_PU2_XO_THERM, 0)
 };
 
-static int vadc_get_dt_channel_data(struct device *dev,
+static int vadc_get_fw_channel_data(struct device *dev,
 				    struct vadc_channel_prop *prop,
-				    struct device_node *node)
+				    struct fwnode_handle *fwnode)
 {
-	const char *name = node->name;
+	const char *name = fwnode_get_name(fwnode);
 	u32 chan, value, varr[2];
 	int ret;
 
-	ret = of_property_read_u32(node, "reg", &chan);
+	ret = fwnode_property_read_u32(fwnode, "reg", &chan);
 	if (ret) {
 		dev_err(dev, "invalid channel number %s\n", name);
 		return ret;
@@ -669,7 +670,7 @@ static int vadc_get_dt_channel_data(struct device *dev,
 	/* the channel has DT description */
 	prop->channel = chan;
 
-	ret = of_property_read_u32(node, "qcom,decimation", &value);
+	ret = fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
 	if (!ret) {
 		ret = qcom_vadc_decimation_from_dt(value);
 		if (ret < 0) {
@@ -682,7 +683,7 @@ static int vadc_get_dt_channel_data(struct device *dev,
 		prop->decimation = VADC_DEF_DECIMATION;
 	}
 
-	ret = of_property_read_u32_array(node, "qcom,pre-scaling", varr, 2);
+	ret = fwnode_property_read_u32_array(fwnode, "qcom,pre-scaling", varr, 2);
 	if (!ret) {
 		ret = vadc_prescaling_from_dt(varr[0], varr[1]);
 		if (ret < 0) {
@@ -695,7 +696,7 @@ static int vadc_get_dt_channel_data(struct device *dev,
 		prop->prescale = vadc_chans[prop->channel].prescale_index;
 	}
 
-	ret = of_property_read_u32(node, "qcom,hw-settle-time", &value);
+	ret = fwnode_property_read_u32(fwnode, "qcom,hw-settle-time", &value);
 	if (!ret) {
 		ret = vadc_hw_settle_time_from_dt(value);
 		if (ret < 0) {
@@ -708,7 +709,7 @@ static int vadc_get_dt_channel_data(struct device *dev,
 		prop->hw_settle_time = VADC_DEF_HW_SETTLE_TIME;
 	}
 
-	ret = of_property_read_u32(node, "qcom,avg-samples", &value);
+	ret = fwnode_property_read_u32(fwnode, "qcom,avg-samples", &value);
 	if (!ret) {
 		ret = vadc_avg_samples_from_dt(value);
 		if (ret < 0) {
@@ -721,7 +722,7 @@ static int vadc_get_dt_channel_data(struct device *dev,
 		prop->avg_samples = VADC_DEF_AVG_SAMPLES;
 	}
 
-	if (of_property_read_bool(node, "qcom,ratiometric"))
+	if (fwnode_property_read_bool(fwnode, "qcom,ratiometric"))
 		prop->calibration = VADC_CALIB_RATIOMETRIC;
 	else
 		prop->calibration = VADC_CALIB_ABSOLUTE;
@@ -731,16 +732,16 @@ static int vadc_get_dt_channel_data(struct device *dev,
 	return 0;
 }
 
-static int vadc_get_dt_data(struct vadc_priv *vadc, struct device_node *node)
+static int vadc_get_fw_data(struct vadc_priv *vadc)
 {
 	const struct vadc_channels *vadc_chan;
 	struct iio_chan_spec *iio_chan;
 	struct vadc_channel_prop prop;
-	struct device_node *child;
+	struct fwnode_handle *child;
 	unsigned int index = 0;
 	int ret;
 
-	vadc->nchannels = of_get_available_child_count(node);
+	vadc->nchannels = device_get_child_node_count(vadc->dev);
 	if (!vadc->nchannels)
 		return -EINVAL;
 
@@ -756,10 +757,10 @@ static int vadc_get_dt_data(struct vadc_priv *vadc, struct device_node *node)
 
 	iio_chan = vadc->iio_chans;
 
-	for_each_available_child_of_node(node, child) {
-		ret = vadc_get_dt_channel_data(vadc->dev, &prop, child);
+	device_for_each_child_node(vadc->dev, child) {
+		ret = vadc_get_fw_channel_data(vadc->dev, &prop, child);
 		if (ret) {
-			of_node_put(child);
+			fwnode_handle_put(child);
 			return ret;
 		}
 
@@ -848,7 +849,6 @@ static int vadc_check_revision(struct vadc_priv *vadc)
 
 static int vadc_probe(struct platform_device *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct iio_dev *indio_dev;
 	struct vadc_priv *vadc;
@@ -860,7 +860,7 @@ static int vadc_probe(struct platform_device *pdev)
 	if (!regmap)
 		return -ENODEV;
 
-	ret = of_property_read_u32(node, "reg", &reg);
+	ret = device_property_read_u32(dev, "reg", &reg);
 	if (ret < 0)
 		return ret;
 
@@ -880,7 +880,7 @@ static int vadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = vadc_get_dt_data(vadc, node);
+	ret = vadc_get_fw_data(vadc);
 	if (ret)
 		return ret;
 
-- 
2.37.1


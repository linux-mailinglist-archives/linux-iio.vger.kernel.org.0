Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F3054600E
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 10:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348355AbiFJItR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 04:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348363AbiFJIs5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 04:48:57 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85154C3677;
        Fri, 10 Jun 2022 01:48:56 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25A5dbT8010601;
        Fri, 10 Jun 2022 04:48:55 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3gm00mh27f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 04:48:55 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 25A8msCW027574
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jun 2022 04:48:54 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 10 Jun 2022 04:48:53 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 10 Jun 2022 04:48:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 10 Jun 2022 04:48:53 -0400
Received: from nsa.ad.analog.com ([10.44.3.70])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 25A8imiq014275;
        Fri, 10 Jun 2022 04:48:44 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-imx@nxp.com>, <linux-renesas-soc@vger.kernel.org>,
        <linux-mips@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <chrome-platform@lists.linux.dev>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
CC:     Cai Huoqing <cai.huoqing@linux.dev>,
        Benjamin Fair <benjaminfair@google.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Nancy Yuen <yuenn@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Gwendal Grignou" <gwendal@chromium.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        "Tali Perry" <tali.perry1@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        "Lorenzo Bianconi" <lorenzo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Guenter Roeck" <groeck@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        "Olivier Moysan" <olivier.moysan@foss.st.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 30/34] iio: adc: qcom-spmi-vadc: convert to device properties
Date:   Fri, 10 Jun 2022 10:45:41 +0200
Message-ID: <20220610084545.547700-31-nuno.sa@analog.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610084545.547700-1-nuno.sa@analog.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 22N82qDX_fB9GEAylcW0NG6WBvVFVCLG
X-Proofpoint-GUID: 22N82qDX_fB9GEAylcW0NG6WBvVFVCLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_02,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100032
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
2.36.1


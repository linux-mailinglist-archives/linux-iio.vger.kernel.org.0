Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402C654605D
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 10:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343526AbiFJItl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 04:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348273AbiFJItP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 04:49:15 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F5999809;
        Fri, 10 Jun 2022 01:49:13 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25A7SjCp005350;
        Fri, 10 Jun 2022 04:49:13 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ghq33kqem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 04:49:13 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 25A8nCMi023344
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jun 2022 04:49:12 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 10 Jun
 2022 04:49:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 10 Jun 2022 04:49:08 -0400
Received: from nsa.ad.analog.com ([10.44.3.70])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 25A8imis014275;
        Fri, 10 Jun 2022 04:48:57 -0400
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
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Nancy Yuen <yuenn@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 32/34] iio: adc: stm32-adc: convert to device properties
Date:   Fri, 10 Jun 2022 10:45:43 +0200
Message-ID: <20220610084545.547700-33-nuno.sa@analog.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610084545.547700-1-nuno.sa@analog.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: _T5ULNt7aIz7kEBK-I7icaSifMJ0z1zY
X-Proofpoint-GUID: _T5ULNt7aIz7kEBK-I7icaSifMJ0z1zY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_02,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 drivers/iio/adc/stm32-adc.c | 128 ++++++++++++++++++++----------------
 1 file changed, 70 insertions(+), 58 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index a68ecbda6480..87acef31ace1 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -21,11 +21,11 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/property.h>
 
 #include "stm32-adc-core.h"
 
@@ -1524,8 +1524,8 @@ static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int stm32_adc_of_xlate(struct iio_dev *indio_dev,
-			      const struct of_phandle_args *iiospec)
+static int stm32_adc_fwnode_xlate(struct iio_dev *indio_dev,
+				  const struct fwnode_reference_args *iiospec)
 {
 	int i;
 
@@ -1579,7 +1579,7 @@ static const struct iio_info stm32_adc_iio_info = {
 	.hwfifo_set_watermark = stm32_adc_set_watermark,
 	.update_scan_mode = stm32_adc_update_scan_mode,
 	.debugfs_reg_access = stm32_adc_debugfs_reg_access,
-	.of_xlate = stm32_adc_of_xlate,
+	.fwnode_xlate = stm32_adc_fwnode_xlate,
 };
 
 static unsigned int stm32_adc_dma_residue(struct stm32_adc *adc)
@@ -1776,14 +1776,14 @@ static const struct iio_chan_spec_ext_info stm32_adc_ext_info[] = {
 	{},
 };
 
-static int stm32_adc_of_get_resolution(struct iio_dev *indio_dev)
+static int stm32_adc_fw_get_resolution(struct iio_dev *indio_dev)
 {
-	struct device_node *node = indio_dev->dev.of_node;
+	struct device *dev = &indio_dev->dev;
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	unsigned int i;
 	u32 res;
 
-	if (of_property_read_u32(node, "assigned-resolution-bits", &res))
+	if (device_property_read_u32(dev, "assigned-resolution-bits", &res))
 		res = adc->cfg->adc_info->resolutions[0];
 
 	for (i = 0; i < adc->cfg->adc_info->num_res; i++)
@@ -1867,11 +1867,11 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 
 static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm32_adc *adc)
 {
-	struct device_node *node = indio_dev->dev.of_node;
+	struct device *dev = &indio_dev->dev;
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
 	int num_channels = 0, ret;
 
-	ret = of_property_count_u32_elems(node, "st,adc-channels");
+	ret = device_property_count_u32(dev, "st,adc-channels");
 	if (ret > adc_info->max_channels) {
 		dev_err(&indio_dev->dev, "Bad st,adc-channels?\n");
 		return -EINVAL;
@@ -1879,18 +1879,17 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
 		num_channels += ret;
 	}
 
-	ret = of_property_count_elems_of_size(node, "st,adc-diff-channels",
-					      sizeof(struct stm32_adc_diff_channel));
-	if (ret > adc_info->max_channels) {
+	ret = device_property_count_u32(dev, "st,adc-diff-channels");
+	if ((ret / 2) > adc_info->max_channels) {
 		dev_err(&indio_dev->dev, "Bad st,adc-diff-channels?\n");
 		return -EINVAL;
-	} else if (ret > 0) {
-		adc->num_diff = ret;
-		num_channels += ret;
+	} else if ((ret / 2) > 0) {
+		adc->num_diff = ret / 2;
+		num_channels += ret / 2;
 	}
 
 	/* Optional sample time is provided either for each, or all channels */
-	ret = of_property_count_u32_elems(node, "st,min-sample-time-nsecs");
+	ret = device_property_count_u32(dev, "st,min-sample-time-nsecs");
 	if (ret > 1 && ret != num_channels) {
 		dev_err(&indio_dev->dev, "Invalid st,min-sample-time-nsecs\n");
 		return -EINVAL;
@@ -1901,21 +1900,20 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
 
 static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
 				      struct stm32_adc *adc,
-				      struct iio_chan_spec *channels)
+				      struct iio_chan_spec *channels,
+				      int nchans)
 {
-	struct device_node *node = indio_dev->dev.of_node;
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
 	struct stm32_adc_diff_channel diff[STM32_ADC_CH_MAX];
+	struct device *dev = &indio_dev->dev;
 	u32 num_diff = adc->num_diff;
 	int size = num_diff * sizeof(*diff) / sizeof(u32);
-	int scan_index = 0, val, ret, i;
-	struct property *prop;
-	const __be32 *cur;
-	u32 smp = 0;
+	int scan_index = 0, ret, i;
+	u32 smp = 0, nsmps, smps[STM32_ADC_CH_MAX], chans[STM32_ADC_CH_MAX];
 
 	if (num_diff) {
-		ret = of_property_read_u32_array(node, "st,adc-diff-channels",
-						 (u32 *)diff, size);
+		ret = device_property_read_u32_array(dev, "st,adc-diff-channels",
+						     (u32 *)diff, size);
 		if (ret) {
 			dev_err(&indio_dev->dev, "Failed to get diff channels %d\n", ret);
 			return ret;
@@ -1936,32 +1934,51 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
 		}
 	}
 
-	of_property_for_each_u32(node, "st,adc-channels", prop, cur, val) {
-		if (val >= adc_info->max_channels) {
-			dev_err(&indio_dev->dev, "Invalid channel %d\n", val);
+	ret = device_property_read_u32_array(dev, "st,adc-channels", chans,
+					     nchans);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nchans; i++) {
+		if (chans[i] >= adc_info->max_channels) {
+			dev_err(&indio_dev->dev, "Invalid channel %d\n",
+				chans[i]);
 			return -EINVAL;
 		}
 
 		/* Channel can't be configured both as single-ended & diff */
 		for (i = 0; i < num_diff; i++) {
-			if (val == diff[i].vinp) {
-				dev_err(&indio_dev->dev, "channel %d misconfigured\n",	val);
+			if (chans[i] == diff[i].vinp) {
+				dev_err(&indio_dev->dev, "channel %d misconfigured\n",	chans[i]);
 				return -EINVAL;
 			}
 		}
-		stm32_adc_chan_init_one(indio_dev, &channels[scan_index], val,
-					0, scan_index, false);
+		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
+					chans[i], 0, scan_index, false);
 		scan_index++;
 	}
 
+	nsmps = device_property_count_u32(dev, "st,min-sample-time-nsecs");
+	if (nsmps) {
+		if (nsmps >= nchans)
+			nsmps = nchans;
+
+		ret = device_property_read_u32_array(dev, "st,min-sample-time-nsecs",
+						     smps, nsmps);
+		if (ret)
+			return ret;
+	}
+
 	for (i = 0; i < scan_index; i++) {
 		/*
-		 * Using of_property_read_u32_index(), smp value will only be
-		 * modified if valid u32 value can be decoded. This allows to
-		 * get either no value, 1 shared value for all indexes, or one
-		 * value per channel.
+		 * This check is used with the above logic so that smp value
+		 * will only be modified if valid u32 value can be decoded. This
+		 * allows to get either no value, 1 shared value for all indexes,
+		 * or one value per channel. The point is to have the same
+		 * behavior as 'of_property_read_u32_index()'.
 		 */
-		of_property_read_u32_index(node, "st,min-sample-time-nsecs", i, &smp);
+		if (i < nsmps)
+			smp = smps[i];
 
 		/* Prepare sampling time settings */
 		stm32_adc_smpr_init(adc, channels[i].channel, smp);
@@ -2004,22 +2021,21 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 				       struct stm32_adc *adc,
 				       struct iio_chan_spec *channels)
 {
-	struct device_node *node = indio_dev->dev.of_node;
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
-	struct device_node *child;
+	struct fwnode_handle *child;
 	const char *name;
 	int val, scan_index = 0, ret;
 	bool differential;
 	u32 vin[2];
 
-	for_each_available_child_of_node(node, child) {
-		ret = of_property_read_u32(child, "reg", &val);
+	device_for_each_child_node(&indio_dev->dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &val);
 		if (ret) {
 			dev_err(&indio_dev->dev, "Missing channel index %d\n", ret);
 			goto err;
 		}
 
-		ret = of_property_read_string(child, "label", &name);
+		ret = fwnode_property_read_string(child, "label", &name);
 		/* label is optional */
 		if (!ret) {
 			if (strlen(name) >= STM32_ADC_CH_SZ) {
@@ -2044,7 +2060,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 		}
 
 		differential = false;
-		ret = of_property_read_u32_array(child, "diff-channels", vin, 2);
+		ret = fwnode_property_read_u32_array(child, "diff-channels", vin, 2);
 		/* diff-channels is optional */
 		if (!ret) {
 			differential = true;
@@ -2061,7 +2077,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 		stm32_adc_chan_init_one(indio_dev, &channels[scan_index], val,
 					vin[1], scan_index, differential);
 
-		ret = of_property_read_u32(child, "st,min-sample-time-ns", &val);
+		ret = fwnode_property_read_u32(child, "st,min-sample-time-ns", &val);
 		/* st,min-sample-time-ns is optional */
 		if (!ret) {
 			stm32_adc_smpr_init(adc, channels[scan_index].channel, val);
@@ -2079,14 +2095,13 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 	return scan_index;
 
 err:
-	of_node_put(child);
+	fwnode_handle_put(child);
 
 	return ret;
 }
 
-static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
+static int stm32_adc_chan_fw_init(struct iio_dev *indio_dev, bool timestamping)
 {
-	struct device_node *node = indio_dev->dev.of_node;
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
 	struct iio_chan_spec *channels;
@@ -2096,7 +2111,7 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
 	for (i = 0; i < STM32_ADC_INT_CH_NB; i++)
 		adc->int_ch[i] = STM32_ADC_INT_CH_NONE;
 
-	num_channels = of_get_available_child_count(node);
+	num_channels = device_get_child_node_count(&indio_dev->dev);
 	/* If no channels have been found, fallback to channels legacy properties. */
 	if (!num_channels) {
 		legacy = true;
@@ -2127,7 +2142,8 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
 		return -ENOMEM;
 
 	if (legacy)
-		ret = stm32_adc_legacy_chan_init(indio_dev, adc, channels);
+		ret = stm32_adc_legacy_chan_init(indio_dev, adc, channels,
+						 num_channels);
 	else
 		ret = stm32_adc_generic_chan_init(indio_dev, adc, channels);
 	if (ret < 0)
@@ -2209,9 +2225,6 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	bool timestamping = false;
 	int ret;
 
-	if (!pdev->dev.of_node)
-		return -ENODEV;
-
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -2220,17 +2233,16 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	adc->common = dev_get_drvdata(pdev->dev.parent);
 	spin_lock_init(&adc->lock);
 	init_completion(&adc->completion);
-	adc->cfg = (const struct stm32_adc_cfg *)
-		of_match_device(dev->driver->of_match_table, dev)->data;
+	adc->cfg = device_get_match_data(dev);
 
 	indio_dev->name = dev_name(&pdev->dev);
-	indio_dev->dev.of_node = pdev->dev.of_node;
+	device_set_node(&indio_dev->dev, dev_fwnode(&pdev->dev));
 	indio_dev->info = &stm32_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	ret = of_property_read_u32(pdev->dev.of_node, "reg", &adc->offset);
+	ret = device_property_read_u32(dev, "reg", &adc->offset);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "missing reg property\n");
 		return -EINVAL;
@@ -2259,7 +2271,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = stm32_adc_of_get_resolution(indio_dev);
+	ret = stm32_adc_fw_get_resolution(indio_dev);
 	if (ret < 0)
 		return ret;
 
@@ -2276,7 +2288,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		timestamping = true;
 	}
 
-	ret = stm32_adc_chan_of_init(indio_dev, timestamping);
+	ret = stm32_adc_chan_fw_init(indio_dev, timestamping);
 	if (ret < 0)
 		goto err_dma_disable;
 
-- 
2.36.1


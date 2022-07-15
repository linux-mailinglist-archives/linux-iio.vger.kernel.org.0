Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4E05761AB
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jul 2022 14:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiGOMbM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jul 2022 08:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiGOMbL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2022 08:31:11 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8E913D65
        for <linux-iio@vger.kernel.org>; Fri, 15 Jul 2022 05:31:10 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F9j6TZ011689;
        Fri, 15 Jul 2022 08:30:14 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h73h7c6t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 08:30:13 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 26FCUCVq062196
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jul 2022 08:30:12 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 15 Jul 2022 08:30:11 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 15 Jul 2022 08:30:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 15 Jul 2022 08:30:11 -0400
Received: from nsa.ad.analog.com ([10.44.3.55])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26FCRxO9001007;
        Fri, 15 Jul 2022 08:30:00 -0400
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
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Olivier Moysan" <olivier.moysan@foss.st.com>,
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
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Avi Fishman <avifishman70@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Haibo Chen" <haibo.chen@nxp.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [PATCH v3 13/15] iio: adc: stm32-adc: convert to device properties
Date:   Fri, 15 Jul 2022 14:29:01 +0200
Message-ID: <20220715122903.332535-14-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220715122903.332535-1-nuno.sa@analog.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: aIFsjyNkoA6L7ukwTCPEaVIZMvy70ZG_
X-Proofpoint-ORIG-GUID: aIFsjyNkoA6L7ukwTCPEaVIZMvy70ZG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_05,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150054
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/stm32-adc.c | 125 ++++++++++++++++++++----------------
 1 file changed, 70 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 3985fe972892..24248f1de1d0 100644
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
 
@@ -241,6 +241,7 @@ struct stm32_adc_cfg {
  * @chan_name:		channel name array
  * @num_diff:		number of differential channels
  * @int_ch:		internal channel indexes array
+ * @nsmps:		number of channels with optional sample time
  */
 struct stm32_adc {
 	struct stm32_adc_common	*common;
@@ -267,6 +268,7 @@ struct stm32_adc {
 	char			chan_name[STM32_ADC_CH_MAX][STM32_ADC_CH_SZ];
 	u32			num_diff;
 	int			int_ch[STM32_ADC_INT_CH_NB];
+	int			nsmps;
 };
 
 struct stm32_adc_diff_channel {
@@ -1530,8 +1532,8 @@ static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int stm32_adc_of_xlate(struct iio_dev *indio_dev,
-			      const struct of_phandle_args *iiospec)
+static int stm32_adc_fwnode_xlate(struct iio_dev *indio_dev,
+				  const struct fwnode_reference_args *iiospec)
 {
 	int i;
 
@@ -1585,7 +1587,7 @@ static const struct iio_info stm32_adc_iio_info = {
 	.hwfifo_set_watermark = stm32_adc_set_watermark,
 	.update_scan_mode = stm32_adc_update_scan_mode,
 	.debugfs_reg_access = stm32_adc_debugfs_reg_access,
-	.of_xlate = stm32_adc_of_xlate,
+	.fwnode_xlate = stm32_adc_fwnode_xlate,
 };
 
 static unsigned int stm32_adc_dma_residue(struct stm32_adc *adc)
@@ -1782,14 +1784,14 @@ static const struct iio_chan_spec_ext_info stm32_adc_ext_info[] = {
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
@@ -1873,11 +1875,11 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 
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
@@ -1885,8 +1887,12 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
 		num_channels += ret;
 	}
 
-	ret = of_property_count_elems_of_size(node, "st,adc-diff-channels",
-					      sizeof(struct stm32_adc_diff_channel));
+	/*
+	 * each st,adc-diff-channels is a group of 2 u32 so we divide @ret
+	 * to get the *real* number of channels.
+	 */
+	ret = device_property_count_u32(dev, "st,adc-diff-channels");
+	ret /= (int)(sizeof(struct stm32_adc_diff_channel) / sizeof(u32));
 	if (ret > adc_info->max_channels) {
 		dev_err(&indio_dev->dev, "Bad st,adc-diff-channels?\n");
 		return -EINVAL;
@@ -1896,8 +1902,8 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
 	}
 
 	/* Optional sample time is provided either for each, or all channels */
-	ret = of_property_count_u32_elems(node, "st,min-sample-time-nsecs");
-	if (ret > 1 && ret != num_channels) {
+	adc->nsmps = device_property_count_u32(dev, "st,min-sample-time-nsecs");
+	if (adc->nsmps > 1 && adc->nsmps != num_channels) {
 		dev_err(&indio_dev->dev, "Invalid st,min-sample-time-nsecs\n");
 		return -EINVAL;
 	}
@@ -1907,21 +1913,20 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
 
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
+	int scan_index = 0, ret, i, c;
+	u32 smp = 0, smps[STM32_ADC_CH_MAX], chans[STM32_ADC_CH_MAX];
 
 	if (num_diff) {
-		ret = of_property_read_u32_array(node, "st,adc-diff-channels",
-						 (u32 *)diff, size);
+		ret = device_property_read_u32_array(dev, "st,adc-diff-channels",
+						     (u32 *)diff, size);
 		if (ret) {
 			dev_err(&indio_dev->dev, "Failed to get diff channels %d\n", ret);
 			return ret;
@@ -1942,32 +1947,47 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
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
+	for (c = 0; c < nchans; c++) {
+		if (chans[c] >= adc_info->max_channels) {
+			dev_err(&indio_dev->dev, "Invalid channel %d\n",
+				chans[c]);
 			return -EINVAL;
 		}
 
 		/* Channel can't be configured both as single-ended & diff */
 		for (i = 0; i < num_diff; i++) {
-			if (val == diff[i].vinp) {
-				dev_err(&indio_dev->dev, "channel %d misconfigured\n",	val);
+			if (chans[c] == diff[i].vinp) {
+				dev_err(&indio_dev->dev, "channel %d misconfigured\n",	chans[c]);
 				return -EINVAL;
 			}
 		}
-		stm32_adc_chan_init_one(indio_dev, &channels[scan_index], val,
-					0, scan_index, false);
+		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
+					chans[c], 0, scan_index, false);
 		scan_index++;
 	}
 
+	if (adc->nsmps > 0) {
+		ret = device_property_read_u32_array(dev, "st,min-sample-time-nsecs",
+						     smps, adc->nsmps);
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
+		if (i < adc->nsmps)
+			smp = smps[i];
 
 		/* Prepare sampling time settings */
 		stm32_adc_smpr_init(adc, channels[i].channel, smp);
@@ -2010,22 +2030,21 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
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
@@ -2050,7 +2069,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 		}
 
 		differential = false;
-		ret = of_property_read_u32_array(child, "diff-channels", vin, 2);
+		ret = fwnode_property_read_u32_array(child, "diff-channels", vin, 2);
 		/* diff-channels is optional */
 		if (!ret) {
 			differential = true;
@@ -2067,7 +2086,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 		stm32_adc_chan_init_one(indio_dev, &channels[scan_index], val,
 					vin[1], scan_index, differential);
 
-		ret = of_property_read_u32(child, "st,min-sample-time-ns", &val);
+		ret = fwnode_property_read_u32(child, "st,min-sample-time-ns", &val);
 		/* st,min-sample-time-ns is optional */
 		if (!ret) {
 			stm32_adc_smpr_init(adc, channels[scan_index].channel, val);
@@ -2085,14 +2104,13 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
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
@@ -2102,7 +2120,7 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
 	for (i = 0; i < STM32_ADC_INT_CH_NB; i++)
 		adc->int_ch[i] = STM32_ADC_INT_CH_NONE;
 
-	num_channels = of_get_available_child_count(node);
+	num_channels = device_get_child_node_count(&indio_dev->dev);
 	/* If no channels have been found, fallback to channels legacy properties. */
 	if (!num_channels) {
 		legacy = true;
@@ -2133,7 +2151,8 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
 		return -ENOMEM;
 
 	if (legacy)
-		ret = stm32_adc_legacy_chan_init(indio_dev, adc, channels);
+		ret = stm32_adc_legacy_chan_init(indio_dev, adc, channels,
+						 num_channels);
 	else
 		ret = stm32_adc_generic_chan_init(indio_dev, adc, channels);
 	if (ret < 0)
@@ -2215,9 +2234,6 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	bool timestamping = false;
 	int ret;
 
-	if (!pdev->dev.of_node)
-		return -ENODEV;
-
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -2226,17 +2242,16 @@ static int stm32_adc_probe(struct platform_device *pdev)
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
@@ -2265,7 +2280,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = stm32_adc_of_get_resolution(indio_dev);
+	ret = stm32_adc_fw_get_resolution(indio_dev);
 	if (ret < 0)
 		return ret;
 
@@ -2282,7 +2297,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		timestamping = true;
 	}
 
-	ret = stm32_adc_chan_of_init(indio_dev, timestamping);
+	ret = stm32_adc_chan_fw_init(indio_dev, timestamping);
 	if (ret < 0)
 		goto err_dma_disable;
 
-- 
2.37.1


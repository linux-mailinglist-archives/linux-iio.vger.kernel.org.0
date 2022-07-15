Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD4757619B
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jul 2022 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiGOMai (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jul 2022 08:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbiGOMae (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2022 08:30:34 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1674025C76
        for <linux-iio@vger.kernel.org>; Fri, 15 Jul 2022 05:30:33 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FAnJfs026918;
        Fri, 15 Jul 2022 08:29:45 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h9r37te7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 08:29:45 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 26FCTiLB062178
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jul 2022 08:29:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 15 Jul
 2022 08:29:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 15 Jul 2022 08:29:43 -0400
Received: from nsa.ad.analog.com ([10.44.3.55])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26FCRxO5001007;
        Fri, 15 Jul 2022 08:29:32 -0400
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
Subject: [PATCH v3 09/15] iio: adc: at91-sama5d2_adc: convert to device properties
Date:   Fri, 15 Jul 2022 14:28:57 +0200
Message-ID: <20220715122903.332535-10-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220715122903.332535-1-nuno.sa@analog.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: m-bvaCdCSS-sjW63PCKCs13AsQvU8x8_
X-Proofpoint-ORIG-GUID: m-bvaCdCSS-sjW63PCKCs13AsQvU8x8_
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index fe3131c9593c..df716584c117 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -16,8 +16,9 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/iio/iio.h>
@@ -650,8 +651,8 @@ at91_adc_chan_get(struct iio_dev *indio_dev, int chan)
 	return indio_dev->channels + index;
 }
 
-static inline int at91_adc_of_xlate(struct iio_dev *indio_dev,
-				    const struct of_phandle_args *iiospec)
+static inline int at91_adc_fwnode_xlate(struct iio_dev *indio_dev,
+					const struct fwnode_reference_args *iiospec)
 {
 	return at91_adc_chan_xlate(indio_dev, iiospec->args[0]);
 }
@@ -1876,7 +1877,7 @@ static const struct iio_info at91_adc_info = {
 	.read_raw = &at91_adc_read_raw,
 	.write_raw = &at91_adc_write_raw,
 	.update_scan_mode = &at91_adc_update_scan_mode,
-	.of_xlate = &at91_adc_of_xlate,
+	.fwnode_xlate = &at91_adc_fwnode_xlate,
 	.hwfifo_set_watermark = &at91_adc_set_watermark,
 };
 
@@ -1920,6 +1921,7 @@ static int at91_adc_buffer_and_trigger_init(struct device *dev,
 
 static int at91_adc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct iio_dev *indio_dev;
 	struct at91_adc_state *st;
 	struct resource	*res;
@@ -1933,7 +1935,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	st = iio_priv(indio_dev);
 	st->indio_dev = indio_dev;
 
-	st->soc_info.platform = of_device_get_match_data(&pdev->dev);
+	st->soc_info.platform = device_get_match_data(dev);
 
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
@@ -1950,34 +1952,32 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	st->oversampling_ratio = AT91_OSR_1SAMPLES;
 
-	ret = of_property_read_u32(pdev->dev.of_node,
-				   "atmel,min-sample-rate-hz",
-				   &st->soc_info.min_sample_rate);
+	ret = device_property_read_u32(dev, "atmel,min-sample-rate-hz",
+				       &st->soc_info.min_sample_rate);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"invalid or missing value for atmel,min-sample-rate-hz\n");
 		return ret;
 	}
 
-	ret = of_property_read_u32(pdev->dev.of_node,
-				   "atmel,max-sample-rate-hz",
-				   &st->soc_info.max_sample_rate);
+	ret = device_property_read_u32(dev, "atmel,max-sample-rate-hz",
+				       &st->soc_info.max_sample_rate);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"invalid or missing value for atmel,max-sample-rate-hz\n");
 		return ret;
 	}
 
-	ret = of_property_read_u32(pdev->dev.of_node, "atmel,startup-time-ms",
-				   &st->soc_info.startup_time);
+	ret = device_property_read_u32(dev, "atmel,startup-time-ms",
+				       &st->soc_info.startup_time);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"invalid or missing value for atmel,startup-time-ms\n");
 		return ret;
 	}
 
-	ret = of_property_read_u32(pdev->dev.of_node,
-				   "atmel,trigger-edge-type", &edge_type);
+	ret = device_property_read_u32(dev, "atmel,trigger-edge-type",
+				       &edge_type);
 	if (ret) {
 		dev_dbg(&pdev->dev,
 			"atmel,trigger-edge-type not specified, only software trigger available\n");
-- 
2.37.1


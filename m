Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83BF5761A1
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jul 2022 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiGOMaw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jul 2022 08:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiGOMau (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2022 08:30:50 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4965A47C
        for <linux-iio@vger.kernel.org>; Fri, 15 Jul 2022 05:30:49 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FAou0a026913;
        Fri, 15 Jul 2022 08:29:39 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h9r37te6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 08:29:39 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 26FCTcgM062175
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jul 2022 08:29:38 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 15 Jul 2022 08:29:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 15 Jul 2022 08:29:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 15 Jul 2022 08:29:36 -0400
Received: from nsa.ad.analog.com ([10.44.3.55])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26FCRxO4001007;
        Fri, 15 Jul 2022 08:29:23 -0400
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
Subject: [PATCH v3 08/15] iio: adc: ab8500-gpadc: convert to device properties
Date:   Fri, 15 Jul 2022 14:28:56 +0200
Message-ID: <20220715122903.332535-9-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220715122903.332535-1-nuno.sa@analog.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 8fwdlyg7qp-onOiQ4O1T3jcYjjFFjUZ0
X-Proofpoint-ORIG-GUID: 8fwdlyg7qp-onOiQ4O1T3jcYjjFFjUZ0
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
 drivers/iio/adc/ab8500-gpadc.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
index 930ce96e6ff5..4fa2126a354b 100644
--- a/drivers/iio/adc/ab8500-gpadc.c
+++ b/drivers/iio/adc/ab8500-gpadc.c
@@ -925,8 +925,8 @@ static int ab8500_gpadc_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static int ab8500_gpadc_of_xlate(struct iio_dev *indio_dev,
-				 const struct of_phandle_args *iiospec)
+static int ab8500_gpadc_fwnode_xlate(struct iio_dev *indio_dev,
+				     const struct fwnode_reference_args *iiospec)
 {
 	int i;
 
@@ -938,7 +938,7 @@ static int ab8500_gpadc_of_xlate(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ab8500_gpadc_info = {
-	.of_xlate = ab8500_gpadc_of_xlate,
+	.fwnode_xlate = ab8500_gpadc_fwnode_xlate,
 	.read_raw = ab8500_gpadc_read_raw,
 };
 
@@ -968,7 +968,7 @@ static int ab8500_gpadc_runtime_resume(struct device *dev)
 /**
  * ab8500_gpadc_parse_channel() - process devicetree channel configuration
  * @dev: pointer to containing device
- * @np: device tree node for the channel to configure
+ * @fwnode: fw node for the channel to configure
  * @ch: channel info to fill in
  * @iio_chan: IIO channel specification to fill in
  *
@@ -976,15 +976,15 @@ static int ab8500_gpadc_runtime_resume(struct device *dev)
  * and define usage for things like AUX GPADC inputs more precisely.
  */
 static int ab8500_gpadc_parse_channel(struct device *dev,
-				      struct device_node *np,
+				      struct fwnode_handle *fwnode,
 				      struct ab8500_gpadc_chan_info *ch,
 				      struct iio_chan_spec *iio_chan)
 {
-	const char *name = np->name;
+	const char *name = fwnode_get_name(fwnode);
 	u32 chan;
 	int ret;
 
-	ret = of_property_read_u32(np, "reg", &chan);
+	ret = fwnode_property_read_u32(fwnode, "reg", &chan);
 	if (ret) {
 		dev_err(dev, "invalid channel number %s\n", name);
 		return ret;
@@ -1021,22 +1021,20 @@ static int ab8500_gpadc_parse_channel(struct device *dev,
 /**
  * ab8500_gpadc_parse_channels() - Parse the GPADC channels from DT
  * @gpadc: the GPADC to configure the channels for
- * @np: device tree node containing the channel configurations
  * @chans: the IIO channels we parsed
  * @nchans: the number of IIO channels we parsed
  */
 static int ab8500_gpadc_parse_channels(struct ab8500_gpadc *gpadc,
-				       struct device_node *np,
 				       struct iio_chan_spec **chans_parsed,
 				       unsigned int *nchans_parsed)
 {
-	struct device_node *child;
+	struct fwnode_handle *child;
 	struct ab8500_gpadc_chan_info *ch;
 	struct iio_chan_spec *iio_chans;
 	unsigned int nchans;
 	int i;
 
-	nchans = of_get_available_child_count(np);
+	nchans = device_get_child_node_count(gpadc->dev);
 	if (!nchans) {
 		dev_err(gpadc->dev, "no channel children\n");
 		return -ENODEV;
@@ -1054,7 +1052,7 @@ static int ab8500_gpadc_parse_channels(struct ab8500_gpadc *gpadc,
 		return -ENOMEM;
 
 	i = 0;
-	for_each_available_child_of_node(np, child) {
+	device_for_each_child_node(gpadc->dev, child) {
 		struct iio_chan_spec *iio_chan;
 		int ret;
 
@@ -1064,7 +1062,7 @@ static int ab8500_gpadc_parse_channels(struct ab8500_gpadc *gpadc,
 		ret = ab8500_gpadc_parse_channel(gpadc->dev, child, ch,
 						 iio_chan);
 		if (ret) {
-			of_node_put(child);
+			fwnode_handle_put(child);
 			return ret;
 		}
 		i++;
@@ -1081,7 +1079,6 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 	struct ab8500_gpadc *gpadc;
 	struct iio_dev *indio_dev;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = pdev->dev.of_node;
 	struct iio_chan_spec *iio_chans;
 	unsigned int n_iio_chans;
 	int ret;
@@ -1096,7 +1093,7 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 	gpadc->dev = dev;
 	gpadc->ab8500 = dev_get_drvdata(dev->parent);
 
-	ret = ab8500_gpadc_parse_channels(gpadc, np, &iio_chans, &n_iio_chans);
+	ret = ab8500_gpadc_parse_channels(gpadc, &iio_chans, &n_iio_chans);
 	if (ret)
 		return ret;
 
-- 
2.37.1


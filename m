Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0EA54604E
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 10:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348461AbiFJItJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 04:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348595AbiFJIsl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 04:48:41 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FB58CCCD;
        Fri, 10 Jun 2022 01:48:37 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25A8Ze4W010624;
        Fri, 10 Jun 2022 04:48:37 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3gm00mh26m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 04:48:37 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 25A8ma7n027568
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jun 2022 04:48:36 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 10 Jun
 2022 04:48:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 10 Jun 2022 04:48:35 -0400
Received: from nsa.ad.analog.com ([10.44.3.70])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 25A8imin014275;
        Fri, 10 Jun 2022 04:48:25 -0400
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
Subject: [PATCH 27/34] iio: adc: ab8500-gpadc: convert to device properties
Date:   Fri, 10 Jun 2022 10:45:38 +0200
Message-ID: <20220610084545.547700-28-nuno.sa@analog.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610084545.547700-1-nuno.sa@analog.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: pHxz0w2nnloZydOjdMyGYt3pvgqFy8Hp
X-Proofpoint-GUID: pHxz0w2nnloZydOjdMyGYt3pvgqFy8Hp
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
2.36.1


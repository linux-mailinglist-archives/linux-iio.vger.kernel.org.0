Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58B0546068
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 10:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348519AbiFJIts (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 04:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348526AbiFJIt3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 04:49:29 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F70451583;
        Fri, 10 Jun 2022 01:49:26 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25A8fboE010559;
        Fri, 10 Jun 2022 04:49:25 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3gm00mh299-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 04:49:25 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 25A8nOwt023362
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jun 2022 04:49:24 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 10 Jun 2022 04:49:23 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 10 Jun 2022 04:49:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 10 Jun 2022 04:49:23 -0400
Received: from nsa.ad.analog.com ([10.44.3.70])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 25A8imiu014275;
        Fri, 10 Jun 2022 04:49:12 -0400
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
Subject: [PATCH 34/34] iio: inkern: fix coding style warnings
Date:   Fri, 10 Jun 2022 10:45:45 +0200
Message-ID: <20220610084545.547700-35-nuno.sa@analog.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610084545.547700-1-nuno.sa@analog.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: z0tgKmiEePpg_dowAY_aI8d3iIGfILTP
X-Proofpoint-GUID: z0tgKmiEePpg_dowAY_aI8d3iIGfILTP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_02,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=768 lowpriorityscore=0 suspectscore=0
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

Just cosmetics. No functional change intended...

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/inkern.c | 64 ++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 7eb536560ded..526519cefcb9 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -45,13 +45,13 @@ int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
 	int i = 0, ret = 0;
 	struct iio_map_internal *mapi;
 
-	if (maps == NULL)
+	if (!maps)
 		return 0;
 
 	mutex_lock(&iio_map_list_lock);
-	while (maps[i].consumer_dev_name != NULL) {
+	while (!maps[i].consumer_dev_name) {
 		mapi = kzalloc(sizeof(*mapi), GFP_KERNEL);
-		if (mapi == NULL) {
+		if (!mapi) {
 			ret = -ENOMEM;
 			goto error_ret;
 		}
@@ -69,7 +69,6 @@ int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
 }
 EXPORT_SYMBOL_GPL(iio_map_array_register);
 
-
 /*
  * Remove all map entries associated with the given iio device
  */
@@ -163,7 +162,7 @@ static int __fwnode_iio_channel_get(struct iio_channel *channel,
 
 	idev = bus_find_device(&iio_bus_type, NULL, iiospec.fwnode,
 			       iio_dev_node_match);
-	if (idev == NULL) {
+	if (!idev) {
 		fwnode_handle_put(iiospec.fwnode);
 		return -EPROBE_DEFER;
 	}
@@ -196,7 +195,7 @@ static struct iio_channel *fwnode_iio_channel_get(struct fwnode_handle *fwnode,
 		return ERR_PTR(-EINVAL);
 
 	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
-	if (channel == NULL)
+	if (!channel)
 		return ERR_PTR(-ENOMEM);
 
 	err = __fwnode_iio_channel_get(channel, fwnode, index);
@@ -293,7 +292,7 @@ static struct iio_channel *fwnode_iio_channel_get_all(struct device *dev)
 
 	/* NULL terminated array to save passing size */
 	chans = kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
-	if (chans == NULL)
+	if (!chans)
 		return ERR_PTR(-ENOMEM);
 
 	/* Search for FW matches */
@@ -318,7 +317,7 @@ static struct iio_channel *iio_channel_get_sys(const char *name,
 	struct iio_channel *channel;
 	int err;
 
-	if (name == NULL && channel_name == NULL)
+	if (!name && !channel_name)
 		return ERR_PTR(-ENODEV);
 
 	/* first find matching entry the channel map */
@@ -333,11 +332,11 @@ static struct iio_channel *iio_channel_get_sys(const char *name,
 		break;
 	}
 	mutex_unlock(&iio_map_list_lock);
-	if (c == NULL)
+	if (!c)
 		return ERR_PTR(-ENODEV);
 
 	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
-	if (channel == NULL) {
+	if (!channel) {
 		err = -ENOMEM;
 		goto error_no_mem;
 	}
@@ -349,7 +348,7 @@ static struct iio_channel *iio_channel_get_sys(const char *name,
 			iio_chan_spec_from_name(channel->indio_dev,
 						c->map->adc_channel_label);
 
-		if (channel->channel == NULL) {
+		if (!channel->channel) {
 			err = -EINVAL;
 			goto error_no_chan;
 		}
@@ -441,7 +440,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 	int mapind = 0;
 	int i, ret;
 
-	if (dev == NULL)
+	if (!dev)
 		return ERR_PTR(-EINVAL);
 
 	chans = fwnode_iio_channel_get_all(dev);
@@ -465,7 +464,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 
 	/* NULL terminated array to save passing size */
 	chans = kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
-	if (chans == NULL) {
+	if (!chans) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
@@ -479,7 +478,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 		chans[mapind].channel =
 			iio_chan_spec_from_name(chans[mapind].indio_dev,
 						c->map->adc_channel_label);
-		if (chans[mapind].channel == NULL) {
+		if (!chans[mapind].channel) {
 			ret = -EINVAL;
 			goto error_free_chans;
 		}
@@ -541,14 +540,14 @@ struct iio_channel *devm_iio_channel_get_all(struct device *dev)
 EXPORT_SYMBOL_GPL(devm_iio_channel_get_all);
 
 static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
-	enum iio_chan_info_enum info)
+			    enum iio_chan_info_enum info)
 {
 	int unused;
 	int vals[INDIO_MAX_RAW_ELEMENTS];
 	int ret;
 	int val_len = 2;
 
-	if (val2 == NULL)
+	if (!val2)
 		val2 = &unused;
 
 	if (!iio_channel_has_info(chan->channel, info))
@@ -560,9 +559,10 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 					vals, &val_len, info);
 		*val = vals[0];
 		*val2 = vals[1];
-	} else
+	} else {
 		ret = chan->indio_dev->info->read_raw(chan->indio_dev,
 					chan->channel, val, val2, info);
+	}
 
 	return ret;
 }
@@ -573,7 +573,7 @@ int iio_read_channel_raw(struct iio_channel *chan, int *val)
 	int ret;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (chan->indio_dev->info == NULL) {
+	if (!chan->indio_dev->info) {
 		ret = -ENODEV;
 		goto err_unlock;
 	}
@@ -592,7 +592,7 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
 	int ret;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (chan->indio_dev->info == NULL) {
+	if (!chan->indio_dev->info) {
 		ret = -ENODEV;
 		goto err_unlock;
 	}
@@ -606,7 +606,8 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
 EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
 
 static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
-	int raw, int *processed, unsigned int scale)
+						 int raw, int *processed,
+						 unsigned int scale)
 {
 	int scale_type, scale_val, scale_val2;
 	int offset_type, offset_val, offset_val2;
@@ -639,7 +640,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 	}
 
 	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
-					IIO_CHAN_INFO_SCALE);
+				      IIO_CHAN_INFO_SCALE);
 	if (scale_type < 0) {
 		/*
 		 * If no channel scaling is available apply consumer scale to
@@ -684,19 +685,19 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 }
 
 int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
-	int *processed, unsigned int scale)
+				 int *processed, unsigned int scale)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
 	int ret;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (chan->indio_dev->info == NULL) {
+	if (!chan->indio_dev->info) {
 		ret = -ENODEV;
 		goto err_unlock;
 	}
 
 	ret = iio_convert_raw_to_processed_unlocked(chan, raw, processed,
-							scale);
+						    scale);
 err_unlock:
 	mutex_unlock(&iio_dev_opaque->info_exist_lock);
 
@@ -711,7 +712,7 @@ int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
 	int ret;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (chan->indio_dev->info == NULL) {
+	if (!chan->indio_dev->info) {
 		ret = -ENODEV;
 		goto err_unlock;
 	}
@@ -737,7 +738,7 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 	int ret;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (chan->indio_dev->info == NULL) {
+	if (!chan->indio_dev->info) {
 		ret = -ENODEV;
 		goto err_unlock;
 	}
@@ -815,7 +816,7 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
 	int type;
 
 	ret = iio_read_avail_channel_attribute(chan, vals, &type, length,
-					 IIO_CHAN_INFO_RAW);
+					       IIO_CHAN_INFO_RAW);
 
 	if (ret >= 0 && type != IIO_VAL_INT)
 		/* raw values are assumed to be IIO_VAL_INT */
@@ -899,7 +900,7 @@ int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *type)
 	/* Need to verify underlying driver has not gone away */
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (chan->indio_dev->info == NULL) {
+	if (!chan->indio_dev->info) {
 		ret = -ENODEV;
 		goto err_unlock;
 	}
@@ -926,7 +927,7 @@ int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
 	int ret;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (chan->indio_dev->info == NULL) {
+	if (!chan->indio_dev->info) {
 		ret = -ENODEV;
 		goto err_unlock;
 	}
@@ -960,9 +961,8 @@ unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
 }
 EXPORT_SYMBOL_GPL(iio_get_channel_ext_info_count);
 
-static const struct iio_chan_spec_ext_info *iio_lookup_ext_info(
-						const struct iio_channel *chan,
-						const char *attr)
+static const struct iio_chan_spec_ext_info *
+iio_lookup_ext_info(const struct iio_channel *chan, const char *attr)
 {
 	const struct iio_chan_spec_ext_info *ext_info;
 
-- 
2.36.1


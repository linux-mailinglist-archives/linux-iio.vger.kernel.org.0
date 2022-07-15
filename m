Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29EC5761AE
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jul 2022 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiGOMbW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jul 2022 08:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiGOMbU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2022 08:31:20 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038EA13D65
        for <linux-iio@vger.kernel.org>; Fri, 15 Jul 2022 05:31:20 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F9mLNx026912;
        Fri, 15 Jul 2022 08:30:27 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h9r37tebw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 08:30:26 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 26FCUP3t062199
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jul 2022 08:30:25 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 15 Jul 2022 08:30:24 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 15 Jul 2022 08:30:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 15 Jul 2022 08:30:24 -0400
Received: from nsa.ad.analog.com ([10.44.3.55])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26FCRxOB001007;
        Fri, 15 Jul 2022 08:30:13 -0400
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
Subject: [PATCH v3 15/15] iio: inkern: fix coding style warnings
Date:   Fri, 15 Jul 2022 14:29:03 +0200
Message-ID: <20220715122903.332535-16-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220715122903.332535-1-nuno.sa@analog.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: yYplBMtHgFHKiK3Qi4V0vxu-HBq4G562
X-Proofpoint-ORIG-GUID: yYplBMtHgFHKiK3Qi4V0vxu-HBq4G562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_04,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 spamscore=0 mlxlogscore=734 mlxscore=0 adultscore=0 suspectscore=0
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

Just cosmetics. No functional change intended...

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/inkern.c | 64 ++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index fab951546086..0c9b1561af31 100644
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
+	while (maps[i].consumer_dev_name) {
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
@@ -157,7 +156,7 @@ static int __fwnode_iio_channel_get(struct iio_channel *channel,
 		return err;
 
 	idev = bus_find_device_by_fwnode(&iio_bus_type, iiospec.fwnode);
-	if (idev == NULL) {
+	if (!idev) {
 		fwnode_handle_put(iiospec.fwnode);
 		return -EPROBE_DEFER;
 	}
@@ -190,7 +189,7 @@ static struct iio_channel *fwnode_iio_channel_get(struct fwnode_handle *fwnode,
 		return ERR_PTR(-EINVAL);
 
 	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
-	if (channel == NULL)
+	if (!channel)
 		return ERR_PTR(-ENOMEM);
 
 	err = __fwnode_iio_channel_get(channel, fwnode, index);
@@ -307,7 +306,7 @@ static struct iio_channel *fwnode_iio_channel_get_all(struct device *dev)
 
 	/* NULL terminated array to save passing size */
 	chans = kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
-	if (chans == NULL)
+	if (!chans)
 		return ERR_PTR(-ENOMEM);
 
 	/* Search for FW matches */
@@ -332,7 +331,7 @@ static struct iio_channel *iio_channel_get_sys(const char *name,
 	struct iio_channel *channel;
 	int err;
 
-	if (name == NULL && channel_name == NULL)
+	if (!(name || channel_name))
 		return ERR_PTR(-ENODEV);
 
 	/* first find matching entry the channel map */
@@ -347,11 +346,11 @@ static struct iio_channel *iio_channel_get_sys(const char *name,
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
@@ -363,7 +362,7 @@ static struct iio_channel *iio_channel_get_sys(const char *name,
 			iio_chan_spec_from_name(channel->indio_dev,
 						c->map->adc_channel_label);
 
-		if (channel->channel == NULL) {
+		if (!channel->channel) {
 			err = -EINVAL;
 			goto error_no_chan;
 		}
@@ -455,7 +454,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 	int mapind = 0;
 	int i, ret;
 
-	if (dev == NULL)
+	if (!dev)
 		return ERR_PTR(-EINVAL);
 
 	chans = fwnode_iio_channel_get_all(dev);
@@ -483,7 +482,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 
 	/* NULL terminated array to save passing size */
 	chans = kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
-	if (chans == NULL) {
+	if (!chans) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
@@ -497,7 +496,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 		chans[mapind].channel =
 			iio_chan_spec_from_name(chans[mapind].indio_dev,
 						c->map->adc_channel_label);
-		if (chans[mapind].channel == NULL) {
+		if (!chans[mapind].channel) {
 			ret = -EINVAL;
 			goto error_free_chans;
 		}
@@ -559,14 +558,14 @@ struct iio_channel *devm_iio_channel_get_all(struct device *dev)
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
@@ -578,9 +577,10 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
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
@@ -591,7 +591,7 @@ int iio_read_channel_raw(struct iio_channel *chan, int *val)
 	int ret;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (chan->indio_dev->info == NULL) {
+	if (!chan->indio_dev->info) {
 		ret = -ENODEV;
 		goto err_unlock;
 	}
@@ -610,7 +610,7 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
 	int ret;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (chan->indio_dev->info == NULL) {
+	if (!chan->indio_dev->info) {
 		ret = -ENODEV;
 		goto err_unlock;
 	}
@@ -624,7 +624,8 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
 EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
 
 static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
-	int raw, int *processed, unsigned int scale)
+						 int raw, int *processed,
+						 unsigned int scale)
 {
 	int scale_type, scale_val, scale_val2;
 	int offset_type, offset_val, offset_val2;
@@ -657,7 +658,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 	}
 
 	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
-					IIO_CHAN_INFO_SCALE);
+				      IIO_CHAN_INFO_SCALE);
 	if (scale_type < 0) {
 		/*
 		 * If no channel scaling is available apply consumer scale to
@@ -702,19 +703,19 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
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
 
@@ -729,7 +730,7 @@ int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
 	int ret;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (chan->indio_dev->info == NULL) {
+	if (!chan->indio_dev->info) {
 		ret = -ENODEV;
 		goto err_unlock;
 	}
@@ -755,7 +756,7 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 	int ret;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (chan->indio_dev->info == NULL) {
+	if (!chan->indio_dev->info) {
 		ret = -ENODEV;
 		goto err_unlock;
 	}
@@ -833,7 +834,7 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
 	int type;
 
 	ret = iio_read_avail_channel_attribute(chan, vals, &type, length,
-					 IIO_CHAN_INFO_RAW);
+					       IIO_CHAN_INFO_RAW);
 
 	if (ret >= 0 && type != IIO_VAL_INT)
 		/* raw values are assumed to be IIO_VAL_INT */
@@ -917,7 +918,7 @@ int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *type)
 	/* Need to verify underlying driver has not gone away */
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (chan->indio_dev->info == NULL) {
+	if (!chan->indio_dev->info) {
 		ret = -ENODEV;
 		goto err_unlock;
 	}
@@ -944,7 +945,7 @@ int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
 	int ret;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
-	if (chan->indio_dev->info == NULL) {
+	if (!chan->indio_dev->info) {
 		ret = -ENODEV;
 		goto err_unlock;
 	}
@@ -978,9 +979,8 @@ unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
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
2.37.1


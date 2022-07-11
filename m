Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129DB5702A0
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 14:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiGKMkC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 08:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiGKMjt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 08:39:49 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544982CDF5;
        Mon, 11 Jul 2022 05:38:51 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BCAAML026688;
        Mon, 11 Jul 2022 08:38:51 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h76k6bhxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 08:38:50 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 26BCcnTF045697
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jul 2022 08:38:49 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 11 Jul 2022 08:38:48 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 11 Jul 2022 08:38:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 11 Jul 2022 08:38:48 -0400
Received: from nsa.ad.analog.com ([10.44.3.53])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26BCbVEA011687;
        Mon, 11 Jul 2022 08:38:36 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-arm-msm@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-mips@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-iio@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     Andy Gross <agross@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        "Zhang Rui" <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Eugen Hristev" <eugen.hristev@microchip.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        "Fabio Estevam" <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Patrick Venture" <venture@google.com>,
        Amit Kucheria <amitk@kernel.org>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        "Guenter Roeck" <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 05/15] iio: inkern: move to fwnode properties
Date:   Mon, 11 Jul 2022 14:38:25 +0200
Message-ID: <20220711123835.811358-6-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711123835.811358-1-nuno.sa@analog.com>
References: <20220711123835.811358-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: V3B74O8w0BGK3b7gC93xQ5skj89w0Qy-
X-Proofpoint-GUID: V3B74O8w0BGK3b7gC93xQ5skj89w0Qy-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_18,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110054
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This moves the IIO in kernel interface to use fwnode properties and thus
be firmware agnostic.

Note that the interface is still not firmware agnostic. At this point we
have both OF and fwnode interfaces so that we don't break any user. On
top of this we also want to have a per driver conversion and that is the
main reason we have both of_xlate() and fwnode_xlate() support.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/inkern.c         | 159 ++++++++++++++++++-----------------
 include/linux/iio/consumer.h |  36 ++++----
 include/linux/iio/iio.h      |   5 ++
 3 files changed, 108 insertions(+), 92 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index f97b7967d3d9..95e015e88645 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -5,6 +5,7 @@
  */
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -117,15 +118,8 @@ static const struct iio_chan_spec
 	return chan;
 }
 
-#ifdef CONFIG_OF
-
-static int iio_dev_node_match(struct device *dev, const void *data)
-{
-	return dev->of_node == data && dev->type == &iio_device_type;
-}
-
 /**
- * __of_iio_simple_xlate - translate iiospec to the IIO channel index
+ * __fwnode_iio_simple_xlate - translate iiospec to the IIO channel index
  * @indio_dev:	pointer to the iio_dev structure
  * @iiospec:	IIO specifier as found in the device tree
  *
@@ -134,14 +128,14 @@ static int iio_dev_node_match(struct device *dev, const void *data)
  * whether IIO index is less than num_channels (that is specified in the
  * iio_dev).
  */
-static int __of_iio_simple_xlate(struct iio_dev *indio_dev,
-				const struct of_phandle_args *iiospec)
+static int __fwnode_iio_simple_xlate(struct iio_dev *indio_dev,
+				     const struct fwnode_reference_args *iiospec)
 {
-	if (!iiospec->args_count)
+	if (!iiospec->nargs)
 		return 0;
 
 	if (iiospec->args[0] >= indio_dev->num_channels) {
-		dev_err(&indio_dev->dev, "invalid channel index %u\n",
+		dev_err(&indio_dev->dev, "invalid channel index %llu\n",
 			iiospec->args[0]);
 		return -EINVAL;
 	}
@@ -149,34 +143,55 @@ static int __of_iio_simple_xlate(struct iio_dev *indio_dev,
 	return iiospec->args[0];
 }
 
-static int __of_iio_channel_get(struct iio_channel *channel,
-				struct device_node *np, int index)
+/*
+ * Simple helper to copy fwnode_reference_args into of_phandle_args so we
+ * can pass it to of_xlate(). Ultimate goal is to drop this together with
+ * of_xlate().
+ */
+static int __fwnode_to_of_xlate(struct iio_dev *indio_dev,
+				const struct fwnode_reference_args *iiospec)
+{
+	struct of_phandle_args of_args;
+	unsigned int i;
+
+	of_args.args_count = iiospec->nargs;
+	of_args.np = to_of_node(iiospec->fwnode);
+
+	for (i = 0; i < MAX_PHANDLE_ARGS; i++)
+		of_args.args[i] = i < iiospec->nargs ? iiospec->args[i] : 0;
+
+	return indio_dev->info->of_xlate(indio_dev, &of_args);
+}
+
+static int __fwnode_iio_channel_get(struct iio_channel *channel,
+				    struct fwnode_handle *fwnode, int index)
 {
+	struct fwnode_reference_args iiospec;
 	struct device *idev;
 	struct iio_dev *indio_dev;
 	int err;
-	struct of_phandle_args iiospec;
 
-	err = of_parse_phandle_with_args(np, "io-channels",
-					 "#io-channel-cells",
-					 index, &iiospec);
+	err = fwnode_property_get_reference_args(fwnode, "io-channels",
+						 "#io-channel-cells", 0,
+						 index, &iiospec);
 	if (err)
 		return err;
 
-	idev = bus_find_device(&iio_bus_type, NULL, iiospec.np,
-			       iio_dev_node_match);
+	idev = bus_find_device_by_fwnode(&iio_bus_type, iiospec.fwnode);
 	if (idev == NULL) {
-		of_node_put(iiospec.np);
+		fwnode_handle_put(iiospec.fwnode);
 		return -EPROBE_DEFER;
 	}
 
 	indio_dev = dev_to_iio_dev(idev);
 	channel->indio_dev = indio_dev;
 	if (indio_dev->info->of_xlate)
-		index = indio_dev->info->of_xlate(indio_dev, &iiospec);
+		index = __fwnode_to_of_xlate(indio_dev, &iiospec);
+	else if (indio_dev->info->fwnode_xlate)
+		index = indio_dev->info->fwnode_xlate(indio_dev, &iiospec);
 	else
-		index = __of_iio_simple_xlate(indio_dev, &iiospec);
-	of_node_put(iiospec.np);
+		index = __fwnode_iio_simple_xlate(indio_dev, &iiospec);
+	fwnode_handle_put(iiospec.fwnode);
 	if (index < 0)
 		goto err_put;
 	channel->channel = &indio_dev->channels[index];
@@ -188,7 +203,8 @@ static int __of_iio_channel_get(struct iio_channel *channel,
 	return index;
 }
 
-static struct iio_channel *of_iio_channel_get(struct device_node *np, int index)
+static struct iio_channel *fwnode_iio_channel_get(struct fwnode_handle *fwnode,
+						  int index)
 {
 	struct iio_channel *channel;
 	int err;
@@ -200,7 +216,7 @@ static struct iio_channel *of_iio_channel_get(struct device_node *np, int index)
 	if (channel == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	err = __of_iio_channel_get(channel, np, index);
+	err = __fwnode_iio_channel_get(channel, fwnode, index);
 	if (err)
 		goto err_free_channel;
 
@@ -211,8 +227,8 @@ static struct iio_channel *of_iio_channel_get(struct device_node *np, int index)
 	return ERR_PTR(err);
 }
 
-struct iio_channel *__of_iio_channel_get_by_name(struct device_node *np,
-						 const char *name)
+struct iio_channel *
+__fwnode_iio_channel_get_by_name(struct fwnode_handle *fwnode, const char *name)
 {
 	struct iio_channel *chan;
 	int index = 0;
@@ -220,19 +236,20 @@ struct iio_channel *__of_iio_channel_get_by_name(struct device_node *np,
 	/*
 	 * For named iio channels, first look up the name in the
 	 * "io-channel-names" property.  If it cannot be found, the
-	 * index will be an error code, and of_iio_channel_get()
+	 * index will be an error code, and fwnode_iio_channel_get()
 	 * will fail.
 	 */
 	if (name)
-		index = of_property_match_string(np, "io-channel-names", name);
+		index = fwnode_property_match_string(fwnode, "io-channel-names",
+						     name);
 
-	chan = of_iio_channel_get(np, index);
+	chan = fwnode_iio_channel_get(fwnode, index);
 	if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
 		return chan;
 	if (name) {
 		if (index >= 0) {
-			pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
-			       np, name, index);
+			pr_err("ERROR: could not get IIO channel %pfw:%s(%i)\n",
+			       fwnode, name, index);
 			/*
 			 * In this case, we found 'name' in 'io-channel-names'
 			 * but somehow we still fail so that we should not proceed
@@ -242,16 +259,16 @@ struct iio_channel *__of_iio_channel_get_by_name(struct device_node *np,
 			 */
 			return ERR_PTR(-EINVAL);
 		}
-		/* If index < 0, then of_parse_phandle_with_args() fails
-		 * with -EINVAL which is expected. We should not proceed
-		 * if we get any other error.
+		/* If index < 0, then fwnode_property_get_reference_args() fails
+		 * with -EINVAL or -ENOENT (ACPI case) which is expected. We
+		 * should not proceed if we get any other error.
 		 */
-		if (PTR_ERR(chan) != -EINVAL)
+		if (PTR_ERR(chan) != -EINVAL && PTR_ERR(chan) != -ENOENT)
 			return chan;
 	} else if (PTR_ERR(chan) != -ENOENT) {
 		/*
 		 * if !name, then we should only proceed the lookup if
-		 * of_parse_phandle_with_args() returns -ENOENT.
+		 * fwnode_property_get_reference_args() returns -ENOENT.
 		 */
 		return chan;
 	}
@@ -260,13 +277,14 @@ struct iio_channel *__of_iio_channel_get_by_name(struct device_node *np,
 	return ERR_PTR(-ENODEV);
 }
 
-struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
-					       const char *name)
+struct iio_channel *fwnode_iio_channel_get_by_name(struct fwnode_handle *fwnode,
+						   const char *name)
 {
+	struct fwnode_handle *parent;
 	struct iio_channel *chan;
 
 	/* Walk up the tree of devices looking for a matching iio channel */
-	chan = __of_iio_channel_get_by_name(np, name);
+	chan = __fwnode_iio_channel_get_by_name(fwnode, name);
 	if (!IS_ERR(chan) || PTR_ERR(chan) != -ENODEV)
 		return chan;
 
@@ -275,35 +293,34 @@ struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
 	 * If the parent node has a "io-channel-ranges" property,
 	 * then we can try one of its channels.
 	 */
-	np = np->parent;
-	while (np) {
-		int index = 0;
-
-		if (!of_get_property(np, "io-channel-ranges", NULL))
+	fwnode_for_each_parent_node(fwnode, parent) {
+		if (!fwnode_property_present(parent, "io-channel-ranges")) {
+			fwnode_handle_put(parent);
 			return ERR_PTR(-ENODEV);
+		}
 
-		chan = __of_iio_channel_get_by_name(np, name);
-		if (!IS_ERR(chan) || PTR_ERR(chan) != -ENODEV)
+		chan = __fwnode_iio_channel_get_by_name(fwnode, name);
+		if (!IS_ERR(chan) || PTR_ERR(chan) != -ENODEV) {
+			fwnode_handle_put(parent);
 			return chan;
-
-		np = np->parent;
+		}
 	}
 
 	return ERR_PTR(-ENODEV);
 }
-EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name);
+EXPORT_SYMBOL_GPL(fwnode_iio_channel_get_by_name);
 
-static struct iio_channel *of_iio_channel_get_all(struct device *dev)
+static struct iio_channel *fwnode_iio_channel_get_all(struct device *dev)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct iio_channel *chans;
 	int i, mapind, nummaps = 0;
 	int ret;
 
 	do {
-		ret = of_parse_phandle_with_args(dev->of_node,
-						 "io-channels",
-						 "#io-channel-cells",
-						 nummaps, NULL);
+		ret = fwnode_property_get_reference_args(fwnode, "io-channels",
+							 "#io-channel-cells", 0,
+							 nummaps, NULL);
 		if (ret < 0)
 			break;
 	} while (++nummaps);
@@ -316,10 +333,9 @@ static struct iio_channel *of_iio_channel_get_all(struct device *dev)
 	if (chans == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	/* Search for OF matches */
+	/* Search for FW matches */
 	for (mapind = 0; mapind < nummaps; mapind++) {
-		ret = __of_iio_channel_get(&chans[mapind], dev->of_node,
-					   mapind);
+		ret = __fwnode_iio_channel_get(&chans[mapind], fwnode, mapind);
 		if (ret)
 			goto error_free_chans;
 	}
@@ -332,15 +348,6 @@ static struct iio_channel *of_iio_channel_get_all(struct device *dev)
 	return ERR_PTR(ret);
 }
 
-#else /* CONFIG_OF */
-
-static inline struct iio_channel *of_iio_channel_get_all(struct device *dev)
-{
-	return ERR_PTR(-ENODEV);
-}
-
-#endif /* CONFIG_OF */
-
 static struct iio_channel *iio_channel_get_sys(const char *name,
 					       const char *channel_name)
 {
@@ -401,8 +408,8 @@ struct iio_channel *iio_channel_get(struct device *dev,
 	struct iio_channel *channel;
 
 	if (dev) {
-		channel = of_iio_channel_get_by_name(dev->of_node,
-						     channel_name);
+		channel = fwnode_iio_channel_get_by_name(dev_fwnode(dev),
+							 channel_name);
 		if (!IS_ERR(channel) || PTR_ERR(channel) != -ENODEV)
 			return channel;
 	}
@@ -443,14 +450,14 @@ struct iio_channel *devm_iio_channel_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_iio_channel_get);
 
-struct iio_channel *devm_of_iio_channel_get_by_name(struct device *dev,
-						    struct device_node *np,
-						    const char *channel_name)
+struct iio_channel *devm_fwnode_iio_channel_get_by_name(struct device *dev,
+							struct fwnode_handle *fwnode,
+							const char *channel_name)
 {
 	struct iio_channel *channel;
 	int ret;
 
-	channel = of_iio_channel_get_by_name(np, channel_name);
+	channel = fwnode_iio_channel_get_by_name(fwnode, channel_name);
 	if (IS_ERR(channel))
 		return channel;
 
@@ -460,7 +467,7 @@ struct iio_channel *devm_of_iio_channel_get_by_name(struct device *dev,
 
 	return channel;
 }
-EXPORT_SYMBOL_GPL(devm_of_iio_channel_get_by_name);
+EXPORT_SYMBOL_GPL(devm_fwnode_iio_channel_get_by_name);
 
 struct iio_channel *iio_channel_get_all(struct device *dev)
 {
@@ -474,7 +481,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 	if (dev == NULL)
 		return ERR_PTR(-EINVAL);
 
-	chans = of_iio_channel_get_all(dev);
+	chans = fwnode_iio_channel_get_all(dev);
 	/*
 	 * We only want to carry on if the error is -ENODEV.  Anything else
 	 * should be reported up the stack.
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 5fa5957586cf..2adb1306da3e 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -7,6 +7,7 @@
 #ifndef _IIO_INKERN_CONSUMER_H_
 #define _IIO_INKERN_CONSUMER_H_
 
+#include <linux/of.h>
 #include <linux/types.h>
 #include <linux/iio/types.h>
 
@@ -14,6 +15,7 @@ struct iio_dev;
 struct iio_chan_spec;
 struct device;
 struct device_node;
+struct fwnode_handle;
 
 /**
  * struct iio_channel - everything needed for a consumer to use a channel
@@ -99,26 +101,20 @@ void iio_channel_release_all(struct iio_channel *chan);
 struct iio_channel *devm_iio_channel_get_all(struct device *dev);
 
 /**
- * of_iio_channel_get_by_name() - get description of all that is needed to access channel.
- * @np:			Pointer to consumer device tree node
+ * fwnode_iio_channel_get_by_name() - get description of all that is needed to access channel.
+ * @fwnode:		Pointer to consumer Firmware node
  * @consumer_channel:	Unique name to identify the channel on the consumer
  *			side. This typically describes the channels use within
  *			the consumer. E.g. 'battery_voltage'
  */
-#ifdef CONFIG_OF
-struct iio_channel *of_iio_channel_get_by_name(struct device_node *np, const char *name);
-#else
-static inline struct iio_channel *
-of_iio_channel_get_by_name(struct device_node *np, const char *name)
-{
-	return NULL;
-}
-#endif
+struct iio_channel *fwnode_iio_channel_get_by_name(struct fwnode_handle *fwnode,
+						   const char *name);
 
 /**
- * devm_of_iio_channel_get_by_name() - Resource managed version of of_iio_channel_get_by_name().
+ * devm_fwnode_iio_channel_get_by_name() - Resource managed version of
+ *					   fwnode_iio_channel_get_by_name().
  * @dev:		Pointer to consumer device.
- * @np:			Pointer to consumer device tree node
+ * @fwnode:		Pointer to consumer Firmware node
  * @consumer_channel:	Unique name to identify the channel on the consumer
  *			side. This typically describes the channels use within
  *			the consumer. E.g. 'battery_voltage'
@@ -129,9 +125,17 @@ of_iio_channel_get_by_name(struct device_node *np, const char *name)
  * The allocated iio channel is automatically released when the device is
  * unbound.
  */
-struct iio_channel *devm_of_iio_channel_get_by_name(struct device *dev,
-						    struct device_node *np,
-						    const char *consumer_channel);
+struct iio_channel *devm_fwnode_iio_channel_get_by_name(struct device *dev,
+							struct fwnode_handle *fwnode,
+							const char *consumer_channel);
+
+static inline struct iio_channel
+*devm_of_iio_channel_get_by_name(struct device *dev, struct device_node *np,
+				 const char *consumer_channel)
+{
+	return devm_fwnode_iio_channel_get_by_name(dev, of_fwnode_handle(np),
+						   consumer_channel);
+}
 
 struct iio_cb_buffer;
 /**
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index d9b4a9ca9a0f..494abb63406e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -18,6 +18,7 @@
  */
 
 struct of_phandle_args;
+struct fwnode_reference_args;
 
 enum iio_shared_by {
 	IIO_SEPARATE,
@@ -429,6 +430,8 @@ struct iio_trigger; /* forward declaration */
  *			provide a custom of_xlate function that reads the
  *			*args* and returns the appropriate index in registered
  *			IIO channels array.
+ * @fwnode_xlate:	fwnode based function pointer to obtain channel specifier index.
+ *			Functionally the same as @of_xlate.
  * @hwfifo_set_watermark: function pointer to set the current hardware
  *			fifo watermark level; see hwfifo_* entries in
  *			Documentation/ABI/testing/sysfs-bus-iio for details on
@@ -510,6 +513,8 @@ struct iio_info {
 				  unsigned *readval);
 	int (*of_xlate)(struct iio_dev *indio_dev,
 			const struct of_phandle_args *iiospec);
+	int (*fwnode_xlate)(struct iio_dev *indio_dev,
+			    const struct fwnode_reference_args *iiospec);
 	int (*hwfifo_set_watermark)(struct iio_dev *indio_dev, unsigned val);
 	int (*hwfifo_flush_to_buffer)(struct iio_dev *indio_dev,
 				      unsigned count);
-- 
2.37.0


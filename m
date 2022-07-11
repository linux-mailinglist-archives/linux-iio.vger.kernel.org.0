Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298995702C8
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 14:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiGKMk1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 08:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiGKMkI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 08:40:08 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB7E31D;
        Mon, 11 Jul 2022 05:39:53 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BAWjZ5011643;
        Mon, 11 Jul 2022 08:39:53 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h73h6cakj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 08:39:52 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 26BCdpcn000442
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jul 2022 08:39:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 11 Jul
 2022 08:39:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 11 Jul 2022 08:39:50 -0400
Received: from nsa.ad.analog.com ([10.44.3.53])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26BCbVEJ011687;
        Mon, 11 Jul 2022 08:39:39 -0400
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
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Patrick Venture <venture@google.com>,
        Amit Kucheria <amitk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 14/15] iio: inkern: remove OF dependencies
Date:   Mon, 11 Jul 2022 14:38:34 +0200
Message-ID: <20220711123835.811358-15-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711123835.811358-1-nuno.sa@analog.com>
References: <20220711123835.811358-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: IHTholClshGTeeB615EYPJ9XHgy861Oj
X-Proofpoint-ORIG-GUID: IHTholClshGTeeB615EYPJ9XHgy861Oj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_18,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=753 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207110054
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since all users of the OF dependendent API are now converted to use the
firmware agnostic alternative, we can drop OF dependencies from the IIO
in kernel interface.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/inkern.c         | 25 +------------------------
 include/linux/iio/consumer.h | 10 ----------
 include/linux/iio/iio.h      |  3 ---
 3 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 95e015e88645..fab951546086 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -8,7 +8,6 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/iio-opaque.h>
@@ -143,26 +142,6 @@ static int __fwnode_iio_simple_xlate(struct iio_dev *indio_dev,
 	return iiospec->args[0];
 }
 
-/*
- * Simple helper to copy fwnode_reference_args into of_phandle_args so we
- * can pass it to of_xlate(). Ultimate goal is to drop this together with
- * of_xlate().
- */
-static int __fwnode_to_of_xlate(struct iio_dev *indio_dev,
-				const struct fwnode_reference_args *iiospec)
-{
-	struct of_phandle_args of_args;
-	unsigned int i;
-
-	of_args.args_count = iiospec->nargs;
-	of_args.np = to_of_node(iiospec->fwnode);
-
-	for (i = 0; i < MAX_PHANDLE_ARGS; i++)
-		of_args.args[i] = i < iiospec->nargs ? iiospec->args[i] : 0;
-
-	return indio_dev->info->of_xlate(indio_dev, &of_args);
-}
-
 static int __fwnode_iio_channel_get(struct iio_channel *channel,
 				    struct fwnode_handle *fwnode, int index)
 {
@@ -185,9 +164,7 @@ static int __fwnode_iio_channel_get(struct iio_channel *channel,
 
 	indio_dev = dev_to_iio_dev(idev);
 	channel->indio_dev = indio_dev;
-	if (indio_dev->info->of_xlate)
-		index = __fwnode_to_of_xlate(indio_dev, &iiospec);
-	else if (indio_dev->info->fwnode_xlate)
+	if (indio_dev->info->fwnode_xlate)
 		index = indio_dev->info->fwnode_xlate(indio_dev, &iiospec);
 	else
 		index = __fwnode_iio_simple_xlate(indio_dev, &iiospec);
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 2adb1306da3e..6802596b017c 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -7,14 +7,12 @@
 #ifndef _IIO_INKERN_CONSUMER_H_
 #define _IIO_INKERN_CONSUMER_H_
 
-#include <linux/of.h>
 #include <linux/types.h>
 #include <linux/iio/types.h>
 
 struct iio_dev;
 struct iio_chan_spec;
 struct device;
-struct device_node;
 struct fwnode_handle;
 
 /**
@@ -129,14 +127,6 @@ struct iio_channel *devm_fwnode_iio_channel_get_by_name(struct device *dev,
 							struct fwnode_handle *fwnode,
 							const char *consumer_channel);
 
-static inline struct iio_channel
-*devm_of_iio_channel_get_by_name(struct device *dev, struct device_node *np,
-				 const char *consumer_channel)
-{
-	return devm_fwnode_iio_channel_get_by_name(dev, of_fwnode_handle(np),
-						   consumer_channel);
-}
-
 struct iio_cb_buffer;
 /**
  * iio_channel_get_all_cb() - register callback for triggered capture
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 494abb63406e..7093be1531c1 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -17,7 +17,6 @@
  * Currently assumes nano seconds.
  */
 
-struct of_phandle_args;
 struct fwnode_reference_args;
 
 enum iio_shared_by {
@@ -511,8 +510,6 @@ struct iio_info {
 	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
 				  unsigned reg, unsigned writeval,
 				  unsigned *readval);
-	int (*of_xlate)(struct iio_dev *indio_dev,
-			const struct of_phandle_args *iiospec);
 	int (*fwnode_xlate)(struct iio_dev *indio_dev,
 			    const struct fwnode_reference_args *iiospec);
 	int (*hwfifo_set_watermark)(struct iio_dev *indio_dev, unsigned val);
-- 
2.37.0


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D82154602E
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 10:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348362AbiFJIs4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 04:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348301AbiFJIsS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 04:48:18 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA75162BE8;
        Fri, 10 Jun 2022 01:48:05 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25A7noCd005281;
        Fri, 10 Jun 2022 04:48:05 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ghq33kq9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 04:48:05 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 25A8m4b4027550
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jun 2022 04:48:04 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 10 Jun 2022 04:48:03 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 10 Jun 2022 04:48:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 10 Jun 2022 04:48:00 -0400
Received: from nsa.ad.analog.com ([10.44.3.70])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 25A8imii014275;
        Fri, 10 Jun 2022 04:47:49 -0400
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
Subject: [PATCH 22/34] iio: inkern: only return error codes in iio_channel_get_*() APIs
Date:   Fri, 10 Jun 2022 10:45:33 +0200
Message-ID: <20220610084545.547700-23-nuno.sa@analog.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610084545.547700-1-nuno.sa@analog.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Y_iBkwY0TFr0zytvI3INOXjiF43q9YVc
X-Proofpoint-GUID: Y_iBkwY0TFr0zytvI3INOXjiF43q9YVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_02,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=842 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100031
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

APIs like of_iio_channel_get_by_name() and of_iio_channel_get_all() were
returning a mix of NULL and error pointers being NULL the way to
"notify" that we should do a "system" lookup for channels. This make
it very confusing and prone to errors as commit dbbccf7c20bf
("iio: inkern: fix return value in devm_of_iio_channel_get_by_name()")
proves. On top of this, patterns like 'if (channel != NULL) return channel'
were being used where channel could actually be an error code which
makes the code hard to read.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/inkern.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 87fd2a0d44f2..31d9c122199a 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -214,7 +214,7 @@ static struct iio_channel *of_iio_channel_get(struct device_node *np, int index)
 struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
 					       const char *name)
 {
-	struct iio_channel *chan = NULL;
+	struct iio_channel *chan;
 
 	/* Walk up the tree of devices looking for a matching iio channel */
 	while (np) {
@@ -231,11 +231,11 @@ struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
 							 name);
 		chan = of_iio_channel_get(np, index);
 		if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
-			break;
-		else if (name && index >= 0) {
+			return chan;
+		if (name && index >= 0) {
 			pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
 				np, name ? name : "", index);
-			return NULL;
+			return chan;
 		}
 
 		/*
@@ -245,10 +245,10 @@ struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
 		 */
 		np = np->parent;
 		if (np && !of_get_property(np, "io-channel-ranges", NULL))
-			return NULL;
+			return chan;
 	}
 
-	return chan;
+	return ERR_PTR(-ENODEV);
 }
 EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name);
 
@@ -267,8 +267,8 @@ static struct iio_channel *of_iio_channel_get_all(struct device *dev)
 			break;
 	} while (++nummaps);
 
-	if (nummaps == 0)	/* no error, return NULL to search map table */
-		return NULL;
+	if (nummaps == 0)	/* return -ENODEV to search map table */
+		return ERR_PTR(-ENODEV);
 
 	/* NULL terminated array to save passing size */
 	chans = kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
@@ -295,7 +295,7 @@ static struct iio_channel *of_iio_channel_get_all(struct device *dev)
 
 static inline struct iio_channel *of_iio_channel_get_all(struct device *dev)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 #endif /* CONFIG_OF */
@@ -362,7 +362,7 @@ struct iio_channel *iio_channel_get(struct device *dev,
 	if (dev) {
 		channel = of_iio_channel_get_by_name(dev->of_node,
 						     channel_name);
-		if (channel != NULL)
+		if (!IS_ERR(channel) || PTR_ERR(channel) == -EPROBE_DEFER)
 			return channel;
 	}
 
@@ -412,8 +412,6 @@ struct iio_channel *devm_of_iio_channel_get_by_name(struct device *dev,
 	channel = of_iio_channel_get_by_name(np, channel_name);
 	if (IS_ERR(channel))
 		return channel;
-	if (!channel)
-		return ERR_PTR(-ENODEV);
 
 	ret = devm_add_action_or_reset(dev, devm_iio_channel_free, channel);
 	if (ret)
@@ -436,7 +434,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 		return ERR_PTR(-EINVAL);
 
 	chans = of_iio_channel_get_all(dev);
-	if (chans)
+	if (!IS_ERR(chans) || PTR_ERR(chans) == -EPROBE_DEFER)
 		return chans;
 
 	name = dev_name(dev);
-- 
2.36.1


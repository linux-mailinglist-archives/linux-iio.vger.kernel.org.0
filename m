Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B15657029C
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 14:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiGKMkB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 08:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiGKMjq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 08:39:46 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F42713DEF;
        Mon, 11 Jul 2022 05:38:43 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BBf38P026647;
        Mon, 11 Jul 2022 08:38:43 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h76k6bhwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 08:38:43 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 26BCcg2u045688
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jul 2022 08:38:42 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 11 Jul
 2022 08:38:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 11 Jul 2022 08:38:41 -0400
Received: from nsa.ad.analog.com ([10.44.3.53])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26BCbVE9011687;
        Mon, 11 Jul 2022 08:38:30 -0400
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
Subject: [PATCH v2 04/15] iio: inkern: split of_iio_channel_get_by_name()
Date:   Mon, 11 Jul 2022 14:38:24 +0200
Message-ID: <20220711123835.811358-5-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711123835.811358-1-nuno.sa@analog.com>
References: <20220711123835.811358-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: WkIKZQXaKH-kBzq2txCSpF9DF1YtAK57
X-Proofpoint-GUID: WkIKZQXaKH-kBzq2txCSpF9DF1YtAK57
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

This change splits of_iio_channel_get_by_name() so that it decouples
looking for channels in the current node from looking in it's parents
nodes. This will be helpful when moving to fwnode properties where we
need to release the handles when looking for channels in parent's nodes.

No functional change intended...

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/inkern.c | 109 ++++++++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c6f1cfe09bd3..f97b7967d3d9 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -211,61 +211,82 @@ static struct iio_channel *of_iio_channel_get(struct device_node *np, int index)
 	return ERR_PTR(err);
 }
 
+struct iio_channel *__of_iio_channel_get_by_name(struct device_node *np,
+						 const char *name)
+{
+	struct iio_channel *chan;
+	int index = 0;
+
+	/*
+	 * For named iio channels, first look up the name in the
+	 * "io-channel-names" property.  If it cannot be found, the
+	 * index will be an error code, and of_iio_channel_get()
+	 * will fail.
+	 */
+	if (name)
+		index = of_property_match_string(np, "io-channel-names", name);
+
+	chan = of_iio_channel_get(np, index);
+	if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
+		return chan;
+	if (name) {
+		if (index >= 0) {
+			pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
+			       np, name, index);
+			/*
+			 * In this case, we found 'name' in 'io-channel-names'
+			 * but somehow we still fail so that we should not proceed
+			 * with any other lookup. Hence, explicitly return -EINVAL
+			 * (maybe not the better error code) so that the caller
+			 * won't do a system lookup.
+			 */
+			return ERR_PTR(-EINVAL);
+		}
+		/* If index < 0, then of_parse_phandle_with_args() fails
+		 * with -EINVAL which is expected. We should not proceed
+		 * if we get any other error.
+		 */
+		if (PTR_ERR(chan) != -EINVAL)
+			return chan;
+	} else if (PTR_ERR(chan) != -ENOENT) {
+		/*
+		 * if !name, then we should only proceed the lookup if
+		 * of_parse_phandle_with_args() returns -ENOENT.
+		 */
+		return chan;
+	}
+
+	/* so we continue the lookup */
+	return ERR_PTR(-ENODEV);
+}
+
 struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
 					       const char *name)
 {
 	struct iio_channel *chan;
 
 	/* Walk up the tree of devices looking for a matching iio channel */
+	chan = __of_iio_channel_get_by_name(np, name);
+	if (!IS_ERR(chan) || PTR_ERR(chan) != -ENODEV)
+		return chan;
+
+	/*
+	 * No matching IIO channel found on this node.
+	 * If the parent node has a "io-channel-ranges" property,
+	 * then we can try one of its channels.
+	 */
+	np = np->parent;
 	while (np) {
 		int index = 0;
 
-		/*
-		 * For named iio channels, first look up the name in the
-		 * "io-channel-names" property.  If it cannot be found, the
-		 * index will be an error code, and of_iio_channel_get()
-		 * will fail.
-		 */
-		if (name)
-			index = of_property_match_string(np, "io-channel-names",
-							 name);
-		chan = of_iio_channel_get(np, index);
-		if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
-			return chan;
-		if (name) {
-			if (index >= 0) {
-				pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
-				       np, name, index);
-				/*
-				 * In this case, we found 'name' in 'io-channel-names'
-				 * but somehow we still fail so that we should not proceed
-				 * with any other lookup. Hence, explicitly return -EINVAL
-				 * (maybe not the better error code) so that the caller
-				 * won't do a system lookup.
-				 */
-				return ERR_PTR(-EINVAL);
-			}
-			/* If index < 0, then of_parse_phandle_with_args() fails
-			 * with -EINVAL which is expected. We should not proceed
-			 * if we get any other error.
-			 */
-			if (PTR_ERR(chan) != -EINVAL)
-				return chan;
-		} else if (PTR_ERR(chan) != -ENOENT) {
-			/*
-			 * if !name, then we should only proceed the lookup if
-			 * of_parse_phandle_with_args() returns -ENOENT.
-			 */
+		if (!of_get_property(np, "io-channel-ranges", NULL))
+			return ERR_PTR(-ENODEV);
+
+		chan = __of_iio_channel_get_by_name(np, name);
+		if (!IS_ERR(chan) || PTR_ERR(chan) != -ENODEV)
 			return chan;
-		}
-		/*
-		 * No matching IIO channel found on this node.
-		 * If the parent node has a "io-channel-ranges" property,
-		 * then we can try one of its channels.
-		 */
+
 		np = np->parent;
-		if (np && !of_get_property(np, "io-channel-ranges", NULL))
-			return ERR_PTR(-ENODEV);
 	}
 
 	return ERR_PTR(-ENODEV);
-- 
2.37.0


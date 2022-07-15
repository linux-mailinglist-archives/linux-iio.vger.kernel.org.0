Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC6A576184
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jul 2022 14:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiGOMaC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jul 2022 08:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbiGOM37 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2022 08:29:59 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB21C5A469
        for <linux-iio@vger.kernel.org>; Fri, 15 Jul 2022 05:29:58 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F9j6TK011689;
        Fri, 15 Jul 2022 08:29:12 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h73h7c6nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 08:29:12 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 26FCTAHQ061326
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jul 2022 08:29:10 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 15 Jul 2022 08:29:09 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 15 Jul 2022 08:29:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 15 Jul 2022 08:29:09 -0400
Received: from nsa.ad.analog.com ([10.44.3.55])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26FCRxO0001007;
        Fri, 15 Jul 2022 08:28:57 -0400
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
Subject: [PATCH v3 04/15] iio: inkern: split of_iio_channel_get_by_name()
Date:   Fri, 15 Jul 2022 14:28:52 +0200
Message-ID: <20220715122903.332535-5-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220715122903.332535-1-nuno.sa@analog.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 00Mvl5QWraXBaMYbB-SuhFGlZYR4oq8v
X-Proofpoint-ORIG-GUID: 00Mvl5QWraXBaMYbB-SuhFGlZYR4oq8v
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
2.37.1


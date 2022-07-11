Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954A55702A6
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 14:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiGKMkI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 08:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiGKMjx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 08:39:53 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719315246E;
        Mon, 11 Jul 2022 05:39:03 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BAvb7D026643;
        Mon, 11 Jul 2022 08:39:03 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h76k6bhy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 08:39:03 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 26BCd177000422
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jul 2022 08:39:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 11 Jul
 2022 08:39:00 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 11 Jul 2022 08:39:00 -0400
Received: from nsa.ad.analog.com ([10.44.3.53])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26BCbVEC011687;
        Mon, 11 Jul 2022 08:38:51 -0400
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
Subject: [PATCH v2 07/15] iio: adc: ingenic-adc: convert to IIO fwnode interface
Date:   Mon, 11 Jul 2022 14:38:27 +0200
Message-ID: <20220711123835.811358-8-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711123835.811358-1-nuno.sa@analog.com>
References: <20220711123835.811358-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: w-LSjoxPM1fkD4boNQ6Bp1aWrvGEvBU7
X-Proofpoint-GUID: w-LSjoxPM1fkD4boNQ6Bp1aWrvGEvBU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_18,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxlogscore=815 malwarescore=0 spamscore=0 impostorscore=0
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

Move from 'of_xlate()' to 'fwnode_xlate()'. The end goal is to completely
drop OF from the IIO inkernel interface.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ingenic-adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index bf5c03c34f84..9e08f3abeea6 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -719,12 +719,12 @@ static int ingenic_adc_read_raw(struct iio_dev *iio_dev,
 	}
 }
 
-static int ingenic_adc_of_xlate(struct iio_dev *iio_dev,
-				const struct of_phandle_args *iiospec)
+static int ingenic_adc_fwnode_xlate(struct iio_dev *iio_dev,
+				    const struct fwnode_reference_args *iiospec)
 {
 	int i;
 
-	if (!iiospec->args_count)
+	if (!iiospec->nargs)
 		return -EINVAL;
 
 	for (i = 0; i < iio_dev->num_channels; ++i)
@@ -743,7 +743,7 @@ static const struct iio_info ingenic_adc_info = {
 	.write_raw = ingenic_adc_write_raw,
 	.read_raw = ingenic_adc_read_raw,
 	.read_avail = ingenic_adc_read_avail,
-	.of_xlate = ingenic_adc_of_xlate,
+	.fwnode_xlate = ingenic_adc_fwnode_xlate,
 };
 
 static int ingenic_adc_buffer_enable(struct iio_dev *iio_dev)
-- 
2.37.0


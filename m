Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885955BE46A
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 13:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiITL2t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 07:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiITL2s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 07:28:48 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617646BD76
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 04:28:47 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KBIc46025053;
        Tue, 20 Sep 2022 07:28:06 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jpn468r1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 07:28:06 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 28KBS55f062496
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Sep 2022 07:28:05 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 20 Sep
 2022 07:28:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 20 Sep 2022 07:28:04 -0400
Received: from nsa.ad.analog.com ([10.44.3.57])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 28KBR4UR021723;
        Tue, 20 Sep 2022 07:27:54 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>
CC:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Subject: [PATCH 05/15] iio: adc: lpc32xx_adc: do not use internal iio_dev lock
Date:   Tue, 20 Sep 2022 13:28:11 +0200
Message-ID: <20220920112821.975359-6-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920112821.975359-1-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: olOHKiyWuUWn6WgLbVn_AAgTMO5HnwCL
X-Proofpoint-GUID: olOHKiyWuUWn6WgLbVn_AAgTMO5HnwCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=947 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200068
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_device lock is only meant for internal use. Hence define a
device local lock to protect against concurrent accesses.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/lpc32xx_adc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index b56ce15255cf..4136cf536d58 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
@@ -49,6 +50,8 @@ struct lpc32xx_adc_state {
 	struct clk *clk;
 	struct completion completion;
 	struct regulator *vref;
+	/* lock to protect against multiple access to the device */
+	struct mutex lock;
 
 	u32 value;
 };
@@ -64,10 +67,10 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->lock);
 		ret = clk_prepare_enable(st->clk);
 		if (ret) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&st->lock);
 			return ret;
 		}
 		/* Measurement setup */
@@ -80,7 +83,7 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
 		wait_for_completion(&st->completion); /* set by ISR */
 		clk_disable_unprepare(st->clk);
 		*val = st->value;
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->lock);
 
 		return IIO_VAL_INT;
 
@@ -158,6 +161,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	st = iio_priv(iodev);
+	mutex_init(&st->lock);
 
 	st->adc_base = devm_ioremap(&pdev->dev, res->start,
 				    resource_size(res));
-- 
2.37.3


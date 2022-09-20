Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB715BE46F
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 13:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiITL3A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 07:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiITL27 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 07:28:59 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A846BD76
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 04:28:58 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K8GY0r006272;
        Tue, 20 Sep 2022 07:28:17 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jn835muta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 07:28:16 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 28KBSFCJ060651
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Sep 2022 07:28:15 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 20 Sep 2022 07:28:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 20 Sep 2022 07:28:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 20 Sep 2022 07:28:14 -0400
Received: from nsa.ad.analog.com ([10.44.3.57])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 28KBR4UT021723;
        Tue, 20 Sep 2022 07:28:03 -0400
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
        "Fabio Estevam" <festevam@gmail.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Baolin Wang" <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Subject: [PATCH 07/15] iio: adc: meson_saradc: do not use internal iio_dev lock
Date:   Tue, 20 Sep 2022 13:28:13 +0200
Message-ID: <20220920112821.975359-8-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920112821.975359-1-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 1KEUsqc0yXe0v9wtREJFIk9of_aToCYV
X-Proofpoint-GUID: 1KEUsqc0yXe0v9wtREJFIk9of_aToCYV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_03,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=926 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200068
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
 drivers/iio/adc/meson_saradc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 1a68b099d323..45d6e3d4b0ce 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
@@ -276,6 +277,8 @@ struct meson_sar_adc_priv {
 	struct clk				*adc_div_clk;
 	struct clk_divider			clk_div;
 	struct completion			done;
+	/* lock to protect against multiple access to the device */
+	struct mutex				lock;
 	int					calibbias;
 	int					calibscale;
 	struct regmap				*tsc_regmap;
@@ -486,7 +489,7 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	int val, ret;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&priv->lock);
 
 	if (priv->param->has_bl30_integration) {
 		/* prevent BL30 from using the SAR ADC while we are using it */
@@ -504,7 +507,7 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
 						      !(val & MESON_SAR_ADC_DELAY_BL30_BUSY),
 						      1, 10000);
 		if (ret) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&priv->lock);
 			return ret;
 		}
 	}
@@ -521,7 +524,7 @@ static void meson_sar_adc_unlock(struct iio_dev *indio_dev)
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
 				   MESON_SAR_ADC_DELAY_KERNEL_BUSY, 0);
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&priv->lock);
 }
 
 static void meson_sar_adc_clear_fifo(struct iio_dev *indio_dev)
@@ -1174,6 +1177,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 
 	priv = iio_priv(indio_dev);
 	init_completion(&priv->done);
+	mutex_init(&priv->lock);
 
 	match_data = of_device_get_match_data(dev);
 	if (!match_data)
-- 
2.37.3


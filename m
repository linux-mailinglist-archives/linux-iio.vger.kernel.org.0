Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20365BE469
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 13:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiITL2q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 07:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiITL2p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 07:28:45 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421BD6BD76
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 04:28:45 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7wQkT025088;
        Tue, 20 Sep 2022 07:28:03 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jpn468r1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 07:28:03 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 28KBS2ZE062485
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Sep 2022 07:28:02 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 20 Sep
 2022 07:28:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 20 Sep 2022 07:28:01 -0400
Received: from nsa.ad.analog.com ([10.44.3.57])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 28KBR4UQ021723;
        Tue, 20 Sep 2022 07:27:49 -0400
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
Subject: [PATCH 04/15] iio: adc: imx7d_adc: do not use internal iio_dev lock
Date:   Tue, 20 Sep 2022 13:28:10 +0200
Message-ID: <20220920112821.975359-5-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920112821.975359-1-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: fbqpoql29bL1qKSeJ7spjl_urrZS0t3H
X-Proofpoint-GUID: fbqpoql29bL1qKSeJ7spjl_urrZS0t3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
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
 drivers/iio/adc/imx7d_adc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 86caff1d006b..fa19f5e09079 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
@@ -108,7 +109,8 @@ struct imx7d_adc {
 	struct device *dev;
 	void __iomem *regs;
 	struct clk *clk;
-
+	/* lock to protect against multiple access to the device */
+	struct mutex lock;
 	u32 vref_uv;
 	u32 value;
 	u32 channel;
@@ -293,7 +295,7 @@ static int imx7d_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&info->lock);
 		reinit_completion(&info->completion);
 
 		channel = chan->channel & 0x03;
@@ -303,16 +305,16 @@ static int imx7d_adc_read_raw(struct iio_dev *indio_dev,
 		ret = wait_for_completion_interruptible_timeout
 				(&info->completion, IMX7D_ADC_TIMEOUT);
 		if (ret == 0) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&info->lock);
 			return -ETIMEDOUT;
 		}
 		if (ret < 0) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&info->lock);
 			return ret;
 		}
 
 		*val = info->value;
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&info->lock);
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -487,6 +489,7 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 
 	info = iio_priv(indio_dev);
 	info->dev = dev;
+	mutex_init(&info->lock);
 
 	info->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->regs))
-- 
2.37.3


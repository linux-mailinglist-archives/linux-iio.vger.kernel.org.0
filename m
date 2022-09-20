Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D06A5BE472
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 13:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiITL3O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 07:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiITL3N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 07:29:13 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143046BD76
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 04:29:13 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KBODCg025060;
        Tue, 20 Sep 2022 07:28:30 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jpn468r3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 07:28:29 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 28KBSSsP062579
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Sep 2022 07:28:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 20 Sep
 2022 07:28:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 20 Sep 2022 07:28:27 -0400
Received: from nsa.ad.analog.com ([10.44.3.57])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 28KBR4UW021723;
        Tue, 20 Sep 2022 07:28:20 -0400
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
Subject: [PATCH 10/15] iio: adc: vf610_adc: do not use internal iio_dev lock
Date:   Tue, 20 Sep 2022 13:28:16 +0200
Message-ID: <20220920112821.975359-11-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920112821.975359-1-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 4plsZpI7JSChqQG81txWSWwhaZ8wyvbt
X-Proofpoint-GUID: 4plsZpI7JSChqQG81txWSWwhaZ8wyvbt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=847 adultscore=0
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

In order to drop the internal lock usage we needed two different things:

1) The first place where 'mlock' was being used was a typical case where
iio_device_claim_direct_mode() fits perfectly.
2) In the second case, it was being used to prevent concurrent accesses
to the device and shared data but nothing was being enforced with
regards to buffering (i.e, there was nothing preventing from changing
the conversion mode while buffering). Hence, in this case, a new lock
was introduced in the state structure.

Note that the goal is not to introduce any functional change and that is
the reason why a new lock was introduced to guarantee 2).

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/vf610_adc.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index c6b16cf6e367..b9addd313ef1 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -7,6 +7,7 @@
 
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
@@ -156,6 +157,9 @@ struct vf610_adc {
 	void __iomem *regs;
 	struct clk *clk;
 
+	/* lock to protect against multiple access to the device */
+	struct mutex lock;
+
 	u32 vref_uv;
 	u32 value;
 	struct regulator *vref;
@@ -467,11 +471,11 @@ static int vf610_set_conversion_mode(struct iio_dev *indio_dev,
 {
 	struct vf610_adc *info = iio_priv(indio_dev);
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&info->lock);
 	info->adc_feature.conv_mode = mode;
 	vf610_adc_calculate_rates(info);
 	vf610_adc_hw_init(info);
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&info->lock);
 
 	return 0;
 }
@@ -635,12 +639,11 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
-		mutex_lock(&indio_dev->mlock);
-		if (iio_buffer_enabled(indio_dev)) {
-			mutex_unlock(&indio_dev->mlock);
-			return -EBUSY;
-		}
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
 
+		mutex_lock(&info->lock);
 		reinit_completion(&info->completion);
 		hc_cfg = VF610_ADC_ADCHC(chan->channel);
 		hc_cfg |= VF610_ADC_AIEN;
@@ -648,11 +651,13 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
 		ret = wait_for_completion_interruptible_timeout
 				(&info->completion, VF610_ADC_TIMEOUT);
 		if (ret == 0) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&info->lock);
+			iio_device_release_direct_mode(indio_dev);
 			return -ETIMEDOUT;
 		}
 		if (ret < 0) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&info->lock);
+			iio_device_release_direct_mode(indio_dev);
 			return ret;
 		}
 
@@ -671,11 +676,13 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
 
 			break;
 		default:
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&info->lock);
+			iio_device_release_direct_mode(indio_dev);
 			return -EINVAL;
 		}
 
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&info->lock);
+		iio_device_release_direct_mode(indio_dev);
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -812,6 +819,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
 
 	info = iio_priv(indio_dev);
 	info->dev = &pdev->dev;
+	mutex_init(&info->lock);
 
 	info->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->regs))
-- 
2.37.3


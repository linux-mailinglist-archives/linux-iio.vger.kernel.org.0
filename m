Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283A85F44BF
	for <lists+linux-iio@lfdr.de>; Tue,  4 Oct 2022 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJDNuL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Oct 2022 09:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiJDNuE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2022 09:50:04 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C280D91
        for <linux-iio@vger.kernel.org>; Tue,  4 Oct 2022 06:50:00 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294BXpkh024570;
        Tue, 4 Oct 2022 09:49:15 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jxjf733pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 09:49:14 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 294DnCre004117
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Oct 2022 09:49:12 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Oct 2022 09:49:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Oct 2022 09:49:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Oct 2022 09:49:11 -0400
Received: from nsa.ad.analog.com ([10.44.3.52])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 294DlkVh032663;
        Tue, 4 Oct 2022 09:49:04 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-amlogic@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Ciprian Regus" <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "Florian Boor" <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Chen-Yu Tsai" <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 10/16] iio: adc: vf610_adc: vf610_adc: do not use internal iio_dev lock
Date:   Tue, 4 Oct 2022 15:49:03 +0200
Message-ID: <20221004134909.1692021-11-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004134909.1692021-1-nuno.sa@analog.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: k3wrSbYPLdlik_JMrtGFyhbH8mmV20dI
X-Proofpoint-ORIG-GUID: k3wrSbYPLdlik_JMrtGFyhbH8mmV20dI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxlogscore=684 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040089
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

While at it, properly include "mutex.h" for mutex related APIs.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/vf610_adc.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index a6f9182d7766..ae31aafd2653 100644
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
@@ -629,12 +633,11 @@ static int vf610_read_sample(struct iio_dev *indio_dev,
 	unsigned int hc_cfg;
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
-		ret = -EBUSY;
-		goto out_unlock;
-	}
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
 
+	mutex_lock(&info->lock);
 	reinit_completion(&info->completion);
 	hc_cfg = VF610_ADC_ADCHC(chan->channel);
 	hc_cfg |= VF610_ADC_AIEN;
@@ -669,7 +672,8 @@ static int vf610_read_sample(struct iio_dev *indio_dev,
 	}
 
 out_unlock:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&info->lock);
+	iio_device_release_direct_mode(indio_dev);
 
 	return ret;
 }
@@ -892,6 +896,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
 		goto error_iio_device_register;
 	}
 
+	mutex_init(&info->lock);
+
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't register the device.\n");
-- 
2.37.3


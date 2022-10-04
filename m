Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695CE5F44BE
	for <lists+linux-iio@lfdr.de>; Tue,  4 Oct 2022 15:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiJDNuD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Oct 2022 09:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJDNuB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2022 09:50:01 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C8DF032
        for <linux-iio@vger.kernel.org>; Tue,  4 Oct 2022 06:49:52 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294ArJjF025134;
        Tue, 4 Oct 2022 09:49:11 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jxjf733pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 09:49:11 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 294DnApA004109
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Oct 2022 09:49:10 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Oct 2022 09:49:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Oct 2022 09:49:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Oct 2022 09:49:09 -0400
Received: from nsa.ad.analog.com ([10.44.3.52])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 294DlkVg032663;
        Tue, 4 Oct 2022 09:48:57 -0400
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
Subject: [PATCH v2 09/16] iio: adc: vf610_adc: add helper function to read samples
Date:   Tue, 4 Oct 2022 15:49:02 +0200
Message-ID: <20221004134909.1692021-10-nuno.sa@analog.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004134909.1692021-1-nuno.sa@analog.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: M6u34JCCV2Zyx26pPgyAcgbJHH3Ax16t
X-Proofpoint-ORIG-GUID: M6u34JCCV2Zyx26pPgyAcgbJHH3Ax16t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040089
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a precursor change to make it simpler to remove the 'mlock'
usage. Having the code in it's own helper function, also makes it easier
to read the error paths.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/vf610_adc.c | 94 +++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index c6b16cf6e367..a6f9182d7766 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -622,6 +622,58 @@ static const struct attribute_group vf610_attribute_group = {
 	.attrs = vf610_attributes,
 };
 
+static int vf610_read_sample(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val)
+{
+	struct vf610_adc *info = iio_priv(indio_dev);
+	unsigned int hc_cfg;
+	int ret;
+
+	mutex_lock(&indio_dev->mlock);
+	if (iio_buffer_enabled(indio_dev)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	reinit_completion(&info->completion);
+	hc_cfg = VF610_ADC_ADCHC(chan->channel);
+	hc_cfg |= VF610_ADC_AIEN;
+	writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
+	ret = wait_for_completion_interruptible_timeout(&info->completion,
+							VF610_ADC_TIMEOUT);
+	if (ret == 0) {
+		ret = -ETIMEDOUT;
+		goto out_unlock;
+	}
+
+	if (ret < 0)
+		goto out_unlock;
+
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		*val = info->value;
+		break;
+	case IIO_TEMP:
+		/*
+		 * Calculate in degree Celsius times 1000
+		 * Using the typical sensor slope of 1.84 mV/°C
+		 * and VREFH_ADC at 3.3V, V at 25°C of 699 mV
+		 */
+		*val = 25000 - ((int)info->value - VF610_VTEMP25_3V3) *
+				1000000 / VF610_TEMP_SLOPE_COEFF;
+
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+out_unlock:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
 static int vf610_read_raw(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *chan,
 			int *val,
@@ -629,53 +681,15 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
 			long mask)
 {
 	struct vf610_adc *info = iio_priv(indio_dev);
-	unsigned int hc_cfg;
 	long ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
-		mutex_lock(&indio_dev->mlock);
-		if (iio_buffer_enabled(indio_dev)) {
-			mutex_unlock(&indio_dev->mlock);
-			return -EBUSY;
-		}
-
-		reinit_completion(&info->completion);
-		hc_cfg = VF610_ADC_ADCHC(chan->channel);
-		hc_cfg |= VF610_ADC_AIEN;
-		writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
-		ret = wait_for_completion_interruptible_timeout
-				(&info->completion, VF610_ADC_TIMEOUT);
-		if (ret == 0) {
-			mutex_unlock(&indio_dev->mlock);
-			return -ETIMEDOUT;
-		}
-		if (ret < 0) {
-			mutex_unlock(&indio_dev->mlock);
+		ret = vf610_read_sample(indio_dev, chan, val);
+		if (ret < 0)
 			return ret;
-		}
-
-		switch (chan->type) {
-		case IIO_VOLTAGE:
-			*val = info->value;
-			break;
-		case IIO_TEMP:
-			/*
-			 * Calculate in degree Celsius times 1000
-			 * Using the typical sensor slope of 1.84 mV/°C
-			 * and VREFH_ADC at 3.3V, V at 25°C of 699 mV
-			 */
-			*val = 25000 - ((int)info->value - VF610_VTEMP25_3V3) *
-					1000000 / VF610_TEMP_SLOPE_COEFF;
-
-			break;
-		default:
-			mutex_unlock(&indio_dev->mlock);
-			return -EINVAL;
-		}
 
-		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-- 
2.37.3


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D81D57A2D0
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jul 2022 17:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiGSPS3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 19 Jul 2022 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiGSPS2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 11:18:28 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Jul 2022 08:18:26 PDT
Received: from mail.actia.se (212-181-117-226.customer.telia.com [212.181.117.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C43338A2
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 08:18:26 -0700 (PDT)
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Tue, 19 Jul
 2022 17:03:21 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.009; Tue, 19 Jul 2022 17:03:21 +0200
From:   Martin Larsson <martin.larsson@actia.se>
To:     Cai Huoqing <cai.huoqing@linux.dev>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Martin Larsson <martin.larsson@actia.se>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] iio: adc: imx8qxp-adc: propagate regulator_get_voltage error
Thread-Topic: [PATCH] iio: adc: imx8qxp-adc: propagate regulator_get_voltage
 error
Thread-Index: AQHYm4CvVEOgJp0PAEWVobJ6jyI6aw==
Date:   Tue, 19 Jul 2022 15:03:21 +0000
Message-ID: <20220719150317.67156-1-martin.larsson@actia.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.37.1
x-originating-ip: [10.12.12.22]
x-esetresult: clean, is OK
x-esetid: 37303A29D5529E56677463
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If the ADC vref regulator returns an error, for example, if CONFIG_REGULATOR
is not set, the error will be used as a reference voltage.

Introduce a guard for negative return values instead of unconditionally
casting it to u32.
---
 drivers/iio/adc/imx8qxp-adc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
index 901dd8e1b32f..8a786d73ae8e 100644
--- a/drivers/iio/adc/imx8qxp-adc.c
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -201,7 +201,7 @@ static int imx8qxp_adc_read_raw(struct iio_dev *indio_dev,
 	struct imx8qxp_adc *adc = iio_priv(indio_dev);
 	struct device *dev = adc->dev;
 
-	u32 ctrl, vref_uv;
+	u32 ctrl;
 	long ret;
 
 	switch (mask) {
@@ -244,8 +244,10 @@ static int imx8qxp_adc_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		vref_uv = regulator_get_voltage(adc->vref);
-		*val = vref_uv / 1000;
+		ret = regulator_get_voltage(adc->vref);
+		if (ret < 0)
+			return ret;
+		*val = ret / 1000;
 		*val2 = 12;
 		return IIO_VAL_FRACTIONAL_LOG2;
 
-- 
2.36.1

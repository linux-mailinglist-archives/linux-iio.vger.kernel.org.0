Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6340E57B9B8
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jul 2022 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiGTPcU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 20 Jul 2022 11:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbiGTPcI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2022 11:32:08 -0400
Received: from mail.actia.se (212-181-117-226.customer.telia.com [212.181.117.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A73A62A57
        for <linux-iio@vger.kernel.org>; Wed, 20 Jul 2022 08:31:56 -0700 (PDT)
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Wed, 20 Jul
 2022 17:31:55 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.009; Wed, 20 Jul 2022 17:31:54 +0200
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
Subject: [PATCH v2] iio: adc: imx8qxp-adc: propagate regulator_get_voltage
 error
Thread-Topic: [PATCH v2] iio: adc: imx8qxp-adc: propagate
 regulator_get_voltage error
Thread-Index: AQHYnE3Xz9QVleWy3UC4SkgZRCMNew==
Date:   Wed, 20 Jul 2022 15:31:54 +0000
Message-ID: <20220720153136.3502440-1-martin.larsson@actia.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.37.1
x-originating-ip: [10.12.12.22]
x-esetresult: clean, is OK
x-esetid: 37303A29D5529E56677761
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

Acked-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Martin Larsson <martin.larsson@actia.se>
---
v2:
  - Added missing Signed-off-by (Fabio)
  - Collected Haibo's Acked-by

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
2.37.1

Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB1D151890
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2020 11:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgBDKLD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 05:11:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3742 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726406AbgBDKLC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Feb 2020 05:11:02 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014A7pCl011088;
        Tue, 4 Feb 2020 11:10:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=ZLFMFNe2ixUJM51GFxjwpcgrGZTCYwGU8LdeMcBXz/0=;
 b=gNNg9TgIkx4I+fxGBiNp2KOcwrBBRQXGCMimIU4ld2CvpPrwXb3INFZTT/ymXLBWSIca
 htMUuVkXGH5A4VK6Sg4tXCiKy8ElVcK9VAsbnktSmECv2biWIE1B9g/S0BKllJ23tRIB
 C2eYcli2lBXF5JZ3cNce8ak1dHbD4fF0H3c8x2aqs1XHyTGSKu6W3XjLdyv07j7OE2oA
 XRucC2rd1wDqQpjH1mFaSoj69kIC3ThCuFb2aEz2WQwPfxle0wPFgctqcKSrWc7k2hnu
 cioTS/vxDNhEZVNHU3UJTq4I4HMI+cHxygeXql0osoaVvu3kD7ifpsIo/1ErX94CqXND yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xvybe0hhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 11:10:37 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 00E1A100039;
        Tue,  4 Feb 2020 11:10:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DABD92AD9DB;
        Tue,  4 Feb 2020 11:10:31 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 4 Feb 2020 11:10:31
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <olivier.moysan@st.com>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/4] iio: adc: sd modulator: add scale support
Date:   Tue, 4 Feb 2020 11:10:06 +0100
Message-ID: <20200204101008.11411-3-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204101008.11411-1-olivier.moysan@st.com>
References: <20200204101008.11411-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_02:2020-02-04,2020-02-04 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add scale support to sigma delta modulator.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 drivers/iio/adc/sd_adc_modulator.c | 108 ++++++++++++++++++++++++++---
 1 file changed, 100 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
index 560d8c7d9d86..a83f35832050 100644
--- a/drivers/iio/adc/sd_adc_modulator.c
+++ b/drivers/iio/adc/sd_adc_modulator.c
@@ -10,8 +10,7 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
-
-static const struct iio_info iio_sd_mod_iio_info;
+#include <linux/regulator/consumer.h>
 
 static const struct iio_chan_spec iio_sd_mod_ch = {
 	.type = IIO_VOLTAGE,
@@ -21,34 +20,126 @@ static const struct iio_chan_spec iio_sd_mod_ch = {
 		.realbits = 1,
 		.shift = 0,
 	},
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+};
+
+static const struct iio_chan_spec iio_sd_mod_ch_ads = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.scan_type = {
+		.sign = 'u',
+		.realbits = 1,
+		.shift = 0,
+	},
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+	.differential = 1,
+};
+
+struct iio_sd_mod_priv {
+	struct regulator *vref;
+	int vref_mv;
+};
+
+static int iio_sd_mod_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan, int *val,
+			       int *val2, long mask)
+{
+	struct iio_sd_mod_priv *priv = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*val = priv->vref_mv;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info iio_sd_mod_iio_info = {
+	.read_raw = iio_sd_mod_read_raw,
 };
 
 static int iio_sd_mod_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct iio_sd_mod_priv *priv;
 	struct iio_dev *iio;
+	int ret;
 
-	iio = devm_iio_device_alloc(dev, 0);
+	iio = devm_iio_device_alloc(dev, sizeof(*priv));
 	if (!iio)
 		return -ENOMEM;
 
+	iio->channels = (const struct iio_chan_spec *)
+					of_device_get_match_data(&pdev->dev);
+
+	priv = iio_priv(iio);
+
 	iio->dev.parent = dev;
 	iio->dev.of_node = dev->of_node;
 	iio->name = dev_name(dev);
 	iio->info = &iio_sd_mod_iio_info;
 	iio->modes = INDIO_BUFFER_HARDWARE;
-
 	iio->num_channels = 1;
-	iio->channels = &iio_sd_mod_ch;
 
 	platform_set_drvdata(pdev, iio);
 
-	return devm_iio_device_register(&pdev->dev, iio);
+	priv->vref = devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(priv->vref)) {
+		ret = PTR_ERR(priv->vref);
+		if (ret != -ENODEV) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "vref get failed, %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (!IS_ERR(priv->vref)) {
+		ret = regulator_enable(priv->vref);
+		if (ret < 0) {
+			dev_err(dev, "vref enable failed %d\n", ret);
+			return ret;
+		}
+
+		ret = regulator_get_voltage(priv->vref);
+		if (ret < 0) {
+			dev_err(dev, "vref get failed, %d\n", ret);
+			goto err_regulator_disable;
+		}
+
+		priv->vref_mv = ret / 1000;
+		dev_dbg(dev, "vref+=%dmV\n", priv->vref_mv);
+	}
+
+	ret = devm_iio_device_register(&pdev->dev, iio);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register sd-modulator, %d\n", ret);
+		goto err_regulator_disable;
+	}
+
+	return 0;
+
+err_regulator_disable:
+	regulator_disable(priv->vref);
+
+	return ret;
+}
+
+static int iio_sd_mod_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct iio_sd_mod_priv *priv = iio_priv(indio_dev);
+
+	if (priv->vref)
+		return regulator_disable(priv->vref);
+
+	return 0;
 }
 
 static const struct of_device_id sd_adc_of_match[] = {
-	{ .compatible = "sd-modulator" },
-	{ .compatible = "ads1201" },
+	{ .compatible = "sd-modulator", .data = &iio_sd_mod_ch },
+	{ .compatible = "ads1201", .data = &iio_sd_mod_ch_ads },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sd_adc_of_match);
@@ -59,6 +150,7 @@ static struct platform_driver iio_sd_mod_adc = {
 		.of_match_table = of_match_ptr(sd_adc_of_match),
 	},
 	.probe = iio_sd_mod_probe,
+	.remove = iio_sd_mod_remove,
 };
 
 module_platform_driver(iio_sd_mod_adc);
-- 
2.17.1


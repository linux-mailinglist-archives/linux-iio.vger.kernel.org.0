Return-Path: <linux-iio+bounces-7322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B30E927AB8
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 17:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED4828635C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7C41B14F0;
	Thu,  4 Jul 2024 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="qoowIqh3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691481B14E2;
	Thu,  4 Jul 2024 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108719; cv=none; b=iMZ0o3RdgiqUsuA5g6WMHCT9Bpi4E3AT8IXb9CoXE9uGkVcp90v3pPX2avFouQUJI2DdH0aBinHepFhhmnlYaItYQnzj/Yne5ypgofy269M46pOoQ7iXvqdaYYdEO9heTEHkz2QKXrkOPma249KQ22/46QFDJwzzPfa+X2F5gXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108719; c=relaxed/simple;
	bh=safQY3Fn2zFb/VG4MzyuKw0omUP5p5cGxwB+mZRfmGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRcgHZAMojCTPU48B46R0uBMRPCGTworcWTmzL1zoTpKae3vf8cbpM92YyIzd/mUl7i8xZfZ/bBlp6nrv35sKB89obdR/IjS+6q9APXirFv9FkY8YODBnF0HEy7koWc1Z2ui8uJvbsWAiOMWViVu3oLspQKYUXxJ7hceBic85WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=qoowIqh3; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464ElubJ013845;
	Thu, 4 Jul 2024 17:58:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	EfcaGHRE0IyvisjBYwh0Vxzl024Zih/W8ulbiu0kQPk=; b=qoowIqh3fOswWhg1
	05m1JTWETvk7k6LT9MCMdAxuWigviDP0q35CVBMTZttlnj4Pt5HdiTMVAU2hYmfx
	mJJc2Sq//CoiZOdDXUf2eFmRrGsqRHWoyrgkijSP7FuEDHu9oWjXJb7yXZtj0BhR
	NLwxYBLVQ1H9lJFqgAfg6xKaAdzgOFvSJKQPnHMAOYFklYcsJV8pz9c0gIC1Fv+e
	rhr9Oyim2dD9Vy0Y7nMfw8yrSyf5W2E/WE2kKe3z0062Xia+HvMcKY4E5+x/5DWl
	XAUQSZXhvekottNx0/I0S38M67pfY3nxskCQ4Lm5glGIcHF0mG+cH0PR+oVvsmG4
	AhriUg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 402w7jbg5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 17:58:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 57A1F40044;
	Thu,  4 Jul 2024 17:58:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F087D229A66;
	Thu,  4 Jul 2024 17:57:51 +0200 (CEST)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Jul
 2024 17:57:51 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 7/8] iio: add iio backend support to sd modulator
Date: Thu, 4 Jul 2024 17:53:35 +0200
Message-ID: <20240704155338.2387858-8-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704155338.2387858-1-olivier.moysan@foss.st.com>
References: <20240704155338.2387858-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01

The legacy sd modulator driver registers the sigma delta modulator as
an IIO channel provider. This implementation is not convenient when the
SD modulator has to be cascaded with another IIO device. The scaling
information is distributed across devices, which makes it difficult to
report consistent scaling data on IIO devices.

The solution is to expose these cascaded IIO devices as an aggregate
device, which report global scaling information.
Add IIO backend support to SD modulator to allow scaling information
management.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/Kconfig            |  1 +
 drivers/iio/adc/sd_adc_modulator.c | 92 +++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f60fe85a30d5..14b1773f02d9 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1171,6 +1171,7 @@ config SD_ADC_MODULATOR
 	tristate "Generic sigma delta modulator"
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select IIO_BACKEND
 	help
 	  Select this option to enables sigma delta modulator. This driver can
 	  support generic sigma delta modulators.
diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
index 327cc2097f6c..06f9c5cacd53 100644
--- a/drivers/iio/adc/sd_adc_modulator.c
+++ b/drivers/iio/adc/sd_adc_modulator.c
@@ -6,11 +6,14 @@
  * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>.
  */
 
+#include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
 
 static const struct iio_info iio_sd_mod_iio_info;
 
@@ -24,7 +27,54 @@ static const struct iio_chan_spec iio_sd_mod_ch = {
 	},
 };
 
-static int iio_sd_mod_probe(struct platform_device *pdev)
+struct iio_sd_backend_priv {
+	struct regulator *vref;
+	int vref_mv;
+};
+
+static int iio_sd_mod_enable(struct iio_backend *backend)
+{
+	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
+
+	if (priv->vref)
+		return regulator_enable(priv->vref);
+
+	return 0;
+};
+
+static void iio_sd_mod_disable(struct iio_backend *backend)
+{
+	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
+
+	if (priv->vref)
+		regulator_disable(priv->vref);
+};
+
+static int iio_sd_mod_read(struct iio_backend *backend, struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*val = priv->vref_mv;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 0;
+		return IIO_VAL_INT;
+	}
+
+	return -EOPNOTSUPP;
+};
+
+static const struct iio_backend_ops sd_backend_ops = {
+	.enable = iio_sd_mod_enable,
+	.disable = iio_sd_mod_disable,
+	.read_raw = iio_sd_mod_read,
+};
+
+static int iio_sd_mod_register(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct iio_dev *iio;
@@ -45,6 +95,45 @@ static int iio_sd_mod_probe(struct platform_device *pdev)
 	return devm_iio_device_register(&pdev->dev, iio);
 }
 
+static int iio_sd_mod_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regulator *vref;
+	struct iio_sd_backend_priv *priv;
+	int ret;
+
+	/* If sd modulator is not defined as an IIO backend device, fallback to legacy */
+	if (!device_property_present(dev, "#io-backend-cells"))
+		return iio_sd_mod_register(pdev);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/*
+	 * Get regulator reference if any, but don't enable regulator right now.
+	 * Rely on enable and disable callbacks to manage regulator power.
+	 */
+	vref = devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(vref)) {
+		if (PTR_ERR(vref) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(vref), "Failed to get vref\n");
+	} else {
+		/*
+		 * Retrieve voltage right now, as regulator_get_voltage() provides it whatever
+		 * the state of the regulator.
+		 */
+		ret = regulator_get_voltage(vref);
+		if (ret < 0)
+			return ret;
+
+		priv->vref = vref;
+		priv->vref_mv = ret / 1000;
+	}
+
+	return devm_iio_backend_register(&pdev->dev, &sd_backend_ops, priv);
+};
+
 static const struct of_device_id sd_adc_of_match[] = {
 	{ .compatible = "sd-modulator" },
 	{ .compatible = "ads1201" },
@@ -65,3 +154,4 @@ module_platform_driver(iio_sd_mod_adc);
 MODULE_DESCRIPTION("Basic sigma delta modulator");
 MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_BACKEND);
-- 
2.25.1



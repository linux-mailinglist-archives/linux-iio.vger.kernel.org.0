Return-Path: <linux-iio+bounces-6902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52763916CB6
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75CFE1C21B70
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD0C1791EB;
	Tue, 25 Jun 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VqHdXESZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289317085B;
	Tue, 25 Jun 2024 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328352; cv=none; b=NWivNpRUm4/fGEArdh2Csau6Vd6X9l/UrhbCR7hJJZHl9/U1dgYVOWqmNzMOGJ8EoLE05AnKp3iqGBN6svzKYNhCabVb2Dx82v8VO7XgOShQkgAz+oH/AyMxn+9Q+WZQRy/AAYyQLxyu6dogPIYQJ0X5y/RPfY+S2l3+etI0Oss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328352; c=relaxed/simple;
	bh=z+TPbwI4td5nu4bcRzClCrXqJH0SLlhW140+y5alurQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hb/+A7uXoGOGT0UzxkgLcrq/R2/rpEXnhL6ZzXYdgF8bAOhOaGgiNxcB60TX9QgBU/9cD67Y6G3w2nqkqdP6YBuslHrKyLsvO+JjBcKCAgXF+I4snHtj6FWi+qM5kjJiU3I1HvxGeu1NL+ojw8fgRO3db13KrqMFnKO5aObLLME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VqHdXESZ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PDDiEP017080;
	Tue, 25 Jun 2024 17:12:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ZczGLWJ6nzUL/Y1/1IVMb7BvAsFquCGZHcfctbcKngk=; b=VqHdXESZBLWhrNqX
	I/daNOGGyDMdsexDIszA2KzmTixQRQ0CrDnl1h88MZGYK2yJQds0n0BGth0x8sNU
	QWoxW8Ee4RrAjmN8OuApGmX/iUQVWmjfsphFNZbge5FIEu99o2Cna1hBgtlAkMiC
	gE3PJpmBtY4j8KOIbWBYN+j2o+NgEQHoSL3acz2Y/XbcfxbTmYGIadaiSIqILPLL
	ynGxT1RPQFFZTvc2Umb5N7q+5spjC4hMoitDh/zujkQxh78Q5y8ZfF65pQ8jW/oS
	IYu16UOtW9GoM7Rj1GEsbIwhucnikKCJnTHGX728W3H+ricUc2qrWSekbRPKtwYt
	350FaQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywnxxceyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:11:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 517864002D;
	Tue, 25 Jun 2024 17:10:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9071A21F0C6;
	Tue, 25 Jun 2024 17:10:34 +0200 (CEST)
Received: from localhost (10.252.26.63) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 25 Jun
 2024 17:10:34 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <fabrice.gasnier@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
CC: Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v2 7/8] iio: add sd modulator generic iio backend
Date: Tue, 25 Jun 2024 17:07:15 +0200
Message-ID: <20240625150717.1038212-8-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_10,2024-06-25_01,2024-05-17_01

Add a generic driver to support sigma delta modulators.
Typically, this device is a hardware connected to an IIO device
in charge of the conversion. The device is exposed as an IIO backend
device. This backend device and the associated conversion device
can be seen as an aggregate device from IIO framework.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/Kconfig          |  10 +++
 drivers/iio/adc/Makefile         |   1 +
 drivers/iio/adc/sd_adc_backend.c | 117 +++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 drivers/iio/adc/sd_adc_backend.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b8184706c7d1..634dc9842fb7 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1155,6 +1155,16 @@ config SPEAR_ADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called spear_adc.
 
+config SD_ADC_BACKEND
+	tristate "Generic sigma delta modulator IIO backend"
+	select IIO_BACKEND
+	help
+	  Select this option to enables sigma delta modulator. This driver can
+	  support generic sigma delta modulators, as IIO backend devices.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sd_adc_backend.
+
 config SD_ADC_MODULATOR
 	tristate "Generic sigma delta modulator"
 	select IIO_BUFFER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 51298c52b223..e9c4a4549fc0 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -140,3 +140,4 @@ obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
 obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
 xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
 obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
+obj-$(CONFIG_SD_ADC_BACKEND) += sd_adc_backend.o
diff --git a/drivers/iio/adc/sd_adc_backend.c b/drivers/iio/adc/sd_adc_backend.c
new file mode 100644
index 000000000000..b9f679c4792f
--- /dev/null
+++ b/drivers/iio/adc/sd_adc_backend.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generic sigma delta modulator IIO backend
+ *
+ * Copyright (C) 2024, STMicroelectronics - All Rights Reserved
+ */
+
+#include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+
+struct iio_sd_backend_priv {
+	struct regulator *vref;
+	int vref_mv;
+};
+
+static int sd_backend_enable(struct iio_backend *backend)
+{
+	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
+
+	if (priv->vref)
+		return regulator_enable(priv->vref);
+
+	return 0;
+};
+
+static void sd_backend_disable(struct iio_backend *backend)
+{
+	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
+
+	if (priv->vref)
+		regulator_disable(priv->vref);
+};
+
+static int sd_backend_read(struct iio_backend *backend, struct iio_chan_spec const *chan, int *val,
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
+	.enable = sd_backend_enable,
+	.disable = sd_backend_disable,
+	.read_raw = sd_backend_read,
+};
+
+static int iio_sd_backend_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regulator *vref;
+	struct iio_sd_backend_priv *priv;
+	int ret;
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
+static const struct of_device_id sd_backend_of_match[] = {
+	{ .compatible = "sd-backend" },
+	{ .compatible = "ti,ads1201" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sd_backend_of_match);
+
+static struct platform_driver iio_sd_backend_adc = {
+	.driver = {
+		.name = "iio_sd_adc_backend",
+		.of_match_table = sd_backend_of_match,
+	},
+	.probe = iio_sd_backend_probe,
+};
+
+module_platform_driver(iio_sd_backend_adc);
+
+MODULE_DESCRIPTION("Basic sigma delta modulator IIO backend");
+MODULE_AUTHOR("Olivier Moysan <olivier.moysan@foss.st.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_BACKEND);
-- 
2.25.1



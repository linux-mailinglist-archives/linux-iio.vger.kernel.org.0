Return-Path: <linux-iio+bounces-21503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E450AFFB15
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 09:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFF01700B7
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001A628A3E1;
	Thu, 10 Jul 2025 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="p5XXN1fi"
X-Original-To: linux-iio@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35928936C;
	Thu, 10 Jul 2025 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133156; cv=none; b=Nt5NqvU0kY1xPCCJS5jGtEaXtk/aGkgA4lrGkSCpmVTOx46CoOZYPPQdZ48LOkwX6hqOTV9uW98df9prmkLQB/u4aB+WEGzeL4TE1q9GNwgXdMvRub8hHclDR+GW6crvlaSDcvb6rilPfE+L9/lcjsRICVLujOsd7pvYkTbvVno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133156; c=relaxed/simple;
	bh=ASbDXvYEpvpA3dhPyIfiJOtn/utMb4WWmHLLlbdNe7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fc5Mtu96TwBH6zo8OHesShHqXkSp1znIEN4HWEeUoHntb8SV7l28tLRH5RdU7mSfAK8oAVXVXpTHZBJv7Am06zaKimvYajMAamHq6jVDAHDiOoM9mKvcEVwkNF0Qe0URf5YxkkPgvoyFw4o02HTATobM3yMnK4UOxKaPA79quaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=p5XXN1fi; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7kVCapFGdG0gRHQhSRUGUM3fGitSOZCS1rMndaGOheE=; b=p5XXN1fiONAQE6w4z3DXP0epP3
	W+0AnvD6kwo2+3JjLjBxGY2ZrvM47itZ94wu+zku2xmM+4D6/vm4TXUrKSb2vXZfCC++9LgTPxlu7
	sdnw8HXmtXvnJg6IEjUkrfcrocttP/kyWabdAUk39VKA2jbvUkSQp+4JLp2bx8AuPNg+nmL7672Nq
	BjxBJpWBc86PA5La/Vh9VTAIO3Rp5lq/YwnJLbJ6NM/p4ZmXyjBM4h2JokBH3C8qfFO1LcoBlnSPX
	dWNPrFbMPwzQdVQDAddi2AScEMrk6sluM2CbzgTQleOJ1NpzapCXPyQUWdXCTuZPbTLy9T75I0kiG
	nmfSMtug==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:48064 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1uZls3-006IV5-1A;
	Thu, 10 Jul 2025 09:39:06 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	andrej.picej@norik.com
Subject: [PATCH 2/2] iio: adc: imx93: Make calibration parameters configurable
Date: Thu, 10 Jul 2025 09:39:04 +0200
Message-Id: <20250710073905.1105417-3-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710073905.1105417-1-primoz.fiser@norik.com>
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Andrej Picej <andrej.picej@norik.com>

Make i.MX93 ADC calibration parameters:
 - AVGEN: Enable calibration averaging function,
 - NRSMPL: Select number of calibration samples,
 - TSAMP: Select sample time of calibration conversions,

in the MCR register configurable with the corresponding device-tree
properties:
 - nxp,calib-avg-en,
 - nxp,calib-nr-samples and
 - nxp,calib-t-sample.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 drivers/iio/adc/imx93_adc.c | 75 ++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index 7feaafd2316f..da9b5c179240 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/property.h>
 
 #define IMX93_ADC_DRIVER_NAME	"imx93-adc"
 
@@ -43,6 +44,9 @@
 #define IMX93_ADC_MCR_MODE_MASK			BIT(29)
 #define IMX93_ADC_MCR_NSTART_MASK		BIT(24)
 #define IMX93_ADC_MCR_CALSTART_MASK		BIT(14)
+#define IMX93_ADC_MCR_AVGEN_MASK		BIT(13)
+#define IMX93_ADC_MCR_NRSMPL_MASK		GENMASK(12, 11)
+#define IMX93_ADC_MCR_TSAMP_MASK		GENMASK(10, 9)
 #define IMX93_ADC_MCR_ADCLKSE_MASK		BIT(8)
 #define IMX93_ADC_MCR_PWDN_MASK			BIT(0)
 #define IMX93_ADC_MSR_CALFAIL_MASK		BIT(30)
@@ -145,7 +149,7 @@ static void imx93_adc_config_ad_clk(struct imx93_adc *adc)
 
 static int imx93_adc_calibration(struct imx93_adc *adc)
 {
-	u32 mcr, msr;
+	u32 mcr, msr, val, reg;
 	int ret;
 
 	/* make sure ADC in power down mode */
@@ -156,12 +160,73 @@ static int imx93_adc_calibration(struct imx93_adc *adc)
 	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_ADCLKSE_MASK, 1);
 	writel(mcr, adc->regs + IMX93_ADC_MCR);
 
-	imx93_adc_power_up(adc);
-
 	/*
-	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
-	 * can add the setting of these bit if need in future.
+	 * Optionally configure desired ADC calibration settings in MCR
+	 * - MCR[AVGEN]: Enable/disable calibration averaging function (default: on)
+	 * - MCR[NRSMPL]: Select the number of calibration samples (default: 512)
+	 * - MCR[TSAMP]: Select sample time of calibration conversions (default: 22)
 	 */
+	ret = device_property_read_u32(adc->dev, "nxp,calib-avg-en", &val);
+	if (!ret) {
+		if (val != 0 && val != 1) {
+			dev_err(adc->dev, "invalid nxp,calib-avg-en: %d\n", val);
+			return -EINVAL;
+		}
+		reg = val;
+		mcr &= ~IMX93_ADC_MCR_AVGEN_MASK;
+		mcr |= FIELD_PREP(IMX93_ADC_MCR_AVGEN_MASK, reg);
+	}
+
+	ret = device_property_read_u32(adc->dev, "nxp,calib-nr-samples", &val);
+	if (!ret) {
+		switch (val) {
+		case 16:
+			reg = 0x0;
+			break;
+		case 32:
+			reg = 0x1;
+			break;
+		case 128:
+			reg = 0x2;
+			break;
+		case 512:
+			reg = 0x3;
+			break;
+		default:
+			dev_err(adc->dev, "invalid nxp,calib-nr-samples: %d\n", val);
+			return -EINVAL;
+		}
+		mcr &= ~IMX93_ADC_MCR_NRSMPL_MASK;
+		mcr |= FIELD_PREP(IMX93_ADC_MCR_NRSMPL_MASK, reg);
+	}
+
+	ret = device_property_read_u32(adc->dev, "nxp,calib-t-sample", &val);
+	if (!ret) {
+		switch (val) {
+		case 8:
+			reg = 0x1;
+			break;
+		case 16:
+			reg = 0x2;
+			break;
+		case 22:
+			reg = 0x0;
+			break;
+		case 32:
+			reg = 0x3;
+			break;
+		default:
+			dev_err(adc->dev, "invalid nxp,calib-t-sample: %d\n", val);
+			return -EINVAL;
+		}
+		mcr &= ~IMX93_ADC_MCR_TSAMP_MASK;
+		mcr |= FIELD_PREP(IMX93_ADC_MCR_TSAMP_MASK, reg);
+	}
+
+	/* write calibration settings to MCR */
+	writel(mcr, adc->regs + IMX93_ADC_MCR);
+
+	imx93_adc_power_up(adc);
 
 	/* run calibration */
 	mcr = readl(adc->regs + IMX93_ADC_MCR);
-- 
2.34.1



Return-Path: <linux-iio+bounces-22273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878FEB19F5A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 12:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A920B17B76F
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAF0248176;
	Mon,  4 Aug 2025 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ENr7FJU8"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6622A2288EE;
	Mon,  4 Aug 2025 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301824; cv=none; b=ENaDSIbMC4h+Eeeck2JImSIye3gD5q6Ss9oOAslO8i/fE99gOHVAN0wD5D/O6qEit3ZpLMHDuSyS354VkxymCrwc2n99Nov0dS39JzbC3F4ZhLXKY39zWt2227A93G6v6DUbXq8GlKmSiclI+5UxWORZFdgAaRCKn5Xk1NKi/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301824; c=relaxed/simple;
	bh=6W4F2tMrJ4fQ3+1dSbKRAr9IS7Qo3RdtktFxwVVRt40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZGG7fY3KkCYU5R3dhsOz8BfUTc2ENtJWyUK4gpzx6iVFiWX2UyaK8+u3TWkmMWtTlzaKtdJNtKhmkUsNxQ96pPj3QnBm26qGK5UVn3HO1CePYWDTE70yffhzmYPHvdpoFmg6h7zFQGpW4QQnrIYPCYS9rsOMjHi41/pqsEo85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ENr7FJU8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754301822; x=1785837822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6W4F2tMrJ4fQ3+1dSbKRAr9IS7Qo3RdtktFxwVVRt40=;
  b=ENr7FJU828nLqgO/UEqDus4m2g9MW4xDkpS1oRXS/xdxWZz9EYkLoyOt
   6fHgSwBMOJ0try/OgbUYZt+yqYbZkzfvgi3v5Kg+vxB3N09xQmKZsRQI/
   Lk4dtN70CFAdi9p8p9eIc3UuIzKTsgvRsUxlF/ME8YcUc5JQBd/tNb2RC
   swjKArOplx+xgDHizTA+jWod7N173Wk1xmsezlpszNqUERKajmQqp8yM2
   Uk6kU6eEpZQVaDZ7rw1lc+Tke1JLzkkqFfaEh6dNRZDIIGW44cvS8pOV1
   qX83zaT8WRg00fSiA7O6XTQg4RGZW391tHgM7hgaZ+TGNIYhcedk4Cd+1
   g==;
X-CSE-ConnectionGUID: E6rlgp6tRPCj0Q8ccA/Yqg==
X-CSE-MsgGUID: nhnyn57ETHaYkg3E28HNcw==
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="44245519"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2025 03:03:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 4 Aug 2025 03:03:25 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 4 Aug 2025 03:03:19 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH 09/15] iio: adc: at91-sama5d2_adc: adapt the driver for sama7d65
Date: Mon, 4 Aug 2025 15:32:13 +0530
Message-ID: <20250804100219.63325-10-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804100219.63325-1-varshini.rajendran@microchip.com>
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support to sama7d65 ADC. The differences are highlighted with the
compatible. The init and parsing of the temperature sensor and
calibration indexes are the main differences.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 94 ++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 916682e326c7..909841b84834 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -456,6 +456,8 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 struct at91_adc_state;
 static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 				     struct device *dev);
+static int at91_sama7d65_adc_temp_sensor_init(struct at91_adc_state *st,
+					      struct device *dev);
 
 /**
  * struct at91_adc_platform - at91-sama5d2 platform information struct
@@ -525,6 +527,20 @@ enum at91_adc_ts_clb_idx {
 	AT91_ADC_TS_CLB_IDX_MAX = 18,
 };
 
+/**
+ * enum at91_sama7d65_adc_ts_clb_idx - calibration indexes in sama7d65 NVMEM buffer
+ * @AT91_SAMA7D65_ADC_TS_CLB_IDX_P1: index for FT1_TEMP equivalent to P1 * (10 ^ 6)
+ * @AT91_SAMA7D65_ADC_TS_CLB_IDX_P4: index for FT1_VPAT equivalent to P4
+ * @AT91_SAMA7D65_ADC_TS_CLB_IDX_P6: index for FT2_VBG equivalent to P6
+ * @AT91_SAMA7D65_ADC_TS_CLB_IDX_MAX: max index for temperature calibration packet in OTP
+ */
+enum at91_sama7d65_adc_ts_clb_idx {
+	AT91_SAMA7D65_ADC_TS_CLB_IDX_P1 = 2,
+	AT91_SAMA7D65_ADC_TS_CLB_IDX_P4 = 1,
+	AT91_SAMA7D65_ADC_TS_CLB_IDX_P6 = 4,
+	AT91_SAMA7D65_ADC_TS_CLB_IDX_MAX = 10,
+};
+
 /* Temperature sensor calibration - Vtemp voltage sensitivity to temperature. */
 #define AT91_ADC_TS_VTEMP_DT		(2080U)
 
@@ -764,6 +780,31 @@ static const struct at91_adc_platform sama7g5_platform = {
 	.temp_init = at91_adc_temp_sensor_init,
 };
 
+static const struct at91_adc_platform sama7d65_platform = {
+	.layout = &sama7g5_layout,
+	.adc_channels = &at91_sama7g5_adc_channels,
+#define AT91_SAMA7D65_SINGLE_CHAN_CNT	16
+#define AT91_SAMA7D65_DIFF_CHAN_CNT	8
+#define AT91_SAMA7D65_TEMP_CHAN_CNT	1
+	.nr_channels = AT91_SAMA7D65_SINGLE_CHAN_CNT +
+		       AT91_SAMA7D65_DIFF_CHAN_CNT +
+		       AT91_SAMA7D65_TEMP_CHAN_CNT,
+#define AT91_SAMA7D65_MAX_CHAN_IDX	(AT91_SAMA7D65_SINGLE_CHAN_CNT + \
+					AT91_SAMA7D65_DIFF_CHAN_CNT + \
+					AT91_SAMA7D65_TEMP_CHAN_CNT)
+	.max_channels = ARRAY_SIZE(at91_sama7g5_adc_channels),
+	.max_index = AT91_SAMA7D65_MAX_CHAN_IDX,
+#define AT91_SAMA7G5_HW_TRIG_CNT	3
+	.hw_trig_cnt = AT91_SAMA7G5_HW_TRIG_CNT,
+	.osr_mask = GENMASK(18, 16),
+	.oversampling_avail = { 1, 4, 16, 64, 256, },
+	.oversampling_avail_no = 5,
+	.chan_realbits = 16,
+	.temp_sensor = true,
+	.temp_chan = AT91_SAMA7G5_ADC_TEMP_CHANNEL,
+	.temp_init = at91_sama7d65_adc_temp_sensor_init,
+};
+
 static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
 {
 	int i;
@@ -2319,6 +2360,56 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 	return ret;
 }
 
+static int at91_sama7d65_adc_temp_sensor_init(struct at91_adc_state *st,
+					      struct device *dev)
+{
+	struct at91_adc_temp_sensor_clb *clb = &st->soc_info.temp_sensor_clb;
+	struct nvmem_cell *temp_calib;
+	u32 *buf = NULL;
+	size_t len;
+	int ret = 0;
+
+	if (!st->soc_info.platform->temp_sensor)
+		return 0;
+
+	/* Get the calibration data from NVMEM. */
+	temp_calib = devm_nvmem_cell_get(dev, "temperature_calib");
+	if (IS_ERR(temp_calib)) {
+		ret = PTR_ERR(temp_calib);
+		if (ret != -ENOENT)
+			dev_err(dev, "Failed to get temperature_calib cell!\n");
+		return ret;
+	}
+
+	buf = nvmem_cell_read(temp_calib, &len);
+	if (IS_ERR(buf)) {
+		dev_err(dev, "Failed to read calibration data!\n");
+		return PTR_ERR(buf);
+	}
+
+	if (len < AT91_SAMA7D65_ADC_TS_CLB_IDX_MAX * sizeof(u32) ||
+	    buf[0] != AT91_TEMP_CALIB_TAG) {
+		dev_err(dev, "Invalid calibration data!\n");
+		ret = -EINVAL;
+		goto free_buf;
+	}
+
+	/* Store calibration data for later use. */
+	clb->p1 = buf[AT91_SAMA7D65_ADC_TS_CLB_IDX_P1];
+	clb->p4 = buf[AT91_SAMA7D65_ADC_TS_CLB_IDX_P4];
+	clb->p6 = buf[AT91_SAMA7D65_ADC_TS_CLB_IDX_P6];
+
+	/*
+	 * We prepare here the conversion to milli from micro to avoid
+	 * doing it on hotpath.
+	 */
+	clb->p1 = clb->p1 / 1000;
+
+free_buf:
+	kfree(buf);
+	return ret;
+}
+
 static int at91_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -2633,6 +2724,9 @@ static const struct of_device_id at91_adc_dt_match[] = {
 	}, {
 		.compatible = "microchip,sama7g5-adc",
 		.data = (const void *)&sama7g5_platform,
+	}, {
+		.compatible = "microchip,sama7d65-adc",
+		.data = (const void *)&sama7d65_platform,
 	}, {
 		/* sentinel */
 	}
-- 
2.34.1



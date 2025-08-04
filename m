Return-Path: <linux-iio+bounces-22268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FBAB19F47
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 12:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFDE8189CD0F
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DC9253B47;
	Mon,  4 Aug 2025 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JoCXiucg"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9458124E4C3;
	Mon,  4 Aug 2025 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301796; cv=none; b=Ia9oeL1x9/4cOOKWk+jTloPzeiL/sXAKHBZzEMaPTmOiwQ58JMBDDjHe5+VRH7HzW+5Jj6uLBD62pdJp+jV1IQVnv+cJ7sJPyrR+Ssq2hKeY6LOL61DOkSd2vlhGnTQWnEjwlkjS+gyf9A+2wwiL0fJDe5lOxCglDb2rNO+mhoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301796; c=relaxed/simple;
	bh=Co7gfwT4mHYrZjebZQxjjmc0VfEU+S5rAP9qwyGGqg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+Arcwktjn029zjKUlVrv+ikeF7f3R8mcXZsrvgS92e0TxjMQcLYTjScKdKJWjCEEX2Ec6OVx43f2gjgh2Hq4t8tWoGxzazhxRTbw4JbwdH3HRkZVd2FyC9YiAgx+dlpkIFmTAbyXXL843DxHLQ1Py6wQ26PzbpKprArZ+yG9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JoCXiucg; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754301794; x=1785837794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Co7gfwT4mHYrZjebZQxjjmc0VfEU+S5rAP9qwyGGqg8=;
  b=JoCXiucgXHGfXMpq+zCct1UMFDNtwYqKgxx+S3dpQbQD3rORFr5aDHBN
   uCFLb7V3JAkm+Jr/2lvQ9TrWOur46PfkaC1BRs7ROSAcgNXGutlkLvzEH
   qqe0r2pgkDjQzNfXZOU2i1bN6dkE2zqSO79rNrtknGwZcGFQ9eK9/bROd
   /LQ5w2M4aZk13EN7w7/UzXfqv9YI3iCqyTdziFuWUGvPfutVTqXeJX2P6
   aSa1HNfNFWNbLPV/N8XjgeLP+Ud45T5jQClhxD8pt34ftn6elLxG8nnsv
   7AnaQ8LMWWcFhb3m9SzjqyLeaAftVs4iZOtGeHPzzNw8YpdE6I8OdaVXX
   w==;
X-CSE-ConnectionGUID: Liqowa5KRuKZ85yXFKRAhg==
X-CSE-MsgGUID: V6sbAXJ8TPW8PGSA1Xm7yg==
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="50182876"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2025 03:03:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 4 Aug 2025 03:02:54 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 4 Aug 2025 03:02:48 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH 04/15] iio: adc: at91-sama5d2_adc: update calibration index, validation condition
Date: Mon, 4 Aug 2025 15:32:08 +0530
Message-ID: <20250804100219.63325-5-varshini.rajendran@microchip.com>
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

Add additional condition for validating the calibration data read from
the OTP through nvmem device interface. Adjust the calibration indexes
of sama7g5 according to the buffer received from the OTP memory.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index c3450246730e..d952109a64a9 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -445,6 +445,14 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 #define at91_adc_writel(st, reg, val)					\
 	writel_relaxed(val, (st)->base + (st)->soc_info.platform->layout->reg)
 
+/*
+ * The calibration data has a TAG to recognize the packet
+ * The tag has a constant value "ACST" with the ASCII
+ * equivalent 0x41435354. This is used to validate the
+ * calibration data obtained from the OTP.
+ */
+#define AT91_TEMP_CALIB_TAG	0x41435354
+
 /**
  * struct at91_adc_platform - at91-sama5d2 platform information struct
  * @layout:		pointer to the reg layout struct
@@ -504,10 +512,10 @@ struct at91_adc_temp_sensor_clb {
  * @AT91_ADC_TS_CLB_IDX_MAX: max index for temperature calibration packet in OTP
  */
 enum at91_adc_ts_clb_idx {
-	AT91_ADC_TS_CLB_IDX_P1 = 2,
-	AT91_ADC_TS_CLB_IDX_P4 = 5,
-	AT91_ADC_TS_CLB_IDX_P6 = 7,
-	AT91_ADC_TS_CLB_IDX_MAX = 19,
+	AT91_ADC_TS_CLB_IDX_P1 = 1,
+	AT91_ADC_TS_CLB_IDX_P4 = 4,
+	AT91_ADC_TS_CLB_IDX_P6 = 6,
+	AT91_ADC_TS_CLB_IDX_MAX = 18,
 };
 
 /* Temperature sensor calibration - Vtemp voltage sensitivity to temperature. */
@@ -2281,7 +2289,7 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 		dev_err(dev, "Failed to read calibration data!\n");
 		return PTR_ERR(buf);
 	}
-	if (len < AT91_ADC_TS_CLB_IDX_MAX * 4) {
+	if (len < AT91_ADC_TS_CLB_IDX_MAX * 4  || buf[0] != AT91_TEMP_CALIB_TAG) {
 		dev_err(dev, "Invalid calibration data!\n");
 		ret = -EINVAL;
 		goto free_buf;
-- 
2.34.1



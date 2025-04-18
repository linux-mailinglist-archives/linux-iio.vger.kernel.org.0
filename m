Return-Path: <linux-iio+bounces-18298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E89DA93E8D
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 22:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAB68E55C0
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499ED2459D6;
	Fri, 18 Apr 2025 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QGXCPTCF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEEA2417E6
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006397; cv=none; b=pQ2hc09IXwF+BARyb32J6LHUepXEULI70H5CSy83jANjpQhMaOHqwN9wISFk3Gb6ENaW/xnCy8HO62IwXTbledKT29Uh2oYnP5fZtbTYMWjI9wajoLg2ria4qLxlTZ3QSfmypjddAmLKZO4258Ov8PDIIQPCnU9mJCa+hXQo1qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006397; c=relaxed/simple;
	bh=lY3P/BHYMrMzt2KYi0LGUhjMzgl6dv5K0V1qFBaK3Yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GGuSHeIip1qt74aWdWWt7pRdCCbhlLfh6HOSyO2PjDPSMz6jqIH2rfyL2U1ev5zvPl2jW3Ea03FU2ST5bTXeLmjXyBBZviG2/9HLAYtxuH5oTXtQWYeExhTC2PgjRJNMGoD963Tfg196xLoe9RcwVS5xCxPB7CxzfSWWScxLPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QGXCPTCF; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72b82c8230aso656374a34.2
        for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745006394; x=1745611194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzSqK4qY9zcb2u1Jy55Elop5xlKMZ/WslrYn6ETdgHk=;
        b=QGXCPTCFzMRL0oCXAZNcwD91WxSxMzDlUg84qoJ4yoa/jti5RUnjaEYqUz9vsLLVHW
         3aZkaocnjsoLHnWpsSj4YSKBwRW+oMtQE9V5rPtNWWIop+Yq+eAbzavxl2gOKihmKP5S
         Tl2uUPk9JHSo3n1wms52im4UflROZtIKWWN7zuLUjzeM3R/97xuek0NpbV84vc9cDoB4
         POoC1MmiW9K2bCjT2sP8moQj9ZX+rRgSx3G5r9pdQP3l091Ukb0x2ApZEMED3/bDr39G
         MUIX+Ubp7+U3FUv0dj9MLVOrRnA+zBu4Vhtxy6uuMtbPqEEEdHGixB1CQsxUApn9PxbP
         98hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745006394; x=1745611194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzSqK4qY9zcb2u1Jy55Elop5xlKMZ/WslrYn6ETdgHk=;
        b=uotfQImCgaSOdjepNGsFZE/olgiScTXLE1YoZHjygWeUqIPDBGqUJCVK/w6F0hqTsU
         kXpFZXaG+BWotc3OLR8do8dvCqIskb6NRbBpdGRp6itPEEsxlwz6BfOqJre6HXpEJDWh
         T9IpBbqIjfSfG0yT3skpw+10mtJuFBSXwzuiwATtL5tcH4uIbbPmvMR4/QqnlULANg9E
         HgfiJ++rvYUvdCWHyz5tqRjS1fU0cvUEdtZPAO+qzssp6jL2DIxFbTUWpVyHUmXOAemd
         MdVOy+kPRI/iG+QkhVEpknjhDWWYtkRkSrW2qnj23tjIqCRkvvRIQZtY/UM2cohMbZyG
         bhpQ==
X-Gm-Message-State: AOJu0YwKjdUc0NaNkAaxgKJqBJhorzaAV+3DT6BS/3r9fg7yEj7UO+eW
	QrvA27h4QLoCn7ElsCBKyubb+tqqks0g8EzhiwWBL5E/7MANV8uOMoofJWrdvmt63f6uvAkuUDS
	ZPOs=
X-Gm-Gg: ASbGncutUdQiajS1Pkt+Kv6CnMS+ddWQjew9/9ZRzBUt3ZGXGW1MG8spn7YZHOWxcC6
	xVLhADNRfdmZlWzru5GbOm1brJXyxc+xcG9D6yc7AdS10MgG4+79rKOprtpHQPm+J/d85rRGhH5
	FNVlnMME0iAIgRYBQ3UnRTiYsuBZdHkQRH/hTqgwuro57dSmGgybTfHuNFAFNsazl6fzpQ2DT0F
	Ty5/x/XadXBZ5+NnCSx/76LgOALms6DYYlROrQoAWKsxP7pglQDK6e6VHGGSDWhad/lNwEVmx/r
	te9UAyASY1P61Z0o373iwyF1g1vou9e8J5NJO60v1a9UCsM=
X-Google-Smtp-Source: AGHT+IHI4O5x+wPPGV+94eQGC4Hk/EXR2vmceT21i5pvhTSn8o+7MxvxGNT6vfB1NACqkNwl8RvUag==
X-Received: by 2002:a05:6871:7286:b0:2c1:4146:c556 with SMTP id 586e51a60fabf-2d526d6841amr2433872fac.31.1745006394498;
        Fri, 18 Apr 2025 12:59:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5213f8e4asm606941fac.23.2025.04.18.12.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 12:59:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Apr 2025 14:58:24 -0500
Subject: [PATCH 05/10] iio: adc: stm32-adc: use struct with aligned_s64
 timestamp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-iio-prefer-aligned_s64-timestamp-v1-5-4c6080710516@baylibre.com>
References: <20250418-iio-prefer-aligned_s64-timestamp-v1-0-4c6080710516@baylibre.com>
In-Reply-To: <20250418-iio-prefer-aligned_s64-timestamp-v1-0-4c6080710516@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andreas Klinger <ak@it-klinger.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2137; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=lY3P/BHYMrMzt2KYi0LGUhjMzgl6dv5K0V1qFBaK3Yg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoAq8EXey7ghkTICKkPtv4/67AoklbnfdqMoKh7
 TTWqGpmphSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAKvBAAKCRDCzCAB/wGP
 wHs6B/4sTJvHSSz6HmN4Jpf1hTnTzsCIHEnlOXlpjG7Pghs62u4n3Ku3uOCaSRMJmW8aPzERMxP
 EjQlPRX6KJhN02AzJJoLomnrGGAlKj7GTMshKYPld4I1xWH/wO+bvbTFWweAMtCYcz4wQfNoFMg
 cwyrNg/zAqQRG3mlYiQnk4s2TJ5+eite0qbnYZPq7xEU7Ky8GDlFTjYDwSgQ10AeOc0vqOIzsB8
 kR71fIXS76ZP1eN+CPrzVIJrpUKXC8rZ7myCL61/wGjr6qdg4OINWKinpTupJdCvUVcKhD3/6GE
 fMhBvDLohiP4ePwyNH53ZIr20gZKjtDb0cKa93njGvhC4hl0
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a struct with aligned s64_timestamp instead of a padded array for
the buffer used for iio_push_to_buffers_with_ts(). This makes it easier
to see the correctness of the size and alignment of the buffer.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/stm32-adc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5159908a2a6100b62e5e64b2b469378ad778c35d..81df0d45784553c87c92995934884138939ac899 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/types.h>
 
 #include "stm32-adc-core.h"
 
@@ -261,7 +262,10 @@ struct stm32_adc {
 	u32			offset;
 	const struct stm32_adc_cfg	*cfg;
 	struct completion	completion;
-	u16			buffer[STM32_ADC_MAX_SQ + 4] __aligned(8);
+	struct {
+		u16 data[STM32_ADC_MAX_SQ];
+		aligned_s64 timestamp;
+	} buffer;
 	struct clk		*clk;
 	int			irq;
 	spinlock_t		lock;		/* interrupt lock */
@@ -1447,7 +1451,7 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 	} else if (time_left < 0) {
 		ret = time_left;
 	} else {
-		*res = adc->buffer[0];
+		*res = adc->buffer.data[0];
 		ret = IIO_VAL_INT;
 	}
 
@@ -1559,7 +1563,7 @@ static irqreturn_t stm32_adc_isr(int irq, void *data)
 
 	if (status & regs->isr_eoc.mask) {
 		/* Reading DR also clears EOC status flag */
-		adc->buffer[adc->bufi] = stm32_adc_readw(adc, regs->dr);
+		adc->buffer.data[adc->bufi] = stm32_adc_readw(adc, regs->dr);
 		if (iio_buffer_enabled(indio_dev)) {
 			adc->bufi++;
 			if (adc->bufi >= adc->num_conv) {
@@ -1858,7 +1862,7 @@ static irqreturn_t stm32_adc_trigger_handler(int irq, void *p)
 
 	/* reset buffer index */
 	adc->bufi = 0;
-	iio_push_to_buffers_with_ts(indio_dev, adc->buffer, sizeof(adc->buffer),
+	iio_push_to_buffers_with_ts(indio_dev, &adc->buffer, sizeof(adc->buffer),
 				    pf->timestamp);
 	iio_trigger_notify_done(indio_dev->trig);
 

-- 
2.43.0



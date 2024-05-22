Return-Path: <linux-iio+bounces-5184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64A08CC3BE
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 17:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFAF2834A9
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102058248E;
	Wed, 22 May 2024 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lOsOaVwT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1730E52F9B
	for <linux-iio@vger.kernel.org>; Wed, 22 May 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390177; cv=none; b=NDhMesCk4f95lztYrqQrH5WOkgykRHnhbhuJCPkmWa3LkyGn7pci9Hs2QFwehnfOSRudufl4Bv5gVFhnD4h4haZ6lfjtZq4coPOC+EtcX+Ki/rMq+/lqUo5Am3xduRr/xnbtME58WiM3whD3dpomhoRNeu3d2LsfEjpVeTXw4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390177; c=relaxed/simple;
	bh=Nl4giAAtfP1wgG/NEvZwNNNg55OtAUvdLhvjiOoMMiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1065tNWxB2oIbVpXhJIBw0IDBUaPssnUy7si5NGqxf4vLWeEfhqZMHN7Kk1YGzx+dwLLtVqxd7vLmOHqG02T/ssK1nqHHkx5MTwiIOD60OP/2WkxD5wDPNLz3Vf4m2VjIrlBOblA5tw6D/PqFmGJFjmE1JHcbPqc1dHuwYevjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lOsOaVwT; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e72b8931caso38421511fa.0
        for <linux-iio@vger.kernel.org>; Wed, 22 May 2024 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716390174; x=1716994974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7D6fFRwhN0Zkm+pAkm+qmc7n3e4Gjj3CxdaCMG+7qFE=;
        b=lOsOaVwTjbL3/MMOYpC+33vZF3ehhPbbX7OoGEGfu4alEbUs8E7wI0HlMsY5mmuncI
         pL85DjfL/tPF8YSeQtIOVWKCMxtNKeiK9lmgk85V8TPoj6U5Nir7lDYj1R98QmUa622J
         uEXS+VnwBAoOp3zSxP7yHt9+xHPnAgvZye+MANa3TazzkMEhrwOjf1R9JESiWCPGjydN
         tLi1gb2m88GmFpj5/j5K6BpybXZrO6cLOd6tFF1GKoT8J1YiyXO7jX7DwilRyGBYq8Tc
         oyuFh0rjJIfgjT0j45tqBHBIZShjqVhTN+W+nHAwFe1xJ+GauGMltb3tcnFGjIy2mSsd
         mcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716390174; x=1716994974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7D6fFRwhN0Zkm+pAkm+qmc7n3e4Gjj3CxdaCMG+7qFE=;
        b=Ci8PRdlw8olfeOqX5yMlJJ7w2UaaGeB7bgDQU5P3UDHlg/o6y9PiIA8evs/xfonR1J
         KHxepzwH3FTDSfi/chO1m0TBhYL2WTntBBv6V4MxW57WRp6mjldyjo8IH0vmaYY4UXFE
         UA6hO04/e6Bx5tcV9O3ccR6pWxHH1XCyHvbIrZLhyo21fniwljSRCOOFEN4wdyZY+0A0
         IFs2RgG9yfRfmhtBawHgNLigPDqSK2wJyX0toVkmK3s2LEBQiiwqII7iuFRnLK0M4xYJ
         ipohpCI5GHBUr3zWXBTR0oIHbE+6m7tDvxJktv2oCuTx1Bk4ugOcIo1ICukIu4iIRkhb
         eYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3QRSjzCKZoejRKXhLlWpJ3QK6ABd8rSUR5KSQATsneti/KIBpjMs+LtQKlrGZnJk1sPKU9YPjV8cIHhCBFwVQHcL4qw1scWnS
X-Gm-Message-State: AOJu0Yx6SJBP94p/iDHEvaLC2UGZx85OHV1hXGtpFB4SmFfcqCS3qhCM
	EuOeQNOCffl0mJkussoKaXNRPCF28G6xa4P8bRlbqxNC4QAvNupCTJs5rgL2WNE=
X-Google-Smtp-Source: AGHT+IGD/2vp9GYsoEwJ7/JTNdx/B3p8YYiryw+V1L9SZyquSNzerQr26Dr671cNpJ9rq5Cile52Dg==
X-Received: by 2002:a2e:9dc1:0:b0:2e0:69b4:d655 with SMTP id 38308e7fff4ca-2e949501a7emr12417751fa.3.1716390174350;
        Wed, 22 May 2024 08:02:54 -0700 (PDT)
Received: from localhost.localdomain (host-79-16-6-145.retail.telecomitalia.it. [79.16.6.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fa90e93absm531370515e9.9.2024.05.22.08.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:02:54 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: nuno.sa@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH v2 5/6] iio: dac: ad3552r: change AD3552R_NUM_CH define name
Date: Wed, 22 May 2024 17:01:40 +0200
Message-ID: <20240522150141.1776196-6-adureghello@baylibre.org>
X-Mailer: git-send-email 2.45.0.rc1
In-Reply-To: <20240522150141.1776196-1-adureghello@baylibre.org>
References: <20240522150141.1776196-1-adureghello@baylibre.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Angelo Dureghello <adureghello@baylibre.com>

After model data and num_hw_channles introduction, we have:

ad3552r_desc, num_ch: used to keep channel number set in fdt,
ad35xxr_model_data, num_hw_channels: for max channel checks,
AD3552R_NUM_CH: just actually used to define the max array size
on allocated arrays.

Renaming AD3552R_NUM_CH to a more consistent name, as AD3552R_MAX_CH.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes for v2:
- patch added in v2
---
 drivers/iio/dac/ad3552r.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index b4630fb89334..b8bdbfed22e3 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -117,7 +117,7 @@
 #define AD3552R_REG_ADDR_CH_INPUT_24B(ch)		(0x4B - (1 - ch) * 3)
 
 /* Useful defines */
-#define AD3552R_NUM_CH					2
+#define AD3552R_MAX_CH					2
 #define AD3552R_MASK_CH(ch)				BIT(ch)
 #define AD3552R_MASK_ALL_CH				GENMASK(1, 0)
 #define AD3552R_MAX_REG_SIZE				3
@@ -279,8 +279,8 @@ struct ad3552r_desc {
 	struct gpio_desc	*gpio_reset;
 	struct gpio_desc	*gpio_ldac;
 	struct spi_device	*spi;
-	struct ad3552r_ch_data	ch_data[AD3552R_NUM_CH];
-	struct iio_chan_spec	channels[AD3552R_NUM_CH + 1];
+	struct ad3552r_ch_data	ch_data[AD3552R_MAX_CH];
+	struct iio_chan_spec	channels[AD3552R_MAX_CH + 1];
 	unsigned long		enabled_ch;
 	unsigned int		num_ch;
 };
@@ -539,7 +539,7 @@ static int32_t ad3552r_trigger_hw_ldac(struct gpio_desc *ldac)
 static int ad3552r_write_all_channels(struct ad3552r_desc *dac, u8 *data)
 {
 	int err, len;
-	u8 addr, buff[AD3552R_NUM_CH * AD3552R_MAX_REG_SIZE + 1];
+	u8 addr, buff[AD3552R_MAX_CH * AD3552R_MAX_REG_SIZE + 1];
 
 	addr = AD3552R_REG_ADDR_CH_INPUT_24B(1);
 	/* CH1 */
@@ -597,7 +597,7 @@ static irqreturn_t ad3552r_trigger_handler(int irq, void *p)
 	struct iio_buffer *buf = indio_dev->buffer;
 	struct ad3552r_desc *dac = iio_priv(indio_dev);
 	/* Maximum size of a scan */
-	u8 buff[AD3552R_NUM_CH * AD3552R_MAX_REG_SIZE];
+	u8 buff[AD3552R_MAX_CH * AD3552R_MAX_REG_SIZE];
 	int err;
 
 	memset(buff, 0, sizeof(buff));
-- 
2.45.0.rc1



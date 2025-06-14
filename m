Return-Path: <linux-iio+bounces-20620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 452F5AD9BAF
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 11:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3CC189DFC1
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 09:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3B229CB53;
	Sat, 14 Jun 2025 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oByO2OvY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727A129B221
	for <linux-iio@vger.kernel.org>; Sat, 14 Jun 2025 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749892523; cv=none; b=qpMT/SbloOS9yo2V7j4+Cvn/ixeLmCAm7twysheBsf3v+Yh3NiYdM6MKnX/LjrdqpsijrJHTPqdbuaRTo8wyr+6O3tR3jtNt90dBWBL/fB2H/nMfA6G5nvgAcRvy/SJCNj07Qm4fPURg9yzb5MndJyL0xRmPc2oAbUHxfSWDhf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749892523; c=relaxed/simple;
	bh=SkKJiZJp2DM+9aH9ZqZNdByprM9DwlhGCimKeBh/YJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c9Eu0qIf0oOjSHCSMdLWiBbPLwLqEoi4fnoN+JlUxoeh5iMc5hCJPeYeoVPdJsELHaHRXkfQuIpBQDLDG1m0RI7QdWDJG5kyYLq8fFdyJYPMRURU4llqihqWPHNUTqE+C+BTUHw8xc18jTXth362ZkfLwVgMyCH54lw/0fxrK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oByO2OvY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso2417246b3a.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Jun 2025 02:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749892521; x=1750497321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXZGIEfZDDccmiTeVzsKZm7Nu0ZNmUD8yr1NHt0MQH4=;
        b=oByO2OvYa0mQyvtIfDrkuaFP/GkFr2iefnm5MoY76gAXGQ+HHevC/BANPF6FGF5zPL
         nRVcozIhDqSRX2cdI+Yb1XaQyEyX+Y+zq2Rn7FWWt4lN0YeplrmRs7w22bmbx2/WlJFb
         irZjomUubA/H890QiwK4qTfhfLLhtJCsBeYPkE5bwhnHkOp0spKERhTcGKdUL5US3q/V
         11xqJsF1/4r65LuaFqUOAQgqFmERTOQpfcM4KUKLiERduaO0By2Ls6SIQfxAU8KGpAxd
         odifHaqNwP5gMg67+Xte5ewIXeuzwjpL1t5ICB4l+MrmpYGu4DrKw2MX3EsT/6itaro6
         5nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749892521; x=1750497321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXZGIEfZDDccmiTeVzsKZm7Nu0ZNmUD8yr1NHt0MQH4=;
        b=whyORqIux/lkuqCJtNiE3iDcQ4Bsb+xNgDS14wCIgE+vRKQVP07eePv7rAFFbC6t/u
         UDIkY6UpWty3dSkedIxv078c/oZcoPN9O3P3BrbApPQVMs64AHaemmjygGmqkx/LrdPQ
         2Tw82zBoa7ZCO0Iqtz1V2pKbOEc9j0boHDTFGPmYX8PmX2p+Kw3Eg6ZXtoSgkiot7Z/V
         3IQp2EhTEm6JKzQeo+E3QzWzXuono6zEjAvEBJR6ro/pIHk3zHM1xLllGS9yIjxfV7Px
         e/2LRw+73hYKD9t887W81YB8owNwo+hoM800aPeSwhqWDJvrXJAIeH2fcPhQpk5Iz8mT
         9F+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQd8VrL02d2wZ4rsVUANwm3hmcxi1JnpgbpDt7TMCf8jX39QzzwydVewzoeCRIb8/y7R8PvmoVqyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQ0sTf8fX1l+wfRJG29jJ3jKQDEPNofvF0JhG+d273/IDha5q
	vtqkX1wE2Z+aStQp5TMXtaNsia4eYh5B60hznpACAAzBMLmGwyrHQw/c/TYiOV+IJxg=
X-Gm-Gg: ASbGncv/zY7KOAFjjtBk0FMbCQWz3h2PdMxijHDFLg44jpLjEoiwCo9dN+/MMbXoGne
	06TYzAWS4e//dQV4cNRXUAVxOnrdi8AodTHgDAnhT5Q6qPoy7Z2Tqd+JsuDMPcgSYaafJxv/r3p
	WkohrNoQxMKWBbuxJOkoly1emeEW1NC0PHe2o8maxHYBopwGF+wZbc49QLX6Rk3yDkfrOvGeP8v
	mKVmKvkiArM7/A1hvZiHbHh09loTeMdCM4MpI1ffvif4xbQXCUzZVcuNYWlpta0LmfVQow1L7BH
	xHxPWe6CC0lieH/lDn9IJrTjOz3IPFtbB383g6qq2X01bdVC01olWch6ICQm1oi88DGNV5tL2G8
	nFNjI9uEKfFukbf6x6jSHSp8G
X-Google-Smtp-Source: AGHT+IFQviDBIfPu42RTiVXXTb+Ho8Tlb2wzrPdUami1CUBjU0n+pKda8Y6gdCAu9tv+g7jIA/1dSA==
X-Received: by 2002:a05:6a00:4b0f:b0:748:1bac:ad5f with SMTP id d2e1a72fcca58-7489cfbb64dmr3449698b3a.12.1749892520692;
        Sat, 14 Jun 2025 02:15:20 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffeca93sm2969630b3a.20.2025.06.14.02.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 02:15:20 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] iio: adc: ti-adc128s052: cleanup changes
Date: Sat, 14 Jun 2025 02:15:02 -0700
Message-Id: <20250614091504.575685-4-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250614091504.575685-1-sbellary@baylibre.com>
References: <20250614091504.575685-1-sbellary@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arrange device IDs in alphabetical and numerical order. new device ID addition
can follow the same convention. Also, arrange the structures in order.
This is a cosmetic change only, and the functionality remains unchanged.

Co-developed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
---
 drivers/iio/adc/ti-adc128s052.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 2b206745e53d..fbf15c83c127 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -112,27 +112,27 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
 
 #define ADC128_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 12)
 
-static const struct iio_chan_spec adc128s052_channels[] = {
+static const struct iio_chan_spec adc122s021_channels[] = {
 	ADC128_VOLTAGE_CHANNEL(0),
 	ADC128_VOLTAGE_CHANNEL(1),
-	ADC128_VOLTAGE_CHANNEL(2),
-	ADC128_VOLTAGE_CHANNEL(3),
-	ADC128_VOLTAGE_CHANNEL(4),
-	ADC128_VOLTAGE_CHANNEL(5),
-	ADC128_VOLTAGE_CHANNEL(6),
-	ADC128_VOLTAGE_CHANNEL(7),
 };
 
-static const struct iio_chan_spec adc122s021_channels[] = {
+static const struct iio_chan_spec adc124s021_channels[] = {
 	ADC128_VOLTAGE_CHANNEL(0),
 	ADC128_VOLTAGE_CHANNEL(1),
+	ADC128_VOLTAGE_CHANNEL(2),
+	ADC128_VOLTAGE_CHANNEL(3),
 };
 
-static const struct iio_chan_spec adc124s021_channels[] = {
+static const struct iio_chan_spec adc128s052_channels[] = {
 	ADC128_VOLTAGE_CHANNEL(0),
 	ADC128_VOLTAGE_CHANNEL(1),
 	ADC128_VOLTAGE_CHANNEL(2),
 	ADC128_VOLTAGE_CHANNEL(3),
+	ADC128_VOLTAGE_CHANNEL(4),
+	ADC128_VOLTAGE_CHANNEL(5),
+	ADC128_VOLTAGE_CHANNEL(6),
+	ADC128_VOLTAGE_CHANNEL(7),
 };
 
 static const char * const bd79104_regulators[] = { "iovdd" };
@@ -216,27 +216,27 @@ static int adc128_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id adc128_of_match[] = {
-	{ .compatible = "ti,adc128s052", .data = &adc128s052_config },
+	{ .compatible = "rohm,bd79104",  .data = &bd79104_config    },
 	{ .compatible = "ti,adc122s021", .data = &adc122s021_config },
 	{ .compatible = "ti,adc122s051", .data = &adc122s021_config },
 	{ .compatible = "ti,adc122s101", .data = &adc122s021_config },
 	{ .compatible = "ti,adc124s021", .data = &adc124s021_config },
 	{ .compatible = "ti,adc124s051", .data = &adc124s021_config },
 	{ .compatible = "ti,adc124s101", .data = &adc124s021_config },
-	{ .compatible = "rohm,bd79104",  .data = &bd79104_config },
+	{ .compatible = "ti,adc128s052", .data = &adc128s052_config },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
 
 static const struct spi_device_id adc128_id[] = {
-	{ "adc128s052", (kernel_ulong_t)&adc128s052_config },
 	{ "adc122s021",	(kernel_ulong_t)&adc122s021_config },
 	{ "adc122s051",	(kernel_ulong_t)&adc122s021_config },
 	{ "adc122s101",	(kernel_ulong_t)&adc122s021_config },
 	{ "adc124s021", (kernel_ulong_t)&adc124s021_config },
 	{ "adc124s051", (kernel_ulong_t)&adc124s021_config },
 	{ "adc124s101", (kernel_ulong_t)&adc124s021_config },
-	{ "bd79104",	(kernel_ulong_t)&bd79104_config },
+	{ "adc128s052", (kernel_ulong_t)&adc128s052_config },
+	{ "bd79104",	(kernel_ulong_t)&bd79104_config	   },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
-- 
2.34.1



Return-Path: <linux-iio+bounces-25840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C56C2B2D5
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 11:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3CA3B3CEC
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 10:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91902301032;
	Mon,  3 Nov 2025 10:52:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B77E3002BD;
	Mon,  3 Nov 2025 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167143; cv=none; b=OywRgw/H9uQtgboadnzvg+gJWRQz+UXkS2slUQp2olxxT+uDeQk4X4NRpKnX5IGUHKq7clxnWsk8BA8Yj+FNcdo+iymSC8wA5Lu5eRRYDlXAXZLCDx3BCtSXBojh/TulRk1agKLUKz8Cd+ARt2auKfmlcpDmC9VAQZnZ0th+7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167143; c=relaxed/simple;
	bh=Rxf9eQc8uGFvMLCvt8Bgx29yb+MOHnxC1mrGHj0dDdc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0JWkw8na+w4mNgV7oSnkWzsEofUm4gI+mQuARYzRUMXfIIdQPkPf4TuHn6ri/uWpB1uoBCvPWWiNnm2fRptCyox6hqXQRiyaJaclBAw1zvtsGQq/e6wyTJFUJq5ZEsnabMWg8wIlSHF0fVHKOIdSGOBSOT2haXNCUtAEqkj7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 18:52:17 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 18:52:17 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<billy_tsai@aspeedtech.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] iio: adc: aspeed: Add AST2700 ADC support
Date: Mon, 3 Nov 2025 18:52:17 +0800
Message-ID: <20251103105217.1764355-2-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>
References: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch adds support for the ADCs found on the Aspeed AST2700 SoC,
which includes two instances: "ast2700-adc0" and "ast2700-adc1". While
they are functionally similar to those on AST2600, the OTP trimming data
is located at the same offset (0x820), but uses different bitfields.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 8ab29948214a..9df6e7f68f19 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -646,6 +646,16 @@ static const struct aspeed_adc_trim_locate ast2600_adc1_trim = {
 	.field = GENMASK(7, 4),
 };
 
+static const struct aspeed_adc_trim_locate ast2700_adc0_trim = {
+	.offset = 0x820,
+	.field = GENMASK(3, 0),
+};
+
+static const struct aspeed_adc_trim_locate ast2700_adc1_trim = {
+	.offset = 0x820,
+	.field = GENMASK(7, 4),
+};
+
 static const struct aspeed_adc_model_data ast2400_model_data = {
 	.model_name = "ast2400-adc",
 	.vref_fixed_mv = 2500,
@@ -690,11 +700,35 @@ static const struct aspeed_adc_model_data ast2600_adc1_model_data = {
 	.trim_locate = &ast2600_adc1_trim,
 };
 
+static const struct aspeed_adc_model_data ast2700_adc0_model_data = {
+	.model_name = "ast2700-adc0",
+	.min_sampling_rate = 10000,
+	.max_sampling_rate = 500000,
+	.wait_init_sequence = true,
+	.bat_sense_sup = true,
+	.scaler_bit_width = 16,
+	.num_channels = 8,
+	.trim_locate = &ast2700_adc0_trim,
+};
+
+static const struct aspeed_adc_model_data ast2700_adc1_model_data = {
+	.model_name = "ast2700-adc1",
+	.min_sampling_rate = 10000,
+	.max_sampling_rate = 500000,
+	.wait_init_sequence = true,
+	.bat_sense_sup = true,
+	.scaler_bit_width = 16,
+	.num_channels = 8,
+	.trim_locate = &ast2700_adc1_trim,
+};
+
 static const struct of_device_id aspeed_adc_matches[] = {
 	{ .compatible = "aspeed,ast2400-adc", .data = &ast2400_model_data },
 	{ .compatible = "aspeed,ast2500-adc", .data = &ast2500_model_data },
 	{ .compatible = "aspeed,ast2600-adc0", .data = &ast2600_adc0_model_data },
 	{ .compatible = "aspeed,ast2600-adc1", .data = &ast2600_adc1_model_data },
+	{ .compatible = "aspeed,ast2700-adc0", .data = &ast2700_adc0_model_data },
+	{ .compatible = "aspeed,ast2700-adc1", .data = &ast2700_adc1_model_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, aspeed_adc_matches);
-- 
2.25.1



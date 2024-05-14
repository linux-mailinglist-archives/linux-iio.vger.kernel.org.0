Return-Path: <linux-iio+bounces-5029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C504D8C4CCC
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 09:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500CFB2175C
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 07:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC5621A06;
	Tue, 14 May 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuPwl4tS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD801EA80;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671398; cv=none; b=Fio3l/egVNiyHL/NfUwRb8NtWrJooX0tQ2h7sT+XSvCw7yKY7Qm0NWBOetS7F2vgEH1R4G2FmKk87V8nPnMbiIi4EAUdQqJgB5X2hWPZx8UhaqGRqEF3189ocxpfgwAw6QoIfDK83Z3yaULi0f69C2n8CS03LqeccpZZLXYzFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671398; c=relaxed/simple;
	bh=YKQKHbGXvIMnWH5GjOE7dofyStSokvsCeHxPG1NfRUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d1vijKc3wZZle9Bfwo7fhBRMNu+pTE1GMeUnsZgGjIDeP/rw47qFymG1myIm/ntkiRL0wd/jaqxkoL31jvONavTE2yRsNWC5w7+dEXv5kuLoBvBWuDYrNS8ZKMG0dKJnRkH0+kJJ7p78UaGFIdoxG8E2Dej2FNUsbsX9R3otqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuPwl4tS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54147C4AF13;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715671398;
	bh=YKQKHbGXvIMnWH5GjOE7dofyStSokvsCeHxPG1NfRUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SuPwl4tSQElZZDHw8hAtJK/4Itm59g5+sgvvlTDsTteCQQLTtIchn+VIaEppn0VD3
	 CN/EDb3EnLe1pz61gzGH9Oytt7SaLPjssyvCLxzvJv7rRNNt3A4e3MBMXT5Moq25TM
	 TqJo1J6MXCv8DcDlDrvSJVw1XWBV0HXP0OVxnqrAmHZcMAlj4ty7OCu2aymDLWR4TU
	 7NuZDgF5T8/rRMPOcKvC0oC0hybT0B7xjnL9MtDz+Fw/7y/t9C33Voc639oZb2z1Nc
	 sEpv7ZEy8/WG9tAEfAJWAhveM1ECYkf+bJ8dF1NIwP1xHzXdazDdpyUI3nhKJTG/b0
	 Ah3PH1CHY76Iw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5DFC25B7B;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Tue, 14 May 2024 10:22:47 +0300
Subject: [PATCH v2 2/9] iio: adc: ad7173: fix buffers enablement for
 ad7176-2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240514-ad4111-v2-2-29be6a55efb5@analog.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
In-Reply-To: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715671396; l=3452;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=By2lkXPmhQUd1cDCa8AwMoP2wuTqqxGblUGZ1vcYth4=;
 b=j56HRphgoU2W5Z5DH/bGgeVIFotvrqbEak1lrvalP881psDRz3V3chluQJeeoN8fPtg4vhvY+
 f1FswDXdyGwCCBsWGXjaxQifiEjoZIEoTz/xeTtkf6lDIPQ6JMq5iYS
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

AD7176-2 does not feature input buffers and marks corespondent register
bits as read only. Enable buffers only on supported models.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index f6d29abe1d04..850574437bda 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -145,6 +145,7 @@ struct ad7173_device_info {
 	unsigned int id;
 	char *name;
 	bool has_temp;
+	bool has_input_buf;
 	bool has_int_ref;
 	bool has_ref2;
 	u8 num_gpios;
@@ -212,6 +213,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_configs = 4,
 		.num_gpios = 2,
 		.has_temp = true,
+		.has_input_buf = true,
 		.has_int_ref = true,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
@@ -224,6 +226,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_configs = 8,
 		.num_gpios = 4,
 		.has_temp = false,
+		.has_input_buf = true,
 		.has_ref2 = true,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
@@ -237,6 +240,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_configs = 8,
 		.num_gpios = 4,
 		.has_temp = true,
+		.has_input_buf = true,
 		.has_int_ref = true,
 		.has_ref2 = true,
 		.clock = 2 * HZ_PER_MHZ,
@@ -251,6 +255,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_configs = 4,
 		.num_gpios = 2,
 		.has_temp = true,
+		.has_input_buf = true,
 		.has_int_ref = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
@@ -263,6 +268,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_configs = 8,
 		.num_gpios = 4,
 		.has_temp = true,
+		.has_input_buf = true,
 		.has_int_ref = true,
 		.has_ref2 = true,
 		.clock = 16 * HZ_PER_MHZ,
@@ -277,6 +283,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_configs = 4,
 		.num_gpios = 2,
 		.has_temp = false,
+		.has_input_buf = false,
 		.has_int_ref = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
@@ -289,6 +296,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_configs = 4,
 		.num_gpios = 2,
 		.has_temp = true,
+		.has_input_buf = true,
 		.has_int_ref = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.odr_start_value = AD7177_ODR_START_VALUE,
@@ -932,7 +940,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 			AD7173_CH_ADDRESS(chan_arr[chan_index].channel,
 					  chan_arr[chan_index].channel2);
 		chan_st_priv->cfg.bipolar = false;
-		chan_st_priv->cfg.input_buf = true;
+		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
 		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
 
@@ -989,7 +997,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 
 		chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
 		chan_st_priv->chan_reg = chan_index;
-		chan_st_priv->cfg.input_buf = true;
+		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.odr = 0;
 
 		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");

-- 
2.43.0




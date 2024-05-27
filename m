Return-Path: <linux-iio+bounces-5344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF048D05F8
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0201F21234
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3DD73449;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vL68RsHb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAD261FEA;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823216; cv=none; b=PqBSOhNgIGw6sP1z/m29Hl5kmoPb4O9pF8qYQRYBxzF0ApIJ9X1IKwYWNa8ZlvhdmXipinwMUoEzZauJ51QHWVibKxI821kFT1/7sKrtFBh4NpV2StIHHf+Dy9bf8vrsTasBE9vk+d1aWac9u4oALh9GubKQFj32CcbSzCkP4uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823216; c=relaxed/simple;
	bh=BscWCvxLlRzWKhpkBSkVww2bcZM3ZdgJi0FGOnKCD8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBq3c/6PRNR1BhFcligrdzsOtNfVrubkqVRSdxBASppKyCyoCHQzVNWByqSF/duQvY27W5NiGRF3lMagTNrWf9YLgTA/HqZymfDUkSlxClVLPeX1K/QsaK4GA1jD5XhinTT5Aqlc7A3LqofZNPL2OEjAh4n8N0WDuxTgTzhKZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vL68RsHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27DDAC32789;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716823216;
	bh=BscWCvxLlRzWKhpkBSkVww2bcZM3ZdgJi0FGOnKCD8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vL68RsHbPefP1xgCClt4GxyyMIZbKjwrFDXfPpSUhtt0T6dBh/7pFInZLlx5w3rQo
	 2fkruSOXi9bRMUuOFuS2lj+3hZ63s/mUQUrZjKJ8uoEqumRcykdl9zDqa0N814pii1
	 XQFxKO6+jI3W9z8IXRSIRU73cuqqNNDjvqfge8KhmXJzS/84pOWLYG0bI1bh4bNBLr
	 F3519tb4tBaLssLkNx6BSlQOAOMs9kcxwenrV+n+SJyEuJboyWneSaaywo43YaWVnm
	 t3ONOhYtLeY9j5ac5jQS5koIXpWqBMzhWUTPwFPalC9b2Pllx8t5hzK3yPoA7bK5ww
	 kHP1qKLG6hRnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC8C25B78;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 27 May 2024 18:19:49 +0300
Subject: [PATCH v2 1/5] iio: adc: ad7173: fix buffers enablement for
 ad7176-2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-ad7173-fixes-v2-1-8501b66adb1f@analog.com>
References: <20240527-ad7173-fixes-v2-0-8501b66adb1f@analog.com>
In-Reply-To: <20240527-ad7173-fixes-v2-0-8501b66adb1f@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716823214; l=3513;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=YO3jbx93xkkdS8bNTk3Nk05937RhLKSs/ejH6uQRBSk=;
 b=5peJNBAZud6iAOE4J6q+0sYQRuqmWLN2zGsrraewPKjaeirGNFw17pAHWQWCqbaxQo87zvzTj
 WhnTmKMrL4gCFcN1BS3tt1nka8mNH9RUvlv/wZdD5I2nF4MUi0MM1O0
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

AD7176-2 does not feature input buffers and marks corespondent register
bits as read only. Enable buffers only on supported models.

Fixes: 8eb903272f75 ("iio: adc: ad7173: add AD7173 driver")
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




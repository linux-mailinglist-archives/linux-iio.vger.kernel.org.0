Return-Path: <linux-iio+bounces-5150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF84C8CAA3B
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 10:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71674282775
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2668F57C83;
	Tue, 21 May 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl9UKDSu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D648651C5F;
	Tue, 21 May 2024 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281186; cv=none; b=iPw8Rq9qR6yKDDGx+JYqDlIuKfraf7Qi1gWUe5ueGj78/Ug1ZAnuL95IZoQdrDyUATb5iB3EShPgH4mh7S6MNff07Jtx4KjsyFUFK+v3HDKIXIEvOJ9LYPKBMIPydll+RZNljVLDaA/k45I/nwesvGnNqF0vK2xktSHC/zmmkrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281186; c=relaxed/simple;
	bh=BscWCvxLlRzWKhpkBSkVww2bcZM3ZdgJi0FGOnKCD8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VJEXIUtCebD40l3vlqFOHPvIUCtw+Cr9k2q/KGVg0sYNGTuMuVVgTFP2ZqvRhOGnxyD6uMasr9wiY+0R8/wvip9FTIN35Dn2pz+yzWoY8muqcECz04GXCLPTKoNkW7PZZViKFjNUMKLdmHLUXw2JDJxrNRPwuYTOQdPdv71RV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl9UKDSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AE1DC4AF0A;
	Tue, 21 May 2024 08:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716281186;
	bh=BscWCvxLlRzWKhpkBSkVww2bcZM3ZdgJi0FGOnKCD8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Gl9UKDSuUbNbk1EHE/G/re5tZyZFHHQOnU+CNKtr2OsEHeAiPcJB1vFMP11ndsCSG
	 10q1BeEmWfs3wtu8LuApWcyjojuNILP8kMKhGjFdDyQd2cixGgKvmCWLSoaZEpA+v5
	 H4JoKGzZdYTH4LP9jSiXfNQdzXU6IBWMJzD+STRa75P9MosfPJ+6ge+SiUqISPETak
	 9iOoZbyiyBg5lIc20/AdR/CoNUzNmLIu9W6cvbK0P5pd0KTyFvmO8bN8WvoPxRVrYO
	 O7XA0B4CAQhJaB2hA3Svv9lEE2yjTkKZ3natqDjhPelZRfTBqkWXLnKa5wHlJuQTin
	 ouXrMV+paMz7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F3DC25B7C;
	Tue, 21 May 2024 08:46:26 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Tue, 21 May 2024 11:45:39 +0300
Subject: [PATCH 1/3] iio: adc: ad7173: fix buffers enablement for ad7176-2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-ad7173-fixes-v1-1-8161cc7f3ad1@analog.com>
References: <20240521-ad7173-fixes-v1-0-8161cc7f3ad1@analog.com>
In-Reply-To: <20240521-ad7173-fixes-v1-0-8161cc7f3ad1@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716281184; l=3513;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=YO3jbx93xkkdS8bNTk3Nk05937RhLKSs/ejH6uQRBSk=;
 b=vn0FOzEoFZlgkHd5VvxLngn8fwDPJNwb2rRvuSlT7Kde9aJoc36/DURSYOKZqEGPqivzPXee9
 UDVeDGtt+GSBlCPjvkLgEqKTuwekQkber9Y/aoBd0uXU2s/RhIu4XWV
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




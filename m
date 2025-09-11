Return-Path: <linux-iio+bounces-24000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C099FB53E04
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 23:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7C118914DB
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 21:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA9C2E4241;
	Thu, 11 Sep 2025 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DdOg7vGI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D4A2E282B
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626983; cv=none; b=e8/F2li6s6Dep2Di5nVMw0CEbghjB705MRIzEzJ/IlG4x6a/rj8PDE63DP78uMKMF690AnHJTtF2Xn1on82lOD7Jlygr7nNZh1fRqtsXYFGOt9sw9b4BqfmfVSw3T8anjB/W/6m78fp0AsyP/cqmJboG8XJlN+rDeql1Y3MruXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626983; c=relaxed/simple;
	bh=f6rDj9kImdMEFXxuOv+xaT+NTqi9Euf7elFeUT10MR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MAA+VG0B05X4BA2Zj1OgGpylhn4uChMkJWBB7H3aTdwxc2rv3BR539bz1PYFS479P49XibkILfKatWbwwcrM88Ul10w4wUEnkeGFohoVYTf9Q4/3zO/wmSfgdWBf9mUSjsL4ne9/HGiOTN3IN3IFh3VwM96yML9Pddt2Zm76DY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DdOg7vGI; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61bf9ef4cc0so788220eaf.0
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757626979; x=1758231779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSPiyKNtG04t1z8Ry3jUY2Wm2ThtvP092cmojhqt60Y=;
        b=DdOg7vGIMhGkC4M1TdggpzImKUbksctzDpraQ5edrIUUqLxmcNB5+eDVyzeHQS9RKJ
         kXzmyPqjS1eC9RsJUO5id2T0QLvKTlaNjuUQVhdRnFz7VvvsZ76QJmerFzOVINXlThru
         z4ApixHdJb62j7xQzjdOwogrJl/SR5Zvq8EcwCQ9l494sxDM8OTuqZyp742MMHsV+pgM
         7DFyuya6JsFOrmLLbwKr0tkgoVS3R4x9Wx7saAlRD/uCZMeWbAs28BrFq54N3ZFKMlsD
         sfn34zSl3QHovi4q+AhveM765gV65JHA3PB1bEn9BTVs0N9W4j0Png4dAm2cszwy3qEy
         4VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626979; x=1758231779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSPiyKNtG04t1z8Ry3jUY2Wm2ThtvP092cmojhqt60Y=;
        b=lJ1Fn6FIrx04FvwWQcZy/nt/Rb4XswXGMLIu9nx7tgfeSoEBOv1NJgh7GV/acqjWhb
         D/7UZYU5b6CjCz4CEQ9zAyhosLC8ZzG6xTwYrANXxz90kY6aETlS9aY6hHjfMbajBTfa
         6E75FJdKWy+ImsTWHNrSbakzwTSQPFhiC+2Qlg/+qnReHgeZKb1YqqCfxVnn+shOhT+l
         Ik5RhbaMcAP/2Fpdwg/jvyxvQMwX1ES9a6pRFE/3TqE1nBzqlDjBY7Yn/4ZreBTG5sMg
         JwQftzUDkBoYuCRkyAvAwxo7F4WMDBhTLV0SYLHcLCf0rp4YN4Is/FZpLRf9m6eUlrpC
         uXKA==
X-Gm-Message-State: AOJu0YweS094yliw/+YchqatKt0vODl4b+bxmMKZX91P4XHK+gdNvzZJ
	wO9rw2PKOB/01ri5LRa7fa44VGlqUmuwq44fhUlarGCbgu9UdaLnYbo5JeKi7yw+Lh4=
X-Gm-Gg: ASbGncuVDEt/4R8zd9j+qlLDJKtwjmHoQlu+j8RnTs4Lj6Q/gDZgn2ZekOVhfKdWzhW
	4Il/IJ3uTdRkabaGdCXPBBnj4c7iIvWda3IAF3ZHr/dwj9YD+A1yZCm74f2pDOJU+nRBWl3vais
	fSOKjQTFpqhyAxo0kmcqFiHUqABruJbiim50o64MHKwHuSBxQhHuyUSVuHgy2pcXiFhAmqqzvOJ
	6prHRfxSVFR7cSUuazrowbdwNtqyb/fP9kXN6JN9QD7Jf+NSl+40G+zjypdH+q/DstYmiGzzpci
	WbE4bJIPxoapxHOeVOD3iuqGUJEDatm9qSosQgBk+M4o9/S4ZwuFbMslx6SQSc8480HdzHnJBZL
	TjWDYJOt+azqDrYkFB/fvn28jAjI5/8PE5t2cpH2GXHkswELWng==
X-Google-Smtp-Source: AGHT+IGp09+4DRj7X196GZuisCs0gzUQ/ApAg5YTD2fTzPWBJDWPZA5Fv/D8IxCKo6Lgk9KD2xIe+Q==
X-Received: by 2002:a05:6808:1513:b0:438:4312:ab98 with SMTP id 5614622812f47-43b8d87ac90mr370401b6e.12.1757626978565;
        Thu, 11 Sep 2025 14:42:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986a7c3sm604188a34.10.2025.09.11.14.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:42:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Sep 2025 16:42:04 -0500
Subject: [PATCH v2 5/6] iio: adc: ad7124: add filter support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-iio-adc-ad7124-add-filter-support-v2-5-b09f492416c7@baylibre.com>
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
In-Reply-To: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15722;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=f6rDj9kImdMEFXxuOv+xaT+NTqi9Euf7elFeUT10MR8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBow0JNx3UGfMNH+ZH1l/61EpUdcbUWZDP1NUchE
 +uPtEeQoZSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMNCTQAKCRDCzCAB/wGP
 wGTUB/44VUHl4K7nLoU+S2wzKn+zJp0MsVOfBqABbgSoMqUvlTLCedtJhhvUiuvTmE1dJUW2O9w
 mBqP+pBPkRtfSd2l/OQBfzG5gLzsnYYbrvBVc5fL612V4wA9eQWinqb/+9/44wsJx73DX0W7wuf
 57Hybn/OKrFzj5SCn40piBbHtG6jPgnoZwNgJakVlcT6HqtfqYa3Euw5HbuGtUsGlAVhcXrVEAa
 StzzQoHgPO9rbH7S9qMw3+C7puApq/Cmm4cFROFGiPAWj1MJy7no0O6M96GjfjpE9mmz6OfJN4K
 AkW0XvzE4nY2sL6FdqeiC3oHWbxBS9qb6z/M4pwPkqpaKD51
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support to the ad7124 driver for selecting the filter type.

The filter type has an influence on the effective sampling frequency of
each channel. For sinc3+pf{1,2,3,4}, the sampling frequency is fixed.
For sinc{3,4} (without post filter), there is a factor of 3 or 4
depending on the filter type. For the extra +sinc1, there is an extra
averaging factor that depends on the power mode.

In order to select the closest sampling frequency for each filter type,
we keep a copy of the requested sampling frequency. This way, if the
user sets the sampling frequency first and then selects the filter type,
the sampling frequency will still be as close as possible to the
requested value.

Since we always either have the SINGLE_CYCLE bit set or have more than
one channel enabled, the sampling frequency is always using the
"zero-latency" calculation from the data sheet. This is only documented
for the basic sinc{3,4} filters, so the other filter types had to be
inferred and confirmed through testing.

Since the flat filter type list consists of multiple register fields,
the struct ad7124_channel_config::filter_type field is changed to the
enum ad7124_filter_type type to avoid nested switch statements in a
lot of places.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 262 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 230 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index b644191319a5eb6ab1a8ba22df4520edbb34ee75..910b40393f77de84afc77d406c17c6e5051a02cd 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -3,6 +3,7 @@
  * AD7124 SPI ADC driver
  *
  * Copyright 2018 Analog Devices Inc.
+ * Copyright 2025 BayLibre, SAS
  */
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
@@ -97,6 +98,15 @@
 #define AD7124_FILTER_FILTER		GENMASK(23, 21)
 #define AD7124_FILTER_FILTER_SINC4		0
 #define AD7124_FILTER_FILTER_SINC3		2
+#define AD7124_FILTER_FILTER_SINC4_SINC1	4
+#define AD7124_FILTER_FILTER_SINC3_SINC1	5
+#define AD7124_FILTER_FILTER_SINC3_PF		7
+#define AD7124_FILTER_REJ60		BIT(20)
+#define AD7124_FILTER_POST_FILTER	GENMASK(19, 17)
+#define AD7124_FILTER_POST_FILTER_47dB		2
+#define AD7124_FILTER_POST_FILTER_62dB		3
+#define AD7124_FILTER_POST_FILTER_86dB		5
+#define AD7124_FILTER_POST_FILTER_92dB		6
 #define AD7124_FILTER_SINGLE_CYCLE	BIT(16)
 #define AD7124_FILTER_FS		GENMASK(10, 0)
 
@@ -151,9 +161,24 @@ struct ad7124_chip_info {
 	unsigned int num_inputs;
 };
 
+enum ad7124_filter_type {
+	AD7124_FILTER_TYPE_SINC3,
+	AD7124_FILTER_TYPE_SINC3_PF1,
+	AD7124_FILTER_TYPE_SINC3_PF2,
+	AD7124_FILTER_TYPE_SINC3_PF3,
+	AD7124_FILTER_TYPE_SINC3_PF4,
+	AD7124_FILTER_TYPE_SINC3_REJ60,
+	AD7124_FILTER_TYPE_SINC3_SINC1,
+	AD7124_FILTER_TYPE_SINC4,
+	AD7124_FILTER_TYPE_SINC4_REJ60,
+	AD7124_FILTER_TYPE_SINC4_SINC1,
+};
+
 struct ad7124_channel_config {
 	bool live;
 	unsigned int cfg_slot;
+	unsigned int requested_odr;
+	unsigned int requested_odr_micro;
 	/*
 	 * Following fields are used to compare for equality. If you
 	 * make adaptations in it, you most likely also have to adapt
@@ -167,7 +192,7 @@ struct ad7124_channel_config {
 		unsigned int vref_mv;
 		unsigned int pga_bits;
 		unsigned int odr_sel_bits;
-		unsigned int filter_type;
+		enum ad7124_filter_type filter_type;
 		unsigned int calibration_offset;
 		unsigned int calibration_gain;
 	);
@@ -284,21 +309,50 @@ static u32 ad7124_get_fclk_hz(struct ad7124_state *st)
 	return fclk_hz;
 }
 
+static u32 ad7124_get_fs_factor(struct ad7124_state *st, unsigned int channel)
+{
+	enum ad7124_power_mode power_mode =
+		FIELD_GET(AD7124_ADC_CONTROL_POWER_MODE, st->adc_control);
+	u32 avg = power_mode == AD7124_LOW_POWER ? 8 : 16;
+
+	/*
+	 * These are the "zero-latency" factors from the data sheet. For the
+	 * sinc1 filters, these aren't documented, but derived by taking the
+	 * single-channel formula from the sinc1 section of the data sheet and
+	 * multiplying that by the sinc3/4 factor from the corresponding zero-
+	 * latency sections.
+	 */
+	switch (st->channels[channel].cfg.filter_type) {
+	case AD7124_FILTER_TYPE_SINC4:
+	case AD7124_FILTER_TYPE_SINC4_REJ60:
+		return 4 * 32;
+	case AD7124_FILTER_TYPE_SINC4_SINC1:
+		return 4 * avg * 32;
+	case AD7124_FILTER_TYPE_SINC3_SINC1:
+		return 3 * avg * 32;
+	default:
+		return 3 * 32;
+	}
+}
+
 static u32 ad7124_get_fadc_divisor(struct ad7124_state *st, unsigned int channel)
 {
+	u32 factor = ad7124_get_fs_factor(st, channel);
+
 	/*
 	 * The output data rate (f_ADC) is f_CLK / divisor. We are returning
 	 * the divisor.
 	 */
-	return st->channels[channel].cfg.odr_sel_bits * 32 * 4;
+	return st->channels[channel].cfg.odr_sel_bits * factor;
 }
 
-static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel,
-				   unsigned int odr, unsigned int odr_micro)
+static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel)
 {
-	unsigned int fclk, factor, odr_sel_bits;
+	struct ad7124_channel_config *cfg = &st->channels[channel].cfg;
+	unsigned int fclk, factor, divisor, odr_sel_bits;
 
 	fclk = ad7124_get_fclk_hz(st);
+	factor = ad7124_get_fs_factor(st, channel);
 
 	/*
 	 * FS[10:0] = fCLK / (fADC x 32 * N) where:
@@ -308,10 +362,9 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
 	 * FS[10:0] are the bits in the filter register
 	 * FS[10:0] can have a value from 1 to 2047
 	 */
-	factor = 32 * 4; /* N = 4 for default sinc4 filter. */
-	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor +
-					       odr_micro * factor / MICRO);
-	odr_sel_bits = clamp(odr_sel_bits, 1, 2047);
+	divisor = cfg->requested_odr * factor +
+		  cfg->requested_odr_micro * factor / MICRO;
+	odr_sel_bits = clamp(DIV_ROUND_CLOSEST(fclk, divisor), 1, 2047);
 
 	if (odr_sel_bits != st->channels[channel].cfg.odr_sel_bits)
 		st->channels[channel].cfg.live = false;
@@ -322,15 +375,29 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
 static int ad7124_get_3db_filter_factor(struct ad7124_state *st,
 					unsigned int channel)
 {
+	struct ad7124_channel_config *cfg = &st->channels[channel].cfg;
+
 	/*
 	 * 3dB point is the f_CLK rate times some factor. This functions returns
 	 * the factor times 1000.
 	 */
-	switch (st->channels[channel].cfg.filter_type) {
-	case AD7124_FILTER_FILTER_SINC3:
+	switch (cfg->filter_type) {
+	case AD7124_FILTER_TYPE_SINC3:
+	case AD7124_FILTER_TYPE_SINC3_REJ60:
+	case AD7124_FILTER_TYPE_SINC3_SINC1:
 		return 272;
-	case AD7124_FILTER_FILTER_SINC4:
+	case AD7124_FILTER_TYPE_SINC4:
+	case AD7124_FILTER_TYPE_SINC4_REJ60:
+	case AD7124_FILTER_TYPE_SINC4_SINC1:
 		return 230;
+	case AD7124_FILTER_TYPE_SINC3_PF1:
+		return 633;
+	case AD7124_FILTER_TYPE_SINC3_PF2:
+		return 605;
+	case AD7124_FILTER_TYPE_SINC3_PF3:
+		return 669;
+	case AD7124_FILTER_TYPE_SINC3_PF4:
+		return 759;
 	default:
 		return -EINVAL;
 	}
@@ -355,7 +422,7 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 				     unsigned int vref_mv;
 				     unsigned int pga_bits;
 				     unsigned int odr_sel_bits;
-				     unsigned int filter_type;
+				     enum ad7124_filter_type filter_type;
 				     unsigned int calibration_offset;
 				     unsigned int calibration_gain;
 			     }));
@@ -422,8 +489,9 @@ static int ad7124_init_config_vref(struct ad7124_state *st, struct ad7124_channe
 static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_config *cfg,
 			       unsigned int cfg_slot)
 {
-	unsigned int tmp;
-	unsigned int val;
+	unsigned int val, filter;
+	unsigned int rej60 = 0;
+	unsigned int post = 0;
 	int ret;
 
 	cfg->cfg_slot = cfg_slot;
@@ -446,6 +514,47 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 	if (ret < 0)
 		return ret;
 
+	switch (cfg->filter_type) {
+	case AD7124_FILTER_TYPE_SINC3:
+		filter = AD7124_FILTER_FILTER_SINC3;
+		break;
+	case AD7124_FILTER_TYPE_SINC3_PF1:
+		filter = AD7124_FILTER_FILTER_SINC3_PF;
+		post = AD7124_FILTER_POST_FILTER_47dB;
+		break;
+	case AD7124_FILTER_TYPE_SINC3_PF2:
+		filter = AD7124_FILTER_FILTER_SINC3_PF;
+		post = AD7124_FILTER_POST_FILTER_62dB;
+		break;
+	case AD7124_FILTER_TYPE_SINC3_PF3:
+		filter = AD7124_FILTER_FILTER_SINC3_PF;
+		post = AD7124_FILTER_POST_FILTER_86dB;
+		break;
+	case AD7124_FILTER_TYPE_SINC3_PF4:
+		filter = AD7124_FILTER_FILTER_SINC3_PF;
+		post = AD7124_FILTER_POST_FILTER_92dB;
+		break;
+	case AD7124_FILTER_TYPE_SINC3_REJ60:
+		filter = AD7124_FILTER_FILTER_SINC3;
+		rej60 = 1;
+		break;
+	case AD7124_FILTER_TYPE_SINC3_SINC1:
+		filter = AD7124_FILTER_FILTER_SINC3_SINC1;
+		break;
+	case AD7124_FILTER_TYPE_SINC4:
+		filter = AD7124_FILTER_FILTER_SINC4;
+		break;
+	case AD7124_FILTER_TYPE_SINC4_REJ60:
+		filter = AD7124_FILTER_FILTER_SINC4;
+		rej60 = 1;
+		break;
+	case AD7124_FILTER_TYPE_SINC4_SINC1:
+		filter = AD7124_FILTER_FILTER_SINC4_SINC1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	/*
 	 * NB: AD7124_FILTER_SINGLE_CYCLE is always set so that we get the same
 	 * sampling frequency even when only one channel is enabled in a
@@ -453,14 +562,12 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 	 * would be 1 and we would get a faster sampling frequency than what
 	 * was requested.
 	 */
-	tmp = FIELD_PREP(AD7124_FILTER_FILTER, cfg->filter_type) |
-		AD7124_FILTER_SINGLE_CYCLE |
-		FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits);
-	return ad7124_spi_write_mask(st, AD7124_FILTER(cfg->cfg_slot),
-				     AD7124_FILTER_FILTER |
-				     AD7124_FILTER_SINGLE_CYCLE |
-				     AD7124_FILTER_FS,
-				     tmp, 3);
+	return ad_sd_write_reg(&st->sd, AD7124_FILTER(cfg->cfg_slot), 3,
+			       FIELD_PREP(AD7124_FILTER_FILTER, filter) |
+			       FIELD_PREP(AD7124_FILTER_REJ60, rej60) |
+			       FIELD_PREP(AD7124_FILTER_POST_FILTER, post) |
+			       AD7124_FILTER_SINGLE_CYCLE |
+			       FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits));
 }
 
 static struct ad7124_channel_config *ad7124_pop_config(struct ad7124_state *st)
@@ -722,13 +829,47 @@ static int ad7124_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(&st->cfgs_lock);
-		*val = ad7124_get_fclk_hz(st);
-		*val2 = ad7124_get_fadc_divisor(st, chan->address);
-		mutex_unlock(&st->cfgs_lock);
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		struct ad7124_channel_config *cfg = &st->channels[chan->address].cfg;
 
-		return IIO_VAL_FRACTIONAL;
+		guard(mutex)(&st->cfgs_lock);
+
+		switch (cfg->filter_type) {
+		case AD7124_FILTER_TYPE_SINC3:
+		case AD7124_FILTER_TYPE_SINC3_REJ60:
+		case AD7124_FILTER_TYPE_SINC3_SINC1:
+		case AD7124_FILTER_TYPE_SINC4:
+		case AD7124_FILTER_TYPE_SINC4_REJ60:
+		case AD7124_FILTER_TYPE_SINC4_SINC1:
+			*val = ad7124_get_fclk_hz(st);
+			*val2 = ad7124_get_fadc_divisor(st, chan->address);
+			return IIO_VAL_FRACTIONAL;
+		/*
+		 * Post filters force the chip to a fixed rate. These are the
+		 * single-channel rates from the data sheet divided by 3 for
+		 * the multi-channel case (data sheet doesn't explicitly state
+		 * this but confirmed through testing).
+		 */
+		case AD7124_FILTER_TYPE_SINC3_PF1:
+			*val = 300;
+			*val2 = 33;
+			return IIO_VAL_FRACTIONAL;
+		case AD7124_FILTER_TYPE_SINC3_PF2:
+			*val = 25;
+			*val2 = 3;
+			return IIO_VAL_FRACTIONAL;
+		case AD7124_FILTER_TYPE_SINC3_PF3:
+			*val = 20;
+			*val2 = 3;
+			return IIO_VAL_FRACTIONAL;
+		case AD7124_FILTER_TYPE_SINC3_PF4:
+			*val = 50;
+			*val2 = 9;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	}
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: {
 		guard(mutex)(&st->cfgs_lock);
 
@@ -751,6 +892,7 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long info)
 {
 	struct ad7124_state *st = iio_priv(indio_dev);
+	struct ad7124_channel_config *cfg = &st->channels[chan->address].cfg;
 	unsigned int res, gain, full_scale, vref;
 
 	guard(mutex)(&st->cfgs_lock);
@@ -760,7 +902,9 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 		if (val2 < 0 || val < 0 || (val2 == 0 && val == 0))
 			return -EINVAL;
 
-		ad7124_set_channel_odr(st, chan->address, val, val2);
+		cfg->requested_odr = val;
+		cfg->requested_odr_micro = val2;
+		ad7124_set_channel_odr(st, chan->address);
 
 		return 0;
 	case IIO_CHAN_INFO_SCALE:
@@ -1006,6 +1150,52 @@ static const struct iio_enum ad7124_syscalib_mode_enum = {
 	.get = ad7124_get_syscalib_mode
 };
 
+static const char * const ad7124_filter_types[] = {
+	[AD7124_FILTER_TYPE_SINC3] = "sinc3",
+	[AD7124_FILTER_TYPE_SINC3_PF1] = "sinc3+pf1",
+	[AD7124_FILTER_TYPE_SINC3_PF2] = "sinc3+pf2",
+	[AD7124_FILTER_TYPE_SINC3_PF3] = "sinc3+pf3",
+	[AD7124_FILTER_TYPE_SINC3_PF4] = "sinc3+pf4",
+	[AD7124_FILTER_TYPE_SINC3_REJ60] = "sinc3+rej60",
+	[AD7124_FILTER_TYPE_SINC3_SINC1] = "sinc3+sinc1",
+	[AD7124_FILTER_TYPE_SINC4] = "sinc4",
+	[AD7124_FILTER_TYPE_SINC4_REJ60] = "sinc4+rej60",
+	[AD7124_FILTER_TYPE_SINC4_SINC1] = "sinc4+sinc1",
+};
+
+static int ad7124_set_filter_type_attr(struct iio_dev *dev,
+				       const struct iio_chan_spec *chan,
+				       unsigned int value)
+{
+	struct ad7124_state *st = iio_priv(dev);
+	struct ad7124_channel_config *cfg = &st->channels[chan->address].cfg;
+
+	guard(mutex)(&st->cfgs_lock);
+
+	cfg->live = false;
+	cfg->filter_type = value;
+	ad7124_set_channel_odr(st, chan->address);
+
+	return 0;
+}
+
+static int ad7124_get_filter_type_attr(struct iio_dev *dev,
+				       const struct iio_chan_spec *chan)
+{
+	struct ad7124_state *st = iio_priv(dev);
+
+	guard(mutex)(&st->cfgs_lock);
+
+	return st->channels[chan->address].cfg.filter_type;
+}
+
+static const struct iio_enum ad7124_filter_type_enum = {
+	.items = ad7124_filter_types,
+	.num_items = ARRAY_SIZE(ad7124_filter_types),
+	.set = ad7124_set_filter_type_attr,
+	.get = ad7124_get_filter_type_attr,
+};
+
 static const struct iio_chan_spec_ext_info ad7124_calibsys_ext_info[] = {
 	{
 		.name = "sys_calibration",
@@ -1016,6 +1206,9 @@ static const struct iio_chan_spec_ext_info ad7124_calibsys_ext_info[] = {
 		 &ad7124_syscalib_mode_enum),
 	IIO_ENUM_AVAILABLE("sys_calibration_mode", IIO_SHARED_BY_TYPE,
 			   &ad7124_syscalib_mode_enum),
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ad7124_filter_type_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_TYPE,
+			   &ad7124_filter_type_enum),
 	{ }
 };
 
@@ -1299,17 +1492,22 @@ static int ad7124_setup(struct ad7124_state *st)
 	mutex_init(&st->cfgs_lock);
 	INIT_KFIFO(st->live_cfgs_fifo);
 	for (i = 0; i < st->num_channels; i++) {
+		struct ad7124_channel_config *cfg = &st->channels[i].cfg;
 
-		ret = ad7124_init_config_vref(st, &st->channels[i].cfg);
+		ret = ad7124_init_config_vref(st, cfg);
 		if (ret < 0)
 			return ret;
 
+		/* Default filter type on the ADC after reset. */
+		cfg->filter_type = AD7124_FILTER_TYPE_SINC4;
+
 		/*
 		 * 9.38 SPS is the minimum output data rate supported
 		 * regardless of the selected power mode. Round it up to 10 and
 		 * set all channels to this default value.
 		 */
-		ad7124_set_channel_odr(st, i, 10, 0);
+		cfg->requested_odr = 10;
+		ad7124_set_channel_odr(st, i);
 	}
 
 	ad7124_disable_all(&st->sd);

-- 
2.43.0



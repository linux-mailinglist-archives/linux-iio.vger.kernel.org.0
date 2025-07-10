Return-Path: <linux-iio+bounces-21552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF58B00ECE
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 00:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD99644831
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801D62BEFF3;
	Thu, 10 Jul 2025 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A3o4uWvp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4902BD013
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 22:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187240; cv=none; b=YfP34r5JCMwWDGUJUz1BsLLuGDmJJ3Kx3tWuu3Bkr3mCGAq8qChXg528tY2OhnRdBcw47rVsa4kOF9Gv8uQCPJTgwjUFfty+UFshvVUmo/EfBQ/miRKIXEsP8CoY9r24ETOorwJFVimMxqoDqxg+aBSDzLxQ1HMb4oHEQ2angCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187240; c=relaxed/simple;
	bh=Y4xxzpQMXT0tVAh0B+9LP1ypOj3L5Cj0Clka4wYTVnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kCDWag5Gfn0nhfL8TIilYb5XJxz4+zMXlc7ni1Uz7WHDNNboBHNa2Mze9IAESKtXlwwolHEgBXr2UZ5UWKkjYIAl79spjDEHSmyvxrdjy+37Mc2xtrvf7WH+aVzG2SrUz2uvifb2FBxfXl88ghG8uLZj56EBY371GytjnPRmW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=A3o4uWvp; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-73b5350980cso1337094a34.1
        for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 15:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752187237; x=1752792037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIBjwMYnL74TcVrAH5e3IGRZZKgXqxeLaFBUWJ6E5yw=;
        b=A3o4uWvpwJbT7T61DXFECIZ2RvI/bz71hV+L7EfHspzSG4ickqRBcrzEwYv8yXDBkB
         d8Uda8sqcDcxeXxBE3gC2aQdqcpss0nkW4zIOvs5yR3GiYRNy2eVrgRVEkYJFgZuleCh
         xwFBeSrcMFRpNau3pmlUXVxuo7gT6fkot37bEY//dCLLJc865ZIEcDwnUV1njWDKmuw7
         n26gCn8X8zq7JTw4viT8J4GoTuDw3u9rJRqqI8Jq03yETHB21BnNJh+ZRCR5xIeuNTX7
         ea2VD5dLwFFZTKgpew5A2haz8422+XmFr6HqTTtRpfIC+d3D4iGzS5Ux7bETJorHWi1g
         A8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187237; x=1752792037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIBjwMYnL74TcVrAH5e3IGRZZKgXqxeLaFBUWJ6E5yw=;
        b=lGAdSMxpUk5HLc/5UeMciIwyl6sHiLyiryvH6efM5iOSG0fL+nfk+FtJq04vbSLir7
         DhY/kXa7N8ylX9uI/7lXGNN3wfw6IfhEBbRPVIbcwtmcxV2s5Pg1Ilsp3hbkgRX8WC8y
         Xpi01KUQXhxe9EgotFngJS2daVmmsZAwnoOAHl6gZuoein4L4boTmg7pkCjqrK9sSq6P
         i3FOo50rukp2wyS303CVpgQjnRrE/Bj8KPoZp0i8zhc+Cpa26LJr3sDVwVDtVKrSEs+I
         9E1Kh/3hVpOLdJ6Jx/0LgWnqNMRWMQC6EBREuHRGCwvp2EK6oKeDk28jXBrI5PLZf3VL
         XLZw==
X-Gm-Message-State: AOJu0Yyi9aCRcahvb0eaxcs56jtO/Hs/sRXoZwk6iWzCvX0KjxdaOwiR
	2g88hnXcV+a3VkHj0D3sbPcRcLb7OczQ1/J5AfB7O190mAcshHgEjpmGZxX1hhJOJyWOTfNUKBl
	NEtwV8gc=
X-Gm-Gg: ASbGncuUGS7hfXSr6WPifeyIS1Ra72AqpmBKrjLPXYXU6NrDjx7rJNPx2GBy+HMYwJa
	8rF3nxsixClTC7mTXBKkQ17ykwrzEGt6lyulghkE9JZackeKwzn6E8y5j12LuPyTcDly7hRlScB
	1bJPAUF7lt0ier6l026m2rCzOobwG5aRV7f/x2BmWRxCC+depn9CzkZjR0iDa3wtoI41sjYxwoq
	yeMsPZ13Ktz0P55I9/bJx2t60qBrpHIpjNvpflAjEe7hFBKPhTj66m3FE60QCK7Lujm19s565JA
	zz03h1hPsBLGowjM7e2xi2JsqnpNy+Dij8fTgNhTV+SJ+qasN0HMQozxvpA3IZ/uncLO8PdV+JN
	O58kG+Pq7zO1ESRP192MLsfh0/w==
X-Google-Smtp-Source: AGHT+IE0jBieUnW+rRGfWxll6L52XTUO/aByQNjjFVxiGHTKx/oAlmLkC6wro7rhwPBufH+QA4JFrQ==
X-Received: by 2002:a05:6808:220f:b0:3f8:bbf3:3a18 with SMTP id 5614622812f47-413c4890f1cmr3917546b6e.16.1752187237575;
        Thu, 10 Jul 2025 15:40:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:891b:7836:c92:869])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9d950f1sm305944eaf.18.2025.07.10.15.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:40:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 10 Jul 2025 17:39:51 -0500
Subject: [PATCH 2/5] iio: adc: ad7173: rename odr field
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-iio-adc-ad7137-add-filter-support-v1-2-acffe401c4d2@baylibre.com>
References: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
In-Reply-To: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3350; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Y4xxzpQMXT0tVAh0B+9LP1ypOj3L5Cj0Clka4wYTVnI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocEFG9srtwbvcID06yiIQNe6pU879Zuxtnvmfy
 fKROwb7ExiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHBBRgAKCRDCzCAB/wGP
 wKeSB/9qDmJmuCanZotA2Zn3hgDWFta7IAV0s/RKiWUXnhfr/+xEEaT5j/eOllCOubgJuNeUxA2
 HjnlYeRd0bZSEmzYuN9KVWZJ4dVvQbkiKsLae01JHtM2VgLmCaTAKlmgOOsl229QmdGhCYJcHYX
 h7U0bswENjIP8oj32wBm4jktVe40Pq1MpvoliTqjkhFybA+iWMz7wsQnwprfaFG9ebDFHrM79EV
 8R2fs7RdinBMV1AWhKQF20AjJViCjeTcveF1TpbJS0ty3IUxNvxafYtL//kPH7smNkt0pSvLkPC
 KqPooEsnl5KELdG5WuhwRpcAngy/Q6nuR1hBUz6c4jqf2Imf
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Rename odr to sinc5_odr_index in the channel setup structure. In a
following commit, we will be adding a separate odr field for when the
sinc3 filter is used instead so having sinc5 in the name will help
avoid confusion. And _index makes it more clear that this is an index
of the sinc5_data_rates array and not the output data rate itself.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 5daf21c6ba5637b2e47dcd052bdd019c3ecbb442..01d78d531d6c024dd92fff21b8b2afb750092b66 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -205,7 +205,7 @@ struct ad7173_channel_config {
 	struct_group(config_props,
 		bool bipolar;
 		bool input_buf;
-		u8 odr;
+		u8 sinc5_odr_index;
 		u8 ref_sel;
 	);
 };
@@ -582,13 +582,13 @@ static bool ad7173_setup_equal(const struct ad7173_channel_config *cfg1,
 		      sizeof(struct {
 				     bool bipolar;
 				     bool input_buf;
-				     u8 odr;
+				     u8 sinc5_odr_index;
 				     u8 ref_sel;
 			     }));
 
 	return cfg1->bipolar == cfg2->bipolar &&
 	       cfg1->input_buf == cfg2->input_buf &&
-	       cfg1->odr == cfg2->odr &&
+	       cfg1->sinc5_odr_index == cfg2->sinc5_odr_index &&
 	       cfg1->ref_sel == cfg2->ref_sel;
 }
 
@@ -650,7 +650,7 @@ static int ad7173_load_config(struct ad7173_state *st,
 		return ret;
 
 	return ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(free_cfg_slot), 2,
-			       AD7173_FILTER_ODR0_MASK & cfg->odr);
+			       AD7173_FILTER_ODR0_MASK & cfg->sinc5_odr_index);
 }
 
 static int ad7173_config_channel(struct ad7173_state *st, int addr)
@@ -1183,7 +1183,7 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		reg = st->channels[chan->address].cfg.odr;
+		reg = st->channels[chan->address].cfg.sinc5_odr_index;
 
 		*val = st->info->sinc5_data_rates[reg] / MILLI;
 		*val2 = (st->info->sinc5_data_rates[reg] % MILLI) * (MICRO / MILLI);
@@ -1229,7 +1229,7 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
 				break;
 
 		cfg = &st->channels[chan->address].cfg;
-		cfg->odr = i;
+		cfg->sinc5_odr_index = i;
 		cfg->live = false;
 		break;
 
@@ -1655,7 +1655,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan_st_priv->cfg.bipolar = false;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
-		chan_st_priv->cfg.odr = st->info->odr_start_value;
+		chan_st_priv->cfg.sinc5_odr_index = st->info->odr_start_value;
 		chan_st_priv->cfg.openwire_comp_chan = -1;
 		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
 		if (st->info->data_reg_only_16bit)
@@ -1727,7 +1727,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan->scan_index = chan_index;
 		chan->channel = ain[0];
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
-		chan_st_priv->cfg.odr = st->info->odr_start_value;
+		chan_st_priv->cfg.sinc5_odr_index = st->info->odr_start_value;
 		chan_st_priv->cfg.openwire_comp_chan = -1;
 
 		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");

-- 
2.43.0



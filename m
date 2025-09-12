Return-Path: <linux-iio+bounces-24038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8934B556C9
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 21:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BEB7AE0229
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 19:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3C7338F2A;
	Fri, 12 Sep 2025 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JVv1enHC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4C30F535
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704215; cv=none; b=K+x0YdpFIelXlWJmrNDWOmwcSgpnTyINdMEkitwZSJWbBeug22FDiZisKP1yrOBKvRXXlfaiuZ54wua5q3eKqf4XH5deJEBuGJFGw9wBVwwX1vBuBkaGaiIHrbyErLLPsNu/s/K+qVOE1cHrJIdyMe5p2q4Kj3zzyp9p8B5Q6jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704215; c=relaxed/simple;
	bh=v0NAW7Y8Tgsq4aoIScefhPV46tEnXeycoysRScmk0Ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JogW7VDaE6wkOf2/kpFwFnlB4NDvOXW0EhLXEt4lU72HB93jFX1qxxFdd9pDOZCf0oue/lcLX9lLheQZkD5CTW+FnPAsGSonvrJzvmqq9S8bz0lfVFM+kIAA9v+9E9cJrwnTugbKvntFfwsWzj93WRkdnkIhv5LfnuuV5fxjodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JVv1enHC; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-321289dee84so1178942fac.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757704211; x=1758309011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SljH0VYmnL+jw/umeaevbM/CplB5Kc7vt0YrqGHjMOw=;
        b=JVv1enHCX40KAlU+9Np81K8mGk0fslyARTuo5f77iyiXLvkHX9fYOPwtsyewabsZKG
         nuZ5ytEvnAzNq7u6ydT39OLpzci9rNmKgGa5sVuTPCjOh9aqmQsPJsZLpg0aFlYaoJe6
         xfnlFsnzCaA6Z6Q17115jYmhVCjiFwLEpJiML6JZHLhhpGp/X1MQG8sHzznGbDXZusak
         5/OncdsSAjwb1CvHun7IKtf4Pmbopu2+955sHTVIdkecAUzaIWPY114kUhefRBm114l9
         RsL5UEvm22qR7eIzfX1TUUPDhM8kNKv54W7mqeudFU55BGpmikvI4Hzck2fBclJogdIG
         f2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757704211; x=1758309011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SljH0VYmnL+jw/umeaevbM/CplB5Kc7vt0YrqGHjMOw=;
        b=e77Dt3wh05hD1tHfFHGrgmm0Fhg2hgUrwO6PCexxpqaiqD/AOiAID7JF5Q4vRSxnMu
         FUJThBkegm4xcvIKE+TSmeZnbBU7e1S76T3EHu1BSQK4tPfZG3GmdeD7aBJFwzbDOiTe
         QuYD3Sh+iBJqybsKRTmnmBP2eWiErmpVIngKQ6tA6dY8h+ZtdpBRFdsEOpFUCEEzBTFC
         gLVmbfXw3lYWahJA5X6ROqA+fH9c9qEv/tD7TbYpNWYdTZbkBnWByBr3Rfk2w/Pg7Qi7
         eT4GPk6JSbZaWJYrpLWSvCsGpGFmpi1V8Opn6/oc+0Ek08hWuF1PQoils0c+5ahY8bIk
         KiZA==
X-Gm-Message-State: AOJu0YwiHxhVK2pAyDjQ22OrcBQkLXXnevdCxEC0ZrACsk0BrHfjzx73
	y/4a51pNGbmrHdOe9DWX3Vw5DyAsYRGFOoy7dduq3Z5iD2DOkEtJi9CpC1vZ+KiCpB0=
X-Gm-Gg: ASbGnctpCJX/cWdeBY671GKG4RZ1bfGPWiIy7+A5fsbt3RmqhCzXxDhUwCFFxbxYuSx
	lRGmak+wfwk6JlNWhfXHgZg4heDnMNl7ee/sOdUjc1qyywNRIU9zrAskVXJ9gkUwN8xzkVUVfsw
	lWwrRtO6GGazlaNv7w33GC+03/6ZRNniODHWbjaRmq8G6n9OQ9bAWWra1U429sTvCazklEddzWu
	GiNR+l5F61EX5B8KxR5sYcPhDARTNUEcyISsQYoXpxvZ0ttlCnm1pm5cp/prcujKk51QREf7Qpj
	Z4xpVYpfQKtQHJrku0EdTSCU2vab4ba5oFITrV6RJuSX6Uunjfgsmx0qFZTDqBHTCG7rzbl9at7
	sawhjf25UOXz94y/z/jy0qoXofWf7
X-Google-Smtp-Source: AGHT+IEYjasC71hvolYSLo91FNK0i9nF7WGqfhNiYnif0y60U/+XyYVSlNOqywPPuiBlSiC58D8CQw==
X-Received: by 2002:a05:6870:7025:b0:319:c3d3:21bf with SMTP id 586e51a60fabf-32e58042ba5mr1841846fac.47.1757704210771;
        Fri, 12 Sep 2025 12:10:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986c872sm1172564a34.15.2025.09.12.12.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:10:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 14:09:31 -0500
Subject: [PATCH v2 2/4] iio: adc: ad7173: rename odr field
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250912-iio-adc-ad7137-add-filter-support-v2-2-bd32dfa3d761@baylibre.com>
References: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
In-Reply-To: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3394; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=v0NAW7Y8Tgsq4aoIScefhPV46tEnXeycoysRScmk0Ec=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxG/8/RmUXg0ZY9kb6HJ+04aymbzF6MgReJoOd
 mxl9Et7JhCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRv/AAKCRDCzCAB/wGP
 wEK6B/9XK4C0R9w7TaO5OCYGHStxfDUkSTiahti8qnURv+f38LAF6wW8pa/2Aa+lrAL3ucWnDF3
 8SQ/8hSVRsp2BwqNuV/E4w9jodb/+8Fww+IQ47pWh/hzaE3gDpsWM3S2pl2nVDmsbPsXDstmvas
 rFUeOJT83UQBEkbVZOla2p3W0DCak23ezrH+IzE8Kj7qauWahHbtCLBGqVGeXFNk3rv7trbqtAe
 jC9yeU/tn59wrxQZyTFQe0FlLNP4JBHQZ8zif2vJ8Z+IbCLI8Bwtmrat+MUaRa8adLLs9UxAdf2
 b6X1lYCDYaqWDE9KU8K4Rbx1nsBlqJfsGEuk/W4mAlSQX3jY
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Rename odr to sinc5_odr_index in the channel setup structure. In a
following commit, we will be adding a separate odr field for when the
sinc3 filter is used instead so having sinc5 in the name will help
avoid confusion. And _index makes it more clear that this is an index
of the sinc5_data_rates array and not the output data rate itself.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index df586cb8f09ccc6d1647c66fdb9f147c0b4694b8..80734ae25f9df31d846e242ab7142251e4ee588d 100644
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



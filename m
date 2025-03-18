Return-Path: <linux-iio+bounces-17052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CA0A68018
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C486188E869
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 22:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4B0207DE2;
	Tue, 18 Mar 2025 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CeWog26X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2DC21480F
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 22:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338351; cv=none; b=oTbasVuZZWwjEu4tGLTpsnN8RW2/kjaE/T12Gl+8mlY9MAFXOpzd1vH5TJlrDTSoz20sM2fNx9eV/C0+jEyJyNRgRTF4vR6khLfYmMDVGWZ9hde5G5tkjzIMRpQBUzEMQLTB2CD326kP4CvrMpjVX9UX2XSWUsf6qcewKBRxcHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338351; c=relaxed/simple;
	bh=n2XuLLxXTCJz5e0bPe5IE80EDLX+dhBN5Wga3hNAHPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcZGbJ5ZIkuyBxz8OY7vZtV2FxR6AHyQjIzz6WxvH9DYy0C45zeFPEvcCOsHJtquzwxBBdGwqaFLp/ieEwlyptCYd2rfDFvbmQlYbRkcA76EkUmhDhobh2W03Uma11GsX+ZpiBEp51oCvtrpuUoDDwkyoQTyn5P+F7BzQL5akDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CeWog26X; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72bb97260ceso1345372a34.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 15:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338348; x=1742943148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjwttRptCyX/KmMrSfvlA1VrtaMa/7/5WsmiZGKA3eU=;
        b=CeWog26XXzmblzCH4xDMAazAR4ljCHCTSuIwliJZCJwXwoa8yDsI/9S/+qomV65+ku
         FVhXiT9Qh3/Ypd9d+VIxKeRE/c4cdOpghLvRpj77GChSAIyYz/77x4s0t7HQ6GdrnNFF
         FkOeSHo4N90K/72q2zTIi1dNGYDj3y9jHjb+xGSX7bIvi2T8UfZMwDmfGT4j1MWr+GT1
         BXp+rsK7Vdk4T5dMlyTGzawC/eRWTxXaLqW1uCN+9lXd75V95zKi0zBDAKjzPkx/sZ44
         n8dxIOS/z/4/GQ5aJSbdWQFwtMZ/MOKWg1K8R9KF7djZ68+W/RRhVpdDthgsTbM8kpRC
         +ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338348; x=1742943148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjwttRptCyX/KmMrSfvlA1VrtaMa/7/5WsmiZGKA3eU=;
        b=ou++xMEFqV1mThLvBQ2mV8snTDIUdQ2gnvqztukK2mtHSNSLgkDRqIEK+uaxzU80yU
         mMAS3nVtrX4nX14+30XEJKZLDOe1O0/4902x1PctAMeU2cJ/i7iDsUR+E77mxkaGSCsZ
         6V5IzReqrN0RtKRZUgqR/qT6O4hfx3Lj/yZ9LZj4763SdayFNBilo9zYdcxOWrlYvgWm
         FBv/IyA3Szkbs1KeKPsd69kcXbaKhZo+/2M2CX4rmv+m6Moyg5cAyBvfuFSi0N+hApSW
         tf2nmMbaW4//s0hsNY5u01c4K41TvVRVP2ZIGZS/DnniF6c00CbkbzI7w+Gx9wp65xuy
         Be+w==
X-Forwarded-Encrypted: i=1; AJvYcCVDc+n+MGoQZU4X2JDMRe+1FAdLna5FjX1swrz+9BNqQ2GtrDcfghok/InLNHHnuQOidzmoCAkiZf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1QNikj73D1BCM3Xl5iCzE8bgbOUGkdkMyR6W15kuOaQS5kz2m
	+0TWzBybw1m80BM7HFfuJxqOT2rxQAR7ab2IcCa6VrBp7GuoWZZOwjxpt+n/Dbg=
X-Gm-Gg: ASbGncuWtXrMj7Wr5od7FVAJWIynVo3c/tSZzHDqSViHHP+GAoBW2h39Qcy6w4W8ptJ
	gZDVzDZY8GNlGeKQdzKbfaq7WsBiAmb0rghSv7kUU5ldm5sLFHKK+Ghy5zZ6TF2nIAD+QcWPA6p
	c/heWJ9DxnVMUCGss6O5qt+c23Lt4dIMCIXNP66sGOJWGceVj5I4TlbQxDXKt1MDC6I5o3Q2NYR
	jJlyRu3xDG++xP5pt3T3oxHXxEYl4FTEOINxgN6JUkDkcP8vDaRTjvnAT+TZw/oO8+LohnaANX/
	DG3Gs/zNgPhhyrz2mWHhzGXVZn6CGiYYfOFDu1hb1wrlyEt1D3u/qkSehJn4+vFSk1yPhUBqGp9
	O
X-Google-Smtp-Source: AGHT+IFZeOB6UmAok88QtPjMZ4a7qssj21BeEdLRLwKLrzI8BBpWjmA+/MaBq6owK+oeIB5KrrWUKQ==
X-Received: by 2002:a05:6830:3903:b0:727:2f79:ce3a with SMTP id 46e09a7af769-72bfbdc582emr520823a34.12.1742338348657;
        Tue, 18 Mar 2025 15:52:28 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2191690a34.52.2025.03.18.15.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:52:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Mar 2025 17:52:16 -0500
Subject: [PATCH v2 08/10] iio: adc: ad7606: drop ch param from
 ad7606_scale_setup_cb_t
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250318-iio-adc-ad7606-improvements-v2-8-4b605427774c@baylibre.com>
References: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
In-Reply-To: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6289; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=n2XuLLxXTCJz5e0bPe5IE80EDLX+dhBN5Wga3hNAHPk=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn2fkddg4E/ENxwGAXmv7gEi6SWv1qMVJ/43o2K
 8DKGGweFWuJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9n5HRUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAPZ2xAA13FHef7K1wo5lD2qvUjWMlT4vMtahvJ4RcAzXf6
 dWXiycvPGGTxGTzb0ngrsueqOxaxcYbUjiBVRxa9rmkcjZpFjyB6iS+LvuT1//rgTJze7j7ss+w
 4Z+pSrn0G78DRNdIsesOwfvQso27KKIty4Z3ufhzvtoo/DufJSvzAEkehGxQGbm7QtgWSAK77/A
 ZJsAbNVS4ImaSz6nfmeLbC54/6NHbji/44Esn+XSItPhdLcuqSnA7BHHbHMdgZeFaANfBWce9eU
 gW1sB/cA8NgesbVd6AYqTW5CuAKLuxnSYRDrSwXGjWe8WyI2ztfm13nqh2UZUBmAv19xwIqMtl4
 k9LwyzIMx1C1oz2BuWv8T3aVWUpTk4UJk2N9+i4/Uef7qfQu5IwxXn0c7/6FYJ48KTjRxN6m86C
 vCDojG30HyYQ6kncX4IBRYJFFzi5tmmj6dAYjqiJ2j9Pf01OfPqoPJzgK+erdzwmyhpjoJ+CBaY
 n0tqy3fn89weR+3gWhfIvUnceX9F3oejVYig8TOpQF3zHqntK92ujLJ635MNs57vM7NM2TBsOLQ
 hAkYdQxEXfiQwUf+vET7vK/roFBfvKXgrvMzP9R/A/FknGqSiD16uXBTzu24JqZsaPGZUbwS5RT
 7/w2dW80QK87zdOQwsvftnH+/hfHXFdo+oZrffCLJcGQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Drop the ch parameter from the ad7606_scale_setup_cb_t functions. The
same info is already available from the chan param via chan->scan_type
and chan->channel, so the parameter is redundant.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 44 +++++++++++++++++++++++---------------------
 drivers/iio/adc/ad7606.h |  2 +-
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 3f03d4b7c2ceed5f7a134189c283ce392167b111..09c35161df365e531b8d254c7333359facf045c7 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -182,17 +182,17 @@ static const struct iio_chan_spec ad7616_channels[] = {
 };
 
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
-					  struct iio_chan_spec *chan, int ch);
+					  struct iio_chan_spec *chan);
 static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
-					  struct iio_chan_spec *chan, int ch);
+					  struct iio_chan_spec *chan);
 static int ad7606_16bit_chan_scale_setup(struct iio_dev *indio_dev,
-					 struct iio_chan_spec *chan, int ch);
+					 struct iio_chan_spec *chan);
 static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch);
+				   struct iio_chan_spec *chan);
 static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch);
+				   struct iio_chan_spec *chan);
 static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch);
+				   struct iio_chan_spec *chan);
 static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
 static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
 
@@ -346,10 +346,10 @@ int ad7606_reset(struct ad7606_state *st)
 EXPORT_SYMBOL_NS_GPL(ad7606_reset, "IIO_AD7606");
 
 static int ad7606_16bit_chan_scale_setup(struct iio_dev *indio_dev,
-					 struct iio_chan_spec *chan, int ch)
+					 struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 
 	if (!st->sw_mode_en) {
 		/* tied to logic low, analog input range is +/- 5V */
@@ -425,10 +425,10 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 }
 
 static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
-					  struct iio_chan_spec *chan, int ch)
+					  struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 	bool bipolar, differential;
 	int ret;
 
@@ -439,7 +439,8 @@ static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 		return 0;
 	}
 
-	ret = ad7606_get_chan_config(indio_dev, ch, &bipolar, &differential);
+	ret = ad7606_get_chan_config(indio_dev, chan->scan_index, &bipolar,
+				     &differential);
 	if (ret)
 		return ret;
 
@@ -482,10 +483,10 @@ static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 }
 
 static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
-					  struct iio_chan_spec *chan, int ch)
+					  struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 	bool bipolar, differential;
 	int ret;
 
@@ -496,7 +497,8 @@ static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 		return 0;
 	}
 
-	ret = ad7606_get_chan_config(indio_dev, ch, &bipolar, &differential);
+	ret = ad7606_get_chan_config(indio_dev, chan->scan_index, &bipolar,
+				     &differential);
 	if (ret)
 		return ret;
 
@@ -540,10 +542,10 @@ static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 }
 
 static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch)
+				   struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 
 	cs->range = 0;
 	cs->scale_avail = ad7607_hw_scale_avail;
@@ -552,10 +554,10 @@ static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
 }
 
 static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch)
+				   struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 
 	cs->range = 0;
 	cs->scale_avail = ad7606_18bit_hw_scale_avail;
@@ -564,10 +566,10 @@ static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
 }
 
 static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
-				   struct iio_chan_spec *chan, int ch)
+				   struct iio_chan_spec *chan)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+	struct ad7606_chan_scale *cs = &st->chan_scales[chan->scan_index];
 
 	cs->range = 0;
 	cs->scale_avail = ad7609_hw_scale_avail;
@@ -1305,7 +1307,7 @@ static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
 	indio_dev->channels = chans;
 
 	for (ch = 0; ch < st->chip_info->num_adc_channels; ch++) {
-		ret = st->chip_info->scale_setup_cb(indio_dev, &chans[ch + offset], ch);
+		ret = st->chip_info->scale_setup_cb(indio_dev, &chans[ch + offset]);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 16a230a7c00e3504744b97da339cdea6b8ecf40f..c57a193761c92add6f82cf0cc51ccfdb9d8d2ab4 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -113,7 +113,7 @@
 struct ad7606_state;
 
 typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
-				       struct iio_chan_spec *chan, int ch);
+				       struct iio_chan_spec *chan);
 typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
 
 /**

-- 
2.43.0



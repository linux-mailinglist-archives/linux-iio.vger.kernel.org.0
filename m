Return-Path: <linux-iio+bounces-16007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A68CA42288
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 15:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B68427A7F38
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 14:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105611459F6;
	Mon, 24 Feb 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JN+Iq9Oy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84581386B4
	for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406254; cv=none; b=fAOAzCW1DptWYkkP6PAU+xtbK37z+LVc6DbQ7XifJDJJT3ktOn6YIjd11e02sQgkRDb8enHVGo9oGLdXe+IYG3eAb1jge8eXNVHibp9PSjB1fDlwW207w/Jm3CwIrQFdf/o18TFbqpQzIsw8pJOVAcJLJY2flgZf4vAJuPjs+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406254; c=relaxed/simple;
	bh=Vs81Vms3na76LF8phSoXFrzIkYQ+oocjyJOIOe552i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8KintRfVVUggR/rkHT5VjzgkCk3q9KmZb5c0+zG7sGnmN+h0oxIURaYGqV48AAERGRh/onOIXsQvsrgAcMmbJ9x68+aQvXH46LfwBxY6BG2fO/La+kbXVC4N4EXOSc0YnAhJRrS/eIFznygdNB9dDO6V//aqUv+xokqenTqaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JN+Iq9Oy; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abec8b750ebso48521966b.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 06:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740406251; x=1741011051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk4bNibOnobb+BM3zwG+9LKQ40oSTYCAQYzdjAQx4Og=;
        b=JN+Iq9OyN9Rv951LDNxQYdXRVjl057z2CpQClllPnLe6D933WXDBX1s9s/6/k32Nlb
         6bGeMasizvD4YyZWd27PMaQI7a6/C+PNUH0yOho0wFH7VVjjMUOY6c3t4vtQOfXgGvpY
         gASRTwm1CBpVnXND37345oaRugScr2ikbL1DRbPEKrCNstwPQKYHd2+aCy6MuNvs+ysD
         v692GdYWOLLXbG1OasQbZvNAf4Hm7kRKgMqIVzXo8uFt7zNDPadkr3xndbkMEVwLvKFg
         mR+CLxi8ZLnNayRtTKcZTaNXkWGQ7zX2kPtsdp7fg94lHn39H2j6oyLHNSZ/zBykNuM1
         /onA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740406251; x=1741011051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kk4bNibOnobb+BM3zwG+9LKQ40oSTYCAQYzdjAQx4Og=;
        b=FPir4hPIpsjJqzUlmaeHh0RpgBDb4/bcjdS7FJFziXclzPa+81rpVFPipQ+O4/4SZo
         em5G2pwS9Y4QVofElF5R006WPnRXCyzuFeOOcLq35mo8YbDh1QT33HBRghTAdVBAcqHB
         MKVcWTdTNMxWCwee20RXuomNlRmU4nkWJuw3/Fu8jTap+ijejslAPc5KiUnJZE4nvNVd
         V1NGFv+0NOVoFFM68MN0B6QECAuIy75dl0m+TjqlA89mGREBb4ecasnrZoByU0FBAUcS
         xHCk5wYeC/7do3U0FxNsWfEA9Fu2Y3Cguu6JqUBxRTqY5PEMVYyTtM2h5SsGigmdr5KQ
         B4cA==
X-Gm-Message-State: AOJu0Yx5Wq2FBEoK0375cXWJHpsg/l/YaGgOsdtNDR1/CTZkb4tlsAxl
	gaJwjFCRNQ+5Nl+rRldAfqYTNN3hjq5M9V84dAdR28CywrC/l2eLlMYWcOMqyio=
X-Gm-Gg: ASbGncujud7b/iQC1sv27mkR6MJUYalYSlS6Eh0kwvX6GSVuIapLeXYIMUd2jVfHKmK
	QhUcPO5HioM4MbW/ZuXP2dKDRHbEH0FaWtYr+qSbErGjcqsIk+mksG8sTNjhj/ZAWzc3AJ1oTpH
	N3bckdSKBxZ1dHABHMfEvKOcZrvPuNCWfIVOx8a3B/F4/ilhDLNUK/lw13JaTOHHO6u+2g04i3D
	RWECxaxmhI/92lFozzJXDjuBXx3wqnbnkdoEvLa9pBBj4MfSHGkII+pZHGBeuvfPu2xccn6hlbd
	EoiTxWpVqrk/Y6Av8a/5B4kM+AKk2YY=
X-Google-Smtp-Source: AGHT+IFfNBlX23Fo/B7jeIH3847V1gKlqsJYWiPnyZyPToC3SZ5rylJ6sNEMW/Frs6+NuBvAtVN+Aw==
X-Received: by 2002:a17:906:31cf:b0:ab6:ef33:402 with SMTP id a640c23a62f3a-abc0d9e4ef5mr1193501666b.18.1740406250878;
        Mon, 24 Feb 2025 06:10:50 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbb73a108bsm1341331166b.141.2025.02.24.06.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:10:50 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v3 4/7] iio: adc: ad7173: Fix comparison of channel configs
Date: Mon, 24 Feb 2025 15:10:15 +0100
Message-ID:  <941123d0959f766878c8799ad4aab325d6018351.1740405546.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740405546.git.u.kleine-koenig@baylibre.com>
References: <cover.1740405546.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2867; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Vs81Vms3na76LF8phSoXFrzIkYQ+oocjyJOIOe552i4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnvH3PDH3M4wnap9aEHEHK005GUAu+e/F5YHEU4 4VpdRzo9MCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7x9zwAKCRCPgPtYfRL+ TgLlCACk5TOiP2GkPM2nQheVIyqQlG2Ie0WRqHoWauqUuAURYsvsYjXyP/ZcExsxwVueMSdiUYO EaXtZwVIwzkR2CNYqAhhdule9cM5MMR2OtpMhv4U4U5/xFTRoBDTVXGpz4OyPSe8Ldwa7WpXKmm YPniC7V62spdyEsgu8lakspjLPE41eRUndXLeIRVgmbhiSHDvcdr25hLBJ6sgdiD9UEots3USQF QlUBVudpHj/lXEpTfzAjkFCxI5Rg0AtvbKNQewan9D65ybKgbm2j/bmX4S5vpbTRwiSS1To22Ck Qkqw71L5nRcCMsTAyiukNJK94FKNwI4JnBg+OEwXiX/UwDHh
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Checking the binary representation of two structs (of the same type)
for equality doesn't have the same semantic as comparing all members for
equality. The former might find a difference where the latter doesn't in
the presence of padding or when ambiguous types like float or bool are
involved. (Floats typically have different representations for single
values, like -0.0 vs +0.0, or 0.5 * 2² vs 0.25 * 2³. The type bool has
at least 8 bits and the raw values 1 and 2 (probably) both evaluate to
true, but memcmp finds a difference.)

When searching for a channel that already has the configuration we need,
the comparison by member is the one that is needed.

Convert the comparison accordingly to compare the members one after
another. Also add a static_assert guard to (somewhat) ensure that when
struct ad7173_channel_config::config_props is expanded, the comparison
is adapted, too.

This issue is somewhat theoretic, but using memcmp() on a struct is a
bad pattern that is worth fixing.

Fixes: 76a1e6a42802 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 54f9cc5a89f5..962033393943 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -197,7 +197,11 @@ struct ad7173_channel_config {
 	u8 cfg_slot;
 	bool live;
 
-	/* Following fields are used to compare equality. */
+	/*
+	 * Following fields are used to compare equality. If you
+	 * make adaptations in it, you most likely also have to adapt
+	 * ad7173_find_live_config(), too.
+	 */
 	struct_group(config_props,
 		bool bipolar;
 		bool input_buf;
@@ -568,15 +572,28 @@ static struct ad7173_channel_config *
 ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *cfg)
 {
 	struct ad7173_channel_config *cfg_aux;
-	ptrdiff_t cmp_size;
 	int i;
 
-	cmp_size = sizeof_field(struct ad7173_channel_config, config_props);
+	/*
+	 * This is just to make sure that the comparison is adapted after
+	 * struct ad7173_channel_config was changed.
+	 */
+	static_assert(sizeof_field(struct ad7173_channel_config, config_props) ==
+		      sizeof(struct {
+				     bool bipolar;
+				     bool input_buf;
+				     u8 odr;
+				     u8 ref_sel;
+			     }));
+
 	for (i = 0; i < st->num_channels; i++) {
 		cfg_aux = &st->channels[i].cfg;
 
 		if (cfg_aux->live &&
-		    !memcmp(&cfg->config_props, &cfg_aux->config_props, cmp_size))
+		    cfg->bipolar == cfg_aux->bipolar &&
+		    cfg->input_buf == cfg_aux->input_buf &&
+		    cfg->odr == cfg_aux->odr &&
+		    cfg->ref_sel == cfg_aux->ref_sel)
 			return cfg_aux;
 	}
 	return NULL;
-- 
2.47.1



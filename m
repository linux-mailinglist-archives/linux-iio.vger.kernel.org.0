Return-Path: <linux-iio+bounces-14555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D1EA1B9DB
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 17:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18B31890B7F
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01CE18E02D;
	Fri, 24 Jan 2025 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DpKBM3Le"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D150D16EC19
	for <linux-iio@vger.kernel.org>; Fri, 24 Jan 2025 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734503; cv=none; b=kJi/G5pRKw5vlBHOZqkgChe8KFreX5QFalvxCYvmc3aVonedECAXOsWG3l2inesx5jgU5x1DxG7GW++go1NdJZH6ZAQg8w15d016LfrDwYpp740XUhYj5y8uGSazqJ8iJ2kkzacJHqRm5O70bkwaVsDfw+t3kUPa9o1gwX7gUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734503; c=relaxed/simple;
	bh=uXr1ITHjKvOLpvD0hVAFujBjqWenww5u7P6+nwcKO0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L6SNKJBdal4nXC27xpJ6yRK+B6e6J6QiAvKuPBapEsRaTCw7HlNMIbwNVssY1/1P8lYuWWUoMZ7lJnUPgpuRsZdkUXeZX2a2PIUX2RqaGbPiVGshpwA4W88LS4D9x5V0uqif/0FOWVOkiuz3oZfkG6nXl7aJ6Us5RePwtI113+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DpKBM3Le; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so414244466b.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Jan 2025 08:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737734498; x=1738339298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qrLugdlwL5/Ilh8OCqqpgiBabhYSEK2nNoDNBCgTthA=;
        b=DpKBM3LeVqSiAw1Kd+4vyhZxQugySt9BNAz6kCPRHQ4KjQ4NYlIfz3nne24bhRHcsK
         q/VBoHsY6sdcQgT8qhzfKZ2Vz3REVura/+9s8v/vrJFcEgdqVtWjDtcvhfsly23t1LLH
         uVUcwu9kL+fvtMJ7ZDj0wHSwMRB1mcGtpr9L2HZqnQV3oUyBhyT3Jnzd1oKqdOUTlcjQ
         wgTdY6X7EeI/c1KzMkb9nYyBV4jZ5zDpttJkmts2ysM1hkK8iY0PBcyIEtJ8LRSRF1w1
         bqwXSwYDVmUKKvb+rXduZ1giDorP5Bbjdpc/oelc2IiVDsjFvTj4n70I94M0FeuZejyg
         jWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737734498; x=1738339298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrLugdlwL5/Ilh8OCqqpgiBabhYSEK2nNoDNBCgTthA=;
        b=vdqmd+nycaydohEilOT3+4zCgcQh62KF8o8p28f+prEdVJJrkEqt1MlRnu/CPI+0Y1
         ArHU9s+cFP3L5612MMYXVbANdQ/3/dAVPL58ehwcW3b5MxHHPGVBijtGmdRKJ0/bzXIr
         NRz5Enst6xF849xMn59eiJanX0nNFcO3So73kNT6+ZpgZ+SZMSTqGzSDlgY4xMQCuIQF
         nwvCg2mMbXopOuIK9GjHoZHj4M4KSa0VLeUauqftN7pFOolyfyy2Tgp01Pg6NaNSVgWx
         r2RMQjL+bx7uDrX0JNjBZpIMBQSq71/lTYndtb0eBZATRjKQdOgzSIYTqvJjwVH8ZHn4
         ysqA==
X-Gm-Message-State: AOJu0YxdjtWypmNwEtPbEwrNogh8qnJV58Xua9QGLLdAZwvh6/5Orz7Y
	ZWwGuLbocUlUiljH39M1jX/C588ozpKaLryjeZ94DUl3OaqmeQUCEcbdPeZIeiw=
X-Gm-Gg: ASbGncvAEA54QU3poDSwgZZPYLcd7U9ehQd4ZyicUBo1zmVC9wAldycngl+tpCMccBV
	oDYbH5c5+a3B5BGb3Oq+qAA53OvRvdyLu93BV9pEwsTGFhhPZTxbJhYnIkuCIGflBcrzafyFmlr
	5xJjVQJxOewbperl/IcRPAH87hQhtz/Kb3JxxA02hajkw/ro4n4xZyvvdmPgtlU1Uxtexrb8xcS
	AvW8YogrhaA0I7zBiRsBVg7BtqdS/50GnTdGbspTOW6LP4ItLIjaLvUudqLDWlOwmMBf5ChgNZ9
	Vd60zqz3YuDxnCMD0JnSoVwMHY3GsHPQ441khaZ7wOoVYUQ=
X-Google-Smtp-Source: AGHT+IFxfINdDp7Y+XggTboowyqqKzj+s2twZAmHmh1GmjCd1HjVxcCiVBesq7+cWsAusIjOiPgslw==
X-Received: by 2002:a17:907:7ba9:b0:aab:8ca7:43df with SMTP id a640c23a62f3a-ab38b37eb9fmr3199054066b.39.1737734496197;
        Fri, 24 Jan 2025 08:01:36 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc186183eesm1355484a12.10.2025.01.24.08.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 08:01:35 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ad7124: Fix comparison of channel configs
Date: Fri, 24 Jan 2025 17:01:23 +0100
Message-ID: <20250124160124.435520-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2864; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=uXr1ITHjKvOLpvD0hVAFujBjqWenww5u7P6+nwcKO0Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnk7lVBLdQ4NOoxRtfSVmt/ll/CdcDjM9rbUMzs EjLMo0GQR6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ5O5VQAKCRCPgPtYfRL+ ThaIB/46ACPryijFu2yam/bi6YvHAoAmvJW07Ac0jSfaiHAYX6GazvS36PvZpij1uyo6N6apr6O DnZfB8tvmwc+wwrfAQ6nY3yN8E/agQz3v6XafJist+0SRpVCpJx263cWLnGJrV1L5RuhXLpTfZ4 t9gu/e+X2ENm01IPzK69TVwTRexoIezyWxi7/zCMMH9eibLXoK7uuX3hxcfTmQbkHVEpLS03PkK H8vgcYONnPGD3TUD/dpo4+lt5np3Oh4dnDevEEBNJDu4qOdOJTRpGceDmMnhXuaL2L6x0hu0CNl +EOyFqws76Kk1THiG8sxSLzlsTNf12RAny2FBk+sbJcHEK5q
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
another. Also add a BUILD_BUG guard to (somewhat) ensure that when
struct ad7124_channel_config::config_props is expanded, the comparison
is adapted, too.

Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 6ae27cdd3250..5eb8ced416ba 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -338,15 +338,38 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 								  struct ad7124_channel_config *cfg)
 {
 	struct ad7124_channel_config *cfg_aux;
-	ptrdiff_t cmp_size;
 	int i;
 
-	cmp_size = sizeof_field(struct ad7124_channel_config, config_props);
+	/*
+	 * This is just to make sure that the comparison is adapted after
+	 * struct ad7124_channel_config was changed.
+	 */
+	BUILD_BUG_ON(sizeof_field(struct ad7124_channel_config, config_props) !=
+		     sizeof(struct {
+			    enum ad7124_ref_sel refsel;
+			    bool bipolar;
+			    bool buf_positive;
+			    bool buf_negative;
+			    unsigned int vref_mv;
+			    unsigned int pga_bits;
+			    unsigned int odr;
+			    unsigned int odr_sel_bits;
+			    unsigned int filter_type;
+		     }));
+
 	for (i = 0; i < st->num_channels; i++) {
 		cfg_aux = &st->channels[i].cfg;
 
 		if (cfg_aux->live &&
-		    !memcmp(&cfg->config_props, &cfg_aux->config_props, cmp_size))
+		    cfg->refsel == cfg_aux->refsel &&
+		    cfg->bipolar == cfg_aux->bipolar &&
+		    cfg->buf_positive == cfg_aux->buf_positive &&
+		    cfg->buf_negative == cfg_aux->buf_negative &&
+		    cfg->vref_mv == cfg_aux->vref_mv &&
+		    cfg->pga_bits == cfg_aux->pga_bits &&
+		    cfg->odr == cfg_aux->odr &&
+		    cfg->odr_sel_bits == cfg_aux->odr_sel_bits &&
+		    cfg->filter_type == cfg_aux->filter_type)
 			return cfg_aux;
 	}
 

base-commit: 5ffa57f6eecefababb8cbe327222ef171943b183
-- 
2.47.1



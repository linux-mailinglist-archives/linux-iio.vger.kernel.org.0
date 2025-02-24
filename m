Return-Path: <linux-iio+bounces-16006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF938A422AE
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E24188F65C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B69613B2A9;
	Mon, 24 Feb 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v8SRo/cL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6A71386B4
	for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406252; cv=none; b=osy30Ex/NUe5GwpJ+F0UFUml8mlxbUEqS8nZpNg4sC0HDXrd9EFBi3Av2JHpUliSKUp6fgE+YzGAMjcoYJ83ppen28GWiMGh+wnWO4efrIIwfnkNRgpfWo9jzs+BaG8aujc28CMHVbxAY7x7i4kGu8KLWokUgmNDwoalv5+Of0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406252; c=relaxed/simple;
	bh=np/7+Gia9o5hRCqEtnJukHY+JqLP+X1gw41ncD9ejcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Im+AEzUtUSGIgCfOhPDQZtTBsIWJ3mg/J/XrdC4ITTpdyYJRQ9hoHUa9fbfjNvSVydGF5jh0YF0XlQm9ZH5qFQLvn9WiBefC79XxLv7SWTMBAxHgNHjx+FUcFh23tfiDQYIKxpFAd9qJvxyGnkuW0C2pSDy+6CJWBLCGW/N0m84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v8SRo/cL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso649217666b.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 06:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740406248; x=1741011048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fn2Y9vpcQ3oAClJnMsZcxwhOJxacZwCbnE8JdwAGjM=;
        b=v8SRo/cLtEuRYaPQfWruy/f4SuW+MDtI6EvqBOiIiINW8kGMIbuf9OV7vEOuCA+/In
         gmoL3dx3G2mwfLnjlCQa9QHYDOfA7hjJCliVNF2gHEn3pbfzMBrNZ2MzXk+DQqK/TWgz
         PlrUwnbFwcTpFrydzUqJhbkTPTBYhCyQqSeAm9hR94Lw1MUvaM4tOv/rnnGLiCHPsG3f
         lhjsb1GCVjzHbSApxD3nmzuWpWNADrYUT5WAEVWS5ohqj5Y0yZm9DsnzgiGARKQ7vh1r
         G98Li5F1USJvUMrM/99BV3swsvkQn2Fox6t7zsudqlJ4LHlMjpop6N6byzKEEgeNMyQ3
         wt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740406248; x=1741011048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fn2Y9vpcQ3oAClJnMsZcxwhOJxacZwCbnE8JdwAGjM=;
        b=mWaYxNJGJdUel5W71sU2/9P03HiJlzAux7lViWqwQOht+eWIY5mRpZDuwfzaAXCb+P
         Sl/QKHJKTsrUSJJsdrSQKlr5pYD8M+KSsGuhv4RDep2qQLFzJ5D5jUWnldbxeG/yS9Zn
         EWUnCEKwogKeKb06AwBNO8TNNzulvdfh17HKWIF4GbFIS1INLYi6f3kBbQQX008wSQwr
         nfkljK/N9ro9R8h2ZxyTAUCK2EaZYn+mvaTvsBSPLR54btoa/vVL2o/3+wW9hrFHbG0B
         M6ThjzYz9j7oYA1+6lfjut7+TJPJx41xHppu4TcmatdF+rOFhUJt/M/x9a71I71fJMf1
         1fBg==
X-Gm-Message-State: AOJu0YxrjscRjTWMFK/SMi76E2ZOuAmTbSPUk7tUYEy8W2HxnuLmStzt
	jcJJW6kb9fOXKmyMatQa0QNxkKx1nkkPtJmuXcjRj9y9UBSmLiO2/SjivI6f3PQ=
X-Gm-Gg: ASbGncu66+mOqZTiMeX9V+igQiML0DBRwhPb5Ir75OD76Z55LjzrVKrOGTNmvjLBXd8
	4kDyBjLRcD69wR7g7JKcA4H4vJwPJpMwIP87Ic4SuiBlZGSyyEWpTYycEQN7xx6JKzwkgdswFQm
	3p/X4cuh2sAj1KbmzrI5xPIWjqX2UIOSRcBYnA1t9oRLmGKb67Pm18ag57wBsMTmvirWHRzYUHL
	3q0bRZkrILoyiz+5poz8/NJCoM6zlUv6jCc25D4uBVeW6GS9eYGk6jmB4KVid00Ury0jKKO1Qtt
	OXLL+4+ptB6ailMv62/Cd5ncw7XOBq0=
X-Google-Smtp-Source: AGHT+IEEev2Pq9yHEhPdQ12GlsX2heN1Yij49q/c4oHJQBN4HtkhF+59wxmGEm/9KMx9ijWpgcc3Mg==
X-Received: by 2002:a17:907:7851:b0:ab6:fee1:60e0 with SMTP id a640c23a62f3a-abc096c2593mr1226357666b.0.1740406248454;
        Mon, 24 Feb 2025 06:10:48 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece288e38sm18333841a12.79.2025.02.24.06.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:10:48 -0800 (PST)
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
Subject: [PATCH v3 3/7] iio: adc: ad7124: Fix comparison of channel configs
Date: Mon, 24 Feb 2025 15:10:14 +0100
Message-ID:  <0699628b9382229f908583ab752c3008d28cf7bc.1740405546.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3388; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=np/7+Gia9o5hRCqEtnJukHY+JqLP+X1gw41ncD9ejcs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnvH3Mw7zonUlErGkb1SgAsItbM0mEx5No/HRM4 s9MQbUVr4OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7x9zAAKCRCPgPtYfRL+ TlMZB/96zO6e+2+CJ1tjsppGwb1qsAgBY2h1F1IpmJhU9MbnO7yTaGmkTcTWTAAjfa4z4cJQgAM loszFc/Owe2wnmk285EeqM9DRZauNNK4Cp7J0kuYYqN3VN4OGP5lJ5Itw1NWDDL3kcKWzXqVWx5 yIxjUHoWQzO+6xieV6eft6ABDjiYSuuYZTQNTm0c9TVjUoKzcCwNKeQpTsjf1MgFO0f2UqXFUME UBWMmePXG7NeuCyOUlP+IDIWeC7A30U2E6KjwG5K0kxCWrYHxkQ0lraGgzehOsr8JaMJ2m1QGLP cwZwKCNoif5BSWzaupXm5EfJnoTfvaYlALR0FHngVpkqRnle
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
struct ad7124_channel_config::config_props is expanded, the comparison
is adapted, too.

This issue is somewhat theoretic, but using memcmp() on a struct is a
bad pattern that is worth fixing.

Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 6bc418d38820..de90ecb5f630 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -151,7 +151,11 @@ struct ad7124_chip_info {
 struct ad7124_channel_config {
 	bool live;
 	unsigned int cfg_slot;
-	/* Following fields are used to compare equality. */
+	/*
+	 * Following fields are used to compare for equality. If you
+	 * make adaptations in it, you most likely also have to adapt
+	 * ad7124_find_similar_live_cfg(), too.
+	 */
 	struct_group(config_props,
 		enum ad7124_ref_sel refsel;
 		bool bipolar;
@@ -338,15 +342,38 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
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
+	static_assert(sizeof_field(struct ad7124_channel_config, config_props) ==
+		      sizeof(struct {
+				     enum ad7124_ref_sel refsel;
+				     bool bipolar;
+				     bool buf_positive;
+				     bool buf_negative;
+				     unsigned int vref_mv;
+				     unsigned int pga_bits;
+				     unsigned int odr;
+				     unsigned int odr_sel_bits;
+				     unsigned int filter_type;
+			     }));
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
 
-- 
2.47.1



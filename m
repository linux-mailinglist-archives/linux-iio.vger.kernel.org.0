Return-Path: <linux-iio+bounces-16273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0952AA4BF3B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF50188C3D0
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E02D20D4E2;
	Mon,  3 Mar 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ukkS3HEI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE220C48B
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002468; cv=none; b=hfVWgFn4iIYlf9JS9qaUCjpomi39BqQ5gmJgM4C+rBcqrrHL92gxycYhfjiaRZ2CU3fX6BRJM9BNKByUBrDJ5JCiuQBZPRLn3/BOhDR2nFlsnfbiKIiLHOvRiHcROVgntgS6s8eLkEY/3nm64HgTTn9DsVcveCLbqZK161FmBsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002468; c=relaxed/simple;
	bh=np/7+Gia9o5hRCqEtnJukHY+JqLP+X1gw41ncD9ejcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tH3SQ3Y4T1+jqAwxL06nLiPNMYwSMEz05gzU7ph2JoQd/k6lY7qn/QyYxvyV1rawQJWdSU05oer9yLL+9YvFw9DC1RiOjw6+x19HkJ4+xEW5YodlTF6dubOF/3zLRZLiYYp1m3NGuQwuFndLCidhVeFsUnuOW0vU8XSqV4CH7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ukkS3HEI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390dd35c78dso2824019f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 03:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741002465; x=1741607265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fn2Y9vpcQ3oAClJnMsZcxwhOJxacZwCbnE8JdwAGjM=;
        b=ukkS3HEIbCvK98xCilOhLg9mqdr7sIRcZzVGckXNduV7O/rUMrXgA2eAEucoL5alEc
         j5ICxKMEz6njdZvAd7UjyhcVXbYLb9BtqNSwF/lCIdNDD+u/h224BSGEJpSRMCXbrGVv
         b/b7w9YDxyHfLhfGIlu2dgYINd7liT8TRf5eR8NuaOjZZGC1XQvEje3HWTKRrSEIu+4B
         0CFqoA9naFE6NHZWSTDC24ZvnqUSWjNMyb9B1dNZ6Qf4kVizH0UyE9WRrybVmdhG4pQA
         ZFUCDKszk5Ub+HSm2XMEIcvz0KVNBssOkxmGagQ1HGZSBUX6Fgyuz7pHAXaUzvNQlQ/v
         ouag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002465; x=1741607265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fn2Y9vpcQ3oAClJnMsZcxwhOJxacZwCbnE8JdwAGjM=;
        b=s3r4Jl+2LewugIaMzFkoF/45RTR+FssU6nnUu88nWYYMU0BckGl04+NBYhCSY/0fZ/
         EeUfjV4994BkhxXSsa/bpzU4Rv7jgYEgiEZz2oEtSMwq/JZgsWr3tzJ5qHYytji9OGeI
         ANikbyQoaTE4xhsERVDoLsamxpOIVOuWN+SwEF5NovZn9ZtguucEHk4P5h4GdsjHC1VY
         CeEiajIi8qfVXaM5eSCM+6sH/3y3NX8X+SZQEgnMTQcOE+BVJGDsa2/x3kAN0L7BSSsh
         Zhd71diYrdCE3rJo8uzWFrC09uvwm1D+0EIne4azxib+22wXKgf/xtMLcsurzi/B3WX/
         O3Yg==
X-Forwarded-Encrypted: i=1; AJvYcCX8jiCfJMSjyFLp6oL7Et8xK32QDC+ANedUiwCamS5rZIPNUALlok7C4NcX0xFCEMQt4oty160u1pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx191eHzpoU5kGP7Sw5jj3iZyx0EIop/ROs4NxMHWGw+rBgD/IP
	RbMCLtHOV5gtUTi0vLUoKLWq27mbCKX3bQmmn/LPlhu9N1krC29M77947mNBNZE=
X-Gm-Gg: ASbGncuWZ1d6ghHg8J6kKrA1wrKBZQ//f03BaHWhBmr2xHDqPSGIjRRh+tq7gmEGsdN
	HCiSUbqNGJTLxT66RpMK2vP8dHGf18QvIYkSRy/RmQ39jItQl4NsOyFVKnqtTcDgXXd5l2SL1dq
	08BgZejfXeUyFMqYzA7aTnxEWRsZQ4QXOaPOmq3XI2ROssi1Ip/WAjCiZvKHmOltXXbMsBW966F
	26nK5eE4ZNqgBjXkHzoIXqnW50l5D2Jyf8i89LociY2Hfkj2m5wnbm+oW8chilnSpnOG0bwEZLt
	d7Gq5K+nHeUpcrZGfiTDy6VZ4fstrIaSu1AzqX2T2mywGbjqgTuxsjvTZuZ7X4ZLngeVu07BGMU
	zF9fRLtNek6EjX7cxiKkiVdazCw==
X-Google-Smtp-Source: AGHT+IHGuolsvcew0aNtGB2on+v463R3QZeJSIqaolbyjPawP/M5ygIMB2T2uNeJ8FlmUsy4njoNGA==
X-Received: by 2002:a05:6000:4591:b0:390:f025:9e85 with SMTP id ffacd0b85a97d-390f0259ebfmr7497566f8f.21.1741002465316;
        Mon, 03 Mar 2025 03:47:45 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485df22sm14465256f8f.97.2025.03.03.03.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:47:44 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Michael Walle <michael@walle.cc>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] iio: adc: ad7124: Fix comparison of channel configs
Date: Mon,  3 Mar 2025 12:47:01 +0100
Message-ID: <20250303114659.1672695-13-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
References: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3388; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=np/7+Gia9o5hRCqEtnJukHY+JqLP+X1gw41ncD9ejcs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnxZbAJOt5fORmw5hG2SGvZ4uf/Inm2XPAMzWvj nzD3Jjk6W2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8WWwAAKCRCPgPtYfRL+ TtAuB/9O9MJyCKychQJPr1/HtaYd7pkBazF4KnKZYm6z81dPMHWwxpxURZkhm960VrHf97ZygAb DP7NBlMXeylVlbicg4wuGR1lktiu0ftQULqr/4qVsIDveEDAZl3o8vtl+8jdv3xUa6vuQzyivUZ FtPWVFOzUePAD1XX66kiFd0qdwWSuiRLyQyTwyGtKneQG5AvykSpuF7RZkT2qk9+ykmSFTAu4SP B1Bw2+ME4rGSNMDmqgs41fUuIUncDvnHSlhWM2yiz4ZeJGSkQmI77+z2EWnWfGvsEE2pujOBrbg YS82JlzmwWJyrFLyLn/MNNM/t6zk/qxPaB/H/pxNZfXuS95M
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



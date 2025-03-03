Return-Path: <linux-iio+bounces-16274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE95A4BF50
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C2F3AE42C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3B020B80A;
	Mon,  3 Mar 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TgmgKYi9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E606F20CCF0
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002470; cv=none; b=RwrTcEUKw+FTZVe6XRI8qtOW3ZWSpKp066lsIOiDH3IJemWVw3s9Gg1Uhjg2EVeSMiet2lx51uK0KAGKmT7ffFg+z08Tl7xnbtwnoyIojIVql36R4EKPie0kUB4ja0c+lqzPBUeDXfeX5JBWbEaTPt1um8rJCYsjeev0e31viJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002470; c=relaxed/simple;
	bh=y10CLHrz5q1cvvW/6hCv3R5E5E/v+RGlhugIUuM3XuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s51nrubovEnEUM3lowFqvXdv2ieT/txP7dBJNh6BubBbWgroXg0XfUrTsUnnBziInXCjzpQV4OHZT0raidrLQNUbZuUW3MXZ8Ta6xc+R0jgA5caTaSeuDfJ6lus4/WFuFhiODXgy6pgrazjij4YyBaYlr6IO+ubfV+J4xsdpm0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TgmgKYi9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390df0138beso2289994f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 03:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741002467; x=1741607267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZWcsKY7qzjNS1Wm2Xh8944/cSh1cBOdNgKC7R7IPMQ=;
        b=TgmgKYi9Ci33UhWc8RR0ukMzU9CMr39R1kvq85RsZ2GpPJaz0eTVezEj4bh7ys5MPR
         pbW0NwwzlrsisGI6mqExgyFaDV2xcgG5FmYUxFSW2wVcVL+fTSBPT5P40Ph/ViQ2Yee2
         8IJzIdgCsC4ndouDLDGkZoscs2SJD0W9VV80SHrH9UXnwCpMVaTfHkpc8HuSgi97NVuz
         enkG3a53FFPOVTkhttbBvE7PZf6+jpvQGcLTUI2quanOm2wjAAI1dy0R5iUvHm/A+Cg7
         kXFP6VMo6iT2EvCiGgQreVFBG9T4RpOPh2DzXnuO3HUne7zyi0kJm7b5hM6XlH8UTDIS
         79CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002467; x=1741607267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZWcsKY7qzjNS1Wm2Xh8944/cSh1cBOdNgKC7R7IPMQ=;
        b=DJgNLgJtkkEO5BPysntilf/Ren7Nhm4cWhjDKKEQu7Lxx7h9RUhR5/R/2tJaPXQoVx
         rsnIpgfMHbArZNrO1C73YkVc66Ja/UKrXrLLFcCyoUYAd2VZO1TFV296aI0pJai/J5kK
         BmtSh2hvgZofKtOXQb9YoywIqC+r76VwEVmmQZUVZgXOoZbS1oFR4Y5Zxv30U+GvUcNd
         JkxUUylgMdm/1arzlrn6OVQjFfMpobyMY48/tntNrBCUMAXpkbSP9KDUh89TPpsjU322
         DpTNrqiftBofHgt2GyKdOkcfG8/0hJ1//5Rr9GgA2IVSv0cjbDp+aXseqqe2E8cKCTSH
         zYlA==
X-Forwarded-Encrypted: i=1; AJvYcCWcGrNjrm3Ut25pMIuDOPyV1GmMXhxk7Xw3uEluUPjkFTT+TjHdDqwv8X+Fqv+jAWNcVQPmZ9bp4Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNO2AuQ4Q9ciKVpGZsgVUOkXuABY8lklFmkgKs/umudDG0yqW9
	NhsB/K+xLh7M9f79OoWz/ANo+FYefgEARcL3+OLtpJ+Q34Anh1rnnHu9GHbQWEG/ogWl1dstThZ
	4pcE=
X-Gm-Gg: ASbGncvpnR7Aosr8cFs9PziDXk48PrNrWkqG1WrsyTZyGYFUXpp2DxbJSnkXipRW7GM
	mKymttEBH3huo3TRPJswTW7giHHS9nQjievPrp8/NC8lHuVRYAYiWJ79cmjvQwk3H7zuXd9AXgH
	TWny4MserbuJbbnEdsX8NMx9qFHI/d8175NuHpyArAEN1xUhNJs8Ip9Vd4Ywla8p5JfV6hSq/wj
	rYobhXYlnS/5bJSVan0rii1bDOZrT4rPN8CHXmtw1JiWW+7WYIG3qTQqNibIF/TzCY3C6SoeOkE
	6vW5lEPyp2kLkPl3Y25C07VJgL5qPeTPk/ZOMTUcQnJJDKCQ5ZOx8a03As2DgBdsLzOy3oJNTXJ
	zRwL8/VEM6OVnYmbcCcFadrEnCQ==
X-Google-Smtp-Source: AGHT+IGcoDodgmWp5+Ijtads7PMkR9LPBMeEvPtHwX7hSfwU3B7pWXGiyRfLkGUcWCvwHE+j4WYS+w==
X-Received: by 2002:a05:6000:2b04:b0:390:df7f:c20a with SMTP id ffacd0b85a97d-390ec9c19a2mr8181322f8f.33.1741002467084;
        Mon, 03 Mar 2025 03:47:47 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5870e7sm191186775e9.35.2025.03.03.03.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:47:46 -0800 (PST)
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
Subject: [PATCH v4 4/8] iio: adc: ad7173: Fix comparison of channel configs
Date: Mon,  3 Mar 2025 12:47:02 +0100
Message-ID: <20250303114659.1672695-14-u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2867; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=y10CLHrz5q1cvvW/6hCv3R5E5E/v+RGlhugIUuM3XuU=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGfFlsKjoB/9Enx0XBp7O5uj/4SpG8Eo5mO3qMUnhEvhZcpxs IkBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJnxZbCAAoJEI+A+1h9Ev5OeFoIAKNt I0HVB0FGhl6WXRj+K+a+jWQubV3oqNtlhol6jL3swaA1Yb+W8f1OsxHLqw3xmL3qnu3F7Zmnuvu 9cWdxMCHqU4cqoUdfzPw2Jg0MvJBSZ4QDLhWtkvrt0KGO2t4TcxrSmZ7XngGVFoh33KNhHo2alF gfRSoPv9iC/zgLS+JPalhzfB0VODl9U2UvcOqwUtRLW4eVeBynbngZXUAsQi87AO7qxJMOpVf77 U5fArLQ0XafUWhNs4Y3EugyOOrNqUrGHABVm0jvyPqvc0+CvQOjpP6HYL+3rLnmOvCXDE5EXxSK r5vjeptYied6fbL17oTgb2Hrx+F+f7tAcyGxGs8=
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
index ca2b41b16cc9..2d90487c7f31 100644
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



Return-Path: <linux-iio+bounces-15745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B081A3A5A4
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 19:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639B4188D281
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E752356CA;
	Tue, 18 Feb 2025 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FrdLThK1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E52356CE
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903499; cv=none; b=SxdO/U2hCPtZJegnpG06uLtqZ51AK8oZqwdhLLVP0yQ0mqksVcnovLu6OwypelFkqzHdpWvpfaJpMZ4tFPdgRitVGlwcVVNx79BqgjzrUQYKikYAavoJc8HGpYPeNTK6B99ih9oFCwcxoFQnYxmpXzz3ASeHJgLrqmRrOxJmQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903499; c=relaxed/simple;
	bh=lnzdjGNHBtKUFzUiqrLEQqzHtRGnNJWcjdjo3ejD0ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ooqf8xZVGEOPiixWl91CQo6gb/YBOm/QPx/ZEC0SDhfnNVv0lEEv9zj3xtOXmrpDpwDqZY1ybpc3Z9fZsh6Peh3wOf/KD8gk7gDjG6tAa7sJakUi1Wg7CLFktvazKuAcZ8wtn4PRnL/Cl1xzQPvdmeGkGoS8avJnwBsT1Ds3s9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FrdLThK1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso16296495e9.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 10:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739903496; x=1740508296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=To6868pYlYT1wEDl3Zkm01Z81bAlVtBC9gPOfWm3OZw=;
        b=FrdLThK1fjQ8dJzITA87osgUGpd/pqA3luBLX1gPN0hb2ZBAJGHp72cbHkm4YYnz8w
         O7Zv3UP5tXm/GX8uCClkrRl7cdpnV9NRG+f8P52FVYTFDDcYKbYk8ZAmQHtqvMKax+/1
         9g8/7MRXsC03u2rZBiAQvufht0fImYvzoKgRXxXBz18B2eMZL5Zk5GOF4yLjixf1PbPn
         GH+59csmWXwVSlGfnDGGZzOIAV3QqV0BpXk70BYGPNrM0qOsLBeZCPtUP1llPLdwd0S0
         fx4vz3OgiFcNh4vqkb7wKUxMZAWdhaSqvnUqFIFof2+u6E+mH+RzWe1W4MYbg1NLAGUF
         7vBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739903496; x=1740508296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To6868pYlYT1wEDl3Zkm01Z81bAlVtBC9gPOfWm3OZw=;
        b=B7uHs4ed7/U0xt5i9awZcpOAekVA2IV//kY/JPEnM2bm7FLMNxtIVSq1OCst/6/N1k
         p8TuQQgV+scIOHSK+PEUhd7HEq5nA0lWsu3Sdzp1kzSWU5nWnFxTN051e86JzDff4RV4
         8ht8W6+TLO9fYGQeSL7QtysoVa/c52r1H1EGbjlBAwjHBeRlXC2zbaWHn8ThTiPkO9pC
         TGRDoWMYfXk5ikbZSdhZSW/GX3IsoSlcyiuGxWvext1aEzGGsjlWq1QwTpbUwZuOEm+J
         YFILJhcIehjPFMJC5VcvBgCEfkokcVL84pgzKaa+VUAsFSdUkSHgMRHKyLakUd343etq
         R50w==
X-Gm-Message-State: AOJu0YzFjKgPSGNXEKJxOhXnTqpiNDJs67a2YLLqJhyFwKR21C/rd/sU
	5RduUXV7sAf/uyrd7GUS2mEEjt3wr5ovv5McJzRs4nbOkD8LTU1AZLNZhqRH3aQ=
X-Gm-Gg: ASbGncvt2/+87BXcVZ651XGAZXiUpaZRtkOCKicYPeJf5oUWVK1XdSFsokgvxqxbfU+
	Bs/rI7dv8KsSr3xUuHbBMYQDDG1QuIpi9HknEpR0u2iREiGuivUIbtMdwpcVxvda7St8DcPLUdT
	TEQuLW5QNX7nJxKKMNGHDZI3g3MCnKEFitLs3S442XYS/rAdoyq0LvCgGA6stFc6ku6finM9wNc
	AvuElznnRw34GCyLUXYRG0XgrvlB3pc8q4LedRWn+kfivHJuF4QxcadNimWsD1Jq9FExies1afE
	p6UbtkfnP3g76KAzytQlFTXM70WfukaKWEx/Mhtd2RAhVjkIh0BRdAsPNA==
X-Google-Smtp-Source: AGHT+IFLW4E0Yuv60khlPum4m7QRLBSuMo5KJZgK9dltZ+nvUWho88JhGxznZLHYmg4Hs49XwG3KEw==
X-Received: by 2002:a05:6000:1446:b0:388:da10:ff13 with SMTP id ffacd0b85a97d-38f587955camr741924f8f.21.1739903495964;
        Tue, 18 Feb 2025 10:31:35 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7987sm15411994f8f.87.2025.02.18.10.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:31:35 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2 4/6] iio: adc: ad7173: Fix comparison of channel configs
Date: Tue, 18 Feb 2025 19:31:11 +0100
Message-ID:  <d64d8f211ab70be720908c88cc35951db3649228.1739902968.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
References: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2865; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=lnzdjGNHBtKUFzUiqrLEQqzHtRGnNJWcjdjo3ejD0ng=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBntNH2RaqEfUbqYNkBw5Z+uLU1qCW/TIl5jIAU3 a0AL5AYRmyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7TR9gAKCRCPgPtYfRL+ Ts1OCACcCkChlEA3si6sfiPwvos5si6xlT7zMU2nECJr9vUTC7Oamx4ZePFZABsOryp/vklolI+ GheBuviSkmJ4AIYdYd3vURFYj7HL9spMM4wBso1aAsLCmwElmBl+HeJi8rd6YNPyglp0DNo2aGY 66fzeHdx5rVRkjU8NPb0JDCsazmdWMtr+G61nCBhfl8Os8jTdGpArFwi1/AMnmYPXM9adAj16c7 D/0JmIjdFu9S5uPCVK70ccQIpfm+KRI9IAuu56Lg3A8PUviIbs3aXsn+OImkrW3Yv1YY/L6M8e3 0MKMfpxg5PFGpdwIoV6korJrl5cxueZhAWbJq2PNpvs/5dRp
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
index 54f9cc5a89f5..59cbb52f6f38 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -197,7 +197,11 @@ struct ad7173_channel_config {
 	u8 cfg_slot;
 	bool live;
 
-	/* Following fields are used to compare equality. */
+	/*
+	 * Following fields are used to compare equality. If you
+	 * make adaptions in it, you most likely also have to adapt
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



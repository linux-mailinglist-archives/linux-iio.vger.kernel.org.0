Return-Path: <linux-iio+bounces-15744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44626A3A5A3
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 19:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3959F3A3909
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 18:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B062356DA;
	Tue, 18 Feb 2025 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O5N+dr9J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A917A2F0
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903498; cv=none; b=J8fcLyhwa6W9p4wn0iuYLOz7s23A0vpV316whp1cnm4Sz/DNxbF4gbN/xsR/gPdIvvhVCfJT2dKE7vKfDngFGhOQx/nYMPrAcpm8Ab50IMMAC4cq5qUISy5rRRiqLlNIjUBp1TGRQqC8hLnmZP2PUzpKt09Sim/Swk7m9HRawBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903498; c=relaxed/simple;
	bh=squXskvofonKmPMfrNJ4SfqvRJ3I3P/i4UuP40csLdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsRZ+tKsIrcu6CNOYQyoTnZidMp8sthCTxTX5plG8BC3d18SQrgfa7IwZ2MdBAC7egqqDlmiq7Bd+rzVew2n7UYF2Zw88l5mIgEVAuGFWjlu4UkjpEKbVjgob+4cO4Z0bJKp3tziYP15zkU2T7ISLdGpTKkREKB8XnWGbTMX6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O5N+dr9J; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f2b7ce319so3581153f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 10:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739903494; x=1740508294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lm+0g22nuZB/LqbGAHJzAZiVTVybRn+Vxw5ANXMgmFo=;
        b=O5N+dr9JVI84pFHDmTq9Ya+rQwvSPjTI4wlcpfY8GaUkyideeOzLs1rGPPQ9szS0wT
         ISCaGahpOblX7XpYYmDKkbZJhcrZUwxgSQhS9dyad+rp/qT3u18qMfXIY7uEn9leRsIs
         YGDAB/LqXSxH7EH13kuqJmsR4TrFBRfgh7e+MboyUB8+oZRmNjkZSnYkinhkdTKhEgHR
         lv/VsSuu1AvxqCSwwYTQEnaSZFTvfU+v8QH6zj0iACTUniv+P414uAH6bafR3e3B3KQn
         8R9x5w89Y2szg8OHoPzVfpgpm25FYLkXNn557xFwgtok8rdC60WJkZho/E2MmgYDPON/
         NIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739903494; x=1740508294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lm+0g22nuZB/LqbGAHJzAZiVTVybRn+Vxw5ANXMgmFo=;
        b=l6/90YacNJkGlkn+lE81Mz6KqNkUU3WhD1w14RL010OFZinduMOEeGLCQ/jtht4A/p
         O6K4tFNnCy5lOaCLgOWhX57J/xYX0cZfc1JzEC4LeG80JD3qZe8yqMGwH4IW4tF25kA9
         caUkCi1ofpHO9q4jQ7QR99pqonc2jWunyNf27qK62kRY7FYpHZlKPxiA8v0c8GAJbQiK
         hqCVR9/JqxIShCVIflQoduoiLo2Y45kEony601bZm3DDx2ZNQPJ6JRmMk8CAPfKsX5cG
         bjj6b7GuvnXbNbI1smE3beN+N6y3M3AsQp4cswFiRtR3HeVxa0ed+tow0M8VZ2RIB/GN
         v+ZQ==
X-Gm-Message-State: AOJu0Yx5MZC2mAKD8RuNZIUiOSP9uj0lxk3vBtfiisY4IvWycUK6kZtf
	oZsFpmw4ORexgT7dvzQUNvSSsWBAiuL+2zlDTRb2G8hSzr9bxoy2OYl6wOvcnI8=
X-Gm-Gg: ASbGncs6O9ot9DwAGfrbzjm1GvHFtcK5VuqGSh5+kHM+eTmJ4Qzl/aKvo3dOSTtOolw
	quHXvx7yrr2QX6L0Xm/yTe65Nwo6A9mV6uZZ4D9bIccIHCFXOkviC7QKXWZx/T3QsloJtWTq6jP
	klf7VBg/t9iukyQ5a5W5ckjbh9JMDml6MdghfmH2Ls9Pz3mxLcwH7kiGqsNvsEwWxZmlTj9Xjjn
	SEhrXCuzkXQknjsSXC0UpUa1vvqmqkf8e//kgTB81nFDdAFIidctikp+JpGgW+irAk11Pxe4Lfu
	Qe09yXgvRt4MvOnAX7J9bAXUkkS6lzXxOe8WJRP5aPMbXOWnAdckhURO5g==
X-Google-Smtp-Source: AGHT+IH4gyYToxOhtqA4tputNocYk97vqlhxdJ1VVjfns8GqB6M30sFRgbUSZWZxufkQlMvVaIm2GQ==
X-Received: by 2002:a5d:588d:0:b0:38f:3141:8912 with SMTP id ffacd0b85a97d-38f5879454fmr597399f8f.24.1739903494264;
        Tue, 18 Feb 2025 10:31:34 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258fc8b4sm15884444f8f.50.2025.02.18.10.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:31:33 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2 3/6] iio: adc: ad7124: Fix comparison of channel configs
Date: Tue, 18 Feb 2025 19:31:10 +0100
Message-ID:  <97c14db44031da3b5dc85c22805ab694cf327b23.1739902968.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3386; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=squXskvofonKmPMfrNJ4SfqvRJ3I3P/i4UuP40csLdM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBntNHz3hpbpW/II13M6OLYkyFyCNFUvmIOUGSl2 o0kYp9o5EuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7TR8wAKCRCPgPtYfRL+ TjBRB/4xxI4au1J/+GmLSvy9McKgAWagCcx6aWpaJj/iF+cSCUrIpbM5n9/ntCY71SyyAG+Geuh yqBOCR2fa0emAv9aD5O4Zhk9qr+15+d2C9sKPq6FuGojK4n2t06xCc7fGTl9RJ3sHPrmCfJ9D80 T4VwL3QL0OOnOX602trw4HAOhKaAv8awr5Gh3w3QSDIfB0UNmqZHYvXCSJT67I4G7bW33YmhKyD xirb4P6iTNyYlpwq8JSGjBcE0A6Itoy1kG5snrzEnYJSh57QH9cjYwHzo5C7VkvT7MHttTxXHfq 93LbSnGLvQn28cy1iYDi0+HU2lI3U+ETu73SKnTGF8aqHpsY
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
index 6bc418d38820..4f253c4831fa 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -151,7 +151,11 @@ struct ad7124_chip_info {
 struct ad7124_channel_config {
 	bool live;
 	unsigned int cfg_slot;
-	/* Following fields are used to compare equality. */
+	/*
+	 * Following fields are used to compare for equality. If you
+	 * make adaptions in it, you most likely also have to adapt
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



Return-Path: <linux-iio+bounces-15743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29231A3A5A2
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 19:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3833A396E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16AB17A30E;
	Tue, 18 Feb 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FaHu3BMK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9748A2356AF
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903496; cv=none; b=eIqEsN26QT/7f7/jvcGK8VmVhNjgiAeMnWrFk/ZNufrN/Aqd3UehLikjG58qqGbBUwAK4cELAQr8NtA3q5B3TfVnux+RHj3jzo5J6Iq58SB/ZfGT19AdFLvWxnBpvD7bhBSgWNSzM6kQsgLHnd8mPsceUW+8czDRAn/8Om5PehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903496; c=relaxed/simple;
	bh=rrJnQI9ZZqc/9wokychG3cC7a51I+7S5RpAh7p1/Oco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crdvYzGXq9gFJ5y31fOgdCnx+Zc3IsFcw3LoKINbB6LFbEMKHzTgNQSYkeq1JBJjjFu3SvAIJV8/MHpyhCecOZNANFQUxm2qPJInb50iCFVSc+PFJmpymx5J5zBATKsSpNLIw92avM8lclzExMQz4jedTtwZNAGLAKGtwiATyYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FaHu3BMK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso51184f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 10:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739903493; x=1740508293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QERqwxD8DlpHnhSjP1pKek0Ii/EPQAdK5zktVJtcm0=;
        b=FaHu3BMKUoKoCoQhDxrbXmCoNldNmDz0UQYsupdOVJ08wbAq//lt7mcXpljnksWD/o
         ojccbaHaD29Q00FX1FgnDmn8dtBZCn60j+8zAnu616/qkYGesG87J6xrzHsMdiXd2jaE
         WZOmasZrNcvSaDUpv2MuLS95qkWq2AR5wcVOv/zfe4fuTVF6IlpqqV22TMp7HRCUGYxp
         URAp+nHuYDYLV8tKV4wEUEzqrh9IZUOR9yTluB92DEGcWwnEy8DlamjkTP6sB/SLRPX4
         8+7ruQoXOK2ByGvK4GbpVu+/I92oAXE3j/rnF7j4qB6MeM7hHHhe4olYdiWaLZbIxPSQ
         3WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739903493; x=1740508293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QERqwxD8DlpHnhSjP1pKek0Ii/EPQAdK5zktVJtcm0=;
        b=nvxYQN9ipmadEQzznkpYWc2vA75vbmwIufSgSLtU5vO107Zo7sDaOWnTdZwzkYVH3k
         uToTscxBQe6R4lmzYtOy3Cmk9vHNC/s+iejvbA1KDDlB+0Eu2ioiRw+bL8NLN7KSiC2I
         1Dt3ElAZKlqpknRHTK1X0rie03CPx6QmpQPXue1QPenDyDApbFHOt4CVygpjOBdkLPqz
         Hb9RgcHU/EX34wCrRwqjm4FPVKZ3wN7YtB6CGxM6rH0wEBD/7eBBCNnqYEjCoPPG5x/9
         5xUjZjxQK/fmxVSUSJITehf0cz9pU61kUJfDHyUFu/bbcAmfTSsViLPTh8Vc8xXM7dJZ
         eh3w==
X-Gm-Message-State: AOJu0YwOaODsxydo9tVNxsp59Usxh8hbkOes58Gf2ISKAM+cD2myPVg/
	nbbc1WGTgWJC+iiW8+0WMT+ulMPCF+tLQD0DldRSPy5JWOl2XoiOk7bPpgik1Pw=
X-Gm-Gg: ASbGncsKFX5gneHaYXr91AMR9Rall9Dv10jwtYUUre9dXnfQHeMOLN02KSJ8Fgb/95L
	+cOQGrdRdIKO20pq4cSyj0SDeziSYmupaElOJVsuXG9zTsA8m9xboHvAage81AKNSWHFEeeSDdZ
	Q5ucbuK26X3aZEoNAjeb7y6HPsnjt63VMjjAp1xhvxH5zKN5RA0CH9hLEeb27Qs8H0yI+5eYKoY
	dtpqUK3Lbp1qfSTvC1ci02R00Xbz/A80RLUnIQijJVdF21R7L5FF8PGq/oKszKOMcQ6IpZYeKZL
	f1KzDfVB/p41ZERmod1/7/19TqzcoFnPmm4ATOMpnBa0Xzj1WANWSXWHKg==
X-Google-Smtp-Source: AGHT+IGbCH6x7NNAwitdYpo1+/xlSJgoqJIBXBHM6gGKlsI1uMtXX3d2K3xVlUQwZlPBCFk2D6omkw==
X-Received: by 2002:a05:6000:1a86:b0:38f:221c:2c8e with SMTP id ffacd0b85a97d-38f57bda89emr833348f8f.6.1739903492816;
        Tue, 18 Feb 2025 10:31:32 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5c36sm15875572f8f.67.2025.02.18.10.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:31:32 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2 2/6] iio: adc: ad4130: Fix comparison of channel setups
Date: Tue, 18 Feb 2025 19:31:09 +0100
Message-ID:  <4d1ba8c9a890393fce38083b01db6ce03df8ac5b.1739902968.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3236; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=rrJnQI9ZZqc/9wokychG3cC7a51I+7S5RpAh7p1/Oco=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBntNHx8inZDN/pL/pdw/tvw9NBua9mNuEGwKwrt yQpJK6NJCiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7TR8QAKCRCPgPtYfRL+ TnAbB/9/Ew9ZxRa7kIwf4F/eKaM9Jy0kNGlSAoN1pdi+piMLQGUg+EcippU+ZXE3HWiW/4+2GS5 Bo9wqKOSJDg+e0S3hhTD175VbwEoIq1qxKKvpiJFvd9LkiOZB3mGYfCAkXTc1ECfObGbi9NRFOw bByDbpYg/JqvqP77qoKOgCNgE4tZi8UEeHUexUIgQE0c1wh5Et8nlAnJJPVTsQEOTeLJVG88lCW G8tb8T+irdDyzIzPD7QYLcdi7Ai5aYQhF3tuEbjX24VU8/FU1NwfQAfPUXBtCgtL2/RqgFkK17U o6OIOnOVnBWLVGB60OQAczghJMM9NZFGMvB3XhY3lM0T5ZrF
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
struct ad4130_setup_info is expanded, the comparison is adapted, too.

Fixes: 62094060cf3a ("iio: adc: ad4130: add AD4130 driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad4130.c | 41 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index acc241cc0a7a..b4eb3065ae34 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -223,6 +223,10 @@ enum ad4130_pin_function {
 	AD4130_PIN_FN_VBIAS = BIT(3),
 };
 
+/*
+ * If you make adaptions in this struct, you most likely also have to adapt
+ * ad4130_setup_info_eq(), too.
+ */
 struct ad4130_setup_info {
 	unsigned int			iout0_val;
 	unsigned int			iout1_val;
@@ -591,6 +595,40 @@ static irqreturn_t ad4130_irq_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static bool ad4130_setup_info_eq(struct ad4130_setup_info *a,
+				 struct ad4130_setup_info *b)
+{
+	/*
+	 * This is just to make sure that the comparison is adapted after
+	 * struct ad4130_setup_info was changed.
+	 */
+	static_assert(sizeof(*a) ==
+		      sizeof(struct {
+				     unsigned int iout0_val;
+				     unsigned int iout1_val;
+				     unsigned int burnout;
+				     unsigned int pga;
+				     unsigned int fs;
+				     u32 ref_sel;
+				     enum ad4130_filter_mode filter_mode;
+				     bool ref_bufp;
+				     bool ref_bufm;
+			     }));
+
+	if (a->iout0_val != b->iout0_val ||
+	    a->iout1_val != b->iout1_val ||
+	    a->burnout != b->burnout ||
+	    a->pga != b->pga ||
+	    a->fs != b->fs ||
+	    a->ref_sel != b->ref_sel ||
+	    a->filter_mode != b->filter_mode ||
+	    a->ref_bufp != b->ref_bufp ||
+	    a->ref_bufm != b->ref_bufm)
+		return false;
+
+	return true;
+}
+
 static int ad4130_find_slot(struct ad4130_state *st,
 			    struct ad4130_setup_info *target_setup_info,
 			    unsigned int *slot, bool *overwrite)
@@ -604,8 +642,7 @@ static int ad4130_find_slot(struct ad4130_state *st,
 		struct ad4130_slot_info *slot_info = &st->slots_info[i];
 
 		/* Immediately accept a matching setup info. */
-		if (!memcmp(target_setup_info, &slot_info->setup,
-			    sizeof(*target_setup_info))) {
+		if (ad4130_setup_info_eq(target_setup_info, &slot_info->setup)) {
 			*slot = i;
 			return 0;
 		}
-- 
2.47.1



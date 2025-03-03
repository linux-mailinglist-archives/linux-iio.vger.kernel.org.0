Return-Path: <linux-iio+bounces-16272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 984BBA4BF38
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FCA165442
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2437520CCC2;
	Mon,  3 Mar 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GiTislL2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142FB20C00C
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002466; cv=none; b=ko5hJpU2Qn0muioZitKleJ1RefjJldr35ZQxZ6qpT938bz0y9VF/Ol3TQoQvZhyFI924Muj9xaWE0p+RpHBjI6tBqVHlmNmTVs+fbufOjRwHiRyYLdLhpfT2cRehJ6qErRVIq9XR+lHqm0ltzlq+FYklEBzYN64AEGhw06hrI78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002466; c=relaxed/simple;
	bh=ec14xnJrpwkJrC/ethpz0fLxzagiTiLZ9fwLcAvPKo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSPEBRubsHUenzXQC0TARTgWi7W/xuJ7ig0gdYV3LuN8utKCRCZ8ImU/hNYZPxmDhlDIeoYOA4RUc2i/qazESOJhVkG8DdsXfetNCDRNB76h2s+Zv1f7hL2ef4btnpeFExme8xyYS+Uz02RM6inOPV5Y1ug3EMGCGo646QclfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GiTislL2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439946a49e1so27335775e9.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 03:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741002463; x=1741607263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3z/kCXdK0L4ldNMK0CvF1cmi0sAxHIrcS5GyQP4Qyg=;
        b=GiTislL2oGDcR3O/UPEyyV9DuHlFpA/s79L/3KSLzLUIQBsR3IYe5LdlLYaLmwGeA5
         BsSbNd8Z9RTdiwTSpreY7kQEQq66tglj7pW29z/yHJfqTu7esegTVwmWRzcU8dkeMxEG
         T51S4LOIe/5fXMWGrjRK+xEA4deNiNq5tC/p2I2+xIS8ZYfssX/5yMwa0pLv8SqQBBRr
         GoBRJQ5qoiikGwjqfvOl6q0x36D01GH6CqGshAZi8y49Kam21t5SrrP8bO3F9SIfesf6
         CgvlXnwJ0+IVvdz5WV9JPxSWsNPOUP1lESaDpLiEDGgK+ATO4Uxxt+tMzu3Whx23ljCW
         PF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002463; x=1741607263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3z/kCXdK0L4ldNMK0CvF1cmi0sAxHIrcS5GyQP4Qyg=;
        b=rzbeB5WaK31iccEhaJwgG8yMoU37Gs19qXF2Q2dEr99bjDetNP+ilqxefD4AyDRgUh
         brDipFCElorj2P1WPbydn3uKvgK36U22ARNVg2vrqK7KfOr38nsNp2OW4rNg698BaQco
         U3bpC8M+11R5IxvHDMzSpX1lHVcoST+ou7vd1qVg1sCzJiKYaq5EXTjxUEFumr5qAch4
         tabpVNXfF2hiII7+y3ewohfuTx7PoXJW/nOPOLjuLObaE/jIeZcH53QUTdK3rqr2O7gD
         qDPE/+ajANYaUtVIxTvhNYWPPihQpxS9mgNLUpFY8qx/aXd97cFIL0T631hQM7lC6sQY
         8ZYw==
X-Forwarded-Encrypted: i=1; AJvYcCWbSRA7fWptLJdI82f+3YlTgrFVe2vE2sCqdnP57d1bhYQlmcXtGM8ZN6quI1wLUVoH7Vk0JmP10Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy62mwzI4ZuhOaI/33Bm5gEAsHj1AGmWZAzzcH7eCLFImPDJ88G
	oubeK7kknF5/Yyrrt1Yvi9L00L/f9CCQYATZ99jyhNaPNhmr+mZ/p5+HFGY6Iik=
X-Gm-Gg: ASbGncuq05I5PG00f14tGdZMk2hOQbBasgtp0BKTUnIDQtYfC9ZZ27Fh4fmGpL1cNM+
	uQjbj5eJ4rglF5PVGC3cowAebC35oO58uOz7AYAAgKnltY/41ooboR/sTRHCEEvMZhBGHcGoSjR
	5RxPkDkv843OyKUuXZZCWBnjTvecrIWW8CYARupeZjCqADQbIeMoIPwRbbD13r33P/4t551bYwp
	STgMt0pkZu98r0V+QQDfl0qKIlDXCxyrdy4REBwfy+6UJkDXzM4dwuWKlXehnSKOOsIcZae7IZN
	+mO36KtMG+yM+ArH3jk4sL9qYCYBexAuoaRYGBlP9hFaGap6XQWLnY6//dHOCCf3ykb43w2R8wn
	z4LSDh3dCjwntWJjBzYo0OqR6+A==
X-Google-Smtp-Source: AGHT+IGcpkNfGC9cZp7cxPodUHwFeqsEzvnD9PBRgOzzVs1HtvoYaDG1YKghsPwupGg0CervwLwT7g==
X-Received: by 2002:a05:600c:190b:b0:439:955d:7ad9 with SMTP id 5b1f17b1804b1-43ba66fe855mr109065095e9.14.1741002463376;
        Mon, 03 Mar 2025 03:47:43 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7a2asm14385125f8f.37.2025.03.03.03.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:47:43 -0800 (PST)
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
Subject: [PATCH v4 2/8] iio: adc: ad4130: Fix comparison of channel setups
Date: Mon,  3 Mar 2025 12:47:00 +0100
Message-ID: <20250303114659.1672695-12-u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3350; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=ec14xnJrpwkJrC/ethpz0fLxzagiTiLZ9fwLcAvPKo8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnxZa43uPHm+mFcYsPYI+AEgpGn7hKsucQzPMCC CLTMo9E9RKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8WWuAAKCRCPgPtYfRL+ TkWZB/4xBWucmDiiknccyOSXYattbMonYzRbz4bd9Umov8diX8N4xq0TJN7QrqvTlOp6CaSSPYk t+gXSgqH4jTIbnIb/x6kAWm981EhINKtu2hxbuPEkfoEEk4mNikABZBMZG7xc6U+M8BNAO8+GTd uzbv9mWwEV6LvzPmziBAXEcQlm7C6RsuUV9yBsXS93SB6vn0rce1aZucMHyR1JiuF5vx2mx+xRr 9T3neSNT8JiOldSEIAmLeOxg6zRL0ccwEGOfD95KVdD4XHjd5T1IfxPc0T15yf6Jc1XcPNXKxcZ EbqyAKdMYk2rHWzC22jfSbOVyx8ZeEkT9N3eWBvwLc32UUff
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
struct ad4130_setup_info is expanded, the comparison is adapted, too.

This issue is somewhat theoretic, but using memcmp() on a struct is a
bad pattern that is worth fixing.

Fixes: 62094060cf3a ("iio: adc: ad4130: add AD4130 driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad4130.c | 41 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 061eeb9b1f8d..4ab1943c4697 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -223,6 +223,10 @@ enum ad4130_pin_function {
 	AD4130_PIN_FN_VBIAS = BIT(3),
 };
 
+/*
+ * If you make adaptations in this struct, you most likely also have to adapt
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



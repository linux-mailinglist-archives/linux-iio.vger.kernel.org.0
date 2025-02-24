Return-Path: <linux-iio+bounces-16005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5165A422C6
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 15:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B661E3B7DD8
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 14:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C0186340;
	Mon, 24 Feb 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tQHhhxMt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666EF13B2A9
	for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406251; cv=none; b=fdqdmgndT39PLs9GPLFSD9/xO8uHHhHKsxhAEl3dxJVBjlwmxqkz9BcspC1nI0Ez83XhoHT39oiKgFW2FA/0q3vmYl/Ni+IVdpnETYBCHhLIH8kNjtP8VX59Q3slhUlpJA47GvAAtwC3kxg1DE2enM/N+UWvw5GxiJVkYgiEHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406251; c=relaxed/simple;
	bh=ec14xnJrpwkJrC/ethpz0fLxzagiTiLZ9fwLcAvPKo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dloFivcYfX5DoBiwDjO0md2cWePzLYAERfLtAGKRNp99VglUWKu9tWlkr6k/MTe1/PlHl9EpDMdii71PgiT4K6gLe6wvahFRweCqmIltb1Qgp0XpRCBuYhaTwSBZJAkx4/HSjaEUmZGmNld6lC9NvSozs6POsEAaaoaXzOLldd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tQHhhxMt; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb9709b5b5so821063166b.2
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 06:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740406246; x=1741011046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3z/kCXdK0L4ldNMK0CvF1cmi0sAxHIrcS5GyQP4Qyg=;
        b=tQHhhxMtbbBIZTPQRPeP7qaA0a0VGbdBaolxJ+eRgMWpLZMHpoimwIfGdUGtlDY4oY
         69hS0viWRXf+lUS2U2BWUqOYyJ9MbCNVLjVuSmTpv0mTvi1AA35caKrs1albw5MIn1Yn
         pbCnml6FGJjAPZnDW5Ax0YPxeBruBUyO5q6dsZAU6oRIATLiHvou6w6jPJz86na5+eTe
         2l3KkBinnirrpI102/6sn8ZRXRbW0xW4cZqiH080BfMkQUDGKszZ0lCS1jkXMwuq8rZz
         8F037bLqhdAKQzCXOba1zXdB2/EKXp8s/xv+DBW9IOEWxzftbkvEr5YMDDj+oWkMbTtm
         7PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740406246; x=1741011046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3z/kCXdK0L4ldNMK0CvF1cmi0sAxHIrcS5GyQP4Qyg=;
        b=e/POsYyaerxmq5IUz3Rqozkhj/CB5H9twBW9OAgNMTFByrxt0BtDKdFXOVo6sXm4GS
         En3mX9ZWF9U0B5A+KLa64WcUzfLUgTCy7MapNJPp8dxNqyweX4kWrDiCrCxBt7FAENEd
         +IGWjsbulIRDsX4U51gM3cwg3dG1kIq8RrvlY/x/2kx7pvPlCTqtlXLJMBsrh+SggeJo
         eIkCdBTy5o5XU63z5OdwBt1EZ/bD36FzW3GYQHM9lOULFQy3Uj2AfvDFeE6YmP1DcE20
         ksZezHD0Lk26m3qiDQ94WOXCQMObOOwV9Qvw6XPUmu1lZFgPqb8lRDjcjPa8Y5biJc3e
         LO9g==
X-Gm-Message-State: AOJu0YyPzHgS+SX7LnnQ8ihJPr4WZbyQlG1lJ/wfmUi18GT1oZJModfE
	fpLK0A78XUjvyfnn0xhjyk44LhsZDdqIBQmFPAQYfE6SwHtDXVeBTgBq9ir2EDOpPEr2PeeahNY
	t
X-Gm-Gg: ASbGncueXVWje/xymCyPoYKQj1Z6Z4m9a45VcHa2OuqEEMjM31k38TtOn6en64aDLcb
	BTznYmQH4U4tmu+6Aa5wKRCfBsf56iyWHQ2VzvZ3zzHULmaegKdJ+gu8qulMejVnbHwk+tWyn6d
	oFJRlrX4MMaj0HHvdnqEUY7hXSliJ/IsvXjckpsDdxq7sCu1yru8L7xXWHskP12ma/owG/xFSlW
	Li7yBzP7eMKZ6X7lU/VxYC7YVGzskQucSDX8wj17s1BnbYBHsOs2xIHT2XAOuBynSgXNQysAb+h
	rOTWIebu+oTz7cRhWgsbedGU+Eg7rZ8=
X-Google-Smtp-Source: AGHT+IEerRa4aomy662kgS2FvwbBpmQRsCYO0ncpqcdejEb2ubM+sRbpqK3FovOpqe/ZYbg0jaiLXA==
X-Received: by 2002:a17:906:c154:b0:ab7:e567:4fe8 with SMTP id a640c23a62f3a-abc09ab0dffmr1425550766b.25.1740406246315;
        Mon, 24 Feb 2025 06:10:46 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdac1015dsm1082696566b.127.2025.02.24.06.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:10:45 -0800 (PST)
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
Subject: [PATCH v3 2/7] iio: adc: ad4130: Fix comparison of channel setups
Date: Mon, 24 Feb 2025 15:10:13 +0100
Message-ID:  <e6f5902a70fb9f6b2981ba7fb1f3582955a836b8.1740405546.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3350; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ec14xnJrpwkJrC/ethpz0fLxzagiTiLZ9fwLcAvPKo8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhvQ9tac2pO2reZlW3u+uLNEhPePo1oDd5d/+vbh9bHOW2 WaBvPbqTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmcimC/Q//jZVi7H1RLxwS 2z5LCwccfXqu67l/0MaLifd4lyiue3rSOCWCabLQ4oiMdj72hT+mSe/yUGbQ9BdJPyRgJHrx8pp dL9Uv5SlPLzZaK/mZsap2tzc706vJJluiHW92WvX9tOdmXlMyU+jkqXpFwRzR5rc2CX+ey+o0dz YJce8rOrPX9dpEx4V/bYQrf29iLdjIm8nuL39vOz+no46ztav5pIcmGxa23Lrj4juFx/5l8aMMM 9e7vtELzu2PchM8EayW/CfumGWD84ydshwZcqrre7uYph/7vG5TQUM6s9rLGzJiufsZHY91srXt W8dz2yVCS2jRq9KrjJtv/Mxl5N/scSvUP+tkobL9KndtAA==
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



Return-Path: <linux-iio+bounces-27840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF17BD2767A
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 19:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9859A31DEE3B
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 18:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C9C3C00A6;
	Thu, 15 Jan 2026 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KbpSzS4D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7879D3D1CBC
	for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499640; cv=none; b=KIhecAb8TpISHbzhJlcPiqCR8fef96nvy+ERdpcYdz9//4JgyKruc5JTy8rifDjbA/K08FZfvOvdOd/ghdti7KUc2P3gILccyX6bCcD1gfPwTEJvlUbW17B7U5duzfSxF1XxiVmINvGy2vBAKpaFtsPBQ5WgijXQE3F4+tNy2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499640; c=relaxed/simple;
	bh=KQ6deyzkVjZq6NIK6tTIuKlZvKBK+ceRfenBzkSvgYI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5CYsniC1PYUdu8cOAoVYhFGwfz+uzN+j3kjFGeH8WAylsiofDN/Ui2+wdueDTr5PEvsYQ53VLe5VZJr9HMOE3LPa6GsdHXGI3q7CqctnZDNY+2jUZDdd9gDBDfLFUMC7d5aMN2GL1sEFti9OFniB2tw3bMPHTiqnf0mhXNuMbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KbpSzS4D; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso2052951a12.0
        for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 09:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768499635; x=1769104435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaLrRxWciIJixwyrbJUWeuXFzrG4IqR46rRObdRM90w=;
        b=KbpSzS4D6/SYH+OmSiv2uQan7ZzoPNj+qKXmJZRiBHKkepn4rsMvyMvxjz2km/2haf
         +h1s+6QVmH6CKxm1ix1krLj5gHTvC7HQuVi/qZ13ylK4E1b5CjpkwfkK8H93c2cFn/yB
         7LwrOy1ifwL+B6n1Un4JO1ze8hXAQYStCX8bpGDVGGi/KS20wlybQvID+JQ+5XU5M679
         C8dGjp/aLjdjdgvSrsYg8yyW5MsUe3pjP69NWOlNytp/Q5M3DFgBe3FL/tzw+sep4JNB
         qXoaSWXtwR3RaNNcZuqdMaqM0FqPQHMiWVkFDU5JwHRngNRK+rIhjlmm97jVFIx3wjkv
         ogIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768499635; x=1769104435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jaLrRxWciIJixwyrbJUWeuXFzrG4IqR46rRObdRM90w=;
        b=DcQhLOMndKSzDcl0SwU1GVnl7qeGCVIjH8Og4neqp1/sy58kdzcTvAI4f+jg2ih3wv
         VgWhz0+F12Igmk2PDaqRbPj9bZSxxi/6g4or02VlrKKSFyNq6gRF/00T5u6Qh+4dUdGB
         8aVSz/lZom4BCd4oFD49l+p9raoEQB0CIE1nPD6fuGdOLty650aJ6UnvbHmaBWE+q5Do
         dGi78GPqh3u4v31zOw+3jYMWW0GZo3C+t3yQlrIS4RIE1hH6bE62XBbrZAqjgw2XseI0
         Od19mj5bezDyeeaj9s27DOCcKgFG9u35oxV1QZybZ29qAzpn8jqD2va2ZgzRqL264vvz
         im+A==
X-Forwarded-Encrypted: i=1; AJvYcCVrSMB8u+q42Rc+6181brwo6bFTnMQBSXa2GFRjCCR+9dXR1cWFe12J3yqlA1vUFY2rlotnXwaIHu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYtGrOWHEeAG0ZDmJMH3dwK9CG0pkGaRtZh4HyyLen6viNcSW
	5wQAK2HqSZRkbk2JgRarv0eW1lrFXVjs4lyl/dhnwJhDgKedfUBKLMzyu02ncAyyUtDxcEbPttQ
	cG/eO75I=
X-Gm-Gg: AY/fxX55nsCX1P4dHdEjJqSndQjYOCFXXtHHFO41CQDgCjxOSwPDaV+kNFg51Rsqw0b
	BwRfLtSo9pztfoKRjWIl6x9pgj50q6ELDSovQPqKvHZH2Xzt8ZpHizMaDg1OYgspwJvdoRae1Qa
	OgrOT5/W8zHuikLG/TQkY2fbZacUJMgR8bqDbWeqeHfwYO2l46qoC8e9PpWvnW3ouxd0FjsrV2j
	VXfNo4UKrWLQpTkFvYUXAogRPiV1lvkqwm/KGwt66Yrm1LIsshcwf3oNnf4GCxYfKy23kAs3e6d
	UusG4V5/v1Pc+WffXqE/pPLx03HrsAq6WXWnrKQw4t51SIY8Z9k7wp/LcD3zDqI3DTtJfL34KK7
	6Mn2wVkw70lk3ZvtTnqRj2V82ovNi6ObqTyB9de5jd5fTwa78AKNdIs70puTYrauKRTrnHrpHpd
	Ka
X-Received: by 2002:a05:6402:5113:b0:64d:2920:ef17 with SMTP id 4fb4d7f45d1cf-65452bcebebmr278852a12.28.1768499634775;
        Thu, 15 Jan 2026 09:53:54 -0800 (PST)
Received: from localhost ([151.43.128.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654533cc543sm190479a12.20.2026.01.15.09.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:53:54 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iio: accel: adxl380: Introduce helper function for activity detection
Date: Thu, 15 Jan 2026 18:53:49 +0100
Message-Id: <20260115175350.1045887-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260115175350.1045887-1-flavra@baylibre.com>
References: <20260115175350.1045887-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2360; i=flavra@baylibre.com; h=from:subject; bh=KQ6deyzkVjZq6NIK6tTIuKlZvKBK+ceRfenBzkSvgYI=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpaSmfTrIanMXh3+id52zUDk/0dRnn3I1dF5hPM 0CLWj6GbbGJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaWkpnwAKCRDt8TtzzpQ2 X6l+DAClES+b9ecDuwGMCe0Ztb/3FUf8eROlHGiCmkJn2rdGtG62ULDe50onZ2llrRARoLBOZe6 wZozNaZjNO0vMbWV17/sBn6dqAIGei633Uhgzkk6655BvUmvpVYZPg7A9uSCn8KsHRvmpY6HJqG //veSVc3QRa/SOTQtmUdIyc86IxUAWgQ5FonEYJIhCZ2QKAP7bdseq2jhsXwyxe65np/pCSsJyi i11xLZK1EV+WCnVyUxPqPyzs0G37kaiUhZWNCpP9dxKxdMB9HxKS0YezbQSO9q9cC7Rtve53pjT 98iFNLRmERNGN7WcCPqpkP+X9ewrYbjD6J4wEAUYAvZQ+IK5BCExecdONCVvV9cLWTBt6J/htp8 uNUaBTNl7YnLwx2XhPmKcQQezizL6SRPzcLF3RiEzf3rBfN1nhag+aUYxHnd/3CZaMCu8RHJrP7 Z77nGvhi9eQeTJSJ61R12EqQIGJBYrNl0p2MjwhtBn/K3WzQDCdvlMOReZlmZtEDEHU3o=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

Motion detection functionalities (such as activity and inactivity
detection) are only available when the chip is in a low-power mode; this
affects the available sampling frequency values.
In preparation for adding support for a new frequency value, introduce a
helper function that checks whether activity/inactivity detection is
currently enabled; this function will be reused in a future commit to
determine what frequency values are available at any given time.
No functional changes.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/accel/adxl380.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index bbf1f88ca781..b99458a5eae3 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -232,14 +232,33 @@ bool adxl380_readable_noinc_reg(struct device *dev, unsigned int reg)
 }
 EXPORT_SYMBOL_NS_GPL(adxl380_readable_noinc_reg, "IIO_ADXL380");
 
+static int adxl380_act_inact_enabled(struct adxl380_state *st, bool *enabled)
+{
+	unsigned int act_inact_ctl;
+	int ret;
+
+	if (!st->chip_info->has_low_power) {
+		*enabled = false;
+		return 0;
+	}
+
+	ret = regmap_read(st->regmap, ADXL380_ACT_INACT_CTL_REG, &act_inact_ctl);
+	if (!ret)
+		*enabled = FIELD_GET(ADXL380_ACT_EN_MSK, act_inact_ctl) ||
+			   FIELD_GET(ADXL380_INACT_EN_MSK, act_inact_ctl);
+
+	return ret;
+}
+
 static int adxl380_set_measure_en(struct adxl380_state *st, bool en)
 {
 	int ret;
-	unsigned int act_inact_ctl;
 	u8 op_mode = ADXL380_OP_MODE_STANDBY;
 
 	if (en) {
-		ret = regmap_read(st->regmap, ADXL380_ACT_INACT_CTL_REG, &act_inact_ctl);
+		bool act_inact_enabled;
+
+		ret = adxl380_act_inact_enabled(st, &act_inact_enabled);
 		if (ret)
 			return ret;
 
@@ -248,9 +267,7 @@ static int adxl380_set_measure_en(struct adxl380_state *st, bool en)
 		 * mode and for devices that support low power modes. Otherwise
 		 * go straight to measure mode (same bits as ADXL380_OP_MODE_HP).
 		 */
-		if (st->chip_info->has_low_power &&
-		    (FIELD_GET(ADXL380_ACT_EN_MSK, act_inact_ctl) ||
-		     FIELD_GET(ADXL380_INACT_EN_MSK, act_inact_ctl)))
+		if (act_inact_enabled)
 			op_mode = ADXL380_OP_MODE_VLP;
 		else
 			op_mode = ADXL380_OP_MODE_HP;
-- 
2.39.5



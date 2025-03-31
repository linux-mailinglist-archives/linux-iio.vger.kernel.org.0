Return-Path: <linux-iio+bounces-17493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD30AA76D7D
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 21:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C17F1656FC
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE6219A91;
	Mon, 31 Mar 2025 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FheK0Ma/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A2B2185B1
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743449405; cv=none; b=C+HeQhNGQ3S4VIuSX/ozS+wkXcLQs0XxShXpqY27G7Oi51KMBWgvgwp52UP/OQjq0s1W+BaUot3TmFOdaLD487nDQlCqls0eCq+27TWdO9QERphlv5Il9AB4nPSUgNNDf9dRhGKtkwsZhxtu/BXC/2D2Ib9cIk8yxilY2tbjrFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743449405; c=relaxed/simple;
	bh=NahM+36knhi00KTWV4WyzXhlwvnW7iE7xJQnqrUZJwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=stYNOaeyFV8gb25lUM4yP1vh9sKw5slrOKRwFjHVM7WGiap5r9rj/lhK3nl4sTNAo3WvC2Ht3zNTIqyDTMBqt4LHqRdlNpAWvzs93/gKb6PH8rzuK6o68xut7EqiyM+47sjSz/SRyYRDtYOOPyG1qqb5AdHfb+V/HFLeFCOvoLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FheK0Ma/; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-60208b7a6d6so1387044eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743449401; x=1744054201; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n7Sr8yp1NV624AmBrK5QYW6xtTPJmFymnATfGqV6IEY=;
        b=FheK0Ma/loPD1EeELAgTSMDSSvHdibinr8Jkg3g4OM5NAayNtA5SeDB3pT+A+2v/U+
         SeuX/0bayAfM7uYNw4g/eKoo1x5JCKWuPz/K5I5wTq6FcXaJHOzq8zc+pS8QKVpAuzhY
         4V7W0DBfLsEVMVdyNTphI6Fhy20TmIu5Acbctx9KpviwfAQ6sp+EUwD5jTC7TljpSEps
         LlW2mYG3YAmChI+Zs385+exZy53qK5hnfY39XPINgSF2IJRZYd2mhM6Rbv2WahvMKYl5
         +pWITIenPNqSTS1F0ktTJmjxr96tyEhWCdHzLjKnUD9ILlK9Thrau6aELueUUglp4R3T
         SdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743449401; x=1744054201;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7Sr8yp1NV624AmBrK5QYW6xtTPJmFymnATfGqV6IEY=;
        b=v1xHrBOKK2z3zKNpGqZRBupsxKqUG0da5RKPLE1sRTHqsiIChdP5UMd5sjnFo17R9R
         tt83UJrLeAIkGIs9s0/0XLb3+aB/um4HFAAtF5Chb7b7HfcGbTCIiiiOeQHgWauKVyew
         CXHJKE2f2EoX3oqZKgbv/ZhwzRoJ4KbYTuhOLmUrpCEyr4EVxjGMlae7U7DHDoqGMz5M
         8OKT4q75LnmNeQKkQjELB96y0YyVsqMXoUJhItGutdlT8IH428G5N0Uizlx1SgX/pC+N
         OjIORpBcOmUvURQgzgQkl8Pfu16IQl58FS/+QRUQ5s+HxTskm80NbvbhM8VskeYZTlHY
         oB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYByuMogSAwOlqjYqWO37zsMLEpT+rMsHstJg1/ta/fbsLYTg2yZxUGSffyDsX/blbcm02KmCgY20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1psIu8HrnzjeMiyohEqXtb23XiADncMHMJTDLV7xc4qx6AobD
	b92mKniPIdKogKkpz93FnswgvX3cty+KOyU6jsNp9Q78IUFTzSDBdQ91vUNKZmM=
X-Gm-Gg: ASbGncsks8b4dU17xK3BUpT+1GsGS71g75k134RpoGbITYI8/S0dmxR34AiyMFGBlun
	4UX7lPdOGJzpzjxtQKoIFfGjnSTzfbc8xxflHSLai692pqtg8WEAiB4kGa3CgsZeewsOa/JwuUV
	QHxDgngb06jLe3kdQXF7A8U/zoImmQWQCz0yDti2+sMrgxd/XBjF2hBvZ/crHkc1SBayrFnN6sy
	WWZp14WO2K0jBUjgWqmRMlNhT9yzUs79ZYgIgjMnCdsEuADJFDzcwzOBYctgsPQEJIWa2VOf8V+
	GVJzaPAEumMq5FmUm5QlX6yLw3ItOqStrJWN32pO2WAXTYggEcPRQUIqCkf+BWhcy8YP5Eo7nlV
	2
X-Google-Smtp-Source: AGHT+IH9+27d56YPKAkDDx/efqJvupFTgR/XenGgMEQV8HGPeVZZ6OEL7idwkp+Gp2Oks1tfGDtZhA==
X-Received: by 2002:a05:6808:150f:b0:3f8:acb4:8d7b with SMTP id 5614622812f47-3ff0f641e38mr6637534b6e.28.1743449400540;
        Mon, 31 Mar 2025 12:30:00 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ff051aa1f1sm1640831b6e.22.2025.03.31.12.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 12:29:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 31 Mar 2025 14:29:54 -0500
Subject: [PATCH] iio: adc: ad7944: drop bits_per_word hack
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-iio-adc-ad7944-drop-bits_per_word-hack-v1-1-2b952e033340@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADHt6mcC/x2NQQqDMBAAvyJ77oJJFGm/Uoqs2U1dCiZspC2If
 2/oYQ5zmTmgiqlUuHUHmLy1at6auEsHcaXtKajcHHzvxz4Eh6oZiWNjug4DsuWCi+51LmLzJxv
 jSvGFNLnF8+gShQQtVkySfv+j++M8f1I/Qu94AAAA
X-Change-ID: 20250331-iio-adc-ad7944-drop-bits_per_word-hack-a71b2d51fa3f
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2173; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=NahM+36knhi00KTWV4WyzXhlwvnW7iE7xJQnqrUZJwU=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn6u00IQV7wI3kL4cLzccCSccA/JuODpOnD/Oou
 Mnj9e2p+1GJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ+rtNBUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAPQvxAAhcTiJYF4XN1pbER609LA7tYr/YKu9SUK1ym8O6z
 riDmweDAorMy8nAgu0s5GYn+xx00s5s9SnW+KifuDupBnYjIlQA2WHdIwkzYQzgpUElCSHa4USZ
 OXCGt/4SnsOlp2zZGpP/dUe5xCTx/4DPMXgQ/FX8ceQh90+0XB/eDIBUxeNOj8S7KXqhOU/CPIU
 6ire+9Xk2/otJI0nTcz7l9CHd5vewWUuwKpbSKuCQuz9JhGUa4IeO5KcT54N+354+JK5JbT+5wQ
 qZUmiqZIHyDoUa4uW7jkCWJrQIJUHf+Qns1ImYMM2h0JmJuYOb8XV93cZDqD1qn6avNsdIObZ7Q
 x4YIylNC6TwOnKbMHCf/K5gCdLeif7tT18dPn2hJBtpGJaZd5GXkBpc93hn5noG3huDayXGv27I
 j8EJpkjpcEaSIuqCTWQUkXhq65/0VReeyjOhEj3PvX0/5NidxH7//2KzSu8LLyg2zgcSuetrFVD
 qhYmnv+hkXKdUPZSBFDnydBzV1HbD/XO5yBFWEca/qC1L0HrqPxDw0BgHqG1N5wW4AN9pdL1PkO
 NppGAfk0QegcHEUJUxduITv0ZaBOQ4qk9vr0GvtzT8zsknhOgqMlblEEBhc8az27deuD4VfbJTC
 3+DhR4TuSvSPLhMRIq+/rs6/cJwF0B5xs91SRiS0KCxw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove setting bits_per_word in SPI xfers without data. The shortcoming
that this was working around was fixed in the SPI controller driver, so
it is no longer necessary. And we don't need this to be cargo-culted to
new drivers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7944.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 2f949fe5587318957f2e423029294ced0a6f803d..70f313545af2393a625ae2ec3c2cff2e29153ffb 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -189,11 +189,6 @@ static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *
 						   : adc->timing_spec->conv_ns;
 	struct spi_transfer *xfers = adc->xfers;
 
-	/*
-	 * NB: can get better performance from some SPI controllers if we use
-	 * the same bits_per_word in every transfer.
-	 */
-	xfers[0].bits_per_word = chan->scan_type.realbits;
 	/*
 	 * CS is tied to CNV and we need a low to high transition to start the
 	 * conversion, so place CNV low for t_QUIET to prepare for this.
@@ -208,7 +203,6 @@ static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *
 	xfers[1].cs_off = 1;
 	xfers[1].delay.value = t_conv_ns;
 	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
-	xfers[1].bits_per_word = chan->scan_type.realbits;
 
 	/* Then we can read the data during the acquisition phase */
 	xfers[2].rx_buf = &adc->sample.raw;
@@ -227,11 +221,6 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 						   : adc->timing_spec->conv_ns;
 	struct spi_transfer *xfers = adc->xfers;
 
-	/*
-	 * NB: can get better performance from some SPI controllers if we use
-	 * the same bits_per_word in every transfer.
-	 */
-	xfers[0].bits_per_word = chan->scan_type.realbits;
 	/*
 	 * CS has to be high for full conversion time to avoid triggering the
 	 * busy indication.

---
base-commit: f8ffc92ae9052e6615896052f0c5b808bfc17520
change-id: 20250331-iio-adc-ad7944-drop-bits_per_word-hack-a71b2d51fa3f

Best regards,
-- 
David Lechner <dlechner@baylibre.com>



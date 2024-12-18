Return-Path: <linux-iio+bounces-13612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FF79F6547
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 12:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F927A0FA0
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC54D1E4BE;
	Wed, 18 Dec 2024 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mXbxDdjh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3A3193079
	for <linux-iio@vger.kernel.org>; Wed, 18 Dec 2024 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522520; cv=none; b=Q54IS11CfD2i8r6TNp1VCI/3boITg9/5MLGNvWgxzjo0zYqC2kkyt8fAvUadwbA7G+TTF6WtI7jTCG88Xqv5Np9Hcu+5bp0itoaIalW81iRml5BvpE/oBYe9rasPa60cFPEu+E5UKyYZNVvP15Z3N0b8YtazHZZI+8S/Av0oxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522520; c=relaxed/simple;
	bh=T54FxyPNRCdVs3+gkr9Kb1Q0yUyf5Q7aplQQADOy28Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YVA3CSy9GwC+oCwqzLCHtg7vQiaXRk73CC5SQiESaNFnLEdWuVfNZvxqqrq2IegjXgdHL9uNNnuO8LWXI0X8bZk5KVrZoCXY7RJqon4BC7t8eQ1DfZ7aVOYltgDYfPyMJsj0D1a1qPN3zf1bfl1wAL3ktUkTXZeLwuQ/kN1oHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mXbxDdjh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa543c4db92so559466b.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Dec 2024 03:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734522516; x=1735127316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6yM0iuIjSwaIFc9pAiwOGe7pFcDeBb7dXTiKpMAYUZA=;
        b=mXbxDdjh0R9xRgBsLxAXKZaxtFud5YEwIjj7VVj+Yr5jHC4apPwHS87h0zXEFlf7Qr
         I0Es98H3fuSMcot2u56BJr73LJ6hdT0qRMsX2+HB9vq0Ko35FKWndNyjf7i2sUyS9KD0
         Jdbx9Qnf+IN4drwuLMBJFK5KqICqyDq1nlfT13lCfg0z9y51pLJCaUoE6bQX6zN+/S2t
         nUVpY0y1QVdHVmvYcEwhePkmNMxkyHprO5Xer3qOzh4CsccFS4csll56yM8FfKoJMqlY
         R+jgoBKDvHB+7ZGDQzlz35FhcNesJmscyFxLjU5NfBPQwvTPx621Ge0snG8x9Gnd/B9F
         doyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734522516; x=1735127316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yM0iuIjSwaIFc9pAiwOGe7pFcDeBb7dXTiKpMAYUZA=;
        b=mL9ZsEVOSNKvzqNnv1M7I3n9WtkHMgaMPkswGS/U/4tU9o3pIIeq9ylcMkwvvR/iy/
         pgkSuJHdmhKIpAlxfJ8h3glrNxIOmxBef8FkkQEQE6SXaCNAdOHoVnq1lHARvnjQbvx/
         aihbibHknRuhN2DnyMNi5nheUogvCjAdOo6FiHX4yAj+Xd0KJ0E2tu88n8HTPxTZnrNx
         MMhbTMpgHEr32KumacVoFuluNIPfkKGkFgBAVw47CILK0aWVnUAEN+aYs7BtKEbgU+7w
         SnWZRUqNFg3FmMiyt57lD4e3I9XQ0zv5bhv05dW4db9RTER+mWqwPYWQBpU64NSdEb00
         k26w==
X-Forwarded-Encrypted: i=1; AJvYcCV/QitSacOrMwinm9yi9iIBqp5lGiYURgHSTsDxqJG7dkeXZl8yWqJkgjUK08MZjNsQav1j1JbwiZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynY+y2gg2odWjhRZhuxB1p3SWS0VwHoETnes1x/+iC50doHM6a
	jJ3zMWVncbnOWRqx+8h3qk5DV0FGN20lbPR/zcTvqzfW1a67lcNY1Nw2KzGIIaM=
X-Gm-Gg: ASbGncuB5jilW4CBrup8RDKlU6veHe37zrUb/Z5B7E9MavNC+P+xowPE1XUJ/st0/zn
	ogHyqQIVzX1+BdgbZmOp8Vcmj4EPwboGM8yhfeOZGIqzOv7STsFyDI3S+xJ9ZkTlgJVeib7g1HM
	gQ7Q4IkkgDfqO5T4mhmPionpYWyqGa51NYVaE3dhpOnssm8Gb+0wEsvLCkiecAyfBrDu/kPibXh
	uRuitemKTBRqXpElJJ2FROaZfDwm6HWufEFgEZ75jIExktw/l3ghJq6jLdP1KwfryW3pxvzP0jw
	C8zWDXbFgw==
X-Google-Smtp-Source: AGHT+IERq+S1Ho+Q8x8mRCM6OygopM7ECLwWvp8CATw9YKJSNKMMBUvtN1dWITD7md6QqQ55iI2K4w==
X-Received: by 2002:a17:907:6d16:b0:aa6:653c:409a with SMTP id a640c23a62f3a-aabf4937abfmr229480366b.57.1734522515866;
        Wed, 18 Dec 2024 03:48:35 -0800 (PST)
Received: from localhost (p50915bc6.dip0.t-ipconnect.de. [80.145.91.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635957fsm560954366b.109.2024.12.18.03.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 03:48:35 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ad_sigma_delta: Use `unsigned int` instead of plain `unsigned`
Date: Wed, 18 Dec 2024 12:48:09 +0100
Message-ID: <20241218114809.1378063-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=T54FxyPNRCdVs3+gkr9Kb1Q0yUyf5Q7aplQQADOy28Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnYrZ5YSyzKuvzKDsQf+4poS/5lCF4JzwaRaifz CnGYFLN67mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ2K2eQAKCRCPgPtYfRL+ TmwcB/wKeOF4w31gL6OcGyzVIciCbF06jtWkX6908YXP0Juc4MVqAPZcUutDpc1PYdxf0p9i+gU gFYgmxaPWX+lAcAXjdqG4fuT0hb48hPyoRAcDHZ0bxmciMti0TN0jepv4AfF/3NfTx5vCmVhpLk G70nadCsxeB+CK+laSdxrvFdzWckbnsLq6cLM8yzpquSIDLLD38TcylonxBMOOglitW6c66Tu2e QmNn5eIuLHK4NchSgrZ3QgcYdLCkSPo0XFTKxxYWhzPh/hrLG6zbP8eS7YuxP6PscV2CG+UyMwp T/4US98qeG4pQrE35AimX3yZ9EVbCO+5Kib1f9iVtZJayEGa
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This fixes a checkpatch warning:

	WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
	#70: FILE: drivers/iio/adc/ad_sigma_delta.c:253:
	+		unsigned status_reg;

Fixes: 132d44dc6966 ("iio: adc: ad_sigma_delta: Check for previous ready signals")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

if it's not already to late for that, feel free to squash this into the
original commit.

Best regards
Uwe

 drivers/iio/adc/ad_sigma_delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index c3c81aef34d8..7164ae255ed7 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -251,7 +251,7 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 	if (sigma_delta->rdy_gpiod) {
 		pending_event = gpiod_get_value(sigma_delta->rdy_gpiod);
 	} else {
-		unsigned status_reg;
+		unsigned int status_reg;
 
 		ret = ad_sd_read_reg(sigma_delta, AD_SD_REG_STATUS, 1, &status_reg);
 		if (ret)

base-commit: 132d44dc6966c1cf841ffe0f6f048165687e870b
-- 
2.45.2



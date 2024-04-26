Return-Path: <linux-iio+bounces-4525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EC18B2E49
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 03:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218CC1C21889
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 01:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0111FED8;
	Fri, 26 Apr 2024 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="RldOkJOm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AEF4690
	for <linux-iio@vger.kernel.org>; Fri, 26 Apr 2024 01:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714094670; cv=none; b=NUh47D3k6DLCiMM9rKWPKfarp6el3nAGoZjMeyWfamDDerH1/Cjpmh6pwAfvmeOthruFAdj9oho6m4M177jnrHXPwzgSlE7QTAkgmO9J1A8ZYuWwNA8ADiDoGqLRrLk/WlP/8h/zeAyzPvAN9nC0Bm65uG5s/i0co6ySdhVqios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714094670; c=relaxed/simple;
	bh=q/7fscwlFLgp5jrvmnnjXvzPuaEUxIpvk1ZKeu+ONqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d6xY/Nztw7gLAdxlCMKgOpsWdrJcdKJ/5/TwGDbH8/L6U3/pVZP8A5uzd0NWFiqxXP5sizIAztpc/Mn2hVpKIsZLYbeMloVXUEtjn68l/oIsDANeidcnqqNjvvBMxIGtDbeiIch4w9XSsGlF2j5Iqv9upnz8JLpR9wh8ZVYEx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=RldOkJOm; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c66b093b86so2074774a12.0
        for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 18:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714094668; x=1714699468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYAdh+c8F2t7nNzWd25A/VC4D8YRxuL3ztzKs2rZXhk=;
        b=RldOkJOmzdl5Y532oGZVWf1sbiYUse9jX/SUGF5Ct07Ia6Z/a4pmD179h2YH7yfEZN
         Ae4VvgsG/ZsTicBYVa/Q+Gyds5ZPTkcjwXdKdGON5KFX6SW/VQI58YaBItZmVC9r4trK
         mEtGg8lX22vMvl+MadcKjX/aojlZ7mPc+VvKbdM/TTcX0NL9LOXu38llZwXMJvmuk79O
         7IG+yHqMdOOua1h/uOBO3cCIayqfLfQk4+1ZCF6yQmKc+juGQLDIsxkMKthc6tfMFe41
         g0AkGbSlmwmdsPxOQz/qqnI3t4NpaNQK769d5dSU5pEMpGrW+4lzwgbMwMttFusSJgwN
         mWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714094668; x=1714699468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYAdh+c8F2t7nNzWd25A/VC4D8YRxuL3ztzKs2rZXhk=;
        b=TDbfGep6pyL5pqhH/+NSIewaEpKdACj604nY4B5lqcdOXCb5uOOp6n6NZXbeUYKsDO
         7qmxoOIvO64z7bLGZu1f0xuxXF6aYS0O/q1OOe/ERHiAUOyh7qfir0tpXvZwTgQw4YDZ
         tPilSaIswAfGoN+vMtmJ44NofMzN3PNLY8VxBgEB1WWGTGbRJy+y5sv9aI7d0LPgNwNh
         ZMpRneaxvgdIKNlIxkCsUaI8t6deX8/ZpYzOlKI4Y3y7JHjMuKk2JYmgWEYiLUunoEWl
         T1p10anTxAoIrzvr25m0TpmsBmJAbD98S4LoG4YxkOd4CqCu6Vp1wPtOAfxWYOFUqFBz
         EzuA==
X-Forwarded-Encrypted: i=1; AJvYcCVyg5K8bF8hJN8vdJHgGe+U3itknJNUDxu1VvWuK1G0afcccWAsjpa7Q9rc4FhcGihlxnhLyQ0V0+m2J9droMq4YPwY4fqCchyt
X-Gm-Message-State: AOJu0Yw4Vq9TIij9uhqW6lo4+cmVWe0tM+p0SDcvZc5f+TFJsvUoJ03P
	JUHIQQgYXRvvmieLcUFLAf9dPW1qrfYNS64AhnYqAwm9mEfzaz7H9xQw9YoFLU8=
X-Google-Smtp-Source: AGHT+IG4bnGwW/InybqMozAWceD+UywATT7qn2q1BEh2yMu07q8sLO93WpTTyo9rc5pGGW39NLJ45Q==
X-Received: by 2002:a17:90b:246:b0:2aa:cadb:d290 with SMTP id fz6-20020a17090b024600b002aacadbd290mr2120610pjb.13.1714094668477;
        Thu, 25 Apr 2024 18:24:28 -0700 (PDT)
Received: from ASUSLaptop-X513EAN.. ([2804:14c:81:903a:9968:e871:2529:9bcd])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090a930800b002a513cc466esm15294305pjo.45.2024.04.25.18.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 18:24:28 -0700 (PDT)
From: Gustavo <ogustavo@usp.br>
X-Google-Original-From: Gustavo <gustavenrique01@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: Gustavo <gustavenrique01@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bruna Lopes <brunaafl@usp.br>
Subject: [PATCH 2/3] iio: adc: ad799x.c: add blank line to avoid warning messages
Date: Thu, 25 Apr 2024 22:23:12 -0300
Message-Id: <20240426012313.2295067-3-gustavenrique01@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426012313.2295067-1-gustavenrique01@gmail.com>
References: <20240426012313.2295067-1-gustavenrique01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a blank line before if statement to avoid warning messages.

Co-developed-by: Bruna Lopes <brunaafl@usp.br>
Signed-off-by: Bruna Lopes <brunaafl@usp.br>
Signed-off-by: Gustavo <gustavenrique01@gmail.com>
---
 drivers/iio/adc/ad799x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 3040575793a2..9a12e562c259 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -335,6 +335,7 @@ static ssize_t ad799x_read_frequency(struct device *dev,
 	struct ad799x_state *st = iio_priv(indio_dev);
 
 	int ret = i2c_smbus_read_byte_data(st->client, AD7998_CYCLE_TMR_REG);
+
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1



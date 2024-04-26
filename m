Return-Path: <linux-iio+bounces-4526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498688B2E4B
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 03:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DA91C20DD1
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 01:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4CB17FF;
	Fri, 26 Apr 2024 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="B2MevCAf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08B64A2F
	for <linux-iio@vger.kernel.org>; Fri, 26 Apr 2024 01:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714094676; cv=none; b=VVYXHbvxmSvXfMKapjxyPiLvFUixh8Nq/txkh1De2n2FkUbY/tliVEuHeJdH+BNCVXqFLrGWKNF+PwzuDNmzNbrnTOnUunkW5qGvWTns9V8d/zzpU6XF8+eUbUKHeLcAhXaH2dg4uoF2jPKTOeTiqltsKMF/1PJSDMQieI+/ZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714094676; c=relaxed/simple;
	bh=Itx0yXPcj6JT4FRoj2WykAooUqnzpUUVPQ07Z7qUrI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jVOvUT9wCjp7DJi8Y0G70k8cGrUHzdPwolFEDiDct9Nh+qP0v+djbRPIEVSapYMy8Rt6BFJSFyjM8kAQnWHsvxTUIbhbaexEvh3vaAMhM+byCTfcR8+8fUfyLv/uszFkfFl2fLOiBSwvqvjGJfutX6aOXFre+THerObFdR/K//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=B2MevCAf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso1472017b3a.2
        for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 18:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714094674; x=1714699474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPmMI5xgMUW3sbiVqM7WG7BhjtO5f68c9xpa9VaPLRo=;
        b=B2MevCAf+IV3eiZkpbOCVsNS+BShHP3RBvvzAWO7ZeDRbzTqwn6Th1uxGZqOuyL9Zb
         yk7n+XWIy0GUR0qmsbD9ttL1vOCkdWgFF9+au9emtR3zWMLzd2f4PHvbbI2RgqCOD+Vg
         v9MdWoAd1edV7dXbxqqIBdXj2dUUXUjGaJXmDVTvXGfwCZwUD9Rgp5nUhauCDMW9vPlR
         9z6Dzzuq1OgPS95e0f5TRpH+2sYlfj0oHZLY6LnqJTyt1NkGVlDNnREVfJgluEazmhbW
         UMkjGRfM3y0PiPi0d+DU02BUn7PjWHbTOSQ70hBuXRm2YkSA3v2ngBpsCTUuHrzkZLkF
         XJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714094674; x=1714699474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPmMI5xgMUW3sbiVqM7WG7BhjtO5f68c9xpa9VaPLRo=;
        b=f3vb3XQBpe0VmG50KN74b307pVvTVhL2Z5dsb1p+gLhXBXtdcP3o+DTiGjyw1oBi4d
         tf448GDOndnsxdt+SqRYieMQsiuW2xaBB+uRhuikrpDMAnELBc9igdQGiKAQD12EDVtW
         gq6AQImj/S2GyzI2ZbE2OYfgpaBTLpExSv5TZEdCsQKzIqF0huPtbb/cGdFM8GiLIOM2
         YkUwqo4RUlqksgdYBudzDcaymozNzF/pqgss6V4MwpOXUcaaWeiA6SX7aaaoEDTq+3tA
         hlVyOjea61j97h/QxRnwIFd/c8TDcJwg8KGytjCfvYr+k/ZZXlzr9IV0s1X/HHwwHwH0
         /X0w==
X-Forwarded-Encrypted: i=1; AJvYcCXyQJVK8mlAUjc1Lwy0JaqcD7awd4VCRBPAxoX1TlxykXBkPm+kM0J4GuDCshNuCxVKJpgNeh27GbJrRdvLikIwVHMD+thownkV
X-Gm-Message-State: AOJu0YxD8F+gbemBOU41AFwMNuB8qqNMsKMO80rhLRzHjfsTSopYsf4N
	XIxYGL3lWtX/a93Coj2Ewjdde4APh7Clpsff3ufNlR6+GeRR26XmXAsUDrgpJHs=
X-Google-Smtp-Source: AGHT+IHmuERcpLua4dtmvB6rwiATxB+WN5ONxq86RoozsM7H/k9MotlC/y6I8BMnjyviQRWo6SlUsA==
X-Received: by 2002:a05:6a21:7885:b0:1a9:6c18:7e96 with SMTP id bf5-20020a056a21788500b001a96c187e96mr1813700pzc.19.1714094673946;
        Thu, 25 Apr 2024 18:24:33 -0700 (PDT)
Received: from ASUSLaptop-X513EAN.. ([2804:14c:81:903a:9968:e871:2529:9bcd])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090a930800b002a513cc466esm15294305pjo.45.2024.04.25.18.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 18:24:33 -0700 (PDT)
From: Gustavo <ogustavo@usp.br>
X-Google-Original-From: Gustavo <gustavenrique01@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: Gustavo <gustavenrique01@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bruna Lopes <brunaafl@usp.br>
Subject: [PATCH 3/3] iio: adc: ad799x: Prefer to use octal permission instead of symbolic
Date: Thu, 25 Apr 2024 22:23:13 -0300
Message-Id: <20240426012313.2295067-4-gustavenrique01@gmail.com>
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

Octal permissions are preferred over the symbolics ones
for readbility.

Co-developed-by: Bruna Lopes <brunaafl@usp.br>
Signed-off-by: Bruna Lopes <brunaafl@usp.br>
Signed-off-by: Gustavo <gustavenrique01@gmail.com>
---
 drivers/iio/adc/ad799x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 9a12e562c259..0f0dcd9ca6b6 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -524,7 +524,7 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_SAMP_FREQ(0644,
 			      ad799x_read_frequency,
 			      ad799x_write_frequency);
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("15625 7812 3906 1953 976 488 244 0");
-- 
2.34.1



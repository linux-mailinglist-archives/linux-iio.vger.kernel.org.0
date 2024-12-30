Return-Path: <linux-iio+bounces-13861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EEF9FE774
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 16:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7277918826AA
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 15:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2437C1A9B42;
	Mon, 30 Dec 2024 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jT6blImR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AB3CA5A
	for <linux-iio@vger.kernel.org>; Mon, 30 Dec 2024 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735571453; cv=none; b=HD90ZzOGxaiyHU6Yzrb8gn23pMf3MxHu8Sj9oZ5ptRL40UzFc0HFaeX6BOY4tY5Cqd8SbxC2lbA51v50KrJc5lv6vpY4jg7dAVO+jCN2YGVaAqU9/2+rW3TJWkdKejq48GPRvHAArr94rnXTBGah7NNrV3AVMKNHcQtRCmE1XqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735571453; c=relaxed/simple;
	bh=FJccU05E7i7GxRaHf1K1SMvrvoSCjZARM6SEF0kGCKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hcm/4+zVihqqVlCg5YqizBaasrzPQaZ4Gi3KuvoDAkqjCAbq885TEtKWZtW7Fd5Wryg38x4nToBv2hz/1Dvx22GcFmG6TJWcdjjZuKORL3oAFtOrMaDFd9Im2EXp1DMO1zTnl76ZfM4tpyfid8zdv0E9zMi6D9KnDyRqCF7A2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jT6blImR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa67f31a858so1647416066b.2
        for <linux-iio@vger.kernel.org>; Mon, 30 Dec 2024 07:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1735571449; x=1736176249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2e1iJ0/fxf/SfE2fA7SvbCnXGAsJhrupsxTeToRmRfU=;
        b=jT6blImRhnfwIi78TBC2kH1OSKdRuNiydy8LFRK5GQidtW35x8p9VJHCJFm0nm0SJM
         pgOdoUVcAo6MuPZn2X4QGyTXF6b4b3wpflkdJO9nPWSydp9YpjkuUAKwq/N7rqgsmEAW
         +OafIwyvJOUKi0+0s3linjyNNebtJs31Dxsxaz6MC6dSZvoEnquCgFL7uE3ZkxpfCeQl
         phyQKsRDHM4q6G6TBYGEO6XHvU8XDaDb3rL1+Peyk5QY0FVr9oj0T50aGo9dHZ9jyA2P
         D773+3Wec+6YlOFQwaxArJxBokkGc0N3mfM/jufrOxftBBa5CCBlVOaoYnXn2cNqXlwH
         vhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735571449; x=1736176249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2e1iJ0/fxf/SfE2fA7SvbCnXGAsJhrupsxTeToRmRfU=;
        b=CHKlpx8ZxgOtnXZPnSeJQlI+l9mAzLZc0+V/OPb4v2cSLHyW/r6d5NVve2eyu+3U9c
         CEQXbLRztQRyUm/Jockq5LhMXC1RCTXu6ESwypOse5gyR/mJpM+ERepu5SE3ftz8cpvd
         0vRt10grZT6bBDAeO9Ngv4MQ89H/ofA3hjOqez/37CGyCstHZXsrVfKTJiG2PmsjClDA
         7S/7oGZtIeGwW3hMwqv21Fzc6B+Y0FFO6fLeNQF6u7iTso0mce0MKFTn6yNx71tn+SqL
         slQBvykxpoO7ydVqDw3LcrLly/iYNacqn7mIAlQAacZnLe1j776tGxUE+hs3tRdd9Jvs
         ydzA==
X-Gm-Message-State: AOJu0YyU2Dsj5d8yi4ycn8Igo7jlc9XuO6OGhYgSCz9bWXgypRMg5Tox
	6OQNVSxwV18wkw7jN3/Yr0MDKRLR5jDVIU2RQHYOgHm15flB9KGmD0ahmnAlzi4=
X-Gm-Gg: ASbGncs9LBC3Nswe5waBkYtZx2HfFFIDH2zx+cRBL8Ci2sMa+L38mWyV12cBSVPVFek
	PrrqmR/G7UPNSG2L0nw8Dr2UxKenBGR9mecNtWmYOIFE83Iycxs7eQEHRLQfda92R6PXQCJTG7v
	LWEfVRACZPfWVHLkdSjdU9GABC8RpdqSkzYMVDQPoGsRkdwlVnTyEhMmqDgwCePSu6uDMDSCpWe
	GtWaLjCsFdizABEn3DzeGOVdiRuNLA83UyaN9dmTwZjIWgP9B48EdC5mgimjPzx7YBREnIEQ0K6
	jVDacMaTaA==
X-Google-Smtp-Source: AGHT+IHew4CJN0csZzahKfwMmDqwbjbRDcZCDujiy5MozzQ6P0Wd8G2TSTWGshy73DowkRi0FAPtMA==
X-Received: by 2002:a17:906:9c8f:b0:aae:d199:6eae with SMTP id a640c23a62f3a-aaed1998ef7mr2265316366b.14.1735571449556;
        Mon, 30 Dec 2024 07:10:49 -0800 (PST)
Received: from localhost (p50915bc6.dip0.t-ipconnect.de. [80.145.91.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f05ee5esm1478159466b.171.2024.12.30.07.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 07:10:49 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	"Michael Hennerich" <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	"Jonathan Cameron" <jic23@kernel.org>,
	"David Lechner" <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ad7625: Add ending newlines to error messages
Date: Mon, 30 Dec 2024 16:10:31 +0100
Message-ID: <20241230151030.3207529-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=FJccU05E7i7GxRaHf1K1SMvrvoSCjZARM6SEF0kGCKM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBncrfnf6KtYCCEp+Nh6ySiQaNyTfXJ1k33aj+Kb Tkr6JRzmw+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ3K35wAKCRCPgPtYfRL+ TudMB/4vQUiNFQdhWKsyzC5NLS1Z/6o1ZeNtaEFG/AzVcXXVEtJ1TYFeDyVQi84UHM20NMr+zhG ZTAiCVmxP4HjxayWTAG0GfIFp5T7uvNc22sF6qf8uQaJPOofsvxLGv6BBCuCwqrRjBosDX9QinZ aZJnmw14DPrk+4QkisQaWCyt1dgfmZ1tZqK8L6rNGeEIn+e5onnotssaaF3D6IV4XzNwuPpKhtm c23b9p+dfRWN3mCScPbvNLO21l3lYvgstR4pI8V3SNSJ3ws3Z3O6NLQoNmKBjAkpP9ApcVFX9XS b204jE4KC/ItDrrdrdycMrDNXxEOfMmq7Jxacuit9QzI0+Ur
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Error messages passed to dev_err_probe() are supposed to end in "\n".
Fix accordingly.

Fixes: b7ffd0fa65e9 ("iio: adc: ad7625: add driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7625.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
index aefe3bf75c91..afa9bf4ddf3c 100644
--- a/drivers/iio/adc/ad7625.c
+++ b/drivers/iio/adc/ad7625.c
@@ -477,12 +477,12 @@ static int devm_ad7625_pwm_get(struct device *dev,
 	ref_clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(ref_clk))
 		return dev_err_probe(dev, PTR_ERR(ref_clk),
-				     "failed to get ref_clk");
+				     "failed to get ref_clk\n");
 
 	ref_clk_rate_hz = clk_get_rate(ref_clk);
 	if (!ref_clk_rate_hz)
 		return dev_err_probe(dev, -EINVAL,
-				     "failed to get ref_clk rate");
+				     "failed to get ref_clk rate\n");
 
 	st->ref_clk_rate_hz = ref_clk_rate_hz;
 
@@ -533,7 +533,7 @@ static int devm_ad7625_regulator_setup(struct device *dev,
 
 	if (!st->info->has_internal_vref && !st->have_refin && !ref_mv)
 		return dev_err_probe(dev, -EINVAL,
-				     "Need either REFIN or REF");
+				     "Need either REFIN or REF\n");
 
 	if (st->have_refin && ref_mv)
 		return dev_err_probe(dev, -EINVAL,
@@ -623,7 +623,7 @@ static int ad7625_probe(struct platform_device *pdev)
 	st->back = devm_iio_backend_get(dev, NULL);
 	if (IS_ERR(st->back))
 		return dev_err_probe(dev, PTR_ERR(st->back),
-				     "failed to get IIO backend");
+				     "failed to get IIO backend\n");
 
 	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
 	if (ret)

base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
-- 
2.45.2



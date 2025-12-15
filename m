Return-Path: <linux-iio+bounces-27105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBCBCBF7D3
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 20:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEE26303976F
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 19:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D811632695C;
	Mon, 15 Dec 2025 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft9+9rtL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0621327790
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825712; cv=none; b=gHGwXegebCqbb41CllAI0tQA1VevY8UfUlRbvzTv4jHgb+64FlKU/28vKBwYzDDVW6JKIsRukpSp6cbU6m6AUR9XTJ2hRFeIQ5l0q3kn0MBhHvxRJw4wUuj4zbARuFOJIBcQWywwgSoovw6bVtG59NA1j4M+PLVYMwE9jGf5CUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825712; c=relaxed/simple;
	bh=vS/v29iFzL6WULN07adkLqiszjwNtmW5Rxtes2iEe1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vD1Ktl4LklRmxxCJWgM7mv8zkmHoa8qaYWdR7L5Ds+S20+m+iwUzIXQ19cjtd8PdifJlAWyUI6OOR31WCDGy+RJ2wJxFFLdu83Mz2iZKMmhVAVHUPGzKMrH8ocO4uS2CWuAmhcPhTUMYPsaY4kyQXYSPFdnSk5w+H4tGXwBIUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft9+9rtL; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c21417781so2900577a91.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 11:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765825708; x=1766430508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L76XOBtvdR9M9Iidb1SoJnTo7w17wFiPv8tlX/4sAsU=;
        b=Ft9+9rtL0UUha1eYiC4JQF7lIH5Zzr+S5vKbYSKRr5Zzy3NjrLkTZlhIim2H+aGfUP
         iNN1WH/eCEZYux5fo0+pmANs/yJ2uzg6OrjuGO3vP5fvUQh+IaHVsWRyf7g2YDYnyiC9
         L+agA0TKc+ut9KyRnFfeewo2JI59PVCSIEMFPraaTtA0sy6QHOOJ+RfwK+ZRV5/Z14Au
         Q976R7J7rgVjGPxRxld4+5M1Wz+hufTVlC6IOfJ3+Ab0i4kz4JAdSehMr1dLePUiU7DG
         +6cuL1aTBQUIFpGnqhukkHFtAfsC93EYPfEhZZKr/YOEd8Tr8jiw/Zx+zjR393q0brVZ
         56qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765825708; x=1766430508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L76XOBtvdR9M9Iidb1SoJnTo7w17wFiPv8tlX/4sAsU=;
        b=PbtjBjVx462+9ixiAiNHSBJO+bH6voasZkK+pNfqQBnCM3GDxKU9e2sLd9bYpW9rYK
         M0qGiKtqB6wd+tKlFa48g/8811kPOCRcWg3YdHsb/BXB4xN3tMr2llnHxvusRRoVJ25N
         SR6Z/WixdlfOO7oHflrQ67zDDyFAUTalsQOMbnXXOpvN/FssQqaUuXxgmQ9cJsRP8Ujk
         kxGKHnJMNZ0xZE3uBU2WhO4msQqEu99oGyZxskltER89rGlPgDtPYLUq7lDHq4Tq4dEV
         BqwYuMQXv0mlGOrFg/lr+vDAmwqtYbBoFR5Uu4B0pJ4rGWN5fzPqW7Vqx2iSbRVXv5wj
         WR3A==
X-Forwarded-Encrypted: i=1; AJvYcCVrty2V2fXgqmI18Gl4bRxFF9vwCQqarNqxFKhXfXeWQJ0sDZNG851CaFDzoIUwBbQbn5gN36hWlfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrGWwrQBK2uLzKx0NexWkmCAQgGt31JsP9ChxVhi9RPUyzhlkg
	fG3ywPk/h9fEEmv/exXXvOaso2I2WyaurU3Mo9+01exHzZXvancrA6GxoIX1RNeL1MQ=
X-Gm-Gg: AY/fxX55aOcLJw3ag69LVd84MJFnbaPeBCLXzWx0+0N4+pioxJXV7TEAff/dJRKuAKO
	pyf08nn721bzUuE4fL7nSXvfLRml67RKWl0FnaW8ZCVPCe0a0wF8vSuMBg+PhGqDFBpuKfHW+XT
	ot1SAO4LgcpS5P59wpmhTFGAhu7KVTOdYRfKkWCAMOafSReKjqKP0El6ZPzvSA1ETjSwMosj5+g
	pejMXPeVsFYjSraP7prhIdG9AYRUBNNku+H6Uc8aYyDjS9j7HuZSRck56GzTgRp4v09ZQ7SjtfX
	KQyLV1D+TzJ9Hk3xRrX8Y8JLJe4HueP0y7Lj8AN+7ibIMFRSGVTKb4PGM4JQTbQ9rMjTGATmKi1
	yxFPQAEXbAdrICq0UVlxoQ27rE0bY8uNBncOWtZKlSevH8Nn5YE9xNuGfnITpZGGedgjB2wHcPW
	NQMpQ5pW4/lVxVKtuAyolx53mib9hiPH+hCU/0D0mjB2vXuopFCu0SOcrIHQkedQRdahJdviE0S
	rGK3EsdWjrtlSjK7xSKJof2i9K2CH4yGQt+1ITX/8V8xsTFH9rkwBljIhuDH1briK+yPIyiR2m+
	WJKHykE=
X-Google-Smtp-Source: AGHT+IE/tsK8aQMr688+Yiaxf7J8IPD9qNC2gqGPcezAhy4Ufwlp7yHvw7TlDSAf47nxJxWdHYGkMQ==
X-Received: by 2002:a17:90b:4c90:b0:341:8b2b:43c with SMTP id 98e67ed59e1d1-34abd75ba34mr11917429a91.18.1765825708181;
        Mon, 15 Dec 2025 11:08:28 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe2948d1sm9958875a91.9.2025.12.15.11.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 11:08:27 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [PATCH 3/5] staging: iio: ad9832: cleanup dev_err_probe()
Date: Mon, 15 Dec 2025 16:08:04 -0300
Message-ID: <20251215190806.11003-4-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215190806.11003-1-tomasborquez13@gmail.com>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup dev_err_probe() by keeping messages consistent and adding
error message for clock acquisition failure.

Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index f9ef3aede4..8d04f1b44f 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -302,15 +302,15 @@ static int ad9832_probe(struct spi_device *spi)
 
 	ret = devm_regulator_get_enable(&spi->dev, "avdd");
 	if (ret)
-		return dev_err_probe(&spi->dev, ret, "failed to enable specified AVDD voltage\n");
+		return dev_err_probe(&spi->dev, ret, "failed to enable AVDD supply\n");
 
 	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
 	if (ret)
-		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVDD supply\n");
+		return dev_err_probe(&spi->dev, ret, "failed to enable DVDD supply\n");
 
 	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
 	if (IS_ERR(st->mclk))
-		return PTR_ERR(st->mclk);
+		return dev_err_probe(&spi->dev, PTR_ERR(st->mclk), "failed to enable MCLK\n");
 
 	st->spi = spi;
 	mutex_init(&st->lock);
-- 
2.43.0



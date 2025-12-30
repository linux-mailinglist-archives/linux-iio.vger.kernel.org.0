Return-Path: <linux-iio+bounces-27424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4437ACEA9DE
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 21:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B03FC30060DA
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 20:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507451C4A24;
	Tue, 30 Dec 2025 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epw2/IAC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C517292B44
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126930; cv=none; b=BhP+3pVLV9NmvyGqjgMblQNSnmuHfNyWgBKIJDN/esJb1EiVe7RuvwtmfdgMOVpToBTbhrEc2nxcJo9nyHQqsVrDUgK7GPupkbiJFZNpsboblTKVdyHXuxhKet2xSe9BGRCCttgDUw0KlFQU98vBz18fpZMFoqgDYvmzAbdohlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126930; c=relaxed/simple;
	bh=UAGRpfY4KwT+V4v61wxdidc8gTTnzFLqaP44Mz50hz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5A4Ajj1VbUugkJ/xqF7LZ2oaJdeEMOY+3PhPoBwZvXa5b5eFNEi73mX80UbcNFKk/jXcvGkdGIxQJF6tJUDYZQyt4Lu3xay24eLHYxDJbvUZLubYjfNItZ5tc9v9d2xElx1UId4vOCfzZ+WMmUgiq43rrn4BLbfz56mfEsFtn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epw2/IAC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0ac29fca1so87050625ad.2
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 12:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767126928; x=1767731728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNqW8ND68Qn1BInNnrDeX5W9wJC6ZSLjSp3dk9M7GPQ=;
        b=epw2/IACFFedkNyPfGJPyZNXKxnln9SIt1aIRK2KAC8gK3FfVl8R/ugXyCou82JeJD
         cxYJ6wyV0WNoX7R0gVQ/tB+IJPNEKJgjGRtozOS1bD+s05+UakNfvxtTGoiY5RFd3lko
         dHj8dpoEc0/zVJD0addMPTzESLa19wzBxsAIzNY9/IpBpxXxE0wVl2Z+8YGQRk2rOt07
         Dp9POIACFWiWC313GZJ5hwFbUlNhbJe5GNh6Er6jWH8og/pqrg3AvaTjMY+MXxjIT3ao
         dpmYu9W+DLCKGz6a92/H9NzNRIvfjrwwz1Q2PsUkLfzdncY+hqyhfZmvavvctRbJJ4is
         BJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767126928; x=1767731728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xNqW8ND68Qn1BInNnrDeX5W9wJC6ZSLjSp3dk9M7GPQ=;
        b=lMtR5YBlFnCEGnavvJNGmjSEDe7hLIGKq1FpNu7cnrcSH9wT72Ts+Ur4V8MVTFPoPi
         Q3axOuhUpsaDNP3v2gNBCUDi9nwlBmT4GSP01+nhoCHXUP3yGRyTjnNxFGtL5njtkZmI
         LC+cXPJkMoLuxouRf2d8cu2VZsOxMHGUK/ZhH8FKPKl76/vI04GCAv/h5XuVA9VIPB9R
         ursE2D7EhKflm9iTen6v0GG0/ojebkKgiP0zMEYGmp0tAJchDGTsIQ0uFwPk9BOV+e/2
         DegW7mkJZg0dSeQpbAJc+gzrIwkv6tkaSqMhgCx8Snb9MqS/Oue23qBc2QG0Ri1aGONA
         6j5g==
X-Forwarded-Encrypted: i=1; AJvYcCW2Isbuh8uejHy+IUrKCpVM5PEDqSp4hYp/V0umu+98TQpZLUEtcniLEMSFQozlAEsx2g/v94Bl5nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLiVuGuyg4tZoRsqP59P9CXhTMP3cze7ClDAjtp7WV0JELmclu
	f8y72sl8EGX5m/qa1003vLrgoa8KMV2Bp13fm+tKmaXWvLfeVw+plrGfaWPdZQ==
X-Gm-Gg: AY/fxX4dCCvv6+ss3kXTSC/UfvNriD+mN96T5AkxEJt5krd426Kwwt+kCPzwnA84fVJ
	j4P/6DsSMu4G6uSAkWOaUMmsyC8gNNeg8+P0tZINtMwIvRkoZqxeIIPxGZcvsWTT1HdyVuYuNB4
	d3I0jZ2T182cznYyXyE4zjYd7xijgwszF5Aar6f/irTQ/nZONTrHt9ZHA4STjErAJwqo82BWmsL
	ft9IV8EFot0+uM6ICFip+tDDUeLKClabOcPVmRMUCnNi7BsITxy4aPOeW3SNv6eX2Ju+KnKa1DR
	Ba7KHLT92uiM4Q25Xxs78U66WQWf9W+vNG3mHVJ3vqHaLH91G9QqWxcVLlFqiZiKaZnzJdakGDN
	ABxBq3GJGuH2k+HuH2Ng68DawznEc86MAhWIbf7mNICAXgcA+hI8aSeXmGL80tmqQ53Poo9RZF1
	9btVbrO1oTnVZK5RC6siU9nVnTRZPCK3sZVAAx+oIkcEmr+CSjk8nQH2C2iiz4K/2ycTMJc2Jfo
	OOlgGYYFaR8YFZ7a86E3yi8hBe0tH7g1fXHLtEPA5KFCpjoYGHmTbSHMlkM/IAJKErz2/0W
X-Google-Smtp-Source: AGHT+IEsKIgPV4K9v9BN3J2QnbXkkuZD29ZOjL2Cv8OdoAPvO3VG4YohYWZFBlHHTexO8jnbyNRtjg==
X-Received: by 2002:a05:7022:92a:b0:119:e55a:9c03 with SMTP id a92af1059eb24-121722dd671mr36870001c88.31.1767126927887;
        Tue, 30 Dec 2025 12:35:27 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.75])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c23csm128074981c88.9.2025.12.30.12.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 12:35:27 -0800 (PST)
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
Subject: [PATCH v2 1/6] staging: iio: ad9832: cleanup dev_err_probe()
Date: Tue, 30 Dec 2025 17:34:54 -0300
Message-ID: <20251230203459.28935-2-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230203459.28935-1-tomasborquez13@gmail.com>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
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
 drivers/staging/iio/frequency/ad9832.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index b87ea1781b27..a5523e2210bf 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -293,27 +293,28 @@ static const struct iio_info ad9832_info = {
 
 static int ad9832_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct ad9832_state *st;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 
-	ret = devm_regulator_get_enable(&spi->dev, "avdd");
+	ret = devm_regulator_get_enable(dev, "avdd");
 	if (ret)
-		return dev_err_probe(&spi->dev, ret, "failed to enable specified AVDD voltage\n");
+		return dev_err_probe(dev, ret, "failed to enable AVDD supply\n");
 
-	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
+	ret = devm_regulator_get_enable(dev, "dvdd");
 	if (ret)
-		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVDD supply\n");
+		return dev_err_probe(dev, ret, "failed to enable DVDD supply\n");
 
-	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
+	st->mclk = devm_clk_get_enabled(dev, "mclk");
 	if (IS_ERR(st->mclk))
-		return PTR_ERR(st->mclk);
+		return dev_err_probe(dev, PTR_ERR(st->mclk), "failed to enable MCLK\n");
 
 	st->spi = spi;
 	mutex_init(&st->lock);
-- 
2.43.0



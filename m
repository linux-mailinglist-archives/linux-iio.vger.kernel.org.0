Return-Path: <linux-iio+bounces-13169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0819E7753
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 18:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA5B2884EF
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D186D1F3D5B;
	Fri,  6 Dec 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LfBEeWqz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1E2206AA
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506156; cv=none; b=X6NJPr/91wahwZPaU9PPg8ZBxKBioUX5syGPBprDrvJTikUunPgHsc2IMLZ31ru9zBngffTOGSvVZYlHiWPTMPk6uqkzutvcTrH6cbkfI2lG3F147UiNiUvGX9k38hagjN5jvXLlmgg5EvMW/j+rSqfQBqIhZl5TANt8N3uNSd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506156; c=relaxed/simple;
	bh=zn8zvV9Mo4O2rpc8Z3avU2Iyc7Z00tacRFBEl6WqSmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2TRCsY5hg7EuEc5CaMNZqh4YbUeHLPlty86B9c8vZGS4ucj2NjHe8z/pbUSYKoY04IAgBCPcMqQbP4/asIMC+fJDyFEN8e3qxeJE2ZehHWxTcTb6+PftcxQiTETBE8sJEr8/iCIizQ7hu8ZeiawTfFtp+Ky5LnKNTaNq2WF7XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LfBEeWqz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e3621518so1709693f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 09:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733506153; x=1734110953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoPQYGtC/ppQEZ9aVkh2TLcv9C9qeXCGvY95zPdobik=;
        b=LfBEeWqzIqhDRQS55O8Gi1fefhFjpSpRzr/TMoiNxgSXav0XcI/2uvH9MVFzqjvKaQ
         axayA2Of7AJcGnXmOCZN+rrAP8StoPWJLxJhnD3z/rhs8LMNv5hwiptQ+z4viyJ3+faa
         FbyGD6JRlNDHMOSxxPbn+YOOoGuYJFxIMxMOiRti1o9Vl+tPfm31frEkaUtpUf7xltAw
         9mrcyN/+uYciNOX/bhtS28GCbwCyNO6XQr/gObFssGfNPKVzKBlCGWFhWxyVoqlWRBcG
         KHFM1oxUY2cO98rNmcdKsbqihUbIFAdOEUxbrfkIYDsWLHicNh/5vcXkpAkWbck53gAR
         +TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733506153; x=1734110953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoPQYGtC/ppQEZ9aVkh2TLcv9C9qeXCGvY95zPdobik=;
        b=bF1MnhN9PbTSKo+ocBfRjiaHwc8jHui7ZEZuDF1rpfqStLEY/bUn9QhHGohlBq9gid
         0gAABsgMTYe6EJRYneX84dsAQEmG8kFqKkrMFoU7lRn3/0hPsg0h6sDh/S5gTICxwUEq
         qFMheiyYTmxAIIbL/ce8zEYs9Mmp2673CU5ftYrv5cXbr1Rln5ZxzZn2xTpbDhPGvce4
         YsEZK0lqFqWmGhC2IH0KvgcSfiMNWIzJybRp0ySR3kdu75x/TYq1sAsqNHa7QuZFNcwg
         JKJ/evUE57hzLvp07ztoPQ7Xc+yhfH8stAG5rd5Gl/TQ5RbQ/Hcf1zEIbaaNGpnjRI4z
         DLjA==
X-Forwarded-Encrypted: i=1; AJvYcCWt9H9Nv8IxHJ1o0UlMdD5dqtJ8C9HizuXgbE9vmke1DvCqImeyO1kvxnMK6OUvbzPLk98cPYkrl/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYLgiBgW35Oz+BvUWX6BYaOdW/YJBldoLP6Ig+tnq1wbthlkAO
	o+1TdKCj52IJ7T+pLYofYcgsgUSJmjOcvlX0t37YPW7NRF1dzTp4j68o4GMHLFo=
X-Gm-Gg: ASbGncu/Nab802o+r9TfnO83IMBIQ9aQIZdCFK0NehpSb6sBtrYEdM1bocaKjC2l32Q
	J6GIpcfMSCadom99Q9oPg3CX1PVoGuTq8lLbOam0PZocWF9aW+tPZEpZRPBygPe/9e6nowLq1H1
	fKxv0RH8Gdx9BaQILmn7eMcMANxOmBOw7w6rIIRBM54ajMNlAUZNECzQoPP57LK0qMvDz8u4keT
	AIkl5QlQj4CytSxTaa2xUySpsnpInh+y14jWKV8a1YhnBizAby/O548ZWwB+Dw1Px61r91orIdC
	ucei
X-Google-Smtp-Source: AGHT+IHd4es1eZBOSw2eEfghY4/vXUkZsgHKgQq1U0xhJFuShgFPcSf1RU0stw1GBxgadbpoBIGY6A==
X-Received: by 2002:a05:6000:2c6:b0:385:e055:a294 with SMTP id ffacd0b85a97d-3862b3e6686mr3201300f8f.59.1733506152702;
        Fri, 06 Dec 2024 09:29:12 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861d0f75b4sm5173815f8f.0.2024.12.06.09.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:29:12 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v6 01/10] iio: adc: ad7124: Don't create more channels than the driver can handle
Date: Fri,  6 Dec 2024 18:28:33 +0100
Message-ID:  <1b9a5a1d334e5501294f7f9f9d5893f1cdf1b0ec.1733504533.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=zn8zvV9Mo4O2rpc8Z3avU2Iyc7Z00tacRFBEl6WqSmQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnUzREwrfxrPn7/gyxJ6Ho77bnj3fw7lhluAKdc jf0pS0kSeGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ1M0RAAKCRCPgPtYfRL+ TvSDB/902QBn4cFJm37Cm52C+RXIivFD2cDnWUPasBDpmCXM/VMWtRJ4ZIhKWyEiVePK1aX7FV8 7ukskMh1kiXJnqmaCaU28wcw0UloCjidZ0yfrf3q+XvKp5c4neMdtxN9OPehebLx5fohRNuLIbf c1AjpFgvBprCHb4TKqdayMz74d2+i7HfmPCW2Z3vmOpjad7YoBNCkB2dA7oMHgzseA01nScasod vWnZlrUYeX8wSyOycazmbFWTxkzCZ4TnnXtd1cydFhU6QKThV2E5SSqTv2iF7iPtybBUk3dTzW0 /iAxfTYdQ3grQ9VTLMW2GAfgQbO4lDVdFB7rZxNKZAkSJ2tz
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The ad7124-4 and ad7124-8 both support 16 channel registers and assigns
each channel defined in dt statically such a register. While the driver
could be a bit more clever about this, it currently isn't and specifying
more than 16 channels yields broken behaviour. So just refuse to bind in
this situation.

Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 8d94bc2b1cac..5352b26bb391 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -821,6 +821,16 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 	if (!st->num_channels)
 		return dev_err_probe(dev, -ENODEV, "no channel children\n");
 
+	/*
+	 * The driver assigns each logical channel defined in the device tree
+	 * statically one channel register. So only accept 16 such logical
+	 * channels to not treat CONFIG_0 (i.e. the register following
+	 * CHANNEL_15) as an additional channel register. The driver could be
+	 * improved to lift this limitation.
+	 */
+	if (st->num_channels > AD7124_MAX_CHANNELS)
+		return dev_err_probe(dev, -EINVAL, "Too many channels defined\n");
+
 	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
 			    sizeof(*chan), GFP_KERNEL);
 	if (!chan)
-- 
2.45.2



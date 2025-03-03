Return-Path: <linux-iio+bounces-16276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04768A4BF40
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3B618883A7
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AD920E032;
	Mon,  3 Mar 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CCyBrL8e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B8820DD6E
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002474; cv=none; b=idcFffo/QHbsPxEnJMYMzcNY2kB3KRdL4uhzG3Z3ONJYF/c8zgOUh1RqVxrpkxyIcWWKpfpa3RxXb8k9QG3DWpqoS2QNSTuBDEy/aUPuNsB7wkrJaNENigpaX59UFPSJ+HE7nEIlOPkvUjUGIG77EsyAr6f9Jc3//809upakDVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002474; c=relaxed/simple;
	bh=+v+ir1+IglYL05L7kQ/+NcMJ+uc5Mh8VNYIDLO2zj4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=As3l1vOkEngnlTYeO49s9FtKFpZI9ZzsEjTso3ooGdGPyrvRh5VW6kCedTUVKMqGQsgew5M4apOeaqEnidfsCN0E5kvpareFXPQYMcMVcSXyM+RS3q4Cw610tvGSZ8ioaEvi2ekeR8ykVGYeJ8bfZiNFrGznAeOJOQbI+jM6Uvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CCyBrL8e; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390cf7458f5so4050350f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 03:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741002471; x=1741607271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKR8mmc7je6VNvAt7e6XfCwJ0Xm9s9LiP8WsU315nXs=;
        b=CCyBrL8eeJVwtW/vo7tWcTm446qekFDbvRoK1W3Pmqxv3iA5H/UdB3hF6EQit9gGwh
         v9qV1HvcIGe8093vqFQZ7pe583JvPwx1uBhHLNigNoJdRAoZDVUoYG7aZ7u1Hs4HqGcL
         5KMOMD169w3jkX45AIUarv/Z/j4Lun0gybflb1G7OxCePmO48nc9dt7fLfp5XdYwTIJA
         MXtf5CM/XmKlwWEyjWaiRv6vNOh/HCsOXMJcLy2Alf1tj2mzV6icIEU+DOimXJLm9RD9
         yRn3lsSl39E6iPrwmGupqJ42Xe18sRgiK682EedLV/HOp1w2sZuVaCNbQbXUvTnXjOSc
         X0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002471; x=1741607271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKR8mmc7je6VNvAt7e6XfCwJ0Xm9s9LiP8WsU315nXs=;
        b=ifCAAnoVPWHueIf7mV3axgicoZ8ivrY4P0F8ewOeT7TwiBf/Ie46lwtGo7VjGlJvb9
         y56Z2fJWU5mhLH73yXXBzesi6cDBnZebhKJ0aS+HVsEWI2VsZ/y9OnNyi4N15grdEf/C
         AHjDFZLzfcgH4A02h3jPvajdVTk3eTZdvRCj4jUAG4Qwu8TT2yk/DR4R2OAso2P0l9CD
         MMtQY4qA645Njn+J2HagtLrE1NkALyZrgOHLEHByBjbmCTxbFZvBeMgqStHv4ysUyxSi
         rJziUUFd5PXErrLiMQh6yYgVula68hbpSYyKtWtPYU9GJhSOgFzDAeUocV41fNyGhKpN
         n5kw==
X-Forwarded-Encrypted: i=1; AJvYcCU4rkFIiRkr7VsR8/CZebR2gkLCVoAERcoaz2Tfw2fph1eyfd4mRwh1iqsGIhyd2+Kf5i01oS/d2Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6udO5Arc1bt65bZtxrH+BZ0k6qDgGmaQuhnaLbrZegEZuzn5
	gzf1zVRxsaE4HCb0/MK6bUSNW2T2ZWno6ax+VMbX/6tpQA8D5FNfp8PYOt5orDhQ7H2MI5jjY2d
	pT4I=
X-Gm-Gg: ASbGnctSIQ3OfanmxRRZ77bpOrPVuv6euv1jCYwO+vkSiUEsj+Rc5EMICEk7VqKN3dE
	Jyspanxau0oSt3vPYdDVAWTnY7gkjmVA6Q0obnTAiWSexGIC2dAvzEDo1WST/gr8DwS1pPye9KL
	xwX+7zFa1KycXVMNSeRachZIUcWn8cX/GhpsKJeijZOFHEK+sieTeIJbEAgmVr4EOPprUwYjZys
	uR2FMUyhArqDhMsR7YFek+l5CS17x3r+caYz2mUZp/j6FH88eXUPnK45M3EGxqQh6Z5DwsRi/8w
	jzle89f980Gcvyd3/kxs+D6hxE9bztV94NpZRTrXzynLe7lgyjjzlipBtdX9/eKyfRpYBIyIniN
	EkEa/EY6dCk/kWZmI9OK+iTvEqQ==
X-Google-Smtp-Source: AGHT+IH5Z6btw41ZKAgQDipPHeM1p1kYa1+Z7ciGYHSk4HbVAIZ7A2f2vv2fwdCwPPHx3p4Q1j+Vww==
X-Received: by 2002:a5d:424b:0:b0:390:e46f:4454 with SMTP id ffacd0b85a97d-390ec9cbfbfmr10067180f8f.32.1741002471263;
        Mon, 03 Mar 2025 03:47:51 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a66adsm14110736f8f.25.2025.03.03.03.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:47:50 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Michael Walle <michael@walle.cc>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] iio: adc: ad_sigma_delta: Add error checking for ad_sigma_delta_set_channel()
Date: Mon,  3 Mar 2025 12:47:04 +0100
Message-ID: <20250303114659.1672695-16-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
References: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=+v+ir1+IglYL05L7kQ/+NcMJ+uc5Mh8VNYIDLO2zj4c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnxZbLpSyJJZQrMNOYSBT3O10ZES5srubfMKd/z Hdc8npRu1aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8WWywAKCRCPgPtYfRL+ TlsjB/wOYCnOMHsdZ0Q3jdrrQBdxHsZXk7f919eqxPaLXjMVofd/123J4vpuLOwaXwaC9W2fjs/ qEW9uVGxoJPU2pXSI/NOnW/tSiqvlVvvF0nKn8Vs8PGs4fACQy+R5WifPK8o/JDCKXnVex6BTOQ NOLo01eR/oiOROTYDKSkx1PKWUW1/efx/ARiHTLKT8bXBKRp0AGXj4nrn1ia98dXJj28h3t7D00 hkX1dnHsPcX5OjWBizSl7SxPa5dXzMQAe11k+Hsa8iu2l58v0J2FCYjmCuCXnxL75xv57fvrK1b 3mRa4JdY9akWMDP7YnNdyNbQyCL286ODl8Ga9ub/dpnFZRT8
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

All other calls to ad_sigma_delta_set_channel() in ad_sigma_delta.c
check the return value afterwards. Do it for all calls.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d91a3ba127e3..6c37f8e21120 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -390,7 +390,9 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
 
-	ad_sigma_delta_set_channel(sigma_delta, chan->address);
+	ret = ad_sigma_delta_set_channel(sigma_delta, chan->address);
+	if (ret)
+		goto out_release;
 
 	spi_bus_lock(sigma_delta->spi->controller);
 	sigma_delta->bus_locked = true;
@@ -431,6 +433,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	sigma_delta->keep_cs_asserted = false;
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
+out_release:
 	iio_device_release_direct(indio_dev);
 
 	if (ret)
-- 
2.47.1



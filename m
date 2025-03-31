Return-Path: <linux-iio+bounces-17404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71172A760CF
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 10:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CDE3A6E2F
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD461D514B;
	Mon, 31 Mar 2025 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NynBNqyd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F21C5F14;
	Mon, 31 Mar 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408219; cv=none; b=EACSx/X5E4n+SYGd6gt3ViBChHp6kAHwsQFhP3zEzZUXxSOpL09PrYex4VnBUQOZk0xg0F6GtKjRMcBdbsiK8CpaZTfl1cGPjDR9NuBl8XNsn7tamoQBjxdU9MZsbQjqsd9+Ze81GnEkPtf5U0XHD8X5M3BvgUQRt5jMngFxBl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408219; c=relaxed/simple;
	bh=vPLcAHUFB/W8vUQ0O/h5XTwfrYfKvwqd7Yqhi3LbMM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5ICstYM09oiYHLhSoMJhnC/pt1scvzGsPRMIUg0Yqiq/1ubBYwVA6nd0EGAdYLeW3EAzNyh44smCH67Q0kbL4qRcR7NyE5OWZG02bsTRkPklQH8d9kFuPgtJSqeofTWgn/At2qVikNEKH/4oaOBdV95ImxX7TNlmMBFFNU4mqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NynBNqyd; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bee278c2aso54739561fa.0;
        Mon, 31 Mar 2025 01:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743408215; x=1744013015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwo7tfDZNT3AYMbBSLZWUiCTgvCkdshfK2riMmfE1NE=;
        b=NynBNqydu85w7B8CpiSrkWZUQqCBQWkrTOG4yoYdvLyxoUB/Sht7TWq9OxVR4Da/FR
         IKAiEjkgxI5uLjzLQDTlRSB5WZ0tW89M4rpZ+0yHpZhhZltoDDuvr37SyIOFF6rDRNU6
         GaW5Kr6TvIXIaNpzf7CcaLlg/9P5wVuBnK/Z50Hwl76FejQ1uD9ecBla9JrPmJtSnUds
         kLIGfLPqPKVU/RYHmGj9ItVu0BGTR8sZKo8klSiOsZacnjuiFNiW5fwO+L8VggTejjMb
         F2iD2GsZusmmLGw/EPM8u2VC/k3f/xf5jepsWsdBCQDs8jD3Jmgq930n1wbOuZdizqBa
         /MZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408215; x=1744013015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwo7tfDZNT3AYMbBSLZWUiCTgvCkdshfK2riMmfE1NE=;
        b=fBFJVy+zADIDfvLNy2U82QUTdDyTgD+m1I6E0+EkmY9R2MVZ6fMhN1a9VIKBw/YlNX
         PLNyh8l0FL1pFnC94joV9pnxyYXm4G7wPiE8jymI8mBn1dcvsO7xOvEgPLFesNiyXzMi
         bw5WXcUR8/nWsfRU/s/QhaxY2Hz33+BUh4W45kloPcrtQ7LzpbTziX69ZPZ6f6GRrkQI
         nZK5Lh7NzyPNimkJwdnvjx0vEkzRIaH+gCpKwjSGGVRY8a5xxtFAw7ZqZu6/CZ3gKQ9B
         ywisKLWvEHhkCI//G6rBRjBwByNE7yw4+WWap7vLwl0E1QUUTJJyhrDvpTzx8oR5fsfE
         Cmyg==
X-Forwarded-Encrypted: i=1; AJvYcCU4L4aYRYTyJH7YtNEKKWur7MSU2skFjor5LKYcahvU9A/zKwuaQhdlS9KVofcGaAlaucfKW+THHcnJ@vger.kernel.org, AJvYcCWKpCcocfjAhpYlG4AFvc6MON9qRa3VWlZv/C0ddVGn8NSrweZljnu4xP0jKVpYqpSk/G8A5ktopvDnIsMk@vger.kernel.org, AJvYcCXAqn+00ZoV7uSIWH24sbWwqEdZGxpwN828IFpk+noKDmgMijDhdJDBvarG+6R6bALKaakHIp35jJqH@vger.kernel.org
X-Gm-Message-State: AOJu0YzpbZ9SNHKZUbyDKFrLzOwRVNJxda9Xnd69Sm+J/17iR3zW1kmc
	gt6gOlc29ItAJ7QWHTacNwTEJjWvgBsZeKENL1rd4yexbOHbRlab
X-Gm-Gg: ASbGncvhLE5SKwSVPezEcmceYx5WsvOelXmKDDxVUMtyfNWY1EDv2iSSxCBkDXYyUAi
	IXLyVrRzXPNe9B8UhM5XeIHbO/XQlde5q2dlz1FDKanQrGZbVIZyvBQic2IL20EXbYuYZYhBY9/
	uDD7bKTB7lFBaEwMz8GJRsU2ypCSRRXiLd++0BF/xwWGtNzrjSHidsu+wPNDfjNjqVNSHSWHl/o
	JKT1Er4o6pxgxQBZjeuXReU9bzCnZfvC5fXybrC5dJUMVjytglkCoQlcDylHSdguYgT1fKmlxej
	Yi9c9lakixSmlhSdDeg7k+5glcJvfCDdfa6j0uFLOx+qsHF5qhY=
X-Google-Smtp-Source: AGHT+IHYHFjZZP8AMNvyTFh6meA7qyYXTvouLqGv4ObEBH2TFgcYbMTH/RRpicmy1avAEDusMMF82w==
X-Received: by 2002:a05:651c:550:b0:309:20da:6188 with SMTP id 38308e7fff4ca-30ddf7a5fbemr27376041fa.6.1743408215214;
        Mon, 31 Mar 2025 01:03:35 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2b4cd28sm13484401fa.70.2025.03.31.01.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:03:34 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:03:30 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] iio: adc: ti-adc128s052: Use devm_mutex_init()
Message-ID: <c424b2c234fb82faf40a7832dc410e0178a3a8fd.1742474322.git.mazziesaccount@gmail.com>
References: <cover.1742474322.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jJ0SL7Q6tGP96Ffe"
Content-Disposition: inline
In-Reply-To: <cover.1742474322.git.mazziesaccount@gmail.com>


--jJ0SL7Q6tGP96Ffe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Quoting Jonathan:
"Whilst it doesn't bring huge advantage, now we have devm_mutex_init()
it seems reasonable to use it and maybe catch a use after free for the
lock"

Switch to use devm_mutex_init() while working on this file.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/adc/ti-adc128s052.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index dd1e405bf172..90b23c68daea 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -172,7 +172,7 @@ static int adc128_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
=20
-	mutex_init(&adc->lock);
+	devm_mutex_init(&spi->dev, &adc->lock);
=20
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
--=20
2.48.1


--jJ0SL7Q6tGP96Ffe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfqTFIACgkQeFA3/03a
ocW9Egf/cRL37ztfS9WdofOAeG8bfu5j0Go7o95/yrrfIOerGwKcs8uW24h3nKNB
fJairztJV43dRRdT1+C7W+zX5efuHf+aiXCfoIWP3CCjT/mPCWJA2FjhJzmtFRpU
nhZafDGvpW55GPQQ4IRmpmcm0ZHT6nUrd1BLbjL4Wmtb7LJHi+UYi+B3xVH+uTta
OnNFcYUObGGBh9QPvgw0ZeHugPxKnokqH1ytElNi6BNTHTPPMpo2EhP+efEAJpG6
JwQuI3YVBw3Gkh0pvEHMOSdZ+kqpH0lA89F2yK2G0OpZO8/hrsJeIxuSCIvshpPY
hvkncZOiaWW7wEtrN9OZWwAqIVMtQA==
=Jn34
-----END PGP SIGNATURE-----

--jJ0SL7Q6tGP96Ffe--


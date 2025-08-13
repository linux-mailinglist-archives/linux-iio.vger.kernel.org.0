Return-Path: <linux-iio+bounces-22648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78917B24519
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 11:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C2A177F1F
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863D2EFD9F;
	Wed, 13 Aug 2025 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3wofiyS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B31A9F94;
	Wed, 13 Aug 2025 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076581; cv=none; b=SLMRsjI7Fcg9KovLm00KynkQKA3hYmV+xNqM8VA8n5PlisxPJCrz2KC1VhQ0QS0jMlPocwZAZ9dpAusfTiMtey+5nmt+TJoxMfbbBjsQ9rvfE9nkgNm/5UBAOGk4PZpGiW+fibtFA59Cq0Tjh9RtID9HvvgTmAVs9tNJaXibklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076581; c=relaxed/simple;
	bh=F39zDA7nOTvNVqAZkmcQePxxokk3Ju+xnSyr2fLJBns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P3CN25X/0BnqHQ2bo7xGwjn1910DZWsF/HDtbUu0wUHTLj/dDZhKbWA0a4MFlE+xowl+4WAkv+T/Ds+8VxmueICAXZGUYpw15wLHtWS3tJKcGew2NyUoGZIhMqNfs/yQHJD5nWsyWVsuuVRAaibnhQxno5LvMJ1wl4IsIV8KGVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3wofiyS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55cb8ab1010so6438977e87.1;
        Wed, 13 Aug 2025 02:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755076578; x=1755681378; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fHenvKdm0XlJ0qMDu0g9fGeQieCcfVRkZfzmaedut9s=;
        b=d3wofiySW7e8bXRvRGTuB9jN8L91yBoIue2l52GxW9/bzdlTLR7kbKJWYy14ZKqK6D
         wQZjJEZ3ubmnXu6TJfa0jTnY5BNxrGzA8YXcEP4sPC1bZDodvWSz1viPEM6b8uDsnUTA
         X1YPuh/qgY1xYfgodBIHUweBpv+Hqa5LXm3ENJK6RftNIniJHw8X9fjgVmInIwhbScPh
         59it3y6ofz61CJ8TDJ47csVk/H2otXb9Cfl2FX1B8wbP0qXG5Y83t/ygco+nkJpbWfVQ
         TtH8/Xcpvhc4VYP5B5mkweRBsQZKZC0c0+ZtNCwQUG+K469PdkN7gLvgwbGhLXuknHGW
         KNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755076578; x=1755681378;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHenvKdm0XlJ0qMDu0g9fGeQieCcfVRkZfzmaedut9s=;
        b=TI1dBK+e/O6NsysyN4Yy/07yuIKz2/7BRwkQnT395auaD7lvFzxV6FWQQV8f+BjV5X
         GEhwRGnThSQser/zodmwBtGVuVhwLyoYbEYInxIYhgJRgb3Eeh/TsvIlY4tEjRPsUHtk
         T4U6VhZxfhOjyNUVu2hv0FuwMlP3MtSZlQCNL7RcerA5ll7pTnX+rItuGUBiXD50Yc1g
         bNzlfj6hiTBRAFiTweajhWPdLT+N7d9fmOvpm7nV0TakXrUmsaY2Ep08Wr4iklBYAWHO
         6J0DT26Rs5DBd1W3Gbj4MOK6ZBIWK1WtoLTW6PGjZhQQcuXoU3wFCzCUZ2Hny69W91NK
         02WA==
X-Forwarded-Encrypted: i=1; AJvYcCUp6jfNPLnm4CYdICEqB2gJGHG5e3vxv9bOcKeXmFpsNZw57lZfnHMlsvxY41XbrFSjZKoZi2Zdu/wbFnn+@vger.kernel.org, AJvYcCVjehT0sxW5EKXE3el8JZQB6q5jHhkm4JjQT3NaaZr0VM9qxlUIII7RLAePCXeXeuShNRsrTkW3g5wB@vger.kernel.org, AJvYcCXBovj8+J8w1p2PE7AemFA/lqGbLdWl+82+wf/n+oXsgKE//YHhaCAnoyU385ltwengDUDjC5rsSv+X@vger.kernel.org
X-Gm-Message-State: AOJu0YyAlsCZQf7SZnBQePsoM6tuKwZ7dLjgRj8X3sp6+QKAUh503i7G
	qMifSkFs/5tJgFqC/xvCmXYam0DpjLy3sipWu8hTZ5WNoPoz4zMyzP7B
X-Gm-Gg: ASbGncse7p76L371z34bx5jApVZb21VpjsaKHeQAt2PxrdGJG9ekvNcnkfGgdDpbmIq
	Dd7tmp0tbEZskWh1mUwaYDkVHvqY/R8oLk8ejcJL8sWHM/YOYirSNof2sM8E+PwJvng+iRS+eII
	JaYeK6V299c0raLMTDYgEfDvrQBg/oX0o+FFDJZdGyQV9UvbbuUASEClFnzud+KLdWYXFB1t2DZ
	ZX6Uo56qt/w8m5BPcnf8s8F7HSZ/uXs36d/WkvXpdAzpkVlbCBKx4jK1JbV75ubyoCFPMWSmFLa
	Ehq0OKqEsB194GmCsV/CzljufXHiynNE/RLnCw6u9QB1mQBNpKMfmHHTyV7qSonlliEVj+vzAFk
	kKBrKwElxUz4cQY9idqIMMmYxLifuWnVVBrYhjPA=
X-Google-Smtp-Source: AGHT+IGKfz9vP96Ie7xpbZJ3khaoiRw8h7lam59TWUNckN8Airi9tcAgeYhGcUSZV5GCv58k8YuQrQ==
X-Received: by 2002:a05:6512:3b2c:b0:55b:760d:c2e2 with SMTP id 2adb3069b0e04-55ce038eaefmr653659e87.19.1755076577806;
        Wed, 13 Aug 2025 02:16:17 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cae595sm5184834e87.155.2025.08.13.02.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 02:16:16 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:16:06 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: bd79124: Add GPIOLIB dependency
Message-ID: <6837249bddf358924e67566293944506206d2d62.1755076369.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jcbngrjPf9mCZaYW"
Content-Disposition: inline


--jcbngrjPf9mCZaYW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The bd79124 has ADC inputs which can be muxed to be GPIOs. The driver
supports this by registering a GPIO-chip for channels which aren't used
as ADC.

The Kconfig entry does not handle the dependency to GPIOLIB, which
causes errors:

ERROR: modpost: "devm_gpiochip_add_data_with_key" [drivers/iio/adc/rohm-bd7=
9124.ko] undefined!
ERROR: modpost: "gpiochip_get_data" [drivers/iio/adc/rohm-bd79124.ko] undef=
ined!

at linking phase if GPIOLIB is not configured to be used.

Fix this by adding dependency to the GPIOLIB.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508131533.5sSkq80B-lkp@int=
el.com/
Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

I am somewhat curious why the failure occurs only at the linking phase?
Wouldn't it either be better to have these functions
devm_gpiochip_add_data_with_key() and gpiochip_get_data() only declared
when the CONFIG_GPIOLIB is y/m, to get errors already during
compilation, or provide stubs?
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6de2abad0197..24f2572c487e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1300,7 +1300,7 @@ config RN5T618_ADC
=20
 config ROHM_BD79124
 	tristate "Rohm BD79124 ADC driver"
-	depends on I2C
+	depends on I2C && GPIOLIB
 	select REGMAP_I2C
 	select IIO_ADC_HELPER
 	help
--=20
2.50.1


--jcbngrjPf9mCZaYW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmicV9MACgkQeFA3/03a
ocXb+Af+NIGlMnF50TrH0tWe5+RTbHSUKhqoO3EOSceKHXvL8xmEQfYVUYHTPmN1
M4zS5DiZfnafHjKyDbdvpHqI+/xdNi+flOx4+RDKl+DZF1OKQ6bYqCwUEb3oU/Kd
wihjuo+VYiQQY9T0fE7DXgselJ1eybci2UhxpqAgfEL2pSspWD/ETiONObr6pw1l
4mYJ90AkKBgoIpcqajUqEhr8OQPbyiHdUn9g8YohCq0b/q4g2Ew/eGdxpVqpIWwU
xQBd/2eiWSXHaWQVk1J1EJS/aVa1B61Ve8p34BQPDlEEhBgq34hOxmhumbdST/lI
opJuDq/4+UcH2DYNN97yUacBaWWI5A==
=Pm2h
-----END PGP SIGNATURE-----

--jcbngrjPf9mCZaYW--


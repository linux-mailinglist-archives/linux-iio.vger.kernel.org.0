Return-Path: <linux-iio+bounces-22434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD1B1E4E1
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 10:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4D57280CB
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE96426B0B3;
	Fri,  8 Aug 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWWKtVuO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B1267B9B;
	Fri,  8 Aug 2025 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643141; cv=none; b=fiDY1FCZznqzh+0Q69VOSd8vwc7IsQQW3YK57XoLomc9/Q50fBw7bC556j8zSOrDH590FgwDeAjos2BzVOtLVG+iwyLJbVdTLAe5wZmy1LYHF1fv8OT73ZEuVSrUTk5PUqh5+rX3Ov0IwoJ5jCRN63C+NFQcRmGTikA043Qq3IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643141; c=relaxed/simple;
	bh=2V7r0S/y7Yn3reyhMQjQ8huU2c0mD0XSjXPz7VuLEVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ5/GegNCumHHACpN+9FdCaCnn1kLVB06Y6BUZlfcudQwHz1wLXQdh1twFU0n6r8z6YSjlx/8tlLU0QeUFcpaJQoxPiCO6vowEfXcv0dGkWxd5i4/JijrUAtTws3qt4sWA7yWr8kQlZ6oDuF2ti8M+qIDokvg8iEEPqXviyCQ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWWKtVuO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-332426c78a2so14813161fa.2;
        Fri, 08 Aug 2025 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643138; x=1755247938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqqybCS+yNNjnY1vade3b4Z5g0zX8h8grApDt19rVXE=;
        b=KWWKtVuOzfeVhvz52PfxTCyDx3jOH9dFXulIs63kQbdX3/B8zOmDpvVYzpv3SgT3h/
         GoPMHOiojm7QcRS/PlFRGSo7ukHW0XFqHdzhwx6FI/+PiS1btrPvrEGWbWmSf8p+0zhV
         96l531Bz8lHxAMifizF31R2WLZ2CfoyiuT/5d35vBXtzw92GdPcTEkrouChHZ1fT6JXw
         xEYHtRQSA58/vDSYGA1V4GtZPcuoDNw9709WrLIC6HN8+GU1h/xoImnWFfuRsXjqqr8y
         3cka+7lATtKHJMHzz/bHQg058Hf/l942AImk8z8MP2uhe64cky3R5rZE0ayss7zF2OGq
         hHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643138; x=1755247938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqqybCS+yNNjnY1vade3b4Z5g0zX8h8grApDt19rVXE=;
        b=i8Z4iGNc71lF4pVbvxSflphBJ2vcGQwz1FfnZD+y6FQFK+uAKhZFDUyyms9aczwi6Z
         SL524XS1+TmE7dVQyTkA7L8UJa258Q85uSqze9grVGkcdT3ecchJXTAD3BZ/2YwoK0lR
         cNEe9oTF/X81nWNL6ZpGHpggjm07Tjq+ZaNIBgxyBtamUk3wB2MJWGxORPLm/6FcBjEY
         XVOgfmta1TEBJ+flq4WCApPqYczEGX8xD7w7tK81w8qEesN/j2IgNblNSOmvY+J2KNLl
         axrfrfW4Rbur9BmUGZA5R9e41VLK7BOissKgmKHSB2bzXQuafh3CEed+VBRAKZRDSan2
         PxUw==
X-Forwarded-Encrypted: i=1; AJvYcCVpwidu/yGH9S6Qvqhjo3bwNUCRvY5JB4IT62dZn13PmxrvCBcsudcrcB8x2/9UOJEUbLqbFafzAXWQn8HR@vger.kernel.org, AJvYcCW+QlFSdIpSKLdbyg5n5dB7vcNc7MeEuc/HVIs/ZoYSc+WvAbC0nImVNMYSddFNUTMTOapv84QRLRoE@vger.kernel.org, AJvYcCWM1rmSCjuw04Y2nXqIcpbMZVi+5pY140j/WBcNxiFA3hAlQ+m3+cdZUI8T48owKSvfh4ilV9qXSqnT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlnvd9yyzgjVTts+vS763289s/On686jTFCjzqCQwbHNjsBbyv
	As022dhjxRJYLfx/0Gn+xnDn2JvNkh7pGSTcBIToHDu0FswdWWjBKhA0
X-Gm-Gg: ASbGncv0dY9boxA6zuJ9o75k6v1KceVLPTS5Txo50DqqyMQ0A7cSpIDc47pNF5ur4KS
	Of7yFnCLuAKF4De3yoGygyJlAmwxFoXDI8KURoHX71FbUuKmzmuOKo2mQHMTzrltC+mx9O3RIO/
	ByoixOhwDBlVUxAHhw02Hfug5V/9TMNLoJ8n+MQ6bOxIqCUUEXmwWLKx5CAn1mm4oJ1ACfcWAP7
	da3gKEztwyUKVHYZneqVf1u1JfXdovwHXAcdyU+WqOZTO1S+QuKIeNZrNMTcxKr1mJA1d5Z0Wyx
	eqCEturaG1FX34Rr56Ahydk+Okdx1h6z1TsO66d+MT9mM98ekbnNL06Q5wzrTxYFCf962ngUaDn
	L27+UGMoO7Jen5Wx29dUyxyP2mBzb
X-Google-Smtp-Source: AGHT+IG9sOAPfAkQX+6RML35fUUokX08NVm/JmPUhkRV1bRAEf9SgmB/9YYav7nfc9PhlTWM52AtLg==
X-Received: by 2002:a2e:742:0:b0:32a:77a3:8781 with SMTP id 38308e7fff4ca-333a225f9eamr4822761fa.30.1754643137963;
        Fri, 08 Aug 2025 01:52:17 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238911615sm28143851fa.72.2025.08.08.01.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:52:17 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:52:13 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/10] iio: adc: ad7476: use *_cansleep GPIO APIs
Message-ID: <d6a8f19e26ffaa97da32317a9601147a11a82622.1754641960.git.mazziesaccount@gmail.com>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LhvDpW6zAb6SfMi9"
Content-Disposition: inline
In-Reply-To: <cover.1754641960.git.mazziesaccount@gmail.com>


--LhvDpW6zAb6SfMi9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 driver supports ADCs which require a GPIO pin to be used to
start conversion. The GPIO line status seems to be always toggled from
a process context, either from the user-initiated "raw-read conversion",
or from a threaded IRQ handler. Furthermore, these ICs are connected via
SPI bus, which is usually implemented in a way that the access to the
device can sleep. The GPIO here is toggled from the same context which
is reading the results over SPI.

Thus it seems very likely these GPIOs are toggled from a context which
can sleep.

Swap the gpiod_set_value() to gpiod_set_value_cansleep() accordinlgy.

Suggested-by: Nuno S=E1 <noname.nuno@gmail.com>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v2 =3D> v3:
 - New patch
---
 drivers/iio/adc/ad7476.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index fc701267358e..1445f0f599d9 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -57,9 +57,9 @@ static void ad7091_convst(struct ad7476_state *st)
 	if (!st->convst_gpio)
 		return;
=20
-	gpiod_set_value(st->convst_gpio, 0);
+	gpiod_set_value_cansleep(st->convst_gpio, 0);
 	udelay(1); /* CONVST pulse width: 10 ns min */
-	gpiod_set_value(st->convst_gpio, 1);
+	gpiod_set_value_cansleep(st->convst_gpio, 1);
 	udelay(1); /* Conversion time: 650 ns max */
 }
=20
--=20
2.50.1


--LhvDpW6zAb6SfMi9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiVur0ACgkQeFA3/03a
ocUXfggAzAND4GqFGEp3idk05Gg6jT1aQ35536iPv10DIMSBio3AhNKGA1FYDJVL
5GIkLbDH2+7Wfb+Xdkb+UaU5pmffqJqmVNGz1PtQOj3o/YZAHXAZdKIKlQ8J8NLL
jnlTF39J059Q7XZW4ajOM53T3fqdsoF0zrL8FRNpPmcZNp9or5Do5VNyyNDyfAQa
Z7EqQu6NHI59t01OApXtJRVxSxEs1bt7efLo9D2kl+6fwStJ3n+3KplT3B/QnLlL
vOaB5J/P1yaE6YXaLS28Jv94ztPv3fB4ZWzLfKGN1uM9azSa85AIQ65EgoZitIOE
IkX0qSKTeZX7GCbmJUG15If7mTwzUA==
=uqj9
-----END PGP SIGNATURE-----

--LhvDpW6zAb6SfMi9--


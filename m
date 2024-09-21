Return-Path: <linux-iio+bounces-9687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FE297DC4D
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2024 11:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3E01F21E85
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2024 09:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CD7155759;
	Sat, 21 Sep 2024 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XaZKm2dB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA4B15445B
	for <linux-iio@vger.kernel.org>; Sat, 21 Sep 2024 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726909899; cv=none; b=Osg+QrFk/GehHD4mbyPmDte3I9J/GpnVzgFcw0Y47RUJvikU8uo1lQRActDpCQVqxm/Pt2s8eYyvZGCA0XOUaTWaJ8Cr8nuItw2FucGHmw6AWAGNyhprVZr0L6L5UPW3RrNniTS0uH0E6Vy21k9s0IEYWUBbyNvkiaIn/r2TVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726909899; c=relaxed/simple;
	bh=LpJePFkpOCrmRcm2bsO+S0TBF/81jncGa0BOoDbOWMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bY/aKgCLm5B9BEeWCn7/X04qrP0AsTAPdc40xG/jCmI/zXtJu7KgUTE/8Cq2FJoBO9P8+3eb88Bpj0sBKSnLyKCLLs/Wd0X/2JJURqMwpjutVZAr3kti0bs5rhno5fClg/b27+OU8yfRkUZZ7YYeGaZUcMG4AFN/6Xlln7JWs7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XaZKm2dB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3787e067230so2057222f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Sep 2024 02:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726909894; x=1727514694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+92qmWOWTsTas7qxFq00TXpzuJdYrOV4QtxxZMwe1U=;
        b=XaZKm2dBv5HUY4/EEmQCJIUGMHQ4CeVCcMeCBRv/7r4dGPocjvRrDllm+9khqqlfiN
         U1b44TufL6gh+wBAUyt5YA+oyVoaDGogH1kt3EJrS4nZoZ/ew/yFq4roBLEbeeWyJbxT
         pvL763sYKqQ46woOOhQKtdPhFHmA7xlpE9EB8Y2GDCjbxbcn5Fa/Uqnp8EwkTx3KvbvG
         oK2KiQ864VjeXm3XQ55y87bxb7q2uATZFTTI5dJvm33I5b5bkJPGe3g4MGRTERhUfI04
         lTahfcj81KqD8lKZX8+EpW6mTSKesBEVfCvxq+VYrIsh5svyTQDnvXezX7G2zzEnh27U
         bOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726909894; x=1727514694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+92qmWOWTsTas7qxFq00TXpzuJdYrOV4QtxxZMwe1U=;
        b=AGlyZVSWsNJjAC+VOjmKRMtwrvU4OI9LvVQM0dDDIa56wzb/p3TBA9t5Yq8YjMhCNQ
         Rg58s+uTJ1i6HoKUVZkYg5mXXEQF/G2V7l9UxCMxG3Oo8vLJo+DOy5CocfvieqVl4hbr
         ye8NM9ZiWk5PCHB4U8ZmVNsEX9AxZQabno+JQp02RKkZxi6d+0gUE2M8NP1Gf6NNfI76
         XWA6JzZjWyHD4HxRR8ktm2ybvnULjntwZN43pPUElsoEzbxKYgjQh7fJUcI3AJ/Rlfoa
         MTzIXOimP6wYvOzizZJrLD1iw95PJWFRcwwjxvu4Tyfi75xAV4rcOwlkF9HoK/crJqiR
         1ckA==
X-Forwarded-Encrypted: i=1; AJvYcCX0/S2s8zXZfROPRhRmZ7gGwOvIZOwlXC537oIyIC7N3KvE+n/XvGVqPQJS6fWmvM0+Uefcbi4SsMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmp24YH3Hm+Pb2yD+8Rn0tigMLPvHvvt2J92TSHKV58y7yzdL
	oqrCeQWNdGpmtBAfRWBeUUPIzDpZEUzx0Gao1xZyjnwCSf9iDDrZTGzMQGcKiyk=
X-Google-Smtp-Source: AGHT+IFV5E3ga/jxa4eXGMk8POq04Bbel4E3r0fgnVOV8eR2jCM6IsYm+TrLRuBiPpwnTwd1oYZTXw==
X-Received: by 2002:adf:fcc6:0:b0:374:caf6:ca2f with SMTP id ffacd0b85a97d-37a4318a753mr2912540f8f.45.1726909893833;
        Sat, 21 Sep 2024 02:11:33 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:a0b5:bea5:b768:cc22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78044dfsm19461798f8f.94.2024.09.21.02.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 02:11:33 -0700 (PDT)
Date: Sat, 21 Sep 2024 11:11:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michal Marek <mmarek@suse.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com
Subject: Re: [PATCH v2 01/10] dt-bindings: iio: adc: ad7606: Set the correct
 polarity
Message-ID: <7mk56pxpgnlu637xo7yypzfdienyh3doch3l3fkinpqbwihf33@nu7v35gdw5zn>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
 <20240920-ad7606_add_iio_backend_support-v2-1-0e78782ae7d0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fon5yzoippkxiyy4"
Content-Disposition: inline
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-1-0e78782ae7d0@baylibre.com>


--fon5yzoippkxiyy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Guillaume,

On Fri, Sep 20, 2024 at 05:33:21PM +0000, Guillaume Stols wrote:
> According to the datasheet, "Data is clocked in from SDI on the falling
> edge of SCLK, while data is clocked out on DOUTA on the rising edge of
> SCLK".
> Also, even if not stated textually in the datasheet, it is made clear on
> the diagrams that sclk idles at high.
>=20
> So the documentation is erroneously stating that spi-cpha is required, and
> the example is erroneously setting both spi-cpol and spi-cpha.

I would expect that the communication with the chip is at least
unreliable if not outright broken with the wrong polarity. So maybe add
something like:

	On $MyMachine dropping the spi-cpha property reduces IO errors / fixes
	measurement readout / improves somehow differently.

to the commit log?

> Fixes: 416f882c3b40 ("dt-bindings: iio: adc: Migrate AD7606 documentation=
 to yaml")
> Fixes: 6e33a125df66 ("dt-bindings: iio: adc: Add docs for AD7606 ADC")
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>

The empty line between Fixes and S-o-b is unusual. Assuming you resend
anyway, please drop it.

> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 69408cae3db9..75334a033539 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -29,8 +29,6 @@ properties:
>    reg:
>      maxItems: 1
> =20
> -  spi-cpha: true
> -
>    spi-cpol: true
> =20
>    avcc-supply: true
> @@ -117,7 +115,7 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - spi-cpha
> +  - spi-cpol

Adding cpol seems unrelated to this patch. (And you remove it again in
patch #2.)

>    - avcc-supply
>    - vdrive-supply
>    - interrupts

Best regards
Uwe

--fon5yzoippkxiyy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbujbUACgkQj4D7WH0S
/k5zDwf/UzSdDFwznnAQVwNU4Up1WB/17Sc+fFsZK7NmAl7vGDK+ucYNoVFnLlpj
8rnZS4oVghQvHP4XVec0RdAN6IUraFrp65HErNSk1w/ggR/AyjQ+tkksGzWzpcQu
NOm257ZP6D5f8CaSqw3C2z613vDtCLthp4Fnhr96EGM0d4Dz8CEB0/Afd5r8Axda
r0nMXbg1xGlhoOnEUxKSOJHTtiFlyVx1nke+odinSs26zkmlY+suaeoTSDIQTw9d
dFO+w2ICYF0qoTrDK2hOiIeW6pfUzkcmbAEhgXHTgWXvxnaMpxJtLUy7KqaAyIkE
TehREFAYgFWvNzKEpIz/Ny6tGNbp7A==
=LDVO
-----END PGP SIGNATURE-----

--fon5yzoippkxiyy4--


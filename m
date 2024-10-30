Return-Path: <linux-iio+bounces-11597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8509B5DD5
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 09:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1916EB21265
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2731E1051;
	Wed, 30 Oct 2024 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q0A+LHSk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFC1E0E0C
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276889; cv=none; b=fNmZqrXvCgBPa9467tmjBiSAJ5Z9MG5/Z5P5PFJtTbzHaE/JkRa81SG6r1ik93xxrJ8PaMsFxOUCWe7PjVEp/nj/evzIyJmsgwnmuiUbAjE6fplXACOoqDsZs3GyjDOL6Qa9ycVfXsuMsUXCT7YQuEd4fD3I5ra84zDa3+fKJ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276889; c=relaxed/simple;
	bh=2EJQviS+R0eeRdt1aLK6bINveA2q82bII4Ab8JdcMJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHkRPU3x4tuAlyTP5FdW60hkpdaJG2SC5320HtkAshVjFaAsAOzK72LGJ0fW3HxLgducHH4dlrcD4S3l6EcLMWe9RdDPR+eiqv6NowcQu0dfepBWifbPeMBah4dzh9/QCIL95VP3496SGuGkXxRlFC8/GMN0kJMWI8MWeUi08uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q0A+LHSk; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso56316831fa.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 01:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730276883; x=1730881683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tBYL9vmtVYAL0EFLZkcBgrxKAFI5YLz3NtbAqMnDtEY=;
        b=q0A+LHSkZgKRpQ0YsO/IS27P75R1MQGURPshorq5S1qWWvA8rWZHDqpus1rXxu8t+Q
         ZoH1aIaCWnMw0VnUOJ/qOC4U58yOWIJA+HmI5q/jpvX8nomJbXN+5nfXSq9tUptDjKC/
         vFN6jXxfNw2CRYiXPDIVED7XRY/KAR7bROaUtZbTEv8FfiNg+WXJ8fKjQ9GmIJBEcE9O
         F70G26H9Lo3UXNpmf6suiFsvUXl96R9LTM3g6+HxH5BHPVqGx4Vc+KJf7v3Av2iG0cuT
         ddRdLWBhZsB/RK8oinX7He3YRo5ApMWzKtop08GvdRPZibE8YoSjoMl/BeosAXpZsAKO
         keJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730276883; x=1730881683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBYL9vmtVYAL0EFLZkcBgrxKAFI5YLz3NtbAqMnDtEY=;
        b=eyWJMxLzrkXSSUzyHVnp3jbL08T2iFXqrOOaPgrflOoaYERcN2/Z7loe+Q2V1WAvsQ
         v9stg78vrvd1HEqf2aaCPHOYLeKdfVB7vMqBQwV4rBGR37ybf1k+u9qv2JV+eBe0U92K
         k+meTVj0GKy/tmnX+Y945ggxIILl3BqReNHsKveP/3n7v6w2l2ihEFa4XOriA7XTdfDx
         RR1QSFejBmDKRxWkEoI1StvjdNruVI+qnQq/l7AXvPGQRKXlu7mU7+XaetB7Zlb4bf6N
         QgX3wIXh/kQMHW06GJnNc6qEyW+vVpj2puOnMZiSzBL90inQryXIoILScxYMLco32pN0
         xckQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6ds79eNisbigZhP/rDmFBhL3TJB3HRa8D8Yr4tE6xWRdQDdTU337y7mmka9uj6tPJg0kaPBvSsgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIZ6X0YiNaVBaesb3JlOQTQup0utCnFNuO6aOLggJ+9L6lMC9e
	Dz1ByNq0lEDRZMtRfCbe+4RjFHNejq7jtB5KmEV4URISCylIqomWrwAOkE2vY8c=
X-Google-Smtp-Source: AGHT+IHLXshujnLj55pap6bOslh51Qbc83Y5ZvmdLqv/90zLHoTuLWDGQOvp4ELrigrr0rv56OxcoA==
X-Received: by 2002:a2e:a99b:0:b0:2fb:5bb8:7c00 with SMTP id 38308e7fff4ca-2fd058fb962mr13655171fa.2.1730276883393;
        Wed, 30 Oct 2024 01:28:03 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d5fcsm13934505e9.28.2024.10.30.01.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 01:28:03 -0700 (PDT)
Date: Wed, 30 Oct 2024 09:28:01 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Guillaume Stols <gstols@baylibre.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
Message-ID: <iajs2rk7odutqwoih4h6besd4b4nnksap6om5r7i2cw5arqcip@rvztnliokuk3>
References: <20241029-pwm-export-pwm_get_state_hw-v2-0-03ba063a3230@baylibre.com>
 <20241029-pwm-export-pwm_get_state_hw-v2-2-03ba063a3230@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n5xp3y2il3quy7aj"
Content-Disposition: inline
In-Reply-To: <20241029-pwm-export-pwm_get_state_hw-v2-2-03ba063a3230@baylibre.com>


--n5xp3y2il3quy7aj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
MIME-Version: 1.0

On Tue, Oct 29, 2024 at 04:18:50PM -0500, David Lechner wrote:
> Replace the call to pwm_get_state() with a call to pwm_get_state_hw() in
> the ad7606 driver. This allows reading the sampling_frequency attribute
> to return the rate the hardware is actually running at rather than the
> rate that was requested. These may differ when the hardware isn't
> capable of running at exactly the requested frequency.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> I went ahead and made this patch since it is trivial, but it would be
> nice to get a Tested-by from Guillaume to make sure it actually works
> as expected.
> ---
>  drivers/iio/adc/ad7606.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 8b2046baaa3e..1581eb31b8f9 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -762,11 +762,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>  		*val =3D st->oversampling;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		/*
> -		 * TODO: return the real frequency intead of the requested one once
> -		 * pwm_get_state_hw comes upstream.
> -		 */
> -		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +		ret =3D pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
> +		if (ret < 0)
> +			return ret;
>  		*val =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_state.period);
>  		return IIO_VAL_INT;
>  	}

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

There is a slight inconsistency compared to ad7606_set_sampling_freq():

ad7606_set_sampling_freq uses

	cnvst_pwm_state.period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);

=2E So if cnvst_pwm_state.period happens to be 3 ns then reading
the freq value yields 333333333, but if you feed freq=3D333333333 into
ad7606_set_sampling_freq() it sets period =3D 4.

To fix that you'd better use a plain / here in ad7606_read_raw().
(Note that with using round-closest for both there are still corner
cases, e.g. period =3D 31796 ns yields freq =3D 31450.496917851302 but
setting freq =3D 31450 yields 31796.50238473768 and so 31797.)

Best regards
Uwe

--n5xp3y2il3quy7aj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmch7g8ACgkQj4D7WH0S
/k5cyAf9ELnSckQLX02VlSjt88Fhbhbb+mCKMOBryiijJlYNtGhk+dfI5Yqyv6mf
WM50/KzHu4CqA6owAQuhfqzL4og2AiOJN3QazfHKK1Dtltll/135JgUptuwu+W5n
n9BS/HNMXCJa/TcMtHXvPbo4FgLdG1gvuXyV+/Ic5iPga+9AWTv++0PxxIENEjFK
yN/cy7bOuvrtTwCgZ/i1DTKh3h2/IDADYoxgTWtWxJ4qKLy2a6yROYBFyAR5jE7d
KsY2s855/TWYIRj0MCp6aOLSjo+sO1Eve5zjdzxz6kAilWwPe60BMScL7PTYevVL
6tL+ZU4J7tKazH3J9Y6alWU+W/OZMg==
=Gx0C
-----END PGP SIGNATURE-----

--n5xp3y2il3quy7aj--


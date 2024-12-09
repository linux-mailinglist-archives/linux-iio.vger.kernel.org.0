Return-Path: <linux-iio+bounces-13274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9359E8EB8
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 10:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999C82837BF
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5921638A;
	Mon,  9 Dec 2024 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pOuDH4FL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28004216387
	for <linux-iio@vger.kernel.org>; Mon,  9 Dec 2024 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736504; cv=none; b=mzUaa4VwW8Vbg4q0NUuljEustyxnRrhxnaENVYteC0gcqXX/4LHcwYps0xUhE28ULKPBJW922pom24xQKLV+rJLvL0O2UmAdqmxuRtns3eXkXrV42MrmU7dDhJDBvhVeWzXt8hnT6KpOAEpB+sJ85k95rCoaCUrvcea9N7pwTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736504; c=relaxed/simple;
	bh=iQo5Npvgaqz7e07PUrAKGboniYzpq/ts+XYhlKkoGyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cW3nuXTTT3BceCpy0iDqbYVTMj1CNPoeBVMlR6TQ+ccTx2Xx6gN9zfil8J87lpvqum726wmvwE3zEJ94MieawzPGWgLzBf1J2DY7cIP+iAmdlRr/jldKV2XBgYmiQc6RQEXe4pghkzsJr38vZd8HzOazsKgX27a7aa3zN4M9Uoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pOuDH4FL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38634c35129so1367372f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Dec 2024 01:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733736499; x=1734341299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKH9n1bUoPUvKLUCb2xRv7dS9GbAaGKaW4ErK1LlmGI=;
        b=pOuDH4FLMT2qgVYTphZYhwgwgJyt4jPXZ4+55lYXb7qs2A9zkJ6ZREHdEYZskC+vMp
         9XzEIfk/W1z+/cvELTuI79t0S160+4qmOgr92ZUk1stxgqQDh0waZanUgE88pFgQDWqH
         rvvg72QxYeyqnGv/NTqZ+rJvYZG8rcvKBomrM88QWD0gE3LvmhAtdXFsKhUrlwlUdhMg
         whMzqlQP966oou/gksnaPlAA6Phk3OZQkDj2p6652HMcTY80MZ5inBjs4sj2y+0igHqb
         YpR1rUcBcK6HgZXcsabA69crbz1HicBcV9AFeXukgO1ctMK0USCkZppGWz6rhKlp2RFR
         D1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733736499; x=1734341299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKH9n1bUoPUvKLUCb2xRv7dS9GbAaGKaW4ErK1LlmGI=;
        b=hsS5NVvP48hhJGSGM6aJKUoqCn7/zZN2dePpEBk4HsYXmNRbGDKx+u9/xl/CCCeQOT
         SdPSDupwqQ1F/SKkAhEbkURJ03D12BFJ4a3+MyFD5Q1V680kZQg6ZdqQwrGQtOy8lRnM
         8zlGoLY2kE86ztEGpVai4zlNEsG9wCflOQopnvwC7OqpTeAzcX+J5+1O3AbfhUSCBDjp
         i8p6ByViV+W2xS1RCWtqtj7GfOs28AIM4IFf3Vdttd+HPUm9+I/Y1lxGUnpzGxfSc6+o
         eqEwJTaSdAeLRVCwm9Ml8yxoMHVwjOXUPsErFshA7Ea/Y3C5kRDsUKX9Zsx/XIlC9ueC
         uIww==
X-Forwarded-Encrypted: i=1; AJvYcCU+GWcYeRHGeqED+G9UqLlrstwbARxobuedFuqF7yGLQX2Lgv2IZAlWaYN4GSw2Dn/UhmAMeTyIWcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykCL4DVB6tihyD3uuXm+X0PdKHsUSuN9uT6qaAJuQh0vKy5WKH
	nP+sw2zqsgx2XXQaA3ZsFYCaqVDtUltn3QQLtcbbmiWt2dOHv+JSzDE7t5qmcLw=
X-Gm-Gg: ASbGncsXXHErjv8k7AJKnuj23ABmdi0V/iJzO1iM0dhFYkTWL6q2LHu6JDitiMPqAcH
	R2qDWscRu4h0NLu4gttErLh1YgLeAA0a1nF64kSuBFDbAkp26ThxYVdaOtN4tuiLc1Jz6pkumQU
	FcxJVOyDnPk2SOiNrBWibYtM5BGdvwHgnhs/OrNwaKyNV6VWNOK47pnvJ/pUuYbXm7ANX0sk/Ez
	P+B5UGKbwoujOZqjXB065I9xYu/giqYydurL+NIo+68I/V3Rgn2E9VJgpG9TGtc5h8M1WYALHWW
	yGX3
X-Google-Smtp-Source: AGHT+IFvKhgdChBdiHTfzC26yO1WS3oWl8CiAW3XgfHPLwbwiGHSzq4ScdyEWR/SGdjubMtf2RWRVA==
X-Received: by 2002:a05:6000:717:b0:385:f6b9:e762 with SMTP id ffacd0b85a97d-3862b3e7545mr7841185f8f.36.1733736499296;
        Mon, 09 Dec 2024 01:28:19 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38637a0c6dfsm6050449f8f.93.2024.12.09.01.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:28:18 -0800 (PST)
Date: Mon, 9 Dec 2024 10:28:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Ardelean <aardelean@baylibre.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Renato Lui Geh <renatogeh@gmail.com>, Rob Herring <robh@kernel.org>, 
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v6 10/10] iio: adc: ad7124: Implement temperature
 measurement
Message-ID: <hoiksj7mar2qbegvy4du3b2pq4c23myrgmzmdc7axwl7yzcxm4@dupqkcedvjax>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
 <433211af8ac3f02dee58586ecb51d2e98246a095.1733504533.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g3pshgy4fppn3qq7"
Content-Disposition: inline
In-Reply-To: <433211af8ac3f02dee58586ecb51d2e98246a095.1733504533.git.u.kleine-koenig@baylibre.com>


--g3pshgy4fppn3qq7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 10/10] iio: adc: ad7124: Implement temperature
 measurement
MIME-Version: 1.0

Hello Jonathan,

On Fri, Dec 06, 2024 at 06:28:42PM +0100, Uwe Kleine-K=F6nig wrote:
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 9405cb579324..d858bffd2628 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> [...]
> @@ -902,6 +941,37 @@ static int ad7124_parse_channel_config(struct iio_de=
v *indio_dev,
>  		chan[channel].channel2 =3D ain[1];
>  	}
> =20
> +	if (num_channels < AD7124_MAX_CHANNELS) {
> +		st->channels[num_channels] =3D (struct ad7124_channel) {
> +			.nr =3D num_channels,
> +			.ain =3D AD7124_CHANNEL_AINP(AD7124_INPUT_TEMPSENSOR) |
> +				AD7124_CHANNEL_AINM(AD7124_INPUT_AVSS),
> +			.cfg =3D {
> +				.bipolar =3D true,
> +			},
> +		};
> +
> +		chan[num_channels] =3D (struct iio_chan_spec) {
> +			.type =3D IIO_TEMP,
> +			.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) |
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +			.scan_type =3D {
> +				/*
> +				 * You might find it strange that a bipolar
> +				 * measurement yields an unsigned value, but
> +				 * this matches the device's manual.
> +				 */
> +				.sign =3D 'u',
> +				.realbits =3D 24,
> +				.storagebits =3D 32,
> +				.endianness =3D IIO_BE,
> +			},
> +			.address =3D num_channels,
> +			.scan_index =3D num_channels,
> +		};
> +	};

The kernel build bot wailed about the ; here. Should I send a proper
patch, or can you still just rewrite your tree to drop it?

Best regards and thanks and sorry,
Uwe

--g3pshgy4fppn3qq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdWuC4ACgkQj4D7WH0S
/k6Dogf+LXyukrlsImArvDU1uIxhmM2Di21x75iqPH2BE+u3cqQ+fUj+QNC3+9J9
+xyJ4JBxMTUXmsuSIE5aXHbOY9QRAoycyjrpGkTeabp7ROe6yVpqCzfra/1QVeWB
0hVU810QUtsLlOxYBP8B42BkCUH77YAuJDVFlx0Iol+kpFeE/kVQ0HqM3eABHfdY
BvUhkqsgB6XOGmXtac7ZyQi1zaFAaO7ZOG5Sfs8uEYIJGZKNhL08CzZk9wKFJ53u
p5wExOayMEfloLT6y6dgndFXbucOEEyxSrlXd9UjoP3l+9Dmov0IZHNUk4cOP067
yhCoMrwxyT66LIPHlINKtzXB/aL4Dg==
=0sS5
-----END PGP SIGNATURE-----

--g3pshgy4fppn3qq7--


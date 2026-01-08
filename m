Return-Path: <linux-iio+bounces-27557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA762D03C3B
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 16:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 732CD304B726
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D8034FF49;
	Thu,  8 Jan 2026 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="091t2/Yv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6796823EA9D
	for <linux-iio@vger.kernel.org>; Thu,  8 Jan 2026 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881239; cv=none; b=ZFX9kOcDnVTT1cBNbUecJdk7T/dmpCQ+uxH4l9CFjF+8WpPI7k719rV6ILV7cfzAzqEzN/W+KuY/tFxCUjWgoHPvGAxA+ivppW62oqGZc/9zTsLXnyJQg9Dr9vjXTcPVPGeMPmEbc41xFCtKefptPumRUfAw3yZvXlSYy1bkkkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881239; c=relaxed/simple;
	bh=GfIhDumiTaTtgjE1NoS7th6W+rdlUjEK0cqr4kMgvj8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DUlxA5nN7isiR/mJkR9esUhd6ncKDt22RU/co0yS8lcY/IegvcaK08QxJlG8vH/crpJHWkh5dwgOt8hC1RKPiZQdmbxgCpawyTgMxu4eZuHRVzXRV8ryE4RXc5eoxn4HGmLdMed+KFfHBTcUlM7/knJVTusXGTj3IKlk81OEGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=091t2/Yv; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64fabaf9133so5692482a12.3
        for <linux-iio@vger.kernel.org>; Thu, 08 Jan 2026 06:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767881235; x=1768486035; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GfIhDumiTaTtgjE1NoS7th6W+rdlUjEK0cqr4kMgvj8=;
        b=091t2/YvnaS5QgD3fHRC8KubvlgXsY6gm3ciqowSv9ZeZMxktTKj+2pcu3XtMsAtk7
         IyfF2g0rme/LSXcXnbQWvs95OJo0urXRDvdYhcCZp6O9qQM8lGC5ozngBSXcmqeUSECX
         ZC3xTNwam7Q9GsAKzA54YH4gxmxL0wijvxYBe5ffRAudrCptGkUGn/ZizYWHnmRndxnj
         2lEK4iJGI6lYSDh9tRUaJN2yVkz5awzcyYiAanQ9nk2dbMo+38CqYwJ8rI68n+Nu0tmc
         7Xb44yNoIqipg2XGoGB9ZhmSQksEtk0FpLBI4XmkS3pKMjVv0tr1uWlk0DwAHEJ36QDB
         66/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881235; x=1768486035;
        h=mime-version:user-agent:organization:references:in-reply-to:date:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfIhDumiTaTtgjE1NoS7th6W+rdlUjEK0cqr4kMgvj8=;
        b=YaDgv4CfUKBoVwzpuBZTaPx7hQPN1ils3ZhzI/L4dXJvY5oPRfJLlcGNlV1M4N8bHQ
         pVaaLQ17kpFm1SFTZJ2Kp5DrlIODJriH8rzkKhZjYqBURKzelbM3SipPO+pJtr/jQwj6
         gcyypMvF+uFoBkkGvuEcPFAB+iik+DbpHXbLFvfeKU2ORjg7xeQOvVURTteYtAgMzWVd
         V/UBF8HuY2PQHjyBnTc59PVhUim/WOXh4maB7+n0k8An/KZqv07OQwKAV8j2sN76NToO
         vNVTjXcd63NG7mJjxST3e2luyOZub+gv0qUqqIz3pVKQTJ+D9mvtOlICv+eLpnSTZEMH
         glKw==
X-Forwarded-Encrypted: i=1; AJvYcCXSNSBXAvtc0HqiGX2ByF6975GDzA4XwqDg56LUu+/o9R3EJI0WRbY4DaW3dfROD7yD0JQ4pM1yTLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygUY+45JHSo4rfHdePxwYHJfyz/4DNzMqEOl7IhsoBQk7TbofZ
	3+4jaabGvblWhr7fWMxTWZvbfN0ZUFEFrePsfIoOzv8PMV5acz6bjIjgXgzgA4eL4B0=
X-Gm-Gg: AY/fxX6df331pGJ3TOSV+7XpNFwokRurHxuJGuEwkkFup0mJBbZBgQlYryoVXmYWKrB
	xe8AtrIgPsLWKrntT/bIptfwk9SGXdzJfVKgwqXaPyTa4uRS0gw4nXYO/pju3yz/9L2WmaD5qJ8
	yFwC1iaf+6ZsDf1K90HrrMDAl38HcN0XpDD40DWgYMH58TjPVYxUy5OaYdL0EmT5AkkMx3BD0//
	hFgG1F7cPwzatQHEndluKVPrz7lVuQEPDMBjse1HMuNTzjLXIbHN/lIJ2M2TR46pXVBP2kX5lRU
	Q785quBiYBbKt3J9lY7c3/Jg7UWhvO/s0/NvzbnHPGh6f9zjYl0GAef+ncBQDhTq53ERX9I4qgh
	0xCuMRaR8rIn+AcxwESDJ7AzFA1Ro3rPmUz3vaIZFgkox3kKzIzvdxEBOrHhbsphKsI4LcO7tZq
	Kpdyk/BemUS5/J
X-Google-Smtp-Source: AGHT+IG0EkEuOhjLyXTP0B/o0vqKuHZddyHHwLf8yXUsHkIwAObUMOKJP2iNC5VThdlElmZ0Kwn0qA==
X-Received: by 2002:a05:6402:524c:b0:647:9380:103c with SMTP id 4fb4d7f45d1cf-65097df5672mr5918312a12.13.1767881234641;
        Thu, 08 Jan 2026 06:07:14 -0800 (PST)
Received: from [10.203.83.73] ([151.19.68.242])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507be641e0sm7584777a12.22.2026.01.08.06.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:07:13 -0800 (PST)
Message-ID: <371503c267d9ded0195da126b58bc8339cb864e8.camel@baylibre.com>
Subject: Re: [PATCH 2/2] iio: accel: adxl380: Add support for 1 kHz sampling
 frequency
From: Francesco Lavra <flavra@baylibre.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>,  Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>,  linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Jan 2026 15:07:07 +0100
In-Reply-To: <5cd68e397bb45f606f59038290e4f3ac09d241da.camel@gmail.com>
References: <20260107123518.4017292-1-flavra@baylibre.com>
	 <20260107123518.4017292-3-flavra@baylibre.com>
	 <52e5cea72b99fc23c922cf74d7dce3403f43c9cd.camel@gmail.com>
	 <9a5db937dc7072d95d6757cdf2eb8d6fde4abbd0.camel@baylibre.com>
	 <5cd68e397bb45f606f59038290e4f3ac09d241da.camel@gmail.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Rb3+OvpD8SnvOKPzkrqM"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Rb3+OvpD8SnvOKPzkrqM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-01-08 at 13:45 +0000, Nuno S=C3=A1 wrote:
> On Wed, 2026-01-07 at 16:39 +0100, Francesco Lavra wrote:
> > On Wed, 2026-01-07 at 13:56 +0000, Nuno S=C3=A1 wrote:
> >=20
> > > 3. Other thing that comes to mind is if it makes sense to allow
> > > controlling odr if
> > > Activity/Inactivity detection is enabled?
> >=20
> > Disallowing odr control when activity detection is enabled could be an
> > option, but what error code should be returned if the user tries to set
> > the
> > sampling frequency value when not allowed? -EBUSY?
>=20
> I think it makes sense given the constrains on activity events. EBUSY
> would be my choice as well.
> Out of curiosity, do you know how the chip behaves if we change the odr
> with activity enabled? Is it
> just ignored?

The chip supports activity detection only when in low-power mode; changing
the odr to a value that requires exiting from low-power mode would mean
effectively disabling activity detection. The driver prevents this by
forcing low-power mode whenever detection is enabled, which means that any
odr changes by userspace do not take effect as long as detection is
enabled.

--=-Rb3+OvpD8SnvOKPzkrqM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmlfugsACgkQ7fE7c86U
Nl8eYwv+MqJw6Dhh/gpXoP9Q6tBMxn81AJDeAjBaTImGR4edL5+nMDK9SpNaDwOu
NwbzpLN+YIMFPBrzoMT1NG3MHifWDtqlCQvyerR2CnCBYtUPQz9zvRQwRQ6V6sJ9
BfPMoyTfXS0EQ6kBDnhCDv+YOvXajkt3ZmfT8UMJElX1f7c29/mX3GZGUGzzGl0y
oCpy1Yjjbr4+/OLBts6YSZrY7w8p8xzSDNBOXGicf95w8kfjEv146kfzlaHfihI2
6mx02x3YKpMlAXaNikg7b+GelIHlhw36dBw6ulNs4RNiWvwbYulMg8p7DQ+aCGys
GA5Lcmej7cZjv6h2wtZw6EsGXek1vLRun32gQK6n0MNJH0hpVHDF62EhI4pBmwiT
HWwhNc0Y5Wfvb+BV/bD/O7UpzxZZAs1+gorret8kzofj9k5Rqsrpz1PeqsbS5RBA
numHdymAFQ9ZpIihdRa3idEb/XkhsF7GbToe2gAbn2J/Z1P/0EuAa3SmiZkiiu9S
2uGxY29E
=N292
-----END PGP SIGNATURE-----

--=-Rb3+OvpD8SnvOKPzkrqM--


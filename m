Return-Path: <linux-iio+bounces-12625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C809D8428
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 12:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1899B2A385
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 11:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72661957F4;
	Mon, 25 Nov 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZK/8K1yg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5A194AD1
	for <linux-iio@vger.kernel.org>; Mon, 25 Nov 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533038; cv=none; b=RNaGzW8pnaqhuI//A62V2QYhLg7z196yGwONDrJDr59dYA+bHK9eXq/CxM+u0zJH9U6CT3wV/D+eQ9zEFyN0eXHsLsHjSKPH4kO/FDXF1vwd6Yk7RyqAHklxgoT6lcyTroirK/m0VkVYvbqDge+XBOPjTfEFON/EW84xMdZrDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533038; c=relaxed/simple;
	bh=SSsdzoEO7ae66YhRKiZJu4mT23BLdMBzS3b4caOe2ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+ZydjCvPwfeI5aYDwG5NA1x+suZJipMyl3Cqvn60pgG1yfRK8l1WzrKupi1D4t7ktgGulxP5gZ0zKpMg/Yq8ulVGRauCDAzej91DRdcTVq7VhMzoAihxN2dFwhRhTdtuB3fACsf3gtPPr2y3PHxMil+B5xDsdvYoAEFpRF0MfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZK/8K1yg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38232c6311fso2910695f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 25 Nov 2024 03:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732533034; x=1733137834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tE53KbDWMiiAf/aKVsGRzxKZZ0crEJNrFhFlNRt0ZRM=;
        b=ZK/8K1ygbiZHVmapXjhPEJEHTsNq+OM2CfRtMW36nUkb2RecFhASAD4UZ8uY92ZmX1
         35UDxQAMB2j8pxKWDE6dccp08otDpM+1xS/mD523vQPX9BZs97Xg+zNeTTSJ5TRqd3hv
         zL6m6qQBE8/WxgGhNQsMXtFEYCa0Zu74cUfNxy1qM/KbB1pjo0N23yvcn6PBXfiqIjVm
         YB+cJ8sxaoQ68JJSyEzW4RFyoBua2wsFaHr0ASbavUOa5p/UE9iOUqVWqbSOd3eMjoJd
         +gRjUOTjHKrUdUzAFlApBpivEJDGPgFRUupFY793YvLCWzLru5DEh5LPAksn0NkOIEHp
         N1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732533034; x=1733137834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE53KbDWMiiAf/aKVsGRzxKZZ0crEJNrFhFlNRt0ZRM=;
        b=KT+Bao8cGyqm+UB0BpQJ32Tmo1jUsJ7lzebv4GU1DXpKSj6XmvlFoBN7Z+tD0nk56Y
         zBv3nOY6LO+31omdns6tsKYGqrN4pmIdIzMJ3hrnHYpU69MRNwoHcHCdVlgGs8HzUeus
         BSwEQDFToFjJ6VaO9FUy+FNHDgmkcuWCnRd+GzLniI2g0+iiy62MuTPYEzcGKcqgONz9
         e9ftgClBcVlQ9n7mh0Ca0Ky+rva43ziykIBAi4X16oSlP3EpmamTzdRyFClSCNWo08BV
         LXz5ydzyF5vu6L4QwQW/Kf7KnOd10kOjfawSPTJO7/NjjUTqhgqdvkFr7pK5nuKRNGOy
         dDQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdrp7R+mm6gKorqNAZohYcQ5E6oJmYPuj0Yrl8Ym+3egU+G462Hz5tf7Bow+wy1m5kuNKiMTAX+no=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7E7E+PIu9RehNWZ6C12zxwHNCNV6V2TNT8CoOxEDfQz53z+7M
	Hab7ylhbOM2TrTGCHTUXsNx4PsBd8kOeYTttjjwdKZAR0havrNyvKmaxs0VtURc=
X-Gm-Gg: ASbGncsxZTxUKu/wdWS2Zg4dAtcKeWrbkM3QttcECX0Lbf1D12sR7AXHtj4V3mR4MKU
	8ALuSQR1218kFV57Zor19XvuABzo7foPl7T5i2/XvLdgmZKhOtT4BVZNbeeiM6Fp2eE8YhEuodd
	YGU2S9dklSz/JOgvE9tmkHrKrmMynq2pFn/YLo7UMaxMfOc4U+Peo5BREuOVgAQRFSm+l+yZDVF
	wtbLcdLmOwJf6nbVD4XBoG9fbkae+N7j5W42Rvz+kqMib009DESw4eS4Q3pXAXRe1QaMZScxIz2
	f8JQtd+482NURmA0Xb2U0l11frS6ER3X7qK+fA==
X-Google-Smtp-Source: AGHT+IHMEHm5zNtM1TTxkOFBU3qXDBZ8yRBvrqoYqldxa34W1szM+0x/kReY7l1aFR+msWNJm5wB6g==
X-Received: by 2002:a5d:6487:0:b0:382:3d08:e978 with SMTP id ffacd0b85a97d-38260b46d13mr10288557f8f.11.1732533034324;
        Mon, 25 Nov 2024 03:10:34 -0800 (PST)
Received: from localhost (p200300f65f242d005bbc9b581c6b9666.dip0.t-ipconnect.de. [2003:f6:5f24:2d00:5bbc:9b58:1c6b:9666])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedf58sm10019510f8f.103.2024.11.25.03.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 03:10:33 -0800 (PST)
Date: Mon, 25 Nov 2024 12:10:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Dumitru Ceclan <dumitru.ceclan@analog.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 08/10] iio: adc: ad_sigma_delta: Check for previous
 ready signals
Message-ID: <7s7y76t4vggoirklkk7kpc6hcazs3woxeoiblfxzgejlckux54@ek4opdkgfkdb>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
 <20241122113322.242875-20-u.kleine-koenig@baylibre.com>
 <CAHp75Vd_jVnf+oY7Y19pFiRVNUNT24J9i9spRRag-e0bw73pSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tfbhahlraekzzkm7"
Content-Disposition: inline
In-Reply-To: <CAHp75Vd_jVnf+oY7Y19pFiRVNUNT24J9i9spRRag-e0bw73pSw@mail.gmail.com>


--tfbhahlraekzzkm7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 08/10] iio: adc: ad_sigma_delta: Check for previous
 ready signals
MIME-Version: 1.0

Hello Andy,

On Fri, Nov 22, 2024 at 10:17:51PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 22, 2024 at 1:34=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > +static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *s=
igma_delta)
> > +{
> > +       int ret =3D 0;
>=20
> Unneeded assignment, see below.

With the changes you suggested below this can get a more local scope,
too. That's what I did for v4.
=20
> > +               spi_message_add_tail(&t[1], &m);
>=20
> Instead you can also use
>=20
>   if (...)
>     spi_message_init_with_transfers(..., 2);
>   else
>     spi_message_init_with_transfers(..., 1);

I kept it as is to match the register read function.

Implemented your other suggestions, stay tuned for v4.

Best regards
Uwe

--tfbhahlraekzzkm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdEWyYACgkQj4D7WH0S
/k7wYgf9EEGL1nMWAsY4W9LxayNjd5LFpdUS6EOFPet1L+7W4zwiitwulXO4v2kI
FbLeG2r+tWJbvoMHT/RkOXPgQAWxzNMcAHCCAxYLUjDIUsYBKniqCK8f16nvKg3L
gyn9o+UKXUIZxCMXmcd9HvrFpjyP6pwTGmPy0hBNeyglPTqxa7JdzxlbIVO5xlqG
RBXII3K5uFvjDfEziCvHNcHAERgE13u5UQQZxYsvue6xHUJgPBnle/BNHLSrRhsi
t15OpsPSy0I/EMna/gAGz40fXZ3snWzgDlEC4cCBBNlT5z/PaaVhPR/YemexrlAV
sO1DOGt0I8pkOuyRSJCuBr0awDdInA==
=iwwL
-----END PGP SIGNATURE-----

--tfbhahlraekzzkm7--


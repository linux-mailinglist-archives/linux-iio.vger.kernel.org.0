Return-Path: <linux-iio+bounces-12500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A349D6192
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 16:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FA51605E6
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 15:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB03713D8B1;
	Fri, 22 Nov 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EERVaJep"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC298157A41
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290865; cv=none; b=pf1zCtXM+I2ZOJVBrotFfM2x1bdGeqcE6tmsG0ih30GDCfLekdf0Nm5/v5nxTUvpbgEarLXg4jdn1KaWm+O4DGCm9DfUz4wkmyGRwsl3mrgeq2i9qsa5Zo+bCnrHHbbV8O4D/r2ohz9S4Vj4XkTXoJ0+6wsTsxL7Z9cXa/2GuoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290865; c=relaxed/simple;
	bh=AbB+GZOADxUTZQjQFYiIqRMTxYSG3RHMUMSTJ35feKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW3pXWW0jdX6V5NhyfPBZ3cCtZUzqPXKHbahxgBCFPqD2kOmp5wMeVNkr/vtwYVIoB8u46WSD9/yVgIF5wGKBWJn07n0EYyxhkK43BbB/NWJaWTbBelJxQocQa0BwllE6sR/1W3h/ItmmR3nmoPk4El0RSSGlp7KrLlnTuxjIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EERVaJep; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfd2978f95so3151343a12.0
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 07:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732290862; x=1732895662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AbB+GZOADxUTZQjQFYiIqRMTxYSG3RHMUMSTJ35feKE=;
        b=EERVaJepjTx+vf4gWsVwA079fYajWitD0Tdz7x2XpgEe0JmeJHHYHwBIaDCxwY53bA
         3n86sI4fZCvvxLwfSL+HWzrWzItssp3wWv9DmTCq8gGvxmEUNb5Rytgk+hEHjzFYDABj
         NNgl0+BZo8hdW5x+KMX70B3jh+I7wV01lcFQXLtZ3/nmW/c2pakglXYipMFNzBYJgfQZ
         FMEfz/lCiIyWEsrSi/kDe9t5On/ouF8F9YRbcuwXJS4HmWy2bdedXR/UVzYzzgomZrTG
         PP4QApeuTNJI4WmwcNZz3nxHafkz7eQQ27u4dcodIurrlZGFf9Iq4gxlzM1nBAZSVmd1
         13Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290862; x=1732895662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbB+GZOADxUTZQjQFYiIqRMTxYSG3RHMUMSTJ35feKE=;
        b=KFCaSFn6lYBFVvUUFI5YJwV1pvbKB8/+BGT7rOJzi4rf3XXc4FtVQ781nZIdnq8jwn
         RaWz4+4+PbqdKahpU/gCxEerZ9lvqfeG8bll+bWH00Qm/SCjjQF3CqXJe7pW2PxOKHVI
         kUsNK4RM5V5fmckvkm+Tvmh3NGVTqJ34juwD2wQddWiLuN0taz52jELtnAkgJ2W2CaQA
         4H6n47xRsC97YFW8TZ2kIlLKaRSnwAKf766n8TQ4GqlhcZkVLbkpiwEA0d4rT1T0L3GO
         D7kN5VjJEtuXjQJYm9HUW/c3Cna2EO3skRx3TABeulyl3eJouN/Xe4BoMazg2oCjyxw/
         I8iA==
X-Forwarded-Encrypted: i=1; AJvYcCWY/0n9HCiT62RZ7g8uYC7ZuaOw+Wqkv0rtX0oVysGfc68r/xHHBpLUXCPyISl9WWwyXg5/QWE9Q7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZGFaccBS4yAnI916NQVibwMfe07wNd4YGV7aUE8ON+Xi7fA0
	Z62t7l1GVyihaXKbdYy3ucijVsiu7CcLjYEN8qfro3lANlfF5SqVqBbYBdsBwt8=
X-Gm-Gg: ASbGnct4hE7rAL1GaV9Dcu3JalUKKBBKJ1xHgxk0qMUAVdPTd+DAt8Ds2KToynoKwOh
	4j5hxi05tmBwtrHm8zS5QsufqahvvVl+LWr32D3ZTUhBiKY3n+dBujQ3oS7fB+X0Dqhbj68ukU3
	9m9Ay7fwsYGf6H0YYw3ylIA03YgrlEZEKiBaRhwEzoUrBcAtAVHMVzYncGz4dBdlFytZ+KwvhmS
	RmukQdvPUkTPb1+1FzjXUMxHaCdXY8RbU2OBdJCCIgn2PC1hFQ3Bs7T6LXfmuSRBefgZKCHLVbD
	gns=
X-Google-Smtp-Source: AGHT+IEcC18ZfKJzXUMKq8ME8tNe1yPd8GuNKTQpBaP76Ba4tDYMggi4IuL4B1XIxe25czmwO7ZLKA==
X-Received: by 2002:a05:6402:538b:b0:5cf:cc4c:76ff with SMTP id 4fb4d7f45d1cf-5d0206339aemr2960405a12.18.1732290861444;
        Fri, 22 Nov 2024 07:54:21 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b88a7sm1054901a12.31.2024.11.22.07.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:54:20 -0800 (PST)
Date: Fri, 22 Nov 2024 16:54:19 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	Dumitru Ceclan <dumitru.ceclan@analog.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 01/10] iio: adc: ad7124: Don't create more channels
 than the driver can handle
Message-ID: <rcn6gtf2kuxxtw2xs5z374lkzst3eozgyrkdcofa6m5jxzfvne@wye2z6qoni42>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
 <20241122113322.242875-13-u.kleine-koenig@baylibre.com>
 <afbb5d4d-8715-4544-b372-be23811eebd0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="odmlvqvkgonrkc6q"
Content-Disposition: inline
In-Reply-To: <afbb5d4d-8715-4544-b372-be23811eebd0@baylibre.com>


--odmlvqvkgonrkc6q
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 01/10] iio: adc: ad7124: Don't create more channels
 than the driver can handle
MIME-Version: 1.0

On Fri, Nov 22, 2024 at 09:14:18AM -0600, David Lechner wrote:
> On 11/22/24 5:33 AM, Uwe Kleine-K=F6nig wrote:
> > The ad7124-4 and ad7124-8 both support 16 channel registers and assigns
> > each channel defined in dt statically such a register. While the driver
> > could be a bit more clever about this, it currently isn't and specifying
> > more than 16 channels yields broken behaviour. So just refuse to bind in
> > this situation.
>=20
> The ad7124-4 datasheet I am looking at says that it only has registers
> CONFIG_0 to CONFIG_7, so do we need to limit those chips to 8 channels?

These could be reused for different channels if the settings match. I'm
unsure what happens if the 16 channels use more than 8 different
configs and you want to bulk read them. Single channel use should work
fine I think. If that is a problem I might have to extend this series of
fixes, but this is something orthogonal to this patch I think.

Best regards
Uwe

--odmlvqvkgonrkc6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdAqSkACgkQj4D7WH0S
/k5Zggf/W9X6102crHeIE0sPhLE77cPvbCd0R7xJZXq1D0cUlPLbzSRI2JBwM//q
53FUpEJ0Y6rx8ipj2yE9RX/NdqpqjBN0oS5QarnOMa6HJgYdrzrR/gSHM0Y9Wwa5
HQ2WVyehWHWgbdr1LkEKxEewYo7ziRE//erTKRl4kEmDHxIQFZg8OguKdOlCpuLa
cDqyyv9ADMHJp9GHhWzBB/VjvTeDoSk4EoROuuI62iVWeekDiRi93L/pEd7jAHCU
c4RwgDYAzSem0vZTtrzi4vWd9kfmxxHwrTDyYF3rHt1idJ8ANCWItnb2K37wm3Ia
bsGNNwsgtxV8uHBjF931oTlkmWFOzw==
=6OJt
-----END PGP SIGNATURE-----

--odmlvqvkgonrkc6q--


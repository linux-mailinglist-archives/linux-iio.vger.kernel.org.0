Return-Path: <linux-iio+bounces-27487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C468CF465F
	for <lists+linux-iio@lfdr.de>; Mon, 05 Jan 2026 16:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B55431CBE4F
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jan 2026 15:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A4C3054EC;
	Mon,  5 Jan 2026 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvlrL0MN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CDB3054EE
	for <linux-iio@vger.kernel.org>; Mon,  5 Jan 2026 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624987; cv=none; b=QbXFdPGgOGjyLC71l8eNLnqDFONAgXd5Vo3JflcYt+wi9Hk5pXvaUjRTGQIjS8aqChjTzF0my/r+Zd/LGYlIEny2gmaJdomexWXL3Remis6Z4p9iy7TwCUqoyrWoRqQ0WDEFakp3AXusZ305ezCNuTHhzhvCyFHtU4RVYvQEAcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624987; c=relaxed/simple;
	bh=dxiqRHHavIFin261g2Manwye9aCMu+eUBxhEmZqtnOk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dy2zSSseRpI2UrN3MddSc6ffnYGC7hONdagDvRYRZjojiQ/YvJgJdOewcP3LBr1OfqxRQmXa4SDBRZsex+HJ2UPzYc940sZMNztSaEEcekPNV99IMBRzj3QA2Gc9Rr7A1X3vVcqETz75Hq1nXkyvDFvK+3696OhPV9dTY2vzDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvlrL0MN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43284ed32a0so3347013f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 05 Jan 2026 06:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767624981; x=1768229781; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TrXuUzKcsmzo7kWSQsu4TC9R7jFFnKDSGkoAA7Lal7k=;
        b=lvlrL0MN2U9Tu+x+IiWiX4+er9ZG6sFlTTovbeezHpQ/RstY8MYKsZq+t8DDnfC8el
         h/hbeTxzMhUpf280bXXMSgKaN7IEA91PsU4fsyDx4Np0/hDlwV11sFpuxKgbkbNNtmzy
         RLT7R/oFda4lZcCVBn7uIM4SR3GNBUcTMk6AXaM8INc6LBSJtAv1HRfjzZ0gHn1+1hfu
         6wtMxMoZCG2OKumiRemcw+xxdDX6uXULsIISn3jeyJHs9K4xlVniYD/LDqAwrHUVmuDW
         st7l/ivcfAK7foP5znxv0wou2d1/FvnwxGp6pSfkxHroofH0ZA7ak4TJgXn2YvzkoPQc
         6Kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767624981; x=1768229781;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrXuUzKcsmzo7kWSQsu4TC9R7jFFnKDSGkoAA7Lal7k=;
        b=ObgoO4fZiM4sEdK3Mn03c1pjeeA425sSv8TQTdjCcuvb0yfDjr+3ngao4iv3itoNOW
         80egp8t23rPGRsfwbF5YxHNl0Rk8PasnaqIBZtfFtLq3/s36fCitYnGYD7KtcJI7HLXv
         dG1jEZWR0+wlRrxUCnan8hWb8Km+KO6AkD4Bbv375fLMGNPKRh6lZEn/YMA0u8rmll+u
         tFOWxMPGIdoSzP5JrZF1OpOVo2Ze23NnKyfUHhWrvE+Ff//0ZBCYTisQrhQo+Vj3grfF
         t5Si8VuuolcDbH4HjrE4udqvZ8HK7W/qa58hGWzP7RG9QJG87MFsVQe8oqc+vAkh9XnX
         uy8w==
X-Forwarded-Encrypted: i=1; AJvYcCUu1kJS/b9VgYxy0GUO40LG3UwKlmZkm0eBxZmvdvNGdN/rb0cdYuD3xks6KDYh/wihmQS056EVWgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOAyonFOAYYhS5GIXmdJmlVqQCSNghs96w9BPwB3RiRXSS/Mb0
	r85ZRoMi59l/SgjeitO1sqON55Ns7+05sIlEnp5MoNyn6kgXV/4MgNtU
X-Gm-Gg: AY/fxX6HpRCTHpS9V3mVnuCSSh3GagBf/xUI64ZQm8qdTRh3yTt/qwGx1kqwiHswq02
	T5LZmQpcv9FPimPKW8eQ42SCO+qeKFW0j8ZCcEbyRma6s+T8ROejGSf5G4NBfcTwtnvJmo2f+J6
	qqU1pCv+Ok/0yxv99zKRFv2VTmwLD4PR5QOqunSJtIlCgUWn7YwwaeZwUAtMdTT/jWz441tIP8/
	GnYKXLsy84sGILJHRV9hXU1jBnjDof4+ryhRybSDPmBgvDcf2KIfoMrP6ckHtKKHZLOSfmOWlv/
	aHcNalD+cLXtUh4kwZQVkTKsKtqpeW5O1/IaJBP2tPYueiS/Q+yo78Ahs5tohaOzKlAgcfI/NVX
	P+RMURd4ruPt8+cEwBCf8XAADL6q8WhMDf6+VB1Gf6czrfIy0dW6O0t+ni0ZKUbi1K7QwcI4xX1
	EsdIG9hcbH+LCqJ1zOsHw=
X-Google-Smtp-Source: AGHT+IHtYGs0n2xRNFZlNWcufG5yFBAvOBoIy3zM7pjp+B7ji5QWQ0n54rIlL4LulVOT6gZoXPwnhw==
X-Received: by 2002:a05:600c:3489:b0:479:2a09:9262 with SMTP id 5b1f17b1804b1-47d1953dabamr617824775e9.9.1767624980869;
        Mon, 05 Jan 2026 06:56:20 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6ba5001esm59914095e9.3.2026.01.05.06.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:56:20 -0800 (PST)
Message-ID: <997f9d13f44031170a4518abf23ee6806d526054.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
	 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Jan 2026 14:57:02 +0000
In-Reply-To: <356a75b0-dc3e-4d10-a827-1af3b4ab638f@vaisala.com>
References: 
	<20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
	 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
	 <20251221200014.29af7df8@jic23-huawei>
	 <356a75b0-dc3e-4d10-a827-1af3b4ab638f@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-05 at 13:06 +0200, Tomas Melin wrote:
> Hi,
>=20
> On 21/12/2025 22:00, Jonathan Cameron wrote:
> > On Tue, 16 Dec 2025 11:40:06 +0000
> > Tomas Melin <tomas.melin@vaisala.com> wrote:
> >=20
> > > Not all users can or want to use the device with an iio-backend.
> > > For these users, let the driver work in standalone mode, not coupled
> > > to the backend or the services it provides.
> > >=20
> > > Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> > Hi Tomas,
> >=20
> > > =C2=A0static int ad9467_probe(struct spi_device *spi)
> > > @@ -1352,21 +1361,25 @@ static int ad9467_probe(struct spi_device *sp=
i)
> > > =C2=A0	indio_dev->channels =3D st->info->channels;
> > > =C2=A0	indio_dev->num_channels =3D st->info->num_channels;
> > > =C2=A0
> > > +	/* Using a backend is optional */
> >=20
> > I'll largely defer to Nuno on the backend aspects but I would like a
> > lot more than a statement that it is optional in this comment.
> > At least something about where the data goes and what a real system
> > that didn't provide a backend would look like etc.
>=20
> Having the backend as optional is about flexibility to incorporate these
> devices as fits best with the system. The current backend approach is
> pretty much dictated with how the ADI default backend is implemented.
> These devices are fully configurable via SPI interface so the backend
> doesn't necessarily need to be anything fancy or even configurable.
>=20
> So there is atleast two use cases that promote the optional iio-backend
> approach
> =C2=A0- simple backend that is not configurable, no need for a dedicated
> driver. The backend (FPGA) sits and waits for data and handles it when
> it arrives

Agree on the above. Ideally we could have some dummy backend for the above =
but
it is not really easy/maintainable to have it.

> -=C2=A0 custom backend not compatible with the adi backend features. For
> example different approach to calibration, or other model for data
> channels etc.

I would argue the above would require a new driver with, perhaps, a new com=
patible
on the frontend side for the needed modifications. Or we could introduce so=
me kind
of "detect backend vendor thing" so that the frontend driver can adapt at r=
untime
(though this looks like a "fancier" way of having a new compatible).

Ideally we could somehow "detect" backend capabilities but these kind of sy=
stems are
so different and usecase specific that, at least for now, I don't see how t=
hat could be
sanely done.

- Nuno S=C3=A1

>=20


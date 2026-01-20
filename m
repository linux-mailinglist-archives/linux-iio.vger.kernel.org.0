Return-Path: <linux-iio+bounces-28049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C29E4D3C4C7
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 11:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFBD352850A
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 10:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5483D3D1C;
	Tue, 20 Jan 2026 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TLaQa/4o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0A39A805
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903416; cv=none; b=NCBqnN4sl+4qgzL5Rbek8vp4gEzQ4SK6V3ohdzsWkCQzb7sP+AFnxxBvB9ZrF0kdsNMVO/rFON6680xSh0xmSmK9/dpc8+Gw1SJSdfAMkEXgOT5UtjibywsYpt1kF0hE6RD204sPHTXhq5NzgU5tD4aGo0Km9ICq64FugCKxd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903416; c=relaxed/simple;
	bh=LF3DNRDW6IFcgixs68yPGT8hTGxazztwO2nF6eNgzUk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P8oUCBPaj3meIZ8L1VGD98Y7m/BKa3Emf5ce+TWtORooXJ1cKbh9udNgsjJ7Ehu9NGd5UMlYODQwQysTxt2mn7sdjFdRpX7UWzFozgOEUMOTwLjSRmLAc+4WLekfFy71GS6XD1UwQXfrMo/L/xIkEHboKVQO7tKIt5unPns5lGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TLaQa/4o; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8718187eb6so793043366b.2
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 02:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768903413; x=1769508213; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LF3DNRDW6IFcgixs68yPGT8hTGxazztwO2nF6eNgzUk=;
        b=TLaQa/4ow7rESkMzeQ7EXJrxPvRFEk8oMNpOo9gZ6voUeyQn0swiOiq6YYST4zdouZ
         G/e/zGdKzXCPA//YtZvjmdW5qLVVxrUS5Cl+zcjpuf5c5X/QGD5SvArGX4L5vXD515uK
         zcK/YLlJPS8xf8uwxXqvcnHpcKyAqLhIx+ai//Z2Rt4/ZEKW3KzsWy0YG/KflCN8vX00
         Cp0wexCPaFW07fLO+2F/m9COReWDc8ce1iDLPuadW5GDw8pYHkDXuRTQ1r23HgloyNZu
         KvbOTNzRReDQce1B4LJ8nUs2qYQsYoiPYkW9zAjwax8vGD1DeZM6z9OVBZioGET0EB0Y
         T1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903413; x=1769508213;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LF3DNRDW6IFcgixs68yPGT8hTGxazztwO2nF6eNgzUk=;
        b=GblHQ111/SzozUiCvCIPVSsYDqHYmW6ifPHGpz/HYqakdRimlokUiIagUhx0L6L0FV
         FmZZr+bWSTLQi6MHXEL9VQgMqaYNmiUZHiyXBbzuDio3Q4oDYFoKdnDUVl/fb5Wbb3el
         jpoGhvPCV9EenP3/9YaKTTS5QjPFDmLo84y722ZFTs2Hh8qiiDnAKJxjZR5S3crYFOiq
         OPYdJeEuqc8nV9YB1480ALnK8XH66JH//9rJB9PCCnCf52t3SUtwFIdWlTuS/0i17A8A
         L6ZkbmjaQ4DoAZPsAPur1LrmgsdIun4OgXSiCbEW0nVR+FBnnND+YoYkz8pvFWdtbLsv
         0lsw==
X-Forwarded-Encrypted: i=1; AJvYcCXCxyQxhc+m4QHG50GBZiMkq7rsQPXyHUm47UCbdtfJ3SbRM49AMyxdkQfwRzb8+Xh7NESpJiyfOC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhefNCU1Wju9rcNlnVZ1PQDaMCksJHvgYCKxBLMF2fk92vJGbw
	ymjzIx43PMIBjyo+zTufI6WTE1cHVXiL/9XTo2A6tgjHafVJdS/KYybfariTVM4rea8=
X-Gm-Gg: AZuq6aI8y+U4YtN7+O/xeHDt724apBthM/DMXsO3g4JeroCQtJzUFT6E8DEUyOBbJss
	f+E03EzuiPeopM/Aw3yRrLeo1j0w2NTRgqN/qapHBa9wJYp1hOUnieaDx5Oq7DrxbL8OVwd4tkx
	d1jC9qZhDJ1Fv4WvkX3VJ1JORVM8C2iHM9kRHIKVsUCbY1MUJZbLDEvgd61DOF6Zy4tJq699Okf
	EssmbmoY4lD/mEcYnExt81+ynFE+zYVMXf8z212MB+CLwd17pwCOBA3Jj/bGn4ogDhkJ/MAtqNm
	xq6SG26r4D83VPrbtN3m1XlLGqZt2/zcaISnNQDOE0s6KgVGauRR1akEwQtItZ3DAoCn4lK/iLQ
	ccYczlTEOz28LDd2XpJBtqgRSB0QhmlaVuVvUCV8CosgbU6nexRqf8Gcqx3GYpQzIb3q5XWk/Lb
	RkqIt8
X-Received: by 2002:a17:907:1c88:b0:b87:2bd6:6bb6 with SMTP id a640c23a62f3a-b87932eb1a0mr1022315666b.64.1768903412662;
        Tue, 20 Jan 2026 02:03:32 -0800 (PST)
Received: from [10.203.83.229] ([151.47.45.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795292783sm1344879166b.31.2026.01.20.02.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 02:03:32 -0800 (PST)
Message-ID: <9149f9c75c9f961da29829577ba4476681f4e82c.camel@baylibre.com>
Subject: Re: [PATCH v3 3/3] iio: imu: st_lsm6dsx: add support for rotation
 sensor
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Jan 2026 11:03:26 +0100
In-Reply-To: <aW9MhYO_xhlQXFn2@smile.fi.intel.com>
References: <20260119100449.1559624-1-flavra@baylibre.com>
	 <20260119100449.1559624-4-flavra@baylibre.com>
	 <aW4Ic5bUId3MG4em@smile.fi.intel.com>
	 <851180c6f41f8c9cc79d6412eb97f381f0312f00.camel@baylibre.com>
	 <aW9MhYO_xhlQXFn2@smile.fi.intel.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-b7hIN649gMk+JAo5hWxf"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-b7hIN649gMk+JAo5hWxf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-01-20 at 11:36 +0200, Andy Shevchenko wrote:
> On Tue, Jan 20, 2026 at 10:28:15AM +0100, Francesco Lavra wrote:
> > On Mon, 2026-01-19 at 12:33 +0200, Andy Shevchenko wrote:
> > > On Mon, Jan 19, 2026 at 11:04:49AM +0100, Francesco Lavra wrote:
>=20
> ...
>=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0snprintf(sensor->name, s=
izeof(sensor->name), "%s_sf",
> > > > name);
> > >=20
> > > Does GCC complain on this (`make W=3D1` build)?
> > > Since this can cut the string and we don't check the return value,
> > > the Q
> > > is:
> > > is this okay to have a reduced string?
> >=20
> > gcc does not complain with W=3D1. sensor->name is appropriately sized t=
o
> > accommodate the longest possible name; if it wasn't, the string would
> > be
> > cut in the accel and gyro IIO devices too (which use a longer suffix
> > than
> > "_sf").
>=20
> Right, the question is if compiler can prove that or not.
>=20
> We have several patches in input subsystem to hide the warning by
> switching
> to scnprintf(), which I consider not the best approach, but still it
> depends
> if we care about cut or not. If we do, we should check for overflow.

A truncated string would result in a corrupted value in
/sys/bus/iio/devices/iio:deviceX/name, so I would say we do care if it's
truncated. But I think the most appropriate check we could add in the code
is a BUG_ON(); would that be acceptable?

--=-b7hIN649gMk+JAo5hWxf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmlvUu4ACgkQ7fE7c86U
Nl80Kgv/aDA+Jv76EZ8AH78iGzWSbZxxCHIBzfOoJFVYnR4rrVtoirEWhPivFKOF
pLy82UwhUXbiCPlFI8Zyr8uz/789ur2lL6/wwv/lsctxfU5BqJQyIxLaJHj0+a+X
WAOS/AYHg53yg90vFWCYJwb07May8Y/Us+0VYCN3DchtM+5gaaU6yw+LiKEC6fku
pMHCGeS49NRMiLn/gu3zzqpaH66G38yFc4S/P3U63SlVY7FEoGLqA8ul73G9RTp6
/Ps90HhsJJNsFCbcoxQTNv3Ubmpm4hT3wv5s+SFt9Id0dPTKYSx6xJHXy1+FrEjW
RUXm4tPjYrp6wDA2a1ldgeXrApEh+1PkoDUOieW/mKBUcEv94941Z6CUd2qAZTGg
Xljmwo7L4ArxFibk1JOe0HwnLQfWdJ+GQG12bEAy2k07ChWYuPuo3nWsrqJSVkSR
AAs91p9J92jWC9AbTLYA50Nwo7d04xEBo2Qwb/ZWIuuw45EiHnXrVGeFexEDWrrJ
CiZ9GKe5
=javF
-----END PGP SIGNATURE-----

--=-b7hIN649gMk+JAo5hWxf--


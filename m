Return-Path: <linux-iio+bounces-26694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62709CA0B92
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 19:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB2E6307FC19
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 16:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F23311C31;
	Wed,  3 Dec 2025 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIeXhyFv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345F3112B2
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778185; cv=none; b=jEb21dbSO4/tVrvVzGZRcHXuVtuItaYkpiuKIcCH8EWYmRKR/GcX2TvRGGDuYt2FFtbM8yVLZIaMwx5NrqApsMIbnGAbDWHNSRGZhyQXUot8zK8nUC3RJ2BeDHfqZFSjjD/TvP41lpFkZkOP7qR1zO69JJaz67pw/ZmlQIdNxdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778185; c=relaxed/simple;
	bh=AMeda2PnLpAhsNgtpMjk9rLgK/Dl9RdumGlImJ5SVRI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ATQsABEFDlrO0H9MTR6L0D0x89OOcBJA28nF12xNvEVvbKmG9rvVSJH1j+pvBXOW1HgN1RY6W0wnkhP8HrCb5QDsjdrR/hLD/MYNSbRHhjKfq38/z/tFxspnOeIez09vjNnmn1KEDu/q5GMOzPPIDIIbZf1i7nMSEyVnbtPjvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIeXhyFv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so12113306a12.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 08:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764778182; x=1765382982; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=790LUITxhKLWzCs8qQsIA+Y8o74zqMnK7Hol5PzAlXc=;
        b=XIeXhyFvUu0zRHysWmurUl7qZGEtFv+MrKzqDIVOMX56fso8EAx+3uXnhlj5obA1jJ
         qNdgLXUvbGt859lVNMrB46twzecOoJKdxS5V5KF5UhxwI29kTLu/decAQLSSjVODrVl8
         C2mYK5vjPgKhQS4o7/aHugIkJVsrNEZql0OteuhFDJh70DoN+bTdQPqP9rlC+UKDxeUP
         WbBb6eYFp0Nazu+SzKycooCMmQb3T7JeeO8rmt+qd+zWC313npdYpLH1bIXqlymEkiJL
         0oiUlCbbckG+DfSDonCGIU5J76UNSEsdc3Un6HHKNDxJyDyRTIwUVDBUcD0XCnV/7Ot5
         sl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764778182; x=1765382982;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=790LUITxhKLWzCs8qQsIA+Y8o74zqMnK7Hol5PzAlXc=;
        b=fhG3FS9gpptdAWJbljYV1yZPBsWzy5UCr22dz08IIpC+Q9wGgyq+Lpj4Alj3I8hWtv
         4KE5Aa+27ml3arj6XU7aBz0VzM3AsaBB0L3prb7Gm57YReiOwfCeH/zvHCLaNO6IaRVw
         Nt72ERGADsWdKlmOhPYtbXmnDGCHAgfgMrYdcoxbzPIIkzc+lYe2oHZncI6f+uRFfrdt
         1bWJ7jS1b1skR8eaWRgME0QE74ojWGa6UnEYim4llI/qvz03zc3aeYFD8htogNnVxWav
         J8OCgkiSRm2oIDcu8yDYMB2eEg1yY3qrPFuZgmh96pmpZqd4WgHhfN+bMc81XFarJbob
         Y/zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNhy/o6ct0OtU2cvInbwgTbPT3MvITmcuHyo79ZHHv6Jl0H3P02qIhLkmjyo6i7tkAOiF49bhuOjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQM6u/tQxw5vC94QBqyEmgiuBxttuTwFbBU6IzDkXwF5cThIl
	TLzCVxVjSga0dyi0t4ESYOXueF8C+ZasGf0R+YLgLIA1NiYTrjlPgIpH
X-Gm-Gg: ASbGncv7cRQEMwWWDHd3OxlBLLSGuXdlJT0nxMu6xUV6XuPAllDA39zcQXWV9q5Cm+O
	ABAhHCAeV2HpkEu1cMjXtJfeyDEAUSyPjXd5bvTdZrIdPWlVVVYVWtlx6EAt23EUZoUq6DZJwVl
	89QtPIvCQIS6MZPidS5x+1NToZ8mRTQWTjOO5UPbSzHMV8O0KuyT5B4yI0z3u7hJWHZVQ4UgIMJ
	Ws08SECJzI5mwKAVnuSGTv808yPeLxj+OqE9cUmJgWWnMbY3USSzovbU5W5WwFZt0kzTS3hs33L
	vYjP99EqcIhl+RrsQn9WUbEpKCvU081XPbrTQcZLwvFDg82KOXzVAed9zc6yTtPS9G/FyEfYUu2
	/+liTSNIGK2CQy+0sjIAdmj9kO+hhmF0d38o3or9fLdtdErOCZakf19qpk166bcG9DBsFj8TZkb
	9zMU744yLSJHc=
X-Google-Smtp-Source: AGHT+IFI8YszJTzdVA1V+yDi6An+lSjLFDFsoEVlke+XdtBNLvQox6jEhAdUUQ0sSKcCzKn+2QPy0A==
X-Received: by 2002:a17:907:97d0:b0:b73:3d15:6337 with SMTP id a640c23a62f3a-b79dbe8d3b0mr328548966b.21.1764778181465;
        Wed, 03 Dec 2025 08:09:41 -0800 (PST)
Received: from [10.5.0.2] ([185.128.9.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f51c8577sm1786027666b.30.2025.12.03.08.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:09:41 -0800 (PST)
Message-ID: <13c8796d8c24f2d0eefd99e6529bc91d448243b8.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: dac: adi-axi-dac: Turn dev_info() into
 dev_dbg()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
	 <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Date: Wed, 03 Dec 2025 16:10:21 +0000
In-Reply-To: <a17f410b-17b3-4abd-98c0-be6952894eaf@baylibre.com>
References: 
	<20251203-iio-axi-dac-minor-changes-v1-0-b54650cbeb33@analog.com>
	 <20251203-iio-axi-dac-minor-changes-v1-2-b54650cbeb33@analog.com>
	 <a17f410b-17b3-4abd-98c0-be6952894eaf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 10:05 -0600, David Lechner wrote:
> On 12/3/25 9:53 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > We should not abuse logging and logging a successful probe is clearly
> > abuse. Turn it into dev_dbg().
> >=20
> > If it turns out the IP version is that relevant we can make it easy to
> > get through a new debugfs interface later on.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/dac/adi-axi-dac.c | 8 ++++----
> > =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-da=
c.c
> > index 0c7b62f5357d..f536158beb4c 100644
> > --- a/drivers/iio/dac/adi-axi-dac.c
> > +++ b/drivers/iio/dac/adi-axi-dac.c
> > @@ -1000,10 +1000,10 @@ static int axi_dac_probe(struct platform_device=
 *pdev)
> > =C2=A0						"cannot create device.");
> > =C2=A0	}
> > =C2=A0
> > -	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
> > -		 ADI_AXI_PCORE_VER_MAJOR(ver),
> > -		 ADI_AXI_PCORE_VER_MINOR(ver),
> > -		 ADI_AXI_PCORE_VER_PATCH(ver));
> > +	dev_dbg(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
>=20
> Didn't ADI HDL versioning policy change to semver so that the last number
> is no longer necessarily an ASCII character?
>=20
> We could probably change this to %d.%.d.%d while here.

Honestly, I'm not sure how that settled up. I'll check and if that's the ca=
se I can change it.
But then it will be a bit messy with older IPs. Maybe moving this into debu=
gfs and handle the format
there would make sense.

- Nuno S=C3=A1

>=20


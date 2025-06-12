Return-Path: <linux-iio+bounces-20544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C12AAD7060
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 14:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3623A143F
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9BE21FF5B;
	Thu, 12 Jun 2025 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA2yUkx8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15F1EE033;
	Thu, 12 Jun 2025 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731359; cv=none; b=sqRj2KnDLEj0yroHfyJxHKVVG6drFjd5Z6kkVCbe99w3pnZzoPYZcPZ7OFaa7tc0+TfzFfouRAeL++rEnWvBef8vYMHwzlCZeuiJgYRCSyqyyrFf5zZ4iVA/FpekCF769wlS1L9irPSivjo/bsYRVWBoxAEDR4/DlO0umM0Xi80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731359; c=relaxed/simple;
	bh=NEJs2y5lh32zGmKZ8Qzhu9KFrGD77yTrgBvMh7VvKkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fd9S5FCoLqx66mbn0iWAAhwjndgtw9GGgnwh8/EPhxzxPY2emVejpmPRYVu088TvqErYYy2lJRepD7vtsnRh55lSlwR3fmRxfq1PndYSArGh4b3HeB7k3R28AsCtE631Z23HuqF2ZBaJFBx7m9l1cuc+HNopdQATwt3mxXtO8HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA2yUkx8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad93ff9f714so158461166b.2;
        Thu, 12 Jun 2025 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749731355; x=1750336155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEJs2y5lh32zGmKZ8Qzhu9KFrGD77yTrgBvMh7VvKkA=;
        b=ZA2yUkx8LibcLgiBimfBweWTPVbAexJk/gKyzqQYCob/ptCsM68G7RxgpZBQpw8YVn
         T6Q/pdbOG/T+RriUUa+FQTyrET8UrQkqptelgRRrfAqZobh5FLEEKeW9OAAHPlvzxWPq
         U3yB5wVV6gcFQ4Q+9Om/Gcz6s4WQF0pfVXDHQtSNsLfJCx7S8xDFVkZf77IHdoNcnwzz
         SVfeZCCv8F7QWYOE+3mq05NUQKeoFGy9ErNb7ub1ffmgjrO8vOUxj87DxbAGUBYkWyUr
         5Q+MvPikylHr6FWY7Vrs/NH8M9APzfSzJuIVrjT1w9bz5w2rMkm1HBpavlK1vWoGGzrU
         emPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749731355; x=1750336155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEJs2y5lh32zGmKZ8Qzhu9KFrGD77yTrgBvMh7VvKkA=;
        b=MFjS1KC6eLG55TyfMwriX91QldMXsSmcGzFiQQXHjdNRKi7M1SX2gNFAjAGTr+RhfY
         uXmBD7ZY7R3FpJ1UFQnMJCQK82dSPPYUeQJPLLRLkxbtI4059UsYkgZaIL0kyGBSpDVZ
         2zSgD/+KtqCYxGddyLQM+tZvnI6w+6WTe4IoWfr7czBodIip9oGJGkYKm4UeicGj7J6i
         g/JH2gud7lvpRaT5ElAE5dJ1krwIK40ZWTJyQ6IjaiPx3XSaGSxXkfOUGxw1Nd5EsUzZ
         SxrOV+o3EuiGT5740YNhA0bZRe9CYThRTHtLiLIAUaUzh9oXREjaZBrYifqpNWxd9+F/
         0Zbw==
X-Forwarded-Encrypted: i=1; AJvYcCUxRD/nyHSdtFydbzOYA9HzZKOt4zcN/0TOUCp7mP2m3rGMkCK0cq01zjil1DpmoYjZU8vnyMcpM3QYzqXu@vger.kernel.org, AJvYcCWQ2deFXTSWqNIrwlsw1OINoahpxMPnph87ZKqAJuTx5kkqbKnAm7z+nd9x6yffHZwcDYgM20+tm1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTkCiEEYMFR7DGoLjHWSq7lm1f0TQ1wWXac3AbFmwc35eyiqzh
	DvWwfyJhDZgtD+lszGCKBNeSs4lGf2Oy8xmeuDNQ2FPAjP98Md/96RLfuZSzoA4pYYPmXGOe62m
	6VItF/2HHQNyMPDMwJd3E/HK4qQn8LsA=
X-Gm-Gg: ASbGncsCkfkZZVPnmQSkxNKjlWrHyxQA6c8Sd2BFv2YfbzJ5XXuxFpTpyGCE96fPeyO
	D2oeGKcJFKaxlSfdYqqWx2Pl456kH8vKbmMEG3sFj7V3zpdegZNk5mCxmf6PVqGgOkQZsJUDSsx
	DNqMBOyJKYgBiRWXj3xNdCVl23JFhY1zbihuOib1BtoGc=
X-Google-Smtp-Source: AGHT+IGlkqMkspvLMpeTjF8aN4KiUGRrevrrBMyqe/WGI6YMF5fU2+dVwFdEvs12L1YJUL60yY3huaWNWMMfCo5r7oM=
X-Received: by 2002:a17:907:1c9e:b0:ade:5ba:40e1 with SMTP id
 a640c23a62f3a-adea270e2f5mr330585366b.0.1749731354468; Thu, 12 Jun 2025
 05:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
 <aEqbQPvz0FsLXt0Z@duo.ucw.cz> <2243943.irdbgypaU6@workhorse>
In-Reply-To: <2243943.irdbgypaU6@workhorse>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 12 Jun 2025 15:28:37 +0300
X-Gm-Features: AX0GCFscYljXh7LJwJGoGDo8-EH4wvCa4kp802_hSw1Ko3S3oAJ3o3w3MKMG3Hc
Message-ID: <CAHp75VdVB1OogZay+FDYVY0XajxcOx6t8T8LJSs+zSZg8TkaDQ@mail.gmail.com>
Subject: Re: [PATCH 00/28] iio: zero init stack with { } instead of memset()
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-rockchip@lists.infradead.org, 
	Michael Hennerich <michael.hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Francesco Dolcini <francesco@dolcini.it>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
	=?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
	kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Roan van Dijk <roan@protonic.nl>, Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
	Jacopo Mondi <jacopo@jmondi.org>, Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
	Mudit Sharma <muditsharma.info@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
	Andreas Klinger <ak@it-klinger.de>, Petre Rodan <petre.rodan@subdimension.ro>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 3:12=E2=80=AFPM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:

> I thought I'd chime in as someone uninvolved because this seemed
> interesting.

Welcome! Other opinions on such a topic are always appreciated.

> On Thursday, 12 June 2025 11:17:52 Central European Summer Time Pavel Mac=
hek wrote:
> >
> > > Jonathan mentioned recently that he would like to get away from using
> > > memset() to zero-initialize stack memory in the IIO subsystem. And we
> > > have it on good authority that initializing a struct or array with =
=3D { }
> > > is the preferred way to do this in the kernel [1]. So here is a serie=
s
> > > to take care of that.
> >
> > 1) Is it worth the churn?
> >
> > 2) Will this fail to initialize padding with some obscure compiler?
>
> as of right now, the only two C compilers that are supported are
> GCC >=3D 8.1, and Clang >=3D 13.0.1. If anyone even manages to get the ke=
rnel
> to finish a build with something else, I think the compiler not
> implementing the C standard correctly is the least of their worries.
>
> My bigger worry is that =3D { } is only guaranteed to be as correct as
> memset on C23, and the kernel's standard right now is C11. For that
> reason alone, I don't think memset should be moved away from for now,
> unless someone can verify that every GCC release >=3D 8.1 and every
> Clang release >=3D 13.0.1 does the right thing here regardless.
>
> >
> > 3) Why do you believe that {} is the preffered way? All we have is
> > Kees' email that explains that =3D {} maybe works in configs he tested.
>
> =3D { } is guaranteed to work in C23, as per the standard, but again we'r=
e
> not on C23.
>
> The reason to prefer this is likely that it's easier for static analysis
> to see the struct as initialised, but that's me making assumptions here.
>
> A more human-centric argument is that once we're on a C standards version
> where =3D { } is guaranteed to be correct, then =3D { } is much more obvi=
ously
> correct to a reader than a memset with a value and a size somewhere later
> in the code. This argument is evident from the number of patches in this
> series where the memset and the declaration are not in the same hunk.
> That's the kind of stuff that keeps me awake at night, sweating profusely=
.

While all you said seems true and I agree with, the pedantism here is
not needed as in the Linux kernel we have {} used for ages in tons of
code and if something went wrong with that we should have had bug
reports already. Are you aware of such? Personally I haven't heard
even one related to this. But if you know, I am really more than
interested to read about (please, give pointers to such a discussion).

--=20
With Best Regards,
Andy Shevchenko


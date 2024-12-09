Return-Path: <linux-iio+bounces-13269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7319E88C6
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 01:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0812810A8
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 00:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061E3DDD3;
	Mon,  9 Dec 2024 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ79p7B+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F5F1BDC3;
	Mon,  9 Dec 2024 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733705601; cv=none; b=RSi8wryV9QIB3RvS1ciGecEkW5ex/bfB+fcuV2sXBaIMJ3xz65NLhHwOLrMsuvfFKtJNPVDkeIsDbJjW/PagYqzdTd9POC68efmJNR1xMctiXlHzTyUc4A4LdHXv1BtFbc0iDZRJGG+d81pN0J44S2fY4upa4gqjY3Nh79q3sb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733705601; c=relaxed/simple;
	bh=+jtvOOatTR0HQ48lQ5maa+VKSxdn8jmz+97YOpGvpn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmXkYN8rqzqfe9OezuHD0F09ON7ZtuU2NbxIdYGFOryl/IvBnK71R+DeIIVH4PeVSsOuVzOqfpz4r7c6WUxZTG3CfxdNqrLYzWyEMjzi9ZNBRGFN9Sbk/EhojXwyrd6oBheTG9kmPq626Ks1X/quu3BhBlR6EnQQAtmPu99U8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ79p7B+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa69251292dso10771466b.2;
        Sun, 08 Dec 2024 16:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733705598; x=1734310398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phzb541nyfl8lWzd2UeSnP0wQBE9joQK4vJrW74ZtJA=;
        b=PQ79p7B+G1NkoDXIwu8Wr5lEkmDKxBUlIQ/PeWlY3qJzp7NrtTK9mSeoEvC5oUJASp
         egrW8sPbSOjvFlcDtLFvZ27zI5sUT+2QfQt/SSGTpEuJ1AioYZM4U1mdyRHVbYrWyEXJ
         TCOo8eaWh/neXXWCUqagByKrwBZA/UvpUkgf49pjYYraAWnYlFuuyxRIiqheDTJf1+B7
         9MEflEFgQWjx3JK/j8RNDPA2qUF1xpBfznFv06ngNzH4Zzr8NUSXlA16FogepwCgXNQ/
         FveCjVycvSPvB1Hsc3HwpR45Y7pZVdIIEGSU0IDjqPrxwe45owvtds/5BExcSuIWFPwb
         69Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733705598; x=1734310398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phzb541nyfl8lWzd2UeSnP0wQBE9joQK4vJrW74ZtJA=;
        b=PW1GzRhm/qQmmHPfv3W2USGBcJyyLiO0ws5y/Qk+04He9fiLNLL72xYQDcbsXTQR69
         i4nx/dBOYiMG3R5nbhEB+CspBbNqvBfBrZOQhIOLqtGuf+lNniVyMOYjQE0kJ4e641Ec
         yrEhF9LmksPD/HC/w5VRr9z8kzxQxK0ncYn1Bvt9t7p064hLZ0ddPn1wTjIzwmyII4FP
         lT8qPxBOI0kPbyMffuMDMaautRDDSR/aBOe6kG6nfZnp5fq0ZirUPCHYhXr5IuNRQGEE
         vo1AJwLMRqWo1ZHlYH/LUUZdTdO3G1wIORMiKjO9YL9fKTBIHXYTRuJc7r5Fef3L991k
         ZAEA==
X-Forwarded-Encrypted: i=1; AJvYcCVkmcp73HrTbuX1jevnOmitcKVxWaCLg9eHwSwlN849nADR7rC6lsPqfPC0vcjSSJF0676tOS/ZSHgW@vger.kernel.org, AJvYcCWk5lM7B3PFF4Wj6F6HYH1JOX/ZpWQrrmRQgWHnXLSxKe0Q0l2bHn5gU7Yw1h7PwYjE8CNCNDOMClxM@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSeVDJzt861vgOAXQSzizZx2pdxwvG9n9LxMnKJasGWr7QwnF
	Yz+7PDUE6P2GtR78C2mqCCFJ8HcPO52pq+oDVT/36JioIbgnqjexxhc154pgpD4Qq+bg4+khIsY
	rovbhr8TJ5IUeOGkItXQUdMDmEsE=
X-Gm-Gg: ASbGncusECseyjttKf75VHXcpd+ZbyJ4jBW1pegApC30FLYzLp7zkO3LM+vDrAzhk8V
	et/xfOH8i3LZRiNXYgEtzkZMWpOJpgz0=
X-Google-Smtp-Source: AGHT+IFfdvG8DX5nV08UVrpPr5GsdJplaPk5IE9L2X3PAj3mY4g1mQZg/aIRL68SuHyVVcqbHBIdIcgzAuDWxz3i7u0=
X-Received: by 2002:a17:906:3287:b0:aa6:715a:75b5 with SMTP id
 a640c23a62f3a-aa6715ad73cmr430615766b.46.1733705598098; Sun, 08 Dec 2024
 16:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
 <9e6def47e2e773e0e15b7a2c29d22629b53d91b1.1733504533.git.u.kleine-koenig@baylibre.com>
 <20241208124205.5b297fa4@jic23-huawei> <CAHp75Vei1g6iL0qWV2Y7+L4M+kJyLfUDoWd0HiXRbAWqQSR0qQ@mail.gmail.com>
 <20241208182346.423bfd06@jic23-huawei>
In-Reply-To: <20241208182346.423bfd06@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 9 Dec 2024 02:52:41 +0200
Message-ID: <CAHp75VdAPSqYS_CdVJcifoKy=D3ihsd5RG9N2DAfLs2Lz-F3Mg@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] iio: adc: ad_sigma_delta: Fix a race condition
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Renato Lui Geh <renatogeh@gmail.com>, Rob Herring <robh@kernel.org>, 
	Trevor Gamblin <tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 8, 2024 at 8:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
> On Sun, 8 Dec 2024 15:05:38 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sun, Dec 8, 2024 at 2:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> > > On Fri,  6 Dec 2024 18:28:38 +0100

...

> > > From sparse.
> > >
> > > drivers/iio/adc/ad_sigma_delta.c:205:13: warning: context imbalance i=
n 'ad_sd_disable_irq' - wrong count at exit
> > > drivers/iio/adc/ad_sigma_delta.c:218:13: warning: context imbalance i=
n 'ad_sd_enable_irq' - wrong count at exit
> > >
> > > I saw your discussion with Linus on this...
> > >
> > > https://lore.kernel.org/all/CAHk-=3DwiVDZejo_1BhOaR33qb=3Dpny7sWnYtP4=
JUbRTXkXCkW6jA@mail.gmail.com/
> > >
> > > So I guess we just treat that as a false positive and move on.
> >
> > I'm wondering if sparse annotation __acquire and __release may help her=
e...
>
> The complaint is (I think) about guard(spinlock_irqsave)
> so I'm not immediately sure how.

In cases like

 if (x)
   lock();
 ...do smth...
if (x)
  unlock()

Those annotations give sparse hints that locking is balanced. That is
why I was thinking it may help guard as well.

--=20
With Best Regards,
Andy Shevchenko


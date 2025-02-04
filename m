Return-Path: <linux-iio+bounces-14958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB60A26DC6
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 09:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3651885EA4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6BD207A0E;
	Tue,  4 Feb 2025 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QhySt0hM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F1C207640
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738659156; cv=none; b=dhAM/W0x7rJv6WeXkFwD749nwNxDuruV6JovJBrZEvBbFpreyisTDsil/kTEEMX1O7dXd1iBLGjgMyllF8A0y4Nkq22rjyuW8Ma6Iu6FwkzClQQ3WH7QWuk9Vh6mWYNV+0m19t0O/7szklfp/KS3z0B8xbrcpP6p3vmNhnk5XfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738659156; c=relaxed/simple;
	bh=HutRJSMeJRnt/VeA6fBVfyfIzPoRWNej7hPpS/LJnd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5miEs8O+qq+mfm88bP1RPVspOOa0jZA5fOXHFd+FpH7ti3K2zTFffKKXr48C+p2Zk63lzo1tARZ2ZZEKCoA20vvBVACTH91ro4xvZITu7zwDyPCNT2RXGLhDNAzSG+fuE0hrnTRpexJV8VkW59IOM4dr+2lx873YmNqER0jYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QhySt0hM; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30613802a04so51689901fa.2
        for <linux-iio@vger.kernel.org>; Tue, 04 Feb 2025 00:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1738659152; x=1739263952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HutRJSMeJRnt/VeA6fBVfyfIzPoRWNej7hPpS/LJnd8=;
        b=QhySt0hMEJ0xvBA2+3D7NGwSBvsVzp33uDy7u2SBmZWVPuA/oVJKLlEyrFPUaMBEfa
         xYGbBZCPgniM2k7OgdysO0kkVCgiDDElacQMcmi3VTrEeYZiKVOj9RfKjIdxJzv3gtUB
         hQi4DbDpbG7I9V70l+ZxsMvRk8z02OtAnKx2vhIUnTY7UUkXtO1Oa3boVysr3xybcyqH
         KRZ5lG8b8oRI4vacsT1F1TCtFwLEs8E67a9NHol6nqP6Z3bH7y2U2bbd6L5GOs7Kt/JA
         ZaodQoPoTB4qzCaFPqSXjysyyU3lLuulcf2gyMHqDtVlVWhpFYG5+8SCJO9soFJeHpBP
         wQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738659152; x=1739263952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HutRJSMeJRnt/VeA6fBVfyfIzPoRWNej7hPpS/LJnd8=;
        b=R5RzFLStBvo61XVhvAAH4slNwGDYj0+AWRHz0AS70Y3lajOtyR6CJcdCxicEWQ3RVh
         t2aoNiJWsFnX+JWJwqElymNYzNchrY9N+th+QUI5cTQkV3oUfQlfEdb2y2ir0gFXo0Z1
         fOjp+RYo9M7LgWG3lazZP6cI9Y4Y3r9k+fOmWCNpOyXXIH81fpxPGJhptsEAneqUGShu
         jKy8ZGLiXRrhZGuDKex+6PqpWEhqP2DD/Fja/w4jg1w/0EyY0enUf3l5pjyFDkFsktFy
         8hz67/etRWUb+ENosdW01UKlWrrzy2JtPInPM5lABX4lzpz/NszByKBLS4NM0JLcIWhk
         PfXA==
X-Forwarded-Encrypted: i=1; AJvYcCVIDylrS7CmFUonHoSpMjZpAxe+i6a3BDd1o3qHfT2tptn/72e1PnNrx8iWVniQuesOKArkDLK4k2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJLvnnSAwBZm7/HmZz49JrazonAZ7x8nLVdWN9y1D3trbZLGND
	7/zrFjML0Op474WYVP4KAyuSohhBzsBk6ps1F5ihO+y0LF1/Dl6ToPfXLnToHMFqBJrz/WKkaOh
	qC9yIjXmssegMtwolWMfGr8p0B3VuWNCc2aE9mA==
X-Gm-Gg: ASbGncvV6GHKg7kErwbQWJ7BJXQJz7U1GQT3KmWncGlQLCvAb+tp8HfBa/4yQdjw8Z1
	ezNZfFJjJeDl904HaXkg3VkWaaOBEm3gkASCBkaRId+lmA6FM2m0ujBKHyTdq3+QUgYMFXREfpC
	zVpxVdU4IemTpD7P7Serq6iVoW6JPT
X-Google-Smtp-Source: AGHT+IF3lsa7S5YwWpfcQVRJJ5PSQIykvInkMIj9GBvAH9xqe0CZdk0yaxGhiayetNv5EouQr4rP2NIVzzgLrFTtrHU=
X-Received: by 2002:a2e:a90d:0:b0:300:15d9:c625 with SMTP id
 38308e7fff4ca-3079684af3emr90981231fa.14.1738659151822; Tue, 04 Feb 2025
 00:52:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
 <CAMRc=MdwQL8dWU5zF5fp+KUbC2RA2Q264by8HGXMg2k1rxhsTA@mail.gmail.com>
 <9931433b-5cde-4819-ac96-eea4f1f0f1f2@baylibre.com> <CAMRc=McEdcDs01BAKN5vg9POg_xxJBY1k8bfgiDN60C1-e_jow@mail.gmail.com>
 <072be5a9-e0fb-4073-85b3-4a8efcafae09@baylibre.com> <CAMRc=Meq_Gfhcjzx0vCL0JPzfnOcijFgB6AuqtsqgGn1eOTMVg@mail.gmail.com>
 <CAHp75Ve+iwrm8dx49+6C7xFJgTQrh3XumKVzKvnYY=00J-j43A@mail.gmail.com> <b1c35782-f717-4fe5-8a00-7f13b341b5dd@baylibre.com>
In-Reply-To: <b1c35782-f717-4fe5-8a00-7f13b341b5dd@baylibre.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 4 Feb 2025 09:52:20 +0100
X-Gm-Features: AWEUYZkoSkw9yp224bcw4kgu34MNb3lBM2F-Kpo3dstTt1XbKUZR_n5bPczpQE0
Message-ID: <CAMRc=MdzeY7p8O2ovJ-Z9u-KzqfeEG7BxRvKHBHPrsFYDFAryA@mail.gmail.com>
Subject: Re: [PATCH 00/13] gpiolib: add gpiods_set_array_value_cansleep
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 11:39=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 2/1/25 1:47 PM, Andy Shevchenko wrote:
> > On Sat, Feb 1, 2025 at 6:22=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> >> On Sat, Feb 1, 2025 at 5:17=E2=80=AFPM David Lechner <dlechner@baylibr=
e.com> wrote:
> >>> On 2/1/25 10:14 AM, Bartosz Golaszewski wrote:
> >>>> On Sat, Feb 1, 2025 at 5:09=E2=80=AFPM David Lechner <dlechner@bayli=
bre.com> wrote:
> >>>>> On 2/1/25 4:36 AM, Bartosz Golaszewski wrote:
> >
> > ...
> >
> >>>>>> This looks good to me except for one thing: the function prefix. I=
 would
> >>>>>> really appreciate it if we could stay within the existing gpiod_ n=
amespace and
> >>>>>> not add a new one in the form of gpiods_.
> >>>>>>
> >>>>>> Maybe: gpiod_multiple_set_ or gpiod_collected_set...?
> >>>>>
> >>>>> I was waiting for someone to complain about the naming. ;-)
> >>>>>
> >>>>> I was going for as short as possible, but OK, the most obvious pref=
ix to me
> >>>>> would be `gpio_descs_...` (to match the first parameter). Any objec=
tions to
> >>>>> that?
> >>>>
> >>>> Yes, objection! As far as any exported interfaces go: in my book
> >>>> "gpio_" is the prefix for legacy symbols we want to go away and
> >>>> "gpiod_" is the prefix for current, descriptor-based API. Anything
> >>>> else is a no-go. I prefer a longer name that starts with gpiod_ over
> >>>> anything that's shorter but doesn't.
> >>>
> >>> Oops, that was a typo. I meant to write gpiod_descs_.
> >>
> >> Eh... the D in gpioD already stands for "GPIO Descriptor" but if
> >> there's no better option in your opinion than I guess I can live with
> >> that.
> >
> > gpiod_set_many_value_cansleep() ?
> >
>
> OK, taking all these suggestions into consideration along with having rec=
ently
> come across regmap_multi_reg_write(), I think I'll go with:
>
> gpiod_multi_set_value_cansleep()

Sounds good.

Bart


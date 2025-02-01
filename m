Return-Path: <linux-iio+bounces-14819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524CFA249A9
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E37E3A4BDA
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0431C07EA;
	Sat,  1 Feb 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGPUdHf2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DE017BA5;
	Sat,  1 Feb 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738422650; cv=none; b=TDfoJZMH+ontQUhMWk6gX9Pp3JrPDWKO/AFe43WMAATfjcQoDuBT8wKzNr54SL5GWJ7fYJUegOFPBVmM4MCHJjZ0MPWcBYdrjoK+en05B6fkqnNFv8N9QNJ6VBEJfwhWWRDvsChY5bJyw8GtQlABKLGwBgNWal0OyRSBea0iHg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738422650; c=relaxed/simple;
	bh=ESxYJN8LO93DuQxER3WQlpFWAbMknpRPqKYoTwe3w58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMj5/uPWiWi4c5v+CAqs4HOfcFn3pfLva+TpWccfY+ApWO7x/7nlnIePG03xdDGzU6YdKblotQ5aa50MB8/1v85R6BAoyvXNKblyMaIBwFAcJWvUW3KT8LFw4WUyigYgmqHVJ9TsxzviNICACrNzWymPSN2nwXutPD2EtlNqnjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGPUdHf2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dc0522475eso5972012a12.1;
        Sat, 01 Feb 2025 07:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738422647; x=1739027447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESxYJN8LO93DuQxER3WQlpFWAbMknpRPqKYoTwe3w58=;
        b=gGPUdHf2xZdF8NN+44IcfpTUoeazH5N25wqLVCSLAgs+0s4NFSTCTfpUVwkzbIVrYz
         cKcwNByN/YEFIZ7iRWv/dhcCtLGMt/+NywlRN5STaUl0NlAK/xpAchg5aBPXfKLqMM7v
         5/S/rM6huqDESNW3/fYTD3JfRK0zXyx4jV1h6JQ87Zy/gv9+khEKS35i9LUu8rXad/HP
         5k8DJ/+1hnHrIE/tYUe3RURagrBH8PM4ciEHIdv8lkqTTVz4jqs4IWE8dkRjKUpK5UZu
         oJMozPvNVdSN7u2pluFc/MkzE1O9p/K3ht5qy/A9dptT/rTSQ9Q5nlPeJL7UeJRElxph
         uK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738422647; x=1739027447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESxYJN8LO93DuQxER3WQlpFWAbMknpRPqKYoTwe3w58=;
        b=cs2i4TyRSXlZfdwkg8CArN6mFzaLS0DkXYKzfarzsOg8SFUMtGcqysRTkpXVeShv/S
         hWGB/nqNZklNz0uoVNsgxKtSWBP+K7ZiQBh/qK8j0BCruwSWoRrWRNvBAseSiXxcCsdz
         8ANEeUMdD5DMEC80mpcDN84T5GF1TUjPfiyPVcQ8IRU0ulHUhLHAulpV8//nWmJYki7j
         jZ0p3vm1V79QSF2gO0d0syOzd+Ty7eIOT6nK5rY3hjdpceU2H4y1YM3aWDZ2IRpkTNEZ
         5kqs8wGJGGVaWgjqnBno8h+SO5iUY3i73MooxX9p4WqAo9s5SYxhQAJHk8oe48MJGPY+
         Q/TA==
X-Forwarded-Encrypted: i=1; AJvYcCUmrfHfvOq3xCjeft8Lw0Hs2sfwD8V+Jke75Ma6qUW03OTFUmHWp3FAjao9M13VnJYbXhT5y+KF@vger.kernel.org, AJvYcCUwnwWIyPSQyAxAFgQr7oEGzzfEmb+yNdO1BUjjHg+PdVbjQkqAy+r9QJouoqNCoWYm9+6UnG3izoHq@vger.kernel.org, AJvYcCV0iJKLhZKFSq5f0QVhfaPRfh6anZ4MMcBOsYn8zGZvrPDsXMQ9MSMBO5urlvwV9ccvZocijjd914A+jlRK@vger.kernel.org, AJvYcCWG/4wVpbFxIp5/XmrGNxolOjtWnvIUe2kOJ8KpxVFxzOhudWRxx/i577qefHofcvVAYz0HjyPKbsED@vger.kernel.org, AJvYcCWSBxX4FgO4eePytX/HwvY0VZsAxYArm/ux0XvXvlefoOtVFAkTErO0fMRqD4gsZPUfROdSdciRtNpp@vger.kernel.org, AJvYcCX5FqFv8NLIVM+7w1i2FjpXKFBhSNfsTL0keVxF+TAqMP1eDoSziccNib/+8d/1XUJdV55b9/kCDz+fVvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydu85pT5ZCARVXdRJZRPscYcLVOoyuXRv8TSaxXGBwKg7vT4W+
	PXxX7+NQ+0qma2oXYIe6AUMvqQGO3pbTwwho66RvxvReGxADslbIZzm8igfLJwUQNxRpVya50J1
	7TsCurefQKY7LgFmF6z2ysfe6eOQPSs1M
X-Gm-Gg: ASbGnculrt4VTrwkNWHSDHMj9Lc+a0FbBsYI6U7Yjjbt/PwYvX6gdPvInf7/5/nwz3U
	KEtDjy66XN0isI/13i3r8eSqvIAgZVpz0pnFrM7fQlfRCHwHcImLrlzz+LLHrO0Uzlw27rujq
X-Google-Smtp-Source: AGHT+IHPgrNaOXTa7GqWwitfxkRWBG3TvzNWPR4XUMDvIyq00cafe/hSAsbw9bgwxCrxOiMYuV7eQGbqzKnExEBm6ts=
X-Received: by 2002:a17:907:7296:b0:aa6:73ae:b3b3 with SMTP id
 a640c23a62f3a-ab6cfd10a18mr1638424866b.32.1738422646569; Sat, 01 Feb 2025
 07:10:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com> <CAMRc=MdwQL8dWU5zF5fp+KUbC2RA2Q264by8HGXMg2k1rxhsTA@mail.gmail.com>
In-Reply-To: <CAMRc=MdwQL8dWU5zF5fp+KUbC2RA2Q264by8HGXMg2k1rxhsTA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 1 Feb 2025 17:10:10 +0200
X-Gm-Features: AWEUYZkrnYfcY0HPvRPT8411yweedOSpoNuc0S9BpdhPvgLvzrOaZ1BtCHgoJXY
Message-ID: <CAHp75VdjLWsQJ6CFGdSSEHR=e53h60LGfBcS0mYjeMjzUJuKJQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] gpiolib: add gpiods_set_array_value_cansleep
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: David Lechner <dlechner@baylibre.com>, linux-gpio@vger.kernel.org, 
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

On Sat, Feb 1, 2025 at 12:36=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Fri, 31 Jan 2025 21:24:40 +0100, David Lechner <dlechner@baylibre.com>=
 said:
> > This series was inspired by some minor annoyance I have experienced a
> > few times in recent reviews.
> >
> > Calling gpiod_set_array_value_cansleep() can be quite verbose due to
> > having so many parameters. In most cases, we already have a struct
> > gpio_descs that contains the first 3 parameters so we end up with 3 (or
> > often even 6) pointer indirections at each call site. Also, people have
> > a tendency to want to hard-code the first argument instead of using
> > struct gpio_descs.ndescs, often without checking that ndescs >=3D the
> > hard-coded value.
> >
> > So I'm proposing that we add a gpiods_set_array_value_cansleep()
> > function that is a wrapper around gpiod_set_array_value_cansleep()
> > that has struct gpio_descs as the first parameter to make it a bit
> > easier to read the code and avoid the hard-coding temptation.
> >
> > I've just done gpiods_set_array_value_cansleep() for now since there
> > were over 10 callers of this one. There aren't as many callers of
> > the get and atomic variants, but we can add those too if this seems
> > like a useful thing to do.

> This looks good to me except for one thing: the function prefix. I would
> really appreciate it if we could stay within the existing gpiod_ namespac=
e and
> not add a new one in the form of gpiods_.
>
> Maybe: gpiod_multiple_set_ or gpiod_collected_set...?

+1 here, i.e. I like the idea, but the naming needs to be amended.

--=20
With Best Regards,
Andy Shevchenko


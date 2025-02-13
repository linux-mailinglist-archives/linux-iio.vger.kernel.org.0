Return-Path: <linux-iio+bounces-15499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573EAA34C33
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 18:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28151887F6F
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 17:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9032222B4;
	Thu, 13 Feb 2025 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YsnRVMjz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3DA28A2B2
	for <linux-iio@vger.kernel.org>; Thu, 13 Feb 2025 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468554; cv=none; b=N4b/lea0td4XvGguBfS28U3k//fynT1Q2MA+4uH2cq3u8LcuZY5Dxx9vwZAVzYWrZSk4RtsOcgi0/Qu7fJ9vFNsQy2Cf7MoJMgvzZcJjUIhN/rX/bG5iu55hu2FcDzl1iVah0NUeG6x5aHoD45NtLWJkUZjPd0XHRFdsCTDcrQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468554; c=relaxed/simple;
	bh=ry5HU2b5JpTWT9D21OGSEN89Xcj4kAma40gpiFnwdJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFt+CO9vlea+9DKqT0HRS2U2P5wC74PHxVy9CtK4VMY82ptRcvDY6N4gWAnjEDiMi114AORGbf295+Y2nQdavkV9TBb9TbraW+DMv5FRoe6S4iYAccMAL+ygz9n7fHAHzohUxkvQLIh4CKTTjoCVV2l8v4ZCABBRhKX58miE9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YsnRVMjz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54508b026d1so957139e87.2
        for <linux-iio@vger.kernel.org>; Thu, 13 Feb 2025 09:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739468551; x=1740073351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7poaTbadceb30IF+pZHsHhZOoR9b8z1fPvVtB4cPUk=;
        b=YsnRVMjzJpPBywIoYZCkd40noCATJ91FhwUJPHKaTaC5FOJQEwcOwlDqAvaHXqvm0Z
         CU4elwzrofsWwdQSvQiYO1hWORw3Z+62DEHhDGrCmIbikCcknlRFciQXerV2e2i3cDA/
         AfD8pviyuSDCjbF5YE2hPy7fvBPLyJoLniHlKHa0DAvIUdNw1GLmZkpBZnIDjEfXfDfK
         dMIv3VUkCFRVc46vU67s46hNoz2AZu4WCp41nITN1eB4E3qkxQLyljvBIG97NDXub+Zs
         rPkwcTfCyY8cJ8mVpJr5xyE8ktDb017ab7j/XLJ7AYMKrfJXdki3HfDwesmN3gVeuFRh
         gO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739468551; x=1740073351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7poaTbadceb30IF+pZHsHhZOoR9b8z1fPvVtB4cPUk=;
        b=mhIMf1gM/N8cNkSBqfd3r4Xlwz5uJl7ygGNXT3zsVqKlSwYqYW/zjH2WLzj3FjKtB5
         urtUOSLNI6hxjglMUqOKXDNJ/N315NnmqODnb3ROO988Qofyw2VoxkpB+xVqmvlNH1YT
         xU/iWw0vMrpU1rjH/uOQ18UQSr7up3gzFIdt4TSyKMX7dHYDyJNglBJ7lSr1tl1VJH0z
         dhuQM6sleIdR/ps8qRrFp79XgbpICDiTOQfjNdB++ebLlNELVPKgEulYgSLxaEm+CDxY
         c+744gKbdSDIx2x3YuM5UkWFHxLD/v1PqLDJ8lPqZi/tdiwwsaIMvbUS24/uERJVLz+b
         DGzA==
X-Forwarded-Encrypted: i=1; AJvYcCWiRrGLHKWfdK5eVowdw94vaEmqGIz9thzYN0ZuNfMyQCTSpKraFib0DLlrF3pPIawHdWaNirRY3o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTH2R+YRtV5UldldMY9FwFWSEL8n+VCV1PGE5clreRjT14M+kh
	R49cktqI6AfuckmPu6Y8bl7+1gG5brchhPns7NgmZgW/rH3kY4NVTfoYAH7HjPCsVCEg5ahL3hY
	ZWdGDCChT5O4/ECCPggby1mHnBbAjlHcB8HQ07g==
X-Gm-Gg: ASbGncuGYE5rmTYPGvxdA0GuvhCLLUXqp6hAkRN/NC/X7SitG+aQ7j0RPKETuIrf3wp
	2GIbW/aSHDH0NPQLnGLnCxkL+Qsog9m7HDHjRrW7+jn2P6kLVR3if72HHJqS8IOj4F4kohs/bCV
	soxUG6tRYF9/ZJUNKCJuhIq9jull9n
X-Google-Smtp-Source: AGHT+IF+fWjLMy4RC4fJfJhppdyGnDeRMMDIkKzyGd/CQOlFqBivCx8W/IGAYdJvOJJTC/43hOWG0nQaRr0ngZJNi/U=
X-Received: by 2002:a05:6512:3d88:b0:545:8cb:2183 with SMTP id
 2adb3069b0e04-54518122c71mr2468700e87.29.1739468550462; Thu, 13 Feb 2025
 09:42:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <173935301204.11039.10193374588878813157.b4-ty@linaro.org> <801b5364-129f-42e9-bf9a-a90d9eeb4629@baylibre.com>
In-Reply-To: <801b5364-129f-42e9-bf9a-a90d9eeb4629@baylibre.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 13 Feb 2025 18:42:19 +0100
X-Gm-Features: AWEUYZkzHoDq5i_PpQBC_MEOqx6J4QYBMs6-RGY-gc-y6YI9Zv84ton-OV3XB6s
Message-ID: <CAMRc=MeXTvPnEPjOmPd5Vw0FYKHzndsB0SVjQErA4CY_0MGsMQ@mail.gmail.com>
Subject: Re: (subset) [PATCH v3 00/15] gpiolib: add gpiod_multi_set_value_cansleep
To: David Lechner <dlechner@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 6:25=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 2/12/25 3:36 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> >
> > On Mon, 10 Feb 2025 16:33:26 -0600, David Lechner wrote:
> >> This series was inspired by some minor annoyance I have experienced a
> >> few times in recent reviews.
> >>
> >> Calling gpiod_set_array_value_cansleep() can be quite verbose due to
> >> having so many parameters. In most cases, we already have a struct
> >> gpio_descs that contains the first 3 parameters so we end up with 3 (o=
r
> >> often even 6) pointer indirections at each call site. Also, people hav=
e
> >> a tendency to want to hard-code the first argument instead of using
> >> struct gpio_descs.ndescs, often without checking that ndescs >=3D the
> >> hard-coded value.
> >>
> >> [...]
> >
> > Applied, thanks!
> >
> > [06/15] gpio: max3191x: use gpiod_multi_set_value_cansleep
> >         commit: eb2e9c308d2882d9d364af048eb3d8336d41c4bb
> >
> > Best regards,
>
> Hi Bartosz,
>
> Do you plan to pick up the other patches that have been acked
> as well? It seems like most folks were OK with everything going
> though the gpio tree since the changes are small.
>

Jonathan requested a branch so I made one and sent out a PR. I figured
people would just pick the relevant patches into their respective
trees? For patches that won't be in next by rc5 - I will take them if
Acked - just remind me.

Bart


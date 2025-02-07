Return-Path: <linux-iio+bounces-15113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB01A2C289
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 13:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D7218812F5
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 12:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837A51E1035;
	Fri,  7 Feb 2025 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl3GFrm9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F0A7FD;
	Fri,  7 Feb 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930856; cv=none; b=VBRXehH1hJyIgA4qfGn4FQBv0kl/5Pe9MC7JO42CoG68vVEzKEOw5MZLvGj6yBZUvMhgd+EadNWFfx/qh/zLARVGW1cDE44Sz0cT+UldD+xGluyTHlIP3BwAvnUL7VibGMaAlcb2N2cVUwu0aTcHpzhlMkGdmAkiPTYPjTFBvAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930856; c=relaxed/simple;
	bh=a54mOet32eur3UH8ItkoAvMxfKNhEKaOIWBLSYbvLSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VriZtkutNIlYpxBSH4PORJQtgx6UkCFQNT40WRgni8byDVfrkTJiOrxrTiQ+meT4YYO5Boyu84w6bd8UvbbLtybGFy1hRSaGu7rVZ/ikO9DiDpgdSwhNcNQd8nyYCjZts51cUO9XloQx4ZH1XL4IvhfRXrjuu2vnmq917RLeGsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cl3GFrm9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso366499866b.1;
        Fri, 07 Feb 2025 04:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930853; x=1739535653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a54mOet32eur3UH8ItkoAvMxfKNhEKaOIWBLSYbvLSw=;
        b=Cl3GFrm9deRMNBDmGo/v09OGvHDpg+1wcX0MGboK+FkV4lFSu7z48MTLgoKhGOFHiM
         dPJM5LEYg451fHwIROmRgURV8s5BIFhk2N0bGi0i8KfGqC47G/zfjygBgxHDlHnvDcIQ
         V1BRCn9jQBku72VR1DF/eItSf8ToxhAsFpCN18PD7nv5WhmaVBcyeNBTUqdaIv/FlSBJ
         zTb+L0PXXAlX0gHIq65/gt79snbeO9iJBYIfETi5EpSW+7O+WvIiNdZ6KWcCpBoavOJO
         yUK8C4csVVIpNbkCCavGsuWA0Kxxeyf5CZFPTFQDRKui3Ga7118XGK6+fn8sCiDI6qX5
         y3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930853; x=1739535653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a54mOet32eur3UH8ItkoAvMxfKNhEKaOIWBLSYbvLSw=;
        b=dK5tcmj2PLrJoR6gW8+2v/1eT5IKLLEF6zpaX6VOoP2LhWOU51B/U0z0xKs3tg3nJv
         9gwbpaRy5EbxIDHZwqAKefwdZX+0RiXIYK0H1WenocgRs0Z5q2jj/AO6Ji5JO6ky+ppn
         LsJKiRQrIsRliZcTCjCop3f40wSVXvAEsQL0DxZN+POxFuBOlyv1TChTVqK437YdCe3Z
         M0eY+FSgIAV3DJhzFFRcoLx+r6+nkagNApQMHPrbEE6UQEpQbP6IzXzQmS8qDwa6wkix
         zlazN4/4VX/IYRQa+8kRybU+RDqhrnzJjZ2XTe2QwU2Jwb/x9FL2BvsQk1D3X73duy4r
         cA8A==
X-Forwarded-Encrypted: i=1; AJvYcCUUAxAfM/T15pwJ/AtNcCw3yFLEKNB1MX15B9ZNvrJ1ecjNRwF0cfr8xIcLHyXboZnGYQ/4w39/nBr2aVQ=@vger.kernel.org, AJvYcCV0v63mPYiN9dI7SfpuFgXI5SLkhYOAiSf+H4h2dlSXYq35NOfpTXF4vflzKajA3Cgw8MM7rc5uJgpo+Buu@vger.kernel.org, AJvYcCX8PL0U55AEunDGKT8Rxv+KjgcqL4WH9PI2ZrPe52KtqqhNVhQtiMNmPswBNTmA5jVrcj+gE/8w@vger.kernel.org, AJvYcCXEsBPjK98wyq2FkGAwL9sv68z0sm3YkM2MMCh5d7bxWAjAQa5wJGGnASf4kcodUrjTi13Cu0eXOGH/@vger.kernel.org, AJvYcCXIWeAaw0ZOY6EKzvfcAsWc9/YkqnpmtMT4RRZ5YzxI6c6PcRj71B4ZmJI/P/OeF66hTL7bdRGZCJtB@vger.kernel.org, AJvYcCXKKEnUnoIhQph4qXY/3ciLO3L/eOlLiGYl/QZEKlRMO17eqUxksaMnjCG89YG9TJghuVf/Ke/pVV5C@vger.kernel.org
X-Gm-Message-State: AOJu0YwGT1huF2220tGmR5mVX53Eu3o9YdDzVR8DkvlJZ4ly/1nyxaK5
	2bUoTBB/pQ74lFe8TYkHhdWMojLwS+sMykQkMFnUbq5ozs65oit4ytb9dhxdH/SMQynNzX0BLgn
	svVK5P36Yvh9rIeBk2fTANfx3JXg=
X-Gm-Gg: ASbGncu68I7wOkxElwGb6MQFPMEA0GTJdcx8VpYc0I0ICbehOBktFba6i9uq8/w5gpG
	Zxit48dKaEBZyHP2yzRCqvj+avyYLtPqXtz8FMuTawWhM56JS6OsHz22W8cXCC4ywCCz2ajgiNU
	M=
X-Google-Smtp-Source: AGHT+IGoiY/D1TiKwL5GXSoLaYBfuEuXQzNiPDbnqOiNifB0jsQGA+mFrH+WWqi6hARBZNpJM2EqqyBf+cDjmszsmSM=
X-Received: by 2002:a17:907:c1b:b0:ab6:36fd:942a with SMTP id
 a640c23a62f3a-ab789c6cedbmr318216966b.50.1738930852678; Fri, 07 Feb 2025
 04:20:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
 <CAMRc=Mf9WQjVXvea7tHx0MJG2H8Yqxw=zGqvjp7dfD7+=huDKw@mail.gmail.com> <CAPDyKFoNuXpTEm1rLPvAgib+ugqr7XyETZhfrNr6ypOOKRwjXQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoNuXpTEm1rLPvAgib+ugqr7XyETZhfrNr6ypOOKRwjXQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Feb 2025 14:20:16 +0200
X-Gm-Features: AWEUYZlfwIvy7LIm9pIahL5l8siSqdVektaSns5lQfpSrtnfvAL7yjcR2ciezX0
Message-ID: <CAHp75VdmN2wqwwnea0gtTQJ+Y5twQaJp6iEL2esEMCHDi8bvVg@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] gpiolib: add gpiod_multi_set_value_cansleep
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, David Lechner <dlechner@baylibre.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 11:48=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> On Fri, 7 Feb 2025 at 08:49, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Thu, Feb 6, 2025 at 11:48=E2=80=AFPM David Lechner <dlechner@baylibr=
e.com> wrote:

...

> > > Maintainers, if you prefer to have this go through the gpio tree, ple=
ase
> > > give your Acked-by:, otherwise I will resend what is left after the n=
ext
> > > kernel release.

> > I can provide an immutable branch for the entire series for everyone
> > to pull or I can apply patch one, provide an immutable branch and
> > every subsystem can take their respective patches. What do you prefer?
>
> The changes look small and trivial to me. I wouldn't mind if you take
> them all (at least for mmc). An immutable branch would be good, if it
> turns out that we need to pull them.

+1 here, the potential user for immutable branch/tag is IIO.
The rest looks trivial and unlikely to have conflicts.

--=20
With Best Regards,
Andy Shevchenko


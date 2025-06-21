Return-Path: <linux-iio+bounces-20835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75852AE2B76
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 21:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB2B1745EE
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D285826FA69;
	Sat, 21 Jun 2025 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqRO8KZ1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA5F149C4A;
	Sat, 21 Jun 2025 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534121; cv=none; b=UMJbXNgKY3goF/2yNVOWiwQTBAEl7eOs96TWiSWEdzuHNClBIgEcYunsu6RkFxKZF6C5z1MM4g8UQ9zl2ApCUKcxuUE4PSzmzoAq8My9EY3TmwnlELjdWfX0fuiBRoKsJRRaGQnMNc0+lj4ALxkYF7YbfvsxGEg+HJTmFidYIac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534121; c=relaxed/simple;
	bh=S4OKtTT6cWKlwgjl1Q3CUq8rOGPPkatKfAaWVfK8JkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtgvuRenQQQ7vMXlI0eUSzeEnYtSdshIGEgDXvuwLxp17Cg+wFI8H47tctZ6ixCT//GN3uvWZLWlBI3Kp8nbapAeX8n3W+YJiiuiaXhRRMPb+VPHJyf13LFqWz1mHiUCpHfiGMhDo+dp/kpBr8lhDNejjkSxmSSnZHsCZws3lwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqRO8KZ1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ade5b8aab41so601445266b.0;
        Sat, 21 Jun 2025 12:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750534118; x=1751138918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYQ4/itaUR6tob8HAxT8Q/X5YuehU1pRS4XG3Rk4W2g=;
        b=BqRO8KZ1+IXTonTjzbzZv+XTbBfuYn1vXI3IEY0g8GSErLbX8wQFQPWscJyALZSAq6
         s0Oe0cR/7TRj/kGcGhPspgRxRhsHmwPBXDmDG26Omdh7fkHxbKUAxPyb43/Gx/A99TvZ
         lWmsexbutKGd0msId5zCfAnSSas4mMglY39ebwTDv8J+ZGx6wySXte0OlpV2nfczH1JP
         PIPntjiZq9OWtyRNG3yrEh6PpzF7xwboAGQ39tCQBcpaQ0dOGGOs5rLk5qnwFbuKkyfX
         9w+HjrYyYwZ1LljIjiQNnXijtjqd2SlZT66aNhHjMmao5HxFHBNx9OT0+gPxsEBKrMLq
         FkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750534118; x=1751138918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYQ4/itaUR6tob8HAxT8Q/X5YuehU1pRS4XG3Rk4W2g=;
        b=O7IzGp+hNUVD925WOItwUrmWO1uf1Se4vOA+3930nh2e7Hxp5GalOxNIFgpsuxcQRj
         U0UKuA3GHY6mZLGEzhmWHSZ7Zct6946JV8qKZHqjQ4y6v/uJjSx2W80lmPJd60XDhsdB
         gQWrLiQ8DyYWyI2mZDzqV48RzVj5D3MiXdh7drs2uby4Pt3vI1XASwhwqF/XwSsbSjze
         acMC7EMHgTbvBXb6pmu9G3MHv4cgcGMVmztt7eQSQRt1FSBQjjgmk/ydSpIyVLs8Uo50
         wp2a0U8WynhF4TT9FGQq6ywugZ0E1TV8BnKfBaRw/DuvNNGcS1B29dtU9tLrLAcGnKiX
         tBwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5zhxfZTVHIp0IpmmViz5Sdfh0Iebpe7BUys/vOTwYrzGm+JaKEd8vIdz4Nn1Mtc3zCJd8lK8IZQU=@vger.kernel.org, AJvYcCWEx8C3rJaf+HveBNbqqjpoCJfnfmOHRK4YlA8iHLFPy0a3JcduoCkUwUO9NI/hHPs3hpkYO1rF0yam@vger.kernel.org, AJvYcCXlG5UjfXXKAbZ6rTJ6O04dq7b5VDOeHL55zvJGeC8lanwWlueUf1qLt/pIF6lzSc867VgXTCt8h7QSH1HI@vger.kernel.org
X-Gm-Message-State: AOJu0YzRO8N5x2BDIMmuAa+3iy+9g7e8uwbfKSjM9acD1/EZ1ZgcexN8
	wWM1dPiojG0A60nHEHSj8ySsVfvKSKHYZULPLrzK+DlB4sb+pnrX6Selw04jjLq/QLatARtDwJ6
	UYzt/svWtoZmB+8KjWguSo8JckLB6jpg=
X-Gm-Gg: ASbGncvazsAK5AmxItgfW2BkQrTEjgLlT63IiAT93H16T0mx4q70phgTzEEbeitMg7A
	NbMRs1KlbuROA1D48abc7WCp0vM3PNDtfD1wNJxivbN6KK5odQ9jd55d+yFQsREYp0eDOu6N8dL
	qBZjo+bdS8XvAzQvSOWxmDvlhRdo04WoDHD7df+2h5GHw=
X-Google-Smtp-Source: AGHT+IGq4wdlZtzL7/eUZnOvJdxZsa9RJazImtZ/DLpYCh8M2bkcJZ2WqbFB+XVyYbn+lvT0ARUe1vhYgow95ctqU1Q=
X-Received: by 2002:a17:906:6a2a:b0:ad8:9909:20b5 with SMTP id
 a640c23a62f3a-ae057c3ceb1mr704858266b.56.1750534118213; Sat, 21 Jun 2025
 12:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610215933.84795-1-l.rubusch@gmail.com> <20250610215933.84795-9-l.rubusch@gmail.com>
 <aErE0xmlm4qBHg03@smile.fi.intel.com> <CAFXKEHao9xKsizGLMQxikcLbG5Him9n9i3btLtqK2Orj_39a9Q@mail.gmail.com>
 <CAHp75VfxqMh8j=TAPFXTDx2PSPVU=No=vDdo+-J-ETDavuYnRA@mail.gmail.com>
In-Reply-To: <CAHp75VfxqMh8j=TAPFXTDx2PSPVU=No=vDdo+-J-ETDavuYnRA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 21 Jun 2025 22:28:02 +0300
X-Gm-Features: AX0GCFsnAsR5Ei8YbwLlhR2Ri10EzbsrReRb2rkRRuCTnBFAkwAXJzvprrgTzcc
Message-ID: <CAHp75VfCJSytzFHKAjCiW8xBsb+qQQjb7kyBnoH14FWtqmJkGg@mail.gmail.com>
Subject: Re: [PATCH v9 08/11] iio: accel: adxl345: add inactivity feature
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 10:24=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Jun 21, 2025 at 9:54=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.c=
om> wrote:
> > On Thu, Jun 12, 2025 at 2:15=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Tue, Jun 10, 2025 at 09:59:30PM +0000, Lothar Rubusch wrote:

...

> > > > +             val =3D (adxl345_odr_tbl[odr][0] > max_boundary)
> > > > +                     ? min_boundary : max_boundary - adxl345_odr_t=
bl[odr][0];
> > >
> > > clamp() ?
> >
> > Isn't clamp() dealing with signed ints?
>
> clamp() is a macro.
>
> > Also, I'll take the diff from
> > max_boundary here.
>
> How does it affect usage of the clamp()?

I see what you mean, but this can be done by clamping the signed values.
So, in any case try to improve this and add a comment explaining why
the maximum boundary is adjusted.

> > So, I'll try staying with the current line and hope
> > it's fine.
>
> I suggest you spend some time thinking about this expression on how to
> make it easier to read and understand. In my opinion clamp() helps a
> lot in this case.

--=20
With Best Regards,
Andy Shevchenko


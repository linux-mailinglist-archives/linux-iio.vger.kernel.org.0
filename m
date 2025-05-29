Return-Path: <linux-iio+bounces-19998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35EFAC7831
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 07:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE7D50362B
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 05:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA93264FA0;
	Thu, 29 May 2025 05:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvr+/7OF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192C7265623;
	Thu, 29 May 2025 05:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748497406; cv=none; b=jf52/haKX2BurqfSl3xuCmc3aBDgLLGBjCnbptr2ooTJo8OxnCKUUoCKo0TfJ7mEmlRkBEmut1wON01j22+QGSh238BtrXDnJ+Roe0lq0ULJ595CRX7khdLUS6vU1XZP0O+oEcYhlCxkMHQNmvlXQWvMycO+uvQFJPvFzIHAm4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748497406; c=relaxed/simple;
	bh=8h6UqYy6eQh8UhHHfZ1AnwFWgdsRIGY/Pnr4CW0Cie4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqHmmDmqgOPy4vwnYxGDroZGqAlvpTUEZqutDMDPcNUQ7AIxYZhVv3UcK4kT8EnULHunOAiqIbYUgdlOz5Hjbydxs6/jByIKXRk9Sw4dBsFth2RWA8UmYi1i7fXdjtst8uq3330Fnhh+sQvxpPXx3goFZCHz+RZNhgl08WHee0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvr+/7OF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad574992fcaso89314966b.1;
        Wed, 28 May 2025 22:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748497403; x=1749102203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91m00KOPKqAhxAOXF7AdqmwKSx+GFz4yTWglZ94qqh0=;
        b=cvr+/7OF/OYFTcgnGNzK/AZwvWF6I3jhCVG1nfFvsFhPR3ylhJKhwk7Ke7bon/b3ph
         0ObTJvIn1/FyY5jl5ebo/cW2E451vWREtsbDA9pJfLYNSzuR/+77CsVNh+D37z1pkSiz
         Ju+KfqnAcvpM1f6CLjduio6yhmItBQn29Pwm4Ib1lMFLpn1M42l21UiVY/FOke3Dp2uT
         QWgvPGdiJw8mkFbA57vA7qXXLUqI/jW7n1C1mYnR+mL9jWclX+8ytgQupxqMf+2wY4X6
         nSgjOjI/e8uuGeo+bjAav+CHMKI/PbHoWcTIXak7M1qoDL/XmKpuJ1uUklo18/qHn8g7
         q/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748497403; x=1749102203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91m00KOPKqAhxAOXF7AdqmwKSx+GFz4yTWglZ94qqh0=;
        b=noc63he8KdWYFpogwiRmbJh+QRciUiRu0fxwM/EFX38iUp6yrniWURtBIMrUUExIsJ
         08htKp9/afCVGjtsshzM2adt4BpUh+Z9ZMnXgXs+pksswlRe3InVyvGB+6k6KW/mUyBw
         AuaZW7Bl6XN5cWOsSZPuVnmVDMGjCnhsg75fIWAr+EHLW4zAPJJh1ZF8lqWXC/ueHadp
         CjB2eUhcQiv197a3QXkH0OH0yu5efKpq1AJgvk4dg48UZ8MwqEpd3PWxvCQwNo0/GNQa
         AwIDPYwRPCvW+WJ+QXHTXEVNqCsvAGunDRpTq3XLHakAXaPf+mVco93n52pYmu8SuQPa
         +v9g==
X-Forwarded-Encrypted: i=1; AJvYcCWOS/bPaRCmqwM3z7kCkI5iOU6oSxwGkRjlouRSzBC6lQrKdYvuXcMoMdnCOkv7RbUHDNSULbYqDDm0hlQc@vger.kernel.org, AJvYcCX/2+JYgzeX9cNDZai4H8gKxBkaUSCE0OzDJcJ54rAkQoczFFy+ZcYnWy7KatA5hfep3+Ot0qW57Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3OjKkA61KP7P9SMmVwNW31ebwqiuH+XF1qVG+TqUE4TC9lOsS
	vQdrsx0AkQ3tN9UiC6heR3WV8ZFR5kq36HxTXyd45QeRasEIGNYyKM8Sbyygoh34W1b/rDSuWxl
	1jgh0jBsBpIYg1Ne5wKhdI308Zl9pKgg=
X-Gm-Gg: ASbGncu7b6kfcdIYRBxy2OwYjMEZ1rCO4OFDcOB63jo+ZRSs1KkXvW0xBtzoyylmsnA
	2ndoeddUlRvPLwREWsPaeYNBkjXEM4i4tKgY2Yp1WXMpjk8mJD+wL7yrepoe7hhTYsaHG/I/Zv1
	9i/SEK40D3Cau05QyqHCA8H2t42VkZZP6ZPETG6OL7FBCY1w==
X-Google-Smtp-Source: AGHT+IHFITTJqypSQIQUaeCvI5fCs+IEhoVxF5pNBP2RI9WF2ldNdg562/uwxhowfwbCkClGch7COKrW9k3nQiFO1oU=
X-Received: by 2002:a17:907:868b:b0:ad8:aa2c:dfe3 with SMTP id
 a640c23a62f3a-ad8aa2ce37cmr319177566b.59.1748497403101; Wed, 28 May 2025
 22:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527200534.98689-1-gye976@gmail.com> <CAHp75VcUr7-X+F1f=wPH4=Z7q3kFffv8BgkmKWM4VTjy2w-tGg@mail.gmail.com>
 <CAKbEznuuGX3Gnqg6WF2mqbigRps0gzK_PfGHGNy8-v1WOZoMUQ@mail.gmail.com>
 <CAHp75VfEeNyspiMSax1_d+cpbmCQQVbOBEPCHuAag2O0ZHC1jA@mail.gmail.com>
 <CAKbEznt7ZhN9gZWy-7wHhFhwbF8XtCGrukuxe4eAFZpfxfu6vg@mail.gmail.com> <20250528180214.00002253@huawei.com>
In-Reply-To: <20250528180214.00002253@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 29 May 2025 07:42:46 +0200
X-Gm-Features: AX0GCFsr-52UgU7OTbDHca2TsgtybzFgxtr1LZvlY1UivEOK3iUWkejYE_wv0is
Message-ID: <CAHp75VdBMXCBYiDX8ocyOZBm_dhWJSU_NXJN6PmOwsZaJt=AHw@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Avoid data race
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gyeyoung Baek <gye976@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 7:02=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Wed, 28 May 2025 16:17:06 +0900
> Gyeyoung Baek <gye976@gmail.com> wrote:
> > On Wed, May 28, 2025 at 6:19=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, May 27, 2025 at 11:10=E2=80=AFPM Gyeyoung Baek <gye976@gmail.=
com> wrote:
> > > > On Wed, May 28, 2025 at 5:25=E2=80=AFAM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Tue, May 27, 2025 at 10:05=E2=80=AFPM Gyeyoung Baek <gye976@gm=
ail.com> wrote:

...

> > > > > At bare minimum they are not relevant to the patch change and hav=
en't
> > > > > been described in the commit messages.
> > > >
> > > > I initially skipped this part as I thought it was minor.
> > > > But on a second look, it seems better to separate the declaration f=
rom
> > > > the logic.
> > > >
> > > > What do you think about the data race logic? Would it make sense?
> > >
> > > The point is valid, the atomic_read() + atomic_set() is 101 thingy,
> > > whoever did that doesn't really have a clue what atomic(ity) is.
>
> :)
>
> I'm trying to recall what this protection is actually for so this might
> be a little vague as descriptions go...
>
> The key here is what can happen in that 'race' and hence why I'm still fa=
irly
> sure it isn't a real race.  Firstly this is called in an irq handler
> so we can only have one call of this particular function at a time
> for a given trigger.  So no race against itself.
>
> The atomic part is about decrements that can happen elsewhere, but there
> can never be 'more' decrements than the value we set the counter to in th=
is
> function.  That is it never goes negative.
>
> Those decrements ultimately happen in calls that can't happen until after
> the set (via various convoluted paths ultimately getting to
> iio_trigger_notify_done()).  In many cases the trigger is masked until it
> is reenabled on the counter =3D=3D 0 (elsewhere) - but not always...
>
> IIRC correctly aim is to not double trigger in cases where we can't mask
> the trigger (a particularly rubbish trigger) - so if any of the downstrea=
m
> devices still hasn't called iio_trigger_notify_done() then we quietly
> drop this particular irq on the floor. We don't mind dropping a few
> too many, just dropping too few a then we end up loosing count of who
> has to be 'done' with the trigger.
>
> Hence the counter won't change between atomic_get and the atomic_set
> as it's always 0 which means no one else is left to decrement it.
>
> Atomics don't always need to be atomic all the time, they just are in
> some states.

Yes, but this is confusing and/or buggy code to begin with (and
independently on the background of its usage). Technically this patch
(perhaps with a better commit message) is valid. Main two points here:
1) avoiding potential (even theoretical) race; 2) do not spread a
really wrong pattern to avoid people learning from it (in case
somebody takes this code as an example for a new driver which might
reside outside of IIO and hence might not be caught by the reviewers
of _that_ subsystem).

Alternatively we need to get rid of atomic operations, but with the
same effect as 2) above.

> So, is this something that has caused observed problems, or based
> on code inspection? My remembering of what was going on here might well
> be flawed.
>
> There are some 'fun' corners for what happens after that set though
> where a handler can run fast enough in race conditions we end up
> hitting 0 in iio_trigger_notify_done_atomic() and have to schedule
> restarting of the trigger because that might involve a bus write over
> a sleeping bus.  That one was a painful bug report some years ago...

--=20
With Best Regards,
Andy Shevchenko


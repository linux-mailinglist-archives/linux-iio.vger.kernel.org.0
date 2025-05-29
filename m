Return-Path: <linux-iio+bounces-20007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF19AC7ECA
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 15:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385AA7A720D
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 13:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F66F227B87;
	Thu, 29 May 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV+Iuj1u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73242218EBE;
	Thu, 29 May 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525702; cv=none; b=TM3zsh4hk0vnM5gogYjvwZgWO6KzDW5OMybvW9evjMeicmsIa780s+qr8jumObcf6iZDwXLDefLS337Guy4DcB11RNbKnMD7WSdEcuY0shun9kQVwV0jqOjNpXyd8M8wE5MOqtYWLbxVGUVyv+fYMPeMXgTweccrkbOBEQer5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525702; c=relaxed/simple;
	bh=PgpPs/+dohID7WSPahcG5Nf97Wybz1kIZvy7V9MojdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ltx/VEOPwpLCj2zzhIA2oZlvgtbkiXceq9eo2i32UJ0VSBHbmw1m5wR9/hiw8nYhx66E0+lyXMjHzw+ZQnfPplC5WfCFe9g71BdipxTvsG90eecFIeKl3gMvaCbRCvizHoWfWnZtpXv2s2xN/rcEN2GwasabtjeL8tQvQEbvJnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV+Iuj1u; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3114c943367so940745a91.1;
        Thu, 29 May 2025 06:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748525700; x=1749130500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeqkDhvtp3nMyrmOeAqt3MnSL10EXrZRWUnJu7S9sto=;
        b=KV+Iuj1usttwVDxv55XSOY43MYGiXrx2+KobNbPErsWAzrj6A8tdYe+0gdegQ9txzr
         IxXZYNa16r7sEvYumuiJnptRrDBkW9Ef95vOtlc2g8tt00i3rQlF0I4GCrv12vdU1NYg
         HkrO1y46hKioIYXG0S4Z64qzRXIKs9WNZAfRxBnfvTFoe9b1uSNcJrCJfaCH9DDZEAJH
         eAw9GuUIXXYqAACcVjZfZeuzYJiG4QeBO1m48fQZQsM2jWaIRDujuecSUr/1u5dPz/s8
         ZtMvT7eHTQY/SxtAo3HBokinPrn2kuWWVc9EkP+9piZdeBWZCYS5thCoJt4WmzI5Oot6
         k/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748525700; x=1749130500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeqkDhvtp3nMyrmOeAqt3MnSL10EXrZRWUnJu7S9sto=;
        b=oJMHmBBlUxCew3R4NJneqYALrb0xkG3RoEWYz+MpYT7+bj6qpTf5HnOYTSmoeeCXjT
         49GpbCSbvK6uXRFaHxFRUTIOMRzcm1Kr+OtlVFqjKGRFN4Rq1AAxqPUt79sn/saDv7Xc
         sWUwb81yXShVwVwFf1RGEzUP9uZf+TGT+Iz7FHX6gtwmVmhvEQralquHtajZwWIMgPIq
         6969vYyx3zv/5g2opsZXIlwW6pz5j1jOr2LF5Hrn09dlasNr7tgVDpRivhoSSqwIpvaM
         Fzu/PmJTSfkwKvjONUkMzj1WiUhG/uod4TIKGeUgQKc/HRkmou5trDXpVvWucPpKjQVT
         JqyA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/WVk9fiRl1Ovmc3guRkQsyCLlwVwIwved+m4t4+rNpjuHIuOSJAQRvJmCSD1wbh46P0yyrBOnkU=@vger.kernel.org, AJvYcCWamw/JgpT3+624GbmhTNK7J4p4CSfHShldLcj+8AKozovDvPsS7QrRkI7n9OgRUcm4A9EncJdZUV2I0uLN@vger.kernel.org
X-Gm-Message-State: AOJu0YxCyoR/CLBv+zPKYphncw+rI6BQP7JA6AL+JoFGt6j6BoQMxfkH
	BQO9pN27WdpHjYCZrP5qH9r+ass2gqhB6qt/i3fDZbBE+i4j9APNnovRb0r2VaoECsKu43mkD/F
	0IhW2KvCe/Hsx1P7Z2lDLauFsVNABros=
X-Gm-Gg: ASbGnctwdGVsH4FAiI4e0p+mEinqHQ4FX54spPUxfqkLmdCOfXAdWpjtrUdAXsNbljo
	obEsyzXKTQAjWhKqKBZkK/AZRUdHJguyYyJtJGbM7dA9kjYWwzWpLwKa5ydXGIHT9E4K+6DTFoB
	JtIfLQtSZbney1/AO7rIZDBoFbYR7OOXSflA==
X-Google-Smtp-Source: AGHT+IG5TvtUi/7Ocsx81viKTveXbpMUjC8wOYCkRjkDSQ6ODB3eJtB5RDP+/qgnQW48o9GBtFKbzdf2DgDlPpHIAlU=
X-Received: by 2002:a17:90b:1997:b0:311:a314:c2cf with SMTP id
 98e67ed59e1d1-311a314c4bcmr13887519a91.30.1748525699585; Thu, 29 May 2025
 06:34:59 -0700 (PDT)
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
From: Gyeyoung Baek <gye976@gmail.com>
Date: Thu, 29 May 2025 22:34:48 +0900
X-Gm-Features: AX0GCFtRpBXqvXbavHfcdC6sWlfhnWjzajkk552UN52Ztlm0oGfU-dMgpmTtpTc
Message-ID: <CAKbEzntM7CvEtNT-SP_CFY0AhTabiDg5JGFdsM=BUd6K=UvCUw@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Avoid data race
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 2:02=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 28 May 2025 16:17:06 +0900
> Gyeyoung Baek <gye976@gmail.com> wrote:
>
> > On Wed, May 28, 2025 at 6:19=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Tue, May 27, 2025 at 11:10=E2=80=AFPM Gyeyoung Baek <gye976@gmail.=
com> wrote:
> > > > On Wed, May 28, 2025 at 5:25=E2=80=AFAM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Tue, May 27, 2025 at 10:05=E2=80=AFPM Gyeyoung Baek <gye976@gm=
ail.com> wrote:
> > >
> > > ...
> > >
> > > > > At bare minimum they are not relevant to the patch change and hav=
en't
> > > > > been described in the commit messages.
> > > >
> > > > Hi Andy, thanks for your review.
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
>
> So, is this something that has caused observed problems, or based
> on code inspection? My remembering of what was going on here might well
> be flawed.

based on code inspection.
initially, I simply assumed a data race because `atomic_read()` and
`atomic_set()` were used.
I didn=E2=80=99t question it further, sorry for that...
However, after reading Jonathan's review, I take a look at the previous com=
mits.
It now seems that there is no data race.

(I wonder why there isn't a wrapper API which does something like
`atomic->counter =3D val;` for situations like this,
    where only consumers need atomic API but not producers?)

Since synchronization isn't needed here, I think `cmpxchg()` may not
be appropriate.
I considered a few possible ways to improve clarity:

1. Add comments only.
2. Add comments and access directly like `use_count->counter =3D
CONFIG_IIO_CONSUMERS_PER_TRIGGER;`.
    (Wouldn't it make sense to have an official API for such direct
access in `linux/atomic/~~.h`?)
3. Add a separate bool flag to represent trigger's on/off state.
`iio_trigger_notify_done()` still uses an atomic API, and it sets a
boolean flag when count is 0.
Then `poll()` and `poll_nested()` would simply check the flag without
using atomic API.

I think `3.` seems the best.
I would appreciate your reviews on this.

> There are some 'fun' corners for what happens after that set though
> where a handler can run fast enough in race conditions we end up
> hitting 0 in iio_trigger_notify_done_atomic() and have to schedule
> restarting of the trigger because that might involve a bus write over
> a sleeping bus.  That one was a painful bug report some years ago...
>
> Jonathan
>
> >
> > Thanks for your explanation.
> > Then I=E2=80=99ll send a v2 patch with only the `int i` change, followi=
ng the
> > review feedback.
> >
> > --
> > Best regards,
> > Gyeyoung
> >
> >
>


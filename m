Return-Path: <linux-iio+bounces-13194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58529E7FC5
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 13:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E89228204E
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F04146018;
	Sat,  7 Dec 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxBv9g5X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D4A8289A;
	Sat,  7 Dec 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733573461; cv=none; b=VH2Mp0SF0O2eJGdC7yrZNrID/LcvOioxtfJsSi3C5DCn9GHSEQmtiU4E7bBu4qHmbL53rLtHq+ppKAz9SXpiVvr71urok2yFItEHfnESfIlXkGhR1t2fOp2L0gXtgJWFneMRc/EcLXmoE3wXKPKTgUAGGC/5dcRL9uB9Wsh3QOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733573461; c=relaxed/simple;
	bh=r87zteF2Hv61ybuLiEqk6fj4kZes/9P+raEzqFuYu1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVoM4kz+ixJrBbT18ikqDwXnvFUSnfzw99ZI5bWgN6qVmvBBmWmMMCQ2Dg1SHYrRBdx+DxQCus4Qm0D1j8FXdtnvbttnvCqktGw0EGjCqm5MbXHx51JqMhij3OGbP7b/azxEIbR0QAunkMAfkKu8NqZOiqF4eKZmSVSzVPagM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxBv9g5X; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e39885e1925so304506276.3;
        Sat, 07 Dec 2024 04:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733573459; x=1734178259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aw8Sw0c0/ZDBtbHXzSSnBq1C++U8b905nlDMZDdgykA=;
        b=gxBv9g5Xaee0EYwQxMmCjoZ8MglKhRjAxrnbC3VnCmW0tX77vrA1AOKup2duPdyH4S
         xFcMp8iRWDc+JyEvr/LJyBn+ass3vbWqFrreUyLVt6XodV0weDzqt7Mt5clQxF3heWIz
         QDJkvX+7351nJuUehu2qb1iz2rRh2hX+tXPRuk/iTDO/SQI5jyiUjTCzhiDPWaVahvYp
         JaJHnQ914lfEtg8xfd4wZkoaAYcApI5BRJtexd4jJRXUJE9I3zsaXgD5LMrWAPQLPxpi
         o3EvD4nWtD4ZTRmELzDV5at/rKU9h5E3+RjMzAEF6RpFL3lxP46cxnTwfN+2VGI9deSw
         jSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733573459; x=1734178259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aw8Sw0c0/ZDBtbHXzSSnBq1C++U8b905nlDMZDdgykA=;
        b=UfzLqU5tqAdaiD5Dpj3wuaViAE8+crLtzGi0SeXo3Wz/puBuOdfzutW56mJ0Q+G6JC
         Hw2thw4OPjlp60RP5dIuBy7ZYYL47mpbHHhzqIgRjlf0aByxmBuMR1rU7Z7x9s1woAh9
         HkTGuxdZhsyDizvjgJAq+PbUY9mLSwvy0Vz6o9+xn6F5GJTM0JSKCv7FDhPoHq/BJ3km
         F9nzuHo5U3cX44OmAxB+xMeC9M8FCqLWRhKGUR9K2zSKwUqf+bDCM00jEJ4E5r7bBtXF
         uO4BrqTPvEy9Kv+kRVsve9d/nKvamMVvymtsiLafSm9h77+FO3A0BG1di+VruiGwrcdS
         3a3w==
X-Forwarded-Encrypted: i=1; AJvYcCVE+tLcZ/3kZSXFzJHCvPboiiMd9SdTi8dkCBTN39TjJuZ2sAF3mc7AZROqTCSfzM9BexlysufX0qXb@vger.kernel.org, AJvYcCXlq4kIWRX4+iVs7oLP8DHgY5QJFZmcoRaB2xAI4FkgNiFp2DK2yi9nG+xgt7YUluBh2DLidH5Pqt1KtbKc@vger.kernel.org, AJvYcCXrXpROXDbqPlGM2POY6epLO7t/0NC05t/WebKSkB66dz+grvKCgw0Q3r/2WwBNLVI/gDVUtTAydNr2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe7gQKaFYm40wDZbSDw7QUTL8+GWYyGMRX6n1ATWssxC2QS+sm
	RbWrwze9SJt5oadl35u+Luxd7ZL+HKGhsejGItXBJD0y9GrdntWKnF1C4wvBwBHwAqV7BvV8A0K
	f9CMWBNCYHuNwE6Qg16q6lDpY7ak=
X-Gm-Gg: ASbGncvu/jwjSVGFozPQqv/rKtKAvJJDyZC9ouyV6IfhuFvQFVmnYm89vkW2KrbnfuN
	zpV32iSvgLXbVF2qm0VhBwUszZHOlQXU=
X-Google-Smtp-Source: AGHT+IEJLeVcUVEI1VZy0ASwSJ7JOuXlvYaZwinxmIXeobwn8KOzzEbls7GkyJmuPpoz3TJbEVUhEoKQHWM7MCvePfM=
X-Received: by 2002:a05:690c:290c:b0:6ef:9c5e:5c7c with SMTP id
 00721157ae682-6efe3ac6c16mr22824827b3.0.1733573458775; Sat, 07 Dec 2024
 04:10:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205171343.308963-1-l.rubusch@gmail.com> <20241205171343.308963-7-l.rubusch@gmail.com>
 <20241205-fraying-overfull-4fe3eb6c5376@spud> <CAFXKEHbGcTGBNH8Hrg3i90_-xR1KYyw_97X1pPMFB6E4ztL5Aw@mail.gmail.com>
 <20241206-settle-impulsive-280ce8dc312f@spud> <CAFXKEHb1NbV-Us3kaNyG+P90SMXsV7233dXd64_gbtCKst6gmQ@mail.gmail.com>
In-Reply-To: <CAFXKEHb1NbV-Us3kaNyG+P90SMXsV7233dXd64_gbtCKst6gmQ@mail.gmail.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 7 Dec 2024 13:10:22 +0100
Message-ID: <CAFXKEHYULs+GO4S4nUzkPC0Sx0KrDur7K3zdFvZn4A3_OEstXw@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] dt-bindings: iio: accel: add interrupt-names
To: Conor Dooley <conor@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 6:29=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.com>=
 wrote:
>
> On Fri, Dec 6, 2024 at 6:08=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> >
> > On Thu, Dec 05, 2024 at 08:41:52PM +0100, Lothar Rubusch wrote:
> > > On Thu, Dec 5, 2024 at 6:54=E2=80=AFPM Conor Dooley <conor@kernel.org=
> wrote:
> > > >
> > > > On Thu, Dec 05, 2024 at 05:13:39PM +0000, Lothar Rubusch wrote:
> > > > > Add interrupt-names INT1 and INT2 for the two interrupt lines of =
the
> > > > > sensor. Only one line will be connected for incoming events. The =
driver
> > > > > needs to be configured accordingly. If no interrupt line is set u=
p, the
> > > > > sensor will still measure, but no events are possible.
> > > > >
> > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > > ---
> > > > >  .../devicetree/bindings/iio/accel/adi,adxl345.yaml         | 7 +=
++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl=
345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> > > > > index 280ed479ef5..67e2c029a6c 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yam=
l
> > > > > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yam=
l
> > > > > @@ -37,6 +37,11 @@ properties:
> > > > >    interrupts:
> > > > >      maxItems: 1
> > > > >
> > > > > +  interrupt-names:
> > > > > +    description: Use either INT1 or INT2 for events, or ignore e=
vents.
> > > > > +    items:
> > > > > +      - enum: [INT1, INT2]
> > > >
> > > > The description for this ", or ignore events" does not make sense. =
Just
> > > > drop it, it's clear what happens if you don't provide interrupts.
> > > >
> > > > However, interrupts is a required property but interrupt-names is n=
ot.
> > > > Seems rather pointless not making interrupt-names a required proper=
ty
> > > > (in the binding!) since if you only add interrupts and not
> > > > interrupt-names you can't even use the interrupt as you do not know
> > > > whether or not it is INT1 or INT2?
> > >
> > > What I meant is, yes, the sensor needs an interrupt line.
> > > Interrupt-names is optional. The sensor always can measure. When
> > > interrupt-names is specified, though, the sensor will setup a FIFO an=
d
> > > can use events, such as data ready, watermark, single tap, freefall,
> > > etc. Without the interrupt-names, the sensor goes into a "FIFO bypass
> > > mode" without its specific events.
> >
> > What I'm talking about here is how it is ultimately pointless for
> > interrupts to be a required property if it can never be used without
> > interrupt-names as you cannot know which interrupt is in use. I think
> > both should be made mandatory or neither.
> >
>
> Ah, now I can see your point. I agree that it should be equally
> mandatory as the interrupt. Legacy implementations used simply always
> just INT1. I'd like to make it configurable in the IIO driver but
> tried to avoid the DT topic for now (which was not a smart decision
> either). Hence, I added the interrupt-names.
> I'm unsure should I make "interrupt-names" a required property now?
> What about the existing DTS files using this sensor? There are no
> interrupt-names specified, so if made required, the missing
> interrupt-names there would break binding check, or not?
>

Sorry, I have to clarify myself, yesterday I was not focussed..

1. I agree this is kind of half way. Either, both are required or none of t=
hem.
If both were required, also the older DTS files using the ADXL345 would
need to be "fixed". If I add interrupt-names, it works with my patches for =
the
"newer" IIO driver, because since I implement it it's using interrupt-names=
.
The older input driver for that using interrupt, does not use interrupt-nam=
es.
Hence, it requires the interrupt in the DT. But it does not require
interrupt-names
(historical stuff).

2. AFAIK the sensor can operate w/o interrupts.
A) w/o INT line: measuring is possible; FIFO bypassed; no events
B) w/ INT line: measuring is possible; can use FIFO; events are possible
When setting the interrupt in DT, the interrupt line name can/could be
configured also via SW (setting up the registers of the sensor). So, it's n=
ot
impossible. This is AFAIR the approach in the legacy input driver. Now, the=
re
is devicetree, and both should probably be better configured somewhere in
the DT

3. IMHO neither one, not the interrupt, nor the interrupt-names need to be
a required DT-binding.
If interrupt is required and interrupt-names not, it's a half-way approach,
which leaves specifying the IRQ line open to be solved partly in DT
(declaration of the interrupt) and partly in SW (configuration of the
interrupt line to use), e.g. hardcoded or configurable somewhere in the
driver via sysfs or the like. Not nice.

Pls, let me know what you think, and in case, if I need to take some
action, here.
Best,
L


> > > Hence, I better drop the description entirely, since it rather seems
> > > to be confusing.


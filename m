Return-Path: <linux-iio+bounces-16584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C39A57E8F
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 22:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA231892677
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185FE20458B;
	Sat,  8 Mar 2025 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODACHIm8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E41E25F7;
	Sat,  8 Mar 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741469234; cv=none; b=HLVHwhZ4ktI8XA9VgQ6h1MZ6891y7qNyxO3Un8gfpL9OZEBFoqgXn8L1zXjQcp+gnPRZhjC3POXnYvMNtp4AD0BEwVFYMuAWkPxln3o1pEpF+B3cu6X0oL1qyOmJ1SYzBiCslfwZwueUDw8WOmdrVrJq+bZyH7tyRDis4/clwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741469234; c=relaxed/simple;
	bh=EaY/agzfScHykGn8A/LRbd6yTlZC2sbtxmAuEdpm9zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRsL1CBepiFP24Qw/49UfwCMEVsYRL1AedSA/F8FHeAuhPxHWTKuo5Fc1NisgpF/06bP/7MXPAh5tQjKRlX58c4Tclr/OLaEwax2UQVw9XAYQ2DaspVZqif6yH3YH4BA/rmw2H/UWOiJiIabhn5FOEW3yzMYb8KXQKWsY0UWnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODACHIm8; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e634d27661eso299275276.1;
        Sat, 08 Mar 2025 13:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741469232; x=1742074032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8NqAd3c5NFekNt4az1U3G2oz33PLqlAz5uAxFgA+Mo=;
        b=ODACHIm82PysltuJ0vF8jZ1IwkwJ6YEE2yyFx7AF93a3iLxrIqpGeSzXqu6m09C6Zm
         NAxoYDj9gdctU4hoHdun6GDIhGlK4Tp40t8F0LCfbl9TfG8qggp2ENoyQcyHVqRwK5wa
         jKyUGFeN5SCzA3CKKjDeGZIaXjnZUpaIpg8IP4p8QqfvvavmHkzEH3oeDVgG/NQxCpzD
         FwnCFIf8WkWT7LdonXaydMW+U4ZkDqUHs55SEOdGPW0GOIxKUfMa974eB5qZanveoM4U
         jCktDEP3zXX2lg4KuQPFBkGFZ6wyEi1R+LXb0LHjoSiPo4qoboMUGDDiQWJ/IgMyrYcs
         jr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741469232; x=1742074032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8NqAd3c5NFekNt4az1U3G2oz33PLqlAz5uAxFgA+Mo=;
        b=NiwV7tRsBnxa5yn9sNc21AXIfsEQCJwVIBDvk8ndTTQNxRTGgjrEEy1thqjLzB/kM8
         Jtqnb7gpN5rsmzJAPWWpOU1e146h9E1drWQ6QoyXOlKBLKN3zQoK6FU/W2IZNRPGk/ee
         ZAciPAITT6t47bUiHu7ivY/JZ+C9zCuJ7fX8dHKuuR4ipby7L6vGA3ePJI/V69mRUHCd
         0TaVZC7PLmvSlwG/fXg18P8CAwufS6I919Q8dIYWzSoCdeeuMhhwY9In3Uty8CjAPhiI
         I2EPXBckLO7qU2558GPRqKNcdYkPs3WpEfp1x2EDHARr12kDwjZUIoHGWs/5BP66eTqS
         rR8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIoJM2HCP4EhC0x3C2jomQqQOzdsnJlI8GGRFcjfvnpwiyX+YJetetnTas5KkSJq54mw41v4naKNghBkqi@vger.kernel.org, AJvYcCVecBHcGDFg6nXbJTWLulDOgUkgD9VR3Rcej9BM2PvoajnvEBIx/14cq2R2PRVH5RqPUhHiwkWdOTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyicdMO+KUpgpfEiAAL9A6EQGA5Mr0/sORf7BU7fAq3xVsJT9QZ
	dxFYld5N6WfwPCt+Tb125YHIp6Gryod0QwSlu01hQoqB91w2wpevCIMMsQiZ9iNY0f0azsO/kSf
	IIdVsxxPsoWDHpuDTmFFh2sCA9lg=
X-Gm-Gg: ASbGnctyWcmrzHhQAxiWRDAIBjAr23Ofs+EXZJhwbOelZXgzMb1O47dIrFdUHDHDJ/A
	VKoZ8mLHPCz7X+iQ1I+GXYs8q8uE7UlH3YJL0/Yk/fe6tMHctCQPCXeOJzacWN88kxgBz9WPfRA
	TncN+xJbO6IYkE6LIeY5d9sITUvkQ5rOUHX8V8
X-Google-Smtp-Source: AGHT+IEU7iSsrDZqz1jnr1oTG5DJpDgNKpGuux0vLfcvBUYiknBaHEySZeEWRd7zNsslEEHvjaciWWfkYtSNz/U0M3s=
X-Received: by 2002:a05:6902:161e:b0:e5b:4283:6f7 with SMTP id
 3f1490d57ef6-e63720d5d47mr2335791276.10.1741469232255; Sat, 08 Mar 2025
 13:27:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221203352.41941-1-l.rubusch@gmail.com> <20250222150329.66d6e79b@jic23-huawei>
In-Reply-To: <20250222150329.66d6e79b@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 8 Mar 2025 22:26:36 +0100
X-Gm-Features: AQ5f1Jo-8x7IoNhmucJGmGQpusKyAJBCvtPJiid_1YXDE_p4k9GZC3B6A2wljiI
Message-ID: <CAFXKEHZEkNXAPVxZA5raPsA8cNt3A+tbd83kNzJc3wY5OjAsdw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: accel: adxl367: fix setting odr for activity
 time update
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, cosmin.tanislav@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 4:03=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 21 Feb 2025 20:33:52 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Fix setting the odr value to update activity time based on frequency
> > derrived by recent odr, and not by obsolete odr value.
> >
> > The [small] bug: When _adxl367_set_odr() is called with a new odr value=
,
> > it first writes the new odr value to the hardware register
> > ADXL367_REG_FILTER_CTL.
> > Second, it calls _adxl367_set_act_time_ms(), which calls
> > adxl367_time_ms_to_samples(). Here st->odr still holds the old odr valu=
e.
> > This st->odr member is used to derrive a frequency value, which is
> > applied to update ADXL367_REG_TIME_ACT. Hence, the idea is to update
> > activity time, based on possibilities and power consumption by the
> > current ODR rate.
> > Finally, when the function calls return, again in _adxl367_set_odr() th=
e
> > new ODR is assigned to st->odr.
> >
> > The fix: When setting a new ODR value is set to ADXL367_REG_FILTER_CTL,
> > also ADXL367_REG_TIME_ACT should probably be updated with a frequency
> > based on the recent ODR value and not the old one. Changing the locatio=
n
> > of the assignment to st->odr fixes this.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Fixes tag?
>

Hi IIO ML readers - Hi Jonathan,
AFAIK there is no tracked bug which I could refer to. Alternatively, I
could refer to
the commit hash of the original commit which introduced the code this
patch is supposed
to fix. Is this ok? Could you please help me here with the process?

> Otherwise looks good to me.
>
> > ---
> >  drivers/iio/accel/adxl367.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> > index add4053e7a02..0c04b2bb7efb 100644
> > --- a/drivers/iio/accel/adxl367.c
> > +++ b/drivers/iio/accel/adxl367.c
> > @@ -601,18 +601,14 @@ static int _adxl367_set_odr(struct adxl367_state =
*st, enum adxl367_odr odr)
> >       if (ret)
> >               return ret;
> >
> > +     st->odr =3D odr;
> > +
> >       /* Activity timers depend on ODR */
> >       ret =3D _adxl367_set_act_time_ms(st, st->act_time_ms);
> >       if (ret)
> >               return ret;
> >
> > -     ret =3D _adxl367_set_inact_time_ms(st, st->inact_time_ms);
> > -     if (ret)
> > -             return ret;
> > -
> > -     st->odr =3D odr;
> > -
> > -     return 0;
> > +     return _adxl367_set_inact_time_ms(st, st->inact_time_ms);
> >  }
> >
> >  static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_odr=
 odr)
>


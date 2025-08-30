Return-Path: <linux-iio+bounces-23462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EEEB3CB88
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 16:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC335E3414
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA5F26FDAC;
	Sat, 30 Aug 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVeSlLXh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AEF38FA3;
	Sat, 30 Aug 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756565668; cv=none; b=CwVmeW4F84c7LUdCbpaJiT7YBky8X3XvyxrZKgVeknSvsGFv5Spl7LVXkWh7fIpv5a1w7nFXN4uel29tXFrVDMw9zz26rrsgDAmOq+p6aciwzHL0dfyoUwNCtxCnYX40DMLEY9o/P0UHA4d3vj+FCPb04UBrkzM64kfj7SGJbYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756565668; c=relaxed/simple;
	bh=Ktw75mdgog7lpWnXaRBkLz8rtk89mnPwavSmf7wrlDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBdXoPdvuUiAWQgFkdWmanxynyovRZplodULY7GGna/X1RFb/J5wfMTVzg51Th9MXaP5ZB34C6LowsPG5+tjDQLepIZu0amIC9Y8MzCBsTXyKlxd4yW8MxrsRY7pRw+UjQooEIWf1e17PZQnD4fUfPTAHa4KoSYy2d56XD7I8+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVeSlLXh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb732eee6so512973366b.0;
        Sat, 30 Aug 2025 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756565665; x=1757170465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tOIHNc7+Xm606U1xeGw8vLOtsuxUzz6dPPPykxIfKY=;
        b=nVeSlLXhsUq23EY7LXh4/yD37y11+bZg+8pMsyB7TO4abU0jm4wIyNXhHaKfmcQpKJ
         yQ3DRc+LT7/nNN58ZKcviKJEWqAdSuQ/n3Bver8MemCsU+SvwFOY81kfMlndW43Mh9Jk
         DpfMQpOESsmLrCEogp6VkGVdXeCBM+7Hxh5aVR14rQ+px6adWrE7IjDLyfH8HGNwNJRF
         bFl7a7NYjSrmayRzxhesYriQNBrGK71xUTw6ib00UtyKehChcuyFqhirLVPHXJ8HEWOG
         nMO7L2MRnPGGt5XpY2+mmrVfxtzpM9LnIlqWN21scGeIiTlIx6rrQbOCG6sgB/Itue4X
         kOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756565665; x=1757170465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tOIHNc7+Xm606U1xeGw8vLOtsuxUzz6dPPPykxIfKY=;
        b=r85cSMC+mjjNbA0/bwYIvNVIe8dwS1/3pDTXfjSp11JiFvOKXrQhC5TzzTnB8Z3LHN
         KFvfcmqNNtznfisvTGs/xniKid3+UZEIiMmMdVxF8Ap9eKNfcj25PW2niPf4M3daufsG
         RuOhM4VYgP4I46dp++Gll+QBcmYu2sfX13yhcMTqfBSpX/i5Psm6FIH1NtINJ1oyo+BO
         +gbUXfEPs0RyWJ//uQ+lr8D9I/Z+j9sSPCtgLZPUv5jZTcQSDsx6YbICK6TczdavbeYq
         gaxZkt+hhv/FxtDGnkzk5zur/x6ZUQgGLM49PW3pD1tBmYRwFJQZAhI8R+05/PJ16TQs
         zhpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNaiKqjypWu4zjsnbrLeX+M38hRx0pl+wdRF9LL5wNIfH4vQaJKhvK/ua5wZcBKHQnHzCvgKXMAmE=@vger.kernel.org, AJvYcCX47gPEMUpbTwKGPVFu1Uwjvzf+zokz/116xIXmp2/7s30+5AYe1hHqRFpaeY7qKLCXPoGpva/9r8R802cz@vger.kernel.org, AJvYcCXofBCchL8I+SU9l5+bK4bg+lQ79YuMhsAgxWM/Rk8waw5N9J0NLvwrG9e+nflFdK/j/Qt3Qx1I1k8hZwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl6DzVV0dLZEWnQ6+36q169bFhQx0ozLF68+Il0lx973zv8/V8
	CQdKOl9XXAMSpPmyvPXb+P1E0gxhS3GDrTqG2S0dlXGJs/K5cwKCnad8mIeCH2Vv9KbHPftzYqp
	IKfIFq/CDoIidHlDRY8/cnRKqWGDkhxXnG4VRiDs=
X-Gm-Gg: ASbGncu5Eq3byIfIccYvd6Iz+oMuFUdfRKD1gWOQ2P9b0v6mA/GehXq1o1oF9a61NXe
	tAqKII2Lnu+x1eXUYXoQ0QB/Q0VuIjByqVlfu03OEDP+p6AA+rq74q4GXx/NORB7sUWgAEyTJ5R
	Jrq8YkC56y2nqiRYy/tSoqybYIiei+0SStuLh+gI9WPagf6XDOFqNQShFQioZhynRvinQ1mGZgk
	8cKKbM+BOhf33KWKw==
X-Google-Smtp-Source: AGHT+IFwdZqt/Wq4ulKY8e9OOu9ijK7SNwFHKSVFr/qfBWbsTAKx2Uccs6636FED6mSy0b8oU5RE3PY94nW+R3mcIwM=
X-Received: by 2002:a17:907:7ea9:b0:afe:d499:a450 with SMTP id
 a640c23a62f3a-b01d97a9337mr186067666b.64.1756565664633; Sat, 30 Aug 2025
 07:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
 <4f93d53a-3dfa-4b9f-8c09-73703888d263@baylibre.com> <CAHp75Ve=xJ6vTUydaTw9GuYr22ZXp3HFA5N0tP7NET=CvZJB8Q@mail.gmail.com>
 <10724132.nUPlyArG6x@radijator>
In-Reply-To: <10724132.nUPlyArG6x@radijator>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 17:53:48 +0300
X-Gm-Features: Ac12FXwlJbathzveEvHfetbyQcoF50ElWHuLqqmT5EQRnY-IHwHv2Sz57IOjxds
Message-ID: <CAHp75VcU-AbfRfMZUanV8eHb5oatQPhGS-ntyWuDFtUgKc-OLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>, 
	David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 4:04=E2=80=AFPM Duje Mihanovi=C4=87 <duje@dujemihan=
ovic.xyz> wrote:
> On Saturday, 30 August 2025 06:37:27 Central European Summer Time Andy Sh=
evchenko wrote:
> > On Fri, Aug 29, 2025 at 2:41=E2=80=AFAM David Lechner <dlechner@baylibr=
e.com> wrote:
> > > On 8/28/25 5:17 PM, Duje Mihanovi=C4=87 wrote:

...

> > > +     if (adcnum < 0 || adcnum > 3)
> > > +             return -EINVAL;
> >
> > in_range()
>
> Not sure how relevant that check is anymore; in my current local
> version this can definitely only be called for one of the GPADCx
> channels. Should I drop it then?

Good point. Yes, we don't want a dead code in the kernel (or always
true / false conditionals).

...

> > > > +     for (int i =3D 0; i < 16; i++) {
> >
> > Why signed? What is the magic value here?
>
> No magic to my understanding, it's that the bias generator can output
> 16 different current levels.

The define it

#define ..._MAX_OUTPUT_CURRENT_LEVELS  16

...

> > > > +             ret =3D regmap_update_bits(*map, reg, 0xf, i);
> >
> > GENMASK() or even better to have a definitive constant.
>
> While at it, could
>
> > > +              *amp =3D 1 + i * 5;
>
> use a macro too?

This is something I haven't checked, dunno.

...

> > > > +     raw =3D gpadc_get_raw(iio, chan->channel);
> > > > +     if (raw < 0) {
> > > > +             ret =3D raw;
> > > > +             goto out;
> > > > +     }
> >
> > Instead just assign to ret and if okay, reassign to raw.
>
> I've refactored that function greatly since and now have:
>
> *val =3D gpadc_get_raw(iio, chan->channel);
> if (*val < 0)
>         return *val;
>
> Is assigning to *val immediately alright?

Only if it's not going to change anymore in this function.

...

> > > > +config 88PM886_GPADC
> > > > +     tristate "Marvell 88PM886 GPADC driver"
> > > > +     depends on MFD_88PM886_PMIC
> > > > +     default y
> >
> > Really? Why tristate then?
> > I would expect default MFD_88PM886_PMIC instead,
> >
> > > > +     help
> > > > +       Say Y here to enable support for the GPADC (General Purpose=
 ADC)
> > > > +       found on the Marvell 88PM886 PMIC. The GPADC measures vario=
us
> > > > +       internal voltages and temperatures, including (but not limi=
ted to)
> > > > +       system, battery and USB.
> >
> > Please, add a line about the module name if one chooses 'm'. Or see
> > above =E2=80=94 drop the "tristate" and explain why this driver may not=
 be a
> > module in the commit message.
>
> 'default MFD_88PM886_PMIC' would make it y as that one is a bool. How
> about 'default m if MFD_88PM886_PMIC' or, since this already depends on
> _PMIC, 'default m'?

I didn't get it. Why? defaulting to MFD is okay, otherwise one needs
to explain 'y' (and even explicit 'm' choice) for the _leaf_ driver.

--=20
With Best Regards,
Andy Shevchenko


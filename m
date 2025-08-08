Return-Path: <linux-iio+bounces-22448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F5CB1E860
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63FB1C200AB
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 12:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5CF1EA6F;
	Fri,  8 Aug 2025 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEWH6viJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF81CA4E;
	Fri,  8 Aug 2025 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656293; cv=none; b=HuPm87YJv0bwhr917qLM817tWlYesJvzRp9pS8Orr2r60S6opLCE6GUkade+34Wy1A1SY1J4oxvP2Tv4x2VRZBgMP9Ejq0vzNPCP8SUVPTVu3cttEGXbHpHpWLiExha+0FEp3hqMvqQajoL8TcxZ8FY278HLde3ul4bOfr1DuLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656293; c=relaxed/simple;
	bh=AE+OUZpHkq97f9U9eh3DCeegcbjETDZEqQEqimmtRhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsikrMnXrnA6yEimRL3sIlOxpSDTsUsBk2GhzazkH34jjJ+jmMhhw5qBgymyOKmlrPHJuReTO3aTPeuOsmWa1B1qvq5dn45rgVNi0Spqbyi3gKxrB8/B7qMt5lfDsNFHn+73e3PA/eJeDNWRx+q7I3cWpW47XCa/mVapsh0DlnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEWH6viJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af96fba3b37so382584066b.3;
        Fri, 08 Aug 2025 05:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754656290; x=1755261090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ2ky9tHZPhS0rovmNk56b1YbseXuuUIMllhwDB0Xeg=;
        b=MEWH6viJ7rojYWEhykE1ENRApQ1ennsMSdVduPZ030kMwWTPlYBlkWxWRRVonNZNAN
         AHsBhy4Scct5M4DcvsnNsDiiJv9i/zPQsDHhmMmIkiHItqg0vfSob4vKI9ge3KZd1Ek1
         XvF1jB6JOS0EkdGUMOtHicv6OoT6ZsmZGfvUnRD2bvbBrzzubA7S8AcwOF4jNOp8g8eF
         dH9dh+0lHhdj91JodlgYU+8yUWpy3dP67HeKQSx2t9Uni5Jk3T20pffFMjUBExAXYnwn
         LTXqWuRP+GRL2lFuSdhd7kcAqy3JMM078K3flIwWjsIF6dMv/3qwIh+OhGnC0nCgL86B
         wzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754656290; x=1755261090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQ2ky9tHZPhS0rovmNk56b1YbseXuuUIMllhwDB0Xeg=;
        b=VJDMwqVweAJGQqkh62ZIzxgUi1LuNh/nVQFjuN/fCRJW5PA8z5vMCtnQSLj8QkeOev
         UBHj7L/0yt7COe0Wo9HM6ZzdynjkJXJU++bT19E3cKxt+R7S6FDobNpDgoqpKbpprkvt
         XpmKRoIJWtVZtprvA42J+SzUqyuHAaf/6NUttpXb8hAHykmTymbu6dMwmThSHiLdYtCu
         k71Mbz0xF3GfKN0pBLuTfLv1NBOszglT/EMk67v3cAcvwqMD+ul8e/Rm/Ls8P0ZTF8Ik
         3dIZwDUsl+AVZa8TsqvB/+hFzkVdVpsESr3gWfZSY4DxTn1ZW69+vmvIsVzdyuaBOyaM
         PNjw==
X-Forwarded-Encrypted: i=1; AJvYcCWyVeaZ55+NQbRzccsC7k/zccmhApkdsMgjxyx9nM0qSeMNO6gAtF+xGEWWysXmEsk1RNHlVqJUTls=@vger.kernel.org, AJvYcCXWlcyy9DJptDuVclHZtufmGogk+NEypTN4DUMXlNR12CLieGyHhnN38tZgICIO/cGWKbDG3nslsgcpXleY@vger.kernel.org
X-Gm-Message-State: AOJu0YwspaeWJDgXL4VL19PG09bpUWxq+IVzvnWL8y/j/8kFQU++N0qH
	XwRKx54CQ5IytRbGvRcmJbqAmK7k4d7z50N3IF3Tfk/Isy7QzEcKA+6MQ5CFpnOrz6efe8g/Msl
	PNtQxVzVk/NWosB6A9wEry5WVj1ga6No=
X-Gm-Gg: ASbGncsaQE1cqRAZePUB9DyIcZCTmHxOVXC5yCe0FS53rU0Z0A7iPQKa48+XYpwtVfL
	mAnW5d+s6iRa7Zw8Y16+rLBH8OPOazF9GnTkf5z8Jfg2o7h0DLdXuSdIX1DKuDw956GN3UEwY1O
	9wOVGa3dGwFMNoAqie4ICs6HFKxvQo679d+l37SCLWGkcYbyLKeKkf93vz0vzM0AifUrw0u3Apd
	H9qApH+4Q==
X-Google-Smtp-Source: AGHT+IFnJfak8sxqVoSo5+esC18P6F++h/8FSN6A559e4RirFQKqkKy9SJoUHWT6H/G4ZIXVU0htdui/Eqf9Nh0dP9k=
X-Received: by 2002:a17:907:6d22:b0:ad8:9257:573a with SMTP id
 a640c23a62f3a-af9c62fb725mr258113566b.5.1754656289949; Fri, 08 Aug 2025
 05:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJReTh-t5D45aZNV@pc> <fe98c2a2-ec8d-4352-a9fb-6f0e798f7268@baylibre.com>
 <CAHp75VfH6xuiPNZA_eGmFgMGxdGTf-y6o+SEKeCbG=wsUOJYfg@mail.gmail.com>
 <CAHp75VfEC3qUurUO4LKA1d6_Ot15AHY2zG9tk3wWrtYAgHrHgQ@mail.gmail.com>
 <c8189da5-f660-4500-b3b3-246913453ad5@baylibre.com> <aJXonEh2W8NNDMZU@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aJXonEh2W8NNDMZU@debian-BULLSEYE-live-builder-AMD64>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Aug 2025 14:30:53 +0200
X-Gm-Features: Ac12FXxEia05zpl6f8XsVYrdTWTD2A6EW8qU38pHWlli9W4LuXU_nmHnSR3fkU8
Message-ID: <CAHp75VfWsyj6q1dYK2dL7Mp3W=98SMGJT=ner3k6ty_NFVYM+Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad4170-4: Use ERR_PTR() with %pe to improve
 error logging
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Salah Triki <salah.triki@gmail.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 2:07=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
> On 08/07, David Lechner wrote:
> > On 8/7/25 4:02 PM, Andy Shevchenko wrote:
> > > On Thu, Aug 7, 2025 at 11:01=E2=80=AFPM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > >> On Thu, Aug 7, 2025 at 6:03=E2=80=AFPM David Lechner <dlechner@bayli=
bre.com> wrote:
> > >>> On 8/7/25 3:05 AM, Salah Triki wrote:

...

> > >>>>       ret =3D __ad4170_read_sample(indio_dev, chan, val);
> > >>>>       if (ret) {
> > >>>> -             dev_err(dev, "failed to read sample: %d\n", ret);
> > >>>> +             dev_err(dev, "failed to read sample: %pe\n", ERR_PTR=
(ret));
> > >>>>
> > >>>>               ret2 =3D ad4170_set_channel_enable(st, chan->address=
, false);
> > >>>>               if (ret2)
> > >>>> -                     dev_err(dev, "failed to disable channel: %d\=
n", ret2);
> > >>>> +                     dev_err(dev, "failed to disable channel: %pe=
\n", ERR_PTR(ret2));
> > >>>>
> > >>>>               return ret;
> > >>>>       }
> > >>>
> > >>> Interesting, I didn't know we had this format specifier. But I thin=
k
> > >>> this is something we would want to do kernel-wide or not at all to =
stay
> > >>> consistent.
> > >>
> > >> I'm sorry but I didn't follow. This is a kernel-wide format specifie=
r.
> >
> > I meant that it would be strange to make this change just in one
> > driver and not do the same everywhere else.
>
> Casting error values to pointers is already being done by many IIO driver=
s
> if we consider the use of dev_err_probe().
> __dev_probe_failed() does the casting from within dev_err_probe()
> https://elixir.bootlin.com/linux/v6.15.9/source/drivers/base/core.c#L5026

This is a manipulation. The dev_err_probe() and __dev_probe_failed()
are parts of the core where we specifically bend the rules for all in
one place just for a reason to avoid this spreading (and avoid
creating specific APIs).

> Thus, I think this patch makes the error messaging from ad4170
> more consistent and, because of that, I also see this as a good change.
>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Thanks for the review...

> Though, I'm also totally fine if maintainers prefer not to take this chan=
ge for
> whatever reason.

...but the below still stays...

> > > And to be clear: I am not in favour of this change exactly due to a
> > > bit weird (for the reader) castings just for the sake of use of %pe.

--=20
With Best Regards,
Andy Shevchenko


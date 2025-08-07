Return-Path: <linux-iio+bounces-22418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7199DB1DED2
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 23:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5F63A33AE
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 21:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AC023959D;
	Thu,  7 Aug 2025 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T272Iq3u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A183FE7;
	Thu,  7 Aug 2025 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601672; cv=none; b=nLRcDK5w+7Zu1XYsee6ioFuMoC6rfMGu5OeiiYj4vCCEJ0M/tJXJFFdkkQU1ad/szS8Hyhajx/gaCd0YXNEOK9ZmLam98eBICEOhEYJa5tYl7y0qqvIPtIy8NLtR6K8XNYBfOZ7eQeZBqZT7IiESvRmF2K9MxeKz3VWk9TdJf/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601672; c=relaxed/simple;
	bh=W2U8LJ7/2DEOvtAD3s0Pz3qkeZCVSJVA+3H0qIaqltk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7Bqz6yCuDQD5M2BR8NRZAtULdvsplD5ugVNpALsaMXsrhdo+c3+5m1eBASdN5Dzo4JkpDbIe0sg/d5Lu4aD5yRx3Xz7+FLz61y8z+esxX4Ftoi2pnr1h4rDpxhzvat8RWFSCh6ndVAYWd+o1i8MjeYsPX0sxLHoQDq4JuRCjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T272Iq3u; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3338252b2e6so11643161fa.2;
        Thu, 07 Aug 2025 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754601669; x=1755206469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbEV67shPWc3pFOlBApRcK2ezgE+ilxtrG+TyJix/Ec=;
        b=T272Iq3uc7z8l20QTkyd/ZJUsPalPHau1iRM+uAo+PtMFZIa3yV9xt/s1GsNdLobt6
         wiCZvSNz/X5TW2Jj7gXnbDCkgJFGluSdSASBcO5O/v4hyLe8oCdxSL7NmWCOmtytRRid
         aqhgCbjG9B5vN8GScMhSH7BaWdGuUBibl8jb9nbxszRpECPRv3/wQ4PZIxblWV4c0OKG
         /xDZip+qvL3L6VM8WjpwcbyvU9NbbbEga0soLxAu8l8+FuBnPr236Z5a1jICsKAVB892
         cBuvfO/4Xvw8NpvZ4irQsXPybCGIDnHBf6Q2aNqoNVh/b+Y21kC1vAh+4asJ35PXMmMZ
         PP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754601669; x=1755206469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbEV67shPWc3pFOlBApRcK2ezgE+ilxtrG+TyJix/Ec=;
        b=DBzwv7EPTdN99nYlTpZ/o9o2ARplMRKooAMwfr80E8rKvfZfpCJ47Tx5EswcVyWu2+
         0pfLv8qaRCIbkOpALwfGRg3u4anG6FQC+HVhV5wSunJSBfhZeMbttDjUvWC52io1JTyY
         HY1xT48HAY1A8pB/rJDET80nBSkHbLWbHrsTzp3jU9FfZaFYAaPdT1MEZHbzqiW3/cVm
         9Z3bSMyNKgQLK554TP1Lgdz0rIZIyJCMR/LUtUzJH3AmXR3bzcAEIaXU9P/xHtyZ6pEh
         dBu/vsrtPUXSP7FYgPsijjmeNaXsXkoeoxrboga+UvdLkOAXsVbpEsEbHtjGQRAhZ7vH
         Sjuw==
X-Forwarded-Encrypted: i=1; AJvYcCW8qhKdZ2kvoTyX0Fy6fhwNnxn6awHqPt35WpWi1fSIqgCzwQRvJvhP+PupP9r4IONAHKEXmzgzmEE=@vger.kernel.org, AJvYcCXbLuEUnw8Tvel+q9HNTvfFd6+137ydTl/uFZwqrTt/JqWR9Lr1r8r9a/aN5uqNji/KgVfmbTdHO8VfkdIx@vger.kernel.org
X-Gm-Message-State: AOJu0YxC/JTKQoMzI8PBp4Kd6DKjOD1ySHhqTXe67TtUeePrBYF92xL9
	rQd7pTIdwj0bsCzRC1quYNWtPA6amzU/v2H/dtynlU7Uk02qt76wLzCN5ZS+se4WveatIll7H8W
	vM6NI4t+7eQ7Y+obAIJ4tT5PpflO6HbE=
X-Gm-Gg: ASbGnctnJwj0okiERWynjtmIYxAsrNsrqdItH9jYqVVIGatw/4QxQkEuo3SE6KdNLaM
	g5IC/kvcXYKyPHGmCRijmH0Vq0ucjZxXxZ0QjJvOHJnFdCMBlKKE80YnSF4eEi3evOFuKUeOFn4
	YIh9gK01/kk7dbV/S0WUTUyhWDHGT3K4MKw2ixPdTJGDmOKAe0VwxXBiKjz20EmjJCWuNFEOKf/
	AuDhXXq1s7LzLG6lTw7+4NctXY9BgpgNmKRJ9SEpgYQsRs+4d9v
X-Google-Smtp-Source: AGHT+IFalq8erPhlncmUD2rzpNwyzjQE6/EKmNtr8baLwKW3FibfuRq29kbjw1niaMqTE0KTb+IlHg6EayDF9CFh4nU=
X-Received: by 2002:a2e:a987:0:b0:330:8d4c:ae6a with SMTP id
 38308e7fff4ca-333a2145753mr1031541fa.6.1754601668576; Thu, 07 Aug 2025
 14:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJReTh-t5D45aZNV@pc> <fe98c2a2-ec8d-4352-a9fb-6f0e798f7268@baylibre.com>
 <CAHp75VfH6xuiPNZA_eGmFgMGxdGTf-y6o+SEKeCbG=wsUOJYfg@mail.gmail.com>
 <CAHp75VfEC3qUurUO4LKA1d6_Ot15AHY2zG9tk3wWrtYAgHrHgQ@mail.gmail.com> <c8189da5-f660-4500-b3b3-246913453ad5@baylibre.com>
In-Reply-To: <c8189da5-f660-4500-b3b3-246913453ad5@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 23:20:30 +0200
X-Gm-Features: Ac12FXzWY7dQbk9I4ah5NdTe8-_7lJo4fudLoFxpzEeIp81prAc1F7I2_AEaPOA
Message-ID: <CAHp75Vcq9MCOtJ3x=uhjcZVb2=i_wZRUeaXXbaCOdCb_-Z2TNQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad4170-4: Use ERR_PTR() with %pe to improve
 error logging
To: David Lechner <dlechner@baylibre.com>
Cc: Salah Triki <salah.triki@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 11:14=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
> On 8/7/25 4:02 PM, Andy Shevchenko wrote:
> > On Thu, Aug 7, 2025 at 11:01=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Thu, Aug 7, 2025 at 6:03=E2=80=AFPM David Lechner <dlechner@baylibr=
e.com> wrote:
> >>> On 8/7/25 3:05 AM, Salah Triki wrote:

...

> >>>>       ret =3D __ad4170_read_sample(indio_dev, chan, val);
> >>>>       if (ret) {
> >>>> -             dev_err(dev, "failed to read sample: %d\n", ret);
> >>>> +             dev_err(dev, "failed to read sample: %pe\n", ERR_PTR(r=
et));
> >>>>
> >>>>               ret2 =3D ad4170_set_channel_enable(st, chan->address, =
false);
> >>>>               if (ret2)
> >>>> -                     dev_err(dev, "failed to disable channel: %d\n"=
, ret2);
> >>>> +                     dev_err(dev, "failed to disable channel: %pe\n=
", ERR_PTR(ret2));
> >>>>
> >>>>               return ret;
> >>>>       }
> >>>
> >>> Interesting, I didn't know we had this format specifier. But I think
> >>> this is something we would want to do kernel-wide or not at all to st=
ay
> >>> consistent.
> >>
> >> I'm sorry but I didn't follow. This is a kernel-wide format specifier.
>
> I meant that it would be strange to make this change just in one
> driver and not do the same everywhere else.

But it's how we usually do things in the kernel,
subsystem-by-subsystem or even driver-by-driver depending on the
cases. And currently it's used in many already. But if we are talking
about IIO, we need to agree which cases are okay to move to and which
are not (besides the fact that this should be applicable only for
error pointers without additional castings).

> > And to be clear: I am not in favour of this change exactly due to a
> > bit weird (for the reader) castings just for the sake of use of %pe.

--=20
With Best Regards,
Andy Shevchenko


Return-Path: <linux-iio+bounces-23956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D6B51FA5
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 20:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89701884537
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02274335BC4;
	Wed, 10 Sep 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeFnFxpw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632D24A058;
	Wed, 10 Sep 2025 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527251; cv=none; b=NG9kuc4VrhUCY2n34/Ngaf086jWhHifZxxWI2ZRAKDVsVnICAI/OAjyRd8l+FaQ1nU91i92cBQED+dVm+lmIKWqpFakXRoQavM5e+gTMzxG5VOTOkkp91f+KMS0xzvEka/wMnFrsJqXvcQh4hqjGlkcuYcppa//q+4uhLuEDBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527251; c=relaxed/simple;
	bh=aQaN4cLCPHfZSNLgdoXn27KAmkMHFXFPAg8xe8qqaCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXPRSrP3KlPbCxKQ5/po9jLruLRFlEy8FhqYETas9uwFN2p6QdpP+IpHkqrRFbzztQZImWCPO3gcmTikAar/DPxHqsAxU63udbAwotkrWua3Y8skXrX8FtoCfMnd2bgJfmFnJX9J2SDd2Ga8FQWlTlywkDobtw1Y9mleHIB+JXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeFnFxpw; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-33808d9e10bso8832911fa.0;
        Wed, 10 Sep 2025 11:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757527248; x=1758132048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOpPtJnUaoTZ1ERK4uesyn4qh66Y/PPUR0nOeiSdMWo=;
        b=BeFnFxpwKIi01mZb+wAYsWzc4RIr4RGuZ6sFXHoA2FKKy51GiZFUbxVD2Y+6Iyufy+
         Z02sK36lezQAJgBngQFQvG21yvp4HuI9j1y/Ng5vaJdPlLmNcWf2OKTn6Tq8Z9jitkCO
         MjDA29N1FuClhArTiNXH6MK/B5DAuSNH/7M0iaL4QH0OPR1kMuZLaU3EHFeCQlR9BL6P
         paHxR+yJuBTifo/cHUltKtjp5A1Ijb+tz+GhFLWkFih6vuNoWwZonHR/onvKtsifW2kI
         PteWIFbrf0FHe+4E9z0DM4ZBv/G5pLw/+driul8blQpplp9mNiiH9tNh8kAMUxNyYX6+
         4T8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757527248; x=1758132048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOpPtJnUaoTZ1ERK4uesyn4qh66Y/PPUR0nOeiSdMWo=;
        b=WOJHbEW20MShLOvgZcpxlXkjW323ZE7iebcHGL8043Uo+yXGyLRHptZzpJHZmkhi1c
         UhZzr7wMjjD+g/ad/PiP2Q3uWcD6TEiKUiqf7GdBzbfYWC8pnB5AzhxKy+OvE6Kvu5km
         Pt6gKL+RhmN3VBJL5Tsbh770xWpaiakGEMhx2NjicLNl5sCfweNPpQfS5EyZTdEMc+qX
         ZDzFaUsiBriLCOf6LZP9wtZQMCLqhdupRysJ+Cr7TlYmp94G6rz9hQmtHkHqpelLbenx
         jKQR6jW/UE8HycUi11yh63TOtduqmA4xVvRpYC9iUMudn8yXbKTZSxyEjjs6HBZj3Xht
         +yHw==
X-Forwarded-Encrypted: i=1; AJvYcCV9xGD2Jrocxn27S9FIC729X98Iu7NHY5V1vsnPfv90e4y61+hVff7hEh1TkDGQesJRZpx7UgSNuyO4kEMy@vger.kernel.org, AJvYcCXU9jX9Wm82Y1gzIFayA+HyMSMoXKavxG4qDfuTxl8FORWGpYUZTe9eTvoQmoJEfmehCLjXOkXVEJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylKdZ3xECRwiUoZxc/l+nD7G5cE4t9m5hk9vHZo22vj//eYOd2
	TWQJibl2LxTKvaxUxhlUm8Jxh8iSM49o7tGH/wId8aTUp/yKaJf3SHqKrUdh9pfPt321w8qq9MG
	RiCcUr+1M/bJlZ4W9km/I0u01CMkijqQ=
X-Gm-Gg: ASbGncsS4fu7jE9buAkVOnAGWqU4KKT96Hulaor5m64Sh8lVD54CWd17/GyDKOEWoU3
	KSfVnY1wmjgi3I48jp8XuPXwHPxypTkk+G+sO8wmHII1A56H2ZtAkBcC3Y+pW2KOT37Ec4mYWHB
	i3T04L4qi1o/3HuQINLrTQtzOn1W6zE4vTRO9kBiXMm87n60G4h6QpMY89rwWP7LUzJS2cvcvOb
	i5VU/ouMxgRGY0ZKFqfmbSWWbBvjvM2d+CY4BFmpQVlId2kOKW+
X-Google-Smtp-Source: AGHT+IGUDRrb9Qg24h4AuH/bzxaYOOE0iGtc8BC3lkhADAWqAhjxIt1JHCvA0/CPAb5tyDBhF1p3GSACj7ZVEYgb+DM=
X-Received: by 2002:a2e:bc0a:0:b0:336:b891:18db with SMTP id
 38308e7fff4ca-34e315d75bamr1995521fa.2.1757527247812; Wed, 10 Sep 2025
 11:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909194649.10512-1-akshayaj.lkd@gmail.com>
 <CAHp75VfpQ9c4cptnNGzFYakQxY7JjtUEMDsysS9KJ60xrzaE4g@mail.gmail.com> <20250910120245.000033e8@huawei.com>
In-Reply-To: <20250910120245.000033e8@huawei.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Wed, 10 Sep 2025 23:30:36 +0530
X-Gm-Features: Ac12FXw7PctS42m23HOIjQFOlv679bgOuOIUXlFLOBLAWUSOAN9A-sP2FPmaQJM
Message-ID: <CAE3SzaQXOr6nh-MFAyLm_1J9kXisnzhak_VuVH4d2z6mXFe1NA@mail.gmail.com>
Subject: Re: [PATCH v7] iio: light: ltr390: Implement runtime PM support
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, anshulusr@gmail.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,
Seeking your approval. If there is a requirement for v8, I can send that to=
o.

Thanks,
Akshay

On Wed, Sep 10, 2025 at 4:32=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Wed, 10 Sep 2025 10:17:00 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Tue, Sep 9, 2025 at 10:47=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gma=
il.com> wrote:
> > >
> > > Implement runtime power management for the LTR390 sensor. The device
> > > autosuspends after 1s of idle time, reducing current consumption from
> > > 100 =C2=B5A in active mode to 1 =C2=B5A in standby mode as per the da=
tasheet.
> > >
> > > Ensure that interrupts continue to be delivered with runtime PM.
> > > Since the LTR390 cannot be used as a wakeup source during runtime
> > > suspend, therefore increment the runtime PM refcount when enabling
> > > events and decrement it when disabling events or powering down.
> > > This prevents event loss while still allowing power savings when IRQs
> > > are unused.
> >
> > ...
> >
> > > +static int ltr390_read_raw(struct iio_dev *iio_device,
> > > +                          struct iio_chan_spec const *chan, int *val=
,
> > > +                          int *val2, long mask)
> >
> > Isn't the mask unsigned long? Jonathan, do we get this fixed already?
>
> Whilst it could (and probably should) be unsigned, it's not actually a ma=
sk.
> That naming is a historical mess up / evolution thing - long ago it was a=
 bitmap.
> It is now the index of a bit in the mask.  So this is unrelated(ish) to t=
he
> recent fixes around the actual bitmaps/bitmasks.
>
> Changing this one is a lot more painful than the recent fix to the infoma=
sk
> as it means changing the signature in every driver.
> I'm doubtful on whether this one is worth the churn.


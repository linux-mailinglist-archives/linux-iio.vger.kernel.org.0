Return-Path: <linux-iio+bounces-16711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF73A5A55A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC733AEE22
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D00E1DF24F;
	Mon, 10 Mar 2025 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW6F9tgz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A98D1DEFE1;
	Mon, 10 Mar 2025 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640019; cv=none; b=hRNQ9Z/UA//JshY4liPUtp74wGvkJKy31sw0nyv3Uy0HfR5p1FDKBsUQs/sPmk5mBCdw0UejIs8YV7wd4Cy9wR7Y3CrsqKLHaa5e2zzwKKg/0cpOYWCj65kwZeflaUnCf5sn24w9kFLrAnQ5e7qo2++htXBoi6KFNzzj/BHmwRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640019; c=relaxed/simple;
	bh=oWjyctOfAZzqZ28wEHoJvG0ah9LKIBMklEVvWnYtIAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekWsMP3hdTLZdTfUfb5jsAu0qHYAHX1Xc08zMK9kqlsmIKTjRjpZ2fIijounfOgqIgQRlms4q/hPrs13YN2ssj/r+7jG2V4uSVETR7xrdSNtkk/bccooVa2tQn1DIIaFHCyxInrR4OuZNlKXtmaY0sImf7XdcBhqPm1xvfxbJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW6F9tgz; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6fee3632ef1so1409337b3.1;
        Mon, 10 Mar 2025 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741640016; x=1742244816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQJmqf4BapFKGOdAG0jiNyOkcaDWGjY4CREwm8k1wPk=;
        b=eW6F9tgzq83YTnZw0gTIhlx9QfVCyNN+sOoep1DqrwBCn6+SZSFq5b6Jo15hO9GrXs
         9LAgKNQfLQuVPcPsDwur/PGjTKIDcZ/0CxO4rnRBvH0xoTeGLCcE8eSa3vISWYFqoO+L
         wgbzAdeShiF717P+/Mi8ozPk2Kmw2+3i9erN0HIiHad0LyITWSHL1YoGqxN/qSfU2EoS
         Ne72Vli5zyJKyhEAPSpu/iFfl7hJ8rMrpJkPKo0CPUMXJR5RzA36uNpNHn30xq8wXb4a
         jXHLLmXr5sihh5e2vxhVgJUgqmVgWwRrqLf5U0UrP27qqwJZSu6CsCzVaZsCzkTp3pO6
         JdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741640016; x=1742244816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQJmqf4BapFKGOdAG0jiNyOkcaDWGjY4CREwm8k1wPk=;
        b=NloccpHMLbMOM94eLLmrNfO2DgIXS5QnkbAUPk5Vz1l+Xz13qRcaWrcUQYhvOtghPT
         S4kmoqMpR1aDzUJjZoZoW0a9zbTVcSe1uSM7490FOS1ImMZoeXATf8CEEU2RzqlVPwK5
         uucc8uUVio4luituRvvQRWcCdyexM5ha26qgMF5rtFysekVrHVNFnilXLOK7xwsfOhOS
         VPT6/MkYDCzsZPhjjCBAD/RShC9ZquGw+B8UPhuKFGON6G3wryAQuBwpziZIuVumwv0S
         06JbaivY0IMddimWzOLljW5RanGs0LLjnm5Kzx5fS1BHlfBBy7So6/RdOEbXqQ0Ux65k
         8gXg==
X-Forwarded-Encrypted: i=1; AJvYcCW98OTdQYT3/cBtQ4lwJdKLqkrJ1bodEsy8OasDjvc792zwr/E6FiiNw0/lMzSTxdRHIXktMA3oLoPxWKRX@vger.kernel.org, AJvYcCXRqxRjCCKcjT3tw3jzxuM90Kys6Z7QQc/eQU2XFldJsRIL6LwrfEk7YokUQ/5AE/YWAvgxrIP6wPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIYCwmpeYOohK+idsFUICA5t/XhZ9K0LjFz0kvoeMdnRTpILMS
	B96YZ64IdbmyNUKfNjOT7uhl/KBy1bkpFKn0UX+o+fTZexEh3fi+dYAUOlh+yv4xIUDJJ9h2QnI
	08w4QnbgdT0ainvEqsS7o2zFEBq0=
X-Gm-Gg: ASbGncsQGiDdMxBhNU8E3HTre/Lj1vqIH169XRdwSEpeF0oQGS4+T83mnDgkhUtFJlW
	DVJYJr0du69hnFlQCoQ8nXvkvcZHnxCXPGap4b4qzy9w8UqRsn3S39UM+l86ydFKNmLzn04Wqr5
	3dBC3nzwx121oCBGTOLkGaoMwT8g==
X-Google-Smtp-Source: AGHT+IHs+DO2QF+x6qYrqQUIG520UyB96W2qoPNqT27M7cudtiD2mizo6Lfop72+jk+PccWblhdrd4UF/u5dcrrYZdY=
X-Received: by 2002:a05:6902:470b:b0:e60:87a0:6219 with SMTP id
 3f1490d57ef6-e63b4e4c51dmr623081276.0.1741640016248; Mon, 10 Mar 2025
 13:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309193515.2974-1-l.rubusch@gmail.com> <20250310201042.0e8f06d7@jic23-huawei>
In-Reply-To: <20250310201042.0e8f06d7@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 10 Mar 2025 21:53:00 +0100
X-Gm-Features: AQ5f1JpUtcf7mzG5cibNdqFYPsXsd_4bN6DiPt3VYpdSp_G16QTdHZNX_yO27W4
Message-ID: <CAFXKEHb1zCpNX_t70dTCM6yBoU=gegcf4bJZyx8iWSEC+ibmMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iio: accel: adxl367: fix setting odr for activity
 time update
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, cosmin.tanislav@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Mon, Mar 10, 2025 at 9:10=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun,  9 Mar 2025 19:35:15 +0000
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
> > Fixes: cbab791c5e2a5 ("iio: accel: add ADXL367 driver")
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > ---
> Change log missing, but I assume it's just the Fixes tag.
> If so, I would have been fine with that just being in a reply
> to the v1. Anyhow, new patch is fine too so applied to the
> fixes-togreg branch of iio.git.  I may well queue this up for
> the merge window rather than send another pull request this cycle.
>

Yes, it is actually just the fixes tag and reviewed-by tag. I'm sorry
for the missing log.

Best,
L

> Thanks
>
> Jonathan
>
>
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


Return-Path: <linux-iio+bounces-18605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D674A9BAC6
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 00:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC37F3B96D3
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E327F74E;
	Thu, 24 Apr 2025 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/bRN73P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1E3289342;
	Thu, 24 Apr 2025 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533811; cv=none; b=I2kzxw6S46RNBhyTFbRM5oq0skuJrBwVyiEULpI4pxulJE7pdnDrFWKVRzM0H163av6DILkwBOuTooLEC70DWZVmcAMvk31z0mm1SsLO2cXmT5aQshoxLaPIaXa3G5acM3NTC8etN1e7Rq3Dnn3GWtvCaBnaTG53+T9KJ4d1bZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533811; c=relaxed/simple;
	bh=cuQzUUvxeCs9j1sBqZ74MivCxv9pA0bPEH+NQyPqPnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zty7BPlaKQkefd5bHV1V/Ym3MUhU36pv+/ytgcldV6NolVoMrkLMHX8apINtu3OYmX7Bn6QeO31wU8B+pSeEozdKemqdevKHIx4xfk8rhap09dbV8z2c1fnxEfkp1d/6bwNR8QLuP9bGFtEKI37J7GE/2Q775pk7Ta+X+IxNREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/bRN73P; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476f4e9cf92so12033011cf.3;
        Thu, 24 Apr 2025 15:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745533808; x=1746138608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cE8lrzeJfm1QbIEx8aHZTIYIj8T/E/38PHm5I1LoFg=;
        b=V/bRN73P9euaOAMwDmQ/Lmkn9I9ORUo4gu/9yZ50gxyY97jQgOI2idQeVL2AkkLiDC
         wkBUGgo5jFRygyvD+/dk/vNxMVnqvUIAcUyVWqmBpSy5XS4CafAORFvgYFUKIVNSSaRy
         FgFqof506pHmhoqViPCbpvaOOH/OxvasE1PlDzrmXr/0djFpcSs3UtrneLXYeeZqwliy
         /XLgK7YwDCuTf8ifWY3sKL23kvk2vHiZsjp0VTHjP5FN7cyKZC7he0nTVydGnow3sF+h
         rSX/2oET/qsTCHg0GKNjVv7CQ7jaGsDdE2yucmLddUMely00LE9LVCnuqVSVOySoJCmv
         Ajaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745533808; x=1746138608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cE8lrzeJfm1QbIEx8aHZTIYIj8T/E/38PHm5I1LoFg=;
        b=SpCN28/4soWFq+6s7lVbhy9NrmCmE3wJ+9pU9fi5OhUQ1Dk/7/PenfypMlRE5KpUs1
         boq6ugZ+jAxDV88uS8L3fCA1Zn3KbxAFrzR/7nV/OGKzY659JOnTvfYZHaI+RN+v6F2I
         THWsn8Y4DAMU8jm1f/wMhQ3HHMsJi9A3p3RzPIgJznsVBEXBRUIh1UFJ4yAjmW7mfcRp
         6Ezx1Ei5ICRBz6QHSNS6bR8iWQNB1NAzUfL7o33QpEpZ0nFp/Sbvd1ziohfYIUQ6QtY9
         wN5AY8yvdg9Hu7i7jLjO+1ZssFo2tpyoLQ6jjGr0kk63hVuEttJbg/4oYwleCf2mQ9wL
         Ttlw==
X-Forwarded-Encrypted: i=1; AJvYcCX6uueLzF+jECvJWxk5aNJBGI1qXT9+qp9GaUFF9HVi9/7Q43YWJIF3qGLwaqOJKZNcLFF28WMStk83Ba2E@vger.kernel.org, AJvYcCXrVk9NR18KbLbnUA2VUGCaLbz8IPHB/A+7R2CdM0vDdL6FmjiFCgwoL9xFTLQnbB1qnIUFY3fD0oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3fWsRNl9uuRmvA4wkcE7GDqE1D3ouP4WFX+A0B1xEkbLAvM3t
	lo5KZ5aR5zIt8XXlPWIwCBCN1Wq1riN8c7wF459WkqydKCrvLzAt+JpiuXWXy4Bqt1/dFv9rDDl
	Na7AH7O9XGX05+kTXfNYaH0zBZxQ=
X-Gm-Gg: ASbGncuz0kJcdh/T+PUTdklpdC5otadnDbt+JX3+Xv5aAReLMsoxTJNd3f3oM9+1A6y
	06q5g8bf0ZXy6ONZP4C5mzCt5SPoGDpkgwvbqW6xbhYFzJ4GNTEsx0Yg24m4OK+wfKyekDDKs2f
	GqO/acyDZEIqoPGamaWXAstKxVVIzmO107WY2y3Gobui7NgWMqsqkTVA==
X-Google-Smtp-Source: AGHT+IE9PGpkxIATayNkKOYIn25iNoH+/2U6QJMbL/8pzJyCLEDJFpGaeSZGrpE0q68KrNypmjVw05RtF1U73UB5whw=
X-Received: by 2002:a05:622a:1a9f:b0:476:b783:c94b with SMTP id
 d75a77b69052e-4801e3f7427mr2303301cf.40.1745533807902; Thu, 24 Apr 2025
 15:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420175419.889544-1-gshahrouzi@gmail.com> <20250420175419.889544-4-gshahrouzi@gmail.com>
 <20250421124044.400628f1@jic23-huawei>
In-Reply-To: <20250421124044.400628f1@jic23-huawei>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Thu, 24 Apr 2025 18:29:57 -0400
X-Gm-Features: ATxdqUE5QDMBo5xoa61NQ3oiJvjCAcOwRQYcvy6rLZHVXpxmXg9tF43a7qIROJs
Message-ID: <CAKUZ0zLgH9Ec5FMEjXa59-bBEVooEQUOeGuZ9OJw=A3P3OWp5A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] staging: iio: ad9832: Add minor improvements to ad9832_write_powerdown
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	Michael.Hennerich@analog.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 7:40=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 20 Apr 2025 13:54:19 -0400
> Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
>
> > Minimize size of type that needs to be used by replacing unsigned long
> > with bool. Avoid redundancy by checking if cached power state is the
> > same as the one requested.
> >
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > ---
> >  drivers/staging/iio/frequency/ad9832.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/i=
io/frequency/ad9832.c
> > index a8fc20379efed..2ab6026d56b5c 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> > @@ -173,13 +173,19 @@ static ssize_t ad9832_write_powerdown(struct devi=
ce *dev, struct device_attribut
> >       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> >       struct ad9832_state *st =3D iio_priv(indio_dev);
> >       int ret;
> > -     unsigned long val;
> > +     bool val;
> > +     bool cur;
> >
> > -     ret =3D kstrtoul(buf, 10, &val);
> > +     ret =3D kstrtobool(buf, &val);
> That could have been done in the previous patch as you are changing the A=
BI anyway.
Got it.
> >       if (ret)
> > -             goto error_ret;
> > +             return ret;
> >
> >       mutex_lock(&st->lock);
> > +
> > +     cur =3D !!(st->ctrl_src & AD9832_SLEEP);
>
> Worth thinking about whether this driver will ever be converted to regmap=
 with regcache.
> If that's a reasonable thing to do long term this sort of optimization ad=
ds nothing
> useful as we'll skip the right anwyay if the driver is already in the app=
ropriate state.
Got it.
>
> This isn't a high performance path, so I'd not bother with the check for =
now.
Got it.
>
> > +     if (val =3D=3D cur)
> > +             goto unlock;
> > +
> >       if (val)
> >               st->ctrl_src |=3D AD9832_SLEEP;
> >       else
> > @@ -189,10 +195,10 @@ static ssize_t ad9832_write_powerdown(struct devi=
ce *dev, struct device_attribut
> >       st->data =3D cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
> >                               st->ctrl_src);
> >       ret =3D spi_sync(st->spi, &st->msg);
> If this fails, where doe ret end up? Looks to me like we now don't report=
 the error
> Anyhow, see guard() comment in previous patch.  These days we can avoid a=
 lot of
> this complexity by using that to allow direct returns where we first see =
the error.
Ah right, fixed that for the new version and removed the complexity by
directly returning.
>
> > -     mutex_unlock(&st->lock);
> >
> > -error_ret:
> > -     return ret ? ret : len;
> > +unlock:
> > +     mutex_unlock(&st->lock);
> > +     return len;
> >  }
> >
> >  static ssize_t ad9832_write(struct device *dev, struct device_attribut=
e *attr,
>


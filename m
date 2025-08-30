Return-Path: <linux-iio+bounces-23460-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980BBB3CB82
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 16:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B6E16C627
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7272254864;
	Sat, 30 Aug 2025 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isSRiKuW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B953730CDBF;
	Sat, 30 Aug 2025 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756565220; cv=none; b=QAMZ3R8w8bdNwWTlwi0RAvlKxIlGfz32XhWjU5bW6hopEST6gF5bEvAyHaFnoQkc2d48BYHonGpQ1i9wHCHtR4zbGvZlvblwto7/7He56IiTTAOy8NUGPJBTDrQCJCA7uFNusrUq7TMhEVgD9Wwz0qLrW+JboNuM721QoH/VSb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756565220; c=relaxed/simple;
	bh=m5MR+0ehlkpJ8CSZrbsaAhKPvHchaOdleoZk4uRFz80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWMUwxhVO4/59cpTZbKXDAZs+/AlMltNooHvzqQbsnziuo68e8A//4ko3/7klOVgbUGGVp+snlcD7jGvcCW0u4qYhDOkpRkxuYZ27vYdXMuDxo6uAEZhhO25G9HcmvNEgZQwxRxWpjxeIW1zG3kU5NHLi4Foj5q/dvkCAoNLf1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isSRiKuW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afec56519c4so393846966b.0;
        Sat, 30 Aug 2025 07:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756565217; x=1757170017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyYnrq0TjY+dlsbIKTtb2T4o84UWHSZ1FKhi72vax0U=;
        b=isSRiKuWsY1+MTGOMmfK75mUf4ZQC4sJ9R3QicqKiJGe7+PciVhc7sxnpJCwfQ6wQO
         lzQpxrE7ongLA/4tOpm2DmLqHUhz3XeDxxsVoCIe3tfOQ7tOfZRVZhPrbTa+jbqnerWm
         vzeKZhC5h0CEdBiTljSfjKBOeE/kYWEkjsxEW97/IwFCMoSfS2M+AptJ1nDCturdENLe
         Y6DHMq5r3Hg61voCLKP27p6RxzS3uGYvy/m0FK7+IqGR+HwKhoDzF3kAV3L2lpDvWT2K
         E25QnLfm+P9g2yamm+LA+4zaVCbT8JF7sEMIZg2j+OfJ9SwlrF2xMOfhrBy2BBsPAxJU
         7x1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756565217; x=1757170017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyYnrq0TjY+dlsbIKTtb2T4o84UWHSZ1FKhi72vax0U=;
        b=eDlCwQ1QWCswKpLt39yNi1cPdZGQBU1wVohGhELYYkZ6JoPkyaUHxeQiCguVfMbmZO
         9W9UbonNlwGgcpOCbP6z6oDbKqcbqpt7apabCquuIwU2n87r5H92ANPg8saHqIQAFvNR
         /2RQrHDfB8NWvsuZW4uHEr/fEEhKk3qXAoHqK4ZblkdU/93gySva7dFsYKnoYHipso49
         e+kzYOEQjuq1+YG5JAVwf5rVqGRdAQ1G3fHPFX8lOyoxjv8xRJ8F845CWmmRdacQeRJd
         0sdyEtbvkIb7oUAtzWIQ7ZGiilWiup4YWRQkzoRjAMAYL9ETsNNRytuU/ALTt9YkVo3z
         JMeA==
X-Forwarded-Encrypted: i=1; AJvYcCVog9Bv4ANKsZKeM+9RlzlIjrGOtC9aQk7b5ngcf08t6N8ILoO+0Y9stFv9ICnUs3T+ad7VqSfnbGE=@vger.kernel.org, AJvYcCX244UqJLshkvCNoby9T05RbJ6oFQH7D9fIzHVnx7IuTbN911FOgwMgi9SK0SmY/Mz/zYVGUUYtgzmCpBi6@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGwC5KARl1KwuOWbHeMBymOiHePGZSKmwEisG8ZTnubd2d2Qj
	3WcYOZwmtaIyMWi9j6Nxt3Q6I0wDvt361SikwOt3GaUadMbn4IP1Dm5O/qfFpqsElEmRHyThZU8
	/2ETtWqzSPeT15xoDcm/oaWc3vDTqN9Y=
X-Gm-Gg: ASbGncv6ov3BYhxCBDu332C0v1q5DYAKWw4NHRkT9yTkOTCITjGSPngfbkCHxffB2xy
	X+B8wnIHX6GdE/hkF8yghMm/rSKQc2LQjas/D4U/U4jB2RMqmZ6fSA6Mt1gUETZawRdD+Tz/RgY
	olbEj1NmiBMJ1p1A2PZmWJ6evmgvjd9LD98YGow4E4wpia/Kcu0pZMK1aqiB4ONKLxEhPEZx4P8
	7O6oYBFtZFjCn1UYurXh75jb6Tb
X-Google-Smtp-Source: AGHT+IH0oSUx4M8oyPrzCFbP39zh0zK0NK+/0+HvWjEyGZvzGyXy0nmmHqhlR01+koIaDPy0K/Djetp0dkZHJb9fgqo=
X-Received: by 2002:a17:907:7f0a:b0:af9:68d5:118d with SMTP id
 a640c23a62f3a-b01d97b5ab2mr211924366b.58.1756565216881; Sat, 30 Aug 2025
 07:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830113502.83102-1-akshayaj.lkd@gmail.com>
 <CAHp75Vc6J+Qm4hsV=PJn9Oyfn5xr9SZLGMagHm9NdFrkk9Y_5A@mail.gmail.com> <CAE3SzaSYLFFRL4OuqUbk8J0dWCuxedCyGiX2_tJySG1FC=w95g@mail.gmail.com>
In-Reply-To: <CAE3SzaSYLFFRL4OuqUbk8J0dWCuxedCyGiX2_tJySG1FC=w95g@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 17:46:20 +0300
X-Gm-Features: Ac12FXwfGpdPlAJmtttbZS5Qns4op2q3Gd4VeFD05A-vUvv33MG2f3q3gfZGXWM
Message-ID: <CAHp75Vcitq5+fJJMKFGC9Qsqe8yAuoxK99YohR8N9218iR_Ocw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: ltr390: Implement runtime PM support
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 4:24=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail.c=
om> wrote:
> On Sat, Aug 30, 2025 at 6:04=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Aug 30, 2025 at 2:35=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gma=
il.com> wrote:

...

> > > +static int ltr390_write_event_config(struct iio_dev *indio_dev,
> > > +                               const struct iio_chan_spec *chan,
> > > +                               enum iio_event_type type,
> > > +                               enum iio_event_direction dir,
> > > +                               bool state)
> > > +{
> > > +       int ret;
> > > +       struct ltr390_data *data =3D iio_priv(indio_dev);
> > > +       struct device *dev =3D &data->client->dev;
> > > +
> > > +       guard(mutex)(&data->lock);
> > > +
> > > +       if (state && !data->irq_enabled) {
> > > +               ret =3D pm_runtime_resume_and_get(dev);
> > > +               if (ret < 0) {
> > > +                       dev_err(dev, "runtime PM failed to resume: %d=
\n", ret);
> > > +                       return ret;
> > > +               }
> > > +               data->irq_enabled =3D true;
> > > +       }
> > > +
> > > +       ret =3D __ltr390_write_event_config(indio_dev, chan, type, di=
r, state);
> > > +
> > > +       if (!state && data->irq_enabled) {
> > > +               data->irq_enabled =3D false;
> > > +               pm_runtime_put_autosuspend(dev);
> > > +       }
> > > +
> > > +       return ret;
> > > +}
> >
> > This looks like overcomplicated and duplicate checks. Just make two
> > functions with and without IRQ enabling handling.
> >
> LTR390 only supports 1 event/interrupt which is toggled in this callback =
based
> on value provided to sysfs entry. There cannot be a version of this witho=
ut IRQ
> handling. It is supposed to do IRQ handling only.
>
> Pseudo code of the said function will be something as follows:
> ltr390_write_event_config() {
> if (interrupt needs to be enabled && previously it was disabled)
>      pm_runtime_resume_and_get()
> do_actual_reg_writes()
> if (interrupt needs to be disabled && previously it was enabled)
>     pm_runtime_put_autosuspend().
> }

I see now, yeah, this is unfortunate.
Just rename the leading __ to the _unlocked() suffix. It's easier to read.

> With the current function , we achieve the following objectives:
> 1. idempotency in refcount change. Meaning if IRQ is already enabled and
> if someone enables it again, it will not increase the refcount, same goes=
 for
> double disable case. This has been tested as well.
> 2. Only if the new and previous config is different, then only the refcou=
nt will
> change.
> 3. Adheres to previous comments received regarding checking return value
> of _get and ignoring that of _put.
>
> I genuinely don't see any duplicate checks here. In addition, I feel the =
above
> function is fine from a simplification point of view and cannot be bifurc=
ated
> further.

You are right I missed the asymmetric conditionals.

> Although, if you could clarify what you mean by further bifurcation, I mi=
ght be
> able to connect with your thoughts.

--=20
With Best Regards,
Andy Shevchenko


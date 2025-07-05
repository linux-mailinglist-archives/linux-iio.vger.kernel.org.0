Return-Path: <linux-iio+bounces-21369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E87AF9E31
	for <lists+linux-iio@lfdr.de>; Sat,  5 Jul 2025 05:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA8B1C82926
	for <lists+linux-iio@lfdr.de>; Sat,  5 Jul 2025 03:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596D714D29B;
	Sat,  5 Jul 2025 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqwv/OQf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511C17BCE;
	Sat,  5 Jul 2025 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751686680; cv=none; b=qvRZISioUOhuY7ls/LRAKsOy8BhTSkkry1wPT+kjp3ZeGzKrX8uoQRk54LmQRf4zhW12aimmg2YMomXTB4V4+TFLgt7kxgH8DzZaXsQR2hjdPjbp1rHHEBhA202/ngrwq+VQnuJM++UDaqSre3ssEDhmKRhiDlFLPzGpjhTkpYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751686680; c=relaxed/simple;
	bh=veIEtP5jVvWxQjvJ64riZxjeBaHu/S9oGBCuCx8fmEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0Eyz0gnEyIbmq9Jv0/Xz57e6qmY9QN8dzMTj8RI6KvWAafvmeVMstEF5yvtXKhtG7APPCVFWF18mDpiPtju96Whj7mFPMC+xg6uJgbmBXiYpSeY/TXLBck6yjoAXp4oM5kLvD1Eddd6wwiAYf2/m5xnPp0qBuBeKOJJv+ZvhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqwv/OQf; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e7fac85892so369480137.3;
        Fri, 04 Jul 2025 20:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751686676; x=1752291476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4om3ua96fXvEXIOy3marF7PLT0aH5hzFP+ZLeODrxY=;
        b=iqwv/OQf9nEJ1bNFs3SA6KDcBsaHta3HOhVhO21AjbuFbMgiTfQ4b7uU0s8XMJuzmj
         6bO11aR1rKjI+NrIrQFA8VkHJ6Qgnx29HfUcrS1uX+f2niNa6KKBzAcv8aqNcUbOdClt
         4DQF2ePA8Bri9s3brQifgW5rTLe8O4KbnQBbUlULB0ZMQg1cgAXHFs4JPVDBTQ7/n514
         rIM7G0bPbE05jtKoe/x9WQk2cfC2TvBYK8prltLUNta7xvUN6qGA0oA1ePAIMBxKdrmh
         WzLmRV9Zvj2WcaypKBuOQOWC3eOi+lYIn4wYbqyN/AD5b0C2wDGJLxvOve29SBzgQV2G
         vPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751686676; x=1752291476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4om3ua96fXvEXIOy3marF7PLT0aH5hzFP+ZLeODrxY=;
        b=AUCBmCWiCOmlbL8ye/cR+Tw+T0Vqbs5yfUeOy1rJE0B7CJCG0w0GM76QEJA4bbD5JU
         OMgUEOFWmS3vK7v3i6rnkV5xmHVeOZWpO0c7nKW3QQJG2434fP48fJYyaHZs8FPIoATE
         3rcCe8yPz5bTzXsiUC+8e2WM645ltecBZRLZ16uSs6ufTl+KUv4acueBtwFDUB4Y3hfK
         dsz6G5Q4/faWDtJXv7ZmJReCPkVXQC3A3yPZVa7Z1pOyYJwy9ztT23v0LKVryhPc3TzC
         0oiTSi6f7pBcHCWqaBt8A4ShkPu6suoMpQnYfVOMSRva4qr8tw1Sk3gnVPOe+zlDRmgY
         sZ2A==
X-Forwarded-Encrypted: i=1; AJvYcCW/HL39MO9hfcMf9GlBNCxa8ovj4HHwe4/B9votjjY24xpeWwfJJJAT+RMxzDqWD7RrFN45QH7jffNjJTB9@vger.kernel.org, AJvYcCW9sz9SON/3zfOGjWSPASU5mdbEYD+sN8j8kFsUZod477/btcjrDdhC27gdUWY6GShoQznzNLE8DW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVLTusemDbQhakPHJgEoI4jVLNKxLEj0YnpgDizY9veHsueqfB
	MpnHrDuBnOOcD+f5EkrZU7ol0nYt6H4yU6UzRXXQ+BQBRXeDzy5MCbUscmCgSDAG/Qy9GdRSrV5
	+V52sIS+R0sfYBUPSO9dqEmXWhQzLUw8=
X-Gm-Gg: ASbGncvim41RLtYBAgKnb3YiPNfRvDXE4Kx6CLCwpMTEOWLIPyeyqpNaMhy3uw5Mkt8
	yNI4Epzcj4wGAhAYBa6cEsKFFBxpgR4ryTrO5y/6KMPu6sDVTo5IPEJjTzvN0q9n5vBk4NxEd0m
	3BMCMso0mXB8W5RfA6nwo5Wt9RU2Ja42orCTQvl+Ml3i0=
X-Google-Smtp-Source: AGHT+IFso5aEBMGJvho4h3Q+6kYELE27l/TQba1W3PGMizii+e4XC6mbx4UIvaE3lML4KoWGPtVx+louUDQgwwKHVFo=
X-Received: by 2002:a05:6102:4190:b0:4eb:53ca:3cfb with SMTP id
 ada2fe7eead31-4f305bf46a9mr563012137.25.1751686676345; Fri, 04 Jul 2025
 20:37:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
 <20250618031638.26477-4-andrew.lopes@alumni.usp.br> <20250621185550.64aebefa@jic23-huawei>
In-Reply-To: <20250621185550.64aebefa@jic23-huawei>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sat, 5 Jul 2025 00:37:45 -0300
X-Gm-Features: Ac12FXwC2DDSHYAxCddFn2SIuEwLxcjFmHOXQy5APNHRzsxHrY3vOi6VLQPNkbk
Message-ID: <CANZih_Tm2w5C58tg36LzEMoLrqWgSGaJZQ_nxoDVUXFMJnZBXQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] iio: accel: sca3000: use lock guards
To: Jonathan Cameron <jic23@kernel.org>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 2:55=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> Please add extra description for where you have pushed locks up
> a level in the call tree and why that is fine to do.
>
Ok! I'll do that.

> >       switch (mask) {
> > -     case IIO_CHAN_INFO_SAMP_FREQ:
> > +     case IIO_CHAN_INFO_SAMP_FREQ: {
> > +             guard(mutex)(&st->lock);
> As below
>
> >               if (val2)
> >                       return -EINVAL;
> > -             mutex_lock(&st->lock);
> > -             ret =3D sca3000_write_raw_samp_freq(st, val);
> > -             mutex_unlock(&st->lock);
> > -             return ret;
> > -     case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +             return sca3000_write_raw_samp_freq(st, val);
> > +     }
> > +     case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: {
> > +             guard(mutex)(&st->lock);
> >               if (val2)
> >                       return -EINVAL;
> > -             mutex_lock(&st->lock);
>
> You can keep the old ordering here.  It doesn't matter much but
> easier to be sure about a patch that makes no functional change.
Ok!


> > -     mutex_lock(&st->lock);
> > +     guard(mutex)(&st->lock);
>
> This is a very large increase in scope.  Use scoped_guard() here instead =
to avoid
> holding the lock over a whole load of code that doesn't need it.
>
> >       ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_STATUS_=
ADDR));
> > -     mutex_unlock(&st->lock);

That makes sense! I don't know why I didn't use scoped_guard() in this
case before.


> >       if (state) {
> >               dev_info(&indio_dev->dev, "supposedly enabling ring buffe=
r\n");
> > -             ret =3D sca3000_write_reg(st,
> > +             return sca3000_write_reg(st,
> >                       SCA3000_REG_MODE_ADDR,
> >                       ret | SCA3000_REG_MODE_RING_BUF_ENABLE);
>
> This indent was already nasty so as we are touching the code good to clea=
n it up.
> For cases like this we can be more relaxed and if it helps readability go=
 a little
> over 80 chars (I think this will be 80 ish)

Great! I'll pay attention to that.

> >
> >
> >  static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
> > @@ -1307,22 +1259,18 @@ static int sca3000_hw_ring_postdisable(struct i=
io_dev *indio_dev)
> >       int ret;
> >       struct sca3000_state *st =3D iio_priv(indio_dev);
> >
> > +     guard(mutex)(&st->lock);
>
> See comment at the top - Making this change is fine but call it out in th=
e patch
> description as it isn't simple change to using guards, but instead to hol=
ding
> the lock for longer.  Change is fine but point it out as it needs
> more review than the mechanical changes.

Ok!

>
> >       ret =3D __sca3000_hw_ring_state_set(indio_dev, 0);
> >       if (ret)
> >               return ret;
> >
> >       /* Disable the 50% full interrupt */
> > -     mutex_lock(&st->lock);
> > -
> >       ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_AD=
DR));
> >       if (ret)
> > -             goto unlock;
> > -     ret =3D sca3000_write_reg(st,
> > +             return ret;
> > +     return sca3000_write_reg(st,
> >                               SCA3000_REG_INT_MASK_ADDR,
> >                               ret & ~SCA3000_REG_INT_MASK_RING_HALF);
>
> As below.
>
> > -unlock:
> > -     mutex_unlock(&st->lock);
> > -     return ret;
> >  }
>
> > @@ -1386,13 +1334,9 @@ static int sca3000_clean_setup(struct sca3000_st=
ate *st)
> >        */
> >       ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR))=
;
> >       if (ret)
> > -             goto error_ret;
> > -     ret =3D sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> > +             return ret;
> > +     return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> >                               ret & SCA3000_MODE_PROT_MASK);
>
> As below.
>
> > -
> > -error_ret:
> > -     mutex_unlock(&st->lock);
> > -     return ret;
> >  }
> >
> >  static const struct iio_info sca3000_info =3D {
> > @@ -1470,19 +1414,16 @@ static int sca3000_stop_all_interrupts(struct s=
ca3000_state *st)
> >  {
> >       int ret;
> >
> > -     mutex_lock(&st->lock);
> > +     guard(mutex)(&st->lock);
> >       ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_AD=
DR));
> >       if (ret)
> > -             goto error_ret;
> > +             return ret;
> >
> > -     ret =3D sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
> > +     return sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
> This adds a character to this line which means that either the indent of
> the following lines was previously wrong, or it is now.
> I think you need to add a space to the following lines.
>
> Check for other similar cases.
>
> >                               ret &
> >                               ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER=
 |
> >                                 SCA3000_REG_INT_MASK_RING_HALF |
> >                                 SCA3000_REG_INT_MASK_ALL_INTS));

Hm, correct me if I'm mistaken but I couldn't find this extra
character, I used the same number of tabs in both cases. Even in this
email it shows as having the same number of white spaces.

Thanks,
Andrew


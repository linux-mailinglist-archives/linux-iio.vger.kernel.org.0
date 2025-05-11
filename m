Return-Path: <linux-iio+bounces-19447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10280AB2A4B
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 20:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686C2171B03
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CA425EFBC;
	Sun, 11 May 2025 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqXXwnN3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0B522F;
	Sun, 11 May 2025 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746988605; cv=none; b=Lh9wChT4pierKkZO2LKfEXw9CsQv0M0VQ0mx4u7eJ2IUL5gZaav28EUozHdSGm7rbUAa1Tmiyef4KhMUxGlGddiSYkUlaXWsFOzDmJyS6r5VrUYd+mxnwkv+avlXdCyr1OuuwT/9zfHr6PswMCPOxmB4iI6PZHbZJu9MLhdwY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746988605; c=relaxed/simple;
	bh=yy5uI0gB4ZxjLt7ZHLjLGyR+f1C3zjpEVUs/3N5QraY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1rwqBIrFwjJ4kWOdANSeT4IpgJ7XD+hxm9FfDX3+hwj9jDanu1TiHFEQ4IkofUGRM7CvRvE6CVgtbrOT+T73H7EV2ZN5iYYOqOluK/3BKjL8Z4ErSH3FVTlBF+ENAVJjwraNFSR4VPuWmKUH7JO+BfjSivoaq+u6s82TZdWx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqXXwnN3; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4def2473a58so779899137.2;
        Sun, 11 May 2025 11:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746988602; x=1747593402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXppe9UTLDGbD+aEkgl2bNsm9yrGbGE6lie0L53bKtY=;
        b=bqXXwnN3Ou4e3XptPgSDMKYl6uxPe7MADThHqueM8U8beXI++lO2qmEb5O8dqQvmiM
         qA4jCyKAxiiw9Pir78QSdkDCZicZtEatE9WgrJ+ogyc1Wie5SM/eAPZhy4viwGZgGaRs
         KMtYgiiYoVi2oi+NSdd7VYUHHK0SviywVihJmHlbm+9su483mlmgu1PoxPsRn4Om8Sxn
         HbWS8SorOqWS7E/8K/D54r5C7zgWPUqpE7ZAKN+JrB0P3zj3YGR4uWvPbxmVI5+nL5RF
         WHTuDN3/vgINxvzaK4m+RiO9y1N+j/fugBZ0WjJ8eiN6wZkrmgqpyaMSLbAwL1GYe99K
         nf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746988602; x=1747593402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXppe9UTLDGbD+aEkgl2bNsm9yrGbGE6lie0L53bKtY=;
        b=tXrGnuLj6fJXtPcv4IIaZksWqjzEm0Xy6gLT3DGnF/kt7EOnT5eW01f/tIcYKiOkcN
         8nTQqiiomWU32wI8hU7uviRVmwwz3pS43yd8Vm3At0tlFFO6isTSEeVfGioyslpzQNh5
         slTNVqZW/UolvLVvEqu02RCo0Mm+zTP5W39A2Z82Zais/BQX1GA8EesfZRdN2qODLyu+
         QuvtvCufFayBCukCxGTa9t3klZdwIiyG0ChAzk7grz8SixRbITVVldyn5q5lsct+U7zP
         auHtCRdT6NMGeb0JvQUdjMvkuz/bNJ1b3xOiDG8YyBPDDI8vGXD5BqZ/ml9jxx9QWMo6
         yHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSwSszlgPXgW9Xs2CIyefkgwboJzc03KydbCKA4AexIyuuvvvgJxzsHPMhbVkM5U1buqvlE/WwAiE=@vger.kernel.org, AJvYcCWB7equYDuvkubpU1itxbyO/sMroacFJOt4VRf/eTZ+g+h/zFyEtMx6RtW+qmL9xYbGkMIeBDTKQb+ndCkz@vger.kernel.org
X-Gm-Message-State: AOJu0YzAnIZzp8MJ8o+De8gDDbvZg1yUpeX55uFgs3jJX+h3AyAe32wn
	oUOrUtSdi4rq2FkG+Cb0m9jH7y9Q995AyR8HH+zDPbI/DZMeq3vSEWeEQjqlw7wR8c2cxWPWhjT
	WMY2sgGNsRo55gGBJvSrxrprCn1c=
X-Gm-Gg: ASbGncss6NY+0AL2gquYfsgH8wp+5lCjR6BqPx4DEYrorU/0f28f5xM5CEWwK1wHkyQ
	1FxVlX3VKPhAJ00QaJnRw016dkaqUamK/hVvnZV1WqVXqI0DCLvvg2ttqHcepcr8HZcODFEPg0V
	mlKDHCNBuOMDG10b0gP4bPpS/FujQSilxwssEvIVwqvlMuGiM=
X-Google-Smtp-Source: AGHT+IFi5ANvWy3kqotn8wJ68LyB6NZnOj9jyuRnlVTXF1ufHrGgLdCcMFLxFyzVBUUScCt0gAQLR0Ui9JBujBiHlok=
X-Received: by 2002:a05:6102:3e16:b0:4c3:b0:46fd with SMTP id
 ada2fe7eead31-4deed3ec5cbmr8798342137.24.1746988602431; Sun, 11 May 2025
 11:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510190759.23921-1-andrew.lopes@alumni.usp.br>
 <20250511123416.729eb50f@jic23-huawei> <CANZih_QHNEuFTQ2NysUVOJ-PmrL-ASFeG5b8xBTbRSG=3ho-vw@mail.gmail.com>
In-Reply-To: <CANZih_QHNEuFTQ2NysUVOJ-PmrL-ASFeG5b8xBTbRSG=3ho-vw@mail.gmail.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sun, 11 May 2025 15:36:31 -0300
X-Gm-Features: AX0GCFu7nkANHOy1KVHO10yniUzFxYg8uCiA6HE_1g2tPiVkDBckWe11evuPnV4
Message-ID: <CANZih_SmneYr+jK9Apuif66vfCcpni7K+CzMk32-hZt-LRrZWw@mail.gmail.com>
Subject: Fwd: [PATCH v4] iio: accel: sca3000: replace usages of internal read
 data helpers by spi helpers
To: Jonathan Cameron <jic23@kernel.org>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, 
	David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, andy@kernel.org, 
	jstephan@baylibre.com, linux-iio <linux-iio@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I noticed now that I replied again only to Jonathan. I'm forwarding
this to all stakeholders.

On Sun, May 11, 2025 at 8:34=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
>
> A few things inline but clearly main thing is to reply to Andy's other
> points on v3.
>
Thanks! I replied to other Andy's points.

...

> > -static int sca3000_read_data_short(struct sca3000_state *st,
> > -                                u8 reg_address_high,
> > -                                int len)
> > +static int sca3000_read_data(struct sca3000_state *st,
> > +                          u8 reg_address_high,
> > +                          int len)
>
> I'd keep this where the original sca3000_read_data() is
> That will give a shorter, more obvious diff and puts the code near where =
it
> is called helping review.
Good idea! I'll do that then.

...

> >  error_ret:
> >       return ret;
> This shows the age of the code.  Just return in error paths above rather
> than a error_ret: label
>
> Might be a good idea to do a precursor patch tidying up any cases of this
> before the one doin gthe spi changes in ehre.

Ok! It makes sense. I'm really doing a lot of different changes in
this patch already.

>
> >  }
> > @@ -432,13 +434,13 @@ static int sca3000_print_rev(struct iio_dev *indi=
o_dev)
> >       struct sca3000_state *st =3D iio_priv(indio_dev);
> >
> >       mutex_lock(&st->lock);
>
> Another patch to use guard(mutex)(&st->lock); etc would be help clean thi=
s
> up by allowing direct return in the error path.

Great! In this case, would you suggest the following order?
1. One patch for general style changes, like the removal of error_ret label=
s;
2. Another patch for spi changes;
3. And another one for using guard(mutex)(&st->lock).

> > -                     ret =3D sca3000_read_data_short(st, address, 2);
> > +                     ret =3D spi_w8r16(st->us, SCA3000_READ_REG(addres=
s));
>
> spi_w8r16be() then no need for the endian conversion below.
...
> > -                     ret =3D sca3000_read_data_short(st,
> > -                                                   SCA3000_REG_TEMP_MS=
B_ADDR,
> > -                                                   2);
> > +                     ret =3D spi_w8r16(st->us,
> > +                                             SCA3000_READ_REG(SCA3000_=
REG_TEMP_MSB_ADDR));
>
> As above. spi_w8r16be()

Great! I didn't know this one. I'll change that then.

> >               mutex_unlock(&st->lock);
>
> >
>
> As above. Put the new implementation of this here so we can easily see wh=
at
> changed.

Ok! Thanks for pointing it out.

--
Thanks,
Andrew


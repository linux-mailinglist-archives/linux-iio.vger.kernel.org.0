Return-Path: <linux-iio+bounces-18947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09985AA62C2
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 20:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB3B1BC6B75
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 18:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8862721FF46;
	Thu,  1 May 2025 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="K01x2VF6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933B7215182
	for <linux-iio@vger.kernel.org>; Thu,  1 May 2025 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746123846; cv=none; b=ayndlFeCYIICcqJaJUUyt4KH3dfqvIxivw/rwHPP/bYOMllKH0oUc3s7/hR5AYatikSACkxUy+oheG7Wi4M+lRWrfldcyvqMkpDRup7CyxvC8KtfM84fnDTnfxj27IFpfvohLmBgQ/0jFvCCV/q4jOjDMQyQdhsKIpHMvj4aQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746123846; c=relaxed/simple;
	bh=R25djgZhP1AIR7IMN71wwXztnvNcsRACLj5saWj2Ga0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuDsT70Ew/ozoVPit6sNhMWskFuT/70NUpRgeIGE20ongW+5923Bn8PO9XBgCJJIzs0lXICi0lM+kY7ohSXDLwIZTn/o1CNhs7TtTW31dSqy/XgV+l36u9joVUoJCG/jFe2WoAjSA9TOs1arQ2SDP2ynjhRKJYUo6TxjLljtduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=K01x2VF6; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-871a7ebd638so32905241.3
        for <linux-iio@vger.kernel.org>; Thu, 01 May 2025 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1746123841; x=1746728641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKieE7pe/erhC9SldEx7kcMtdvNqRZUyQreMOM3HnYA=;
        b=K01x2VF6UWt1yizCpCYX0DKBr23RIlbmgzc77uruYyxD3LBhaIrEtMesNyrgB4fHmY
         e8hx3gogGRQVXrp+hbzbjtld5NQDo2+QwED9hhHoqvXxfwKadVMzjxp4jcnkplAssrVT
         /esmLZ0IEU9XuhAUaPeM0i5ZXwFrJ6n+pkjfbz8mX8TaYfU+5a0q3Ad3yKDEjhJ47lgq
         3gekdFfjQmckrwD3f5tp3BJAU9uQVA+PXOH5SJaUpTgO92rDWxaETps5obkxX7i7o67s
         7wLY6EQyH8V2+ZM1iaGtzTOyRh3owZCd8lKgNdjSwBxecKgVzTG1A1M++EopccDYUFtK
         C/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746123841; x=1746728641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKieE7pe/erhC9SldEx7kcMtdvNqRZUyQreMOM3HnYA=;
        b=cjZM+cihoTm6sle+TIp+14ZKMYLnqk7WfGDjGiqpMn0VzjvUvXR60FbLcYEFyGbPKY
         grI2+GhlZiTmcJdIjTkWAhoWjEkH99gVZZgg9oID9guyjUGefE9BBgUH+smlojP6GY3/
         hsDMJfNJY0Nph1xSY2doaBpkmKZElj8Pl8eB63xVseeoPuTQuTQZYQY22EN9gQ3WHjWy
         yTL5YqzH2dbbnZEbYGEJlK7hY/f6vZF5+oL5kSKFC04Twvt3iGEj1H92RHDsTATfqLMT
         LpcKdZy5tbGPComN8rjBmnYbfB/zHG3R5OW6lTaOCJHuw7CRwPfJtTLuvalMo89KoA+4
         Hhkg==
X-Forwarded-Encrypted: i=1; AJvYcCVo5cDVasJNRM9tEGM3R2rqVh6Gx/Ho/jA6sMbJOVf2BAFhm0xvwiaHJy291EyYYL8MUvsVqtRDJ2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4qWRQv0uoMD++5+ITESW9J6cM1R3bT6m3+gmgjEw2Dv2lS/R8
	92ImZvxQP4sjG96Wc1ndAHukcNjakQ9Sl7vHjO+roClUvnlyMKbfcTHGKrATmkU0/ZRFun8tS8F
	YwDtaFMWRmCkSw1jTlbgsYGRtWsOAOzSAWxe78Q==
X-Gm-Gg: ASbGncvGIbZGbpeBeF3TQqJ6NeD0aZKeB+JXTxqSLpo7IKOy57NvGR5cOKX3ZR/FwMm
	z4ZYaJmQkTXDD8Z+M1uPXPr+jN6d9NuW9DB1TPFKpQfvYQmo6EJHBUU6Po5cmxSxR9k/9NuOBn5
	I43+JNEDRBnSh1HhenUse3lyx7fNqmVYzQVnUCGYwpODA3e6tapI4ez3s=
X-Google-Smtp-Source: AGHT+IGWWNRhxG2HEUzqmGCU2xI7QkYEcjzP8FMaDAQmDwZBTjenK0gjCCdbSoJRqFfDBEAAXhJgO04NM715mXiJenE=
X-Received: by 2002:a05:6102:3b13:b0:4c1:966a:3c4e with SMTP id
 ada2fe7eead31-4dafb7cf171mr4760137.9.1746123841240; Thu, 01 May 2025 11:24:01
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429093923.347370-1-mikhael_abdallah@usp.br> <20250429160710.00004a1b@huawei.com>
In-Reply-To: <20250429160710.00004a1b@huawei.com>
From: Mikhael Abdallah de Oliveira Pinto <mikhael_abdallah@usp.br>
Date: Thu, 1 May 2025 15:23:50 -0300
X-Gm-Features: ATxdqUFPupo7rEqN_5lY9luIheAEuwxJcBVCqfvEFEAY-6cf5DLc6HZmBh544OY
Message-ID: <CAC46vBch9QooNOA6hgLd9NN_954DR+V-r06ZW0EdW4MfDudCbw@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: sx9500: Deduplicate buffer managing functions
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jic23@kernel.org, Augusto Bernarde <augustomb@usp.br>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thanks for the feedback. I've decided not to continue with this change
and will abandon it.

Best, Mikhael

Em ter., 29 de abr. de 2025 =C3=A0s 12:07, Jonathan Cameron
<Jonathan.Cameron@huawei.com> escreveu:
>
> On Tue, 29 Apr 2025 06:39:23 -0300
> Mikhael Abdallah de Oliveira Pinto <mikhael_abdallah@usp.br> wrote:
>
> > Refactor to share logic between buffer enable/disable handlers.
> >
> > Signed-off-by: Mikhael Abdallah de Oliveira Pinto <mikhael_abdallah@usp=
.br>
> > Co-developed-by: Augusto Bernarde <augustomb@usp.br>
> > Signed-off-by: Augusto Bernarde <augustomb@usp.br>
> > ---
> >  drivers/iio/proximity/sx9500.c | 50 ++++++++++++++++------------------
>
> In my view this isn't a significant enough reduction to justify the more =
complex code.
> Particularly in the error paths.
>
> Jonathan
>
>
> >  1 file changed, 23 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9=
500.c
> > index c4e94d0fb163..75459c85116b 100644
> > --- a/drivers/iio/proximity/sx9500.c
> > +++ b/drivers/iio/proximity/sx9500.c
> > @@ -674,52 +674,48 @@ static irqreturn_t sx9500_trigger_handler(int irq=
, void *private)
> >       return IRQ_HANDLED;
> >  }
> >
> > -static int sx9500_buffer_postenable(struct iio_dev *indio_dev)
> > +static int sx9500_buffer_manage_chan_users(struct iio_dev *indio_dev, =
bool enable_channels)
> >  {
> >       struct sx9500_data *data =3D iio_priv(indio_dev);
> >       int ret =3D 0, i;
> >
> >       mutex_lock(&data->mutex);
> >
> > -     for (i =3D 0; i < SX9500_NUM_CHANNELS; i++)
> > +     for (i =3D 0; i < SX9500_NUM_CHANNELS; i++) {
> >               if (test_bit(i, indio_dev->active_scan_mask)) {
> > -                     ret =3D sx9500_inc_chan_users(data, i);
> > +                     if (enable_channels)
> > +                             ret =3D sx9500_inc_chan_users(data, i);
> > +                     else
> > +                             ret =3D sx9500_dec_chan_users(data, i);
> >                       if (ret)
> >                               break;
> >               }
> > +     }
> >
> > -     if (ret)
> > -             for (i =3D i - 1; i >=3D 0; i--)
> > -                     if (test_bit(i, indio_dev->active_scan_mask))
> > -                             sx9500_dec_chan_users(data, i);
> > +     if (ret) {
> > +             for (i =3D i - 1; i >=3D 0; i--) {
> > +                     if (test_bit(i, indio_dev->active_scan_mask)) {
> > +                             if (enable_channels)
> > +                                     sx9500_dec_chan_users(data, i);
> > +                             else
> > +                                     sx9500_inc_chan_users(data, i);
> > +                     }
> > +             }
> > +     }
> >
> >       mutex_unlock(&data->mutex);
> >
> >       return ret;
> >  }
> >
> > -static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
> > +static int sx9500_buffer_postenable(struct iio_dev *indio_dev)
> >  {
> > -     struct sx9500_data *data =3D iio_priv(indio_dev);
> > -     int ret =3D 0, i;
> > -
> > -     mutex_lock(&data->mutex);
> > -
> > -     for (i =3D 0; i < SX9500_NUM_CHANNELS; i++)
> > -             if (test_bit(i, indio_dev->active_scan_mask)) {
> > -                     ret =3D sx9500_dec_chan_users(data, i);
> > -                     if (ret)
> > -                             break;
> > -             }
> > -
> > -     if (ret)
> > -             for (i =3D i - 1; i >=3D 0; i--)
> > -                     if (test_bit(i, indio_dev->active_scan_mask))
> > -                             sx9500_inc_chan_users(data, i);
> > -
> > -     mutex_unlock(&data->mutex);
> > +     return sx9500_buffer_manage_chan_users(indio_dev, true);
> > +}
> >
> > -     return ret;
> > +static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +     return sx9500_buffer_manage_chan_users(indio_dev, false);
> >  }
> >
> >  static const struct iio_buffer_setup_ops sx9500_buffer_setup_ops =3D {
>


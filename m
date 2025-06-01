Return-Path: <linux-iio+bounces-20116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8024FACA048
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 21:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A3C3B2FE8
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57C0239086;
	Sun,  1 Jun 2025 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/Re1fE6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17B22DCC01;
	Sun,  1 Jun 2025 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748806721; cv=none; b=pcgw1Ym/uIkbGEea2aOndCansrgO/DKReWlCmvIDDFc2TUZwwKEpSV+kR9Ch6zT7OK9TnSoqTbeZZ+nI4UYHtQTj9ifDy5Jeeen+ZmXnOsWiTJ1uD97LC+VYS0yiWHwmLWGdexywPbwrTRPQlwCxBype5UuxLKD+gPCEZs3d0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748806721; c=relaxed/simple;
	bh=IeG8UKCg4lvF/tYhYOPRz/Q1JPgIutr1oWCut5JjwBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6R6VVYtt7ZhQwu6mWWm9irVoXXQN1XgFzV9tAYMsEjtHCI9YBtk9yYXXQO/+ozaIuH0rhQcrcIVl8CpbPruxJcJ/SawKHFBXp13u+7nPYNesioafSNBADY0Tk0cdKSHN8sEubxpC8XqnsgrELhURfE5U/akr8dstg9azkiCnEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/Re1fE6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-adb4e36904bso232390166b.1;
        Sun, 01 Jun 2025 12:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748806718; x=1749411518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B11mIr/s1+fKxEHSw/QmoGkOx26Vq2+vDkpLrQaTVx4=;
        b=f/Re1fE6aTUYVbQ0IJbpA2USQOBBnCrBhGWx/dFhPuX3J6zVRwBjUlW6gGsG1+xINt
         8bbHDckfNOMCBthLCrRSMLSMMFUZpQci2XUFZEuwXDScK4zZsS2A2+Bxo2FJ0HzPEY13
         ebtI7WQqPLDH9UM+zmwVHbFcGvyb3fcc0iMeEmm0OqyhXZyyqJ7kLHY2xA5kokT0TLzo
         T/SA87123tULwkPFV5cE4q75fOYYMuxYgSRAN4Q1TtyGooSYF4wcLmIH6tobFV2Yszhs
         Xha8yd+nglrLDAIKOF3fcOoh6OY0a9DRD3QhhzyFLiWsA3/G9kBC8qqM8fgZw/UhFvaD
         XVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748806718; x=1749411518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B11mIr/s1+fKxEHSw/QmoGkOx26Vq2+vDkpLrQaTVx4=;
        b=JQy9MVB+dInRCtZckfrGYWOKxKizaWVA6DGC6V3/y7i6Um8shcVUH4FzgFGy7RAdvJ
         /Vn6WRHyMXgKswEkTXiPMhHXH4jPhEtXIZ/4e1bzm6zoKZvk8hOdmhF7n1QuJXEQti5U
         UeZrsjN0YH8QtfdVGqu8sxJLoqjxNHrYKFbzz4v24jrBGNK6AdNqDE8DFydwUmZmq/0J
         oHy5/6U4FHhZJ/Zw8JBqFXQPXTIfvPH7RUPNply5rEPVg1f2FmYujB0+YK54PVLA0HQK
         jxrA3By4rGRwsND1bh7JilJi4GEEtMw1EN+N9UeAk0R+SphBneoCj1r1dFAnTne1jUsv
         1ygg==
X-Forwarded-Encrypted: i=1; AJvYcCVxpDxxzaUUBFKOckY07CxXh6WND5GP4zYMnMKjYcG/EU5kyxfBJnXbl1MPsfPeY7coV1EZcqFc/Ao=@vger.kernel.org, AJvYcCWJej44rkhE37xZ+9s9BQu+GGNp54ESUvjvyjD5tLc6Ap0kXaiTlqBeLy8wpOpd4ejp5Nw8f3A0EZAz@vger.kernel.org, AJvYcCXV2f4DAUOdHP9D54go8f6ny9G/5saGVpy7G1HJuGgUqgnMubmhR8putoCyNCh2sDXwovdYW3cz9afqFyQA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz978LOoCllwiS/uEf2RHs+Kl9K3hFcqFqcretlXOZWonzB/MAm
	LkKW0gtC04LVsJZAwGWQ6G1/O/1Lhe/ZuhVowtE4oZRTtJFUOjkvjRb8ZZZC75Qx96/F3amN30V
	Dm/yd4OFOYK5Tc1vuqLDTf2T0ETH1sFk=
X-Gm-Gg: ASbGnctNLXPwRWpFejJGDhbyWt0impTXPapkZkcpiczhBjPj5VpTjzcLa+tucMPt3JY
	9HfG/l/fiN76cOUqTPSlTQTyhkvHMfZbijlVOigQi6Y5fH/I6bq0qxshU2EYBrK9GUPbsL5WzXv
	aKNElEhrUgU+c5ZuP1vSby5d6GBg5Xj60q/jUnlm01lxI=
X-Google-Smtp-Source: AGHT+IEqDt9KECAGnDpIRfjKZd/9Tuo1/lahFMEac0foWC/x+1y5j8HG4Ba0gnqpHlOPs6kVPE8N32+n6BYylslE2dA=
X-Received: by 2002:a17:907:9450:b0:ad8:9e5b:9217 with SMTP id
 a640c23a62f3a-adb36bfb683mr906120166b.45.1748806718050; Sun, 01 Jun 2025
 12:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-8-l.rubusch@gmail.com>
In-Reply-To: <20250601172139.59156-8-l.rubusch@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 1 Jun 2025 22:38:01 +0300
X-Gm-Features: AX0GCFvqz6k77Rudh7415Hm0JJsDqI38u-Cisvz1_GqJgo6zEIT4Nkzp4fjjzko
Message-ID: <CAHp75VemOXhpRp2hfDhvzi3y5j5oL-_0xMmWRWkwEtX7Ks5nMQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] iio: accel: adxl313: add activity sensing
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 8:22=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.com>=
 wrote:
>
> Add possibilities to set a threshold for activity sensing. Extend the
> interrupt handler to process activity interrupts. Provide functions to se=
t
> the activity threshold and to enable/disable activity sensing. Further ad=
d
> a fake channel for having x, y and z axis anded on the iio channel.

IIO

And what does the 'anded' mean?

> This is a preparatory patch. Some of the definitions and functions are
> supposed to be extended for inactivity later on.

...

> +static int adxl313_is_act_inact_en(struct adxl313_data *data,
> +                                  enum adxl313_activity_type type)
> +{
> +       unsigned int axis_ctrl;
> +       unsigned int regval;
> +       int axis_en, int_en, ret;
> +
> +       ret =3D regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axi=
s_ctrl);
> +       if (ret)
> +               return ret;
> +
> +       /* Check if axis for activity are enabled */
> +       if (type !=3D ADXL313_ACTIVITY)
> +               return 0;
> +
> +       axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);

If it's false, it will be false anyway. No need to defer the check:

  if (!axis_en)
    return false;

> +       /* The axis are enabled, now check if specific interrupt is enabl=
ed */
> +       ret =3D regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval=
);
> +       if (ret)
> +               return ret;
> +
> +       int_en =3D adxl313_act_int_reg[type] & regval;
> +
> +       return axis_en && int_en;

  return ... & regval;

> +}

I have already commented on this a couple of times.

...

> +       /* Scale factor 15.625 mg/LSB */
> +       regval =3D DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);

I would rather do

val * MICRO + val2

which is read more naturally (we will easily get that the expression
uses MICRO scale).

...

> +       int ret =3D -ENOENT;
> +
> +       if (FIELD_GET(ADXL313_INT_ACTIVITY, int_stat)) {
> +               ret =3D iio_push_event(indio_dev,
> +                                    IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> +                                                       IIO_MOD_X_OR_Y_OR=
_Z,
> +                                                       IIO_EV_TYPE_MAG,
> +                                                       IIO_EV_DIR_RISING=
),
> +                                    ts);
> +               if (ret)
> +                       return ret;
> +       }
>
>         if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
>                 samples =3D adxl313_get_samples(data);
>                 if (samples < 0)
>                         return samples;
>
> -               return adxl313_fifo_push(indio_dev, samples);
> +               ret =3D adxl313_fifo_push(indio_dev, samples);

This is not needed...

>         }
>
>         /* Return error if no event data was pushed to the IIO channel. *=
/
> -       return -ENOENT;
> +       return ret;

...and this looks wrong.

Before the case was clear, if we have no respective bit set in the
int_stat, we return ENOENT. Now it depends on the other bit. If this
is correct behaviour, it needs a comment.

--=20
With Best Regards,
Andy Shevchenko


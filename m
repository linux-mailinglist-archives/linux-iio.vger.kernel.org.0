Return-Path: <linux-iio+bounces-20702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7AAADADDF
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 12:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB473A69B0
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 10:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF2E27F178;
	Mon, 16 Jun 2025 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO4eQEqU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A823C1465A5;
	Mon, 16 Jun 2025 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750071554; cv=none; b=jjlxPvskZeErpzAD7OWOhtXpsbrwknV/HWk4W6hwrKErmQOLZNbso1BboZ1KP/f6FLAW+q64CAI5aCo915yULdJRrTRZeba2b8MXknvtv9OX+w59dAO+YSJfHGkq4dx717pESizcLbvyT7hgRcS3mV6xBJkQQt0pfmYGsYVeGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750071554; c=relaxed/simple;
	bh=ivAyhqHkPrwFRYJzP0f+A9vzerfjqRCkdprjo4/m3aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSQyv8Ff5mMs07PNBex3Yn7LTZZYPRTJ0qxTDochMwaiBmdfr5OBazLN/FytlrYjIxTjzGQA6Y9Pxf4gpJFTrTWE7OLoE/1U4ZslbdFj0Oifr+XswBpm/XcyIKmeb86qIrz9BwvgZKZ2/0rGV8Y/aAKSAOwh+IDLceqLdJ7zgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO4eQEqU; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ade4679fba7so800681266b.2;
        Mon, 16 Jun 2025 03:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750071551; x=1750676351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUerpZOJO73onNYo92QlKelLbykJvFa6HSMQaRUUq74=;
        b=WO4eQEqUni3TWzTsEdBQRAv6Key5XqbHtvi35OYeBw5HwDZ2HvRSXurSEfjmSiEwiU
         ITlra45M3QRsQHBx79l1Qe43Hr9EAezgGhX7mElaJ46CzyuP9YP7NRZRDAa7aXydC20Q
         P/1kzOS33F5TgsuwKNcCcpt4UC2BvZBNJAEQeI2EkXIl6v+0Q+pOCl8nk2Q27IGCaRDb
         6WKP8xvPZofRvR3DF6RvNSQjLjuaE3PjxAHpR3mRt3ss7Y6KpRbecRc2JnD0TEsWdVME
         CE46rG3M+nPCpTJkILWADepuTxv2FA3xwPvVsiPxVAUHaEVO9EgIDl/r0IVshDpalkO9
         /vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750071551; x=1750676351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUerpZOJO73onNYo92QlKelLbykJvFa6HSMQaRUUq74=;
        b=qsQTIF1OOLDIOQ1BHNJSkC50EMr1sG+RB4FEw6jd1kcQ/IthiqRjxp8GVQZaE4bRUY
         aH11gRnBfyYNm4W/8a2hLKQUSMwmrPMdRSqehqAtLxfErSXq+Hnf4xYZTNubQc44tmfa
         DDXFqUrEoXE6mGmFV+kOWaIMce04M3lR9fWlFp063J/XHIusyZIMtTSVb2d63R8awCLL
         LoMGPPnH50B0snAKsGX4lQV0z9GjIN4cvBOsmk10eSMjvIQ0XKj6Tmc+u+gW8jDCN0SL
         VaX5XZf6zkvca4KHifAlX31crJ8yg2wgKs9k6ODCyUVGcfQ8YU5Kl5GTGGQy2QE9rxjl
         KovA==
X-Forwarded-Encrypted: i=1; AJvYcCVpfx1MvhQZL/cpzSfCNpJsjoNIXA3w9CwZwKzKaZelfx3Qr5Grrg7Jc0VZ0iqiznF/t4CD0pmU8Cc=@vger.kernel.org, AJvYcCWrOoSVh76FO65EyMMxIDiKkNfa2/8QZN3vVdeZRFeFThl1b4NQf9yBYEe5fsKSiCus/OJi9/dZ3hK5@vger.kernel.org, AJvYcCXKirJA/eU3CENo6/VQHejd4lq4RN8KKTSbC6u7/a/++6RwvjtYw3HKkFm3Zsh6Jus9rwe65a2Xt+KubExk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4hUtKHF9F6GgaMk0vt6+3xbGnD9u+tfGw4ZGX3DUYT14SIjdi
	45fzacM1hsvl+EeeBvrn480bG+n6D+Ipu2AKADIjnfRsYvubP1jlJGl3cv2cZfSD7S3NZ29Xvj6
	Hs21E6rutng5+HnU+wc8NccGKXqRIQxU=
X-Gm-Gg: ASbGnct95bWdA/Cy/fEQ03ZCHV/VZQQphmHf4xlMhV3vcbn+HAdkp9VrOwRQBzLgRNP
	e/Ciy58DsW29okCfhti862X9TbkM0muZ9JAihJEq4rOkXlYTO8CQY9KIzJzkoS8nyPyQNA4zq/k
	3MIP117IrvyZ5G7zUjpUezKt3VbFg8dhaTZX4BoFachvJCz4vQEk6UNTmo
X-Google-Smtp-Source: AGHT+IEj0l0JJd/YOnNnj6VYrjKKVCp+t0CG6lxcnBcfrsUbqPiZvWYlOO3jWuW8VuwwavUgBZGYerQdMSELsDjKuPA=
X-Received: by 2002:a17:907:9285:b0:ad5:5198:b2ad with SMTP id
 a640c23a62f3a-adfad59ac32mr846089466b.48.1750071550733; Mon, 16 Jun 2025
 03:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615222258.117771-1-l.rubusch@gmail.com> <20250615222258.117771-6-l.rubusch@gmail.com>
In-Reply-To: <20250615222258.117771-6-l.rubusch@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 16 Jun 2025 13:58:34 +0300
X-Gm-Features: AX0GCFu4RcbVhsjuRncgzOdsGD5SqBMHKarvEM9c27WzKqfcMa8HYO2IM5SjMgs
Message-ID: <CAHp75VdWtY6nxFFTucoCRiq+tM5caL5N1yp_15=FSAZ7Vyk_7Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] iio: accel: adxl313: add inactivity sensing
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 1:23=E2=80=AFAM Lothar Rubusch <l.rubusch@gmail.com=
> wrote:
>
> Enhance the interrupt handler to process inactivity events. Introduce
> functions to configure the threshold and period registers for
> inactivity detection, as well as to enable or disable the inactivity
> feature. Extend the fake IIO channel to handle inactivity events by
> combining the x, y, and z axes using a logical AND operation.

...

> -       axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> +       /* Check if axis for activity are enabled */
> +       switch (type) {
> +       case ADXL313_ACTIVITY:
> +               axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> +               break;
> +       case ADXL313_INACTIVITY:
> +               axis_en =3D FIELD_GET(ADXL313_INACT_XYZ_EN, axis_ctrl);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
>
>         if (!axis_en)
>                 return false;

So, this looks better without a variable?

  case FOO:
     if (!FIELD_GET(...))
         return false;
     break;

On the first glance it seems that next changes don't affect this.

...

> -       /* Start modifying configuration registers */

Stray change, the next patch restores this. So why change to  begin with?

>         ret =3D adxl313_set_measure_en(data, false);
>         if (ret)
>                 return ret;

...

>         /* Enable axis according to the command */
> -       axis_ctrl =3D ADXL313_ACT_XYZ_EN;
> +       switch (type) {

I was wondering if you can use switch-case earlier in the series.

> +       case ADXL313_ACTIVITY:
> +               axis_ctrl =3D ADXL313_ACT_XYZ_EN;
> +               break;
> +       case ADXL313_INACTIVITY:
> +               axis_ctrl =3D ADXL313_INACT_XYZ_EN;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }

...

> -       if (info !=3D IIO_EV_INFO_VALUE)
> -               return -EINVAL;
> -
> -       switch (dir) {
> -       case IIO_EV_DIR_RISING:
> +       switch (info) {
> +       case IIO_EV_INFO_VALUE:
> +               switch (dir) {
> +               case IIO_EV_DIR_RISING:
> +                       ret =3D regmap_read(data->regmap,
> +                                         adxl313_act_thresh_reg[ADXL313_=
ACTIVITY],
> +                                         &act_threshold);
> +                       if (ret)
> +                               return ret;
> +                       *val =3D act_threshold * 15625;
> +                       *val2 =3D MICRO;
> +                       return IIO_VAL_FRACTIONAL;
> +               case IIO_EV_DIR_FALLING:
> +                       ret =3D regmap_read(data->regmap,
> +                                         adxl313_act_thresh_reg[ADXL313_=
INACTIVITY],
> +                                         &inact_threshold);
> +                       if (ret)
> +                               return ret;

> +                       *val =3D inact_threshold * 15625;
> +                       *val2 =3D MICRO;
> +                       return IIO_VAL_FRACTIONAL;
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_EV_INFO_PERIOD:
>                 ret =3D regmap_read(data->regmap,
> -                                 adxl313_act_thresh_reg[ADXL313_ACTIVITY=
],
> -                                 &act_threshold);
> +                                 ADXL313_REG_TIME_INACT,
> +                                 &inact_time_s);
>                 if (ret)
>                         return ret;
> -               *val =3D act_threshold * 15625;
> -               *val2 =3D MICRO;
> -               return IIO_VAL_FRACTIONAL;
> +               *val =3D inact_time_s;
> +               return IIO_VAL_INT;
>         default:
>                 return -EINVAL;
>         }

I still don't get what's wrong with helpers for nested switches?
Instead of doing ping-pong with so many lines (due to indentation
changes), just create a helper from the beginning. In this case this
will look more like


  if (nfo =3D=3D IIO_EV_INFO_VALUE)
    return my_cool_helper_for_THIS_case(...);

Note, I admit that not all the cases may be done like this, but just
look at this again and perhaps something can be optimised.

--
With Best Regards,
Andy Shevchenko


Return-Path: <linux-iio+bounces-22599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F775B21568
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 21:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93221A226A5
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F0725A655;
	Mon, 11 Aug 2025 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv2GulXz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E512BD580
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940881; cv=none; b=skoMOS1BWFk3S/bLRE79azCxp1xAf5u2GWtFu4AaPPoXgA8o/Vl3L3kEXoNR9jYg/QIqQTZqHnBFGhfLaPduORPiiFkXdt9XbNGHTJxh8IRQedjyFjV0nxe5nJBajYWU2cHlW912CqR3Cgy4sKf5X1czBM7zorbR8+esSlJvp/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940881; c=relaxed/simple;
	bh=RjxYP21Sfd7JXTVlLkHlMhYbEo34PoLIvP69vzd9EXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z27mN+JEIHS6szNxxMK+oECYGf3wfpFWmkPqkJMQcMBCSy1k5SE6Ld27wIpHI2UY9FegPSQARUdM3087qGkmXFc1PZN+6aWNVs+JJvLXInzgcZ8QYvfbtrJMsjXKyYqfOXDHCZwHPFVy1oPxn/EpEgX5rzFVwifg2WCVtZMqyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bv2GulXz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af96fba3b37so890058366b.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 12:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754940878; x=1755545678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMmPbFgs3yxmq05QjFKFHmBagygbNuGevzmgwmt6fos=;
        b=Bv2GulXzsgUMh2DXPWjbQ+vH8BOU+itPQm3ClGnfYpmJPsiQ/o5PsTb5Q3Kmr8NAdy
         2rrwVGI2DRf+hRtDIiNrGGBr8GPYuVNsmyDD/G0Ft3BHlgA/7+mT1mslT7J/oea3YSBD
         lRTj0ts4/6rhxpus8DvoGKGmfhPhituNQs+EPYH7X9xIYgvtx3CaX0t8EUGLh/hAUvPX
         5wwCkesJVxXIrPpFw1qpcRzlkOt67oUwAw/q7OLYvJSO4PdZfpISetW/ixcDK0MDWXkW
         mqv9BjdfZizuv6G2IaUnO5wkl660Sl7MtHpz8LH6MqFf0p0zhS/yZjdKtnImRR/SGMjE
         eAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754940878; x=1755545678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMmPbFgs3yxmq05QjFKFHmBagygbNuGevzmgwmt6fos=;
        b=JDQ7qXd54a59lnANdgVv8R1T5xdfaC0CcMcqnEKbQOMguLbzRebaIaekQ2fuglxd5K
         dYZmZi5B+S8qIeWbp6pn/hFX5+urIekqmjY6MF/7kurAt1+SkNz19mnNAgalD1mdmJ3N
         mNv0Zd5hWfw3XfBLHe0R7xnrxMRtY8o8wwtSNfmDnBoMuW5jSkQOe0npJ5/hVj3CYTIv
         kDG8sHrLFpiOoS5tgzLBkfvyHqkb/OE/9RhgqH4eld+o355LiJCIEz0QtPW9Cb507PfD
         wDe0yo65d+DbIg8tBFaxcgHQq65lBuhLU4HMCgFJH3QbFMhrgDLXKfFkT+ZcNu2HoTmu
         /VTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqD99SdH8xhtrW+FklllBFARIcAamtq5y52ZYfrdCc0xWadBJxecMJaDQ4yeB2z5QKEtNL1XyhpUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVpbpRFSOH/91YUuhlvqOshV3CzR65Y7tYO6g9liGAe7nYi3SU
	ZHU/dkeaSLzSJgAUOVQXJ0HZhGECCuuwG+DtvR6Q7jejABiFxzFB+2PRxvNZXcniDfsaa/7N4X+
	Z7vd8PU3RjbBiT5ANkHJfoDFyMUcVNkI=
X-Gm-Gg: ASbGnctz0N3pg8uC0EYVjj8hGnTlPGk1enTXbPZs93ovVzPR0yWGyGevbUaWiw++kv9
	1AUZPb3QxaUCDjn6TamPMdbTOIN9iXS6TAzL1nPdj9+g0bzA5EMqejSxPmCBMbyHX0j+3d9RsbL
	dTY8op23aiTWoChqTRygLOcf/m7Q2tN04tNLf/HFm2Cb8f8T+aOyaRJb1Gtv88fpfY4OQRvPkvK
	veb+F7nOg==
X-Google-Smtp-Source: AGHT+IG33RJznGZPWTodddBFW+B6jpXfzh9FBeFgDzhs7iROl3x1eqCkuwOiqr3aAX3vzhwiq9gnFa6oyKXaBz4dZ0s=
X-Received: by 2002:a17:906:6a08:b0:ae3:bb0a:1cd8 with SMTP id
 a640c23a62f3a-afa1e0214bdmr66684866b.19.1754940878195; Mon, 11 Aug 2025
 12:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811155453.31525-1-hansg@kernel.org> <20250811155453.31525-4-hansg@kernel.org>
In-Reply-To: <20250811155453.31525-4-hansg@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Aug 2025 21:34:01 +0200
X-Gm-Features: Ac12FXwXgtSeiu6BmcOjD_wNULriTtLyiOQoCfjtt27T9c1agVexzTx9v8s-ezc
Message-ID: <CAHp75VfohEyQkXZfKe4-NkGqrA9ACLNYVqbh8zEMw=XqZDvrHQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] iio: consumers: Add an iio_multiply_value() helper function
To: Hans de Goede <hansg@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Matteo Martelli <matteomartelli3@gmail.com>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:55=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> The channel-scale handling in iio_convert_raw_to_processed() in essence
> does the following:
>
> processed  =3D raw * caller-provided-scale * channel-scale
>
> Which can also be written as:
>
> multiplier =3D raw * caller-provided-scale
> iio-val    =3D channel-scale
> processed  =3D multiplier * iio-val
>
> Where iioval is a set of IIO_VAL_* type + val + val2 integers, being

Typo, should be iio-val.
In some cases you use iio-value. Can you make the same things to be
spelled in the same way?

> able to handle multiplication of iio-values like this is something
> which is useful to have in general and as previous bugfixes to

and, as

> iio_convert_raw_to_processed() have shown also tricky to implement.

shown. also

> Split the iio-value multiplication code from iio_convert_raw_to_processed=
()
> out into a new iio_multiply_value() helper. This serves multiple purposes=
:
>
> 1. Having this split out allows writing a kunit test for this.

KUnit

> 2. Having this split out allows re-use to get better precision
>    when scaling values in iio_read_channel_processed_scale().

...

> +int iio_multiply_value(int *result, s64 multiplier,
> +                      unsigned int type, int val, int val2)
> +{
> +       s64 denominator;
> +
> +       switch (type) {
> +       case IIO_VAL_INT:
> +               *result =3D multiplier * val;
> +               return IIO_VAL_INT;
> +       case IIO_VAL_INT_PLUS_MICRO:
> +       case IIO_VAL_INT_PLUS_NANO:
> +               switch (type) {
> +               case IIO_VAL_INT_PLUS_MICRO: denominator =3D MICRO; break=
;
> +               case IIO_VAL_INT_PLUS_NANO: denominator =3D NANO; break;
> +               }
> +               *result =3D multiplier * abs(val);
> +               *result +=3D div_s64(multiplier * abs(val2), denominator)=
;
> +               if (val < 0 || val2 < 0)
> +                       *result *=3D -1;
> +               return IIO_VAL_INT;
> +       case IIO_VAL_FRACTIONAL:
> +               *result =3D div_s64(multiplier * val, val2);
> +               return IIO_VAL_INT;
> +       case IIO_VAL_FRACTIONAL_LOG2:
> +               *result =3D (multiplier * val) >> val2;
> +               return IIO_VAL_INT;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +EXPORT_SYMBOL_GPL(iio_multiply_value);

Is it in the namespace? I think we already discussed with Jonathan
that IIO_CORE or something can be started if not yet for this kind of
exported symbols (and it doesn't matter if the rest are still using
global namespace, we can address that later on).

...

> +/**
> + * iio_multiply_value() - Multiply an iio value

IIO ?

> + * @result:    Destination pointer for the multiplication result
> + * @multiplier:        Multiplier.
> + * @type:      One of the IIO_VAL_* constants. This decides how the val

@val

> + *             and val2 parameters are interpreted.

@val2

> + * @val:       Value being multiplied.
> + * @val2:      Value being multiplied. val2 use depends on type.
> + *
> + * Multiply an iio value with a s64 multiplier storing the result as

IIO ?

> + * IIO_VAL_INT. This is typically used for scaling.
> + *
> + * Returns:
> + * IIO_VAL_INT on success or a negative error-number on failure.
> + */

--=20
With Best Regards,
Andy Shevchenko


Return-Path: <linux-iio+bounces-22681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD502B25046
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 18:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6344B1BC5878
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E822874ED;
	Wed, 13 Aug 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggYDlJjV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9610C1F582E;
	Wed, 13 Aug 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104070; cv=none; b=UZgiPyJIQ6BY/qmZtfsj4GFCDD8q9Fz3R5tmwDdPN3N0eGsenqXCeFwjQd2wS6iP71Lp7k54Mto2ABEHvETbcPoSINfEJuGbksxkOgCw0KcbKlxX4YPeN3Se/tU5lxXRlX830qFYf+K2hJW1hsfI1fcOb++bse4DTPBC8qmkNB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104070; c=relaxed/simple;
	bh=vQgrbIyhxn0faYGZQQaZ25U3Nm+uaCoDaB89CFoYQH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulGRXf2trmvvX8eodWgOU6Exb+N5OKsZEdeqU+n7oVXLLWRoYYISSsophFCWetSDunm2NtBSYDbyzEvFIjDUZKWFqaEhWVcm9sxlOt70Ox+hAVBBfJU0ViR66k9u/CNtqzs2RGB/q5e+E+rdtDOLGq+fYQsjODHjpl0XqDoe3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggYDlJjV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7ace3baso5838466b.3;
        Wed, 13 Aug 2025 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755104067; x=1755708867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fia+C4F/2ia0vnb0y/F4g4iaD6+fLDHe4xFz/p6aSjo=;
        b=ggYDlJjV2sjY67zDe2fZzrkz6zqQNOKi3vJ15rKksm9upLgUawAeHh8BofaVYfQahb
         mchMBrE205npCnXPw5v2OgmEy952YPlRy4YtzTQw0Xin5lV3Scw9xCY1E/6Zilie4/bQ
         pEDo7/mt8qLViN7EOE/g10BiJLaJBuZ4U+95rxH/bXSNPVa3tN3KRY7f/ovsq1zWWI4l
         eNTKyxQPMNoFDn9NB5gXpajlzTCLKG8u0HeAunBaukCSZ/jL9ClxFUQvPcy4cIqIuH0V
         skngiQ+I1O7nbOggOvHVmq3GcvZR+QwdNidaO3a5FQITqUmLhuJ/9thQiJHmjNl0teyD
         GWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755104067; x=1755708867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fia+C4F/2ia0vnb0y/F4g4iaD6+fLDHe4xFz/p6aSjo=;
        b=c5JkdaDnJzXamjOEBnXHH3UGwzkIAs6FHP4bUHsQlOjHZ6OFFX2rMAZTC2CtTxyLIv
         ZY4YhlLbtDhqInRDLqkFf74Fr7GN0NrQ7CTbqBZJNBAAHmbFaH/VXpcu+p2lTVGRTh82
         ND7urelWrN92fPtuI5mzBC1ayUBgw72iXB4v9V8scQwY0DNK6e5mQEndaR3RKTTT/9Hx
         Ti5crQUaZqR8zHBRNJ7PWsYD/YvV1VKw9kyoRgoxslaGawYcU2OyIaub/iC4FdMVlANX
         Cbg9/Ucr4Xxe2Cy1EEmxNSFnZTmw9XHN/EUmvEYnFOx4G/NrJ6DfbpCYZJNgt5v8UfaY
         jQrA==
X-Forwarded-Encrypted: i=1; AJvYcCVlnW+C6TCIMz16Ns+ZRXmrmWIIijfGVni7gZQ7qom3C1nAw0NtLzQ5+7HRABvrxRRxZG+BaxJSyd8=@vger.kernel.org, AJvYcCXuy2QVcxSoNdtYIgjgWuV02VLdnoBF0F41ANGDX61Y7yyt2Kw3/sHpD2qdLkEJmRwsJ8DnXUfDfXbK4Y7+@vger.kernel.org
X-Gm-Message-State: AOJu0YxDDnwbfY58HtppGiUptgY7ZOOiV4Xb1581rlILu4mvyfWqcOZJ
	1ltzhOV5pQS6KMlI8LPGT7EBSwFeLQxG7Fm+1C9DHjKMxNIgrc2Ss7cbEzoe7kaKwbayZdAeF2C
	H7uXTTe6v/e+H5T/ZwQwzaqVJcJwhfIlFZ9/sKck=
X-Gm-Gg: ASbGncurFWRspe/R6oEhJejAgLOQ8X0HyAnhKzDoLnmchKtO8MJK5Kfg1QkUoqNdtUP
	feVniXbbG8kTUNM7ECQlgojMYBDGE4vtC+wbBbICWXlfr1BHazmheYCdQZVfJWaOVbLZMKM0uRm
	oCkJB3Wdxy2PG3jXT/sF4Q68E/Oh5AYQbtrhjuOac2Ca0c9KG6IK3FgR9/wKLZX2/dk8JxCtFZx
	+I5LDe1Dw==
X-Google-Smtp-Source: AGHT+IGGHB7f9jYfS/efNI6IxhOGxiEwSgkVfaRSpN9fABBvCiN6/wyzNMS9n7z4AGdDkYfnQmaVtROclJfOh7ZObK4=
X-Received: by 2002:a17:907:3c94:b0:af9:8064:21e3 with SMTP id
 a640c23a62f3a-afca4e6c5d9mr339922466b.56.1755104066655; Wed, 13 Aug 2025
 09:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813151614.12098-1-bcollins@watter.com> <20250813151614.12098-6-bcollins@watter.com>
In-Reply-To: <20250813151614.12098-6-bcollins@watter.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 18:53:48 +0200
X-Gm-Features: Ac12FXyRjHkHIq-CuScRsFVbUQR_icnw_15XSooc7i2HDcZbDus8J2Gr20bVkE8
Message-ID: <CAHp75Venj0SEYKBwHcXD+sPgmX85P+Adw=T1wmGwERK0AzQ=Bw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
To: Ben Collins <bcollins@watter.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:17=E2=80=AFPM Ben Collins <bcollins@watter.com> w=
rote:
>
> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> to allow get/set of this value.
>

...

>         case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
>                 *val =3D mcp9600_tc_types[data->thermocouple_type];
>                 return IIO_VAL_CHAR;

Again, either here + blank line, or as already mentioned, remove a
stray one below.

> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +               *val =3D data->filter_level;
> +               return IIO_VAL_INT;
>
>         default:
>                 return -EINVAL;

...

>         cfg  =3D FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
>                           mcp9600_type_map[data->thermocouple_type]);
> +       cfg |=3D FIELD_PREP(MCP9600_FILTER_MASK, data->filter_level);

FIELD_MODIFY() ?

...

> +static int mcp9600_write_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            int val, int val2, long mask)
> +{
> +       struct mcp9600_data *data =3D iio_priv(indio_dev);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:

> +               if (val < 0 || val > 7)

in_range() ?
Where 8 will be an ARRAY_SIZE() ?

> +                       return -EINVAL;
> +
> +               data->filter_level =3D val;
> +               return mcp9600_config(data);

> +

So, make sure these blank lines in the switch-cases are all consistent
all over the code.

> +       default:
> +               return -EINVAL;
> +       }
> +}

...

> +       /* Default filter level of the chip is 0 (off) */
> +       data->filter_level =3D 0;

Why do we need an explicit assignment? If you want to have a comment
(which seems somehow valuable), find a better place for it without
likely unneeded assignment.

--=20
With Best Regards,
Andy Shevchenko


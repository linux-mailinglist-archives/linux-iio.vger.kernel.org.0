Return-Path: <linux-iio+bounces-15757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF56A3B66E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 10:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15761189F21E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534491E7C23;
	Wed, 19 Feb 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3NIrN3d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DBD1E503C
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955278; cv=none; b=UeZfxj6uM+1dAnVpb+6elSx5D/m9rCU60gPrv7B5JeXLV+gobQ7rOdjhs/QyVfk3KAlvc5iYjFmBZ/PguUEyNbM58Qq9/lsQCywZvj8lPq9Z+yQIphmHiH501PnS3q09MAMD4CpHpB1ISVQbfOvPx8m177zEwP18ZIGjscXxiOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955278; c=relaxed/simple;
	bh=KrhAtcBwzsPqOpd9+yItf00BBTvOUArImXUQiJweLQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cc896vyTz5C6BCD1wUVydNlA37gpudTUJBjSGvE13U5BzKQfrDwwirNL7gjuh36M7HcxzMaECPXXf9c55T02Ryt5w+wNewgl2ZxnDRlcc8xIVLq8yiJFJFuC0mmjyXYZYjFqZ8l/XXCLmX643z1K+Qg592bwXeSg8zJEiA28x8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3NIrN3d; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abbdc4a0b5aso48422966b.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 00:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739955271; x=1740560071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vdNnaALe1ePC/1Kja1Y2+B/Td8y/hXWCVJtQPqB9KE=;
        b=I3NIrN3d6u2LTl3OdTO/BuysjZH3uHDaIFBXeP9yIc14P3XJZsyb7Da0kNUka/B6m7
         4nZ664A34MjFT7sAC65kjh/1NrjvbwFB25zHQHVXTlvu7/7LFKH51Xr16ZRoHXve3mMu
         Z9vuVpaQfEC3e0/1e0ORS2QjZZOO3VoFRqdZLY/shYygUPdA2kpuaHmzV1+32wQfTrTg
         v0KxgIWNcDbjzSBu1nuSv73Wq24oTaYyV8pJtVN/MRluaafLcXevGdhjhkq6W4iLIHja
         adbkiQUEZL+mTwcpWiwz4UsfzsWfzp6YmX7hiHvfD9lOikV2YS0eWcm3pVxaZWf1N/Fb
         6pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739955271; x=1740560071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vdNnaALe1ePC/1Kja1Y2+B/Td8y/hXWCVJtQPqB9KE=;
        b=eoC86igPY6YtM+8Qo975uCYeQEkJHHOIjbd10K11ozd3dP2n0L91LKIb/y/uNSeeis
         UTRoTrEYIiXVe/auJ/a6Jlgb32QO4p3guVqHpbuKTVgwyL6JMil48GW8vNWeKR7O+cie
         8PB0ujBl6xhXJ5gsbPf9yM7cf8dBkmYA9QDNe0IE16frfEdt5LD5VHVny7nYgp5rkkte
         fKrv8qc4qiB2HckT3t9+j3zPmdm/mSmege+zFI3tCe7gpv9oLkd9eitpsytELN2SSB02
         zUMlnrfepHy3hltwluDoxfYknbgjKDoR9ENTFIoGFzbObU1jfhc+HyxRyN3T3GCJClWK
         YfLw==
X-Forwarded-Encrypted: i=1; AJvYcCU/pb8vxq3Xg6Ry6E++myG6rGF1qqGNBZtiAaAhEomd2L8Pj/iJ6mdYW7b8hXdnyJAu8Vir/OvbwpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOJh8Sceh3Y+gPkhr8K0BMc+x5IbJ2k4i/F289Bh7+kFE1APP3
	Yg2i7T1flKYc6KsuIiTa5nNebv8jne6DbTENr8we2HjLH053aABw/rxUzCLBWI64tsvsbMvlgNu
	4Oao/Ta1Ow81dZI42iotsSI7vFUY=
X-Gm-Gg: ASbGnctDmxjheJatltD3IlrTY6YJ9mZfsKhjVY/29+MTZ24y55dkG/IK8iLCGauiV/A
	6AtBVeKolq2e6cYnltNVoWhcceIzSj3XSejbn5ryiyVhPFzTm2cBIWOTV8+Ij/fcmexWSGslL
X-Google-Smtp-Source: AGHT+IFHFeZjpbRwL4D/4GqoSvblBpAC3trODXkUXvIIDHs6t1g0o0/5kx9/oaJVd/VVtz8EjnUQc8+z3J3+co3u6Vk=
X-Received: by 2002:a17:906:9c86:b0:abb:bb82:385b with SMTP id
 a640c23a62f3a-abbcc63a5b9mr237830066b.13.1739955270541; Wed, 19 Feb 2025
 00:54:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739902968.git.u.kleine-koenig@baylibre.com> <4d1ba8c9a890393fce38083b01db6ce03df8ac5b.1739902968.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <4d1ba8c9a890393fce38083b01db6ce03df8ac5b.1739902968.git.u.kleine-koenig@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 19 Feb 2025 10:53:54 +0200
X-Gm-Features: AWEUYZkXtuva0ff7xdPh9FbRs5IB3k8UcMtz33V36axf-5kyc2pgqw1X0YQtY3U
Message-ID: <CAHp75VfmYVBpmq1_bChNrZ+pgcHN_eBOYTcnhcxqWvhKxx0G1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] iio: adc: ad4130: Fix comparison of channel setups
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Cosmin Tanislav <cosmin.tanislav@analog.com>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 8:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Checking the binary representation of two structs (of the same type)
> for equality doesn't have the same semantic as comparing all members for
> equality. The former might find a difference where the latter doesn't in
> the presence of padding or when ambiguous types like float or bool are
> involved. (Floats typically have different representations for single
> values, like -0.0 vs +0.0, or 0.5 * 2=C2=B2 vs 0.25 * 2=C2=B3. The type b=
ool has
> at least 8 bits and the raw values 1 and 2 (probably) both evaluate to
> true, but memcmp finds a difference.)
>
> When searching for a channel that already has the configuration we need,
> the comparison by member is the one that is needed.
>
> Convert the comparison accordingly to compare the members one after
> another. Also add a BUILD_BUG guard to (somewhat) ensure that when
> struct ad4130_setup_info is expanded, the comparison is adapted, too.

...

> +/*
> + * If you make adaptions in this struct, you most likely also have to ad=
apt

adaptations?


> + * ad4130_setup_info_eq(), too.
> + */

...

> +static bool ad4130_setup_info_eq(struct ad4130_setup_info *a,
> +                                struct ad4130_setup_info *b)
> +{
> +       /*
> +        * This is just to make sure that the comparison is adapted after
> +        * struct ad4130_setup_info was changed.
> +        */
> +       static_assert(sizeof(*a) =3D=3D
> +                     sizeof(struct {
> +                                    unsigned int iout0_val;
> +                                    unsigned int iout1_val;
> +                                    unsigned int burnout;
> +                                    unsigned int pga;
> +                                    unsigned int fs;
> +                                    u32 ref_sel;
> +                                    enum ad4130_filter_mode filter_mode;
> +                                    bool ref_bufp;
> +                                    bool ref_bufm;
> +                            }));

This can be moved out of the function, but in any case it should not
affect code generation I believe.

> +       if (a->iout0_val !=3D b->iout0_val ||
> +           a->iout1_val !=3D b->iout1_val ||
> +           a->burnout !=3D b->burnout ||
> +           a->pga !=3D b->pga ||
> +           a->fs !=3D b->fs ||
> +           a->ref_sel !=3D b->ref_sel ||
> +           a->filter_mode !=3D b->filter_mode ||
> +           a->ref_bufp !=3D b->ref_bufp ||
> +           a->ref_bufm !=3D b->ref_bufm)
> +               return false;
> +
> +       return true;
> +}

...

>                 struct ad4130_slot_info *slot_info =3D &st->slots_info[i]=
;
>
>                 /* Immediately accept a matching setup info. */
> -               if (!memcmp(target_setup_info, &slot_info->setup,
> -                           sizeof(*target_setup_info))) {
> +               if (ad4130_setup_info_eq(target_setup_info, &slot_info->s=
etup)) {

I don't remember if we discussed the idea of using crc32 to compare
the data structures, like it's done for PLD data in USB Type-C cases.
https://elixir.bootlin.com/linux/v6.14-rc3/C/ident/pld_crc

>                         *slot =3D i;
>                         return 0;
>                 }


--=20
With Best Regards,
Andy Shevchenko


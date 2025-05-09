Return-Path: <linux-iio+bounces-19355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09AFAB0E3B
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 11:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62CC07AB55F
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 09:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6255A207A08;
	Fri,  9 May 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoEVEnfR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDEB14F98;
	Fri,  9 May 2025 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781615; cv=none; b=o1EWANTJymePq3OsAQaNgRQEVLDcTdgKIMWsIvEumriAN2ZDtYavDhwPShgyZ4KpwgDs32LoEGVtoHuww8hEUkgkmyrKoNs+/IvSEr7+IlbgvAd8yV80uKWKfXTDQPH3jOR39rHJd4xAKXSemkB+ow4QlqRZtGJW33tS/4ugyq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781615; c=relaxed/simple;
	bh=sAFkRHh9bzGYnsvmn6RJcgV4uo5APsdL0DD3ImIhGSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUuCtrebEko8lTgRtxj+SJQgfdfg5TXpRpswOLvideecHv1oksYowuvGjLg1eljXKBoktKezhGMXrXGFsBwGDdqv/86b7szjvxEsjD40JScN1yHRLS1D9NuVu33324dknyhh6xJ3ce9UcZhBCpJhoYl7qlg1oeSVMBvf6xCVAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoEVEnfR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ace3b03c043so300645266b.2;
        Fri, 09 May 2025 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746781612; x=1747386412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ww1C5cskFkFK3cmuMB2ZAcdmwSeUk/Y0atV0njjxmYo=;
        b=IoEVEnfRrOjx3hvG/XAzT9ujZIzlFlXmFtQTbWCmDzZsGZ4EZsh6kR987yJJWURnKW
         kWGKSiaVbs9GaVPcDI5YzNZLTJjvZfv9kLwy1y7RoaoRJDU7IThvd5PNRi4WjiitMKwp
         86ThWhQ3UM/efwHwB2B+JuaZLYcsM0YRqrhRanENsVU5RUzgyEv33bZgaVdMyLsRWBdU
         /7KUofUa4HIptl94yxzHA3WunSRma0vx/W2I85lEGhwzMNQHp3pEspxJsjIzRxy52PHE
         Ocaan9XSi8droq8Eq9VC2jo/kfzi9nQNRlA5J3N6puVxDLGGtOHrUOi2iRj1uJjW0fGI
         3C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746781612; x=1747386412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ww1C5cskFkFK3cmuMB2ZAcdmwSeUk/Y0atV0njjxmYo=;
        b=gDsPTezMLKA5oHhgwZUV0nW15ukbBI8xYZ6yTwyCzZbZT6f0q65opL5Ze6Nq9v72z4
         gA4ZxdZgBSglAHgaPJGxYFyJNh+DYiBz0PLtFFlCSD+r9LWIaSGKTuCLI7yz6zKJ8g6R
         vFlOtsga2dqdSgeQStSZI0VlXc5Gu7k/MimJCEKMbc7d58ASILSH4AYnIALKptz/KpZX
         WcpNJlHe3EnBn2KS7ahR1P/FZv1AgI9vV200MBsVqthm+tXEun2F2YJ8d3sEklw0tWFl
         RosDQVhd7JnZWHFi8d+D6TWqtkLjHefR6Vj2fBJKe/goo6VylouxAAoAzkOZqloEZUpR
         suqA==
X-Forwarded-Encrypted: i=1; AJvYcCUZR26DfErl4cdLqMGi/Thfbw0yW6BQIF/xjDVehy/5Ts7WKmcflPTBsRqV6R+xDblCmFJlsZ89JFU9ze3z@vger.kernel.org, AJvYcCWvIsr0jtmeW8w/00NV+nBDHcLo35pWI5hxJAZ9qCJoiugJwTuyY7SPzFfBWpzkWOS+KJ8ketEozJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKEENpsFfYFeDEqsp+9yWshRcJNz9rCEaaj7lPQ87aXtdul3rW
	t1/ypiH0yElo1eiNhSk1XyXdEkNaccKw3/H+GlnTZlFE/fRKCu4fVBQImGcOtSIJrM1BhPMJnsN
	91G5R/P1EgrWvdr9T+oVIlm3BTK4=
X-Gm-Gg: ASbGncsTY9x6yvNpdFi9k41j7tBbSDFiZvcG3KNG/GtzMR9AQiTL+BN6zXg0tZv4kAY
	xyf+w6b38BwvhZhC9Goce4DsiCiaiWybuTgz+DOomI1ybG7cpeN504iqOgRuC4QAg+a5dToc4bT
	iMG2BEa3qpxAtKz35dz7XxKa8y
X-Google-Smtp-Source: AGHT+IHIy0jD4deps83mC+BJmknL3Cgj5RJsKo2gQsuaVts0eTtH76HrlAlx5F1MimQi1yke5qB3yYDyvNVQ5fq28rQ=
X-Received: by 2002:a17:907:940c:b0:ad2:2417:12db with SMTP id
 a640c23a62f3a-ad2241716dfmr90159966b.40.1746781611479; Fri, 09 May 2025
 02:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509013931.47524-1-andrew.lopes@alumni.usp.br>
In-Reply-To: <20250509013931.47524-1-andrew.lopes@alumni.usp.br>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 May 2025 12:06:15 +0300
X-Gm-Features: AX0GCFuAk1M85duu0X3oWCXjgf2w9d_WEv2IGSuBGytINUPqhfHKLGeCIGOw80w
Message-ID: <CAHp75Ve7-hMUxrmXQnkMjynhPUbD6R+K=-j+h0zELvcxZdy5nw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: accel: sca3000: replace usages of internal read
 data helpers by spi helpers
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: jic23@kernel.org, andrew.lopes@alumni.usp.br, gustavobastos@usp.br, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 4:39=E2=80=AFAM Andrew Ijano <andrew.ijano@gmail.com=
> wrote:
>
> Remove usages of sca3000_read_data() and sca3000_read_data_short()
> functions, replacing it by spi_w8r8() and spi_w8r16() helpers. Just
> one case that reads large buffers is left using an internal helper.
>
> This is an old driver that was not making full use of the newer
> infrastructure.

Suggested-by: ? (IIRC Jonathan suggested this, but ignore if I am mistaken)

...

>         ret =3D sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, ctrl_reg=
);
>         if (ret)
>                 goto error_ret;
> -       ret =3D sca3000_read_data_short(st, SCA3000_REG_CTRL_DATA_ADDR, 1=
);
> +
> +       ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_CTRL_DATA_A=
DDR));
>         if (ret)
>                 goto error_ret;
> -       return st->rx[0];

> +       return ret;
>  error_ret:
>         return ret;

Doesn't feel like a good cleanup. Please, drop this error handling
completely, just return instead of goto above.

...

> -                       *val =3D sign_extend32(be16_to_cpup((__be16 *)st-=
>rx) >>
> +                       *val =3D sign_extend32(be16_to_cpu((__be16) ret) =
>>

This doesn't look good, can you define a proper __be16 variable on
stack and use it instead of ret?

>                                              chan->scan_type.shift,

With the above done, move this parameter to the previous line.

>                                              chan->scan_type.realbits - 1=
);
>                 } else {

...

> -                       *val =3D (be16_to_cpup((__be16 *)st->rx) >>
> +                       *val =3D (be16_to_cpu((__be16) ret) >>
>                                 chan->scan_type.shift) &
>                                 GENMASK(chan->scan_type.realbits - 1, 0);

Ditto.

...

>         /* if off and should be on */
> -       if (state && !(st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT))
> +       if (state && !(ret & SCA3000_REG_MODE_FREE_FALL_DETECT))
>                 return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> -                                        st->rx[0] | SCA3000_REG_MODE_FRE=
E_FALL_DETECT);
> +                                        ret | SCA3000_REG_MODE_FREE_FALL=
_DETECT);
>         /* if on and should be off */
> -       else if (!state && (st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT=
))
> +       else if (!state && (ret & SCA3000_REG_MODE_FREE_FALL_DETECT))

Remove redundant 'else'

>                 return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> -                                        st->rx[0] & ~SCA3000_REG_MODE_FR=
EE_FALL_DETECT);
> +                                        ret & ~SCA3000_REG_MODE_FREE_FAL=
L_DETECT);
>         else

Ditto.

>                 return 0;

...

>         ret =3D sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> -                               (st->rx[0] & SCA3000_MODE_PROT_MASK));
> +                               (ret & SCA3000_MODE_PROT_MASK));

Remove unneeded parentheses.

...

> -       ret =3D sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1)=
;
> +       ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_AD=
DR));

> +

Stray blank line.

>         if (ret)
>                 goto error_ret;

Perhaps you wanted it to be here?

>         ret =3D sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,

> -                               (st->rx[0] &
> +                               (ret &
>                                  ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTE=
R |
>                                    SCA3000_REG_INT_MASK_RING_HALF |
>                                    SCA3000_REG_INT_MASK_ALL_INTS)));

Remove unneeded parentheses (outer for the last parameter).

--=20
With Best Regards,
Andy Shevchenko


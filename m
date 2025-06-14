Return-Path: <linux-iio+bounces-20672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E61BAD9FF5
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 23:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B1D3B65FA
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 21:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2C51F8AC8;
	Sat, 14 Jun 2025 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BunBAmaY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67DF8F6E;
	Sat, 14 Jun 2025 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749937840; cv=none; b=ls7vkYMbfSMTw8a3Fd9EiZTxXIgsYRR0Z4Se63aw+num7616U6T1JdcoIIAyI8oef++znuoo2PL4DsPhWGgkN1A5HZjubxiH8rClom6I5jWiVr6PPYvI7arXlvAgUAT00k63B7p5Y/KiEA65OTkXV6sskJF94V6x0WppN5QGalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749937840; c=relaxed/simple;
	bh=28TxhUesNYNhTIWhDyjUnhlMg6DCd7L8h8mUQz9dKtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9c09/RNJ5CFvWhnJBqnkzfvtpRTzqKXzHdQu0DpeeZ+eTbgCdSAcDEtUMW3C5uaD9KEptXskn8hl120gVr9qok+jRtW2c16diqp/VTF7biwmpBVilxYjUjHul9tKUdg1fgGCTg+4Fsfzr/4SE3Ox0UGKAks+siSm2ETSDrmIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BunBAmaY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso6308429a12.2;
        Sat, 14 Jun 2025 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749937837; x=1750542637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ2JDYGtyZy01pSmrKkInxHeCy/t8KVeDwZZegFmHjE=;
        b=BunBAmaYNaqTToWxQhTk71LTLEMTUY7Wk8yPzwN9NEp6wo/8tHhXNQJvw73slnkwJ5
         v6XEdH9Tbc8w/Wfh/wgcn/bseni+MjBfhpR+1HvxUGuzni85R/Ig1Kjg67JAlmR6br85
         ApjiB+QorwuCMddFjepLsUdzX+BaxG7/8KbugAqmdOPbR6CfR3Cc2HhVwjkldROkflDs
         JxarU3S1nhNV8ZqNt9kz0CJgkX635ikmAaaNTf5/jEKIEQeJI/OYAYDHqUp9Lctrhj0f
         ui6drLD3HkEaIT6YqPga0VIa09Pt912qaNjvV8MRuUBKF3VJzqC2KajpqfNgtMe6+a+i
         cOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749937837; x=1750542637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ2JDYGtyZy01pSmrKkInxHeCy/t8KVeDwZZegFmHjE=;
        b=CnrkMU3NRT1StLfWfk+0Li4isDsid2nU+hhRpra8eKaVxvdc2mOvkdsknl9EEoSAQE
         46Rkun5lIm+hjzLmLQcfmuANmevghkbNY0wx8SZ6PZCUL4YuV7Vazrk5qV/vQoJIK3VJ
         FKiFFpAt1eQon8+pAvwy6g7xkh07O0eSQ8lACrZnH8oY0j4GLIif+TlqELw+b9Z5cx+D
         kzq/YHP5nWulQeG/+Hv1N1Xq6jN2bk5HyTkRH5AQKnTZjBAsv214Tp6a12AFH7/17Y3D
         qtkCRrG/QRVHNLAbWw72VRVHxk9emGntqogYoMEMpXsBfJWM5gt1qMYeWp9wA4+mKnUr
         IHfw==
X-Forwarded-Encrypted: i=1; AJvYcCXG6CiM8QNE2Z/J6/zl6W8VksnE01WUhbPo41DjivLWa2wql6IEygL7sdfX6nKsuDxyMF7h+Tcem9Q=@vger.kernel.org, AJvYcCXX1LCUhS4mWc3crtum8OMamJ+KxHcXhSlmwq2vZhdrrp/+A+dkAFxMtPI3bm0+om5frUWnMyX9XfbA8eB5@vger.kernel.org
X-Gm-Message-State: AOJu0YyowfWUEGyW+1cgj/4ext7TvT/n8QRJI72XDARN2dq52QrwWegE
	TRWp7cfo59eU3lUniCa1LyXHg+NbU4kYEx/ZcKxZKHrDHcC38HuA2Dx6VXjCa9cL+MwJGbhkZXi
	57kad433AObs6Eba8caKveQ/QSa6jSXY=
X-Gm-Gg: ASbGncuTtX1GnPY8kY9cZoDYMfgy7C4uciGgLUgVQA6PQksIVSr8R3NnpbCHH4MCWQK
	Eu3RAalvwm+xoxB+AgQ2v/KcwrhxD4ZRACRsOf5IZ4EkP44XLQYBwbZlxLFeN0ciDFrGegCOIgO
	tPHkqwZs4bTmqdLpfTnBH/D1Qh50AOyL8Vh+eEnIJf0Co=
X-Google-Smtp-Source: AGHT+IGDIxRrYycGoBMoj/HmdvU0qBmuNl9VTOVZg1KhEIPLtSNofZlui2gdTmhgM6H2mhXv1u/mobLmtpetSddRNoY=
X-Received: by 2002:a17:907:2d2c:b0:ad9:db54:ba47 with SMTP id
 a640c23a62f3a-adfad60904bmr406713966b.43.1749937836749; Sat, 14 Jun 2025
 14:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
 <20250611194648.18133-3-andrew.lopes@alumni.usp.br> <aErUqzdFL9nG6Bxc@smile.fi.intel.com>
 <CANZih_RTtcHHP80rtJ5gGkmkL1ohoctUBaGm-2Z2=Xo9VvT-Aw@mail.gmail.com>
In-Reply-To: <CANZih_RTtcHHP80rtJ5gGkmkL1ohoctUBaGm-2Z2=Xo9VvT-Aw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 15 Jun 2025 00:50:00 +0300
X-Gm-Features: AX0GCFtW7Hyd7Y0XkMtvjgDVITxggRAS2oHIy410dLomCNXlgB5TpjqKqBOLm_o
Message-ID: <CAHp75VfXw++C859kq58QOEcC5c4z1YdF0yBH1v4vJYujUPT75A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: accel: sca3000: replace usages of internal
 read data helpers by spi helpers
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jic23@kernel.org, 
	andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 12:06=E2=80=AFAM Andrew Ijano <andrew.ijano@gmail.c=
om> wrote:
> On Thu, Jun 12, 2025 at 10:22=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:

...

> > Moreover, the function  should be switched to sysfs_emit_at() if this i=
s part
> > of ABI.
>
> Great! I didn't know that.
>
> In this case, sca3000_read_av_freq() is described as a "sysfs function
> to get available frequencies", so I guess it's the case, right?
> Is your suggestion to replace cases of sprintf() by sysfs_emit_at()
> then? If so, I could do that in a following patch, it seems that
> sca3000_show_available_3db_freqs() is also using sprintf().

Yes. This is written in the Documentation.

...

> > >               }, {
> > >                       .len =3D len,
> > > -                     .rx_buf =3D rx,
> > > +                     .rx_buf =3D st->rx,
> > >               }
> > >       };
> >
> > > -
> >
> > Stray change. Doesn't checkpatch complain on this?
>
> I don't recall getting any warning from checkpatch but I can check
> again for this next version.

The problem here is the absence of a blank line between the definition
block (where variables are declared/defined) and the first line of the
actual code.

--=20
With Best Regards,
Andy Shevchenko


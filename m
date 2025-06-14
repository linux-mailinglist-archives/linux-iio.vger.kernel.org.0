Return-Path: <linux-iio+bounces-20668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF11CAD9FD3
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 23:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2560B3A0736
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686A11F8BD6;
	Sat, 14 Jun 2025 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJXci07y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A188B1A5BAE;
	Sat, 14 Jun 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749935201; cv=none; b=ShCfd81CY9fMp/qplg5dXIGd1xEf+BeXrUnIL5RzdG3YUR3b4jEP2L55NhBl0tluvEbZohR+gkK8TZQhhzARla2EB9KVYfixq6v58FqMG8bXZeAN6/glPx8zFo6AjtBVjZqEIz5Bi0HNf+HnRKy+R0bIYqlsPnKrR5XkZInJorI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749935201; c=relaxed/simple;
	bh=mU75yMS3MKwvmVpAKwvOGQvnvuRjwHubW99GY625xtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLqQ5T6l5eIq985CyasKLZsl+cU7ONpJFYTwVUpxTjuVHziVqVvrmhXTAtpodI/Or2PRKWAlNa48M+u8adQZBR69iXB3im9tSlxrJSauQfXeOzk9nW+nZBMS8o3S71zJSP9hyseWOK2AeEpEVd2CzO0CnWsTR6lyVotkR0BhcA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJXci07y; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87f0efa51c0so384283241.1;
        Sat, 14 Jun 2025 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749935197; x=1750539997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etjm9yyX1fF60Zs0zODeHRktUxlJWK0YFF+vCfFs5e8=;
        b=NJXci07yNOPcrjqerwTx+aVnNSQygMv9mpwGVspucMVX81KikApGd08+3PF62pdItw
         iTyIhQDx6rWvhfcFp+Q1rv9XXmYX3y61XWFmcOhabrSxMxEgOE3IodFXRrV3dqeTt/Nv
         8md0huLkPWowd4XW8PFoqkH+e22fgMLbBnR9kZPT0ELA/puCR4b/UgIkHnRgn6N7tr/Y
         trYU2GHkI6zvj25/KEGJTUb1SlqjNyu8o29zS8p2daKkWMd1IvU1dvFu3WUVe8fNzLzV
         W7o6pYnaMLWMZXSKB0yZn6ENrofU0myZa1WXsGKXggAhFRJ8pjzokgr47RXriUhqzEhl
         6zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749935197; x=1750539997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etjm9yyX1fF60Zs0zODeHRktUxlJWK0YFF+vCfFs5e8=;
        b=EgYCDPevODIewHTvfNNy9g0bNA3t1sReXi8WYL8YTJzasB5DVffa8jrwoVDWZhvlKo
         LDCeFct4avorp8C/P1vLOZ+oRx5CC2OG+ObAfT6xJ3iPv8m9C0H86AB653TjQ0sLZLT7
         ELo9af1MIeMXhge9wUExcMUMWwRpBYSXMV03Afj7ECBWfJspbPWP4aVM48PW4Ud7QH8v
         M1YP2VVtNapW+yhiJkz8PFi/hKSmZ/JRybKfMgcnl9N+7LsNncPflmHqZ818yaaK4/xz
         eUvfGtGHgEuD+bUHyMEkavlgT7KMSpNVZzUn06O82JgXmhyZyqEUK+xN/0Lby/n7uL3z
         EKfg==
X-Forwarded-Encrypted: i=1; AJvYcCV8XAeySZOlz1f4xUCPMoTMh5/WntzLEGbk+Vfno9QKMNG/79PROmOtGTeC4C6D1F0avRkQom6KLnM=@vger.kernel.org, AJvYcCVWc747lGPhyxJoGLvHw9lKqn53hh7hatlad4el+vv/cJa7mTzOrSQgak15LakaSw/tKYXZQgXRtkQbxYuY@vger.kernel.org
X-Gm-Message-State: AOJu0YySGmBycmyIgkVZ26flEj0FWIZS5YA9RS942+L6SB3iIpEWzEpq
	KDgOR9Mm8OC3tAojhnmVJS08HeCcFIHA0ev9dxEoJDqKRjamV1nmKZIENftVtwhAq3SkQV+BLTy
	jgS63M4rEoZx7zZm/9VcgdyZOh2M8cGE=
X-Gm-Gg: ASbGncsfoA8/sjGuHI6z686G1B6G6Y6ap6Rs/nLsQxYsgbFL0r1/npVQRFzTwlF8k5i
	gseEfekoQwlxKHbdBDfrnB0T89Z9JH9wHQnbun0swwPoXH+QQuHYW4aDkqvod8LBmOvRBzkNOGY
	xrOIPJF54tXI9RwZHDER1QdEMTZBz+Wc+WzKd/aAbFbtDWGgmzwg1CRAwAK0JkAop6E0JD
X-Google-Smtp-Source: AGHT+IFEn0NmZQrrcd4mSespYY01Ia7Uokw/chLiA+7yFBbBM9iZcx3HLNKhz2beEOEJiWz51rhZn4fUeLWgdlQiNmg=
X-Received: by 2002:a05:6102:c8f:b0:4df:84d5:543e with SMTP id
 ada2fe7eead31-4e7f61629cdmr3200156137.7.1749935197339; Sat, 14 Jun 2025
 14:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
 <20250611194648.18133-3-andrew.lopes@alumni.usp.br> <aErUqzdFL9nG6Bxc@smile.fi.intel.com>
In-Reply-To: <aErUqzdFL9nG6Bxc@smile.fi.intel.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sat, 14 Jun 2025 18:06:26 -0300
X-Gm-Features: AX0GCFt1rNic8PBTIBQ1w-unioGMhl3EVrgfF43dp29afz5eHFVDkpFq1n7youY
Message-ID: <CANZih_RTtcHHP80rtJ5gGkmkL1ohoctUBaGm-2Z2=Xo9VvT-Aw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: accel: sca3000: replace usages of internal
 read data helpers by spi helpers
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andrew.lopes@alumni.usp.br, gustavobastos@usp.br, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 10:22=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> ...
>
> > +     ret |=3D (mode & SCA3000_REG_MODE_MODE_MASK);
>
> Unneeded parentheses.
>
...
>
> > +                     ret =3D spi_w8r16be(st->us,
> > +                                             SCA3000_READ_REG(SCA3000_=
REG_TEMP_MSB_ADDR));
>
> Make it simply one line. The above formatting is ugly.

That's right! I'll fix them.

>
> >       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> >       struct sca3000_state *st =3D iio_priv(indio_dev);
> > -     int len =3D 0, ret, val;
> > +     int len =3D 0, ret;
>
> Ideally it's better to split them and len should never be signed.

Nice! I can make this change.

> Moreover, the function  should be switched to sysfs_emit_at() if this is =
part
> of ABI.

Great! I didn't know that.

In this case, sca3000_read_av_freq() is described as a "sysfs function
to get available frequencies", so I guess it's the case, right?
Is your suggestion to replace cases of sprintf() by sysfs_emit_at()
then? If so, I could do that in a following patch, it seems that
sca3000_show_available_3db_freqs() is also using sprintf().

>
> >       mutex_lock(&st->lock);
> > -     ret =3D sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
> > -     val =3D st->rx[0];
> > +     ret =3D spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR))=
;
> >       mutex_unlock(&st->lock);
> >       if (ret)
> >               return ret;
>
> ...
>
> >               }, {
> >                       .len =3D len,
> > -                     .rx_buf =3D rx,
> > +                     .rx_buf =3D st->rx,
> >               }
> >       };
>
> > -
>
> Stray change. Doesn't checkpatch complain on this?

I don't recall getting any warning from checkpatch but I can check
again for this next version.

> > -                     (st->rx[0] | SCA3000_REG_MODE_RING_BUF_ENABLE));
> > +                     (ret | SCA3000_REG_MODE_RING_BUF_ENABLE));
>
> > -                     (st->rx[0] & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
> > +                     (ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
>
> In the original code and still now too many parentheses.

Ok! I'll remove them.

Thanks,
Andrew


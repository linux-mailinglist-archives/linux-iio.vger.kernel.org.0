Return-Path: <linux-iio+bounces-15112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D885A2C280
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 13:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE0B3A988F
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 12:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403ED1F1534;
	Fri,  7 Feb 2025 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh1+POEC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C41E0DEA;
	Fri,  7 Feb 2025 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930709; cv=none; b=oqMlNz9gCYFE4csB4Qo6NDjUR7JZIOTOicxZR7wsYVwJE7wVsWFb15aWpBoDQtEoBVTcpG9FbA/7koOUQx6Ytm+TH+81tMsVKxt2FJzw0W7SeXbImGfoaK9Mh+Dk7gal7AuYBgSsNqUqTTv2uyfbG+whFX5l3cIGzfyUVrMeNGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930709; c=relaxed/simple;
	bh=gq6zzef9mN8VOP/B8pyInYMmzd2Gmkc2yEJH/o9LvxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXWTgTpsB4TMFXzAyyH5u25wtizZ2pwMU1mszK7WBRAexi2MrJiqvT6geQQCpVV1+TGN4EmlfkImJgTnlLxxw6kd/IJPABN16R2I4KvDQSmno59XqPyZtQIy67gX9whusqqL/phi0bNQbPCxK13NjQ6CqcqMoVim1ruzP3v9o3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh1+POEC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7157cf352so602818766b.0;
        Fri, 07 Feb 2025 04:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930706; x=1739535506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AnS6zB1IqaiTJ947vhQew0524hQrc2UQ2tC8yNLWiQ=;
        b=Vh1+POECCSJFUpcHO5CVu7ONdQH24wUHOq5Gg6+oHKBQifbTxcMKQ4dFQYh4oZQ1xV
         zl86Fbwk4W3l4ekGBh5l3oBjtsAlf/wlg96GypRke/3OQvbVrrkrCDxuDQQk/ZNTLt4r
         fZ3pSNuOfw5K8MK754dalxmlXV1umz7eyxXHYyooCupnt8uNs6Rby2acfvws5ABUgvn6
         bw64a4Eon29b/olyBl+AkFz7if1f79D43haxQCd2Hu6qOyg9Li6a/w+c6BY+An28r5oK
         IBJuUsEXGCvHYPbQfRDIHybGYo9C+M3iN17gsixYnrJ1kyiMjj8wu2n7bq3SzTHU/gir
         Sb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930706; x=1739535506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AnS6zB1IqaiTJ947vhQew0524hQrc2UQ2tC8yNLWiQ=;
        b=vo+XKRxIyZmZmXWi+v+18C2DMqKYZhh9JrIB5BV0g/280l4dvVhw3mWwD/dpv6lIUF
         6vhQI1vLM7hKdRqi04W4en15gb2PD/v4bPd/D+VIjcg3E+U1uM4WaxjmC+CGNOGvs/qz
         bt+gL+6MFrapsySilxOkVgUceHxPpOKe6zk/S7FcSlh+M18sjzQUDy6xBy+Y6py2ktNN
         PgCXG4XYY4/DFKoFdYA9oTeun3u0DLurTNSNUw7GugeZ/Q6VUVpEBF1DQJKBFW2MGZ9h
         sI+FtOzPbYpv3D3YGXFHLMMR7j2vdjCb73RJn/Q8997R1fnHTkj/wG2HgJBUjEfR/Pu4
         HJXA==
X-Forwarded-Encrypted: i=1; AJvYcCVbDnazlTZwKvLePK0R5xaK2oy2eeLYZeoqf6wJ1EtG3rSYkr/xvpAb+sfLxsgQCGTF4lnb9GDVfaNyWvSg@vger.kernel.org, AJvYcCVs9MMUgPq5EWF6nOQkjqVXNS8l1cfLyukBAbj5jdgY/y8gX7VCznpzKJ5BwnKSCLQ73e9VAA0Y@vger.kernel.org, AJvYcCW/KtSt298qM3AndR3RRgq+Iypww5WH0sHugUPVkUAxioQaRKNCQ807u1gkwxMgpFcGm76jVlYQqkBJ@vger.kernel.org, AJvYcCWH3dzJz2IXwwEOt5JGf6OChfJFkWi/A4QzPhx4A7beDalL22ybBcjHKScrnI4OnoQdJKG2Y5IhUE2p@vger.kernel.org, AJvYcCXBslRLkZ2BzVNXcbJEXn8wX+V5wpw0CBEU4MwMGoyksb4CHkG05Vj+QJYeeeNlRRvATTfTP+Jjy3Xqtqw=@vger.kernel.org, AJvYcCXoMvEAGaZX/tPDRhZ4C8S2fZkPfSsIiofNP4b9n58vP+RwHJKqhuYrjLi4nPhB2mYGjvvA4mIvtNL0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/QDr/ZzUqxXMdddLl8NOHIOXQllS1tlDvTRUtZgW7jFG/Gngl
	0RRPJGeM6/A4IR4jr9fPUNyhLtT1yDPXY3BjRyvbC/aLkV1V1b/meEEe6Kjn+jGLnp2Bs0RcnlU
	0BRtsTdhCS8vixJ6fwLNZbGS+K3E=
X-Gm-Gg: ASbGncuaypk84wAVujQnSDuCaDxgoKsimEyUset/XF+7Upek00IbVUMuK6iMWcNF0x5
	9pJcdjTqu/PFqizYwbtJTGKouhhXbnzF7Brl4ZPtcvMhDbx9SHk4UJujAthSjF5fdaSwenYCRnc
	o=
X-Google-Smtp-Source: AGHT+IGlS0cVAd0st91xU2D48nCL2gCa3SCGAKqVvd3cM5wglhTfa7vJ1XBkyOj94B8CwdZQN+GSKTNE0VwWA7/YmEo=
X-Received: by 2002:a17:907:7e97:b0:ab7:63fa:e4ae with SMTP id
 a640c23a62f3a-ab789a9a583mr278038666b.4.1738930705331; Fri, 07 Feb 2025
 04:18:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
 <20250206-gpio-set-array-helper-v2-4-1c5f048f79c3@baylibre.com> <CAHp75Vf+3pc84vV-900Ls64hM1M7Ji6Dmy8FPwL=n0=sJFSuVA@mail.gmail.com>
In-Reply-To: <CAHp75Vf+3pc84vV-900Ls64hM1M7Ji6Dmy8FPwL=n0=sJFSuVA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Feb 2025 14:17:49 +0200
X-Gm-Features: AWEUYZkSs8v-7WJQOys6Nw0fuSh0Pf6jrpjU3caLBhYNMllzG2w7Y5BACdTLgxs
Message-ID: <CAHp75Vdt5EU83mJrB7Sb_pgRNbhvCQ=F2Lyq7mQLAvV-w6cqEA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] bus: ts-nbus: use gpiod_multi_set_value_cansleep
To: David Lechner <dlechner@baylibre.com>, Yury Norov <yury.norov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Yury.

On Fri, Feb 7, 2025 at 2:15=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 7, 2025 at 12:48=E2=80=AFAM David Lechner <dlechner@baylibre.=
com> wrote:

...

> >  static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
> >  {
> > -       struct gpio_descs *gpios =3D ts_nbus->data;
> >         DECLARE_BITMAP(values, 8);
> >
> >         values[0] =3D byte;
> >
> > -       gpiod_set_array_value_cansleep(8, gpios->desc, gpios->info, val=
ues);
> > +       gpiod_multi_set_value_cansleep(ts_nbus->data, values);
>
> As I said before, this is buggy code on BE64. Needs to be fixed.

Or isn't? Do we have a test case in bitmap for such a case?

> >  }


--=20
With Best Regards,
Andy Shevchenko


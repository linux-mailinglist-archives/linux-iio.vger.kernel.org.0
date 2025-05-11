Return-Path: <linux-iio+bounces-19445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E9AB29DC
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 19:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397A31895D14
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A604025D20A;
	Sun, 11 May 2025 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxiAVEt/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A84315E;
	Sun, 11 May 2025 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984218; cv=none; b=KPbptr2NR8M74Hq24viTs3rt5HrsGW7oOABe9YHRwk99pFtSfgXBUYaC03FLZWPKOEfJNzs/WGtuwmpoGa9YRvQ7cpoaBj6NKXLpfAjCCsYfS0e8xNGyl8xAHNsHJ50tPXdzO0hgXCoonlRH7i0jhWTPfm5h42mCSFiPxMzJF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984218; c=relaxed/simple;
	bh=LtzpehVGu2B69y1XpCCA5A0OebEImMHVr/qUe8ig5zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4pyPaRvJolwfLFgvsvD4LneeyW+u5AQWYyidC5w2irHNi+DB3TBV1kwBVSh0mjeJSqo7I1xFN09uNtywp0VgPTwXxnljgRdhs2yMWYN7w8o7RNJwItu/ieiLILjlD3Mt1onmDk1M63CHuAOFSWyEGyV+72bCBHNMQFl9lPE3WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxiAVEt/; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4def2473a58so770502137.2;
        Sun, 11 May 2025 10:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746984216; x=1747589016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgA21BcJxdlRP4wuaR895U76otIEBUDznH0KYWsiBok=;
        b=gxiAVEt/MxhCUjEVBtIISKXH55k9sSwOuc//rffdxzrupWHZZHoFaOj4dlfVQj04XG
         KkkhWonLA54QYtjoFo39tfiTH43y//ImP2F/P9Ma0EAdklmTG/NZGkiEzBeUmR4+YYXa
         yVWO3pRkwA0M/tdDOlgw77szO+oWrBpsToriGA0bTCwiKXyHbDTf0kLuV4vJfa5Zv3GX
         tVgLf9S6yYkCmYOxn6ztzhiWYfwrTbNEQSq5gqjbgtF2V5riasO3V55MQUjL4dUwn5sC
         wSOLWDw/XaGRCkFcmz8gnn9mtEGJSKR/BU4MnN9ub+68AFvsuwuMC8tsN/nmvW0GgRC1
         69QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746984216; x=1747589016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgA21BcJxdlRP4wuaR895U76otIEBUDznH0KYWsiBok=;
        b=S9wwIUdLVAbIeaRIuHXQ80kvq9bKx71mE8tMByLBVSlmPtWQCjVWDgFCefyIIKV5x0
         7ZrsL0dWplvsKaJIGcfOALeoRgla5jRnpS1vtrRRt9T8JPoUofVAeKTfsjsZt7WXcqdH
         AVrAlHLBbwB3OpE8LW6dOtaqZZ8uRLUkptVlA8JlzaMFpp6ay/CgomuVx0f1XIwaxnpK
         4CChyH8/ToB/CPvlHcOHFtdZJwT8j/lDKgJhioBorq19PLE5StcFuqgOMU78Or4tHozn
         1frht9GBl9Sl+3NTtX7FA7LBPmexcYQThe25T8c5OTLZ7dqFkbKoTp4zqj/HiMGyI9KW
         A69A==
X-Forwarded-Encrypted: i=1; AJvYcCUMu2vhyqvlVwfGaXqlPav8G9NhRNwIojckRtQK2rnS1ALTvaxINErpQI4DKgiRKt1y9r+y9GcMuLW3rAxt@vger.kernel.org, AJvYcCX0O7gOkv2d3bmBs1ofSgQvjs7EAlCnOBpzKSOftpvWqLz1Jvc6iv/3U9OjypN5gd5NKprdSuDabbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4vxp0dHJltNm3htjEIzKYveVoyxCjfyHqJEPLhmn3CjeAziQ1
	Iwt/s9mVA5jYMuBhKTbd7JvoRYFyTWIwkS0pxFLHBVv8q+RX1eqxn2Z4HNQ2ryLt73P/MWj5Lzh
	+OHq6iEqj8XE5XJWr4pemZKo1zLI=
X-Gm-Gg: ASbGncttBFjGiNrC5pxkhKluW1FiG9irSurp/DwqYn4gKCcwH6S39NHtvFLnqs2hcEL
	ToCVbnwxBSwm5Or+qgQ/Iv5i2bhUKaoaSXA1d5nTn+EsZylqW+6WTdyDadQjr+261mMnuR8iRPS
	4xFfbFD/WgQwjYfmpivQqSAJApT8GMN/qyWpl03WtLE+0yOw8=
X-Google-Smtp-Source: AGHT+IGLhEqaokzKQl34iQ57xc/NxVdJGI54Xizj99c/+daJg5Ju85VDhQgT3zo+gLjyclqJKdNxRkGzWhp0ReCK3+Y=
X-Received: by 2002:a05:6102:5345:b0:4cb:5d6c:9946 with SMTP id
 ada2fe7eead31-4deed334190mr8500994137.10.1746984215757; Sun, 11 May 2025
 10:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509013931.47524-1-andrew.lopes@alumni.usp.br> <CAHp75Ve7-hMUxrmXQnkMjynhPUbD6R+K=-j+h0zELvcxZdy5nw@mail.gmail.com>
In-Reply-To: <CAHp75Ve7-hMUxrmXQnkMjynhPUbD6R+K=-j+h0zELvcxZdy5nw@mail.gmail.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sun, 11 May 2025 14:23:24 -0300
X-Gm-Features: AX0GCFvrIxDMbI0XWKebH07YOg3FUp0UyfdHeuqnsmwrOfESJkVF0TP3ve7vBm8
Message-ID: <CANZih_Q5WJD9TSnyhPHcygFJDEvvkj1KdWO-1=QO-1Uhr6tLCA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: accel: sca3000: replace usages of internal read
 data helpers by spi helpers
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, andrew.lopes@alumni.usp.br, gustavobastos@usp.br, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Going back to this one to reply to the unaddressed comments.

On Fri, May 9, 2025 at 6:06=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
...
>
> >                                              chan->scan_type.shift,
>
> With the above done, move this parameter to the previous line.

Ok! I reorganized this shift operation to be all in one line.

 ...
>
> > -                       *val =3D (be16_to_cpup((__be16 *)st->rx) >>
> > +                       *val =3D (be16_to_cpu((__be16) ret) >>
> >                                 chan->scan_type.shift) &
> >                                 GENMASK(chan->scan_type.realbits - 1, 0=
);
>
> Ditto.

Thanks, I changed here too.
 ...

> > -       else if (!state && (st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETE=
CT))
> > +       else if (!state && (ret & SCA3000_REG_MODE_FREE_FALL_DETECT))
>
> Remove redundant 'else'
>
> >                 return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> > -                                        st->rx[0] & ~SCA3000_REG_MODE_=
FREE_FALL_DETECT);
> > +                                        ret & ~SCA3000_REG_MODE_FREE_F=
ALL_DETECT);
> >         else
>
> Ditto.
Ok! Removed both of them.

 ...
>
> >         ret =3D sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
> > -                               (st->rx[0] & SCA3000_MODE_PROT_MASK));
> > +                               (ret & SCA3000_MODE_PROT_MASK));
>
> Remove unneeded parentheses.
...
>
> >         ret =3D sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
>
> > -                               (st->rx[0] &
> > +                               (ret &
> >                                  ~(SCA3000_REG_INT_MASK_RING_THREE_QUAR=
TER |
> >                                    SCA3000_REG_INT_MASK_RING_HALF |
> >                                    SCA3000_REG_INT_MASK_ALL_INTS)));
>
> Remove unneeded parentheses (outer for the last parameter).
Great! Removed all the unneeded parentheses then.

--
Thanks again for these comments,
Andrew


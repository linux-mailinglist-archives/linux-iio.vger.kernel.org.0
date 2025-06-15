Return-Path: <linux-iio+bounces-20681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDACADA0BF
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 05:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02ED6189389A
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 03:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FD52E630;
	Sun, 15 Jun 2025 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+zycXJQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F59C28EB;
	Sun, 15 Jun 2025 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749957720; cv=none; b=k3S1w6FOtBg9NOPrd/qor14pMTTyd/mRFlYSsxe3HLlA969DkcQQx1PIdxlWUpJRVRLp5Rwzxt850BueL2wU8Ra7zNtuZiYq+FV2qmIdcZtvjtPm5p0SM5GymHWYlqh5Roz6PEdOdmOyTAWfbbOnG02B/lc6pjBtDiV+Ry5v+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749957720; c=relaxed/simple;
	bh=xwhgC4f93t0za700nReXFXsEK1k+n2mQmbFJupW7dVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQGerh4bPQ+kXfyJztYzYAuM1dnoEpbwHvyAONfobikp1OAm7ij8tAqDBWaxrkNS0OJkkYBMYPyLF4TvngA58to0hln1fe1x+bwGRZDAQIHSGWMnfACcHr/Q9VEPSifHejiDhRq0Nn4VkvNoJuovzwpsUf0JVmsTb54JpXq5Sug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+zycXJQ; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4e7ade16082so1002581137.1;
        Sat, 14 Jun 2025 20:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749957718; x=1750562518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wExD0cpW6EK/Bucskg373M+fWDTA7/mApFOQNklxIsE=;
        b=W+zycXJQ6kZe+7jWXXdBmRHi9y+YtnDaqOzVFSwcjYftifwb4BS+ahVoHPrjJtbXSj
         9qXBad1nWXUc9D4sn+jXz2zzbxoRsdukblG39sNpF9T2eTZTQtZrQ0o7C2JE7Uq8rj59
         75VY6ZnZhkPjrPeCFFClbmp6/pURN5kAzlFJj6PCFH+1XDfzZDRjftzTE5Ew4YsP1nIF
         5r0YR7ANN00XvAXKDnyYX1jJLk7irOhgofa/yZnv1mswvan0qNtL1FgNfWMFt9YYuX6K
         j6K+GDKZoPJahssBviok+lZzgZ0kK/U6tI1S/og1bLN1YBuqtksatPG/iydh7VrDkq9P
         +iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749957718; x=1750562518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wExD0cpW6EK/Bucskg373M+fWDTA7/mApFOQNklxIsE=;
        b=wfCIMm3K9TJmgQw5t/Dp0PLuQBsRkBgbB8ITmzag3+5Cq0Rq5k+U5hTFy5HHactjFD
         RXuWOOSxCLaxssy+wPIqMjswa4Nhfxbue87H7JJUMZL8109CXWOIbYN8T0PbFcIhrBoJ
         8oIqDt0LQO3V+OOrenoV0CYBLzFZ4g/W8Ap/89srX17wg9jF5ajaY6Fd6WgFNfIIDwO7
         Qebg8tcwK4P+/5WRSQsGkD/NkzwDgKIqbJJUFlVZ35YEAfL4Cf5kaS4Pnveu1JVN16W+
         hDSQlBFbbj5dB7X7ncR5/W/vcrEBLTFLXxZb/s+5dkH5eRcF72DeYUU8f4wXAA9RoKDV
         OW/A==
X-Forwarded-Encrypted: i=1; AJvYcCX+Z94WyCb/TtoFVWWa19PkKqLpsWxHJrnX4YI6x09EEWs9V2N1lsYH1j0J2nS5od1IqlkCvwBQ01E=@vger.kernel.org, AJvYcCXaIywDw/WpyviSgTUh4Q2tZj9TX6KMHlCjrxmbqgECG9U3zRZGBnqcrTI9nly3c3/LMh1mhAsFuq60b+Y9@vger.kernel.org
X-Gm-Message-State: AOJu0YwwNauiPLWKS1Wiw+MiDSOjX0e7KF8ITcfZxDP4JaJyPt7lT4co
	Me0pdmj7HtCmTgOMU3CjCO8w+LSg1J5sdVMzTVarRfqwLAtKipYziqOu5jGOUvWyy6UXO9eTtKX
	QmVFM8YNwzvUN8ikYslDT99gM8xXr/fw=
X-Gm-Gg: ASbGnctWPzj/b/0GQinGD60efuEhiMCaVO3ZpdwRmkfo+u2cKuRExiuQ2AL+n6pkCkQ
	iBm0b6PSV6Ari1UI+A2XU3K93Ule/+txJe9MRQbM46ds+3gTmd+ltclWJSE0yXSgG0jYsWPQkHP
	mqjhxMQuYHBmjytcAyTm7Zqg07xL0Kd2RRghZBxwSHzOMQeCNHJmDYmC9ASA==
X-Google-Smtp-Source: AGHT+IHjzK0oPQ1W70Jp9lc1Z8gKz5hkYXGV/pqRXygc65iXD6dzOVkVFLNXnwpmF1LOLpBAGyP3rJin9Y3QiDQok+Y=
X-Received: by 2002:a05:6102:4bcd:b0:4e2:ecd8:a27 with SMTP id
 ada2fe7eead31-4e7f632330fmr3284379137.4.1749957718008; Sat, 14 Jun 2025
 20:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
 <20250611194648.18133-3-andrew.lopes@alumni.usp.br> <aErUqzdFL9nG6Bxc@smile.fi.intel.com>
 <CANZih_RTtcHHP80rtJ5gGkmkL1ohoctUBaGm-2Z2=Xo9VvT-Aw@mail.gmail.com> <CAHp75VfXw++C859kq58QOEcC5c4z1YdF0yBH1v4vJYujUPT75A@mail.gmail.com>
In-Reply-To: <CAHp75VfXw++C859kq58QOEcC5c4z1YdF0yBH1v4vJYujUPT75A@mail.gmail.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sun, 15 Jun 2025 00:21:47 -0300
X-Gm-Features: AX0GCFulQmotUJKswjZcbyCcuA8cl9dJtWHUgFy3L3Fwx47Bynyc5TnE2FRTM9U
Message-ID: <CANZih_SG9agcQJ=VP-u5FAAkj1L1-pWmA4UzkSU_UcM+LZ14Zg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: accel: sca3000: replace usages of internal
 read data helpers by spi helpers
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jic23@kernel.org, 
	andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 6:50=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Jun 15, 2025 at 12:06=E2=80=AFAM Andrew Ijano <andrew.ijano@gmail=
.com> wrote:
> > On Thu, Jun 12, 2025 at 10:22=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
>
> ...
>
> > > Moreover, the function  should be switched to sysfs_emit_at() if this=
 is part
> > > of ABI.
> >
> > Great! I didn't know that.
> >
> > In this case, sca3000_read_av_freq() is described as a "sysfs function
> > to get available frequencies", so I guess it's the case, right?
> > Is your suggestion to replace cases of sprintf() by sysfs_emit_at()
> > then? If so, I could do that in a following patch, it seems that
> > sca3000_show_available_3db_freqs() is also using sprintf().
>
> Yes. This is written in the Documentation.

Nice! I'll try to make a new patch later to address that then.

...

> > > >               }, {
> > > >                       .len =3D len,
> > > > -                     .rx_buf =3D rx,
> > > > +                     .rx_buf =3D st->rx,
> > > >               }
> > > >       };
> > >
> > > > -
> > >
> > > Stray change. Doesn't checkpatch complain on this?
> >
> > I don't recall getting any warning from checkpatch but I can check
> > again for this next version.
>
> The problem here is the absence of a blank line between the definition
> block (where variables are declared/defined) and the first line of the
> actual code.

Thanks for the explanation. I double checked and checkpatch doesn't
seem to warn about that, but I fixed it anyway.

Thanks,
Andrew


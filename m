Return-Path: <linux-iio+bounces-11946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026269BEFC4
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 15:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880181F21FBA
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764A31E0499;
	Wed,  6 Nov 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3QcSTEwR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD317DFF2
	for <linux-iio@vger.kernel.org>; Wed,  6 Nov 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901831; cv=none; b=QtAIwgXmCmidlWRnCJEQUXFFOO2y/Q+yJgb+B+TNSQQ+yG450xZ6EqtEqVfmlgI7B6ccUpLGISTAGh8OALgpUTzGlVeC2zI4fMbS+jfD/BOPYvtjsXxGBw0Trn7MA4DihP5ZgDdjaL4xTsU21ciyC5i4C3zkkOKRcb6j8I6rzGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901831; c=relaxed/simple;
	bh=BRELluoB3BcwrDwB0JatpNKtw7xSPMK5yId7NAyYwb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPARrIAz/WotY4wD6G9Fg4BfdKacX2LnvUKbSltsuCWEBrszMawyoSdCYE8aKbg/MS0o7t88ELNYBgzu7VC4Je6WzWGgld1EJNfX2cnpgNg4qXPtlBPsmT0da2Q3oH0CGXwgCHmlnaUsgBfXY4zlvyuoEzU7Se+67YJWqE/Q1gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3QcSTEwR; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b1511697a5so462857285a.2
        for <linux-iio@vger.kernel.org>; Wed, 06 Nov 2024 06:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730901828; x=1731506628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qFAv62RI8NqXjqdkvHw+8SNQsMbQ88Kr9G0caEjF2A=;
        b=3QcSTEwReAj589TLDCLJ0RevJSQ+7I7a2nnt8d7WL0WrsfiG2aPD0T+k1wyrji5PPV
         D3ufzQSSHQ6bbSLkQfWfD4EembtpWgQRd8EQ5zqNbvcxfOWNlOyXa7See1OUJw/YYRrF
         1Xl/sYSldZKFhlN1smkL99fEiMjSK3RUHgE5jjWV4r74lRHRcLfOT9JMtNJyWuCX0qEo
         x626Eh2pWlmN90L7IKNG3MjAX4fw4T/kJgkW6WU1MliydXQWfcBqwHb7ys0b4oCrVePA
         XxjdOZ7rR9R7UHk5qIKUCFNFkohuvxdmz0woaHeEbpvExsOU8LY6VEWiggPQx/CYRKde
         08/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730901828; x=1731506628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qFAv62RI8NqXjqdkvHw+8SNQsMbQ88Kr9G0caEjF2A=;
        b=uOWoydxtYkR58XB+ewyyusz9cEc/MXxzMFeK7EO8YQwONU597LKWP/Kgy6b+RKWdHb
         TJaxfIy4XuIBjPj5nB3ja/G+g/QwCU0quYTN/orS9PkAr1Mvy28aXX0bnHt0rJ+gEOZe
         3Y9qLkDU7aV2m24V8IKiwVbQIl5pUvdfmzFFfylkgyGupsDt9IoNZx8jwEFmhI6RhEdN
         dCV5RuES+Bh2tzJV/jcURltBBJoS9GrsjY73dTgxK2cc/wuCtfbfC8DPvV8nWtT/O3pS
         HsnamTrf4liMDq9ZIftuWbE8gko2D256HNOpRWeB/S5tX02flgb9KlDnjmA4twbFXdhx
         2rtA==
X-Gm-Message-State: AOJu0Yw385fglvAq2G9csIT2Js87bjDi+ngDcdoY4eIKxGWlFCGbYCNM
	QXTGhGlE7sPD1673z+/1I3hNT9KdWS/9xzeY6KF+EXtiRwpGAdemxnDBBsqS1DZieHGNxot5Tit
	ywMyOssljEsRJJtKTL25QZPAlEzYP/Zs89fXBMtY5jYwMXvkDoj1j2g==
X-Google-Smtp-Source: AGHT+IES2FaQC22aSUkUFna/ll6nbwvITqYva6F+Gk8zHOjC0pnuajIqTPOsAxtt5SNW3oxA44R0ZyCHgFOLCwmf8NQ=
X-Received: by 2002:a05:620a:4153:b0:7b1:123a:2185 with SMTP id
 af79cd13be357-7b193f5b5damr5095196385a.54.1730901827481; Wed, 06 Nov 2024
 06:03:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105145406.554365-1-aardelean@baylibre.com> <20241105150826.86b0a8f2c0df2a4822b07757@linux-foundation.org>
In-Reply-To: <20241105150826.86b0a8f2c0df2a4822b07757@linux-foundation.org>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 6 Nov 2024 16:03:36 +0200
Message-ID: <CA+GgBR-a050NUMB4Z=Q1UhqjAcKRVVw4k+S9uBZp6iRGqHkB6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] util_macros.h: fix/rework find_closest() macros
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, 
	bartosz.golaszewski@linaro.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 1:08=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue,  5 Nov 2024 16:54:05 +0200 Alexandru Ardelean <aardelean@baylibre=
.com> wrote:
>
> > A bug was found in the find_closest() (find_closest_descending() is als=
o
> > affected after some testing), where for certain values with small
> > progressions, the rounding (done by averaging 2 values) causes an incor=
rect
> > index to be returned.
>
> Convincing changelog, thanks.
>
> > -#define find_closest(x, a, as) __find_closest(x, a, as, <=3D)
> > +#define find_closest(x, a, as)                                        =
       \
> > +({                                                                   \
> > +     typeof(as) __fc_i, __fc_as =3D (as) - 1;                         =
 \
> > +     long __fc_mid_x, __fc_x =3D (x);                                 =
 \
> > +     long __fc_left, __fc_right;                                     \
> > +     typeof(*a) const *__fc_a =3D (a);                                =
 \
> > +     for (__fc_i =3D 0; __fc_i < __fc_as; __fc_i++) {                 =
 \
> > +             __fc_mid_x =3D (__fc_a[__fc_i] + __fc_a[__fc_i + 1]) / 2;=
 \
> > +             if (__fc_x <=3D __fc_mid_x) {                            =
 \
> > +                     __fc_left =3D __fc_x - __fc_a[__fc_i];           =
 \
> > +                     __fc_right =3D __fc_a[__fc_i + 1] - __fc_x;      =
 \
> > +                     if (__fc_right < __fc_left)                     \
> > +                             __fc_i++;                               \
> > +                     break;                                          \
> > +             }                                                       \
> > +     }                                                               \
> > +     (__fc_i);                                                       \
> > +})
> >
> > ...
> >
> > +#define find_closest_descending(x, a, as)                            \
>
> Boy these things are hard to read.  They're also bloaty and I'm
> counting 36ish callsites!
>

Yeah, they're not easy on the eyes at first.
But you do get used to them, after spending some time trying to
understand why they're not working for some values.

> Can we fix both issues by just giving up on the macro approach and
> reimplement them in out-of-line C code?  All the sites I looked at are
> using 32-bit quantities - a mix of signed and unsigned.
>

Converting this to a static-inline was my other thought, rather than
keeping the macros.
But I'm not sure where to draw the line between too much rework vs a bug-fi=
x.
Just fixing the bug was done in V1 of this patch, but then the kunit
exposed a bunch more.

> It's separate from this bugfix of course, but would it be feasible for
> someone to go switch all callers to use u32's then reimplement these in
> lib/find_closest.c?
>

That would work.
How would a rework be preferred?
As a continuation to this patchset? Or a V3 to this patchset?

It's not a big effort to do, now that the kunit is in place.
I actually have a bunch of kunit variants (locally) that try various
combinations of signed/unsigned X & arrays.
But they drove me slightly nuts, until I decided to do the enforcement
to 'long' type for x, mid, left, right variables.

A catch-all implementation (for all current use-cases) would be best
with an int32 vs uint32 for X, mid, left & right (variables).
The thing with X being an int32 is more related to what userspace
would expect to see when inputting a negative number against an array
(of signed or unsigned).
The type of the elements in the array (signed or unsigned) doesn't
matter much (if focusing on the type for the X, mid, left & right
variables).

For the oversampling feature in ad7606, with unsigned X:
   echo -1 > /sys/bus/iio/devices/iio\:device0/oversampling_ratio
would return 128 rather than 0 (for "cat
/sys/bus/iio/devices/iio\:device0/oversampling_ratio")
Right now, the IIO framework treats -1 as an 'int'

But, moving forward: what would some preferences be?
- have variants of find_closest() for unsigned/signed arrays? (
find_closest_u32() or find_closest_i32() ?)
   - AFAICT so far, there aren't any values in the arrays that get
close to INT32_MAX, so int32 may work for now
   - maybe later some 64-bit variants could be added if needed
- should the variables X, mid, left & right be the same signedness as the a=
rray

The only preference (towards which I'm leaning) is just making sure
that X (and friends) are signed.


Return-Path: <linux-iio+bounces-26788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E336BCA7800
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 13:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DAEA30987B4
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 12:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A0426F2A0;
	Fri,  5 Dec 2025 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMt2ahl3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11E316915
	for <linux-iio@vger.kernel.org>; Fri,  5 Dec 2025 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764936163; cv=none; b=jP8buj3rqa9SVlU2Edy8nuO4qJfKO2pGX5lVScXDnwKVIWWbKN1+y0KgyK/uCvRASB2FGqI6F/0SGDpdNXz7IQ92aDJoyiy5ugamry+MhFvKddOwmtDeCESAW8euMwyZUNipDME2383ycebPjYeHjPMtAvyBV6z3jmYHgoY/fxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764936163; c=relaxed/simple;
	bh=bgYeGMAzm6Y6sfhlpNRYEBYM+0aMUuWk/NuSWaFkkTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/liMFMPKEWSlx3xe4TVVuRtVvZ0AHIC6gwhQfjGCLE3UGkJVxW19mmvuaEcuPc5/OwU735siRckByAUYcSB0AypRnWthToTkHrakZEaCtLcMkN7M1j3jZkXdqe+AkTrOPbSh1GfI5bKw/nbI2+k2QqEr6fbY7dtF1LhnJDZ9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMt2ahl3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b737502f77bso262644066b.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 04:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764936158; x=1765540958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgyaUQ07yV5AbaD6jWa5R2iO6mlnxudcEFZdveJPHlE=;
        b=WMt2ahl3Go75Px38hXZd/4f7k5fSV4uIJHmp5qLW61Gdy06MSZIRfVgVrkeTdQXdyg
         V9xct/0yL7Yn/Y3Eh/vn1MTOXHc7N2Vdzg2dtMxwQJpISsFDLdeQdtRF3BGp7neiLsTI
         kWmnazS6cmIQ2pJxX1ytEfm7yPHMCfJ+GxX7Gh32ttxO847xtad/+PxmepZf9FbIEnVv
         k7NH8FPU+1pfZxjG3+crlTzmj19EllgpR+iYzZgbt74Qia0It84Dvpi4gSXiT1uE2ljW
         nXarr9fnXxBEErW0fw8X5UowjJD7OMcx1P9pX2Yr0kOIp+qfUDYE6LVJsEA2lKy0sMiY
         BcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764936158; x=1765540958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VgyaUQ07yV5AbaD6jWa5R2iO6mlnxudcEFZdveJPHlE=;
        b=tGOCz8hMOASQLdQDvHA9PEvVzrnrRzK77xP/bNz/tQTbaGPDmQyr+3VSP8JIZFCbUM
         CfwyCs15nm3uRJ8VRF8V7J/MDhijnHBO8OafiYejUbEi1I1U7xbiDxmq2Z3qKxlL3ae3
         LkG9ymUsT1g59XigzdWgOGPMjNnr2+jcHBIsS6lNTBFcd+nV7reKNTyK4Lqi9HgTxSEl
         FrU0IQVRtlLt8zFl0fFcoDbxmz/c8uax6JTizPLzbtUcx81W9L0LU49y1EvkfCYutcHS
         U85HDVVs6HEGt3u2BH9nbP7fEHFO4KqQCFJYQ6/S1DOBpbDMrThmGsrICNiLus65hfjs
         qUWg==
X-Forwarded-Encrypted: i=1; AJvYcCXZJo+VkL7TVRFUh5Owaxs7l2FavgJUl63CPGGHmHfR1lbDSuOJBh320jSbU3kOossBNy3lgs+l+X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEgyBmExowLs5IIqBmAJd1arE8FXRYYkLdOMP5vW1ZhgXf2vtH
	c6PDzk6HmdD6OzkQ3XQSkX47ZWxExq0WSkl9hthon2uGYKnX+Th+ICuJ8u5Gmz1gkvQwXyCpOWC
	zen5c0XCuKbLYyH6InFmWo2gjMoy7kJI=
X-Gm-Gg: ASbGncvFLJhg6n+8W9Sew9tNuIYpIPUsAYHmJZhSDXiakWyLGKOU1IpBoIQnBjluapd
	H5qPfe5O/8kAHQfMJolmw2fpp6MLahqQ2iVmDteD5BifHjHoUjKxVcGzUlQ0nch9P6wlb88gQzc
	UzpV0Utc33j7b+YMjE83D84TJGqIg0WFUzeehMl9J8UpV7quvhrEN/qWC+DDlewwsKZgE2B+mpv
	cuE/tOVihKLbAANNqyMCn2NkrC1iywsaW6kp1aFRh4kJ6J2zCwPTofW/KMFanPHIvCHCpBUT59u
	MFq+DEUr+wIuMH9hTHs+uriIheW+DaVsiKAXq0huSBPurc3xJyCOPSUmBge1idA9KcygSrg=
X-Google-Smtp-Source: AGHT+IGBQ0GhvwVKLqSDdmB+0hEDhHnoYfYYmLqHuYVoO1l7rAv2wXtwBjAHttKeBb0IocJiCANgCIPU3cmgESB5dxQ=
X-Received: by 2002:a17:907:7ea3:b0:b79:cec4:f1ad with SMTP id
 a640c23a62f3a-b79ec6b93c7mr675997966b.40.1764936157439; Fri, 05 Dec 2025
 04:02:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-9-a375609afbb7@analog.com> <aSQ2JUN05vmMQC1I@smile.fi.intel.com>
 <rk4hmupbrb5ugxft6upj7ru43x3z7ybrobax45rorpwbcwleh6@vzxrr3m7r6ep>
 <aSgX9nMBwBtAlSyj@smile.fi.intel.com> <3izg5lyxjye24pvzoibk4tmnxbdfokr53abkpbjo5epqjoz55j@6wc7i4wsgwkt>
 <CAHp75VfLd46xt_2W35gjoTCoh+PqExL-faZ8snhzfOx=65qXWw@mail.gmail.com> <egl65ctlz2umzcdzf7ke5c2hnd33ghudklmf4pdgnp64vnzjg3@rpqrludyv4p2>
In-Reply-To: <egl65ctlz2umzcdzf7ke5c2hnd33ghudklmf4pdgnp64vnzjg3@rpqrludyv4p2>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Dec 2025 14:02:00 +0200
X-Gm-Features: AWmQ_bnpd4_oFl4c5azPbk7HXaspqhnY9oSEmM6KqrHSmwBU-kDUBFomCH8ufok
Message-ID: <CAHp75VcJZavRo7TKXAZagDc8Vt4-y-zm+EySyugRtSxSLMGX-Q@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] iio: adc: ad4062: Add GPIO Controller support
To: Jorge Marques <gastmaier@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 1:53=E2=80=AFPM Jorge Marques <gastmaier@gmail.com> =
wrote:
> On Fri, Dec 05, 2025 at 12:21:31AM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 4, 2025 at 11:38=E2=80=AFPM Jorge Marques <gastmaier@gmail.=
com> wrote:
> > > On Thu, Nov 27, 2025 at 11:20:54AM +0200, Andy Shevchenko wrote:
> > > > On Wed, Nov 26, 2025 at 04:55:41PM +0100, Jorge Marques wrote:
> > > > > On Mon, Nov 24, 2025 at 12:40:37PM +0200, Andy Shevchenko wrote:
> > > > > > On Mon, Nov 24, 2025 at 10:18:08AM +0100, Jorge Marques wrote:

...

> > > > > > > +       return reg_val =3D=3D AD4062_GP_STATIC_HIGH ? 1 : 0;
> > > > > >
> > > > > >   return !!(reg_val =3D=3D AD4062_GP_STATIC_HIGH);
> > > > > >
> > > > > > also will work.
> > > > > >
> > > > >     return reg_val =3D=3D AD4062_GP_STATIC_HIGH;
> > > >
> > > > Hmm... This will include implicit bool->int. The !! guarantees valu=
es 0 or 1,
> > > > but I don't remember about implicit bool->int case.
> >
> > > I don't think the implicit bool->int is an issue, grepping `return .*=
 =3D=3D .*;`
> > > matches a few methods that return int.
> >
> > Yes, the Q here is the value of true _always_ be promoted to 1?
>
> The relational operator result has type int (c99 6.5.9 Equality
> operators); and when any scalar value is converted to _Bool, the result
> is 0 if the value compares equal to 0; otherwise, the result is 1 (c99
> 6.3.1.2).
> https://www.dii.uchile.cl/~daespino/files/Iso_C_1999_definition.pdf

Okay, thanks for checking this!
So, let's go with a simplified variant then.

> No conversion warnings even when forcing _Bool type.
> There are many usages like this, for example:
>
> drivers/iio/accel/adxl313_core.c @ int adxl313_is_act_inact_ac()
> drivers/iio/light/opt4060.c @ int opt4060_read_event_config()
> drivers/iio/light/tsl2772.c @ int tsl2772_device_id_verify()
> lib/zstd/compress/zstd_fast.c @ int ZSTD_match4Found_branch()
>
> I cannot find many legitimate usage of relational operator with the
> double negation.
>   git ls-files | xargs grep -s 'return !!' | grep '=3D=3D'

--=20
With Best Regards,
Andy Shevchenko


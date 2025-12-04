Return-Path: <linux-iio+bounces-26778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DFCCA59E3
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 23:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1232315C80B
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 22:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC5335576;
	Thu,  4 Dec 2025 22:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaD5CKhp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB9314B6C
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 22:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764886933; cv=none; b=eiWfysA4ZfAsA+ywRLzgk5QFz8qrE1l1XCGgTFRPMelZ4m1tV/5tcn5idcslos/W8jrDMTdN+kkS6D5iJWZmZ5Y7AUqFPeoJc3EMJz/FMrb6vgx/ztlM77y+DwIyaKRi5jQqq4FCNz0mCS815y1JIFdFbXZ0XUUjvG4aCTO9BsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764886933; c=relaxed/simple;
	bh=D6xxe3fyua+TN2tZMgy2Gw80PyQe/N50HFczCYjzibE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9xOGvX2A9pap6aPyTuE6og4g0vp/lyl19jVjYvKvKkapwqvWkLWhUCwxEacawyFysY6SZaieE+/dTE54fuTv5mMAoks/+EEEFqJXIilyIFhc2brEygvnneSqX0JOONRIbRwXBNfYRFgIOSLN0n6fzbykyp3322/uU9r7FgWgZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaD5CKhp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b736ffc531fso249959366b.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 14:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764886928; x=1765491728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XupUstTQcKQfp6Q5f2R4dwsrOpNjG+W+mOqffMiqwlg=;
        b=EaD5CKhpYXcP3CDF1eZZYnnEolEN4pOOOAc88koxvn2tYY03BjA/S31Fpv6rAi+KIZ
         u67N10agjF9wVRjAoWtCg9psyombmYJ2iUFeiI1k4tQV/yhbJdbyq0GsaFhIu/24hc+t
         XpA6r+DM0mA4iMx6xYAsVePFJaSJtZ10RTKAKeQ7nyluEJd91Mr7HkzQJCntIEIk29Ub
         hJR9B0KonMSUf2o2vgYkda7jfZZmG68hXVYrN3uJmYKvLi5zjJdbuQnOtScdtA+p9BIK
         JddlF+Pch8cxCibFW+zKrXq+5jcdcJwhhzBi3GX5mkV/Jh+nzS1ojvOIqmj2niVdDjuF
         Vrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764886928; x=1765491728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XupUstTQcKQfp6Q5f2R4dwsrOpNjG+W+mOqffMiqwlg=;
        b=pjm6hQuwZsuW7CVwBss1V69txr+8ibpVTUYzxEoDLmsHC1fUFmS7+jJnk51Fjt1vSH
         S6LP0BWFsQLQ7p9vxluFmNTc5LB5CUTw4O06Z8n+Nr8agcVo/xdloVxb5XS+4Ah7Pq/Z
         0vRZoTBYpOBWNCf8uUTJRA3jd9/n/Dk/ZttQ4/lkmrlOmUXV8pR5waGICcVyPyQwl0d3
         l5kZrxncI+Mv4mNKeAxG3mDz4wvRKG4Zgiyfn9LgklOFzyQ3oNTH9xJit2EKDO2IzJtE
         BE+0eSMItWCpIYaov7PQZumR/x+mDKma72TzHcIDfP9bblHV+JtC4PhtNI1RRyWrRlFo
         zbSw==
X-Forwarded-Encrypted: i=1; AJvYcCVCiA9dlqufHopJkaIoTlL17DtwM5z7tp67n3WW5m3E5p/CNaeiAz/JW+dlLw8acWTNKLc5smHcBCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19TyVWUlQbOINPH52AbkWGh6PJuacWhi5iYqw2nJUGDSq3FWl
	OSSd9Te9mCbo/F4H1iJEAZdBRJuFpyhuBfGbZySlWgDxQey74B18MGvqsCYidrjRkp20QiSLtA0
	MIEvHu5C3KEK3PRCUg/IM9jSagKbNAMc=
X-Gm-Gg: ASbGncs7/prFcxUrT9I5VS6/aVmja3pd20g3LsmIZmp+OX3gxpkdLy5qmeCa6OrJ5dU
	Ojf4z+4Jh/9f8sEKKmDdvVcqnCi44S7SC7ySZllVS1po8NYd9DQevnfHEozBGIsfD8JGWUk0A5e
	aGLk00PJk9ZlBmvXOAU663AeYSYhDVBeYvoGzMpeAuIKWapM8KJBTqs8XXgwsC+ZUbJRa6ZvkxL
	18XSy3+hsFVuG2YQbiuf3sKwSgcdpeWIhIY0/3ttEbrtLyEEU70uIRjyxvWB1ppcxO+5i0xcvCI
	Kd+fsZI9e6vEwYSsqsIP/J7mHfw4kIsceuY2ATJ25z6n+IvzYQyGDTFoMmEPFLCovgFL6Ow=
X-Google-Smtp-Source: AGHT+IFXDSgZzBVz1g8UK31AUP8phQfiDKgwk3r9slHtleurRlUBKv+w/ggRRvanZGRCWmJHejrKRrmxiRrqkTM4yJM=
X-Received: by 2002:a17:907:2d14:b0:b76:7fe7:ff37 with SMTP id
 a640c23a62f3a-b79dbe8bdc6mr841679666b.18.1764886927851; Thu, 04 Dec 2025
 14:22:07 -0800 (PST)
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
In-Reply-To: <3izg5lyxjye24pvzoibk4tmnxbdfokr53abkpbjo5epqjoz55j@6wc7i4wsgwkt>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Dec 2025 00:21:31 +0200
X-Gm-Features: AWmQ_bmbCUOw3LqhyL1NA8ZmvoQjfRd9vbO6kMBuNW89E9IZztlzzePVnfkiPE0
Message-ID: <CAHp75VfLd46xt_2W35gjoTCoh+PqExL-faZ8snhzfOx=65qXWw@mail.gmail.com>
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

On Thu, Dec 4, 2025 at 11:38=E2=80=AFPM Jorge Marques <gastmaier@gmail.com>=
 wrote:
> On Thu, Nov 27, 2025 at 11:20:54AM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 26, 2025 at 04:55:41PM +0100, Jorge Marques wrote:
> > > On Mon, Nov 24, 2025 at 12:40:37PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Nov 24, 2025 at 10:18:08AM +0100, Jorge Marques wrote:

...

> > > > > +       return reg_val =3D=3D AD4062_GP_STATIC_HIGH ? 1 : 0;
> > > >
> > > >   return !!(reg_val =3D=3D AD4062_GP_STATIC_HIGH);
> > > >
> > > > also will work.
> > > >
> > >     return reg_val =3D=3D AD4062_GP_STATIC_HIGH;
> >
> > Hmm... This will include implicit bool->int. The !! guarantees values 0=
 or 1,
> > but I don't remember about implicit bool->int case.

> I don't think the implicit bool->int is an issue, grepping `return .* =3D=
=3D .*;`
> matches a few methods that return int.

Yes, the Q here is the value of true _always_ be promoted to 1?

> Experimenting with the _Bool type (gcc 15, clang 19, any std version),
>
>         int main()
>         {
>             int a =3D 1;
>             int b =3D 2;
>
>             return (_Bool)(a =3D=3D b);
>         }
>
> with
> gcc -Wall -W -pedantic -std=3Dc23 -c test.c
> clang -Wall -Wextra -Wbool-conversion -std=3Dc11 -O2 test.c
>
> also doesn't raise warnings.

Of course, because before even looking into warnings the entire code
degrades to return 0. I.o.w., the test case is not correct. But don't
hurry up to fix it, you won't get warnings anyway, it's all about C
standard and not about (in)correctness of the code. See above.

--=20
With Best Regards,
Andy Shevchenko


Return-Path: <linux-iio+bounces-23463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9161B3CBA7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 17:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2637A6C57
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A381024DFF4;
	Sat, 30 Aug 2025 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O56kvdyG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9221E3DD7;
	Sat, 30 Aug 2025 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756566346; cv=none; b=eFupg8pAf0nqWtlN9UD2FH7w1iFZAknGXEgLfas1IcaX8Nmgdn1ajvoJSB1XygDgwm/luFK6ek3tahwUQfw/0/Vm0l4FMFvmdbNPBDIGb96i4hnp9my0cYhzF3siP1r6firxfyuc5U2rqmCO7+uwpydVrwD/SNSj0UVFOACX/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756566346; c=relaxed/simple;
	bh=jCqaKGitFN5uu3KorOhLoWYr/Okh3hv3yEe9Xhsc+vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEWKWWMPnPRjZW8LLs65c5FFZ32aMrTsEFvmzCY4LtRGB+YWssluVE1AxddCSlUqBNYfLgL1rdtrSc6xn8oVSHonbwk6Bb921JTqJeDO+nYBmIMr3tg9u2Dw1PdONaXJUghpyd8jQv6JQPdqVeyIiSLyY22dzmmhtPPeSWKIlBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O56kvdyG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so60059466b.2;
        Sat, 30 Aug 2025 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756566343; x=1757171143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN6cBknTvIC8v8PTKqGGEUwlLaNHTmySHAziXrgYzew=;
        b=O56kvdyGliu/TgF0bJfgqerBMGeApJXAQyMAIMG6Y0hQCr8s22BtPYVs1ycVV6n3n1
         0iWJnPk9DnXpLp/Kh6L5WhHeEdwPVrV7hpG3m1y68/1Qes9tGnW7MM1fnVKLOYYQ0p1h
         aXvWpW0HDH/szl+qqFG+aiWxhjpTcg0V3guaVJE1nR0kDLv7gFgUVXqSVmuoafSwRoWW
         ASc2QxGuBwZ0JjoRO6kQSkMobrnwA31a40AHTi8enrT/WR2hcDytJf8Y1pgnU0aBOpyd
         8fg/IH3yo/0hqWpzXiTr5hqJ76GjpUShRTtSNuQoCHN6WVSKNWKAmT0sNt/EUkJmtOt+
         ZpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756566343; x=1757171143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fN6cBknTvIC8v8PTKqGGEUwlLaNHTmySHAziXrgYzew=;
        b=tU7GO0zcqM3h9cgvKTOYQ0/iH03vAygdUdSMQeP+rmVW7KGMbnt2A04CF/w/HzFIvo
         72wNQnGNmaCTrz8hj6RWqfQBcC2SIROUizY9H/NLvjZLQ5SdiNeigf8cV6OHr2sxYfBm
         uWsmv8/jiwOkxYtri7lKKjkbfYVBsSAti4JUGG5ufsNregyW2h3O/poGktaWjrg1sGdw
         cAaSQweHLPWgZAQ9ZeNuQWhvKL3TyCrCb0vjQVzdEAg2Fuwv1CJMOUP8jmzS2oPzKMhv
         Q81GjIcllvR9s3iRhmSsVOtimtzC+3YT5zxzgY6zEOUHfrFY9OYQxdxON6eqgK8r0a7B
         sIXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz3utWWZXJLw0U1PqdulBcV8j33nzHAgVI5yFXwpXyEjyg0+H6oDAqrnBobX/9asC7knD79ib5jtcW2y/v@vger.kernel.org, AJvYcCVR94G9ogOuj0UJV/CNhXMn98eZxFBNIM+FrowSpFDN+FPUn57hnpli/fPpQ8OVgeqbJxN17NaH8oM=@vger.kernel.org, AJvYcCXaXC2u4JZndmMIC61BkWqw7ga1H1SxTozSglP5vwDksKv2TVaRt8uk0qsKzaaz2V9kpjMnF+AoD+0Boxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjW2FrkUV69Gg378i1lv+lQFt7CqCdufaHwJWDegY3X6+XojkC
	41ddlosm+AMtdhLZqsoEUj7A2aLew3+29vLnsrnguFXs8HKCn+CG+HG99MIu8iHrXXknFJVrecF
	jMfNx14iEXkq28kM3cXOULBlDyQWSbo8=
X-Gm-Gg: ASbGncv7kVxFAa9YCIDmHo983x7ZB6qU+30K8I4HDV1KgTTtFQVQ+hBaM8GD7VpR2iL
	aOUuA/lTTRiSqkap50DwAdrAzTr8U8nL0lIATM/+OcbrgMRlUe+2DG+eChBOpUo91K3v/7jxX4I
	vxIoGbl4wt3H6w5Zr9CCZv1YGHPK+juK0ruv1cZ4fDz/4sW6r7hhiePAoRg0NxJLT+lJ/xnr9b/
	4T5eqraoSY7oR8erisGSrfYK3/r
X-Google-Smtp-Source: AGHT+IGsH1PXGwUgVexc1lMG6rmmQhIjk/W76iU5aKBGV8SYkOMNIATBRu6zIo7zWQVFlSfWhfXIuXrT28YobmIlfgQ=
X-Received: by 2002:a17:907:3f07:b0:ad8:a935:b905 with SMTP id
 a640c23a62f3a-b01d8c74f3emr218389066b.22.1756566342992; Sat, 30 Aug 2025
 08:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
 <CAHp75Ve=xJ6vTUydaTw9GuYr22ZXp3HFA5N0tP7NET=CvZJB8Q@mail.gmail.com>
 <CAHp75Vd+hAucOyjqLj=rY3oLSySiReVupRQdBjwoLQSPAZMNMQ@mail.gmail.com> <22825864.EfDdHjke4D@radijator>
In-Reply-To: <22825864.EfDdHjke4D@radijator>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 18:05:06 +0300
X-Gm-Features: Ac12FXzmfa_ynBM8A7qkaTdSJMGTHyWBiaQnD0Amqhps0VbmmPMbityG91FxqAY
Message-ID: <CAHp75Vfg4E7nUXwQowN0wtNKQR_i6W+E_JT0xwCKSoY+ghGFvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>, 
	David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 4:07=E2=80=AFPM Duje Mihanovi=C4=87 <duje@dujemihan=
ovic.xyz> wrote:
> On Saturday, 30 August 2025 06:41:58 Central European Summer Time Andy
> Shevchenko wrote:
> > On Sat, Aug 30, 2025 at 7:37=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Aug 29, 2025 at 2:41=E2=80=AFAM David Lechner <dlechner@bayli=
bre.com>
> wrote:
> > > > On 8/28/25 5:17 PM, Duje Mihanovi=C4=87 wrote:

...

> > > > > +     ret =3D regmap_bulk_read(*map, regs[chan], buf, 2);
> >
> > On top, please drop a double pointer and use map directly. That's
> > already a pointer, what's the issue with it to begin with?
>
> struct regmap is only defined in a regmap-internal header, so it has to
> be a double pointer or a struct containing a regmap pointer. I went
> with David's advice and created this struct.

I might have missed something... So, the root of this is how we
allocate memory for the data structure and what we keep in the priv
member there. Indeed, it keeps the pointer to the field in the
allocated memory, so if we allocate a memory just to keep one pointer
it should be doubled (independently on the possibility to access the
data type we are using to keep in priv).

--=20
With Best Regards,
Andy Shevchenko


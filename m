Return-Path: <linux-iio+bounces-27851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B8D321E4
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 14:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9761E307A004
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 13:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764D328851E;
	Fri, 16 Jan 2026 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3WslThW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B6D281368
	for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571467; cv=pass; b=pZgEKVswsZT3DlUVENLcGC6CMe6oHy3iSx34GMUwZTqnj3n52bD97aQaR8EGWDdjuE+HIiFZxFYMVb656xXTTm5Rbr93t7WELBPfOetECGHUew1KawIy2H0Aj4cuOel0CwV9+LAIYVt4PCx1n8qnDxYl16cxVfBCY1hGETx0v1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571467; c=relaxed/simple;
	bh=0imWy1cM2Yh3ijKRNIflaY8vhnL/+2L4VY5uCrifH/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGlar3ceHQ8rs5ahntBzul7ea0NCz/44gIyQAdr5+lm6myCGz4CT/R37pgaqL5RPeAazWYsyQgtDj0JDgwEE+knu4sImYcMDmO8NPg5hFGUcLNK1vHNzyJr+l4gBbJq/6TJgehHRMNCbUY5KHopMlIYvwSVBfc+fA0gYndaWm5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3WslThW; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b879d5c1526so123532266b.1
        for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 05:51:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768571464; cv=none;
        d=google.com; s=arc-20240605;
        b=HPDSjmOv/Ywr2qokw16SnayUYcnF/Yg93ZKuCDwo8+odR0LznGQJVmdLt5gJ5OP4+W
         LVMTnAldroIQKVU4NrjIJHgsRoH0k0ebwq/qhJhcpa9y5eztRAQWK6GxZPcCuOwQNaoz
         rMA9bI326iM9xafICy9aVc9nEy0lJj81/UP/qwHwrKmIUYNh7DqKofPPnuZSo7w6Vmk+
         +fdXHsMr6D33YL6yYPK5DaCPuW2n1vv6YeC3vNyzviFGzG+HKUnMLmifuLCvyDnYeFbf
         LMmmymge2rPK+uE++7p189h5M8uqVZq5uzzCbHK+8e4I4FUsSlP9csazAApB2Ea7a00K
         z9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vP98g39yyougRsxlmtaspRwBSt2K8dov2JxcZQzReas=;
        fh=BaTLFgNVuJc6y4NJHOvJ2n2BV5ZetLQDtGUhZ7hXGdc=;
        b=eaA2W6ARn5tRQuq7Ir/7UOWoc9p0X4aLzjf9MrnVYKP1uuiP5Wyv5zfwe88Epb7Gcn
         vFTN31gnFoUns/haRCH8QYUGjNj3neBJ8YroeO4HF2FDgQ8g2SbVS98xWbbq7sHqsHzV
         bB6dPa+hdwMMNLifx95DQSlldNc0D0CPCzwIISwpzvRXsxohhPJOAa2bvxlFm8JjLDJw
         BzaEdpWsBaEc/e0yRvl6zJEG4NkiTcz7a60YEyQ6A6PvXC7q1YwsrAoychYn4/n+NfeZ
         dBvfSg32o642NaTWZYo2etQscHtMAK4i52ji5laVQKs9SKMMmSQ6nzyTVbPMGy+dwtsG
         zODg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768571464; x=1769176264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP98g39yyougRsxlmtaspRwBSt2K8dov2JxcZQzReas=;
        b=i3WslThWc1Xd+/crfe/XdxS+0Nsp58RaMSbabGhjGVY0L4gL07QRI8Mfn8Dqoz59Ll
         ZXOMW/ekCsToVc57Lc3ryRXxw67yjHXtS27iCkxHAs/5SSxEMRkTIYVCjA5keU+HDXJh
         c0z1Sc6EJmf6LVp1j8a+PrYLAlIzh6hthujW67yci8qW60cEBd1fXU/sspn82dpeWNm6
         mD32OJgg/yDjIbKmcG4ZgsqG0YuOR+l/9t2hRzfz/Qb/DLm2c1w/QaeCzg0z23w2iXJb
         EhEUwyKbcs+HNF/4xQDmhnU+cDfKlSo7dWONZHX4X4eJ4WBwdEnJ+kWijmiHp5LJUEQ7
         l5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768571464; x=1769176264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vP98g39yyougRsxlmtaspRwBSt2K8dov2JxcZQzReas=;
        b=lFNm/KqBmxlU+HJmdVRU4z/dWHSfC02VIcfaLrGdD3ihF5foRPHzegS0tPsPxsnWEJ
         WyC+30FAzAN/PAFa2UWh8jViR/mAgHWtWeqgupDGM9gQR3/JvqXfSySA40TuCeXQarGE
         XjrbE66oEekaSbWi8+xbWLgJOUx2iuu2iOH3Dy3n+du15fqd4LUr3GAfqnPqwPmWfpXn
         V6b+cLH0mARc9DXVCZ/P7ZOkqDDZbKEn9L5arJ1xDTJ6UgiyethXjUCtIN+SVcyt79mG
         thEPBk67gMafguXzA/kNF8gsOfi+KKN+2cRWRYeixIDvzmgpG32epTf4J0s3o5zu93Ag
         2e6w==
X-Forwarded-Encrypted: i=1; AJvYcCVjlJlihDL3oMu4kgUblpwew9tqBnyyqCPzESpQ4psyJBcWyGo4XqIAs34UXJfme2/TQd+6bx8vbu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJPEQH/KU9ZW7M0OHknHeLdi32SN6KifQ2MTvF3xVrKAq53+Ot
	jze9t93xxPCmx2TCb/b5ptCId5PrzbIuvcev7x6Jam3SZRidC+Nnj7ujAIUdSmSn0KM9CFBzp7U
	7sp+9GEbjDCsfWEBJjWiNxscqA4QQhhk=
X-Gm-Gg: AY/fxX5LcddfulHUYZv9KJsLRIfkuu9DYaAQCyRm44TT5YXHUbZ8O/f2yZ5gkoFhCPI
	4SauutmnRwwX2UghCIat+4Cjs6+JJYc11Ffl2pOtkHBhYSOSXuEFmFmgCEW6HxOVkreP5I7YVQp
	7E1k/Rwj4BIlePQkaTfHf3F6PsNnQIIW4B80TD/gv6sJq3qEaqss1qBLyOmWxHc7HCD0ZNnmuth
	ODXWb1pg/6lY+6ZtuIlhfBXOoneIYxHanc2VRVvGzsfM+UN6cVgp+XEKjrUfNOJ0FyNxWmzaJt2
	0Mdhol+5le64WiZtBYkuM1Tq7wQO2sIFukNvYpboR7mI899F6QNPdVHKQvF3bYy0+ndawWI=
X-Received: by 2002:a17:907:1c10:b0:b87:1b64:a63 with SMTP id
 a640c23a62f3a-b87968a9716mr191242366b.6.1768571463652; Fri, 16 Jan 2026
 05:51:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
 <20260108-adf41513-iio-driver-v3-2-23d1371aef48@analog.com>
 <aWFPEa9HI4wmYLpn@smile.fi.intel.com> <6hcqrcy3meskddrklb3jtlpca2snrs4upwms56lhq7mkes7krm@vdiaqkfc6lgg>
 <aWTTs1n_N0dVjpbV@smile.fi.intel.com> <lwqhf3pm5xewtx4hhq7ei2yil4skmtkstqfifif74u4e5jmtzh@wedhpibvjepw>
 <zgz6g7pvzijrt77lwdi6q23lgkscm33imcdfbnu7mxvzarygst@ve3wi5l6dv3d>
In-Reply-To: <zgz6g7pvzijrt77lwdi6q23lgkscm33imcdfbnu7mxvzarygst@ve3wi5l6dv3d>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Jan 2026 15:50:27 +0200
X-Gm-Features: AZwV_QgMV3VtbpdpsZAd3s2CqQZWxMYfJmVw_nvg5Cuzp2P6oYGHfb6siqtNym8
Message-ID: <CAHp75VccDF6QfkZ729qCTQcd5bbnTO2SX+FG8QNPRSC9=LneMg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] iio: frequency: adf41513: driver implementation
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, rodrigo.alencar@analog.com, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 1:32=E2=80=AFPM Rodrigo Alencar
<455.rodrigo.alencar@gmail.com> wrote:
> On 26/01/13 09:32AM, Rodrigo Alencar wrote:
> > On 26/01/12 12:57PM, Andy Shevchenko wrote:
> > > On Mon, Jan 12, 2026 at 09:56:25AM +0000, Rodrigo Alencar wrote:
> > > > On 26/01/09 08:55PM, Andy Shevchenko wrote:
> > > > > On Thu, Jan 08, 2026 at 12:14:51PM +0000, Rodrigo Alencar via B4 =
Relay wrote:

...

> > > > > > +#define ADF41513_MAX_PHASE_MICRORAD          6283185UL
> > > > >
> > > > > Basically I'm replying to this just for this line. 180=C2=B0 is P=
I radians, which is
> > > > > something like 31415926... Can we use here (2 * 314...) where PI =
is provided in
> > > > > one of the used form? This will help to grep and replace in case =
we will have a
> > > > > common PI constant defined in the kernel (units.h).
> > >
> > > Any comment on this?
> >
> > will adjust as suggested.
>
> I am finishing putting the V4 together and I decided to leave as is.
> doing (2 * 314...) might lose precision, by not much (maybe negligible)
> but it does, as (2 * 3141592) !=3D 6283185.
> And that it is part of the reasons why PI is already multiplied by a
> power of 10. I suppose there would be multiple constants defined:
> - pi in micro radians and nano radians
> - 2*pi in micro radians and nano radians

The problem is that we will have off-by-one errors in plenty of
drivers. Depending on the driver the PI may be floor()ed or ceil()ed.
That's why I think it is best to use 2*PI with the precision you like.
In this case it can be as simple as

((2 * 31415926) / 10)
But you might actually want to have the maximum 32-bit PI, as
314159265 for the same reason.

--=20
With Best Regards,
Andy Shevchenko


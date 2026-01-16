Return-Path: <linux-iio+bounces-27852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D53D322BF
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 14:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FB233074036
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 13:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8B0286405;
	Fri, 16 Jan 2026 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM2rntib"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73C72853F2
	for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571674; cv=pass; b=JRJ9ZXUaM6gjK7aw3lpuvMNgCKcUeHMwoCYgUwMIUEbUePMrl6ect3f1tA5SsONFxgAQWxI1FOVhoL5b4vyxxhc6vXVGA4B+zTIU3hDeJNUh6ZZbk8S9CFupY3nu+QygIMs0p+hEWlKAZfaUc6Q7/tcPvtIucHOXrwR6eO1Z4GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571674; c=relaxed/simple;
	bh=R8kBBE34ZNMYFTudNvOv2beFXalia1gR/fPFdf8uKYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYYifsLTKoPc7cGRG9hfD0WatB9rJYSxGq+PlITPH29KMgIX0eMBMRRi2SkkcQnzcU3AjRq00w/LIXgR65DJ3AfehnRaDXyX25Pku15BEsS6ZuwmMSPDEUCG3p7scWVR9wwR7+UGCzqy/7n8fCUjRbnKt8LhiHsl0945mUrvLOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM2rntib; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-655afbca977so1060510a12.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 05:54:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768571671; cv=none;
        d=google.com; s=arc-20240605;
        b=aUDniIKeeWHXEdLZEJ7nz+z9HUBkkUyPSdi4ETGH8m4lqnjxGYKWd2XtH/UeHGKMjl
         J/UDOsBWkf8vN7bAmrBB0NukBh2ppiVhCpwlpPgcem/Deyr2eaneXB7063XGr6LYKrfV
         UqTmYk4TFTa0/rptNwHYdnwzuYvI+jfKdfgNIhU4EzlS0TDlbTz3OOb1Beq22yYW7aP7
         59fjPYyeJs3suOGK3vujy1bIQ/qahHVXOZOiMEajdPc/qIDDSk/t57oIJz9UdG/u9TqB
         +uoder4eKyUY5MnoFhlEQuHnJmkj5tTskIRfzJK0Vg0Qnc1Tqd+dvU/WBTp6RsMy/J5J
         yK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RotkfXlDeAeLy5OveUiI64+KfXV2VpL9+J6GoWK/2KY=;
        fh=93wPC4fuUD6pnnm+BymApuaQz7hlqSGeBLNqNGzO8qI=;
        b=RL94hTgW+mrEL2di3a/zGqddfGq94XhYrxVHPZ/oXaCPGnVWtCSJv1X/pzpmWFPKSZ
         mU7b6byiDbu/pKFyhFObc9AxgZyzP0pWv85M6/04s6MkIvRD5lKcNUDVLOHyRpnhLiRZ
         ySh9KQ/lTZydjzofS7FrLEBdCvB9mRe5tTGxpTPuTgIUkiORB0Tw3ivxoap0/2BV44r8
         Ff1t69Nbhd694RJjavYHHm4fpxTdOsIJ3T2brfrGenxtndHR/9ncoiLGp9MTpdA2Mp+u
         akDqnmKA4UJSfvhMkyZvbFMTl/1uHs+CyYxk2A2MrKciHztwACLag1KKvj8IM3ejDbPc
         EAeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768571671; x=1769176471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RotkfXlDeAeLy5OveUiI64+KfXV2VpL9+J6GoWK/2KY=;
        b=eM2rntibBC6HsCk0aSXkFVNCs0lA8sodjRpwnc1dDdpuuHe9SJH3zyGlKhGLeXLHZ+
         JwpVJIUOplR8xgkEwG7MNk8eLJ0e8xqR2gSGvmpQxP3C/KhPzKc4ZfAo0ghmBsUrg3Ay
         0blZfPjFikCZoFXcI7PD/LzOw+EX0Cv2CSMAit5VmWq1zKyDr/ysYqK6NVuujzNqKsxr
         8N7xJJoRz8YvNamSsB2KhwI4hIei46KHaygqIeTLVfXk34O4MBm/5589wzvRS3jP5t+b
         hbPSG+f66w+KYwR+BKZ5h0Mwh+c2FAZKu75iNahMIEfQm/0ob6VeMHYUDZ0n9ql8rPAY
         t8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768571671; x=1769176471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RotkfXlDeAeLy5OveUiI64+KfXV2VpL9+J6GoWK/2KY=;
        b=d1Pt7JhwPvyRf74TmPGPsO4/i0uJ6neuB1eFLkfa5Q1JVfVw9fqMj+6Q787cFn2c5M
         iCHCq6CNV9OWjHhQQ4VaeEJLG1ApDARh78cnd/XTnhRHiZ7zu/MpkQl1WaATjvJPLr5J
         LkM++XpizSdIM2B5+vd+IOidKGOrl95ZqtWqYGj8HJmhaWSF+NV6xRhoXKfYD0KR8Fli
         jci3mKHSxblwudQc2uqGePRHaNQ8vKE9vm1G9Fznr113FwgJOo6nCZj0YJIGgZUiROOd
         UymDkhB3ZMki2PrRRiJwADFmBSeYB0WUGWczvWel0Lsdz1kCoNKBKssLdT8xFRq0M5MI
         tAjg==
X-Forwarded-Encrypted: i=1; AJvYcCVnNNPR7iBROog8CmMkcuKEspmIrrDRp4zU89SotC0hjJwz6pe5+UtM9U2VhJpucckgpzTwntszHfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyabA8vYxo8eeEwd/qffodG0wnu0v2fO8AiJKLfsKrXj0mveeK
	9CBUu5f/2vPh5tD0r2wPdhwokadDlaUzYQCsWHLkr9oN8MjIgN2/Nk/v9QTj2azLaa92w84nDu4
	7aLU/S+QuIt/JZoGU7R5XG2EXl3v8wTA=
X-Gm-Gg: AY/fxX5QD+x6JvC3wxEkDN5QGli3Un50Orw6cKmakSurT1cNI1n0euNrkbmMbgbWlgq
	Z/N1bqbtY2JkNI6g1dDHQuVB+PMvmsBQy8jt0W2b8cVKH88JXyDDqIPtpxe58j0ZAjYb3vDJaUK
	LBCdVhCeeN4JGBUAEvUcimFhX2Bpq56UqVFdQdJbSkPKX6HoPkiGy1mx0OM0wfYRzyEk9xwM8H4
	8xzCdRZmoKxuR0HuxRSTxZ4aXhyOs+XDgZiiH4IW3qOeZhUjncgGuX9iwAF8o10xjK1xUfcCLlb
	yGU22LPRJ2WyUZJVywNE1GFmqd2G5PvpXLR3DdUO/KnTqOmwQL6DdPbnIrLFha+ROPHe0u2w9D+
	/fcK7NA==
X-Received: by 2002:a17:907:3cc4:b0:b87:2b1a:3c55 with SMTP id
 a640c23a62f3a-b8792fc438cmr299318466b.39.1768571670823; Fri, 16 Jan 2026
 05:54:30 -0800 (PST)
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
 <zgz6g7pvzijrt77lwdi6q23lgkscm33imcdfbnu7mxvzarygst@ve3wi5l6dv3d> <CAHp75VccDF6QfkZ729qCTQcd5bbnTO2SX+FG8QNPRSC9=LneMg@mail.gmail.com>
In-Reply-To: <CAHp75VccDF6QfkZ729qCTQcd5bbnTO2SX+FG8QNPRSC9=LneMg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Jan 2026 15:53:54 +0200
X-Gm-Features: AZwV_Qhnb5ASdJPz3Ird7Y1KuJggzpYW4SdF5HLUhFubm0H1G0jhHHLVxjuzeXs
Message-ID: <CAHp75VfMFF4-NPtuAENc9YRx7xrhiNAs6x2VoafUJbOzH=_SFQ@mail.gmail.com>
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

On Fri, Jan 16, 2026 at 3:50=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jan 16, 2026 at 1:32=E2=80=AFPM Rodrigo Alencar
> <455.rodrigo.alencar@gmail.com> wrote:
> > On 26/01/13 09:32AM, Rodrigo Alencar wrote:
> > > On 26/01/12 12:57PM, Andy Shevchenko wrote:
> > > > On Mon, Jan 12, 2026 at 09:56:25AM +0000, Rodrigo Alencar wrote:
> > > > > On 26/01/09 08:55PM, Andy Shevchenko wrote:
> > > > > > On Thu, Jan 08, 2026 at 12:14:51PM +0000, Rodrigo Alencar via B=
4 Relay wrote:

...

> > > > > > > +#define ADF41513_MAX_PHASE_MICRORAD          6283185UL
> > > > > >
> > > > > > Basically I'm replying to this just for this line. 180=C2=B0 is=
 PI radians, which is
> > > > > > something like 31415926... Can we use here (2 * 314...) where P=
I is provided in
> > > > > > one of the used form? This will help to grep and replace in cas=
e we will have a
> > > > > > common PI constant defined in the kernel (units.h).
> > > >
> > > > Any comment on this?
> > >
> > > will adjust as suggested.
> >
> > I am finishing putting the V4 together and I decided to leave as is.
> > doing (2 * 314...) might lose precision, by not much (maybe negligible)
> > but it does, as (2 * 3141592) !=3D 6283185.
> > And that it is part of the reasons why PI is already multiplied by a
> > power of 10. I suppose there would be multiple constants defined:
> > - pi in micro radians and nano radians
> > - 2*pi in micro radians and nano radians
>
> The problem is that we will have off-by-one errors in plenty of
> drivers. Depending on the driver the PI may be floor()ed or ceil()ed.
> That's why I think it is best to use 2*PI with the precision you like.
> In this case it can be as simple as
>
> ((2 * 31415926) / 10)
> But you might actually want to have the maximum 32-bit PI, as
> 314159265 for the same reason.

That said, the preferable way for 32-bit arithmetics is to have

((2 * 314159265) / 100)

In this case we can use that PI as a reference in many drivers.

--=20
With Best Regards,
Andy Shevchenko


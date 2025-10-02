Return-Path: <linux-iio+bounces-24644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 993BABB2A9E
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 09:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F94F3203C1
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 07:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557DF2882A6;
	Thu,  2 Oct 2025 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bby2P5dN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7827A454
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759389106; cv=none; b=OdW2m9WYRF4C7bz6CHnF5Ct13zlX0k1XE/PcCwH/CFyVaqtzbXdMWkmxicyNYqIbPsbQGzvJiZVi2nUyzMlXJwEPa7+VtmkPPo5BxBqf+QsFCHRgjp73ec5ih4+6hAPZgCh0+90JLXAXAr+RmTn8Esb4rI+RfZTd2u+cA9idnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759389106; c=relaxed/simple;
	bh=3SkLR+BabbPxgGGt7fReCFr2RJCPvXAQFeGpsqrLBOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gs4oeB5iajSZl0PhJoEZjAnD15mRwfPmaSLV0ng1M2uNzDNZmXczz2I8g7xB9vndx1WoL3NogOyuT45a5TbiWjIPq82d0XBsPKKLoQcLJKDgpCCVVl50Rjz5XmCzQ55QRe9C6COj8hR+npTYlVL4gaB3nmPhOUEzjUe7BoOVd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bby2P5dN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3717780ea70so6936801fa.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 00:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759389101; x=1759993901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7+F3MJCw1zdRhN/EFswQNuWdlErwjej/UIxS2S/iC4=;
        b=Bby2P5dN38iizUhpsAwFl1fQKJqTNIoEluueiB19mNePFCGcZetOpTc3nTeQnYqEx2
         flKdF+ETG+eo54AhS7JWvF3szbM+8t0z7n+aegP7bOEET8SfRe7iRWp+8YUENJ2KrpaW
         h/2wPzpNgOdTDpuVRQxYZz4fz+HO0KiGLNjKOY4yNCRIfN1PB8h7hyXgWgTDwYWDBQy6
         DkXQVkYOfNUbtutBO8+lBVQP2otbMIM2r5qPd3xZ5p4Q6rkK1ufhpEnuc36r7rPG/Bti
         A5tWMAglWD/lXQJyKX61ijjJSjKLB5f7e0GUUQGpvt86qZYWUhD0qbGnu57yvXDxL3Wz
         Xh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759389101; x=1759993901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7+F3MJCw1zdRhN/EFswQNuWdlErwjej/UIxS2S/iC4=;
        b=skBEvmTg6aWjKaj87TLQrsAxJoDSd10vDIcHgDzvQMb6/2w2gP9FKVX6eUCEAV9vx+
         edPWh6iEZWFhN7JBJIbbA66cqaUIC2Cus6IstKRK2vmUK45C+qOMFacd++iRJ9xZr+bf
         Noa+PXOEVJ3ClE36PDsYIIP9jQQq8PiYdR4lGSQ8Q32WNhz57XL8S1mQjrK2x1y9tkkh
         i0I9uuLyCCSLUVArPjhbxMF0lbzWIBiLRmAXgchTh1s/Mc4+iO5lUWapBGk24h0n+pO1
         nvfXaIP8AgMbM8Qa3LiIqyyWxVp+4498sU62pTnBqyVG4+RC/WzfLq06uzTqVF9YZUxU
         BD3A==
X-Forwarded-Encrypted: i=1; AJvYcCWNLpbcKJnEdMSpuq2eAxsl+sZ6UdFJB0R2XfNimsGIm+C86Zkumo2DIqLuX+2uZN9ZTK0tVXoY3Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnUQfNStXNjWJnPL7So5zagJdzj/kiA5iCCdlp9iXYM5kxRm06
	E3EXhbi2SibuPeHuvM/VmTnJGoRieZtDM6v8otoPGuV4XJihhsyjEYgFFtF0cuxh+7cTqLtcGRR
	1pz1d2XzIzbppazjoFB53tKYpf8hJE3m9WUDQ5HLsuw==
X-Gm-Gg: ASbGnctY9X5en4tXg8b9LJX0z7J1IjKaj134werAb8aECo6IMbUIluDmVfMX4xpalXC
	LUp9ljiB6ZI+1vtapDebC8mtIONV5EqavLPltf1SoSzy/ek/mCB5PZ6KKW2BRx6zKIX2KvCbwfE
	C1QP7AiifUtBbuRm2fHsaSYFPoC1LCO30HWGNjbhdKvinksIAbhA3ZVG4tSXzJmyVsA6sCq+wpK
	xyiWcyBEeBqcXrJ+JIblxc1glVPSio=
X-Google-Smtp-Source: AGHT+IFW5Sqq0j8hZYcbkmjNo7v5KP/6QB1gYXNk+QdN7ywZJZD8XGGfmVVaw52M4XwrBItOqUnHQNR3kXoyhMFZ4LA=
X-Received: by 2002:a05:651c:1142:b0:372:9f0c:2154 with SMTP id
 38308e7fff4ca-373a748a7e6mr16649951fa.42.1759389101230; Thu, 02 Oct 2025
 00:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <5331035.LvFx2qVVIh@fw-rgant> <20250927-spoon-yearning-c1a8df796173@spud>
 <5926760.DvuYhMxLoT@fw-rgant> <CAMknhBGOpODxmzU9J9nqGDKGzn6KKFV5Ed3okLvecKtHhNRB9A@mail.gmail.com>
 <20251001-glacial-synthetic-6faa84d6d047@spud>
In-Reply-To: <20251001-glacial-synthetic-6faa84d6d047@spud>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 2 Oct 2025 09:11:30 +0200
X-Gm-Features: AS18NWC22naFCVhN0qxOVgBX0jh3xnNC_HJV963X-Rb8nhwdrLQRrxDqp9KRg3U
Message-ID: <CAMknhBG1W47iiqanQ+GQbETBy_A4zbn9U7ZeXV4dCCkJYqJ97w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] regulator: dt-bindings: Add Linear Technology
 LTM8054 regulator
To: Conor Dooley <conor@kernel.org>
Cc: Romain Gantois <romain.gantois@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:40=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Wed, Oct 01, 2025 at 01:18:51PM +0200, David Lechner wrote:
> > On Wed, Oct 1, 2025 at 9:12=E2=80=AFAM Romain Gantois
> > <romain.gantois@bootlin.com> wrote:
> > >
> > > On Sunday, 28 September 2025 00:31:05 CEST Conor Dooley wrote:
> > > ...
> > > > > >
> > > > > > > +  lltc,fb-voltage-divider:
> > > > > > Why does this property have a ?linear? vendor prefix?
> > > > > > Shouldn't it be adi to match the other property and compatible?
> > > > >
> > > > > This component was originally from Linear Technology, before it w=
as
> > > > > acquired by Analog Devices. The new properties and compatibles ha=
ve the
> > > > > Analog Devices prefix, but the "fb-voltage-divider" property is a=
lready
> > > > > used by the LTC3676 and LTC3589 regulators, so I left the Linear
> > > > > Technology prefix for this one to avoid introducing a new propert=
y just
> > > > > to specify a vendor prefix change.
> > > > >
> > > > > I don't have a strong opinion about this though.
> > > >
> > > > Do they share the same driver?
> > >
> > > They do not. However, they use it in the exact same way, and I would'=
ve
> > > liked to factor out the handling of this property in a future patch. =
This
> > > would also make it easier to handle other types of feedback pin circu=
its
> > > and have a generic binding for "regulators using a feedback pin conne=
cted
> > > to some kind of analog circuit".
> > >
> > > For example:
> > >
> > > Vout----+
> > >         |
> > >         |
> > >        +++
> > >        | |
> > >        | | Rtop
> > >        | |
> > >        +++
> > >         |
> > >         |
> > >  FB ----+
> > >         |
> > >      +--+--+
> > >      |  |  |
> > >      |  |  |CCS
> > >      +--v--+
> > >         |
> > >         |
> > >        -+-
> > >         -
> > >
> > > This is all speculation at this point though, so I don't mind changin=
g the
> > > property to "adi,fb-voltage-divider" and handling the different compa=
tibles
> > > when it comes to it.
> > >
> >
> > Could we just make it `fb-voltage-divider-ohms`? The -ohms suffix
> > makes it match the standard property-units suffix which already has
> > the uint32-array type. There are a couple of bindings that have
> > `vout-voltage-divider` without a vendor prefix, so it sounds like this
> > pattern is considered somewhat of a standard property already. But I
> > think it would be better with the -ohms suffix. For example, there is
> > already `gw,voltage-divider-ohms` as well. But there are so many
> > similar properties without the suffix, it is kind of the defacto
> > standard already, so might be better to stick with that rather than
> > making it even more different variants than there already are.
>
> Ye, by all means standardise it. I suppose that means insertion into
> regulator.yaml, which usually also means a regulator- prefix - unless
> you're eyeing something wider than that?

Yes, there are also hwmon and iio bindings that are already already
using variations of ([a-z]+,)?(([a-x]+-)voltage-divider(-ohms)?.
Although `fb-voltage-divider` specifically seems to only be common for
regulators, so could make sense to just have
`regulator-fb-voltage-divider-ohms`.


Return-Path: <linux-iio+bounces-15510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C57A356E7
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 07:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8740F7A5CC6
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 06:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7EB1FFC4E;
	Fri, 14 Feb 2025 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MptpSou7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642AA149C64;
	Fri, 14 Feb 2025 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513753; cv=none; b=OzVOFvqNkjnnzwY62YrUCsnO8NhpyA6gMbiwFrjjUQLwOGitQug2AM9lGDza7YcE1pG9IhGsfar2GAZ5zWe5uCZyKyZZBQ/rIeCqMETTXvU/HjbasWt2ja7YDc+vhfsNt98pSff5NHFHnyOw26zSEMlULnX7VeYLwgYFI8UwKso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513753; c=relaxed/simple;
	bh=aM14EfTf7kxGF6E6MWp7m7oiNKQeF7djPzQHqGzU97I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=At6dsh/iNoBKXSD2ElnaYm01d1H0z6kBkxFIVfR3is4FvCekAWGskiSx4POGjwjy2fM68/OPwuU5NdjKiuwU4ALwi41EOlbwdtlan44CuDyTtXwF8NVD7vKB8eFu5SeBsbltnyS8SClgyiAe/onWQJRm15t+SXTaJ6SXArlw0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MptpSou7; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f1e8efef5so877644f8f.1;
        Thu, 13 Feb 2025 22:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739513749; x=1740118549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhnYXc5eLU/qb2LmGA7DVYyAfoe6L2fU4LUv/RW7nLY=;
        b=MptpSou7BpvLsUzPvkDuJEAqq/mf3iAPNjUXk0ACnGYsX50iOSxtQAxU8PgEkfqzYR
         Wb4fI+N7rEPw/prtAdWjttGLc5o949nErteAWBUB35wGwu1oYfSmUA927uv0rhPqXQPf
         VPc081l0jXLgviflhpt/G3005W7f5zi9j+RLRzGelT44Fq6Lng1C6GHaKPH3EGf0VC00
         z6HW4IwZvREXXn2J99HEoSb66yQwqp8B/TtfK2QL306yYgdFXU05X9o/c941sNWN400U
         Hcogy0aSNj/j8uYYkIr1rulFkkfnKt0+Xim1AxGJMSCfRU+Z2Ew31qdFbFDm9AFLMFyC
         b2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739513749; x=1740118549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhnYXc5eLU/qb2LmGA7DVYyAfoe6L2fU4LUv/RW7nLY=;
        b=E3s/TQ00v0umQ2mVZEUmqw1d8P5kykYekXMtrMjPxL/a5DiA8GV2Dk5ycoMH6wImRc
         4oAVT/ZrMlUHdDNFCDE67nBSi+ztOYNmKPIiDHk6vrQPRDkIIJ2TewTwh2bXTpWsHmM/
         b3pbe7syEjnjfqhvrupR2gHQf5mHPQ+oVNuzZpXvHZHdmzMman700cwzhmO9+vUduLLD
         9S8BP6v3155Y0OmGgMP0bjERdi70Iw43nSsSWcOwWZwTv/OQudULlRCEQeWjNC69kLhJ
         62TAaiWZSVqyMzZ3kzLusH0O5519Ohv2FSaHewsy5ezOGF3Tzg2j0UuNrKbvcaehgNKZ
         BAJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAeFXILJkO+xM4Bxc/j3pv7Sx9p6/RXsuAYzk8Q8JEajN4kH/iHLUw9m/II7ATOd6ouGkdD5tz1BtX@vger.kernel.org, AJvYcCW9dOmNvkrtfskaXuflkJ4BFh9u/WoWM8uaniovPFX/6ZdDucchkIS3Y4rmAAYlFm4CszRcGd5m635i@vger.kernel.org, AJvYcCWUgEdxq08xG6+8aDvneeYRLUJJwHrNqTnKf+2mMoU454Cmin55WJLbJ0AnZZb/zqBHFe8PgLvasd8fggML@vger.kernel.org, AJvYcCWaOn9rersQRJ7QO5+Zb9k+S2a/xfbA5lISD/2UDsD9ZDhrB67B80U3JF3fJtoqupnto15Ypf5QVlhlUA==@vger.kernel.org, AJvYcCXVQTs/MY2BdqJZ3QEvRQc1smfYCv0hVkWg/BjU/Q/sGeTH6mFjt1mzzFr62WR7sX2+DB4HeAl0jhlj5bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXAl/6RLI4oKcoZPn1r5sNe9pzYZQ5FXqLh9UToQATAbcn35Yj
	U5HBLash4GNqQWsUsffAL7WKcjQvrjzXKuYU7NAWYrK2AOlj5RwoUv7V87Yn54CEOLrjZod+Apx
	GL1oI0ev840iCWY3XFE00vFdjOyk=
X-Gm-Gg: ASbGncvtsi+E7GrV85P8UumbjyjDRU/GIk8Y9F+Wj3613hm+37x+QqeADh5YRC+PCJK
	xHgbZg9SrDMpQhgj2uDcGZLXO1MsXH5asivwvzv1kARzkdtTEdvYRCiPdday++VSukXIyAEpDBQ
	==
X-Google-Smtp-Source: AGHT+IEheasLNiOFDe5gQUVHdJ2tXdveZ64cTF1VIIUAvU9iciSBae2zDTq5NTHytPqUSQySTKC3ggW2wMA/FnoTyEQ=
X-Received: by 2002:a5d:6484:0:b0:38d:a879:4778 with SMTP id
 ffacd0b85a97d-38f24505651mr8245160f8f.33.1739513747960; Thu, 13 Feb 2025
 22:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212075845.11338-1-clamor95@gmail.com> <20250212075845.11338-2-clamor95@gmail.com>
 <Z65k-fi78DnKVN1K@aspen.lan>
In-Reply-To: <Z65k-fi78DnKVN1K@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 14 Feb 2025 08:15:36 +0200
X-Gm-Features: AWEUYZkYeN4e2_mTmoivB54FQVa-QU7otnFSUN4kc54MQBDIFepRTqtzY9BzDCE
Message-ID: <CAPVz0n2p2OS=nhBY13huPEew0XjReH+LF+zxLMAXLWo0kU-jSA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: mfd: Document TI LM3533 MFD
To: Daniel Thompson <daniel@riscstar.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 13 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 23:32 Dani=
el Thompson <daniel@riscstar.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 12, 2025 at 09:58:41AM +0200, Svyatoslav Ryhel wrote:
> > Add bindings for the LM3533 - a complete power source for
> > backlight, keypad, and indicator LEDs in smartphone handsets.
> > The high-voltage inductive boost converter provides the
> > power for two series LED strings display backlight and keypad
> > functions.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../devicetree/bindings/mfd/ti,lm3533.yaml    | 221 ++++++++++++++++++
> >  include/dt-bindings/mfd/lm3533.h              |  19 ++
> >  2 files changed, 240 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lm3533.yam=
l
> >  create mode 100644 include/dt-bindings/mfd/lm3533.h
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml b/Doc=
umentation/devicetree/bindings/mfd/ti,lm3533.yaml
> > new file mode 100644
> > index 000000000000..d0307e5894f8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
> > @@ -0,0 +1,221 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/ti,lm3533.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI LM3533 Complete Lighting Power Solution
> > +
> > +description: |
> > +  The LM3533 is a complete power source for backlight,
> > +  keypad, and indicator LEDs in smartphone handsets. The
> > +  high-voltage inductive boost converter provides the
> > +  power for two series LED strings display backlight and
> > +  keypad functions.
> > +  https://www.ti.com/product/LM3533
> > +
> > +maintainers:
> > +  - Johan Hovold <jhovold@gmail.com>
>
> This looks like it has been copied from the lm3533 driver. Did Johan
> agree to this?
>

Thank you for pointing this out, maintainers field should have been
amended with my name. It seems that this slipped from me on
submitting. I initially though that maintainers should contain driver
author hence set Johan, but that is obviously not correct.

>
> Daniel.


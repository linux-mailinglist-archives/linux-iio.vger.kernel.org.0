Return-Path: <linux-iio+bounces-13888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1286A01465
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 13:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DF13A421F
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 12:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3195F191F89;
	Sat,  4 Jan 2025 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDuUq0xt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9E25949A;
	Sat,  4 Jan 2025 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995083; cv=none; b=tP9/dAjrFm+4L6H8oloxTUol3XjGsUBDYaglHyAb5ZiW4AmcSX5ZVhdej6WSplVHfy6oS25G7drgR9J/FYQC/V6E89r3K3RaLx/G5HyTVKOtGMeTZnHNGE34K6aci/Md4ULz7COTWsNeg1f5UWjQU6xawlF3HcuELlqMDqr4H2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995083; c=relaxed/simple;
	bh=2NHW2tkcj66mZ9wLxIDG9bC0GdSz+XsnxV+G+613WGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2gF8Cw6jlVNXZL9TH4zyFJxVNVPz3XvH50NASgEKz9UFSkSOpy5QdJ2sRYL5IcxAKA2p0achv3mUAVtkXNT+d1OXr8Z3OjwgPBQUvZTVSkPY+XeO5dnokDLxF406vCPjdyqmg3rCXmbrfvy6PVbZuy5NHXelmAlx/jzu3OpqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDuUq0xt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7C1C4CED1;
	Sat,  4 Jan 2025 12:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735995082;
	bh=2NHW2tkcj66mZ9wLxIDG9bC0GdSz+XsnxV+G+613WGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tDuUq0xtSv16JFm9ufuCqepNxoRVuYll2ztJm4twIeJsPAbJ6zo3ZaSfUEUk7UvAe
	 v27aiQ0uvYeL3+ZKMNhSfok8r8W7ZHnowat/v0Yasti85GbbqzyBjIr6wHmBZ8vw1t
	 AFta9ihqvJGsrWHvFQEvqb+JJhgWMN14csXeLLmNdYI1LrikFggHlQICZLf5II/B0q
	 E/zNGQJTFsTr91qPGhU2ZFT1yVeWr031QcE2Bnw6GXc7CPj1cISRNlUk+ZxCfPcoQg
	 VGA6KzJxayppQPIEHDxieGV7GJkPEJ86vOmNNmFY5YStPxwbel/VaH+ybfd3UYNkIz
	 BC48uzkXuqZtQ==
Date: Sat, 4 Jan 2025 12:51:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v8 7/7] iio: accel: adxl345: complete the list of
 defines
Message-ID: <20250104125113.51e1e06a@jic23-huawei>
In-Reply-To: <CAFXKEHb8vMs_en6_iBUG37YyWn90xn8xnz2yrRMB=4rues7BuA@mail.gmail.com>
References: <20241225181338.69672-1-l.rubusch@gmail.com>
	<20241225181338.69672-8-l.rubusch@gmail.com>
	<20241228144714.2c1db6a8@jic23-huawei>
	<CAFXKEHb8vMs_en6_iBUG37YyWn90xn8xnz2yrRMB=4rues7BuA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Dec 2024 16:48:11 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sat, Dec 28, 2024 at 3:47=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Wed, 25 Dec 2024 18:13:38 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Having interrupts events and FIFO available allows to evaluate the
> > > sensor events. Cover the list of interrupt based sensor events. Keep
> > > them in the header file for readability.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> >
> > One comment inline
> >
> > Thanks,
> >
> > Jonathan
> > =20
> > >  #define ADXL345_REG_BW_RATE          0x2C
> > >  #define ADXL345_REG_POWER_CTL                0x2D
> > >  #define ADXL345_REG_INT_ENABLE               0x2E
> > > @@ -34,20 +59,40 @@
> > >  #define ADXL345_FIFO_CTL_MODE(x)     FIELD_PREP(GENMASK(7, 6), x)
> > >
> > >  #define ADXL345_INT_DATA_READY               BIT(7)
> > > +#define ADXL345_INT_SINGLE_TAP               BIT(6)
> > > +#define ADXL345_INT_DOUBLE_TAP               BIT(5)
> > > +#define ADXL345_INT_ACTIVITY         BIT(4)
> > > +#define ADXL345_INT_INACTIVITY               BIT(3)
> > > +#define ADXL345_INT_FREE_FALL                BIT(2)
> > >  #define ADXL345_INT_WATERMARK                BIT(1)
> > >  #define ADXL345_INT_OVERRUN          BIT(0)
> > > +
> > > +#define ADXL345_S_TAP_MSK    ADXL345_INT_SINGLE_TAP
> > > +#define ADXL345_D_TAP_MSK    ADXL345_INT_DOUBLE_TAP =20
> >
> > Why have these?
> > =20
>=20
> To be honest, I'm unsure to keep this patch within this series now.
>=20
> Initially, ..... long story short, having FIFO and interrupt handling
> now, it is possible to apply and use those ADXL345_INT_ constants. On
> the other side, having this more and more separated out of other
> patches, it becomes clear there is still some implementation pending
> to really use them. I'd like to focus this series rather on FIFO and
> interrupt mechanism.
>=20
> Especially when it comes to the ADXL345_S_TAP_MSK defines, which
> probably make even less sense here, if I look at it now.
>=20
> What would you recommend - Keep it? Drop it? Add just the ADXL345_INT_
> fields w/o the _MSKs?

I don't mind that much either way so I'll go with what ever you did in
v9 (not looked yet :)

Jonathan

>=20
> >
> > =20



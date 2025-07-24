Return-Path: <linux-iio+bounces-21978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C93FB10BC7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2830A1CC1E16
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAA42D9EDA;
	Thu, 24 Jul 2025 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjDZiVKc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674512D641C;
	Thu, 24 Jul 2025 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364619; cv=none; b=uIt6NFFsSmLzAwv8kV1+c+lhgn/km4Mt8W0GcNvJC1uxw64evQXfpUvGw8/Q1s4skOPGzBWJ0AKBFgKPsFkqjSC4aXJtuns2LE7y637zn5zy1Kwp20xj6xS1880ACMlb2ABhOY29yarHVy2v+dnSwycvdwdO3z6VDXZ0F39TsyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364619; c=relaxed/simple;
	bh=jvwuOcs0F4iieHp4m7+/mC0b/s00ATTuLTWGg5HsYyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obkxERNCbKX06Lms2/LCOCEF24GKrLDnOZ1sgpuyZjPcPQRXh8TwBpH03N5RgHxGkGMh+buGIrO/YrEGW5IRxjWH7nDiZVFlF6qXFGNKrRnk8yjtdH2bUK6zvHFu1ix4pQf1Xhy1szH4izjsU7XvXKPW4HPFTzeorYHExjv7D0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjDZiVKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E438C4CEF5;
	Thu, 24 Jul 2025 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753364618;
	bh=jvwuOcs0F4iieHp4m7+/mC0b/s00ATTuLTWGg5HsYyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VjDZiVKcNXereyNCOWtIsCA1qtfpstNZdwT8mA7NJTD1eWJPWCHrxDUSltUdv7oH7
	 FDTgLPZWoc+540maw3vaZ4qmz70BAnbidsMxAxz/Vf1uQZnARsGnU1qeCt94U7NZ2e
	 VZxdK1dA/DSmgLtbZdLYuHtKVX1T9tv/jNr7a+diYBe7hJjELauxR4Jr0MTGbl8D9t
	 ja5zmCmbLTmWqkBnvACyJZ9GZpXnBVmJhPGcVdbKGjHcsEdOOrEwgXroxpJWgDGM1m
	 MPS3faerY/sT2fcflz1ogBntJFYL5Cz/UbpGy71Z8a23ASndFV0zenu7cwsd4loghj
	 PJJToqgdJAYNg==
Date: Thu, 24 Jul 2025 14:43:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v11 3/8] iio: accel: adxl345: add activity event feature
Message-ID: <20250724144331.25f64e47@jic23-huawei>
In-Reply-To: <CAFXKEHY61+OqwpOUJau+9afn3C6dya6AkAjfmrf+F=2bnFE-vQ@mail.gmail.com>
References: <20250702230315.19297-1-l.rubusch@gmail.com>
	<20250702230315.19297-4-l.rubusch@gmail.com>
	<aGaSkQHQKCqfrVXF@smile.fi.intel.com>
	<20250706170916.17417514@jic23-huawei>
	<CAFXKEHY61+OqwpOUJau+9afn3C6dya6AkAjfmrf+F=2bnFE-vQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Jul 2025 20:36:09 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi, I appologize for late replying on this topic.
>=20
> On Sun, Jul 6, 2025 at 6:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Thu, 3 Jul 2025 17:24:17 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > =20
> > > On Wed, Jul 02, 2025 at 11:03:10PM +0000, Lothar Rubusch wrote: =20
> > > > Enable the sensor to detect activity and trigger interrupts accordi=
ngly.
> > > > Activity events are determined based on a threshold, which is initi=
alized
> > > > to a sensible default during probe. This default value is adopted f=
rom the
> > > > legacy ADXL345 input driver to maintain consistent behavior.
> > > >
> > > > The combination of activity detection, ODR configuration, and range
> > > > settings lays the groundwork for the activity/inactivity hysteresis
> > > > mechanism, which will be implemented in a subsequent patch. As such,
> > > > portions of this patch prepare switch-case structures to support th=
ose
> > > > upcoming changes. =20
> > > =20
> > > >  #define ADXL345_REG_TAP_AXIS_MSK   GENMASK(2, 0)
> > > >  #define ADXL345_REG_TAP_SUPPRESS_MSK       BIT(3)
> > > >  #define ADXL345_REG_TAP_SUPPRESS   BIT(3)
> > > > +#define ADXL345_REG_ACT_AXIS_MSK   GENMASK(6, 4)
> > > >
> > > >  #define ADXL345_TAP_Z_EN           BIT(0)
> > > >  #define ADXL345_TAP_Y_EN           BIT(1)
> > > >  #define ADXL345_TAP_X_EN           BIT(2)
> > > >
> > > > +#define ADXL345_ACT_Z_EN           BIT(4)
> > > > +#define ADXL345_ACT_Y_EN           BIT(5)
> > > > +#define ADXL345_ACT_X_EN           BIT(6)
> > > > +#define ADXL345_ACT_XYZ_EN         (ADXL345_ACT_Z_EN | ADXL345_ACT=
_Y_EN | ADXL345_ACT_X_EN) =20
> > >
> > > I'm trying to understand the logic behind the placement of the masks =
and bits.
> > > To me it sounds that the above should be rather
> > >
> > > #define ADXL345_REG_TAP_AXIS_MSK      GENMASK(2, 0)
> > > #define ADXL345_TAP_Z_EN              BIT(0)
> > > #define ADXL345_TAP_Y_EN              BIT(1)
> > > #define ADXL345_TAP_X_EN              BIT(2)
> > > #define ADXL345_REG_TAP_SUPPRESS_MSK  BIT(3) // Do we need this at al=
l?
> > > #define ADXL345_REG_TAP_SUPPRESS      BIT(3) // or actually this? One=
 is enough, no?
> > > #define ADXL345_REG_ACT_AXIS_MSK      GENMASK(6, 4)
> > > #define ADXL345_ACT_Z_EN              BIT(4)
> > > #define ADXL345_ACT_Y_EN              BIT(5)
> > > #define ADXL345_ACT_X_EN              BIT(6)
> > > #define ADXL345_ACT_XYZ_EN            (ADXL345_ACT_Z_EN | ADXL345_ACT=
_Y_EN | ADXL345_ACT_X_EN)
> > >
> > > (Yes, I know that the mess is preexisted, but try to keep some order =
in the
> > >  pieces you add here.) =20
> >
> > FWIW I fully agree on keeping field definitions and field break up toge=
ther.
> >
> > The ACT_MSK is a little odd as thing as then we'd expect there to be bi=
ts
> > within that. So that FIELD_GET(a, ADXL345_REG_ACT_AXIS_MSK) would return
> > a value from a list of things like
> > ADXL345_REG_ACT_AXIS_VALUE_A and similar.
> >
> > So I'd not define that as a mask a tall but just use the
> > ACT_XYZ_EN for it as then it's clear you are checking for any of the
> > 3 bits being set.
> > =20
>=20
> The reason is that ADXL345_REG_ACT_AXIS_MSK is used in the evaluation
> of the incoming interrupt status register for "activity" events, and
> ADXL345_ACT_XYZ_EN is supposed to group the enabled axis, when
> enabling the sensor feature "activity" in the enable register. At the
> end of the day, using only one of them would work for both, but
> there's a semantic difference.
>=20
> Given this explanation, would you prefer to see a separate
> ADXL345_REG_ACT_AXIS_MSK and ADXL345_ACT_XYZ_EN as presented here, or
> just one ADXL345_ACT_XYZ_EN covering both cases, i.e. the evaluation
> of the interrupt status, and enabling activity axis?

I think just using the XYZ_EN is clear enough as we are checking for
'any of' those.

>=20
> > Jonathan
> > =20
> ...
> Best,
> L



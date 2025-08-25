Return-Path: <linux-iio+bounces-23197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA6AB33BCA
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA555188ECB2
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE882D323E;
	Mon, 25 Aug 2025 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xqpn8E+1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E52D0C70;
	Mon, 25 Aug 2025 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115442; cv=none; b=h16eq2qtfnqcQSoa2xQAkabOT6bD0t8Q+aD9FUV7bSprljT3LduumFFZ4wvVIJIalAAlt2C3jIosIOkX5bqfJEhLgW6tTOWtHtbdR4jxqbQkdRlNnvJjmw8L6JYRDIZYFslCIe84Iu3/Mvvnm6D1/5pueGHKiCl9r4fFW4nX3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115442; c=relaxed/simple;
	bh=oAksL10rM01RKP2Fo0u19qLEi3x+WBMWJDe8YJJTSnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGzs2T/z+q7XouI4CS9jmsP+6qnkiWP10zdtPnLcrppRpXQ0oHRmSTYKZ3R8v/bS6BD7XhwtgDzfzSzC+7FwL1sXWyFbav44k9DkXoGxw00VUIghSiZoANg3b8syXTEiRA6WpuYEXX45Ge2RZ553NQ3YqExyOOg1JgTBAULiO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xqpn8E+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16740C116D0;
	Mon, 25 Aug 2025 09:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756115442;
	bh=oAksL10rM01RKP2Fo0u19qLEi3x+WBMWJDe8YJJTSnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xqpn8E+1S2afLNXlLn5zwHcK6KnD0fTTQUUhim6rkOBsLkhPoOdtY02VLlPzD6dhr
	 G2MwbupF74Tw8/Jx8j/HW0qQ6mDPkWKoGJpIaOlYshYHo2pU+ZCeURNTAm5Nd3yskB
	 EBfob3LYl2omOXUbKv1JACF9ZEZNiL8hYAPlFX1N2+bbXkKK7HkLNqdiLWJl7h+woW
	 o8Lk5NZE0FEZ8mYN5kBdKbd0B6rNEwf2/+5A9dNjqjZF2NFbFnetHdm4R135lEK7gM
	 Qsz7QHmHnX6momPklW9VBGlo0h7Por8QlUWjPgV0A1GnBh8S+Ndojq2iWlY4NFn9WV
	 9UJ/6V1OhUrsw==
Date: Mon, 25 Aug 2025 10:50:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <20250825105032.45f33b12@jic23-huawei>
In-Reply-To: <CAFmh=S0gAB93Gqnrt9NdtLA=cjOcYwy6+ECnwH-j9sN_sZYjZw@mail.gmail.com>
References: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
	<20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
	<aKXW5pGiN18DyIZ7@smile.fi.intel.com>
	<aKaMPMnGRyvKqTny@dixit>
	<CAHp75Vdw5X1Y057fpGjdvVGwKq0x0UBdm8py+m+55RbzXi1PJw@mail.gmail.com>
	<aKfYlP-yWdQi34db@dixit>
	<CAFmh=S0gAB93Gqnrt9NdtLA=cjOcYwy6+ECnwH-j9sN_sZYjZw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Aug 2025 08:33:07 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> On Fri, Aug 22, 2025 at 8:10=E2=80=AFAM Dixit Parmar <dixitparmar19@gmail=
.com> wrote:
> >
> > On Thu, Aug 21, 2025 at 10:41:03AM +0300, Andy Shevchenko wrote: =20
> > > On Thu, Aug 21, 2025 at 6:02=E2=80=AFAM Dixit Parmar <dixitparmar19@g=
mail.com> wrote: =20
> > > > On Wed, Aug 20, 2025 at 05:08:38PM +0300, Andy Shevchenko wrote: =20
> > >
> > > ...
> > > =20
> > > > > >  st_magn-$(CONFIG_IIO_BUFFER) +=3D st_magn_buffer.o
> > > > > >  obj-$(CONFIG_IIO_ST_MAGN_I2C_3AXIS) +=3D st_magn_i2c.o
> > > > > >  obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) +=3D st_magn_spi.o
> > > > > >
> > > > > > +obj-$(CONFIG_INFINEON_TLV493D)             +=3D tlv493d.o
> > > > > > +
> > > > > >  obj-$(CONFIG_SENSORS_HMC5843)              +=3D hmc5843_core.o
> > > > > >  obj-$(CONFIG_SENSORS_HMC5843_I2C)  +=3D hmc5843_i2c.o
> > > > > >  obj-$(CONFIG_SENSORS_HMC5843_SPI)  +=3D hmc5843_spi.o =20
> > > > >
> > > > > I haven't got the ordering rules here and in Kconfig. Can it be a=
lphabetical? =20
> > > > From what I can see, the order is alphabetical based on the CONFIG =
option in the
> > > > Makefile and Kconfig, and I kept CONFIG_INFINEO_TLV493D after CONFI=
G_IIO_ST*.
> > > > Isn't it in correct order? or my understanding is incorrect? =20
> > >
> > > I dunno, The file name there is with the vendor prefix, in many cases
> > > the configuration option is with vendor prefix as well, but the file.=
 =20
> > Hi Jonathan, Can you please suggest best possible way here? =20
> Hi Jonathan, When you get a chance, please share your thoughts on this.

No hard rules on this.  We should probably make some but don't have
them yet, so try to go with what seems most common in the particular file.

Jonathan


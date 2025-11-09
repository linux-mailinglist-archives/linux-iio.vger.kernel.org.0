Return-Path: <linux-iio+bounces-26079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 046A9C441A7
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 16:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E09014E1E24
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7AE2FF16B;
	Sun,  9 Nov 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVmBsd9z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABA820013A;
	Sun,  9 Nov 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762703745; cv=none; b=nONkYgs9kWIALaWg8eGOEsn6LYKiNQ1jA/E3bs2rz+bHoNfmkG4Xv6MjuXKJuFdMeGzH2bziAnEbf2MQzemtNb9ce5c1QRLNB24QfCbAnMMV0BWvMv1gsv28yhe+i+HI/MdyYT4cLGF2gj0tLP2qMu11tZsZeVHE1ro0xrZe2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762703745; c=relaxed/simple;
	bh=2g81BxaE7u5hZ1JwZXDl6KMBhsWN4WmtYf0TiaN8XKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uf+6Qz3ikhauL3nzE/O2gdNf3wAfPNX/SGO+CwhzQ1XgidRwLNPWSWu6sTJDMuYPn1bCse6GGUkW7gwjnHr5Fx69ljul8cq+CCULFhOmG8rA6aGPL7uCxVYRKMQ9SyEEPKNaWQP3QUcnSY7ARXDAsRiapEQXYFvKjbLhpESquhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVmBsd9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE00C4CEFB;
	Sun,  9 Nov 2025 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762703744;
	bh=2g81BxaE7u5hZ1JwZXDl6KMBhsWN4WmtYf0TiaN8XKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DVmBsd9zzMpiYdL9ryEfdTrl7y9ztOoSZCWalooDMVABDmIiew9TgDtKQa1iAZJzu
	 Z9jiPhdv/fXMKQXMod23QNj8NhEyzI3jh6oTj8z/XS5apPijPypsCegCd0pt2vCdUw
	 W+4CZ3a3cINJ0+yCyAObgN/3Eo4sf1BRWeTFT0qTkH2BguLE2wIafRHeFxsfyhWQwQ
	 NlCKchIYaRYaOfJekmWSZhBtHEJEW9ucPeP93xZ1z9W3B/VbCxPBzbuI5Dx3J+pYOT
	 Wco/YOCASli9EhrgwKXwUhVAlfwZsY+0Yluq7LeqxjS4ULBmJeWJnaBuObwBkFoKPe
	 JDqHPqy8Exgww==
Date: Sun, 9 Nov 2025 15:55:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 07/12] iio: dac: ad5446: Separate I2C/SPI into
 different drivers
Message-ID: <20251109155538.51f890de@jic23-huawei>
In-Reply-To: <aQpD7zx7D6sQOAdC@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-7-6fe35458bf8c@analog.com>
	<aQpD7zx7D6sQOAdC@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Nov 2025 20:20:31 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Nov 04, 2025 at 03:35:12PM +0000, Nuno S=C3=A1 via B4 Relay wrote:
> >=20
> > Properly separate the I2C and SPI drivers into two different drivers
> > living in their own source file (as usual). So that no need for the
> > hacky ifdefery. =20
>=20
> ...
>=20
> > +#include <linux/iio/iio.h>
> > +#include <linux/mutex.h>
> > +#include <linux/types.h>
> > +
> > +struct device;
> > +
> > +extern const struct iio_chan_spec_ext_info ad5446_ext_info_powerdown[];
> > +
> > +#define _AD5446_CHANNEL(bits, storage, _shift, ext) { \
> > +	.type =3D IIO_VOLTAGE, \
> > +	.indexed =3D 1, \
> > +	.output =3D 1, \ =20
>=20
> > +	.channel =3D 0, \ =20
>=20
> Unneeded.
Even though it is indeed not strictly needed:
As it's indexed I'd normally suggest we keep this as explicitly
set.  There isn't an obvious default for a channel number.
>=20
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> > +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
> > +	.scan_type =3D { \
> > +		.sign =3D 'u', \
> > +		.realbits =3D (bits), \
> > +		.storagebits =3D (storage), \
> > +		.shift =3D (_shift), \
> > +		}, \
> > +	.ext_info =3D (ext), \
> > +}
> > +
> > +#define AD5446_CHANNEL(bits, storage, shift) \
> > +	_AD5446_CHANNEL(bits, storage, shift, NULL)
> > +#define AD5446_CHANNEL_POWERDOWN(bits, storage, shift) \
> > +	_AD5446_CHANNEL(bits, storage, shift, ad5446_ext_info_powerdown)
> > +
> > +/**
> > + * struct ad5446_state - driver instance specific data
> > + * @dev:		this device
> > + * @chip_info:		chip model specific constants, available modes etc
> > + * @vref_mv:		actual reference voltage used
> > + * @cached_val:		store/retrieve values during power down
> > + * @pwr_down_mode:	power down mode (1k, 100k or tristate)
> > + * @pwr_down:		true if the device is in power down
> > + * @lock:		lock to protect the data buffer during write ops
> > + */
> > +struct ad5446_state {
> > +	struct device *dev;
> > +	const struct ad5446_chip_info *chip_info;
> > +	unsigned short vref_mv; =20
>=20
> _mV?
>=20
> > +	unsigned int cached_val;
> > +	unsigned int pwr_down_mode;
> > +	unsigned int pwr_down;
> > +	/* mutex to protect device shared data */
> > +	struct mutex lock;
> > +	union {
> > +		__be16 d16;
> > +		u8 d24[3];
> > +	} __aligned(IIO_DMA_MINALIGN);
> > +};
> > +
> > +/**
> > + * struct ad5446_chip_info - chip specific information
> > + * @channel:		channel spec for the DAC
> > + * @int_vref_mv:	AD5620/40/60: the internal reference voltage
> > + * @write:		chip specific helper function to write to the register
> > + */
> > +struct ad5446_chip_info {
> > +	struct iio_chan_spec channel;
> > +	u16 int_vref_mv; =20
>=20
> _mV?
>=20
> > +	int (*write)(struct ad5446_state *st, unsigned int val);
> > +};
> > +
> > +int ad5446_probe(struct device *dev, const char *name,
> > +		 const struct ad5446_chip_info *chip_info);
> > +
> > +#endif =20
>=20



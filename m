Return-Path: <linux-iio+bounces-21954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5920B108DF
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AFD5A3502
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA226CE29;
	Thu, 24 Jul 2025 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o28ZYiH6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE726E718;
	Thu, 24 Jul 2025 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355754; cv=none; b=GuP+eEJfDMNt2jz5NAGpNkCr1SPbwHKgy1wIT6poj8fc0ciPvW+cAUnbNw+NrpLF1A1/w7HllXtUZYpl4KtiDI/6wD8aV9Md7jGx8YUoJydSHG/sxpLDHpygQ6NhoGrhV9tPVZw/R7hjuqJ2dGWDDbE+rVA8EmyX/XqRObu/7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355754; c=relaxed/simple;
	bh=zBr2yNlBokIwEA35ZNYVLoBZg7VaTR4C4VvEReyNKws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zyf4/VEi6qG4DVonYCDVH98mZfWE3WgjvAeBjBIeQ0acClJ1auJx9Z98tb7cF5pJWQgpNIGeYVaKCZTt0Npjq71OzHXRerE8Phx/xrkY6g5mm92xmnQZbkHOux9P3zUFr6hRG8K4OpPNBY5wN3OdzOBDz/VM/KnRayhRs5DbqR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o28ZYiH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8E8C4CEF5;
	Thu, 24 Jul 2025 11:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753355753;
	bh=zBr2yNlBokIwEA35ZNYVLoBZg7VaTR4C4VvEReyNKws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o28ZYiH6h9/UmrCa66gSdKO63YsLE+95O4uoX+ORxfVGaTX/IW/52exP5W9pOg/8H
	 h5bGR2viYdTKFofuXlaCP+4F1vckV0IRT+shEZEdm/ewd/33btKylz0yxYUHzb2EPr
	 99Ka8eTBHbHAGWC9yNitfzNpj8yCzcLjfDOv+ZOvojtmP/Df2r76G1ANXdcpVHHO2G
	 wpF4Hmp4aCpPrESMcQ7bFZRVIjwS8x5lZo1zhuuN4PUzxNz7Ni92FFlFOWxG/OTdUE
	 9C6zBlZX148qu/Fp23VEtybAODY2aTRE4OLCnRaZuMf08pdAQJzc3dEmWS9PvjCEFP
	 hj4/etc23pYxg==
Date: Thu, 24 Jul 2025 12:15:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matt Ranostay
 <mranostay@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: maxim_thermocouple: use DMA-safe
 buffer for spi_read()
Message-ID: <20250724121546.72d82f80@jic23-huawei>
In-Reply-To: <pj2pzpd33covkhi2ho3nsoazqqqpfeiy6n42fkmada6drpr6bj@2dm4iqxdhotj>
References: <20250721-iio-use-more-iio_declare_buffer_with_ts-3-v2-1-0c68d41ccf6c@baylibre.com>
	<bd5c1587-c830-40e6-90d5-be7fad215cef@baylibre.com>
	<pj2pzpd33covkhi2ho3nsoazqqqpfeiy6n42fkmada6drpr6bj@2dm4iqxdhotj>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2025 10:24:56 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, Jul 21, 2025 at 06:06:39PM -0500, David Lechner wrote:
> > On 7/21/25 6:04 PM, David Lechner wrote: =20
> > > Replace using stack-allocated buffers with a DMA-safe buffer for use
> > > with spi_read(). This allows the driver to be safely used with
> > > DMA-enabled SPI controllers.
> > >=20
> > > The buffer array is also converted to a struct with a union to make t=
he
> > > usage of the memory in the buffer more clear and ensure proper alignm=
ent.
> > >=20
> > > Fixes: 1f25ca11d84a ("iio: temperature: add support for Maxim thermoc=
ouple chips")
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > > Changes in v2:
> > > - This is a new patch since when looking at it again, I noticed a bug
> > >   with passing stack-allocated memory to spi_read(). So now the prima=
ry
> > >   purpose is a fix and converting the array to a struct comes free wi=
th
> > >   it.
> > > - Link to v1: https://lore.kernel.org/r/20250711-iio-use-more-iio_dec=
lare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com
> > > ---
> > >  drivers/iio/temperature/maxim_thermocouple.c | 26 ++++++++++++++++--=
--------
> > >  1 file changed, 16 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/i=
io/temperature/maxim_thermocouple.c
> > > index cae8e84821d7fd521d59432580d51def939fa4d1..fa648a6542a4e2f08adb5=
56c776b68331ae69631 100644
> > > --- a/drivers/iio/temperature/maxim_thermocouple.c
> > > +++ b/drivers/iio/temperature/maxim_thermocouple.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/err.h>
> > >  #include <linux/spi/spi.h>
> > > +#include <linux/types.h>
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/iio/sysfs.h>
> > >  #include <linux/iio/trigger.h>
> > > @@ -121,8 +122,15 @@ struct maxim_thermocouple_data {
> > >  	struct spi_device *spi;
> > >  	const struct maxim_thermocouple_chip *chip;
> > >  	char tc_type;
> > > -
> > > -	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
> > > +	/* Buffer for reading up to 2 hardware channels. */
> > > +	struct {
> > > +		union {
> > > +			__be16 raw16;
> > > +			__be32 raw32;
> > > +			__be16 raw[2];
> > > +		};
> > > +		aligned_s64 timestamp;
> > > +	} buffer __aligned(IIO_DMA_MINALIGN);
> > >  };
> > > =20
> > >  static int maxim_thermocouple_read(struct maxim_thermocouple_data *d=
ata,
> > > @@ -130,18 +138,16 @@ static int maxim_thermocouple_read(struct maxim=
_thermocouple_data *data,
> > >  {
> > >  	unsigned int storage_bytes =3D data->chip->read_size;
> > >  	unsigned int shift =3D chan->scan_type.shift + (chan->address * 8);
> > > -	__be16 buf16;
> > > -	__be32 buf32;
> > >  	int ret;
> > > =20
> > >  	switch (storage_bytes) {
> > >  	case 2:
> > > -		ret =3D spi_read(data->spi, (void *)&buf16, storage_bytes);
> > > -		*val =3D be16_to_cpu(buf16);
> > > +		ret =3D spi_read(data->spi, &data->buffer.raw16, storage_bytes);
> > > +		*val =3D be16_to_cpu(data->buffer.raw16);
> > >  		break;
> > >  	case 4:
> > > -		ret =3D spi_read(data->spi, (void *)&buf32, storage_bytes);
> > > -		*val =3D be32_to_cpu(buf32);
> > > +		ret =3D spi_read(data->spi, &data->buffer.raw32, storage_bytes);
> > > +		*val =3D be32_to_cpu(data->buffer.raw32);
> > >  		break;
> > >  	default:
> > >  		ret =3D -EINVAL;
> > > @@ -166,9 +172,9 @@ static irqreturn_t maxim_thermocouple_trigger_han=
dler(int irq, void *private)
> > >  	struct maxim_thermocouple_data *data =3D iio_priv(indio_dev);
> > >  	int ret;
> > > =20
> > > -	ret =3D spi_read(data->spi, data->buffer, data->chip->read_size);
> > > +	ret =3D spi_read(data->spi, &data->buffer.raw, data->chip->read_siz=
e); =20
> >=20
> > Compile check didn't catch this. Need to drop the &.
> > data->buffer.raw is already an array. =20
>=20
> Neither did I :). I should have looked into this email __before__ (and
> not after) sending my tag. Anyways, consider the tag with the above
> fixed.
>=20
> - Nuno S=C3=A1
>=20
Applied to the fixes-togreg-for-6.17 branch + marked for stable with:
diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/tem=
perature/maxim_thermocouple.c
index fa648a6542a4..205939680fd4 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -172,7 +172,7 @@ static irqreturn_t maxim_thermocouple_trigger_handler(i=
nt irq, void *private)
        struct maxim_thermocouple_data *data =3D iio_priv(indio_dev);
        int ret;
=20
-       ret =3D spi_read(data->spi, &data->buffer.raw, data->chip->read_siz=
e);
+       ret =3D spi_read(data->spi, data->buffer.raw, data->chip->read_size=
);
        if (!ret) {
                iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
                                            sizeof(data->buffer),

Quicker than going around again :)

> >=20
> >  =20
> > >  	if (!ret) {
> > > -		iio_push_to_buffers_with_ts(indio_dev, data->buffer,
> > > +		iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
> > >  					    sizeof(data->buffer),
> > >  					    iio_get_time_ns(indio_dev));
> > >  	}
> > >=20
> > > ---
> > > base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
> > > change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-3-2cc387a=
66bdc
> > >=20
> > > Best regards, =20
> >  =20



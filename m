Return-Path: <linux-iio+bounces-11284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4749B0343
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 14:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661F7281CD8
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AA8206505;
	Fri, 25 Oct 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqTMymUn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0852064FF;
	Fri, 25 Oct 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861166; cv=none; b=rhBs2pendHBWNzEaiMJFrRpvchzIFPxdwn+Kk5HYoGSPbvvtN5VAfnIbaXo28Fx9gtUkb0j47UpBCi4LjZDu3tAHFwQ3/xzr7SC4ribrYHYOnifVjISekIPF8ftdJba1NOmEMgUhrIV4pQ2W96ahRPjgyNJ3uKEdFbfsGc4kjWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861166; c=relaxed/simple;
	bh=hdcfCxsXN5ta8lMkugI2tJMm2SyrMVogUPc8IAR3RTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IMiy3nxR+kZkh4qxnhxuIqnrtIxIwqxL1mxWBPA0n5pyhTsxpQqovf5dJlBkX+H55OFmAggZYn6ItgpTay0VjcvjoE+3mUZXUxmQGH8vOyt7f2oue8tRN4J9q0JlP1NmTThbYwT1gq5pIxT3r45hMb26kzE/nmUdQN+podx2szM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqTMymUn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d49a7207cso1394940f8f.0;
        Fri, 25 Oct 2024 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729861162; x=1730465962; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/dK3DUAuPNtJN++MSCDzSk5rSBh2hkVm1V3fHnM0ADo=;
        b=hqTMymUnn5mJH6Ar+LY7VqE5+shj8ZLrLFoutW5qNCjeLXGbSRNILXOOnsQLjYfnkc
         vaHb1BLP8QJveFuw34K2PkJ7Vq3s3aDv/XA4Bcww14Xq4crDjJ61Pjxf/t7xhHRNakfc
         e6QsPZyDieNtvCJKI5uqQFRqLDFTd0OR9T+fN9hwEyVSZMwjGeYlMmwDdNHMM6GXKFP8
         f6gxcg5bGsKgJ60c3ysf2leHnf2/Cru2PBAHhtQr3bVCyGkdVTNTovIR+RZvKky3Qfa/
         aAdkSgI0I5CEH2YiYhlAHc0V3NUfk/DH6TQODtMe4BftnFasebwvy0bHqkX5lAGoZciD
         S+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729861162; x=1730465962;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dK3DUAuPNtJN++MSCDzSk5rSBh2hkVm1V3fHnM0ADo=;
        b=NwTodfXxJW9RrPUqGLNchLZflo/STrFZEdoGr0siVrL1uZtU89Ay8BDixFASJr1Cz2
         enQ/vEIsfXXN8+gfuosg0NBY1Y1sL3ZPvayKRZ1YJpvDy0NiIxnIysteosNyGkJzRWY3
         ugKIPgBBmkhsov/HmDNhxf5c1KkuJkShE16JUPm8qxp14tUbX8Fg7nLdD4fV37w0dRIk
         2v+8UkC48tVdQSEPF7SX1siEW6MWQM+OyxLA7l1vkKD2c3+tjR3SwjCZNPlBBkp5cQAw
         /qvxAU+ZKKwGuGfnM2N7Ry5ZgItY10iOi9zw18O4z3wgGjCMFm+aU3NULN5CwtQAnn2x
         9AYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6yb04L9W5whUhznTv3OdwYCLdaitLPr+XoNMuwHsBu8Wc2nBAr2RXEzxS3IyX2UdP1Vjcl+v2q6qU@vger.kernel.org, AJvYcCVGxntOFXag3fpHRV5KrzBHNgPh+kw0a5OlzF0JDIKYxRSzrDSRq9C/qGcFttX51aJRWhrTW0A/cClD/nUK@vger.kernel.org, AJvYcCVgwbAXaojsj1Qghf3w1zpON2L0Ha2aYT5O5Ffse30ZlrS5VRoJgyOq3/zlv+y355FeNfniwiQiDrFj@vger.kernel.org, AJvYcCX1kTi2kr2mNCvadh0clVQmWa3/vIYKNaCzz20816oyb69I0NyABuFVpY9l012ex/OWu58/IMEaeMz7@vger.kernel.org, AJvYcCXV2NNWbot1BG1JDhkJ7qQrGinuR1BoApAt7Tid3fCi9eKnEG+85Wy1g1LpOoub7yS61/99bHyDERWJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgxAWPuNOx6i4jutsonTJOYklGQJU+vZbTk00gRMXLIfcb3IE
	oBM6SchuvQpcXsIVpVM1+5Bi+GbQ1Kr/eW/usPkEyVNbtyfRF0Qy
X-Google-Smtp-Source: AGHT+IGBYmPpYKtmXRSaOCQ1RVaiC+G41NQIoM5/5LkjcD3eKW3rDfPb/dkM1T28n78mtrCkDLm6OA==
X-Received: by 2002:a5d:55cc:0:b0:37d:4e80:516 with SMTP id ffacd0b85a97d-37efcf1fe4cmr6269440f8f.34.1729861161844;
        Fri, 25 Oct 2024 05:59:21 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b712cbsm1457071f8f.77.2024.10.25.05.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 05:59:21 -0700 (PDT)
Message-ID: <2cec766bb77ef245f34e213f081b5e27b489aff7.camel@gmail.com>
Subject: Re: [PATCH RFC v4 02/15] spi: add basic support for SPI offloading
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Fri, 25 Oct 2024 14:59:20 +0200
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-2-f8125b99f5a1@baylibre.com>
References: 
	<20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	 <20241023-dlech-mainline-spi-engine-offload-2-v4-2-f8125b99f5a1@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
> Add the basic infrastructure to support SPI offload providers and
> consumers.
>=20
> SPI offloading is a feature that allows the SPI controller to perform
> transfers without any CPU intervention. This is useful, e.g. for
> high-speed data acquisition.
>=20
> SPI controllers with offload support need to implement the get_offload
> callback and can use the devm_spi_offload_alloc() to allocate offload
> instances.
>=20
> SPI peripheral drivers will call devm_spi_offload_get() to get a
> reference to the matching offload instance. This offload instance can
> then be attached to a SPI message to request offloading that message.
>=20
> It is expected that SPI controllers with offload support will check for
> the offload instance in the SPI message in the optimize_message()
> callback and handle it accordingly.
>=20
> CONFIG_SPI_OFFLOAD is intended to be a select-only option. Both
> consumer and provider drivers should `select SPI_OFFLOAD` in their
> Kconfig to ensure that the SPI core is built with offload support.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> v4 changes:
> * SPI offload functions moved to a separate file instead of spi.c
> =C2=A0 (spi.c is already too long).
> * struct spi_offload and devm_spi_offload_get() are back, similar to
> =C2=A0 but improved over v1. This avoids having to pass the function ID
> =C2=A0 string to every function call and re-lookup the offload instance.
> * offload message prepare/unprepare functions are removed. Instead the
> =C2=A0 existing optimize/unoptimize functions should be used. Setting
> =C2=A0 spi_message::offload pointer is used as a flag to differentiate
> =C2=A0 between an offloaded message and a regular message.
>=20
> v3 changes:
> * Minor changes to doc comments.
> * Changed to use phandle array for spi-offloads.
> * Changed id to string to make use of spi-offload-names.
>=20
> v2 changes:
> * This is a rework of "spi: add core support for controllers with offload
> =C2=A0 capabilities" from v1.
> * The spi_offload_get() function that Nuno didn't like is gone. Instead,
> =C2=A0 there is now a mapping callback that uses the new generic devicetr=
ee
> =C2=A0 binding to request resources automatically when a SPI device is pr=
obed.
> * The spi_offload_enable/disable() functions for dealing with hardware
> =C2=A0 triggers are deferred to a separate patch.
> * This leaves adding spi_offload_prepare/unprepare() which have been
> =C2=A0 reworked to be a bit more robust.
> ---
> =C2=A0drivers/spi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 ++
> =C2=A0drivers/spi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/spi/spi-offload.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 104=
 ++++++++++++++++++++++++++++++++++++++++
> =C2=A0include/linux/spi/spi-offload.h |=C2=A0 64 ++++++++++++++++++++++++=
+
> =C2=A0include/linux/spi/spi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 16 +++++++
> =C2=A05 files changed, 188 insertions(+)
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 823797217404..d65074b85f62 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -55,6 +55,9 @@ config SPI_MEM
> =C2=A0	=C2=A0 This extension is meant to simplify interaction with SPI me=
mories
> =C2=A0	=C2=A0 by providing a high-level interface to send memory-like com=
mands.
> =C2=A0
> +config SPI_OFFLOAD
> +	bool
> +
> =C2=A0comment "SPI Master Controller Drivers"
> =C2=A0
> =C2=A0config SPI_AIROHA_SNFI
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index a9b1bc259b68..6a470eb475a2 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -10,6 +10,7 @@ ccflags-$(CONFIG_SPI_DEBUG) :=3D -DDEBUG
> =C2=A0obj-$(CONFIG_SPI_MASTER)		+=3D spi.o
> =C2=A0obj-$(CONFIG_SPI_MEM)			+=3D spi-mem.o
> =C2=A0obj-$(CONFIG_SPI_MUX)			+=3D spi-mux.o
> +obj-$(CONFIG_SPI_OFFLOAD)		+=3D spi-offload.o
> =C2=A0obj-$(CONFIG_SPI_SPIDEV)		+=3D spidev.o
> =C2=A0obj-$(CONFIG_SPI_LOOPBACK_TEST)		+=3D spi-loopback-test.o
> =C2=A0
> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> new file mode 100644
> index 000000000000..c344cbf50bdb
> --- /dev/null
> +++ b/drivers/spi/spi-offload.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Analog Devices Inc.
> + * Copyright (C) 2024 BayLibre, SAS
> + */
> +
> +#define DEFAULT_SYMBOL_NAMESPACE SPI_OFFLOAD
> +
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/spi/spi-offload.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +
> +/**
> + * devm_spi_offload_alloc() - Allocate offload instances
> + * @dev: Device for devm purposes
> + * @num_offloads: Number of offloads to allocate
> + * @priv_size: Size of private data to allocate for each offload
> + *
> + * Offload providers should use this to allocate offload instances.
> + *
> + * Return: Pointer to array of offloads or error on failure.
> + */
> +struct spi_offload *devm_spi_offload_alloc(struct device *dev,
> +					=C2=A0=C2=A0 size_t num_offloads,
> +					=C2=A0=C2=A0 size_t priv_size)
> +{
> +	struct spi_offload *offloads;
> +	void *privs;
> +	size_t i;
> +
> +	offloads =3D devm_kcalloc(dev, num_offloads, sizeof(*offloads) + priv_s=
ize,
> +				GFP_KERNEL);
> +	if (!offloads)
> +		return ERR_PTR(-ENOMEM);
> +
> +	privs =3D (void *)(offloads + num_offloads);
> +
> +	for (i =3D 0; i < num_offloads; i++) {
> +		struct spi_offload *offload =3D offloads + i;
> +		void *priv =3D privs + i * priv_size;
> +
> +		offload->provider_dev =3D dev;
> +		offload->priv =3D priv;
> +	}

Hmm looking at the spi_engine implementation, got me thinking about this. I=
 think
like this we might mess up with natural alignments which can be pretty nast=
y. Maybe
do something like devres [1] (I guess we do not need the flex array though)=
?

Now that I also look at this better, I would not do it like this. I would k=
eep it
simple and just allocate one spi_offload object and be done with it. In the=
 future
and when we actually support more than one instance you could introduce a
devm_spi_offload_alloc_array() variant and I'm still not sure if it's that =
useful.
Anyways this is just personal preference I guess...

[1]: https://elixir.bootlin.com/linux/v6.12-rc4/source/drivers/base/devres.=
c#L35

- Nuno S=C3=A1



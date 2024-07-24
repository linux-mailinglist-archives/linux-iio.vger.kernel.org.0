Return-Path: <linux-iio+bounces-7840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C61793B15B
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 15:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3FD7B21A37
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAA1158DA4;
	Wed, 24 Jul 2024 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHCxDRo5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF312D214;
	Wed, 24 Jul 2024 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826434; cv=none; b=Da3a1YJpDdT67IvMapmSWktamUKfLtErOZe3k+0AAHAYS+jr7wtHT1ygPSWHDNFOdTxE0gkfYcQMi8ASNfXlq91t2U2802//GrFr+GBTTJyHVkC2JjtOTFRYgsoeuao4HCuzyVzhrOjLqKYXF99nw70JEumGgTHKsK35GUr5caY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826434; c=relaxed/simple;
	bh=aZliOTTzEMqUjfvufR+Kg61eexqt1hOKBZi4p58i/Jg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZhI1q6ElBnz77EnEWZTzsd9YCUuG/nCHWGwxj03bcw04SC1bNoa8TfnZtcJvtVm6izyxGmOC48zEobanTlaLH11h+ddVQPSys9jbpAcfJDULoofZ72Flg3WKLhsOcRpfF0YgEcSiB9NTYegYzqKdxtVro5or6WpzDupOkLDUX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHCxDRo5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3685afd0c56so2193602f8f.1;
        Wed, 24 Jul 2024 06:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721826431; x=1722431231; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PpLHG2upNXSlIGlrfb5d7+Efqj6vqHvqV3d48dTu4zk=;
        b=iHCxDRo5sW0gJjC6GNk8sUJHUvX45PsJ+G7aflZNIac17eLMffh8w1TQIG9jeV8BWr
         zG0QPsEEu+mulZ0hzHEDyNqbiAZ3Vs1OgoYNMU8LGDxxzdtwcN+A5W3kWp0hDWlNB793
         jnJi+LXhRz7R60ruRKwXwxZYgTzGaJ9S02DnjeF0ZALbxrmu2nm+9Mqjv1tdSkfDa3Xj
         UOzONXDYGFYTcqnsWN60CmkZW1ESsUFd42+rhw7b1egjMeA1uNpDf3HODMCEHZVRMajP
         wUCgvBp8im6ShKVc5mYpl4W6cFNh7/aQH3hwm2bqO7M167G0tOSnH2/fRx7zrucm5ipt
         yo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721826431; x=1722431231;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PpLHG2upNXSlIGlrfb5d7+Efqj6vqHvqV3d48dTu4zk=;
        b=h1+mGLiLe7/QJ0JQPEemUeA8hhI/O66RzgoZ8OGV2gfNdTaMEHMKyV4MHv/l6qIDuq
         Zezup9EcETk9Ha3EOU/9pVjbh1VF87p9jgkBvM543fALQqnDjeG8ECw9PqYfPzIjurY/
         3NoO/2t23gtp6TGfHVn4+5+nmdbS0Ix2H5LZxesgKbRZwJ0JD7HP2VsEV845tdZNNnzR
         moAhMFI+dt0pbhbNCTTAc1TgAj+T4+Y+YiVZYvcj3jU3GDzObJJ5nqmfS4M6Uk+ohNDe
         BfgHbGUZySicslIA8TwtC4kZMrio5tN9mjWEwLqVWsJorQvQXSkxmRDxHUgn5qG2xe5s
         rQGw==
X-Forwarded-Encrypted: i=1; AJvYcCW127zzNCtm4kbS47ZjUdKXYBQT7csAHGrn4s1GMX8jlQLhkM9Nkj7mhJxLZYW1dv/h7L9yy+WT1rngp1szP+6EbfhUoz2jZ62Y8yJ2iutnndlyGv8NeOjF0fFti0pad2nJEIn27z+gE4rAPN/2fmkO63i1lV6NPTVPA2cxMpxKTvRKWwTFVDWFJgt57DSbcp+IBHMpYe1+1SxxRanCgQ==
X-Gm-Message-State: AOJu0YyjTqhfwtRGYm2HPqLTpNrW+QcOYep6IuyBtDojyA0N7e7zIKUn
	8Yd66hb1Y3ChMaimzceXaTpoLt/W1lIfNdAHtnCnmYTxy3+WgX42NUcAlw==
X-Google-Smtp-Source: AGHT+IHVXxYH4eXMSVLXeQ56KgGLdwyjiEHm6XW8lPtJMf/Rtd3/fo5eok9Egemow+DEO9GgJ7VGfA==
X-Received: by 2002:a5d:6791:0:b0:368:3b1a:8350 with SMTP id ffacd0b85a97d-369f5b2c7ddmr1520211f8f.19.1721826430683;
        Wed, 24 Jul 2024 06:07:10 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787cecb4sm14216261f8f.77.2024.07.24.06.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:07:10 -0700 (PDT)
Message-ID: <4d241cdce41656f990f5f854aef33b3186d20a0a.camel@gmail.com>
Subject: Re: [PATCH RFC v3 6/9] spi: axi-spi-engine: implement offload
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Wed, 24 Jul 2024 15:07:09 +0200
In-Reply-To: <ebfa05e7-2674-4869-bbfd-f0a6cf6b03fa@baylibre.com>
References: 
	<20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
	 <20240722-dlech-mainline-spi-engine-offload-2-v3-6-7420e45df69b@baylibre.com>
	 <5b246e7628ea189be5f8430dac4cffde723b7907.camel@gmail.com>
	 <ebfa05e7-2674-4869-bbfd-f0a6cf6b03fa@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-23 at 09:19 -0500, David Lechner wrote:
> On 7/23/24 3:01 AM, Nuno S=C3=A1 wrote:
> > On Mon, 2024-07-22 at 16:57 -0500, David Lechner wrote:
> > > This implements SPI offload support for the AXI SPI Engine. Currently=
,
> > > the hardware only supports triggering offload transfers with a hardwa=
re
> > > trigger so attempting to use an offload message in the regular SPI
> > > message queue will fail. Also, only allows streaming rx data to an
> > > external sink, so attempts to use a rx_buf in the offload message wil=
l
> > > fail.
> > >=20
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > >=20
> >=20
> > ...
> >=20
> >=20
> > I'm likely missing something but you already have:
> >=20
> > priv =3D &spi_engine->offload_priv[args[0]];
> >=20
> > which seems that from FW you already got the offload index you need. Ca=
n't we
> > just save that index in struct spi_device and use that directly in the =
other
> > operations? Saving the trouble to save the id string and having to alwa=
ys call=20
> > spi_engine_get_offload()?
>=20
> Saving the index in the struct spi_device would assume 1. that all SPI
> peripherals can only use one SPI offload instance and 2. that all SPI
> offload providers have #spi-offload-cells =3D <1> where the cell is the
> index. I don't think either of these are safe assumptions.
>=20

Ok, I see what you mean. I guess I just don't like too much of that *id in =
all over
the place. But we may anyways have to come up with some kind of offload abs=
traction.

> >=20
> > > +
> > >=20
> >=20
> > ...
> >=20
> > > +}
> > > +
> > > +static void spi_engine_offload_unprepare(struct spi_device *spi, con=
st char
> > > *id)
> > > +{
> > > +	struct spi_controller *host =3D spi->controller;
> > > +	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> > > +	struct spi_engine_offload *priv;
> > > +	unsigned int offload_num;
> > > +
> > > +	priv =3D spi_engine_get_offload(spi, id, &offload_num);
> > > +	if (IS_ERR(priv)) {
> > > +		dev_warn(&spi->dev, "failed match offload in unprepare\n");
> > > +		return;
> > > +	}
> > > +
> > > +	writel_relaxed(1, spi_engine->base +
> > > SPI_ENGINE_REG_OFFLOAD_RESET(offload_num));
> > > +	writel_relaxed(0, spi_engine->base +
> > > SPI_ENGINE_REG_OFFLOAD_RESET(offload_num));
> > > +
> > > +	priv->prepared =3D false;
> > > +}
> > > +
> > > +static int spi_engine_hw_trigger_mode_enable(struct spi_device *spi,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 const char *id)
> > > +{
> > > +	struct spi_controller *host =3D spi->controller;
> > > +	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> > > +	struct spi_engine_offload *priv;
> > > +	unsigned int offload_num, reg;
> > > +
> > > +	priv =3D spi_engine_get_offload(spi, id, &offload_num);
> > > +	if (IS_ERR(priv))
> > > +		return PTR_ERR(priv);
> > > +
> > > +	reg =3D readl_relaxed(spi_engine->base +
> > > +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
> > > +	reg |=3D SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
> > > +	writel_relaxed(reg, spi_engine->base +
> > > +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void spi_engine_hw_trigger_mode_disable(struct spi_device *sp=
i,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *id)
> > > +{
> > > +	struct spi_controller *host =3D spi->controller;
> > > +	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> > > +	struct spi_engine_offload *priv;
> > > +	unsigned int offload_num, reg;
> > > +
> > > +	priv =3D spi_engine_get_offload(spi, id, &offload_num);
> > > +	if (IS_ERR(priv)) {
> > > +		dev_warn(&spi->dev, "failed match offload in disable\n");
> > > +		return;
> > > +	}
> > > +
> > > +	reg =3D readl_relaxed(spi_engine->base +
> > > +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
> > > +	reg &=3D ~SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
> > > +	writel_relaxed(reg, spi_engine->base +
> > > +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
> > > +}
> > > +
> >=20
> > I would expect for the enable/disable() operations to act on the trigge=
r. In
> > this case to enable/disable the clock...
>=20
> I'm not opposed to doing that, but things would get more complicated if w=
e
> ever added more trigger types. Because then we would need to add some kin=
d
> of trigger device abstraction to wrap the enable and disable functions of
> the various triggers.
>=20

Yeah, to me is about symmetry... I'm of the opinion that consumers, ideally=
, would
not have to know about the type of the trigger. Just that we have a trigger=
 and then
have an interface for what can we do with it. The one that needs to know ab=
out the
type is the controller driver proving offload capabilities. I guess we can =
have one
DT cell to specify the type of the trigger.

> It seems simpler to me to have the peripheral driver do it since it alrea=
dy
> needs to get the clock device for other reasons anyway.
>=20
> But I also got some internal feedback that it might make more sense to ad=
d
> a trigger abstraction layer, so maybe that is something we should look in=
to
> more.

Nice. I admit I did not though too much on an actual implementation so I'm =
not really
sure how feasible this is without getting overly complicated. But from a co=
nceptual
point of view, it looks the right thing to me.

- Nuno S=C3=A1



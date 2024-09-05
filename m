Return-Path: <linux-iio+bounces-9186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC9596D606
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 12:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA890287EA0
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 10:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B5E19CC30;
	Thu,  5 Sep 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGvQW2Ld"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF1198A3E;
	Thu,  5 Sep 2024 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531888; cv=none; b=A0FZ7ZuunZF3aabmNavz2xY7Vk1j+RMKFSfTY3X/rlZIWVaIfeM6nhj1SJlL/KdV78Rtx558Wc1Bp22BRHZsXvR1LFgh/anlVC8G+nitQyM1RDHVYWmdmbq2oAYoqhbnM7g/lcahpXn2hN0rOavARk22MR5P/LLhpQBPnThD6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531888; c=relaxed/simple;
	bh=ymFcbMYD51eRn07YRHO/UDdIB9t+HQX0ow25KGMtxx8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDsQ0CYj9zKREREvI4Qj54wCXeFuQrUvCbywVogRXE7ZGxYraVEgogkUPrWkpCXaZjAhdoNKdhSO5lwX1WPrCIaPHkDIxSp4f6HEpEiOqxXNB6jsvV0oiNClLupqb7H30o7vR8CWz/Vkx3CjC7jiE9WJszKcA5PtjNyEgeI2x44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGvQW2Ld; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c26852af8fso660329a12.2;
        Thu, 05 Sep 2024 03:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531885; x=1726136685; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KD5e8iLAs44FdlnMrUVKychwWaQXORD8FkLl/XxSu6A=;
        b=RGvQW2LdS+IXmrpIcexw4nKRqB6GGCxxFrU69WQDixnwVQZDYRSdlG181jCgI+DzP0
         Un+44eAKjjvKwv0cp31aJY8ZvJIN+nQ4NWZp2VYhfrnarXRXIeLhPx1dA2+tR9p636kT
         uimLzz8ioUy3Ny6pcZkfhpzFolteyA3jyDSzYI3l72fGzQRqv2MLjfE9IIxHORJWzbKb
         uYncuRko2eNCu1QXVpFhIbsq/DtJ2N0ugOZDmjRQUQzyHjV9qhZe7A5fuYYbaozb/B+g
         hHybwgY89mC9xu64nu0AGd/FpfQRN04JWEf672I821+yziGnYeMs0qVcPflzKz+3orkO
         V9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531885; x=1726136685;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KD5e8iLAs44FdlnMrUVKychwWaQXORD8FkLl/XxSu6A=;
        b=uR9ML1nbt++CBFsfyzGSKbcGLG7tbHg/nlo3JbxN+tvwcOUeF5eW5vFdUzQvpYqM3I
         5q/gNkhBkKWD0YV4VMJ4gIJ25oAiA9q5vzbP2ACWo3BYXx5Tkq8oppVUkSY2jeR18s89
         eFBzAqjWO6Z1D4Y5nt/w6mTksK06IKcd/yBDoTNbfZFc7+5joSA5qlgeao8oM3kkFY8j
         J8iz0HtG7Qx39ltBpKako3noEV8GEo7K6dNC3hMEv6B46OhXcllNb5MwhrwQchYECbQM
         zjC1VP89ca17o8fqoJlbD84a15C7WaQT7yCKtrRPCB3zpabbloc8nb3KBo+AEdMxGBP/
         Zcag==
X-Forwarded-Encrypted: i=1; AJvYcCU0aRgmNh/6T2j1uNy/u6BUy4uTQI5jD0IGw2Ayr3VanvW5/pkR4/New7J80dCUbpTznspdFTXkIx7QoNlC@vger.kernel.org, AJvYcCUS7xiuYkVaVaTydtzU6SxyFxjiAFuOGMz2WCAjuCojaiR4osYAlxoPmEgSX0/sAzDoumrdF9NJC9as@vger.kernel.org, AJvYcCUWn05zn28mvjNuXubRL30F46NRObA17ajO+6kNwn/F1Yo/cRYqyE79MpSs4uG9qc3Hhl0SAqb38hd4@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwSXl7r3k6MnXeDqt7+GPWv+9+cpwf2ByNyAS2iHbbfxMzYgp
	B1oy0rxzS6bPWF3yJUltR8d4MESZhwb/7xahyNNMvVh/yVDKFGh8RwCRx4r7
X-Google-Smtp-Source: AGHT+IH9QD8IgY98uB7SOYLpUoQEDlELekqA8jpzQSGk5y6R3sXTSHAUSEqr3MRXF1xYtE5tiPaKTw==
X-Received: by 2002:a05:6402:13cc:b0:5a4:6dec:cd41 with SMTP id 4fb4d7f45d1cf-5c21ed89d15mr19180363a12.28.1725531884208;
        Thu, 05 Sep 2024 03:24:44 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc56a897sm1050958a12.47.2024.09.05.03.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:24:43 -0700 (PDT)
Message-ID: <f2568dd151efc2da76659fea4300fa7b3610d1e1.camel@gmail.com>
Subject: Re: [PATCH RFC 2/8] iio: backend: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
Date: Thu, 05 Sep 2024 12:28:51 +0200
In-Reply-To: <4826097d-b575-4895-9335-f587bbf3bc89@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	 <20240829-wip-bl-ad3552r-axi-v0-v1-2-b6da6015327a@baylibre.com>
	 <20240831122313.4d993260@jic23-huawei>
	 <0fbe1321-cc67-4ade-8cbb-cbbaa40d2ca1@baylibre.com>
	 <20240903201157.5352ec04@jic23-huawei>
	 <4826097d-b575-4895-9335-f587bbf3bc89@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-04 at 14:01 +0200, Angelo Dureghello wrote:
> Hi Jonathan,
>=20
> On 03/09/24 9:11 PM, Jonathan Cameron wrote:
> > On Mon, 2 Sep 2024 16:03:22 +0200
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >=20
> > > Hi Jonathan,
> > >=20
> > > thanks for the feedbacks,
> > >=20
> > > On 31/08/24 1:23 PM, Jonathan Cameron wrote:
> > > > On Thu, 29 Aug 2024 14:32:00 +0200
> > > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > > > =C2=A0=20
> > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > >=20
> > > > > Extend backend features with new calls needed later on this
> > > > > patchset from axi version of ad3552r.
> > > > >=20
> > > > > A bus type property has been added to the devicetree to
> > > > > inform the backend about the type of bus (interface) in use
> > > > > bu the IP.
> > > > >=20
> > > > > The follwoing calls are added:
> > > > >=20
> > > > > iio_backend_ext_sync_enable
> > > > > 	enable synchronize channels on external trigger
> > > > > iio_backend_ext_sync_disable
> > > > > 	disable synchronize channels on external trigger
> > > > > iio_backend_ddr_enable
> > > > > 	enable ddr bus transfer
> > > > > iio_backend_ddr_disable
> > > > > 	disable ddr bus transfer
> > > > > iio_backend_set_bus_mode
> > > > > 	select the type of bus, so that specific read / write
> > > > > 	operations are performed accordingly
> > > > > iio_backend_buffer_enable
> > > > > 	enable buffer
> > > > > iio_backend_buffer_disable
> > > > > 	disable buffer
> > > > > iio_backend_data_transfer_addr
> > > > > 	define the target register address where the DAC sample
> > > > > 	will be written.
> > > > > iio_backend_bus_reg_read
> > > > > 	generic bus read, bus-type dependent
> > > > > iio_backend_bus_read_write
> > > > > 	generic bus write, bus-type dependent
> > > > >=20
> > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > ---
> > > > > =C2=A0=C2=A0 drivers/iio/industrialio-backend.c | 151
> > > > > +++++++++++++++++++++++++++++++++++++
> > > > > =C2=A0=C2=A0 include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 24 ++++++
> > > > > =C2=A0=C2=A0 2 files changed, 175 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/iio/industrialio-backend.c
> > > > > b/drivers/iio/industrialio-backend.c
> > > > > index a52a6b61c8b5..1f60c8626be7 100644
> > > > > --- a/drivers/iio/industrialio-backend.c
> > > > > +++ b/drivers/iio/industrialio-backend.c
> > > > > @@ -718,6 +718,157 @@ static int __devm_iio_backend_get(struct de=
vice
> > > > > *dev, struct iio_backend *back)
> > > > > =C2=A0=C2=A0=C2=A0	return 0;
> > > > > =C2=A0=C2=A0 }
> > > > =C2=A0=20
> > > > > +
> > > > > +/**
> > > > > + * iio_backend_buffer_enable - Enable data buffering
> > > > Data buffering is a very vague term.=C2=A0 Perhaps some more detail=
 on what
> > > > this means?
> > > for this DAC IP, it is the dma buffer where i write the samples,
> > > for other non-dac frontends may be something different, so i kept it
> > > generic. Not sure what a proper name may be, maybe
> > >=20
> > > "Enable optional data buffer" ?
> > How do you 'enable' a buffer?=C2=A0 Enable writing into it maybe?
>=20
> for the current case, this is done using the custom register
> of the AXI IP, enabling a "stream".
>=20
> return regmap_set_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_STREAM_ENABLE);
>=20
> Functionally, looks like dma data is processed (sent over qspi)
> when the stream is enabled.
>=20
> Maybe a name as "stream_enable" would me more appropriate ?
> "Stream" seems less generic btw.
>=20

Yes, stream enable is very specific for this usecase. This is basically
connected to typical IIO buffering. So maybe we could either:

1) Embed struct iio_buffer_setup_ops in the backend ops struct;
2) Or just define directly the ones we need now in backend ops.
=20
> > >=20
> > > > > + * @back: Backend device
> > > > > + *
> > > > > + * RETURNS:
> > > > > + * 0 on success, negative error number on failure.
> > > > > + */
> > > > > +int iio_backend_buffer_enable(struct iio_backend *back)
> > > > > +{
> > > > > +	return iio_backend_op_call(back, buffer_enable);
> > > > > +}
> > > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_buffer_enable, IIO_BACKEND);
> > > > > +
> > > > > +/**
> > > > > +/**
> > > > > + * iio_backend_bus_reg_read - Read from the interface bus
> > > > > + * @back: Backend device
> > > > > + * @reg: Register valule
> > > > > + * @val: Pointer to register value
> > > > > + * @size: Size, in bytes
> > > > > + *
> > > > > + * A backend may operate on a specific interface with a related =
bus.
> > > > > + * Read from the interface bus.
> > > > So this is effectively routing control plane data through the offlo=
aded
> > > > bus?=C2=A0 That sounds a lot more like a conventional bus than IIO =
backend.
> > > > Perhaps it should be presented as that with the IIO device attached
> > > > to that bus? I don't fully understand what is wired up here.
> > > > =C2=A0=20
> > > Mainly, an IP may include a bus as 16bit parallel, or LVDS, or simila=
r
> > > to QSPI as in my case (ad3552r).
> > ok.
> >=20
> > If this is a bus used for both control and dataplane, then we should re=
ally
> > be presenting it as a bus (+ offload) similar to do for spi + offload.
> >=20

Yes, indeed. In this case we also use the axi-dac core for controlling the
frontend device (accessing it's register) which is fairly weird. But not su=
re
how we can do it differently. For the spi_engine that is really a spi contr=
oller
with the extra offloading capability. For this one, it's now "acting" as a =
spi
controller but in the future it may also "act" as a parallel controller (th=
e
axi-adc already is in works for that with the ad7606 series).

I was also very skeptical when I first saw these new functions but I'm not
really sure how to do it differently. I mean, it also does not make much se=
nse
to have an additional bus driver as the register maps are the same. Not sur=
e if
turning it in a MFD device, helps...

FWIW, I still don't fully understand why can't we have this supported by th=
e
spi_engine core. My guess is that we need features from the axi-dac (for th=
e
dataplane) so we are incorporating the controlplane on it instead of going
spi_engine + axi-dac.

Also want to leave a quick note about LVDS (that was mentioned). That inter=
face
is typically only used for data so I'm not seeing any special handling like=
 this
for that interface.

- Nuno S=C3=A1
> >=20


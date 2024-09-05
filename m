Return-Path: <linux-iio+bounces-9190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CBA96D653
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 12:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156921C235B7
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C42E198E77;
	Thu,  5 Sep 2024 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dONE8SI4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B743194C95;
	Thu,  5 Sep 2024 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533126; cv=none; b=TF5hj0FZ8oRnKu6LLWHpvvbzPyTc5O5ym1WDB5nNeAImSvVFnyBdlqnbOZs/7jX0iM0Qx6dWoP3AxqqG7fjhudmhhXFSj+AFFNj1VbPcEoxueXTzER41tNSBJ5ru3+R/HYEa68Xpb1+Uo3IQz4j/Cgb7WSndM9lhygwNTeN+yrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533126; c=relaxed/simple;
	bh=Cp3ABXE9jfn2+adjI48m213NmLshgXqtxz4UNHX3OwI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ARPlERlYjYdXDyC5u5PhwfOUzg77h2kMdo8n/kn7+UG81BqwF2xQu3t5BgF6+9FdofiH8CUP27bOnO4MLCprqkpf2+PhLO2nbBo/SqPahgum9ewM44xP4zM/YN0Z+b5WygLSK/yqYwKCq62masxMZNGoyifCtDVtVZYyEbnefKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dONE8SI4; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f74e468baeso3310631fa.2;
        Thu, 05 Sep 2024 03:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725533123; x=1726137923; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aIWrzHnJmACh9n3SKKN3TGolmhJb9VcZ1CS5M/kAQk8=;
        b=dONE8SI4ynzFhsHyaA5XEtvi0NOAsfdj2wRxT6YWPPqYjezScRrW9DgTtWOfdQWVcs
         3niwGXuBQqVmHNSPI78b876I+P/eFqjU500YlG5PNmN5h+CbV/hEVuHN6BRvt1AkkMrc
         Jv113dLF5ee0n52ZQ/zgy3LfROf+DavY30vo7/pR0zLZrQdXkZWgXmY8eBcviQ2buTu8
         4zTKKNPGNfnrVmWuXj6Se2gBBMGNRkssoOe1DrxWxnUCkDeIJrb9P8a6QCcskmELSaNw
         OSOsDJR9eMujpAZPctHZxFxN5hNRPXfVSHmLonOK6hmZobfVLcovMWbj/i9nK7bAnULj
         NvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533123; x=1726137923;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIWrzHnJmACh9n3SKKN3TGolmhJb9VcZ1CS5M/kAQk8=;
        b=oOvgcGKOqfwvFKpZvSAVF+mq03m6K7bOhs7zEPh+9nLY+5iDxWuLEUfzBptxd/2rxu
         poihFs5f2EEEi+rAJBzdyvxcTJYBhBKx/34zS0p3CfolfNfDdSoaUYTHFiQ+K1XF6ftZ
         GcktnQq8YqXl6Ttvo7Xp9u0WcLgvw8nhsYxi8e5aRALQVfiqzRoCYwCAEOmD5kH3fvqe
         8GobAtPa42xeLCXD24Hh2b4JxFiyi2ewgesHksEyCTeF0PIPMEMSmxO6fjou9SyNdv/4
         zgWUB4SOf8JwHqa6T8XW/7/LEKeWvXk+xsX3w76Cn+9WYgJ7a+WW2xx5PXlUBZBpd+me
         e1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVdAhq+ePEKfcWlthOlXhDnJrBHe6v/cpdkUvXpLm7JTP4oLi+KXPlJrmebHIZ6Nsfegy2LPKEzQkAo@vger.kernel.org, AJvYcCXM13TpTcu5L7heezs9qmMmQ3ZySWQ3JWThV+O8WYh2OtiSEd3h1SCqXEFZJRApJ4QgBxDDCMsXKwI1TzSZ@vger.kernel.org, AJvYcCXixGpNq22N7lShPK7VEUT+L9TKp+5Khwz7pkgkLQnW7J7hbL9NblJw+NOSMjldrLxmWHt7sLdoGUlk@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/uRJizGkv0EXKQbxYHK0w1b24XjepqIUeXvz1j++DNBj4Kju
	9mbtaBRXugYWzcYJrwPmjQmrL9ai7l90+c4lF99OpsTkJ7+5j6OB
X-Google-Smtp-Source: AGHT+IHU67H4LAHmEig99s1Ucie8nAXccR1D6JvAWjan4o6IxuU3teW2U23zXrvwcp2PUhe+Y8Gyiw==
X-Received: by 2002:a2e:4612:0:b0:2f2:9f26:ce96 with SMTP id 38308e7fff4ca-2f65c8ae484mr24328511fa.40.1725533122173;
        Thu, 05 Sep 2024 03:45:22 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc547ca7sm1068526a12.23.2024.09.05.03.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:45:21 -0700 (PDT)
Message-ID: <e7aacdc36be2bc11dc0e5ce5cf135482257d2a7d.camel@gmail.com>
Subject: Re: [PATCH RFC 3/8] iio: backend adi-axi-dac: backend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Angelo Dureghello
	 <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
Date: Thu, 05 Sep 2024 12:49:29 +0200
In-Reply-To: <20240903201614.08722f59@jic23-huawei>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	 <20240829-wip-bl-ad3552r-axi-v0-v1-3-b6da6015327a@baylibre.com>
	 <20240831123418.6bef6039@jic23-huawei>
	 <fd68cda2-f523-49fd-943b-c07dbb461799@baylibre.com>
	 <20240903201614.08722f59@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-03 at 20:16 +0100, Jonathan Cameron wrote:
> On Mon, 2 Sep 2024 18:04:51 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>=20
> > On 31/08/24 1:34 PM, Jonathan Cameron wrote:
> > > On Thu, 29 Aug 2024 14:32:01 +0200
> > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > > =C2=A0
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > Extend DAC backend with new features required for the AXI driver
> > > > version for the a3552r DAC.
> > > >=20
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>=C2=A0=
=20
> > > Hi Angelo
> > > Minor comments inline.=C2=A0=20
> > > > =C2=A0=20
> > > > =C2=A0 static int axi_dac_enable(struct iio_backend *back)
> > > > @@ -460,7 +493,13 @@ static int axi_dac_data_source_set(struct
> > > > iio_backend *back, unsigned int chan,
> > > > =C2=A0=C2=A0	case IIO_BACKEND_EXTERNAL:
> > > > =C2=A0=C2=A0		return regmap_update_bits(st->regmap,
> > > > =C2=A0=C2=A0					=C2=A0
> > > > AXI_DAC_REG_CHAN_CNTRL_7(chan),
> > > > -					=C2=A0 AXI_DAC_DATA_SEL,
> > > > AXI_DAC_DATA_DMA);
> > > > +					=C2=A0 AXI_DAC_DATA_SEL,
> > > > +					=C2=A0 AXI_DAC_DATA_DMA);=C2=A0=20
> > > Unrelated change.=C2=A0=C2=A0 If you want to change this, separate pa=
tch.=C2=A0=20
> > Thanks, fixed.
> > > =C2=A0
> > > > +	case IIO_BACKEND_INTERNAL_RAMP_16:
> > > > +		return regmap_update_bits(st->regmap,
> > > > +					=C2=A0
> > > > AXI_DAC_REG_CHAN_CNTRL_7(chan),
> > > > +					=C2=A0 AXI_DAC_DATA_SEL,
> > > > +					=C2=A0
> > > > AXI_DAC_DATA_INTERNAL_RAMP_16);
> > > > =C2=A0=C2=A0	default:
> > > > =C2=A0=C2=A0		return -EINVAL;
> > > > =C2=A0=C2=A0	}
> > > > @@ -518,9 +557,204 @@ static int axi_dac_reg_access(struct iio_back=
end
> > > > *back, unsigned int reg,
> > > > =C2=A0=C2=A0	return regmap_write(st->regmap, reg, writeval);
> > > > =C2=A0 }
> > > > =C2=A0=20
> > > > +
> > > > +static int axi_dac_bus_reg_write(struct iio_backend *back,
> > > > +				 u32 reg, void *val, size_t size)=C2=A0=20
> > > Maybe just pass an unsigned int for val?
> > > So follow what regmap does? You will still need the size, but it
> > > will just be configuration related rather than affecting the type
> > > of val.
> > > =C2=A0
> > void * was used since data size in the future may vary depending
> > on the bus physical interface.
> >=20
> I doubt it will get bigger than u64.=C2=A0 Passing void * is always
> nasty if we can do something else and this is a register writing
> operation.=C2=A0 I'm yet to meet an ADC or similar with > 64 bit register=
s
> (or even one with 64 bit ones!)

I think the original thinking was to support thinks like appending crc to t=
he
register read/write. But even in that case, u32 for val might be enough. No=
t
sure. Anyways, as you often say with the backend stuff, this is all in the
kernel so I guess we can change it to unsigned int and change it in the fut=
ure
if we need to.

Since you mentioned regmap, I also want to bring something that was discuss=
ed
before the RFC. Basically we talked about having the backend registering it=
's
own regmap_bus. Then we would either:

1) Have a specific get_regmap_bus() callback for the frontend to initialize=
 a
regmap on;
2) Pass this bus into the core and have a new frontend API like
devm_iio_backend_regmap_init().

Then, on top of the API already provided by regmap (like _update_bit()), th=
e
frontend could just use regmap independent of having a backend or not.

The current API is likely more generic but tbh (and David and Angelo are aw=
are
of it) my preferred approach it to use the regmap_bus stuff. I just don't f=
eel
that strong about it :)

>=20
> > Actually, a reg bus write involves several AXI regmap operations.
> > > =C2=A0
> > > > +{
> > > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > > +
> > > > +	if (!st->bus_type)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	if (st->bus_type =3D=3D AXI_DAC_BUS_TYPE_QSPI) {=C2=A0=20
> > > As below, I'd use a switch and factor out this block as a separate
> > > bus specific function.=C2=A0=20
> > Ok, changed.
> > > =C2=A0
> > > > +		int ret;
> > > > +		u32 ival;
> > > > +
> > > > +		if (size !=3D 1 && size !=3D 2)
> > > > +			return -EINVAL;
> > > > +
> > > > +		switch (size) {
> > > > +		case 1:
> > > > +			ival =3D FIELD_PREP(AXI_DAC_DATA_WR_8, *(u8
> > > > *)val);
> > > > +			break;
> > > > +		case 2:
> > > > +			ival =3D=C2=A0 FIELD_PREP(AXI_DAC_DATA_WR_16, *(u16
> > > > *)val);
> > > > +			break;
> > > > +		default:
> > > > +			return=C2=A0 -EINVAL;=C2=A0=20
> > > Hopefully compiler won't need this and the above. I'd drop the size !=
=3D 1..
> > > check in favour of just doing it in this switch.
> > > =C2=A0
> > sure, done.
> >=20
> >=20
> > > > +		}
> > > > +
> > > > +		ret =3D regmap_write(st->regmap, AXI_DAC_CNTRL_DATA_WR,
> > > > ival);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		/*
> > > > +		 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to
> > > > know
> > > > +		 * the data size. So keeping data size control here
> > > > only,
> > > > +		 * since data size is mandatory for to the current
> > > > transfer.
> > > > +		 * DDR state handled separately by specific backend
> > > > calls,
> > > > +		 * generally all raw register writes are SDR.
> > > > +		 */
> > > > +		if (size =3D=3D 1)
> > > > +			ret =3D regmap_set_bits(st->regmap,
> > > > AXI_DAC_REG_CNTRL_2,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_SYMB_8B);
> > > > +		else
> > > > +			ret =3D regmap_clear_bits(st->regmap,
> > > > AXI_DAC_REG_CNTRL_2,
> > > > +						AXI_DAC_SYMB_8B);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		ret =3D regmap_update_bits(st->regmap,
> > > > AXI_DAC_REG_CUSTOM_CTRL,
> > > > +					 AXI_DAC_ADDRESS,
> > > > +					 FIELD_PREP(AXI_DAC_ADDRESS,
> > > > reg));
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		ret =3D regmap_update_bits(st->regmap,
> > > > AXI_DAC_REG_CUSTOM_CTRL,
> > > > +					 AXI_DAC_TRANSFER_DATA,
> > > > +					 AXI_DAC_TRANSFER_DATA);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		ret =3D regmap_read_poll_timeout(st->regmap,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_REG_CUSTOM_CTRL,
> > > > ival,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ival &
> > > > AXI_DAC_TRANSFER_DATA,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10, 100 * KILO);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		return regmap_clear_bits(st->regmap,
> > > > AXI_DAC_REG_CUSTOM_CTRL,
> > > > +					=C2=A0 AXI_DAC_TRANSFER_DATA);
> > > > +	}
> > > > +
> > > > +	return -EINVAL;
> > > > +}
> > > > +
> > > > +static int axi_dac_bus_reg_read(struct iio_backend *back,
> > > > +				u32 reg, void *val, size_t size)=C2=A0=20
> > > As for write, I'd just use an unsigned int * for val like
> > > regmap does.=C2=A0=20
> >=20
> > Ok, so initial choice was unsigned int, further thinking of
> > possible future busses drive the choice to void *.
> >=20
> > Let me know, i can switch to unsigned int in case.
> I would just go with unsigned int or at a push u64 *
>=20
> >=20
> >=20
> > >=20
> > > =C2=A0
> > > > +{
> > > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > > +
> > > > +	if (!st->bus_type)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	if (st->bus_type =3D=3D AXI_DAC_BUS_TYPE_QSPI) {=C2=A0=20
> > > It got mentioned in binding review but if this isn't QSPI, even
> > > if similar don't call it that.=C2=A0=20
> >=20
> > It's a bit difficult to find a different name, physically,
> > it is a QSPI, 4 lanes + clock + cs, and datasheet is naming it Quad SPI=
.
> > But looking the data protocol, it's a bit different.
>=20
> is QSPI actually defined anywhere? I assumed it would be like
> SPI for which everything is so flexible you can build whatever you like.
>=20
> >=20
> > QSPI has instruction, address and data.
> > Here we have just ADDR and DATA.
> >=20

I'm not sure the instruction is really relevant for this. From a quick look=
, it
feels like something used for accessing external flash memory like spi-nors=
. So,
I would not be surprised if things are just like Jonathan said and this is =
just
flexible as spi (being that extra instruction field a protocol defined for =
flash
memory - where one typically sees this interface)

- Nuno S=C3=A1
>=20



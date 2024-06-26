Return-Path: <linux-iio+bounces-6962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D3391851A
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 17:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B64228A333
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 15:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86D5188CC1;
	Wed, 26 Jun 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diSzikHV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31BD18756E;
	Wed, 26 Jun 2024 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414109; cv=none; b=ETuSPPx3WccivrQe5ACtMsQ2us4jpSZMbOrUCX78uD580w+ONGFhlprOtiGeBhK/zanjPaxTKVsuuKBcGrDCqtoZJZDEtQ4ORO6eI+vrDbTNQ5dUEIE7C+fhTTPucpnwrN4KyC0eJN29+e/+V4z+loIR+qKhM8h+nr9+CDuU/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414109; c=relaxed/simple;
	bh=DuiVcdmmYbG7tkTTDbf+uUIXSJ06lIes0SLGtKA9hTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aY9nG6t6gseyKFWZqbbZ3HRUJOMhsvi35VLKpGO/WSCbXwQ6lF0uQ12Sb/g13s04+GQFuTgkk5HH3zI0EWxxGoN9RjsN+Pq7rom3OKr7ZkMJ4xhHzhJuffMWlaZf1gxYxcUNfqXDoCbV2b3vI9Ugpp2Xb+FzPf29+CHD5RQKmHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diSzikHV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso779498666b.0;
        Wed, 26 Jun 2024 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719414106; x=1720018906; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BoXAm49CkNSWP38zNf9LCupKizuESpLlF5JEmXOGc+o=;
        b=diSzikHVLoS6YUGTMwJAAC2aZxMrBRxXDTUWFHR0Zin0BsJ9+bQm16DHjtdYWDZMHi
         LWAcWEEAGPuW3TxZhVdS/u+M3c5gMwUzxKZpOsFS6BpW6t+Mk3XCNwG8IPtZbCDx0aQt
         4N7Bwsqm4KkDioSZRY3eMW/3X5CUl7QjYKQLY9HxKGrjuukkylMokt0ZBdHDedJ64uai
         FQIMD+GoPHOCxwMNYYHt9JpORUywJJh6VN5ga8bFpsMRFM0Wxp9otS8NZbWePQ2jZOFA
         CitqWUP59n47FJHhffi4vJr0uMbN+Mxq0Vhqpmr82/d4qn7/+oK8KaU/jHi9oJdYnsmF
         8G9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414106; x=1720018906;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BoXAm49CkNSWP38zNf9LCupKizuESpLlF5JEmXOGc+o=;
        b=dA7LfSZufEOwTOZyrhRayD4nrkWkxWPpnkyY8IBknNUlgiJZWXTHu8xn9JYJ7wh1CR
         FX8vUlLTZx5EgsERszzysB3jVuHXWd9B1XLhqmRL1LBqVMJgZPosryGSSfz2BU5Xhkgj
         3Gx13H8pD1PXy7HiT11EzLprvDprrIZXbQK2FRCRBxtlQwOu5RPOImR/MDXnaqem11xK
         +/eE6puLdiPi8WHuPJ/2MAVUJuN0TuTOzBh9U5VoH1t1QVWWQkHalGxqU3MP5tOfqmKh
         esuNW1QY+KqK5PIZnqtVEXZSOZT2zBLPCwFAOh8x0viK1QpKyE/1Gk3vI6Ol7PUsu9yJ
         WWbA==
X-Forwarded-Encrypted: i=1; AJvYcCWfakHT7D01o6uH7dkDemanIaKQ6bWbmo6aDdEkP0LNP9p0Sy0bz58YiiI21kBqSWGjE/WgJ7oI4tTv22QiKA2xanyecmOddUf9Du89ey26Rq1gyFDzlkQP1C9aoX2Pk6zhWF400UI7UZKIQuA/aeaVn0CEb55iSTIkc+n9P5tQrEhtvU51qCp/hTifD0NtKlCs+cQ2NNotW9dWlsKRgg==
X-Gm-Message-State: AOJu0YwCcZkKTppZE9butBjyiAtFpg5eNzCEX704czoXpKraXqbuvdZd
	OuS3AefjTKu5gYey6JHLcwcNbIW/pLJIQbSMsu5zFE9jCxG0tQr7
X-Google-Smtp-Source: AGHT+IEyrfpFF7R8vnozW8y6UEWbyGFkRCX4Qmq5R/QcuSLK06eVh/OJy4J+q+I0OqXLTbkQ1b/vbw==
X-Received: by 2002:a17:906:6bc9:b0:a72:2cb0:fafe with SMTP id a640c23a62f3a-a7242e159camr628886566b.75.1719414105716;
        Wed, 26 Jun 2024 08:01:45 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7248935f4dsm395395666b.9.2024.06.26.08.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:01:45 -0700 (PDT)
Message-ID: <89f1b3ae847f1110ca1782866971d82193d9f351.camel@gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: ad4695: Add driver for AD4695 and
 similar ADCs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ramona Gradinariu
	 <ramona.gradinariu@analog.com>
Date: Wed, 26 Jun 2024 17:05:37 +0200
In-Reply-To: <d2649e69-4c71-4aa9-88e2-9d3f15549e1b@baylibre.com>
References: <20240624-iio-adc-ad4695-v3-0-a22c302f06bf@baylibre.com>
	 <20240624-iio-adc-ad4695-v3-2-a22c302f06bf@baylibre.com>
	 <f02cac02f9404bf6dcc5a8274b51d836960871ee.camel@gmail.com>
	 <d2649e69-4c71-4aa9-88e2-9d3f15549e1b@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 09:42 -0500, David Lechner wrote:
> On 6/26/24 6:47 AM, Nuno S=C3=A1 wrote:
> > Hi David,
> >=20
> > minor stuff from me..
> >=20
> >=20
> > ...
> >=20
> > > +
> > > +static int ad4695_write_chn_cfg(struct ad4695_state *st,
> > > +				struct ad4695_channel_config *cfg)
> > > +{
> > > +	u32 mask =3D 0, val =3D 0;
> > > +
> > > +	mask |=3D AD4695_REG_CONFIG_IN_MODE;
> > > +	val |=3D FIELD_PREP(AD4695_REG_CONFIG_IN_MODE, cfg->bipolar ? 1 :
> > > 0);
> > > +
> >=20
> > nit: don't need to OR the first assignments and so initializing the
> > variables.
>=20
> :+1:
>=20
> >=20
> > > +	mask |=3D AD4695_REG_CONFIG_IN_PAIR;
> > > +	val |=3D FIELD_PREP(AD4695_REG_CONFIG_IN_PAIR, cfg->pin_pairing);
> > > +
> > > +	mask |=3D AD4695_REG_CONFIG_IN_AINHIGHZ_EN;
> > > +	val |=3D FIELD_PREP(AD4695_REG_CONFIG_IN_AINHIGHZ_EN, cfg->highz_en
> > > ? 1
> > > : 0);
> > > +
> > > +	return regmap_update_bits(st->regmap, AD4695_REG_CONFIG_IN(cfg-
> > > > channel),
> > > +				=C2=A0 mask, val);
> > > +}
> > > +
> > > +/**
> > > + * ad4695_read_one_sample - Read a single sample using single-cycle =
mode
> > > + * @st: The AD4695 state
> > > + * @address: The address of the channel to read
> > > + *
> > > + * Upon return, the sample will be stored in the raw_data field of @=
st.
> > > + *
> > > + * Context: can sleep, must be called with iio_device_claim_direct h=
eld
> > > + * Return: 0 on success, a negative error code on failure
> > > + */
> > > +static int ad4695_read_one_sample(struct ad4695_state *st, unsigned =
int
> > > address)
> > > +{
> > > +	struct spi_transfer xfer[2] =3D { };
> > > +	int ret;
> > > +
> > > +	ret =3D ad4695_set_single_cycle_mode(st, address);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/*
> > > +	 * Setting the first channel to the temperature channel isn't
> > > supported
> > > +	 * in single-cycle mode, so we have to do an extra xfer to read
> > > the
> > > +	 * temperature.
> > > +	 */
> > > +	if (address =3D=3D AD4695_CMD_TEMP_CHAN) {
> > > +		/* We aren't reading, so we can make this a short xfer.
> > > */
> > > +		st->cnv_cmd2 =3D AD4695_CMD_TEMP_CHAN << 3;
> > > +		xfer[0].bits_per_word =3D 8;
> >=20
> > nit: isn't this the default?
>=20
> yes (looks like leftover from testing when I was trying 16 instead of 8)
>=20
> >=20
> > > +		xfer[0].tx_buf =3D &st->cnv_cmd2;
> > > +		xfer[0].len =3D 1;
> > > +		xfer[0].cs_change =3D 1;
> > > +		xfer[0].cs_change_delay.value =3D AD4695_T_CONVERT_NS;
> > > +		xfer[0].cs_change_delay.unit =3D SPI_DELAY_UNIT_NSECS;
> > > +
> > > +		/* Then read the result and exit conversion mode. */
> > > +		st->cnv_cmd =3D AD4695_CMD_EXIT_CNV_MODE << 11;
> > > +		xfer[1].bits_per_word =3D 16;
> > > +		xfer[1].tx_buf =3D &st->cnv_cmd;
> > > +		xfer[1].rx_buf =3D &st->raw_data;
> > > +		xfer[1].len =3D 2;
> > > +
> > > +		return spi_sync_transfer(st->spi, xfer, 2);
> > > +	}
> > > +
>=20
> ...
>=20
> > > +
> > > +static int ad4695_parse_channel_cfg(struct iio_dev *indio_dev)
> > > +{
> > > +	struct device *dev =3D indio_dev->dev.parent;
> > > +	struct ad4695_state *st =3D iio_priv(indio_dev);
> >=20
> > Why not passing in struct ad4695_state directly?
>=20
> Probably because that is how it was done in the ADI tree driver
> I started with. Changing it to two parameters would be fine.
>=20

I think you're fine in just passing ad4695_state. If I'm not missing nothin=
g the
iio_dev is only to get the parent device and you have that in st->spi.

> >=20
> > ...
> >=20
> > >=20
> > > +
> > > +	/* Needed for debugfs since it only access registers 1 byte at a
> > > time. */
> > > +	ret =3D regmap_set_bits(st->regmap, AD4695_REG_SPI_CONFIG_C,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4695_REG_SPI_CONFIG_C_MB_STRICT)=
;
> > > +	if (ret)
> > > +		return ret;
> > > +
> >=20
> > Question... do we gain something but not doing the above? Because debug=
fs is
> > optional and always doing it even when it's not present looks unnecessa=
ry.=20
>=20
> I haven't got to a place where we need to read or write a 2 byte register
> yet, so I'm not sure. My plan is to defer worrying about it until then
> and update this if necessary in a future patch when it actually makes a
> difference. But for now, this is harmless because we are only reading
> and writing single byte registers.
>=20

ack

- Nuno S=C3=A1
>=20



Return-Path: <linux-iio+bounces-13757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A4C9FAE17
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 13:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E177165147
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 12:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4749D1A8F7C;
	Mon, 23 Dec 2024 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwEjl/H2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7D2166307;
	Mon, 23 Dec 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734955470; cv=none; b=dfIZ0sagiI+xJC6xnSEjM4E8a/RF/rkBWI/ZqTKWuosqtqYhFph34p8mED1d7CF75wbUgrNLVTx/9uvMqgEcReJNFVuiQ17j+EOTHX+MSeayolAxB/a7LVoUpZFaOFPRhACkIrt/c8MWiEEAwJnzGWVR6Qm/gbfq18L/z2KwrlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734955470; c=relaxed/simple;
	bh=eTuo3BA1z95J3Hik9TgED0lTLu3IKaNA1di3N+ffVuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbRaZcZ0g2Nxp8uGyiOWP4FoaR0mg9gh9i0VtvEX2oyOSFfy00nc+FRC7387/sItqOXXlemv41BFBOj7+/JNwctQSUw9iVhsyMdpWP3CAG5vu31ACD5+NOWLIywWWEwQA52lT767rg5G4wsaRJda0Q3bX91PtwM6r025jNRTQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwEjl/H2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB04C4CED3;
	Mon, 23 Dec 2024 12:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734955469;
	bh=eTuo3BA1z95J3Hik9TgED0lTLu3IKaNA1di3N+ffVuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UwEjl/H2HHCdB4e5pO7q5Xp2HjWcKpZolP+7nnd6xp+lXKUK22++mrXiLN7daK2HA
	 euBEYYoZo1lzkgT/zsO8P3M98Kr1hcE/RgEg4SZd3zIVcOj5NlX3hut+s+jyhQAny7
	 08ZYoVz9YahU83KZYCZGgxlunWx9gH7bgGhPwfGe7dKGkLkfeMEZ6JgBF7QQ1BCu9W
	 q3Zj8FxqAK2G+R/GOZIxfJZ6dS9liNoG5FrtilvCLamMSlh1IaGatbcFZ2rzUBeNUG
	 BthK4jbwf3vbVPpkow1sWvN29XjcEQE3Vdd05B3Aj3lesoB4e815G3b2/kyxO2Ljvx
	 xHjFzQkhuhfPg==
Date: Mon, 23 Dec 2024 12:04:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Esteban Blanc <eblanc@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <20241223120419.757eadfb@jic23-huawei>
In-Reply-To: <Z2eqOSN2Uk8SfTq1@debian-BULLSEYE-live-builder-AMD64>
References: <20241219-eblanc-ad4630_v1-v2-0-f36e55907bf5@baylibre.com>
	<20241219-eblanc-ad4630_v1-v2-2-f36e55907bf5@baylibre.com>
	<Z2eqOSN2Uk8SfTq1@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Just commenting on one particular bit feedback. Makes sure to address the
rest!

> > +
> > +static int ad4030_get_chan_calibscale(struct iio_dev *indio_dev,
> > +				      struct iio_chan_spec const *chan,
> > +				      int *val,
> > +				      int *val2)
> > +{
> > +	struct ad4030_state *st =3D iio_priv(indio_dev);
> > +	u16 gain;
> > +	int ret;
> > +
> > +	ret =3D regmap_bulk_read(st->regmap, AD4030_REG_GAIN_CHAN(chan->addre=
ss),
> > +			       st->rx_data.raw, AD4030_REG_GAIN_BYTES_NB);
> > +	if (ret)
> > +		return ret;
> > +
> > +	gain =3D get_unaligned_be16(st->rx_data.raw); =20
> My impression is that it is a bit odd to handle endianness after/before
> calling regmap_read/write(). Can you try set
> .val_format_endian_default =3D REGMAP_ENDIAN_BIG, in ad4030_regmap_bus?
> If that doesn't help, what about doing the get/set_unaligned stuff within
> the bus read/write calls?

Unless these are all 16 bit registers (in which case push it into the
regmap side of things), then a bulk read is not implying the registers
read are one value. They could just be a load of registers next to each oth=
er.
As such the regmap core won't touch them and endian conversion here, at the
layer where we know they are related is the right thing to do.

It's  not worth dual regmap stuff just because we have a few pairs of
registers.=20


>=20
> > +
> > +	/* From datasheet: multiplied output =3D input =C3=97 gain word/0x800=
0 */
> > +	*val =3D gain / 0x8000; =20
> Use a define to give a name to the gain constant?
>=20
> > +	*val2 =3D mul_u64_u32_div(gain % 0x8000, NANO, 0x8000);
> > +
> > +	return IIO_VAL_INT_PLUS_NANO;
> > +}
> > + =20
> [...]



Return-Path: <linux-iio+bounces-6957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD19182D2
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 15:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C296B1C212CD
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 13:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41031836F4;
	Wed, 26 Jun 2024 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaWmclw/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6FC1E890;
	Wed, 26 Jun 2024 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409325; cv=none; b=VvmT2SzNJ4OrZcifJ/zBnEpyxypfaUDoP4qIBWW1E/yDEXl8VO4Q6G1XvAX7d+VyVdB6Ev4MsCokXphr4y/QxgylQ3rVSuCFFHso9y2AQgZT0Hdkem1eK/lspcafq+cw1TFi/qP5d54T4GApP5yY+XO6Kdm9nCRXzbvpy1yEkLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409325; c=relaxed/simple;
	bh=7sY4DvBd+42DdRB69MfJg/sYGx3Q0KlzO7+txFWMzJU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Td/Gz28LDNGeUsZUZ5a8kfEKVOd9g740G5G2pTDwFA5/AUR/OyXL3j+b4u475/k3Rar0sf4BzbTGLuuud44zNgLbmTmTLiynrDnmYOJH5STdzmNo0+4V0fQ/Llo70oZ7c0ZfEQe087BQeVuzzV+VPBGUaNg37qN2vUTf4olz8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaWmclw/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4248e28de9eso30264645e9.2;
        Wed, 26 Jun 2024 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719409322; x=1720014122; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L8BeqKvtu81yy7xc7ZCBkEW2RL3ioT7E1XvmV51sVYE=;
        b=CaWmclw/UTJxSlVK/6jV9/foo+GaNsUBLDPOXlwpot1cJDeHAy5doaorh/lrUSBJpl
         zWaJhAkRpEBGBwShgPGuFPM17FmSvTDyX18G1xshkgcA2nZoMcvWylrgiTihseGTh+e8
         MFXlxBvRs9RmMCCEY+q3Kh3jq9MrZ0+34F3yZr5hNibxgtI+hS4QZ0nVwWfBj+YF6Fkk
         Xyfn/08J3wtLNSIWMYhLk5W40sZ1MsUvskCsKXKY2XHRbUpaXkqVbbYG3SjpFofGjs8t
         Kglg1KDVPtPFkvtdNKKqI1ADQ2JigLQTP1TgSjxqrzmy6H/Ngpj21qb4WLzFmPujoa/U
         lkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409322; x=1720014122;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8BeqKvtu81yy7xc7ZCBkEW2RL3ioT7E1XvmV51sVYE=;
        b=tYQ97cqB+SOIdetHS2AzvlMRHjyRLwCJXLbK4M5uqJNUXisgw5weySG4EpvaUDbolY
         H64amBSAeIkwZvBkOwUue3A0tfteMaHL3VQ7e8f6Tzc01k3TN+uzTkexrfQMQIAKAZJt
         UIkke/UC9Dnq+4q5UTjxz+mBa6Ex4BGsLDi5CkQWUr1lqnLl4+kWXNSmIagrVo4MuhtE
         BmA5ilH8pNjb6OtTfieXFLUO7TdHpb50sNkH1LaNHeDtPCN8VrXrxqPXcOBkzfSVF70w
         B8mCdHL7HsUjJ07sR/jQLOs65d5PYOgM4btujFWbAAJQ8QUsIz0qVoEnuJnHAddhIc7U
         GOtw==
X-Forwarded-Encrypted: i=1; AJvYcCVMXzvzyo6WOIp3wDlaSpz/WAk8IF50oqpEoRGahRFfysp1nsW5jwSI39zmS1kkuqMUDe4djv4p736V6Xumg2ayc14MRlVcSH1Y2Iifijb+04BQWTxz1CFwpFoK+C0WsjeKDttfCmSJxqPe0TVJGmQ6nTEHzBih23mAD/nr7IpDHtEyBL8wQrs/wki+/4rU8Ml3xLCtk9poAZsttmvLCy31ibqjKGWg3Wdr0Ql46AbB55JERnUY4xTqwA==
X-Gm-Message-State: AOJu0YzLlkP/TZkmbPbxKv2dBHSgGo3iCiRcALgvExvaPfqKc7uGvAJj
	fJNFm+Xxw2On42+uP09lVccJDfJ9m2+aYSQIGdWHcmaV3Z96mUWJ
X-Google-Smtp-Source: AGHT+IFMOO8EMlp6gEGvgRVvAXSflnqACiSa0Ac1BeE9fhjDlq2n0Dhu0CRIp9CRhdx6gtpsSsSfyQ==
X-Received: by 2002:a05:6000:4020:b0:366:e991:b9ac with SMTP id ffacd0b85a97d-366e991ba88mr7840059f8f.14.1719409321919;
        Wed, 26 Jun 2024 06:42:01 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f694asm15865447f8f.77.2024.06.26.06.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:42:01 -0700 (PDT)
Message-ID: <53ae33f72d2326a58db3bcf629fc522db3acf550.camel@gmail.com>
Subject: Re: [PATCH v5 6/7] iio: adc: Add support for AD4000
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org, 
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  nuno.sa@analog.com, dlechner@baylibre.com, corbet@lwn.net, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 26 Jun 2024 15:45:52 +0200
In-Reply-To: <ZnwU3MovTWfrovrE@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
	 <eb5f7b73bdf3ac89117e28f26ee3f54ba849163e.1719351923.git.marcelo.schmitt@analog.com>
	 <f6dc458f759c47154eee16354c807c020028512e.camel@gmail.com>
	 <ZnwU3MovTWfrovrE@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 10:17 -0300, Marcelo Schmitt wrote:
> On 06/26, Nuno S=C3=A1 wrote:
> > On Tue, 2024-06-25 at 18:55 -0300, Marcelo Schmitt wrote:
> > > Add support for AD4000 series of low noise, low power, high speed,
> > > successive approximation register (SAR) ADCs.
> > >=20
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 12 +
> > > =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/iio/adc/ad4000.c | 711 ++++++++++++++++++++++++++++++++=
+++++++
> > > =C2=A04 files changed, 725 insertions(+)
> > > =C2=A0create mode 100644 drivers/iio/adc/ad4000.c
> > >=20
>=20

...

> >=20
> > nit: you could reduce the scope of the above prepare functions...
>=20
> Not sure I got what you mean with this comment Nuno.
> Would it be preferable to prepare the 3-wire/4-wire transfers within the
> switch
> cases in probe?
>=20

These functions are only called from probe() right? So they could closer to=
 the
probe function. Anyways a nitpick comment :)

...

>=20
> >=20
> >=20
> > iio_device_claim_direct_scoped()?
>=20
> I had iio_device_claim_direct_scoped() in v4 but was asked to use a local
> lock to protect the read modify write cycle here.
> >=20
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > > +		mutex_lock(&st->lock);
> >=20
> > guard()?
>=20
> This guard() stuff is somewhat new to me.
> Will check out if can use it here.

should be doable...=20

>=20
> >=20
> > > +		ret =3D ad4000_read_reg(st, &reg_val);
> > > +		if (ret < 0)
> > > +			goto err_unlock;
> > > +
> > > +		span_comp_en =3D val2 =3D=3D st->scale_tbl[1][1];
> > > +		reg_val &=3D ~AD4000_CFG_SPAN_COMP;
> > > +		reg_val |=3D FIELD_PREP(AD4000_CFG_SPAN_COMP,
> > > span_comp_en);
> > > +
> > > +		ret =3D ad4000_write_reg(st, reg_val);
> > > +		if (ret < 0)
> > > +			goto err_unlock;
> > > +
> > > +		st->span_comp =3D span_comp_en;
> > > +err_unlock:
> > > +		iio_device_release_direct_mode(indio_dev);
> > > +		mutex_unlock(&st->lock);
> > > +		return ret;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> ...
> > > +
> > > +static int ad4000_probe(struct spi_device *spi)
> > > +{
> > > +	const struct ad4000_chip_info *chip;
> > > +	struct device *dev =3D &spi->dev;
> > > +	struct iio_dev *indio_dev;
> > > +	struct ad4000_state *st;
> > > +	int ret;
> > > +
> > > +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	chip =3D spi_get_device_match_data(spi);
> > > +	if (!chip)
> > > +		return -EINVAL;
> > > +
> > > +	st =3D iio_priv(indio_dev);
> > > +	st->spi =3D spi;
> > > +
> > > +	ret =3D devm_regulator_get_enable(dev, "vdd");
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "Failed to enable VDD
> > > supply\n");
> > > +
> > > +	ret =3D devm_regulator_get_enable(dev, "vio");
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "Failed to enable VIO
> > > supply\n");
> >=20
> > devm_regulator_bulk_get_enable()? Do we have any ordering constrains?
>=20
> No ordering constraints, but vdd and vio are optional while ref is requir=
ed
> and
> we need to get the voltage of ref.
> devm_regulator_bulk_get_enable_read_voltage()? and discard vdd and vio
> voltages?

Hmmm, vdd and vio do not look like optional to me :). Anyways I meant
devm_regulator_bulk_get_enable() only for vdd and vio and still treat ref
separately.

>=20
> >=20
> > > +
> > > +	ret =3D devm_regulator_get_enable_read_voltage(dev, "ref");
> > > +	if (ret < 0)
> > > +		return dev_err_probe(dev, ret,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get ref regulator
> > > reference\n");
> > > +	st->vref_mv =3D ret / 1000;
> > > +
> > > +	st->cnv_gpio =3D devm_gpiod_get_optional(dev, "cnv",
> > > GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(st->cnv_gpio))
> > > +		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get CNV GPIO");
> > > +
> > > +	ret =3D device_property_match_property_string(dev, "adi,sdi-pin",
> > > +						=C2=A0=C2=A0=C2=A0 ad4000_sdi_pin,
> > > +						=C2=A0=C2=A0=C2=A0
> > > ARRAY_SIZE(ad4000_sdi_pin));
> > > +	if (ret < 0 && ret !=3D -EINVAL)
> > > +		return dev_err_probe(dev, ret,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "getting adi,sdi-pin property
> > > failed\n");
> > > +
> > > +	/* Default to usual SPI connections if pin properties are not
> > > present
> > > */
> > > +	st->sdi_pin =3D ret =3D=3D -EINVAL ? AD4000_SDI_MOSI : ret;
> > > +	switch (st->sdi_pin) {
> > > +	case AD4000_SDI_MOSI:
> > > +		indio_dev->info =3D &ad4000_reg_access_info;
> > > +		indio_dev->channels =3D &chip->reg_access_chan_spec;
> > > +
> > > +		/*
> > > +		 * In "3-wire mode", the ADC SDI line must be kept high
> > > when
> > > +		 * data is not being clocked out of the controller.
> > > +		 * Request the SPI controller to make MOSI idle high.
> > > +		 */
> > > +		spi->mode |=3D SPI_MOSI_IDLE_HIGH;
> > > +		ret =3D spi_setup(spi);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > > +		ret =3D ad4000_prepare_3wire_mode_message(st, indio_dev-
> > > > channels);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		ret =3D ad4000_config(st);
> > > +		if (ret < 0)
> > > +			dev_warn(dev, "Failed to config device\n");
> > > +
> >=20
> > Should this be a warning? Very suspicious :)
>=20
> This devices have some many possible wiring configurations.
> I didn't want to fail just because reg access fail.
> Maybe ADC SDI was wired to VIO but dt don't have adi,sdi-pin =3D "high".
> Reg access will fail but sample read should work.

Well, to me that really is a configuration failure and we should treat it a=
s
such. If we are in the so called "reg_access_info" which I read as "we can
access registers", failing to do so should be treated as an error.=20

So, setting scale would also fail and we then have a broken interface :)

- Nuno S=C3=A1
>=20


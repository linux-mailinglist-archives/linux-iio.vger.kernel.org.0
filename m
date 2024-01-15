Return-Path: <linux-iio+bounces-1670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE40582D6A9
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 11:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA61281467
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 10:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11778F4E9;
	Mon, 15 Jan 2024 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIeqM286"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251FE579;
	Mon, 15 Jan 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso14868045e9.3;
        Mon, 15 Jan 2024 02:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705313129; x=1705917929; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vFMc7j2kW/EmR5j9xazq9ZZP8xcBhns8tWgRjbApPD8=;
        b=gIeqM286EePlCwwjkCJ15zX4LDglNUVgCGwbQUEO9UkrbQsPmG4oHGcngcK2vbcBbT
         3u9as5/X8qY6u4gHanH2izNtQfJh16f8cgu4bzPSNptGn1IKdN1vjvRHRQ6fqyzYtprJ
         n4UI0BpXNxOr/XTwlaMYaFT1UOqwW/ODHX8DfB9BshXabWU2VQK3nd6Iqo3lu8Xh+5QM
         GOr4gwELcylYoGmleUv0uVjk+TSfuCUMvnMBVZ3Uk4GGyxNXrutX+zLuevKTS9GqOQQa
         bTupQTT3kq6xgIMUTCZPjXrX1oxC4+oG8Ne9xj181AYu8r9OwfQ1DUiPZ735gsPz6Vqu
         d9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705313129; x=1705917929;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vFMc7j2kW/EmR5j9xazq9ZZP8xcBhns8tWgRjbApPD8=;
        b=StSZ21bi0BXJnUj42Z38Qj+jeILjvAV2sS2Ue/bo/915+gtFnO7mwTOwWqs3jXXByp
         PLUx82M/k5ApmRJ/h8Zokw1Lj57YTUD/Enz26J26vtS42TsSVs3spI/D/DLLJNFlxLp4
         l+XuzQEIqbJ6sfoL72b6CGQsCmqOjjuNfe3lINqqJJ1AYSeUMfUVa14NLAP7C7qvUsnM
         Y2Th13jijTyF5zG6SCHFjOZ6LHQ1EtFhDrnU+ICIScQO1wgO2FNjAymSZnYJQ6nkMQq3
         +vJQtbWc8lpT01cRf/vVi9VJYISWwxs5QZxAlS3jGxEY66nvjFlapacjTApGK8Iz1jss
         Wjlg==
X-Gm-Message-State: AOJu0YxuDU+nOszq/V8eEX+QBcN5JAt4jFd2p40tAG4Or04O8sFc87Kh
	dA6qsP3DYkXIdj4vd1XBwVM=
X-Google-Smtp-Source: AGHT+IH1FkjAOh3RlCwB3wJxmfd8cgvu4OEKpj4LBcJ1YEkoZ/0uD1+hwZkIQvjjobJzLjVvQy9Rxg==
X-Received: by 2002:a7b:cb05:0:b0:40e:4944:9a97 with SMTP id u5-20020a7bcb05000000b0040e49449a97mr1872629wmj.96.1705313128810;
        Mon, 15 Jan 2024 02:05:28 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b0040c6d559490sm15357548wmq.3.2024.01.15.02.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:05:28 -0800 (PST)
Message-ID: <0a7f38984f45531b1e08b20ea1d8532e1e78bf73.camel@gmail.com>
Subject: Re: [PATCH v5 7/8] iio: adc: ad9467: convert to backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Mon, 15 Jan 2024 11:08:40 +0100
In-Reply-To: <20240112173333.00002ed1@Huawei.com>
References: <20240112-iio-backend-v5-0-bdecad041ab4@analog.com>
	 <20240112-iio-backend-v5-7-bdecad041ab4@analog.com>
	 <20240112173333.00002ed1@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-12 at 17:33 +0000, Jonathan Cameron wrote:
> On Fri, 12 Jan 2024 17:40:21 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Convert the driver to use the new IIO backend framework. The device
> > functionality is expected to be the same (meaning no added or removed
> > features).
> >=20
> > Also note this patch effectively breaks ABI and that's needed so we can
> > properly support this device and add needed features making use of the
> > new IIO framework.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> Hi Nuno,
>=20
> Some trivial stuff in here (not I reviewed in reverse so might make more
> sense read that way).=C2=A0 Mostly little changes that will reduce what
> appears to be going on in this patch to the minimum possible
>=20
>=20
> > +
> > =C2=A0static int ad9467_outputmode_set(struct spi_device *spi, unsigned=
 int mode)
> > =C2=A0{
> > =C2=A0	int ret;
> > @@ -401,19 +419,17 @@ static int ad9467_outputmode_set(struct spi_devic=
e
> > *spi, unsigned int mode)
> > =C2=A0				AN877_ADC_TRANSFER_SYNC);
> > =C2=A0}
> > =C2=A0
> > -static int ad9467_scale_fill(struct adi_axi_adc_conv *conv)
> > +static int ad9467_scale_fill(struct ad9467_state *st)
> > =C2=A0{
> > -	const struct adi_axi_adc_chip_info *info =3D conv->chip_info;
> > -	struct ad9467_state *st =3D adi_axi_adc_conv_priv(conv);
> > =C2=A0	unsigned int i, val1, val2;
> 	const struct adi_axi_adc_chip_info *info =3D st->info;
> I think...
>=20
> Makes this patch more minimal which is nice and it's not a bad change
> in it's own right..
>=20
> Same with some other cases changed by this patch.

Alright, will do it in all the places you pointed out...

>=20
> > =C2=A0
> > -	st->scales =3D devm_kmalloc_array(&st->spi->dev, info->num_scales,
> > +	st->scales =3D devm_kmalloc_array(&st->spi->dev, st->info-
> > >num_scales,
> > =C2=A0					sizeof(*st->scales), GFP_KERNEL);
> > =C2=A0	if (!st->scales)
> > =C2=A0		return -ENOMEM;
> > =C2=A0
> > -	for (i =3D 0; i < info->num_scales; i++) {
> > -		__ad9467_get_scale(conv, i, &val1, &val2);
> > +	for (i =3D 0; i < st->info->num_scales; i++) {
> > +		__ad9467_get_scale(st, i, &val1, &val2);
> > =C2=A0		st->scales[i][0] =3D val1;
> > =C2=A0		st->scales[i][1] =3D val2;
> > =C2=A0	}
> > @@ -421,11 +437,27 @@ static int ad9467_scale_fill(struct adi_axi_adc_c=
onv
> > *conv)
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > -static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
> > +static int ad9467_setup(struct ad9467_state *st)
> > =C2=A0{
> > -	struct ad9467_state *st =3D adi_axi_adc_conv_priv(conv);
> > +	struct iio_backend_data_fmt data =3D {
> > +		.sign_extend =3D true,
> > +		.enable =3D true,
> > +	};
> > +	unsigned int c, mode;
> > +	int ret;
> > +
> > +	mode =3D st->info->default_output_mode |
> > AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
>=20
> Bit of a long line. Perhaps break it after the |

One of those cases where I think going beyond the 80 limit col helps
readability. But I can break the line if that's your preference.
=20
>=20
> > +	ret =3D ad9467_outputmode_set(st->spi, mode);
> > +	if (ret)
> > +		return ret;
> > =C2=A0
> > -	return ad9467_outputmode_set(st->spi, st->output_mode);
> > +	for (c =3D 0; c < st->info->num_channels; c++) {
> > +		ret =3D iio_backend_data_format_set(st->back, c, &data);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int ad9467_reset(struct device *dev)
> > @@ -443,25 +475,64 @@ static int ad9467_reset(struct device *dev)
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +static int ad9467_iio_backend_get(struct ad9467_state *st)
> > +{
> > +	struct device *dev =3D &st->spi->dev;
> > +	struct device_node *__back;
> > +
> > +	st->back =3D devm_iio_backend_get(&st->spi->dev, NULL);
> > +	/* If not found, don't error out as we might have legacy DT
> > property */
> > +	if (IS_ERR(st->back) && PTR_ERR(st->back) !=3D -ENOENT)
> > +		return PTR_ERR(st->back);
> > +	if (!IS_ERR(st->back))
> > +		return 0;
> Why not do this one first? I know I normally moan about having error hand=
lers
> out of line, but in this case the good is out of line whatever.
>=20
> 	if (!IS_ERR(st->back)
> 		return 0;
>=20
> 	if (PTR_ERR(st->back) !=3D ENOENT)
> 		return PTR_ERR(st->back);
>=20
> 	...

Yeah, really because I wanted to have the error condition checked first. Bu=
t I
agree in this particular case it makes the code simpler by not doing it tha=
t
way.

>=20
>=20
> > +	/*
> > +	 * if we don't get the backend using the normal API's, use the
> > legacy
> > +	 * 'adi,adc-dev' property. So we get all nodes with that property,
> > and
> > +	 * look for the one pointing at us. Then we directly lookup that
> > fwnode
> > +	 * on the backend list of registered devices. This is done so we
> > don't
> > +	 * make io-backends mandatory which would break DT ABI.
> > +	 */
> > +	for_each_node_with_property(__back, "adi,adc-dev") {
> > +		struct device_node *__me;
> > +
> > +		__me =3D of_parse_phandle(__back, "adi,adc-dev", 0);
> > +		if (!__me)
> > +			continue;
> > +
> > +		if (!device_match_of_node(dev, __me)) {
> > +			of_node_put(__me);
> > +			continue;
> > +		}
> > +
> > +		of_node_put(__me);
> > +		st->back =3D __devm_iio_backend_get_from_fwnode_lookup(dev,
> > +								=C2=A0=C2=A0=C2=A0=C2=A0
> > of_fwnode_handle(__back));
> > +		of_node_put(__back);
> > +		return PTR_ERR_OR_ZERO(st->back);
> > +	}
> > +
> > +	return -ENODEV;
> > +}
> > +
> > =C2=A0static int ad9467_probe(struct spi_device *spi)
> > =C2=A0{
> >=20
>=20
> > =C2=A0
> > -	st->output_mode =3D info->default_output_mode |
> > -			=C2=A0 AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
> > +	ret =3D ad9467_iio_backend_get(st);
> > +	if (ret)
> > +		return ret;
> > =C2=A0
> > -	return 0;
> > +	ret =3D devm_iio_backend_request_buffer(&spi->dev, st->back,
> > indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D iio_backend_enable(st->back);
> > +	if (ret)
> > +		return ret;
>=20
> I'm curious there is no iio_backend_disable() to be done in the exit path=
?
>=20

Ehehe something I have in my mind, yes. I'm just not disabling the core bec=
ause
it was the same with the previous approach. My goal was to have (more or le=
ss)
the same state before vs after introducing the backend. I was thinking in a=
dding
a devm_iio_backend_enable() as a follow up patch and use it in here (or act=
ually
use it for the first axi-dac/dds user as that one will be come from a "clea=
n"
state).

If you prefer I can already turn iio_backend_enable() ->
devm_iio_backend_enable() and use it in this patch.

- Nuno S=C3=A1
>=20


Return-Path: <linux-iio+bounces-4832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6718BC997
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 10:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C249B20AF2
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 08:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6343433BF;
	Mon,  6 May 2024 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGFkHlCf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B354F107A6;
	Mon,  6 May 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984408; cv=none; b=NNa1DGdulwtK6w+8Q17yBVEMrywABS1B8gYx1L9HmTlatMpRWrrRW5id0jelLRoKjpozdPJQD5xjbM6Bt2PQfU6K7MfdNX7kaLJQyYb2gaLX2K1alrROz57jYsg02HTTnBJtjr/7ssFVC9dhdOBggWj8GzomKDjL9J2T2EAckUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984408; c=relaxed/simple;
	bh=5+heWQn0NY04iO2WHoDCAsLzKUiOwreLVsDsjjsVU4M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JVRuUAMf1QjyAuZwaCTee/vrxJ97drvZpoT1bh88kRGpvkLOPGlAmTQYG387DYSAAG+m3eLrIVJ312EjzYkZGr7MMn4nLTOr0WQOnohYdTfytg2nBtD2qotcenEtBZrWrShfRRsVSdXfeI6yrjBVqv5G9lMpaz4f2l54i80znXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGFkHlCf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34e0d8b737eso2279806f8f.1;
        Mon, 06 May 2024 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714984405; x=1715589205; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8BH2FLNjc9RL/5k2roaJc/YdP9FTDUVcmIm+bJl28hc=;
        b=cGFkHlCfRDjR57Na6geTf+lyyd2Av0AE2xR1jtaWMOipZRnI9Trg3hmXF4Ln35SKyI
         LGyf+oDTfaM4ENPit3YzBTEMRlyJoTD3x/DQA4Q/WS1sirQd7BrBp69WNUuKaQKD7b6I
         06ft5D0QjqXcBjapF0gWHeu0JiYJ+kyLYOPgtfkGXvrQdirjFP2SbSIVQZ6jYT+zSJYW
         o4UPQAuqOkm7UYkk2hGja1aUyIPfZJHQKPJyaW7HmizEYftZwfEuHmzyTfcRgOKFlH4e
         MWSM+sD0SDVqeFWIodtxHl1/2QEZpTgK3nM7eCBlGNcsH0dGHDaES5ICuhkunFPGLSeN
         EuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714984405; x=1715589205;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8BH2FLNjc9RL/5k2roaJc/YdP9FTDUVcmIm+bJl28hc=;
        b=hLTq3KqXd5ZhlGQ9giV2buApd8ZRrk91EqS8JgGnfn9OhH2mh9Rqm8jImwcwQET3Ir
         0E70ynml19lXv7isLUdIIA5tz2PEyS3EXqLlOocL13ET/66faBr/RtLZ2pxLEac/4t7d
         VNkUPMEzJIOu5WIseKLJbVXQ/j3cH7bdGJ590MiFB6TpygIeycB4X35JbcaGbyXuAu6v
         VJaJLI8PONabQdKvEAOn48ZRHgQ9pdevJ6yLrMkQVpPG8HEJQ2vAA212M2EzRnDWXwTh
         CCOonDEncTkV5xx7/UOLvnIEH6ufQm5UdVsr31Xl71EfTc+EoEcCU3FuMrDQk9S5aSqs
         xvXA==
X-Forwarded-Encrypted: i=1; AJvYcCWSm367HCdPtcMz7t++b0g7Z1n4A0aFoEKq8Tz5Agk91TE9WGjsvdqXLAtlZv7g3sfX2zSBdOscY8GxOvg3HyIoc1/RxVSkgJDsto56L+UkZYKMAdzcvACcOZgc/iTtZE4JI003G4hVoFyMkczkmKR2s4tedQ0s/PEqYJLbl9DwUECpJQ==
X-Gm-Message-State: AOJu0YxVx2wDyIrZMN2zFJS63GoN0JF8QtorsKy3i3n0onq8oYWHiFPi
	a02NvvukGa6b+JyJbiCkCnILQ2KH7ePo1oNTU6lhDJ75b7/1khIR
X-Google-Smtp-Source: AGHT+IF7ZyL1tW67ZTb0llfcXYb9IJtqzTWjKrbOB2tBjnQ2BGbqnOvM4pBWmYf7ujM4mIdPIlPKDQ==
X-Received: by 2002:a5d:47a7:0:b0:34e:8f88:e1f8 with SMTP id 7-20020a5d47a7000000b0034e8f88e1f8mr7935075wrb.30.1714984404618;
        Mon, 06 May 2024 01:33:24 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c4f9100b0041668162b45sm18876968wmq.26.2024.05.06.01.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 01:33:24 -0700 (PDT)
Message-ID: <9cfbe67f24cf4e0f69ee7f3769d85469e0738ee2.camel@gmail.com>
Subject: Re: [PATCH RFC v6 09/10] iio: adc: ad7380: add support for rolling
 average oversampling mode
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 06 May 2024 10:33:23 +0200
In-Reply-To: <20240501-adding-new-ad738x-driver-v6-9-3c0741154728@baylibre.com>
References: 
	<20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
	 <20240501-adding-new-ad738x-driver-v6-9-3c0741154728@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-01 at 16:55 +0200, Julien Stephan wrote:
> Adds support for rolling average oversampling mode.
>=20
> Rolling oversampling mode uses a first in, first out (FIFO) buffer of
> the most recent samples in the averaging calculation, allowing the ADC
> throughput rate and output data rate to stay the same, since we only need
> to take only one sample for each new conversion.
>=20
> The FIFO length is 8, thus the available oversampling ratios are 1, 2, 4,=
 8
> in this mode (vs 1,=C2=A0 2, 4, 8, 16, 32 for the normal average)
>=20
> In order to be able to change the averaging mode, this commit also adds
> the new "oversampling_mode" and "oversampling_mode_available" custom
> attributes along with the according documentation file in
> Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380 since no standard
> attributes correspond to this use case.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
> =C2=A0Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380 |=C2=A0 38 +++++=
+
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad7380.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 143 +++++++++++++++++++--
> =C2=A03 files changed, 174 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380
> b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380
> new file mode 100644
> index 000000000000..0a560ef3e32a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380
> @@ -0,0 +1,38 @@
> +What: /sys/bus/iio/devices/iio:deviceX/oversampling_mode
> +KernelVersion: 6.9
> +Contact: Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +=C2=A0=C2=A0=C2=A0 Writing this attribute sets the oversampling average =
mode.
> +=C2=A0=C2=A0=C2=A0 Reading it, shows the configured mode.
> +=C2=A0=C2=A0=C2=A0 Available modes can be displayed using the oversampli=
ng_mode_available
> +=C2=A0=C2=A0=C2=A0 attribute.
> +=C2=A0=C2=A0=C2=A0 When writing this attribute to change the oversamplin=
g mode, this will
> +=C2=A0=C2=A0=C2=A0 have the following side effects:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - soft reset the ADC to flush the oversam=
pling block and FIFO
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - the available oversampling ratios depen=
d on the oversampling mode
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 configured so to avoid miscon=
figuration, changing the mode will disable
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the oversampling by setting t=
he ratio to 1.

Hmm, can we somehow re-enable it again with a proper configuration (after t=
he mode
change)?

> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - the list of available ratios (displayed=
 by reading the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oversampling_ratio_available =
attribute) will be updated when changing
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the oversampling mode.
> +
> +What: /sys/bus/iio/devices/iio:deviceX/oversampling_mode_available
> +KernelVersion: 6.9
> +Contact: Michael Hennerich <michael.hennerich@analog.com>
> +Description:
> +=C2=A0=C2=A0=C2=A0 Display the available oversampling average modes. The=
 two available modes
> +=C2=A0=C2=A0=C2=A0 are "normal" and "rolling" where "normal" average mod=
e is the default one.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - normal averaging involves taking a numb=
er of samples, adding them
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 together, and dividing the re=
sult by the number of samples taken.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This result is then output fr=
om the device. The sample data is cleared
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when the process completes. B=
ecause we need more samples to output a
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value, the data output rate d=
ecrease with the oversampling ratio.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - rolling oversampling mode uses a first =
in, first out (FIFO) buffer of
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the most recent samples in th=
e averaging calculation, allowing the ADC
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 throughput rate and output da=
ta rate to stay the same, since we only need
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to take only one sample for e=
ach new conversion.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 87724a9e9f9f..ca1e115f2aff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -434,6 +434,7 @@ R:	David Lechner <dlechner@baylibre.com>
> =C2=A0S:	Supported
> =C2=A0W:=09
> https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad=
738x
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> =C2=A0F:	drivers/iio/adc/ad7380.c
> =C2=A0
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 1e3869f5e48c..7b021bb9cf87 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -51,6 +51,8 @@
> =C2=A0#define AD7380_REG_ADDR_ALERT_HIGH_TH	0x5
> =C2=A0
> =C2=A0#define AD7380_CONFIG1_OS_MODE		BIT(9)
> +#define OS_MODE_NORMAL_AVERAGE		0
> +#define OS_MODE_ROLLING_AVERAGE		1

no AD7380 prefix?

> =C2=A0#define AD7380_CONFIG1_OSR		GENMASK(8, 6)
> =C2=A0#define AD7380_CONFIG1_CRC_W		BIT(5)
> =C2=A0#define AD7380_CONFIG1_CRC_R		BIT(4)
> @@ -159,16 +161,27 @@ static const struct ad7380_timing_specs ad7380_4_ti=
ming =3D {
> =C2=A0	.t_csh_ns =3D 20,
> =C2=A0};
> =C2=A0

...

>=20
> +static ssize_t oversampling_mode_store(struct device *dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct ad7380_state *st =3D iio_priv(indio_dev);
> +	int os_mode, ret;
> +
> +	ret =3D sysfs_match_string(ad7380_oversampling_average_modes, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	os_mode =3D ret;
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		ret =3D regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
> +					 AD7380_CONFIG1_OS_MODE,
> +					 FIELD_PREP(AD7380_CONFIG1_OS_MODE,
> os_mode));
> +
> +		if (ret)
> +			return=C2=A0 ret;
> +
> +		st->oversampling_mode =3D os_mode;
> +
> +		/*
> +		 * Oversampling ratio depends on oversampling mode, to avoid
> +		 * misconfiguration when changing oversampling mode,
> +		 * disable oversampling by setting OSR to 0.
> +		 */

Given the comment, I would expect you to disable osr before changing the mo=
de.

> +		ret =3D regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
> +					 AD7380_CONFIG1_OSR,
> FIELD_PREP(AD7380_CONFIG1_OSR, 0));
> +
> +		if (ret)
> +			return ret;
> +
> +		st->oversampling_ratio =3D 1;
> +

1?

Also, it would be nice if we could re-enabled osr. So the flow would maybe =
be:

1) disable osr;
2) change mode;
3) do whatever we need so configuration makes sense for new mode?
4) re-enable osr;
5) soft-reset;

Also not sure if 4) and 5) are in the correct order.

> +		/*
> +		 * Perform a soft reset.
> +		 * This will flush the oversampling block and FIFO but will
> +		 * maintain the content of the configurable registers.
> +		 */
> +		ret =3D regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
> +					 AD7380_CONFIG2_RESET,
> +					 FIELD_PREP(AD7380_CONFIG2_RESET,
> +						=C2=A0=C2=A0=C2=A0 AD7380_CONFIG2_RESET_SOFT));
> +	}
> +	return ret ?: len;
> +}
> +
> +static ssize_t oversampling_mode_available_show(struct device *dev,
> +						struct device_attribute *attr,
> char *buf)
> +{
> +	int i;
> +	size_t len =3D 0;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ad7380_oversampling_average_modes); i++)
> +		len +=3D sysfs_emit_at(buf, len, "%s ",
> ad7380_oversampling_average_modes[i]);
> +
> +	buf[len - 1] =3D '\n';
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR_RW(oversampling_mode, 0);
> +static IIO_DEVICE_ATTR_RO(oversampling_mode_available, 0);
> +
> +static struct attribute *ad7380_attributes[] =3D {
> +	&iio_dev_attr_oversampling_mode.dev_attr.attr,
> +	&iio_dev_attr_oversampling_mode_available.dev_attr.attr,
> +	NULL
> +};
> +

Maybe use IIO_ENUM... It allows the core to do some of the stuff you're doi=
ng for
you.


- Nuno S=C3=A1


Return-Path: <linux-iio+bounces-5441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF538D36A8
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 14:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77281C218B0
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048F82581;
	Wed, 29 May 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyAZpdwg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C6B522A;
	Wed, 29 May 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986784; cv=none; b=m3GqoAcpI+dNzP4k97iES6uHGuHrZ8Ntrm4dCBtJtnO87Gs1Nn3ekl+exKcdwLVXQy8Y+SDCPOWBUTPAGGYtbrD+rxyOtOOrQvbRLXUuB31jreipKPYGxAe7CxxRZ6KLge9zbMbS28v4yaJ536TU/fVATamjTwaRrrBPJy/jkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986784; c=relaxed/simple;
	bh=eIcSn/w2UJAtrs2KoBAYuNN6R+VcjW4f5tn8eORF9R4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1Dnyf4QLTMTsNz1zsBQYJ7DR5aRlbMpR45RfXykh9/fO6z2xGWVh+J+Ch40WSqYzQJ5zxxBy6JZla/qpQzOaAI00qWcxBZ57TlRkrAvQVj22jJPNTuLzx3vWvhNTyCiMw0Al2DdSCM2irSBI6ffEToITRyvs804nwpMlEFPNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyAZpdwg; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a632ba6c9dbso257136766b.2;
        Wed, 29 May 2024 05:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716986781; x=1717591581; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ALj8QX9npd32lYH5tO3rAXpwxR3OB1S4dU9F8nF9IFs=;
        b=SyAZpdwgcdabUNU+Spx9KbssQcnwuBPX5da+FEg3t0x7j4yTmyNk89b3PcWJNuqeTa
         XkS+dpekxmWkjDXWpJnq6cV2Ly6AYqxRSOWC0bPq97KSj3GzbVukkeL7UmH4H2BM5JpW
         sOLQtzVAGjCKeQHaSsy09m86gK4SUUDovzrtUs9XlzQ8jHIElznvZu3qnDXXdqOGER8n
         wSexQTRvVV792rkdkTlpyrWRAIvx05qJNjuDrcS11rFP5l4SDIL+gWVOD4ndBFyPs+x7
         wbtu+SXGhgJxorNMiNP+nZkXCfo+xd7ul7HvcFjhZ2spGZyHz0m8K9hdYn9hnWJ9pL8A
         950g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716986781; x=1717591581;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALj8QX9npd32lYH5tO3rAXpwxR3OB1S4dU9F8nF9IFs=;
        b=D3UX89CLANOn3wyRIXJIMDVjNQB/BxH4p+HhQgANYknDTac6uRUvptVfOzW4c44Bmx
         M+zQmTEEYfjzhdMaaurzxErj0pW80m+dw1J0hkQwoWbYaJoBA1WXdAhfKNUiSaMe6Bjq
         C+IB8RNvlOSV3COth9jwAW5V7Vami6BxQOORk7tiZp5kQUjnI/ydqx+a8O45RWJV6/jy
         2zd4sA7iTgyBbLXoez60srFBJ8oNDe0/v5D6HT7FWMrclAJbz2UFOh9lOFLxnHmxtso0
         mSAfokDlmzE7soXmvQ3JwoY2Z+UYBl9a/LFxpiptbzcjBHi+5NXY0kT3KDbGQcwzK07R
         byaw==
X-Forwarded-Encrypted: i=1; AJvYcCWDIeTN/bNpHlb5VTo2V+yyXc1vgdU5P1Lq9fpLblokLXZ74Ok8E/ElOgnpcvdlSMl9FYqLVp8QEWt2JDho8ltdf740Cwdr58rVRZmdqJQ0ZGmLwbpTQB6tehns3rbw2ZVgr2clQg4EfbjgZVQe2CQBi/BXzCdRRDe6msKcmIf4yFFXEA==
X-Gm-Message-State: AOJu0YxWjlaF3WCjGc4VmrwLfzIlmbC8Pwk0GfOLTm0LJHCKfM7KmRP6
	OshgQPHXpUP7hp7T1x+ijAry75kyMdRlz0wSjuyEN/RLGqaw+J4fAVgjJhba0ko=
X-Google-Smtp-Source: AGHT+IH0ud2UPyqniKkXVMNs39clE/FMkN2pIjKN8N2j24ujrEeUPS0Y62HAjEev7qWnlOOEhahDwQ==
X-Received: by 2002:a17:906:2789:b0:a59:9ad2:a7f8 with SMTP id a640c23a62f3a-a626511490fmr1020499366b.72.1716986780967;
        Wed, 29 May 2024 05:46:20 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c938718sm709504466b.66.2024.05.29.05.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 05:46:20 -0700 (PDT)
Message-ID: <6f18184de4a37993baedc15b44ecf0a6834a24d1.camel@gmail.com>
Subject: Re: [PATCH v3 5/6] iio: adc: ad7173: Add support for AD411x devices
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Wed, 29 May 2024 14:46:19 +0200
In-Reply-To: <20240527-ad4111-v3-5-7e9eddbbd3eb@analog.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
	 <20240527-ad4111-v3-5-7e9eddbbd3eb@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-27 at 20:02 +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
>=20
> The AD411X family encompasses a series of low power, low noise, 24-bit,
> sigma-delta analog-to-digital converters that offer a versatile range of
> specifications.
>=20
> This family of ADCs integrates an analog front end suitable for processin=
g
> both fully differential and single-ended, bipolar voltage inputs
> addressing a wide array of industrial and instrumentation requirements.
>=20
> - All ADCs have inputs with a precision voltage divider with a division
> =C2=A0 ratio of 10.
> - AD4116 has 5 low level inputs without a voltage divider.
> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
> =C2=A0 shunt resistor.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
> =C2=A0drivers/iio/adc/ad7173.c | 327 ++++++++++++++++++++++++++++++++++++=
++++++-----
> =C2=A01 file changed, 297 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 106a50dbabd4..328685ce25e0 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -1,8 +1,9 @@
> =C2=A0// SPDX-License-Identifier: GPL-2.0+
> =C2=A0/*
> - * AD717x family SPI ADC driver
> + * AD717x and AD411x family SPI ADC driver
> =C2=A0 *
> =C2=A0 * Supported devices:
> + *=C2=A0 AD4111/AD4112/AD4114/AD4115/AD4116
> =C2=A0 *=C2=A0 AD7172-2/AD7172-4/AD7173-8/AD7175-2
> =C2=A0 *=C2=A0 AD7175-8/AD7176-2/AD7177-2
> =C2=A0 *
> @@ -75,7 +76,9 @@
> =C2=A0#define AD7176_ID			0x0c90
> =C2=A0#define AD7175_2_ID			0x0cd0
> =C2=A0#define AD7172_4_ID			0x2050
> -#define AD7173_ID			0x30d0
> +#define AD7173_AD4111_AD4112_AD4114_ID	0x30d0

I would definitely rename this :). Would even prefer to have separate defin=
es all
defined by AD7173_ID.

> +#define AD4116_ID			0x34d0
> +#define AD4115_ID			0x38d0
> =C2=A0#define AD7175_8_ID			0x3cd0
> =C2=A0#define AD7177_ID			0x4fd0
> =C2=A0#define AD7173_ID_MASK			GENMASK(15, 4)
> @@ -106,6 +109,7 @@
> =C2=A0
> =C2=A0#define AD7173_GPO12_DATA(x)	BIT((x) + 0)
> =C2=A0#define AD7173_GPO23_DATA(x)	BIT((x) + 4)
> +#define AD4111_GPO01_DATA(x)	BIT((x) + 6)
> =C2=A0#define AD7173_GPO_DATA(x)	((x) < 2 ? AD7173_GPO12_DATA(x) :
> AD7173_GPO23_DATA(x))
> =C2=A0
> =C2=A0#define AD7173_INTERFACE_DATA_STAT	BIT(6)
> @@ -124,11 +128,20 @@
> =C2=A0#define AD7173_VOLTAGE_INT_REF_uV	2500000
> =C2=A0#define AD7173_TEMP_SENSIIVITY_uV_per_C	477
> =C2=A0#define AD7177_ODR_START_VALUE		0x07
> +#define AD4111_SHUNT_RESISTOR_OHM	50
> +#define AD4111_DIVIDER_RATIO		10
> +#define AD411X_VCOM_INPUT		0X10
> +#define AD4111_CURRENT_CHAN_CUTOFF	16
> =C2=A0
> =C2=A0#define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
> =C2=A0#define AD7173_MAX_CONFIGS		8
> =C2=A0
> =C2=A0enum ad7173_ids {
> +	ID_AD4111,
> +	ID_AD4112,
> +	ID_AD4114,
> +	ID_AD4115,
> +	ID_AD4116,
> =C2=A0	ID_AD7172_2,
> =C2=A0	ID_AD7172_4,
> =C2=A0	ID_AD7173_8,
> @@ -138,22 +151,43 @@ enum ad7173_ids {
> =C2=A0	ID_AD7177_2,
> =C2=A0};
> =C2=A0
> +enum ad4111_current_channels {
> +	AD4111_CURRENT_IN0P_IN0N,
> +	AD4111_CURRENT_IN1P_IN1N,
> +	AD4111_CURRENT_IN2P_IN2N,
> +	AD4111_CURRENT_IN3P_IN3N,
> +};
> +
> +enum ad7173_channel_types {
> +	AD7173_CHAN_SINGLE_ENDED,
> +	AD7173_CHAN_DIFFERENTIAL,
> +};
> +
> =C2=A0struct ad7173_device_info {
> =C2=A0	const unsigned int *sinc5_data_rates;
> =C2=A0	unsigned int num_sinc5_data_rates;
> =C2=A0	unsigned int odr_start_value;
> +	/*
> +	 * AD4116 has both inputs with a volage divider and without.

s/volage/voltage

> +	 * These inputs cannot be mixed in the channel configuration.
> +	 * Does not include the VCOM input.
> +	 */
> +	unsigned int num_voltage_inputs_with_divider;

nit: maybe num_voltage_in_div?

> =C2=A0	unsigned int num_channels;
> =C2=A0	unsigned int num_configs;
> -	unsigned int num_inputs;
> +	unsigned int num_voltage_inputs;

nit: maybe num_voltage_in?

> =C2=A0	unsigned int clock;
> =C2=A0	unsigned int id;
> =C2=A0	char *name;
> +	bool has_current_inputs;
> +	bool has_vcom_input;
> =C2=A0	bool has_temp;
> =C2=A0	/* ((AVDD1 =E2=88=92 AVSS)/5) */
> =C2=A0	bool has_common_input;
> =C2=A0	bool has_input_buf;
> =C2=A0	bool has_int_ref;
> =C2=A0	bool has_ref2;
> +	bool higher_gpio_bits;
> =C2=A0	u8 num_gpios;
> =C2=A0};
> =C2=A0
> @@ -195,6 +229,24 @@ struct ad7173_state {
> =C2=A0#endif
> =C2=A0};
> =C2=A0
> +static unsigned int ad4115_sinc5_data_rates[] =3D {
> +	24845000, 24845000, 20725000, 20725000,	/*=C2=A0 0-3=C2=A0 */
> +	15564000, 13841000, 10390000, 10390000,	/*=C2=A0 4-7=C2=A0 */
> +	4994000,=C2=A0 2499000,=C2=A0 1000000,=C2=A0 500000,	/*=C2=A0 8-11 */
> +	395500,=C2=A0=C2=A0 200000,=C2=A0=C2=A0 100000,=C2=A0=C2=A0 59890,	/* 1=
2-15 */
> +	49920,=C2=A0=C2=A0=C2=A0 20000,=C2=A0=C2=A0=C2=A0 16660,=C2=A0=C2=A0=C2=
=A0 10000,	/* 16-19 */
> +	5000,	=C2=A0 2500,=C2=A0=C2=A0=C2=A0=C2=A0 2500,		/* 20-22 */
> +};
> +
> +static unsigned int ad4116_sinc5_data_rates[] =3D {
> +	12422360, 12422360, 12422360, 12422360,	/*=C2=A0 0-3=C2=A0 */
> +	10362690, 10362690, 7782100,=C2=A0 6290530,	/*=C2=A0 4-7=C2=A0 */
> +	5194800,=C2=A0 2496900,=C2=A0 1007600,=C2=A0 499900,	/*=C2=A0 8-11 */
> +	390600,	=C2=A0 200300,=C2=A0=C2=A0 100000,=C2=A0=C2=A0 59750,	/* 12-15 =
*/
> +	49840,	=C2=A0 20000,=C2=A0=C2=A0=C2=A0 16650,=C2=A0=C2=A0=C2=A0 10000,	=
/* 16-19 */
> +	5000,	=C2=A0 2500,	=C2=A0=C2=A0=C2=A0 1250,		/* 20-22 */
> +};
> +
> =C2=A0static const unsigned int ad7173_sinc5_data_rates[] =3D {
> =C2=A0	6211000, 6211000, 6211000, 6211000, 6211000, 6211000, 5181000,
> 4444000,	/*=C2=A0 0-7=C2=A0 */
> =C2=A0	3115000, 2597000, 1007000, 503800,=C2=A0 381000,=C2=A0 200300,=C2=
=A0 100500,=C2=A0
> 59520,	/*=C2=A0 8-15 */
> @@ -210,14 +262,109 @@ static const unsigned int ad7175_sinc5_data_rates[=
] =3D {
> =C2=A0	5000,					/* 20=C2=A0=C2=A0=C2=A0 */
> =C2=A0};
> =C2=A0
> +static unsigned int ad4111_current_channel_config[] =3D {
> +	[AD4111_CURRENT_IN0P_IN0N] =3D 0x1E8,
> +	[AD4111_CURRENT_IN1P_IN1N] =3D 0x1C9,
> +	[AD4111_CURRENT_IN2P_IN2N] =3D 0x1AA,
> +	[AD4111_CURRENT_IN3P_IN3N] =3D 0x18B,
> +};
> +
> =C2=A0static const struct ad7173_device_info ad7173_device_info[] =3D {
> +	[ID_AD4111] =3D {
> +		.name =3D "ad4111",
> +		.id =3D AD7173_AD4111_AD4112_AD4114_ID,
> +		.num_voltage_inputs_with_divider =3D 8,
> +		.num_channels =3D 16,
> +		.num_configs =3D 8,
> +		.num_voltage_inputs =3D 8,
> +		.num_gpios =3D 2,
> +		.higher_gpio_bits =3D true,
> +		.has_temp =3D true,
> +		.has_vcom_input =3D true,
> +		.has_input_buf =3D true,
> +		.has_current_inputs =3D true,
> +		.has_int_ref =3D true,
> +		.clock =3D 2 * HZ_PER_MHZ,
> +		.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> +		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> +	},

At some point it would be nice to drop the ad7173_device_info array...

...

>=20
> @@ -688,18 +858,33 @@ static int ad7173_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0
> =C2=A0		return IIO_VAL_INT;
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> -		if (chan->type =3D=3D IIO_TEMP) {
> +
> +		switch (chan->type) {
> +		case IIO_TEMP:
> =C2=A0			temp =3D AD7173_VOLTAGE_INT_REF_uV * MILLI;
> =C2=A0			temp /=3D AD7173_TEMP_SENSIIVITY_uV_per_C;
> =C2=A0			*val =3D temp;
> =C2=A0			*val2 =3D chan->scan_type.realbits;
> -		} else {
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case IIO_VOLTAGE:
> =C2=A0			*val =3D ad7173_get_ref_voltage_milli(st, ch->cfg.ref_sel);
> =C2=A0			*val2 =3D chan->scan_type.realbits - !!(ch->cfg.bipolar);
> +
> +			if (chan->channel < st->info-
> >num_voltage_inputs_with_divider)
> +				*val *=3D AD4111_DIVIDER_RATIO;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case IIO_CURRENT:
> +			*val =3D ad7173_get_ref_voltage_milli(st, ch->cfg.ref_sel);
> +			*val /=3D AD4111_SHUNT_RESISTOR_OHM;
> +			*val2 =3D chan->scan_type.realbits - (ch->cfg.bipolar ? 1 :
> 0);

Can bipolar have any other value than 0 or 1? Just subtract it directly...

> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> =C2=A0		}
> -		return IIO_VAL_FRACTIONAL_LOG2;
> =C2=A0	case IIO_CHAN_INFO_OFFSET:
> -		if (chan->type =3D=3D IIO_TEMP) {
> +
> +		switch (chan->type) {
> +		case IIO_TEMP:
> =C2=A0			/* 0 Kelvin -> raw sample */
> =C2=A0			temp=C2=A0=C2=A0 =3D -ABSOLUTE_ZERO_MILLICELSIUS;
> =C2=A0			temp=C2=A0 *=3D AD7173_TEMP_SENSIIVITY_uV_per_C;
> @@ -708,10 +893,14 @@ static int ad7173_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD7173_VOLTAGE_INT_REF_u=
V *
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MILLI);
> =C2=A0			*val=C2=A0=C2=A0 =3D -temp;
> -		} else {
> +			return IIO_VAL_INT;
> +		case IIO_VOLTAGE:
> +		case IIO_CURRENT:
> =C2=A0			*val =3D -BIT(chan->scan_type.realbits - 1);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> =C2=A0		}
> -		return IIO_VAL_INT;
> =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> =C2=A0		reg =3D st->channels[chan->address].cfg.odr;
> =C2=A0
> @@ -919,13 +1108,34 @@ static int ad7173_register_clk_provider(struct iio=
_dev
> *indio_dev)
> =C2=A0					=C2=A0=C2=A0 &st->int_clk_hw);
> =C2=A0}
> =C2=A0
> +static int ad4111_validate_current_ain(struct ad7173_state *st,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ain[2])

Hmm, pass by reference... Should also be const AFAICT.

...

> =C2=A0
> @@ -1022,12 +1248,23 @@ static int ad7173_fw_parse_channel_config(struct =
iio_dev
> *indio_dev)
> =C2=A0		chan_st_priv =3D &chans_st_arr[chan_index];
> =C2=A0		ret =3D fwnode_property_read_u32_array(child, "diff-channels",
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 ain, ARRAY_SIZE(ain));
> -		if (ret)
> -			return ret;
> +		if (ret) {
> +			ret =3D fwnode_property_read_u32_array(child, "single-
> channel",
> +							=C2=A0=C2=A0=C2=A0=C2=A0 ain, 1);
> +			if (ret)
> +				return ret;
> =C2=A0
> -		ret =3D ad7173_validate_voltage_ain_inputs(st, ain);
> -		if (ret)
> -			return ret;
> +			ret =3D ad4111_validate_current_ain(st, ain);
> +			if (ret)
> +				return ret;
> +			is_current_chan =3D true;
> +			ain[1] =3D 0;
> +		} else {
> +			ret =3D ad7173_validate_voltage_ain_inputs(st, ain);
> +			if (ret)
> +				return ret;
> +			is_current_chan =3D false;
> +		}
> =C2=A0
> =C2=A0		ret =3D fwnode_property_match_property_string(child,
> =C2=A0							=C2=A0=C2=A0=C2=A0 "adi,reference-
> select",
> @@ -1051,17 +1288,34 @@ static int ad7173_fw_parse_channel_config(struct =
iio_dev
> *indio_dev)
> =C2=A0		chan->scan_index =3D chan_index;
> =C2=A0		chan->channel =3D ain[0];
> =C2=A0		chan->channel2 =3D ain[1];
> -		chan->differential =3D true;
> -
> -		chan_st_priv->ain =3D AD7173_CH_ADDRESS(ain[0], ain[1]);
> =C2=A0		chan_st_priv->chan_reg =3D chan_index;
> =C2=A0		chan_st_priv->cfg.input_buf =3D st->info->has_input_buf;
> =C2=A0		chan_st_priv->cfg.odr =3D 0;
> -
> =C2=A0		chan_st_priv->cfg.bipolar =3D fwnode_property_read_bool(child,
> "bipolar");
> +
> =C2=A0		if (chan_st_priv->cfg.bipolar)
> =C2=A0			chan->info_mask_separate |=3D BIT(IIO_CHAN_INFO_OFFSET);
> =C2=A0
> +		ret =3D fwnode_property_match_property_string(child,
> +							=C2=A0=C2=A0=C2=A0 "adi,channel-type",
> +							=C2=A0=C2=A0=C2=A0 ad7173_channel_types,
> +							=C2=A0=C2=A0=C2=A0
> ARRAY_SIZE(ad7173_channel_types));
> +		chan->differential =3D (ret < 0 || ret =3D=3D AD7173_CHAN_DIFFERENTIAL=
)
> +					? 1 : 0;

I don't think we should treat 'ret < 0' has a differential channel. Any rea=
son for
it? For me, it's just an invalid property value given by the user...

- Nuno S=C3=A1



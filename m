Return-Path: <linux-iio+bounces-5834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECA38FCF53
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 15:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E807285B08
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 13:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65C719413F;
	Wed,  5 Jun 2024 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c56ogE59"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DB7192B6A;
	Wed,  5 Jun 2024 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717592370; cv=none; b=eVuF8t9ktnevG6kKYG1R706CFK6+zyrYCJD59+wVUvHLimv6CnVdPhqQE6DDt3IEYDWegx8Ie5cxu1jWo9qbK2I4VaEoFCGi+mH6GovJLx+sWgPei2pldybMMWP32B4dY6VsnPrT4gM7u80BsKxsssLVNhzH/TJB+KQWlzxylzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717592370; c=relaxed/simple;
	bh=rcoYzRM62pU1psgNvnV7Pjx4fbOvPM/MXCVPLLT2pZY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AVOelc+xscKIoPyAGOi+XpqM7EsPgrj7see6Gu+ocrAfa/pjpM54HVHT37D0SW+YJdWBnRWY03OzLLX/eiDDS1fV3zh/uKWTvBaUb/jqhB/3dYa41YtrZeWN7l7ul+ZNMB1HVgo1Ej/Is2KTOb7sI6VgJIyTkczbKLLygj8KWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c56ogE59; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b90038cf7so5871297e87.0;
        Wed, 05 Jun 2024 05:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717592366; x=1718197166; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=366Rb1nAPeHUh6NkPUc8+CVj3LSoZk+2nynGG2ynnNo=;
        b=c56ogE59fUDt6aHmPICE8Yb3ac9XUOsYkxcoh1WBstQSXk9gLIT5DUEJB/OP1IWSf+
         D7suB63ask74EILeJVGA6KR9SjM0YuVH9KxOfclQmRx2Pipg1xJSmxPQSiI0jtzYd+rD
         2SLP6QGh5OYEl9HCnj64lgYDwENXxweWCIEBzlnEclzuEOXCucgurOXuBBQ+sPuS57x9
         /UCyEwM4tDhrQ9UCbQN8q/i/Og9epP5b3W/fHmJL/4mJb/DXmerZX4eHkYo4wFEklH3b
         Ahw2U6cIdSibbHE3RMAEG1eOGISopMjpN23e+P5riuV5i6hUB8GaP30Rpajej9pPgCLj
         7Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717592366; x=1718197166;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=366Rb1nAPeHUh6NkPUc8+CVj3LSoZk+2nynGG2ynnNo=;
        b=C59PkKBaLEvXO89zP3WiWQwCPd/lSqIgndP/Gms9EnqprUaW6vaHLuJovrYpA7sVvY
         WYhZkwuB5pLUdNn2EMNYmQOcCSjVU5SFKe/k8CM6uX5DrGRDNJ4K1TsSZ1qcxwSbjQqy
         Spf7EM2jMOUfLLXY5YWQAW4WMyMQxVMniJQp8i3LLDsKuzY4zywqrdfyPsWRA7mAk1mz
         IV+EtMLuaI1+sGf5Y9WGkvUtBzNcWIy0ySfhY796UdOkpalNZu3mqe6I84z4rZonsWiG
         dVG/kOgfDuHDwLi9C0R0faEPd3evYUOaHZxONIO4ebazWCnFsI/ytIu5zS3EfcoNSc+R
         p3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6frOiy+uLdPk9k5+kKJSB0uprmhbr0p9xEI1M582tY0J4JJ7y1WMwiysuLKZsLAFwSwqND+8qLFWdgu1IZOZlTPoaTwnfrF8g/93w105UkiLLaxQ+ntRTPyEaSXp4a0GaTDikmGV/UDMVjWJRLk4o/QaZwox0GHvsbcKtLB1ynODTQ==
X-Gm-Message-State: AOJu0YzvOxxX6U/MQHpMrumGkvJdo7NbL91lnpQ6J9lgCpHAIyOJ3CtR
	+2uZ/sHUJSWHxIJBuK5MudtGSvY8ppg4l3TWAFcEAiZKvDQo8i2Cj+XOxb5Q
X-Google-Smtp-Source: AGHT+IFWRcbB7EJ3xohUcZk3McTi7YxDMMxpzPWkV6BVKv+gvIjIXTiNK8sjyEbK1Z6HU+F/PAf09g==
X-Received: by 2002:ac2:4c4a:0:b0:52a:fe27:aa0d with SMTP id 2adb3069b0e04-52bab4aede2mr1986421e87.12.1717592365922;
        Wed, 05 Jun 2024 05:59:25 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c9d584sm9118389a12.96.2024.06.05.05.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 05:59:25 -0700 (PDT)
Message-ID: <e92871489d416e4f8a350fd24fc5ed0012b3cf2b.camel@gmail.com>
Subject: Re: [PATCH v3 6/6] iio: adc: Add support for AD4000
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org, 
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  nuno.sa@analog.com, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Jun 2024 15:03:12 +0200
In-Reply-To: <e340f48324b0ea3afb1c715cb2fba184c27112a1.1717539384.git.marcelo.schmitt@analog.com>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
	 <e340f48324b0ea3afb1c715cb2fba184c27112a1.1717539384.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 08:14 -0300, Marcelo Schmitt wrote:
> Add support for AD4000 series of low noise, low power, high speed,
> successive aproximation register (SAR) ADCs.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

...

> +
> +static const struct ad4000_chip_info ad4000_chips[] =3D {
> +	[ID_AD4000] =3D {
> +		.dev_name =3D "ad4000",
> +		.chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 16),
> +	},
> +	[ID_AD4001] =3D {
> +		.dev_name =3D "ad4001",
> +		.chan_spec =3D AD4000_DIFF_CHANNEL('s', 16),
> +	},
> +	[ID_AD4002] =3D {
> +		.dev_name =3D "ad4002",
> +		.chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 18),
> +	},
> +	[ID_AD4003] =3D {
> +		.dev_name =3D "ad4003",
> +		.chan_spec =3D AD4000_DIFF_CHANNEL('s', 18),
> +	},
> +	[ID_AD4004] =3D {
> +		.dev_name =3D "ad4004",
> +		.chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 16),
> +	},
> +	[ID_AD4005] =3D {
> +		.dev_name =3D "ad4005",
> +		.chan_spec =3D AD4000_DIFF_CHANNEL('s', 16),
> +	},
> +	[ID_AD4006] =3D {
> +		.dev_name =3D "ad4006",
> +		.chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 18),
> +	},
> +	[ID_AD4007] =3D {
> +		.dev_name =3D "ad4007",
> +		.chan_spec =3D AD4000_DIFF_CHANNEL('s', 18),
> +	},
> +	[ID_AD4008] =3D {
> +		.dev_name =3D "ad4008",
> +		.chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 16),
> +	},
> +	[ID_AD4010] =3D {
> +		.dev_name =3D "ad4010",
> +		.chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 18),
> +	},
> +	[ID_AD4011] =3D {
> +		.dev_name =3D "ad4011",
> +		.chan_spec =3D AD4000_DIFF_CHANNEL('s', 18),
> +	},
> +	[ID_AD4020] =3D {
> +		.dev_name =3D "ad4020",
> +		.chan_spec =3D AD4000_DIFF_CHANNEL('s', 20),
> +	},
> +	[ID_AD4021] =3D {
> +		.dev_name =3D "ad4021",
> +		.chan_spec =3D AD4000_DIFF_CHANNEL('s', 20),
> +	},
> +	[ID_AD4022] =3D {
> +		.dev_name =3D "ad4022",
> +		.chan_spec =3D AD4000_DIFF_CHANNEL('s', 20),
> +	},
> +	[ID_ADAQ4001] =3D {
> +		.dev_name =3D "adaq4001",
> +		.chan_spec =3D AD4000_DIFF_CHANNEL('s', 16),
> +	},
> +	[ID_ADAQ4003] =3D {
> +		.dev_name =3D "adaq4003",
> +		.chan_spec =3D AD4000_DIFF_CHANNEL('s', 18),
> +	},
> +};
> +

Please have the above as a different variable per device rather than the ar=
ray.
Likely no need for the enum then...
=20
> +struct ad4000_state {
> +	struct spi_device *spi;
> +	struct gpio_desc *cnv_gpio;
> +	struct spi_transfer xfers[2];
> +	struct spi_message msg;
> +	int vref;
> +	enum ad4000_spi_mode spi_mode;
> +	bool span_comp;
> +	bool turbo_mode;
> +	int gain_milli;
> +	int scale_tbl[2][2];
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	struct {
> +		union {
> +			__be16 sample_buf16;
> +			__be32 sample_buf32;
> +		} data;
> +		s64 timestamp __aligned(8);
> +	} scan __aligned(IIO_DMA_MINALIGN);
> +	__be16 tx_buf;
> +	__be16 rx_buf;
> +};
> +
> +static void ad4000_fill_scale_tbl(struct ad4000_state *st, int scale_bit=
s,
> +				=C2=A0 const struct ad4000_chip_info *chip)
> +{
> +	int diff =3D chip->chan_spec.differential;
> +	int val, val2, tmp0, tmp1;
> +	u64 tmp2;
> +
> +	val2 =3D scale_bits;
> +	val =3D st->vref / 1000;
> +	/*
> +	 * The gain is stored as a fraction of 1000 and, as we need to
> +	 * divide vref by gain, we invert the gain/1000 fraction.
> +	 * Also multiply by an extra MILLI to avoid losing precision.
> +	 */
> +	val =3D mult_frac(val, MILLI * MILLI, st->gain_milli);

Why not MICRO :)?

> +	/* Would multiply by NANO here but we multiplied by extra MILLI */
> +	tmp2 =3D shift_right((u64)val * MICRO, val2);
> +	tmp0 =3D (int)div_s64_rem(tmp2, NANO, &tmp1);

no cast needed...

> +	/* Store scale for when span compression is disabled */
> +	st->scale_tbl[0][0] =3D tmp0; /* Integer part */
> +	st->scale_tbl[0][1] =3D abs(tmp1); /* Fractional part */
> +	/* Store scale for when span compression is enabled */
> +	st->scale_tbl[1][0] =3D tmp0;
> +	/* The integer part is always zero so don't bother to divide it. */
> +	if (diff)
> +		st->scale_tbl[1][1] =3D DIV_ROUND_CLOSEST(abs(tmp1) * 4, 5);
> +	else
> +		st->scale_tbl[1][1] =3D DIV_ROUND_CLOSEST(abs(tmp1) * 9, 10);
> +}
> +
> +static int ad4000_write_reg(struct ad4000_state *st, uint8_t val)
> +{
> +	st->tx_buf =3D cpu_to_be16(AD4000_WRITE_COMMAND << BITS_PER_BYTE |
> val);
> +	return spi_write(st->spi, &st->tx_buf, 2);

sizeof(tx_buf)?

> +}
> +
> +static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
> +{
> +	struct spi_transfer t[] =3D {
> +		{
> +			.tx_buf =3D &st->tx_buf,
> +			.rx_buf =3D &st->rx_buf,
> +			.len =3D 2,
> +		},
> +	};
> +	int ret;
> +
> +	st->tx_buf =3D cpu_to_be16(AD4000_READ_COMMAND << BITS_PER_BYTE);
> +	ret =3D spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> +	if (ret < 0)
> +		return ret;
> +
> +	*val =3D be16_to_cpu(st->rx_buf);
> +
> +	return ret;
> +}
> +
> +static void ad4000_unoptimize_msg(void *msg)
> +{
> +	spi_unoptimize_message(msg);
> +}
> +
> +/*
> + * This executes a data sample transfer for when the device connections =
are
> + * in "3-wire" mode, selected by setting the adi,spi-mode device tree
> property
> + * to "single". In this connection mode, the ADC SDI pin is connected to=
 MOSI
> or
> + * to VIO and ADC CNV pin is connected either to a SPI controller CS or =
to a
> GPIO.
> + * AD4000 series of devices initiate conversions on the rising edge of C=
NV
> pin.
> + *
> + * If the CNV pin is connected to an SPI controller CS line (which is by
> default
> + * active low), the ADC readings would have a latency (delay) of one rea=
d.
> + * Moreover, since we also do ADC sampling for filling the buffer on
> triggered
> + * buffer mode, the timestamps of buffer readings would be disarranged.
> + * To prevent the read latency and reduce the time discrepancy between t=
he
> + * sample read request and the time of actual sampling by the ADC, do a
> + * preparatory transfer to pulse the CS/CNV line.
> + */
> +static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec
> *chan)
> +{
> +	unsigned int cnv_pulse_time =3D st->turbo_mode ? AD4000_TQUIET1_NS
> +						=C2=A0=C2=A0=C2=A0=C2=A0 : AD4000_TCONV_NS;
> +	struct spi_transfer *xfers =3D st->xfers;
> +	int ret;
> +
> +	xfers[0].cs_change =3D 1;
> +	xfers[0].cs_change_delay.value =3D cnv_pulse_time;
> +	xfers[0].cs_change_delay.unit =3D SPI_DELAY_UNIT_NSECS;
> +
> +	xfers[1].rx_buf =3D &st->scan.data;
> +	xfers[1].len =3D BITS_TO_BYTES(chan->scan_type.storagebits);
> +	xfers[1].delay.value =3D AD4000_TQUIET2_NS;
> +	xfers[1].delay.unit =3D SPI_DELAY_UNIT_NSECS;
> +
> +	spi_message_init_with_transfers(&st->msg, st->xfers, 2);
> +
> +	ret =3D spi_optimize_message(st->spi, &st->msg);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(&st->spi->dev, ad4000_unoptimize_msg,
> +					&st->msg);
> +}
> +
> +/*
> + * This executes a data sample transfer for when the device connections =
are
> + * in "4-wire" mode, selected when the adi,spi-mode device tree
> + * property is absent or empty. In this connection mode, the controller =
CS
> pin
> + * is connected to ADC SDI pin and a GPIO is connected to ADC CNV pin.
> + * The GPIO connected to ADC CNV pin is set outside of the SPI transfer.
> + */
> +static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec
> *chan)
> +{
> +	unsigned int cnv_to_sdi_time =3D st->turbo_mode ? AD4000_TQUIET1_NS
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : AD4000_TCONV_NS;
> +	struct spi_transfer *xfers =3D st->xfers;
> +	int ret;
> +
> +	/*
> +	 * Dummy transfer to cause enough delay between CNV going high and
> SDI
> +	 * going low.
> +	 */
> +	xfers[0].cs_off =3D 1;
> +	xfers[0].delay.value =3D cnv_to_sdi_time;
> +	xfers[0].delay.unit =3D SPI_DELAY_UNIT_NSECS;
> +
> +	xfers[1].rx_buf =3D &st->scan.data;
> +	xfers[1].len =3D BITS_TO_BYTES(chan->scan_type.storagebits);
> +
> +	spi_message_init_with_transfers(&st->msg, st->xfers, 2);
> +
> +	ret =3D spi_optimize_message(st->spi, &st->msg);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(&st->spi->dev, ad4000_unoptimize_msg,
> +					&st->msg);
> +}
> +
> +static int ad4000_convert_and_acquire(struct ad4000_state *st)
> +{
> +	int ret;
> +
> +	/*
> +	 * In 4-wire mode, the CNV line is held high for the entire
> conversion
> +	 * and acquisition process. In other modes st->cnv_gpio is NULL and
> is
> +	 * ignored (CS is wired to CNV in those cases).
> +	 */
> +	gpiod_set_value_cansleep(st->cnv_gpio, 1);

Not sure it's a good practise to assume internal details as you're going fo=
r
GPIO. I would prefer to have an explicit check for st->cnv_gpio being NULL =
or
not.
 =20
> +	ret =3D spi_sync(st->spi, &st->msg);
> +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> +
> +	return ret;
> +}
> +
> +static int ad4000_single_conversion(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan, int
> *val)
> +{
> +	struct ad4000_state *st =3D iio_priv(indio_dev);
> +	u32 sample;
> +	int ret;
> +
> +	ret =3D ad4000_convert_and_acquire(st);
>=20

no error check

> +	if (chan->scan_type.storagebits > 16)
> +		sample =3D be32_to_cpu(st->scan.data.sample_buf32);
> +	else
> +		sample =3D be16_to_cpu(st->scan.data.sample_buf16);
> +
> +	switch (chan->scan_type.realbits) {
> +	case 16:
> +		break;
> +	case 18:
> +		sample =3D FIELD_GET(AD4000_18BIT_MSK, sample);
> +		break;
> +	case 20:
> +		sample =3D FIELD_GET(AD4000_20BIT_MSK, sample);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (chan->scan_type.sign =3D=3D 's')
> +		*val =3D sign_extend32(sample, chan->scan_type.realbits - 1);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad4000_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *val,
> +			=C2=A0=C2=A0 int *val2, long info)
> +{
> +	struct ad4000_state *st =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> +			return ad4000_single_conversion(indio_dev, chan,
> val);
> +		unreachable();
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D st->scale_tbl[st->span_comp][0];
> +		*val2 =3D st->scale_tbl[st->span_comp][1];
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D 0;
> +		if (st->span_comp)
> +			*val =3D mult_frac(st->vref / 1000, 1, 10);
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4000_read_avail(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const int **vals, int *type, int *length,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 long info)
> +{
> +	struct ad4000_state *st =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals =3D (int *)st->scale_tbl;
> +		*length =3D 2 * 2;
> +		*type =3D IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, long
> mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +}
> +
> +static int ad4000_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int val, int
> val2,
> +			=C2=A0=C2=A0=C2=A0 long mask)
> +{
> +	struct ad4000_state *st =3D iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	bool span_comp_en;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			ret =3D ad4000_read_reg(st, &reg_val);
> +			if (ret < 0)
> +				return ret;
> +
> +			span_comp_en =3D (val2 =3D=3D st->scale_tbl[1][1]);

no () needed

> +			reg_val &=3D ~AD4000_CFG_SPAN_COMP;
> +			reg_val |=3D FIELD_PREP(AD4000_CFG_SPAN_COMP,
> span_comp_en);
> +
> +			ret =3D ad4000_write_reg(st, reg_val);
> +			if (ret < 0)
> +				return ret;
> +
> +			st->span_comp =3D span_comp_en;
> +			return 0;
> +		}
> +		unreachable();
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t ad4000_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct ad4000_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D ad4000_convert_and_acquire(st);
> +	if (ret < 0)
> +		goto err_out;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
> +					=C2=A0=C2=A0 iio_get_time_ns(indio_dev));
> +
> +err_out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static int ad4000_reg_access(struct iio_dev *indio_dev, unsigned int reg=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int writeval, unsigned int *readval=
)
> +{
> +	struct ad4000_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	if (readval)
> +		ret =3D ad4000_read_reg(st, readval);
> +	else
> +		ret =3D ad4000_write_reg(st, writeval);

if (readval)
	return ad4000_read_reg();

return ad4000_write_reg();


> +
> +	return ret;
> +}
> +
> +static const struct iio_info ad4000_info =3D {
> +	.read_raw =3D &ad4000_read_raw,
> +	.read_avail =3D &ad4000_read_avail,
> +	.write_raw =3D &ad4000_write_raw,
> +	.write_raw_get_fmt =3D &ad4000_write_raw_get_fmt,
> +	.debugfs_reg_access =3D &ad4000_reg_access,
> +
> +};
> +
> +static int ad4000_config(struct ad4000_state *st)
> +{
> +	unsigned int reg_val;
> +
> +	if (device_property_present(&st->spi->dev, "adi,high-z-input"))
> +		reg_val |=3D FIELD_PREP(AD4000_CFG_HIGHZ, 1);
> +
> +	/*
> +	 * The ADC SDI pin might be connected to controller CS line in which
> +	 * case the write might fail. This, however, does not prevent the
> device
> +	 * from functioning even though in a configuration other than the
> +	 * requested one.
> +	 */

This raises the question if there's any way to describe that through DT (if=
 not
doing it already)? So that, if SDI is connected to CS we don't even call th=
is?
Other question that comes to mind is that in case SDI is connected to CS, w=
ill
all writes fail? Because if that's the case we other writes (like scale) th=
at
won't work and we should take care of that...

> +	return ad4000_write_reg(st, reg_val);
> +}
> +
> +static void ad4000_regulator_disable(void *reg)
> +{
> +	regulator_disable(reg);
> +}
> +
> +static int ad4000_probe(struct spi_device *spi)
> +{
> +	const struct ad4000_chip_info *chip;
> +	struct regulator *vref_reg;
> +	struct iio_dev *indio_dev;
> +	struct ad4000_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip =3D spi_get_device_match_data(spi);
> +	if (!chip)
> +		return -EINVAL;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->spi =3D spi;
> +
> +	ret =3D devm_regulator_get_enable(&spi->dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "Failed to enable VDD
> supply\n");
> +
> +	ret =3D devm_regulator_get_enable(&spi->dev, "vio");
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "Failed to enable VIO
> supply\n");
> +
> +	vref_reg =3D devm_regulator_get(&spi->dev, "ref");
> +	if (IS_ERR(vref_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(vref_reg),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get vref regulator\n");

Should this not be an optional one? If not, why not devm_regulator_get_enab=
le()?
Also consider the new devm_regulator_get_enable_read_voltage() - you need t=
o
handle -ENODEV in case this is optional.=20

> +
> +	ret =3D regulator_enable(vref_reg);
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to enable voltage regulator\n");
> +
> +	ret =3D devm_add_action_or_reset(&spi->dev, ad4000_regulator_disable,
> vref_reg);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to add regulator disable
> action\n");
> +
> +	st->vref =3D regulator_get_voltage(vref_reg);
> +	if (st->vref < 0)
> +		return dev_err_probe(&spi->dev, st->vref, "Failed to get
> vref\n");
> +

I think in all places you're using this you st->vref / 1000, right? Do it h=
ere
just once...

> +	st->cnv_gpio =3D devm_gpiod_get_optional(&spi->dev, "cnv",
> GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->cnv_gpio))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->cnv_gpio),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get CNV GPIO");
> +
> +	ret =3D device_property_match_property_string(&spi->dev, "adi,spi-
> mode",
> +						=C2=A0=C2=A0=C2=A0 ad4000_spi_modes,
> +						=C2=A0=C2=A0=C2=A0
> ARRAY_SIZE(ad4000_spi_modes));
> +	/* Default to 4-wire mode if adi,spi-mode property is not present */
> +	if (ret =3D=3D -EINVAL)
> +		st->spi_mode =3D AD4000_SPI_MODE_DEFAULT;
> +	else if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "getting adi,spi-mode property
> failed\n");
> +	else
> +		st->spi_mode =3D ret;
> +
> +	switch (st->spi_mode) {
> +	case AD4000_SPI_MODE_DEFAULT:
> +		ret =3D ad4000_prepare_4wire_mode_message(st, &chip-
> >chan_spec);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	case AD4000_SPI_MODE_SINGLE:
> +		ret =3D ad4000_prepare_3wire_mode_message(st, &chip-
> >chan_spec);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * In "3-wire mode", the ADC SDI line must be kept high when
> +		 * data is not being clocked out of the controller.
> +		 * Request the SPI controller to make MOSI idle high.
> +		 */
> +		spi->mode =3D SPI_MODE_0 | SPI_MOSI_IDLE_HIGH;
> +		if (spi_setup(spi))
> +			dev_warn(&st->spi->dev, "SPI controller setup
> failed\n");

Does not look like a warn to me... Also, spi_setup() should already print a=
n
error message so this will duplicate that.

> +
> +		break;
> +	}
> +
> +	ret =3D ad4000_config(st);
> +	if (ret < 0)
> +		dev_dbg(&st->spi->dev, "Failed to config device\n");

Also questionable but see the my comment on ad4000_config(). In any case th=
is
should be visible to the user so I would at least use dev_warn().

> +
> +	indio_dev->name =3D chip->dev_name;
> +	indio_dev->info =3D &ad4000_info;
> +	indio_dev->channels =3D &chip->chan_spec;
> +	indio_dev->num_channels =3D 1;
> +
> +	/* Hardware gain only applies to ADAQ devices */
> +	st->gain_milli =3D 1000;
> +	if (device_property_present(&spi->dev, "adi,gain-milli")) {
> +
> +		ret =3D device_property_read_u32(&spi->dev, "adi,gain-milli",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &st->gain_milli);

Can we have full unsigned int range for the gain? I guess not :)


- Nuno S=C3=A1


Return-Path: <linux-iio+bounces-6945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1774B917F10
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 13:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341C5B20EA7
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9862C17C7C3;
	Wed, 26 Jun 2024 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyYfKCXU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7B74BF2;
	Wed, 26 Jun 2024 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399645; cv=none; b=kZPbR91m94d8DC0Sttwm7SMLNwsOn1nv2J283xjcXtwGe6E73FqW5dTmm9/CWCinJ26yebA8k1lGKwJzVO0HTIOKpIdAJPxk51/NshJlvYVTQmywE1slvB7jaQXv6B3DryqWckYw1AYZ2yooxK6QCbUNWE5m3zj29vFeoJdR9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399645; c=relaxed/simple;
	bh=YhZx4rG4dzhjg8P0ZN2xhibtt2NklnNmJJfRMuvx6As=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hytKxf6JpAjnUz//sEKR1wgShsiUFFWzOB7/03jgpz3gIV8+S8xgSQbNgJVRY3fvPEj4vyu3P0oZcIkH0PP/+4VX57WNI8vSIcQceIQjBveggUw8sIOLgg2L5SGZsM1TFfGUIHcHaDnDN9hBQXbuuD7W4fkQucfIVjhni5EqcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyYfKCXU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-363826fbcdeso4800306f8f.0;
        Wed, 26 Jun 2024 04:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719399641; x=1720004441; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zzJujuINL7mWYnWrPX7uJvSnIkkrw6c4es8CLJvCOwk=;
        b=kyYfKCXU9Xi5Tk0O86SzOJtJudOpEFm/ez2Rt+8QUP24D8o/nP6MHsQyAshEq3i+Ga
         GYFvJh3Q6bKuyRknDzwvu+y/SxknI4uCRGe4kBbc0loTKppLsoT5WPVoKfP19WcgM6B1
         Ti40TN/uSz8x7bveQfX+dptCmOC44kn7YiH8cnux7rCHVs5C4+r7BbOWQRQwhGUAiZHb
         a+/ENfKUOsQhvDsIRbpMH5c7sbdwKO47TeoSCJm3bY23KEHqQOqlPOZ7ZywuelEJQk4f
         Sl6b7vFXLRkjovGpP5Zn4RQtc+gZgN4B2+qst2yGuh3xJyJMmKyBOjohGQCRa1yNHixb
         uMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719399641; x=1720004441;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zzJujuINL7mWYnWrPX7uJvSnIkkrw6c4es8CLJvCOwk=;
        b=fch6DdwtuCMMYGISGCzosL11bG42eSegln5lfkwK36FGfm9dXPi0gM1nbGuqRLkoLV
         qUAsdcjFsuvuiRee+53Y9UCHPoRh9aDJQLBhi7NiXGWu7XNX+FMBYnUnI2M8cb6FLO0k
         XeyubcG7kChoncx3uChnGgF4mt7oL2cD4iYbt1qTxnMWW/cqplNPOW1lEJwrdgwv5Heq
         gKx7T6sdYPy6VrvcO1OlZbqu4JOX/czbF4gsEEiOpoZ+IINMupGLzZYvB8nLROPllvpN
         EJw1LhHe/l7QJ0SlwgnUArh+Xlrv5VehwOALCWnXSqicl2dq2wBVtPSUzgt7iTWBf8/i
         kVvg==
X-Forwarded-Encrypted: i=1; AJvYcCWUsO28nPE51bkWBBAm9ZzdkXU9UOlcbC3nH/sBQ2HexWoQ6vPB/s0BtgPJehmQVuCg5+yhB9PmIxp19LlWOPKdEiMjxrBo2BrL5byp+FPUIwW0taxM60C4K218cUC85J5fgXbC1/UQPS2/r8Zl8y0dxZEjmEevNh0A2++lF+FOdjEQj5G9ub4/XzJyAoJnGwIjKB2Lk9sFqzhMe4TUlw==
X-Gm-Message-State: AOJu0Ywz6HHL5TlpMV2FdyBukSgWpqUpO/4g6yILJ4bfqRatjGBSfwnb
	PyzoRTN+IGSh37Up7P+KGPWJhUWzKCjubmyHyksFL0U+AcNhegm+
X-Google-Smtp-Source: AGHT+IH5wIIFynsUSFLRMPzMUaK2jwh/6m0GskXFqU0UghRNCbLBsT3uT7pTJwG1lNF6afki2vYfow==
X-Received: by 2002:adf:e606:0:b0:366:df65:8763 with SMTP id ffacd0b85a97d-366e7a0fdc9mr7031728f8f.34.1719399641280;
        Wed, 26 Jun 2024 04:00:41 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f670csm15558309f8f.11.2024.06.26.04.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 04:00:40 -0700 (PDT)
Message-ID: <f6dc458f759c47154eee16354c807c020028512e.camel@gmail.com>
Subject: Re: [PATCH v5 6/7] iio: adc: Add support for AD4000
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org, 
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  nuno.sa@analog.com, dlechner@baylibre.com, corbet@lwn.net, 
 marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 26 Jun 2024 13:04:32 +0200
In-Reply-To: <eb5f7b73bdf3ac89117e28f26ee3f54ba849163e.1719351923.git.marcelo.schmitt@analog.com>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
	 <eb5f7b73bdf3ac89117e28f26ee3f54ba849163e.1719351923.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 18:55 -0300, Marcelo Schmitt wrote:
> Add support for AD4000 series of low noise, low power, high speed,
> successive approximation register (SAR) ADCs.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 12 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad4000.c | 711 ++++++++++++++++++++++++++++++++++++=
+++
> =C2=A04 files changed, 725 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/ad4000.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9aa6531f7cf2..f4ffedada8ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1205,6 +1205,7 @@ L:	linux-iio@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> +F:	drivers/iio/adc/ad4000.c
> =C2=A0
> =C2=A0ANALOG DEVICES INC AD4130 DRIVER
> =C2=A0M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index b8184706c7d1..5bbe843916a3 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -21,6 +21,18 @@ config AD_SIGMA_DELTA
> =C2=A0	select IIO_BUFFER
> =C2=A0	select IIO_TRIGGERED_BUFFER
> =C2=A0
> +config AD4000
> +	tristate "Analog Devices AD4000 ADC Driver"
> +	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD4000 high spe=
ed
> +	=C2=A0 SPI analog to digital converters (ADC).
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll
> be
> +	=C2=A0 called ad4000.
> +
> =C2=A0config AD4130
> =C2=A0	tristate "Analog Device AD4130 ADC Driver"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 51298c52b223..f4361df40cca 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -6,6 +6,7 @@
> =C2=A0# When adding new entries keep the list in alphabetical order
> =C2=A0obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
> =C2=A0obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> +obj-$(CONFIG_AD4000) +=3D ad4000.o
> =C2=A0obj-$(CONFIG_AD4130) +=3D ad4130.o
> =C2=A0obj-$(CONFIG_AD7091R) +=3D ad7091r-base.o
> =C2=A0obj-$(CONFIG_AD7091R5) +=3D ad7091r5.o
> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> new file mode 100644
> index 000000000000..0b6293db68dc
> --- /dev/null
> +++ b/drivers/iio/adc/ad4000.c
> @@ -0,0 +1,711 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD4000 SPI ADC driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +#include <linux/util_macros.h>
> +#include <linux/iio/iio.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
>=20

...

> +
> +static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
> +{
> +	struct spi_transfer t =3D {
> +		.tx_buf =3D st->tx_buf,
> +		.rx_buf =3D st->rx_buf,
> +		.len =3D 2,
> +	};
> +	int ret;
> +
> +	st->tx_buf[0] =3D AD4000_READ_COMMAND;
> +	ret =3D spi_sync_transfer(st->spi, &t, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val =3D st->tx_buf[1];

I'm puzzled... tx_buf?

> +	return ret;
> +}
> +
> +/*
> + * This executes a data sample transfer for when the device connections =
are
> + * in "3-wire" mode, selected when the adi,sdi-pin device tree property =
is
> + * absent or set to "high". In this connection mode, the ADC SDI pin is
> + * connected to MOSI or to VIO and ADC CNV pin is connected either to a =
SPI
> + * controller CS or to a GPIO.
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
> +	return devm_spi_optimize_message(st->spi, &st->msg);
> +}
> +
> +/*
> + * This executes a data sample transfer for when the device connections =
are
> + * in "4-wire" mode, selected when the adi,sdi-pin device tree property =
is
> + * set to "cs". In this connection mode, the controller CS pin is connec=
ted
> to
> + * ADC SDI pin and a GPIO is connected to ADC CNV pin.
> + * The GPIO connected to ADC CNV pin is set outside of the SPI transfer.
> + */
> +static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec
> *chan)
> +{
> +	unsigned int cnv_to_sdi_time =3D st->turbo_mode ? AD4000_TQUIET1_NS
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : AD4000_TCONV_NS;
> +	struct spi_transfer *xfers =3D st->xfers;
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
> +	return devm_spi_optimize_message(st->spi, &st->msg);
> +}

nit: you could reduce the scope of the above prepare functions...

> +
> +static int ad4000_convert_and_acquire(struct ad4000_state *st)
> +{
> +	int ret;
> +
> +	/*
> +	 * In 4-wire mode, the CNV line is held high for the entire
> conversion
> +	 * and acquisition process. In other modes, the CNV GPIO is optional
> +	 * and, if provided, replaces controller CS. If CNV GPIO is not
> defined
> +	 * gpiod_set_value_cansleep() has no effect.
> +	 */
> +	gpiod_set_value_cansleep(st->cnv_gpio, 1);
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
> +	if (ret < 0)
> +		return ret;
> +
> +	if (chan->scan_type.storagebits > 16)
> +		sample =3D be32_to_cpu(st->scan.data.sample_buf32);

Just a minor note regarding your comment in the cover. FWIW, I prefer you l=
eave
it like this. Yes, with 24 bits you save some space but then you need an
unaligned access... To me that space savings are really a micro optimizatio=
n so
I would definitely go with the simpler form.

> +	else
> +		sample =3D be16_to_cpu(st->scan.data.sample_buf16);
> +
> +	sample >>=3D chan->scan_type.shift;
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
> +			*val =3D mult_frac(st->vref_mv, 1, 10);
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
> +		*length =3D AD4000_SCALE_OPTIONS * 2;
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
> +		ret =3D iio_device_claim_direct_mode(indio_dev);

iio_device_claim_direct_scoped()?

> +		if (ret < 0)
> +			return ret;
> +
> +		mutex_lock(&st->lock);

guard()?

> +		ret =3D ad4000_read_reg(st, &reg_val);
> +		if (ret < 0)
> +			goto err_unlock;
> +
> +		span_comp_en =3D val2 =3D=3D st->scale_tbl[1][1];
> +		reg_val &=3D ~AD4000_CFG_SPAN_COMP;
> +		reg_val |=3D FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_en);
> +
> +		ret =3D ad4000_write_reg(st, reg_val);
> +		if (ret < 0)
> +			goto err_unlock;
> +
> +		st->span_comp =3D span_comp_en;
> +err_unlock:
> +		iio_device_release_direct_mode(indio_dev);
> +		mutex_unlock(&st->lock);
> +		return ret;
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
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, pf-
> >timestamp);
> +
> +err_out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info ad4000_reg_access_info =3D {
> +	.read_raw =3D &ad4000_read_raw,
> +	.read_avail =3D &ad4000_read_avail,
> +	.write_raw =3D &ad4000_write_raw,
> +	.write_raw_get_fmt =3D &ad4000_write_raw_get_fmt,
> +};
> +
> +static const struct iio_info ad4000_info =3D {
> +	.read_raw =3D &ad4000_read_raw,
> +};
> +
> +static int ad4000_config(struct ad4000_state *st)
> +{
> +	unsigned int reg_val =3D AD4000_CONFIG_REG_DEFAULT;
> +
> +	if (device_property_present(&st->spi->dev, "adi,high-z-input"))
> +		reg_val |=3D FIELD_PREP(AD4000_CFG_HIGHZ, 1);
> +
> +	return ad4000_write_reg(st, reg_val);
> +}
> +
> +static int ad4000_probe(struct spi_device *spi)
> +{
> +	const struct ad4000_chip_info *chip;
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4000_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
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
> +	ret =3D devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable VDD
> supply\n");
> +
> +	ret =3D devm_regulator_get_enable(dev, "vio");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable VIO
> supply\n");

devm_regulator_bulk_get_enable()? Do we have any ordering constrains?

> +
> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get ref regulator
> reference\n");
> +	st->vref_mv =3D ret / 1000;
> +
> +	st->cnv_gpio =3D devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->cnv_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get CNV GPIO");
> +
> +	ret =3D device_property_match_property_string(dev, "adi,sdi-pin",
> +						=C2=A0=C2=A0=C2=A0 ad4000_sdi_pin,
> +						=C2=A0=C2=A0=C2=A0
> ARRAY_SIZE(ad4000_sdi_pin));
> +	if (ret < 0 && ret !=3D -EINVAL)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "getting adi,sdi-pin property
> failed\n");
> +
> +	/* Default to usual SPI connections if pin properties are not present
> */
> +	st->sdi_pin =3D ret =3D=3D -EINVAL ? AD4000_SDI_MOSI : ret;
> +	switch (st->sdi_pin) {
> +	case AD4000_SDI_MOSI:
> +		indio_dev->info =3D &ad4000_reg_access_info;
> +		indio_dev->channels =3D &chip->reg_access_chan_spec;
> +
> +		/*
> +		 * In "3-wire mode", the ADC SDI line must be kept high when
> +		 * data is not being clocked out of the controller.
> +		 * Request the SPI controller to make MOSI idle high.
> +		 */
> +		spi->mode |=3D SPI_MOSI_IDLE_HIGH;
> +		ret =3D spi_setup(spi);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D ad4000_prepare_3wire_mode_message(st, indio_dev-
> >channels);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D ad4000_config(st);
> +		if (ret < 0)
> +			dev_warn(dev, "Failed to config device\n");
> +

Should this be a warning? Very suspicious :)

> +		break;
> +	case AD4000_SDI_VIO:
> +		indio_dev->info =3D &ad4000_info;
> +		indio_dev->channels =3D &chip->chan_spec;
> +		ret =3D ad4000_prepare_3wire_mode_message(st, indio_dev-
> >channels);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	case AD4000_SDI_CS:
> +		indio_dev->info =3D &ad4000_info;
> +		indio_dev->channels =3D &chip->chan_spec;
> +		ret =3D ad4000_prepare_4wire_mode_message(st, indio_dev-
> >channels);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL, "Unrecognized connection
> mode\n");
> +	}
> +
> +	indio_dev->name =3D chip->dev_name;
> +	indio_dev->num_channels =3D 1;
> +
> +	devm_mutex_init(dev, &st->lock);
> +
> +	st->gain_milli =3D 1000;
> +	if (chip->has_hardware_gain) {
> +		if (device_property_present(dev, "adi,gain-milli")) {
> +			ret =3D device_property_read_u16(dev, "adi,gain-milli",
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &st->gain_milli);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to read gain
> property\n");
> +		}
>=20

the above looks odd. Why not?

ret =3D device_property_read_u16(dev, "adi,gain-milli", &st->gain_milli);
if (!ret) {
	...
}

Note that you're also allowing any value for gain_milli when we just allow =
some
of them (according to the bindings). Hence you should make sure we get supp=
orted
values from FW.

- Nuno S=C3=A1


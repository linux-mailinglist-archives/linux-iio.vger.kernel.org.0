Return-Path: <linux-iio+bounces-25197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8BFBE986B
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 17:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB32742001
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD3632E155;
	Fri, 17 Oct 2025 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWvxfbtm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D52F12B0
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713317; cv=none; b=X+nAjyw0wiAhYp10kt9jmbN4BywPl3U48bP21frglj3QVHuZvkQZQHOt7Muz7HppjcbwEJ0Redot06edaK5qPmIcvTraq9fDdn520aeSVWJsyD6H0STMi7uFZbKfzq2ZIjNYqafuXhSxs4wSCGFdYJLE94Nuo+INzizMN3ltagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713317; c=relaxed/simple;
	bh=+xrczsUuKYuB1espPCeVqCRItUgne3A1DqEB9Uh+O2M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EGaQrpEDJcumrKn3esyJSEomaNRIiyrScBuFqbUMqXUm83mTsFIcWVUfT+1kqESonfkNATyqtyvXSF1WYW+0axcnGYtmW3iVP4p6rEqnsDBJO7bcgkX8ylHPzEsR/qLc3IpYl32JBiqAJo9bNTAcfkPHfX+M4H36wX7wIrlkQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWvxfbtm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so19051635e9.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760713313; x=1761318113; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kVxsWgSHrz2oyX3c7E12BLJmLZ3gHeLAN/+wo/mUNOw=;
        b=MWvxfbtmPdvvbVd6H8xKJ/AvJWy3ieZmoNR/qZ2cRvgqTvwfYHKpikW+0mYmozZ5bQ
         Q3P0GBgWwWE8ERRc4iyUlRcaMWGfx2gDHjfP0LsMdIIC7CULICcCDJjRlBe7YJLdzcb9
         CWLisyMUYKcxpiFPf46EES8SxoH445wyMaiA4bm5lKkHpos6L77fALx2mFj1rPBJlB9y
         Ig7rUJMI8y+iLYovgb6XoTBgIjDCY2ReKx0txmrp2f1Ez59Yu7MbliLkifE6JVoFxAxv
         C864GVGbtSSjs/IZQKC/tdc9UlEF6mA7Gy6mH2AoXa6rCdjnUgn4JhWZijeococYontf
         bEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760713313; x=1761318113;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kVxsWgSHrz2oyX3c7E12BLJmLZ3gHeLAN/+wo/mUNOw=;
        b=cga/0s9ky+yVAwwgs5xv3T2iye/M9XdH8JFDvJe7KOd3ZC4Kx+MryqlpAlSCPMjIxy
         JQvAE7q8agz6DgW6rUXIV/B0AJ1u3y2c/bjku+71yimwV+r+oX/3gWUzrO4bLJmCwv9E
         e8ggMCGlEho9VAThGuCUm1PKgF1Jx/sR2fOZb9eCMC67m2QFMkEoG0Ckv9OF0jNlhD1t
         pxdQ0kRk2UIx3tcanj7EAqaZiInDzUwtUY8Pp06iDjFllNwnF5V4cuc1+JHDU7cgk1Bh
         dO7WvtoLvwe8N3glQ4VWIo3FIRL199Lf9oMNTPzx4LN79DkshlSyC5kkGqdn9VPI2mhY
         F+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTtLNFwzFJV1cUgwTsrt4xdb+TO6ZpFAdSO7NdYIBBpnEZvr3fZeaER9FEMvqiKGGzmd4fWxhtZhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv28/l7vyMw85TbOz4fTqjjlqKPe0+i7TqvJrkiDO8MUHvT/+q
	3SHgq7KjMZSq0umy9ToiN0HTS2OWJrM+m2Y4BApiRAq7yqpCem5Ig8N5
X-Gm-Gg: ASbGnctQshaiOAh9H9GlDhefmlbw8B0VXdyaO7C4yGUGS4ANKNYXJ6Oo9Y7ksDYXE+Y
	+kYk/56dAi//aHLXTZuDlNfCvXyO2rDZevy9FGyTAsECrZV108kxIMMMrAflIBgOPIlBJzdqYX3
	nRPOxvAer2gJFS0SS9DaVSRk1ZFUwN7gfJThbHOPpL3bwjOyJugIVo6ZdmIEHWwPQFpVbnUTtju
	Jzl5spbVLfC/tsqrRfUDoMsOOD2VngXRhNBKzl3h452cj8Tr/ttSeoVcp2rWWSsqiQ8CgskD/is
	JqH95afny4011q1FoDHEsDy7U9vgQq4vJSkwfPLVLvHKl9ubpnxZ//3xQcN/2lQ2WVzKk1ri5K6
	+rEbcNBvB7At/vrZL0lsl15m6QTTbJpa4Osyzc5C7DUGkDMyJViahNRiKMiRM5jvPRTUC4XxazI
	kttzUezRsicw/FlCd0ais=
X-Google-Smtp-Source: AGHT+IFKXFQd8yXkVDBCZ/mYOBoCZz26SV1cuRznvpqDSwoEzQXZgRlwQyeEdrEnMqY79Pnm7nrISA==
X-Received: by 2002:a05:600c:681b:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-47117925e39mr34862695e9.36.1760713312831;
        Fri, 17 Oct 2025 08:01:52 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144516fasm94167575e9.16.2025.10.17.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:01:52 -0700 (PDT)
Message-ID: <5e3a1d31f3cec340650e2e63db79903b78ab9a1f.camel@gmail.com>
Subject: Re: [PATCH v5 5/7] iio: adc: ad4030: Add SPI offload support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com, 
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
 robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net, 
	marcelo.schmitt1@gmail.com, Trevor Gamblin <tgamblin@baylibre.com>, Axel
 Haslam	 <ahaslam@baylibre.com>
Date: Fri, 17 Oct 2025 16:02:24 +0100
In-Reply-To: <c12569f251962ad6034395e53cd6d998ce78a63f.1760479760.git.marcelo.schmitt@analog.com>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
	 <c12569f251962ad6034395e53cd6d998ce78a63f.1760479760.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-14 at 19:22 -0300, Marcelo Schmitt wrote:
> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> samples per second (MSPS). Not all SPI controllers are able to achieve su=
ch
> high throughputs and even when the controller is fast enough to run
> transfers at the required speed, it may be costly to the CPU to handle
> transfer data at such high sample rates. Add SPI offload support for AD40=
30
> and similar ADCs to enable data capture at maximum sample rates.
>=20
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Hi Marcelo,

> Change log v4 -> v5
> - Made Kconfig entry depend on PWM and select other features.
> - Reused ad4030_exit_config_mode() in ad4030_offload_buffer_postenable().
> - Dropped common-mode voltage support on SPI offload setup.
> - Adjusted offload trigger period calculation.
> - No longer setting data frame mode from ad4030_set_avg_frame_len().
> - Rearranged code to reduce patch diff.
>=20
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 5 +
> =C2=A0drivers/iio/adc/ad4030.c | 425 ++++++++++++++++++++++++++++++++++++=
+--
> =C2=A02 files changed, 416 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index b0580fcefef5..f76df0609b3d 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -60,9 +60,14 @@ config AD4030
> =C2=A0	tristate "Analog Devices AD4030 ADC Driver"
> =C2=A0	depends on SPI
> =C2=A0	depends on GPIOLIB
> +	depends on PWM
> =C2=A0	select REGMAP
> =C2=A0	select IIO_BUFFER
> +	select IIO_BUFFER_DMA
> +	select IIO_BUFFER_DMAENGINE
> =C2=A0	select IIO_TRIGGERED_BUFFER
> +	select SPI_OFFLOAD
> +	select SPI_OFFLOAD_TRIGGER_PWM
> =C2=A0	help
> =C2=A0	=C2=A0 Say yes here to build support for Analog Devices AD4030 and=
 AD4630
> high speed
> =C2=A0	=C2=A0 SPI analog to digital converters (ADC).
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index b2847fd90271..3df0b593c808 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -14,15 +14,25 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> =C2=A0#include <linux/clk.h>
> +#include <linux/dmaengine.h>
> +#include <linux/iio/buffer-dmaengine.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/trigger_consumer.h>
> =C2=A0#include <linux/iio/triggered_buffer.h>
> +#include <linux/limits.h>
> +#include <linux/log2.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/pwm.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/regulator/consumer.h>
> +#include <linux/spi/offload/consumer.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0#include <linux/unaligned.h>
> =C2=A0#include <linux/units.h>
> +#include <linux/types.h>

...

>=20
> +
> +static int ad4030_set_sampling_freq(struct iio_dev *indio_dev, int freq_=
hz)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +
> +	/*
> +	 * We have no control over the sampling frequency without SPI offload
> +	 * triggering.
> +	 */
> +	if (!st->offload_trigger)
> +		return -ENODEV;
>=20

Isn't the frequency control only available for offload channels? If I'm not
missing nothing the trigger isn't optional either so I would say the above
should never happen.

> +	if (!in_range(freq_hz, 1, st->chip->max_sample_rate_hz))
> +		return -EINVAL;
> +
> +	return ad4030_update_conversion_rate(st, freq_hz, st->avg_log2);
> +}
> +
> =C2=A0static int ad4030_set_chan_calibscale(struct iio_dev *indio_dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan=
,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int gain_int,
> @@ -512,11 +643,30 @@ static int ad4030_set_avg_frame_len(struct iio_dev =
*dev,
> int avg_val)
> =C2=A0	struct ad4030_state *st =3D iio_priv(dev);
> =C2=A0	unsigned int avg_log2 =3D ilog2(avg_val);
> =C2=A0	unsigned int last_avg_idx =3D ARRAY_SIZE(ad4030_average_modes) - 1=
;
> +	int freq_hz;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> =C2=A0		return -EINVAL;
> =C2=A0
> +	if (st->offload_trigger) {
> +		/*
> +		 * The sample averaging and sampling frequency configurations
> +		 * are mutually dependent one from another. That's because
> the
> +		 * effective data sample rate is fCNV / 2^N, where N is the
> +		 * number of samples being averaged.
> +		 *
> +		 * When SPI offload is supported and we have control over the
> +		 * sample rate, the conversion start signal (CNV) and the SPI
> +		 * offload trigger frequencies must be re-evaluated so data
> is
> +		 * fetched only after 'avg_val' conversions.
> +		 */
> +		ad4030_get_sampling_freq(st, &freq_hz);
> +		ret =3D ad4030_update_conversion_rate(st, freq_hz, avg_log2);
> +		if (ret)
> +			return ret;
> +	}
> +
> =C2=A0	ret =3D regmap_write(st->regmap, AD4030_REG_AVG,
> =C2=A0			=C2=A0=C2=A0 AD4030_REG_AVG_MASK_AVG_SYNC |
> =C2=A0			=C2=A0=C2=A0 FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL,
> avg_log2));
> @@ -769,6 +919,13 @@ static int ad4030_read_raw_dispatch(struct iio_dev
> *indio_dev,
> =C2=A0		*val =3D BIT(st->avg_log2);
> =C2=A0		return IIO_VAL_INT;
> =C2=A0
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (!st->offload_trigger)
> +			return -ENODEV;

same

> +
> +		ad4030_get_sampling_freq(st, val);
> +		return IIO_VAL_INT;
> +
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -809,6 +966,9 @@ static int ad4030_write_raw_dispatch(struct iio_dev
> *indio_dev,
> =C2=A0	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> =C2=A0		return ad4030_set_avg_frame_len(indio_dev, val);
> =C2=A0
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4030_set_sampling_freq(indio_dev, val);
> +
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -898,6 +1058,104 @@ static const struct iio_buffer_setup_ops
> ad4030_buffer_setup_ops =3D {
> =C2=A0	.validate_scan_mask =3D ad4030_validate_scan_mask,
> =C2=A0};
> =C2=A0
> +static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	u8 offload_bpw;
> +
> +	if (st->mode =3D=3D AD4030_OUT_DATA_MD_30_AVERAGED_DIFF)
> +		offload_bpw =3D 32;
> +	else
> +		offload_bpw =3D st->chip->precision_bits;
> +
> +	st->offload_xfer.bits_per_word =3D offload_bpw;
> +	st->offload_xfer.len =3D spi_bpw_to_bytes(offload_bpw);
> +	st->offload_xfer.offload_flags =3D SPI_OFFLOAD_XFER_RX_STREAM;
> +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer,
> 1);
> +}
> +
> +static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st =3D iio_priv(indio_dev);
> +	unsigned int reg_modes;
> +	int ret, ret2;
> +
> +	/*
> +	 * When data from 2 analog input channels is output through a single
> +	 * bus line (interleaved mode (LANE_MD =3D=3D 0b11)) and gets pushed
> through
> +	 * DMA, extra hardware is required to do the de-interleaving. While
> we
> +	 * don't support such hardware configurations, disallow interleaved
> mode
> +	 * when using SPI offload.
> +	 */
> +	ret =3D regmap_read(st->regmap, AD4030_REG_MODES, &reg_modes);
> +	if (ret)
> +		return ret;
> +
> +	if (st->chip->num_voltage_inputs > 1 &&
> +	=C2=A0=C2=A0=C2=A0 FIELD_GET(AD4030_REG_MODES_MASK_LANE_MODE, reg_modes=
) =3D=3D
> AD4030_LANE_MD_INTERLEAVED)
> +		return -EINVAL;
> +
> +	ret =3D ad4030_exit_config_mode(st);
> +	if (ret)
> +		return ret;
> +
> +	ad4030_prepare_offload_msg(indio_dev);
> +	st->offload_msg.offload =3D st->offload;
> +	ret =3D spi_optimize_message(st->spi, &st->offload_msg);
> +	if (ret)
> +		goto out_reset_mode;
> +
> +	ret =3D pwm_set_waveform_might_sleep(st->cnv_trigger, &st->cnv_wf,
> false);
> +	if (ret)
> +		goto out_unoptimize;
> +
> +	ret =3D spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &st->offload_trigger_config);
> +	if (ret)
> +		goto out_pwm_disable;
> +
> +	return 0;
> +
> +out_pwm_disable:
> +	pwm_disable(st->cnv_trigger);
> +out_unoptimize:
> +	spi_unoptimize_message(&st->offload_msg);
> +out_reset_mode:
> +	/* reenter register configuration mode */
> +	ret2 =3D ad4030_enter_config_mode(st);

nit: if ret2 is not being used at all, maybe just

if (ad4030_enter_config_mode(st))
=09
> +	if (ret2)
> +		dev_err(&st->spi->dev,
> +			"couldn't reenter register configuration mode: %d\n",
> +			ret2);
> +
> +	return ret;
> +}
>=20

...

>=20
> =C2=A0static int ad4030_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	struct device *dev =3D &spi->dev;
> @@ -1045,24 +1346,61 @@ static int ad4030_probe(struct spi_device *spi)
> =C2=A0		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get cnv gpio\n");
> =C2=A0
> -	/*
> -	 * One hardware channel is split in two software channels when using
> -	 * common byte mode. Add one more channel for the timestamp.
> -	 */
> -	indio_dev->num_channels =3D 2 * st->chip->num_voltage_inputs + 1;
> =C2=A0	indio_dev->name =3D st->chip->name;
> =C2=A0	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =C2=A0	indio_dev->info =3D &ad4030_iio_info;
> -	indio_dev->channels =3D st->chip->channels;
> =C2=A0	indio_dev->available_scan_masks =3D st->chip->available_masks;
> =C2=A0
> -	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_pollfunc_store_time,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad4030_trigger_handler,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ad4030_buffer_setup_ops);
> -	if (ret)
> -		return dev_err_probe(dev, ret,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to setup triggered buffer\n");
> +	st->offload =3D devm_spi_offload_get(dev, spi, &ad4030_offload_config);
> +	ret =3D PTR_ERR_OR_ZERO(st->offload);
> +	if (ret && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to get offload\n");
> +
> +	/* Fall back to low speed usage when no SPI offload is available. */
> +	if (ret =3D=3D -ENODEV) {
> +		/*
> +		 * One hardware channel is split in two software channels
> when
> +		 * using common byte mode. Add one more channel for the
> timestamp.
> +		 */
> +		indio_dev->num_channels =3D 2 * st->chip->num_voltage_inputs +
> 1;
> +		indio_dev->channels =3D st->chip->channels;
> +
> +		ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> iio_pollfunc_store_time,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad4030_trigger_handler,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> &ad4030_buffer_setup_ops);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to setup triggered
> buffer\n");
> +	} else {
> +		/*
> +		 * One hardware channel is split in two software channels
> when
> +		 * using common byte mode. Offloaded SPI transfers can't
> support
> +		 * software timestamp so no additional timestamp channel is
> added.
> +		 */
> +		indio_dev->num_channels =3D 2 * st->chip->num_voltage_inputs;

Maybe I'm missing something but common mode is not supported for now so isn=
't
the above wrong?

- Nuno S=C3=A1


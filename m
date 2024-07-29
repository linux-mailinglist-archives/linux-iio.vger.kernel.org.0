Return-Path: <linux-iio+bounces-8035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD7D94007C
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 23:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B7D1C220B7
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 21:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C6E18C358;
	Mon, 29 Jul 2024 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="BQmUqUdF"
X-Original-To: linux-iio@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-68.smtpout.orange.fr [80.12.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41337D3F1;
	Mon, 29 Jul 2024 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288884; cv=none; b=QTDsXZMZKJC03HctRiWu1TADtwhYJeGNanL7PyWZbjLGSWtuuhMBUPHvi+SOVpRAMm7RjJOkX98NsiXc8z9EwMDDo4aUrVS50nPu7LM9HlCswbTnN0CHkyHVRUodGWFco3FfN7ag7HRAXZ60Mz2rPLPh0VXV625es8fnJ5K3ZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288884; c=relaxed/simple;
	bh=3+pwqht9xHkMiBhYxd7W7IBBqiquaAIYlWA4EU4Jh5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ee00tpLpJKpPOqEqZZvGEmqOo7EG/LCq3yPr/nuKPJNw0sgFi8G0PCi4i5UKM426lknu9s/arnZxy5uFyHVvM6h+UVckJa2QrMIq48MitnaD+3G8sjLZOThWLy820XOJrdhc5bLxAXUknvvWVHS43vAgC3VrR59pxlClarmoij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=BQmUqUdF; arc=none smtp.client-ip=80.12.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id YY0ksSWFSN67nYY0lstwr6; Mon, 29 Jul 2024 23:34:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722288873;
	bh=ucumROewCOlJ/+rkXDYdvCUcwadsziBKuLfZMTTlVCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=BQmUqUdFImiktTc2UhLFzwAfTSFqRGo1TXLFX9xhyScHS18InvAC1p7Valv8yvQiB
	 cBs2QvzMtQbxsyqn9qc11jyIjSaLjeqUQR0/hc4ECUqzjC4AL2ygV8vu8wzBjdNzlL
	 j8pl7tSVsOBTsrMaIg+i/ryqarHvy+L8hyjisZLGvWfO/fDJS1wID3rL0QSloJafKe
	 1HkT3yjpUY4M1WlMJTPaoelvV8Y3I4CbOSzfKc1jRES67+A3iNExzfUNr+qtzPE24j
	 zT+p2KXNj+ToGS/txNbdH9i08GuWHsB/mJFFkyBxtUfyCnnlecNnJJb4ZF+amL/B70
	 YDToJtZBthbkg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 29 Jul 2024 23:34:33 +0200
X-ME-IP: 90.11.132.44
Message-ID: <aeb5e95a-f108-4b23-b14b-c9fe1463775e@wanadoo.fr>
Date: Mon, 29 Jul 2024 23:34:30 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/5] iio: adc: ad4030: add driver for ad4030-24
To: eblanc@baylibre.com
Cc: Michael.Hennerich@analog.com, baylibre-upstreaming@groups.io,
 conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com,
 jic23@kernel.org, krzk+dt@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 robh@kernel.org
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
 <20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 27/06/2024 à 13:59, Esteban Blanc a écrit :
> This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> 
> The driver implements basic support for the AD4030-24 1 channel
> differential ADC with hardware gain and offset control.
> 
> Signed-off-by: Esteban Blanc <eblanc-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---

Hi,

a few nitpick below, should it help.

...

> +static int ad4030_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *channel,
> +			     const int **vals, int *type,
> +			     int *length, long mask)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*vals = ad4030_get_offset_avail(st);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*vals = (void *)ad4030_gain_avail;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_RANGE;

Nitpick: in other switch below, there is a blank line before default:

> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int ad4030_regulators_get(struct ad4030_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	static const char * const ids[] = {"vdd-5v", "vdd-1v8"};
> +	int ret;
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ids), ids);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +
> +	st->vio_uv = devm_regulator_get_enable_read_voltage(dev, "vio");
> +	if (st->vio_uv < 0)
> +		return dev_err_probe(dev, st->vio_uv,
> +				     "Failed to enable and read vio voltage");

Nitpick: missing \n

> +
> +	st->vref_uv = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (st->vref_uv < 0) {
> +		if (st->vref_uv != -ENODEV)
> +			return dev_err_probe(dev, st->vref_uv,
> +					     "Failed to read vref voltage");

Nitpick: missing \n

> +
> +		/* if not using optional REF, the internal REFIN must be used */
> +		st->vref_uv = devm_regulator_get_enable_read_voltage(dev, "refin");
> +		if (st->vref_uv < 0)
> +			return dev_err_probe(dev, st->vref_uv,
> +					     "Failed to read vrefin voltage");

Nitpick: missing \n

> +	}
> +
> +	if (st->vref_uv < AD4030_VREF_MIN_UV || st->vref_uv > AD4030_VREF_MAX_UV)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "vref(%d) must be in the range [%lu %lu]\n",
> +				     st->vref_uv, AD4030_VREF_MIN_UV,
> +				     AD4030_VREF_MAX_UV);
> +
> +	return 0;
> +}

...

> +static int ad4030_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4030_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));

Nitpick: dev could be used. It is the same &spi->dev

> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	/* Make sure the SPI clock is within range to read register */
> +	st->conversion_speed_hz = spi->max_speed_hz;
> +	if (spi->max_speed_hz > AD4030_SPI_MAX_REG_XFER_SPEED)
> +		spi->max_speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED;
> +
> +	st->regmap = devm_regmap_init(&spi->dev, &ad4030_regmap_bus, st,

Nitpick: dev could be used. It is the same &spi->dev

> +				      &ad4030_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		dev_err_probe(&spi->dev, PTR_ERR(st->regmap),

Nitpick: dev could be used. It is the same &spi->dev

> +			      "Failed to initialize regmap\n");
> +
> +	st->chip = spi_get_device_match_data(spi);
> +	if (!st->chip)
> +		return -EINVAL;
> +
> +	ret = ad4030_regulators_get(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4030_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4030_detect_chip_info(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4030_config(st);
> +	if (ret)
> +		return ret;
> +
> +	st->cnv_gpio = devm_gpiod_get(dev, "cnv", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->cnv_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
> +				     "Failed to get cnv gpio");

Nitpick: missing \n

> +
> +	indio_dev->name = st->chip->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ad4030_iio_info;
> +	indio_dev->channels = st->chip->channels;
> +	indio_dev->num_channels =  2 * st->chip->num_channels + 1;

Nitpick : 2 spaces after =

> +	indio_dev->available_scan_masks = st->chip->available_masks;
> +	indio_dev->masklength = st->chip->available_masks_len;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      ad4030_trigger_handler,
> +					      &ad4030_buffer_setup_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup triggered buffer\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

...

CJ



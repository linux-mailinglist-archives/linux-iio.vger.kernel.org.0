Return-Path: <linux-iio+bounces-15949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3F0A40930
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE69B17D392
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E70216B3A1;
	Sat, 22 Feb 2025 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqnn1A+M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E783145348
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740235495; cv=none; b=YLAg+lcYvalSKKxZ9AKEIEn1HM9Ht68HWAHrkKAtSHlbt41XvCQZFIM95hUhhT0i/juPFrJx4xw5wQSFtaNtvdDalOTvNRARcV3ZbEnWnT8drIngJ4JpLtdtJgvmbYKQlr6FiOJAM9e2PXh3iXu7FMmzvtUK7h5xgMBU02/H78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740235495; c=relaxed/simple;
	bh=jvG6erYt4KEE8wjRQ+1V/RTDiCd1wEKtuCmWCYmZ+t8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UT8HKl8K+Mzo8vrArOmxE3wA2QF45Q+4M50LxHtWxQThtudsC3f7/y/aXiResRo0vi84maSPodJflINFYNE5C9tc82j/B3whUL1L9QVbwHsobo7d9fdcCvJT81NNHbaMJk9GXld56igQfB8HOWhx5hto+6NZMvPWnlJtyGhVqjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqnn1A+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCE5C4CED1;
	Sat, 22 Feb 2025 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740235493;
	bh=jvG6erYt4KEE8wjRQ+1V/RTDiCd1wEKtuCmWCYmZ+t8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iqnn1A+MjcjYJiOzhV2d6ZqyDl18BxyTUdVt1g/SqJM/HVVsgoF1JC7Unck9GDfxF
	 Ox9pelBnyW6C3UoypPmiBKfTEXrTi4l0YAtAIVI93229sd836l8QakbbJo0qlLBsUy
	 NDz1jVyRPHrfuFyM0cC7GMDh5H8wYhCdKyqYsfEP/6UsbGeJNBFs2isar95jtMdcml
	 1JjaXddVlM70uC8Y3zRN6QfkErcN3SEGtqLa0REvsmv4qQ17lsKiOTq4w5ojtkMXI5
	 fvAFNq4ROSXWUjvtE8OxU2l771lYSAsh0T2dZAE/1OMh69QZU5IjHgutZLA4TY9Fyw
	 UGzylgR6tUO8g==
Date: Sat, 22 Feb 2025 14:44:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: adc: ad7124: Implement internal calibration
 at probe time
Message-ID: <20250222144449.43ad5948@jic23-huawei>
In-Reply-To: <deef14543f8f5ff34076e69d90711bbe719c4d12.1739902968.git.u.kleine-koenig@baylibre.com>
References: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
	<deef14543f8f5ff34076e69d90711bbe719c4d12.1739902968.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Feb 2025 19:31:12 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Use the calibration function provided by the ad_sigma_delta shim to
> calibrate all channels at probe time.
>=20
> For measurements with gain 1 (i.e. if CONFIG_x.PGA =3D 0) full-scale
> calibrations are not supported and the reset default value of the GAIN
> register is supposed to be used then.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
one passing comment inline.=20

> +static int ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev =
*indio_dev)
> +{
> +	struct device *dev =3D &st->sd.spi->dev;
> +	int ret, i;
> +	unsigned int adc_control =3D st->adc_control;
Maybe factor out from here...
> +
> +	/*
> +	 * Calibration isn't supported at full power, so speed down a bit.
> +	 * Setting .adc_control is enough here because the control register is
> +	 * written as part of ad_sd_calibrate() -> ad_sigma_delta_set_mode().
> +	 */
> +	if (FIELD_GET(AD7124_ADC_CTRL_PWR_MSK, adc_control) >=3D AD7124_FULL_PO=
WER) {
> +		st->adc_control &=3D ~AD7124_ADC_CTRL_PWR_MSK;
> +		st->adc_control |=3D AD7124_ADC_CTRL_PWR(AD7124_MID_POWER);
> +	}
> +
> +	for (i =3D 0; i < st->num_channels; i++) {
> +
> +		if (indio_dev->channels[i].type !=3D IIO_VOLTAGE)
> +			continue;
> +
> +		/*
> +		 * For calibration the OFFSET register should hold its reset default
> +		 * value. For the GAIN register there is no such requirement but
> +		 * for gain 1 it should hold the reset default value, too. So to
> +		 * simplify matters use the reset default value for both.
> +		 */
> +		st->channels[i].cfg.calibration_offset =3D 0x800000;
> +		st->channels[i].cfg.calibration_gain =3D st->gain_default;
> +
> +		/*
> +		 * Full-scale calibration isn't supported at gain 1, so skip in
> +		 * that case. Note that untypically full-scale calibration has
> +		 * to happen before zero-scale calibration. This only applies to
> +		 * the internal calibration. For system calibration it's as
> +		 * usual: first zero-scale then full-scale calibration.
> +		 */
> +		if (st->channels[i].cfg.pga_bits > 0) {
> +			ret =3D ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_INT_FULL, i);
> +			if (ret < 0)
> +				goto out;
> +
> +			/*
> +			 * read out the resulting value of GAIN
> +			 * after full-scale calibration because the next
> +			 * ad_sd_calibrate() call overwrites this via
> +			 * ad_sigma_delta_set_channel() -> ad7124_set_channel()
> +			 * ... -> ad7124_enable_channel().
> +			 */
> +			ret =3D ad_sd_read_reg(&st->sd, AD7124_GAIN(st->channels[i].cfg.cfg_s=
lot), 3,
> +					     &st->channels[i].cfg.calibration_gain);
> +			if (ret < 0)
> +				goto out;
> +		}
> +
> +		ret =3D ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_INT_ZERO, i);
> +		if (ret < 0)
> +			goto out;
> +
> +		ret =3D ad_sd_read_reg(&st->sd, AD7124_OFFSET(st->channels[i].cfg.cfg_=
slot), 3,
> +				     &st->channels[i].cfg.calibration_offset);
> +		if (ret < 0)
> +			goto out;
> +
> +		dev_dbg(dev, "offset and gain for channel %d =3D 0x%x + 0x%x\n", i,
> +			st->channels[i].cfg.calibration_offset,
> +			st->channels[i].cfg.calibration_gain);
> +	}

to here as a ad7124_do_calibrate_all() or something like that.
Then you can do direct returns and it becomes really obvious this function
is stashing and restoring the adc_control value.

I don't mind that much as the flow is fairly simple.

> +
> +out:
> +	st->adc_control =3D adc_control;
> +
> +	return ret;
> +}
> +
>  static void ad7124_reg_disable(void *r)
>  {
>  	regulator_disable(r);
> @@ -1132,6 +1241,10 @@ static int ad7124_probe(struct spi_device *spi)
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to setup triggers\n");
> =20
> +	ret =3D ad7124_calibrate_all(st, indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to register iio device\n");



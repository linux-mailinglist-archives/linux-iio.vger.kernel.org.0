Return-Path: <linux-iio+bounces-15181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 549D8A2D790
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 17:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E48166D05
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E23241CBB;
	Sat,  8 Feb 2025 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9zpoczF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992A4241C8C;
	Sat,  8 Feb 2025 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739033537; cv=none; b=Keehv+G2iwI8r+X3/ULEQo3ElSILmbR3RrR1vLeFnPYmL4xz3RA9bDRS+cUEN0P/SEK9f+W9Bxabsm7DLyr66+9X5bj3peAUiFTKHagM+Jxq5/TqlP+azG5fAfqI/RqbsokYhCBssIzR/8dDFsrgSawMiyseCLwlBldnRC2C+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739033537; c=relaxed/simple;
	bh=XctkP6Ri4RWMm2KQrzkn+GGWoMNk2euuCy/Hed9WVIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6/kS3s5H75DMvtM5fMpcJpbSEWaxD2fmfxqTve7D/7xNa/s79hjaPTF2EUDTOVvzg8Ix740Jlf1r/HKHzEpYbAsvwhn1/s4HcjMb2fZAfVX63LsfCITnUVPpnAR4psC+f3WRbT14MLcrjGvoTJJItu3oZf1ZGWG02FSFtU96ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9zpoczF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C11C4CED6;
	Sat,  8 Feb 2025 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739033537;
	bh=XctkP6Ri4RWMm2KQrzkn+GGWoMNk2euuCy/Hed9WVIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p9zpoczF6R+S2ek2CmHno08S9F5QLqXcsGqKeLt0vHXxu2N5ugSnjd/f6vgbLTuiK
	 57Iz4e/O2kc2+kMgb1NkHXfuihG9niWX1vaLTu35cO5CxXUk/+BxdXlptqHZ6Tacy2
	 vJcyErOil551Sr4btL+PVp0aDksCRZIcB1q2gvZmC66imBnIU7+9Wq2a2mu03RuTtQ
	 qkql0isHd1b5mDivto2NkoBtSajz4IPoPSJpxoG3uZ/CaBdXOcUgDddLcaOK8XegUi
	 5Uku4T3LbOhsxMIevgMr4LZLBHYAVdWIGvsnbT//cVx9046LIN3v2c2PHijKmV4Mdm
	 hDCEo9FpWHeCQ==
Date: Sat, 8 Feb 2025 16:52:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250208165208.3560237f@jic23-huawei>
In-Reply-To: <4781e1b1f074ca6c84ecc084b152885d08e826cc.1738761899.git.mazziesaccount@gmail.com>
References: <cover.1738761899.git.mazziesaccount@gmail.com>
	<4781e1b1f074ca6c84ecc084b152885d08e826cc.1738761899.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 15:38:16 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
> an automatic measurement mode, with an alarm interrupt for out-of-window
> measurements. The window is configurable for each channel.
> 
> The I2C protocol for manual start of the measurement and data reading is
> somewhat peculiar. It requires the master to do clock stretching after
> sending the I2C slave-address until the slave has captured the data.
> Needless to say this is not well suopported by the I2C controllers.
> 
> Thus the driver does not support the BD79124's manual measurement mode
> but implements the measurements using automatic measurement mode relying
> on the BD79124's ability of storing latest measurements into register.
> 
> The driver does also support configuring the threshold events for
> detecting the out-of-window events.
> 
> The BD79124 keeps asserting IRQ for as long as the measured voltage is
> out of the configured window. Thus the driver masks the received event
> for a fixed duration (1 second) when an event is handled. This prevents
> the user-space from choking on the events
> 
> The ADC input pins can be also configured as general purpose outputs.
> Those pins which don't have corresponding ADC channel node in the
> device-tree will be controllable as GPO.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Hi Matti,

Just a few really trivial comments though this wasn't my most thorough
of reviews as ran out of time / energy today!

Jonathan

> diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
> new file mode 100644
> index 000000000000..ea93762a24cc
> --- /dev/null
> +++ b/drivers/iio/adc/rohm-bd79124.c
> @@ -0,0 +1,1149 @@


> +static int bd79124_write_event_value(struct iio_dev *iio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info, int val,
> +				     int val2)
> +{
> +	struct bd79124_data *data = iio_priv(iio_dev);
> +	int reg;
> +
> +	if (chan->channel >= BD79124_MAX_NUM_CHANNELS)
> +		return -EINVAL;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (dir == IIO_EV_DIR_RISING) {
> +			guard(mutex)(&data->mutex);
> +
> +			data->alarm_r_limit[chan->channel] = val;
> +			reg = BD79124_GET_HIGH_LIMIT_REG(chan->channel);
> +		} else if (dir == IIO_EV_DIR_FALLING) {
> +			guard(mutex)(&data->mutex);
> +
> +			data->alarm_f_limit[chan->channel] = val;
> +			reg = BD79124_GET_LOW_LIMIT_REG(chan->channel);
> +		} else {
> +			return -EINVAL;
> +		}
> +		/*
> +		 * We don't want to enable the alarm if it is not enabled or
> +		 * if it is suppressed. In that case skip writing to the
> +		 * register.
> +		 */
> +		if (!(data->alarm_monitored[chan->channel] & BIT(dir)) ||
> +		    data->alarm_suppressed[chan->channel] & BIT(dir))
> +			return 0;
> +
> +		return bd79124_write_int_to_reg(data, reg, val);
> +
> +	case IIO_EV_INFO_HYSTERESIS:
> +			reg = BD79124_GET_HYSTERESIS_REG(chan->channel);
> +			val >>= 3;
Odd indent.
> +
> +		return regmap_update_bits(data->map, reg, BD79124_MASK_HYSTERESIS,
> +					  val);
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +static void bd79124_re_enable_lo(struct bd79124_data *data, unsigned int channel)
> +{
> +	int ret, evbit = BIT(IIO_EV_DIR_FALLING);
> +
> +	if (!(data->alarm_suppressed[channel] & evbit))
> +		return;
> +
> +	data->alarm_suppressed[channel] &= (~evbit);
> +
> +	if (!(data->alarm_monitored[channel] & evbit))
> +		return;
> +
> +	ret = bd79124_write_int_to_reg(data, BD79124_GET_LOW_LIMIT_REG(channel),
> +				       data->alarm_f_limit[channel]);
> +	if (ret)
> +		dev_warn(data->dev, "Low limit enabling failed for channel%d\n",
> +			 channel);
> +}
> +
> +static void bd79124_re_enable_hi(struct bd79124_data *data, unsigned int channel)
> +{
> +	int ret, evbit = BIT(IIO_EV_DIR_RISING);
> +
> +	if (!(data->alarm_suppressed[channel] & evbit))
> +		return;
> +
> +	data->alarm_suppressed[channel] &= (~evbit);
> +
> +	if (!(data->alarm_monitored[channel] & evbit))
> +		return;
This lot is very similar to the lo variant. Can we combine them or
use some helper for both?
> +
> +	ret = bd79124_write_int_to_reg(data, BD79124_GET_HIGH_LIMIT_REG(channel),
> +				       data->alarm_r_limit[channel]);
> +	if (ret)
> +		dev_warn(data->dev, "High limit enabling failed for channel%d\n",
> +			 channel);
> +}



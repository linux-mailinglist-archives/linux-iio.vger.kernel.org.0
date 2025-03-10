Return-Path: <linux-iio+bounces-16703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F04A5A4E8
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83F5172358
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4601DE3A8;
	Mon, 10 Mar 2025 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSvdsQlG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEEFEC5;
	Mon, 10 Mar 2025 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638411; cv=none; b=nkFj/nHxp0Vftvmu4bOEItUTgPuWhMKzp6tagm2WZFm8bVXffxf9HVpiSZi/tOu13CDZ74tc04fc0Ff9Y74i+WtOEtzaMHERvKZSWAsYFlmpN5uN4zuPp+pUktGzTdzaCb9ZaIWZl/5oZE6nm2ZjVSBYMI6U6EIRmQiSbsix+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638411; c=relaxed/simple;
	bh=6TBv8eUZABNkITVZTddPYa48Ozritmys3dSTxrbdGck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBKpMLi8OoFYUItUepNrLt3uVq0nrm1sBdv1IU6PQT1X3cpz1MaQORcrJm8vji26QdWsQRlPzwl9EYnS1XT2wMErSWNEfCZ5q4LHHDaRe+OAf5ybhS4jIFK7NIQKPvGh8gVFzBss2VLjkzEALXBq9/rAJW5vN4ajANMv5OUiFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSvdsQlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6720C4CEE5;
	Mon, 10 Mar 2025 20:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741638411;
	bh=6TBv8eUZABNkITVZTddPYa48Ozritmys3dSTxrbdGck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bSvdsQlGcmGFCLbPdeAK4oIeozGaZPIq9L9QmMQSzy82NsHQ0sQuHiTHqr4WkvJgJ
	 pH6m4rJI6jR7mquxwVkvHRUtImzSwcmlMfrwudfAWhDguJ0adjuyzByHNI8A/FKVxf
	 TpGCdKpVyVCwRc0vNoG6fZsnNkzQUYODo/IWiBaxfYppGE/Q2qEOqW3G13VVC6G4sH
	 mQT4OiMQBQ2YrpHcsStxquf8x/mI7Siy575F0VRl2pmDhAvHVNqBpStQGM2wTpU2CU
	 XCaYxIqHoR4mroxZ3uaCayFmbfYDJO729td5Y2g7bxDevTtf0b4nklugA4frdKNMnq
	 IZ+JcSoHnFGAQ==
Date: Mon, 10 Mar 2025 20:26:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Guillaume Stols
 <gstols@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, Trevor
 Gamblin <tgamblin@baylibre.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, =?UTF-8?B?Sm/Do28=?=
 Paulo =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 06/10] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250310202640.71f7ec1f@jic23-huawei>
In-Reply-To: <448f1f3cd05a9798e79a3948f95ada3e4c3483f7.1741610847.git.mazziesaccount@gmail.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
	<448f1f3cd05a9798e79a3948f95ada3e4c3483f7.1741610847.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 14:56:47 +0200
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


The comment below wins the Monday award for the trivial :)


> diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
> new file mode 100644
> index 000000000000..f63141daf5e2
> --- /dev/null
> +++ b/drivers/iio/adc/rohm-bd79124.c

> +static int bd79124_enable_event(struct bd79124_data *data,
> +		enum iio_event_direction dir, unsigned int channel)
> +{
> +	int dir_bit = BIT(dir);
> +	int reg, ret;
> +	u16 *limit;
> +
> +	guard(mutex)(&data->mutex);
> +	/* Set channel to be measured */
> +	ret = bd79124_start_measurement(data, channel);
> +	if (ret)
> +		return ret;
> +
> +	data->alarm_monitored[channel] |= dir_bit;
> +
> +	/* Add the channel to the list of monitored channels */
> +	ret = regmap_set_bits(data->map, BD79124_REG_ALERT_CH_SEL,
> +			      BIT(channel));
> +	if (ret)
> +		return ret;
> +
> +	if (dir == IIO_EV_DIR_RISING) {
> +		limit = &data->alarm_f_limit[channel];
> +		reg = BD79124_GET_HIGH_LIMIT_REG(channel);
> +	} else {
> +		limit = &data->alarm_f_limit[channel];
> +		reg = BD79124_GET_LOW_LIMIT_REG(channel);
> +	}
> +	/*
> +	 * Don't write the new limit to the hardware if we are in the
> +	 * rate-limit period. The timer which re-enables the event will set
> +	 * the limit.
> +	 */
> +	if (!(data->alarm_suppressed[channel] & dir_bit)) {
> +		ret = bd79124_write_int_to_reg(data, reg, *limit);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Enable comparator. Trust the regmap cache, no need to check
> +	 * if it was already enabled.
> +	 *
> +	 * We could do this in the hw-init, but there may be users who
> +	 * never enable alarms and for them it makes sense to not
> +	 * enable the comparator at probe.
> +	 */
> +	return regmap_set_bits(data->map, BD79124_REG_GEN_CFG,
> +				      BD79124_MASK_DWC_EN);
> +
Stray blank line.

> +}
>


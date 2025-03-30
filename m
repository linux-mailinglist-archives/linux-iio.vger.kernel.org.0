Return-Path: <linux-iio+bounces-17355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3B7A75AEF
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8D6165E86
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EF11D5172;
	Sun, 30 Mar 2025 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGGsKP0M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FF31CD205;
	Sun, 30 Mar 2025 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743352534; cv=none; b=G9v0aabatRx3n5eV07Jo52afRzNmQG8PqaDQxe0Fo1mdU4NoQREqNqFg6FvfNLtVvPtBeoO4bVN59os23adL6uMo3PyrFJtJ5E2JUMWoNambY/e98OssNQQXyXdGww18euwtM9hpVVegMq34jtby8Z7CFe2NE/VSGEogOA8xtc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743352534; c=relaxed/simple;
	bh=awwD76MG8HmfFfbsWnFxLgNKojOB1p4MjsMjAmU3tSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLtt73RGS40+sbyfcUWxHlY5UOacoNUW+xgcmAWAoatVfA70YvseVqb3yPP6i+gY/1h9XuTy7j9dQbds4a6mZizyv8hBqa0bz+9JZmpRH9kHaQxzBO4gPZECkdZftz3I7f6Amc92GKZ3j7wu6rzYAjoFf4Zdj24M0Q4g3M7QFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGGsKP0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015CAC4CEDD;
	Sun, 30 Mar 2025 16:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743352534;
	bh=awwD76MG8HmfFfbsWnFxLgNKojOB1p4MjsMjAmU3tSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dGGsKP0MqoU4yzNin26nlWak4YrxZHMRUn4bGlEy4tj3H1JtoxR0l7/AhTx09lP2N
	 jBzOA2IVr4qjuVlRw2Kq7YBEXSUUtDwT8Lr/ZG0qr/CLiTMsGskBizFrzCKpq4VqTJ
	 9NFw1eRIp2wuW3cmrExEX85zdafXpGFco8QjN4Sa9o0jUAWsQbggPnAnmf0s2Cwtfi
	 3yKFwxWlftOG6qnaJJrvLh/5FC44T2oalR5wcapycAc1GCvAqWZLTiLa+Ss3fm7FbW
	 qLEYMiwir6+ThdgobqPD4wEBpjycKeeUsHTGW6YlEtac4SbgjY+gK4WhtTkWXBAtvD
	 Flf155+sN7Wpg==
Date: Sun, 30 Mar 2025 17:35:25 +0100
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
Subject: Re: [PATCH v10 6/8] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250330173525.5d6e3d29@jic23-huawei>
In-Reply-To: <ca3886c9abcb268ca976e62cd7da28bf5d6e6382.1742560649.git.mazziesaccount@gmail.com>
References: <cover.1742560649.git.mazziesaccount@gmail.com>
	<ca3886c9abcb268ca976e62cd7da28bf5d6e6382.1742560649.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 09:13:42 +0200
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
> Thus do not support the BD79124's manual measurement mode but implement
> the measurements using automatic measurement mode, relying on the
> BD79124's ability of storing latest measurements into register.
> 
> Support also configuring the threshold events for detecting the
> out-of-window events.
> 
> The BD79124 keeps asserting IRQ for as long as the measured voltage is
> out of the configured window. Thus, prevent the user-space from choking
> on the events and mask the received event for a fixed duration (1 second)
> when an event is handled.
> 
> The ADC input pins can be also configured as general purpose outputs.
> Make those pins which don't have corresponding ADC channel node in the
> device-tree controllable as GPO.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

One trivial thing inline.

Jonathan

> diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
> new file mode 100644
> index 000000000000..099eccaa2232
> --- /dev/null
> +++ b/drivers/iio/adc/rohm-bd79124.c
> @@ -0,0 +1,1147 @@

>
> +static int bd79124_read_event_value(struct iio_dev *iio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int *val,
> +				    int *val2)
> +{
> +	struct bd79124_data *data = iio_priv(iio_dev);
> +	int ret, reg;
> +
> +	if (chan->channel >= BD79124_MAX_NUM_CHANNELS)
> +		return -EINVAL;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (dir == IIO_EV_DIR_RISING)
> +			*val = data->alarm_r_limit[chan->channel];
> +		else if (dir == IIO_EV_DIR_FALLING)
> +			*val = data->alarm_f_limit[chan->channel];
> +		else
> +			return -EINVAL;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_EV_INFO_HYSTERESIS:
> +		reg = BD79124_GET_HYSTERESIS_REG(chan->channel);
> +		ret = regmap_read(data->map, reg, val);
> +		if (ret)
> +			return ret;
> +
> +		*val &= BD79124_MSK_HYSTERESIS;
> +		/*
> +		 * The data-sheet says the hysteresis register value needs to be
> +		 * sifted left by 3.

shifted



Return-Path: <linux-iio+bounces-16574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD89A57C0C
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 17:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9830A16CFDE
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA531E51EF;
	Sat,  8 Mar 2025 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjQoM39p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6897E0E4;
	Sat,  8 Mar 2025 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452290; cv=none; b=mdT3H/qsKUbMf/tWsdWYC6hWjFQNfxVCd+PtyFR4t4gFcsCd6TzyqtLfLNt1WfPQHgUb3Ymhs9U8A4l/dgiYxwNjfR7vlwy0sGUSKeorFjWsz8B6eI4wzuPxnN9DeizQ9psNxuvwBuel5sMaj3GFN0INPHw3zcpxIvP/ghwKj8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452290; c=relaxed/simple;
	bh=XmWFGdTfcaGqbXLexjd2nltEBEsDhy2zNQyas9t/IKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EN4gKdecI+EUyLUlthwtGUImaFCqofyVr9KKXnO9spX6gvbgWo09ACtQsiJ1s6zVn69U+inhkhgXU4Sl/1qidK0SgqKMUllW3XGx6qN2jppqeDl4wKU9rEGwtfsY1KdZgzxV20K/Yz7xwBYhv4e3UZgtlzoznE8fJ/rGmAe8XXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjQoM39p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896D7C4CEE0;
	Sat,  8 Mar 2025 16:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741452289;
	bh=XmWFGdTfcaGqbXLexjd2nltEBEsDhy2zNQyas9t/IKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rjQoM39p9uMhfrRfuWgDOe+rZcJNLSthydIs4ouKCgIJibZySOLYXBx1cKTrwMQzr
	 mf9yL/uMLnP9HhKeYL/PK8VtWAMO4Qx6wyDDpKR/X88PH382z2J1JI/iPc1FNgdmL7
	 4x9H5zvLiE37rbVRpSyEEevHZmNuQjeRMPeoeETVZzLUSuHF4rIigr0FvgPDap+YIt
	 dQ7xkBuWNs80AK0IaVYvfG2X0dZK7vYD9Wu1+X96Hy8xXwXRyCkZKkuHYEitSCmoYO
	 1HpGFoHTS2VAATgiyy99creWdnThyWYSFs88VFWwTajHD270zMxMKB8GWY3dW/Gfdj
	 S/r2b/okpmcCQ==
Date: Sat, 8 Mar 2025 16:44:41 +0000
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
Subject: Re: [PATCH v5 07/10] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250308164441.00f64ab2@jic23-huawei>
In-Reply-To: <60a55e4027cf9335b37d4affc11d805a1504cab7.1740993491.git.mazziesaccount@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
	<60a55e4027cf9335b37d4affc11d805a1504cab7.1740993491.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 13:33:39 +0200
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
Hi Matti

Just a few really trivial comments.  If all else in the
set was resolved I'd probably have applied with a tweak or two

Thanks,

Jonathan

>  obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
> diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
> new file mode 100644
> index 000000000000..466c7decf8fc
> --- /dev/null
> +++ b/drivers/iio/adc/rohm-bd79124.c
> @@ -0,0 +1,1108 @@
...

> +
> +/* Read-only regs */

Given naming this is pretty obvious. I would drop the comment
and any others that don't add much meaning.

> +static const struct regmap_range bd79124_ro_ranges[] = {



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
> +		/* Mask the non hysteresis bits */
> +		*val &= BD79124_MASK_HYSTERESIS;
> +		/*
> +		 * The data-sheet says the hysteresis register value needs to be
> +		 * sifted left by 3 (or multiplied by 8, depending on the
> +		 * page :] )

We don't really need this comment on the oddity of the way the datasheet
describes things in the final driver as effect is same in either case.
It did make me smile though ;)


> +		 */
> +		*val <<= 3;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int bd79124_disable_event(struct bd79124_data *data,
> +			enum iio_event_direction dir, int channel)
> +{
> +	int dir_bit = BIT(dir), reg;

I'd rather this one was split as I find it hard to read lines that
mix setting of some variables and not others.

> +	unsigned int limit;
> +
>
> +static int bd79124_enable_event(struct bd79124_data *data,
> +		enum iio_event_direction dir, unsigned int channel)
> +{
> +	int dir_bit = BIT(dir);
> +	int reg;
> +	u16 *limit;
> +	int ret;

Trivial but might as well but ret and reg on same line.


> +
> +}


>


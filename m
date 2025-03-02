Return-Path: <linux-iio+bounces-16230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BE1A4AF3A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 05:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69127189091B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 04:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A0D1A5B97;
	Sun,  2 Mar 2025 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRAQ/Bpr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3298632E;
	Sun,  2 Mar 2025 04:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740888671; cv=none; b=MfuSaHB1j0BCBT+W14vfbdXh+3htUDFEAO7afvHX4PnRA2QIFRnn1TMqkkvZCf1GeQ6WGDFapDIBaXHF3WZeeVArvyaCQH9y72NE8wF7mIgfjVol55tr2hjgjnjlJbJ+v4SvOQA2pTozPlxHWpqtp3Tdpn+vcR9+48pFr9xvKXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740888671; c=relaxed/simple;
	bh=mhZ4GEcprVucdPj/c25y003/+abJiOOGAR1e9Cvo/NY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6eoQPPkN8Q6+TPi8lubXjoJA0yDK8DSsqnn/OOijCaB6Rb8gIuPyQ3ScD0Sv+X+h67mCZt2JAQAsW1BLd78AA6MKcWnp1vo6QMBx3FQRERDHrk/PPHKTOry1PXDDTc6UxsRgPQ76V7sA187loklDcoAV6Q+2ooeaCdOpS4w9Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRAQ/Bpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D712C4CED6;
	Sun,  2 Mar 2025 04:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740888670;
	bh=mhZ4GEcprVucdPj/c25y003/+abJiOOGAR1e9Cvo/NY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uRAQ/BprkT/fcETMQ/nvto5l6d/mJi22o7WvOY6UsRwn/nB2zaUFub9c4e4HutEhR
	 FxSc2yd6nJX6ms2tv+vIeelPkGLRoo997BrggpXhZINTGueJF4UWmioOzWaawkqEB2
	 pTkMX3nkEoGq8HGmAaqik5NYczg2WLPMmBOgR9o6jw4SdLBzJRFCFUGq7yuxo4HtZn
	 sf2e9Miao8Q7EQkyrF8dkhDWkuN5/64M/VSrdAfByWm15HcEcKb77ZsQsl96Xg2LTV
	 wvcCxNrLi9itzebjiUPrMZKaWvF1pi8/VqyLlkyZKbM70Q8ddZou8wJ54NLQpP8xPv
	 dje10SlihUoLg==
Date: Sun, 2 Mar 2025 04:10:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Guillaume Stols
 <gstols@baylibre.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru
 Ceclan <mitrutzceclan@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, Linus
 Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 08/10] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250302041046.7fde3c68@jic23-huawei>
In-Reply-To: <4d1bf5df8f3b0f760422b6b67fcc8245ebf520e0.1740421249.git.mazziesaccount@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
	<4d1bf5df8f3b0f760422b6b67fcc8245ebf520e0.1740421249.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 20:34:30 +0200
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
Some minor stuff inline.

Thanks,

Jonathan

> +
> +#define BD79124_REG_SYSTEM_STATUS	0x0
> +#define BD79124_REG_GEN_CFG		0x01
> +#define BD79124_REG_OPMODE_CFG		0x04
> +#define BD79124_REG_PINCFG		0x05
> +#define BD79124_REG_GPO_VAL		0x0B
> +#define BD79124_REG_SEQUENCE_CFG	0x10
> +#define BD79124_REG_MANUAL_CHANNELS	0x11
> +#define BD79124_REG_AUTO_CHANNELS	0x12
> +#define BD79124_REG_ALERT_CH_SEL	0x14
> +#define BD79124_REG_EVENT_FLAG		0x18
> +#define BD79124_REG_EVENT_FLAG_HI	0x1a
> +#define BD79124_REG_EVENT_FLAG_LO	0x1c
> +#define BD79124_REG_HYSTERESIS_CH0	0x20
> +#define BD79124_REG_EVENTCOUNT_CH0	0x22
> +#define BD79124_REG_RECENT_CH0_LSB	0xa0
> +#define BD79124_REG_RECENT_CH7_MSB	0xaf
> +
> +#define BD79124_ADC_BITS 12
> +#define BD79124_MASK_CONV_MODE GENMASK(6, 5)
> +#define BD79124_MASK_AUTO_INTERVAL GENMASK(1, 0)
> +#define BD79124_CONV_MODE_MANSEQ 0
> +#define BD79124_CONV_MODE_AUTO 1
> +#define BD79124_INTERVAL_075 0

Can we make these units in these explicit?
#define BD79124_INTERVAL_MS_0_75 
maybe?  Nice to avoid need for comments on what the units are where
you use these.

> +#define BD79124_INTERVAL_150 1
> +#define BD79124_INTERVAL_300 2
> +#define BD79124_INTERVAL_600 3

> +
> +static int bd79124_enable_event(struct bd79124_data *data,
> +		enum iio_event_direction dir, unsigned int channel)
> +{
> +	int dir_bit = BIT(dir);
> +	int reg;
> +	u16 *limit;
> +	int ret;
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
> +	/* Don't write the new limit to the hardware if we are in the
> +	 * rate-limit period. The timer which re-enables the event will set
> +	 * the limit.
> +	 */
/*
 * Don't

Check for other cases of this...


> +static void bd79124_re_enable_hi(struct bd79124_data *data, unsigned int channel)
> +{
> +	int ret, evbit = BIT(IIO_EV_DIR_RISING);
> +
> +	if (!(data->alarm_suppressed[channel] & evbit))
> +		return;
> +
> +	data->alarm_suppressed[channel] &= (~evbit);

No brackets around the ~evbit.
Check for other cases of this.
Otherwise we'll get some script written 'cleanup'.


> +
> +	if (!(data->alarm_monitored[channel] & evbit))
> +		return;
> +
> +	ret = bd79124_write_int_to_reg(data, BD79124_GET_HIGH_LIMIT_REG(channel),
> +				       data->alarm_r_limit[channel]);
> +	if (ret)
> +		dev_warn(data->dev, "High limit enabling failed for channel%d\n",
> +			 channel);
> +}
> +
> +static void bd79124_alm_enable_worker(struct work_struct *work)
> +{
> +	int i;
> +	struct bd79124_data *data = container_of(work, struct bd79124_data,
> +						 alm_enable_work.work);
> +
> +	guard(mutex)(&data->mutex);
> +	/*
> +	 * We should not re-enable the event if user has disabled it while
> +	 * rate-limiting was enabled.
> +	 */

Is this comment suggesting something that isn't done or referring to specific
code?  I think it wants to be in the function above where the decision is made.

> +	for (i = 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
> +		bd79124_re_enable_hi(data, i);
> +		bd79124_re_enable_lo(data, i);
> +	}
> +}
> +

> +

> +static irqreturn_t bd79124_event_handler(int irq, void *priv)
> +{
> +	int ret, i_hi, i_lo, i;
> +	struct iio_dev *iio_dev = priv;
> +	struct bd79124_data *data = iio_priv(iio_dev);
> +
> +	/*
> +	 * Return IRQ_NONE if bailing-out without acking. This allows the IRQ
> +	 * subsystem to disable the offending IRQ line if we get a hardware
> +	 * problem. This behaviour has saved my poor bottom a few times in the
> +	 * past as, instead of getting unusably unresponsive, the system has
> +	 * spilled out the magic words "...nobody cared".
> +	 */
> +	ret = regmap_read(data->map, BD79124_REG_EVENT_FLAG_HI, &i_hi);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	ret = regmap_read(data->map, BD79124_REG_EVENT_FLAG_LO, &i_lo);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	if (!i_lo && !i_hi)
> +		return IRQ_NONE;
> +
> +	for (i = 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
> +		u64 ecode;
> +
> +		if (BIT(i) & i_hi) {
> +			ecode = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,

> +					IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING);
Align this to less tabs as per discussion on previous version.

> +
> +
> +struct bd79124_reg_init {
> +	int reg;
> +	int val;
> +};

Not used any more.

> +
> +static int bd79124_chan_init(struct bd79124_data *data, int channel)
> +{
> +	int ret;
> +
> +	ret = regmap_write(data->map, BD79124_GET_HIGH_LIMIT_REG(channel), 4095);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(data->map, BD79124_GET_LOW_LIMIT_REG(channel), 0);
> +}

> +
> +static int bd79124_init_mux(struct bd79124_data *data, int gpio_pins)
> +{
> +	return regmap_write(data->map, BD79124_REG_PINCFG, gpio_pins);

Maybe squash this inline.  Doesn't seem to add a lot to have the helper.

> +}
> +
> +static int bd79124_hw_init(struct bd79124_data *data, int gpio_pins)
> +{
...

> +
> +	/* Set the measurement interval to 0.75 mS */

This lead me to comment on defines.  I'd rather code was fully self
documenting and remove the comment if we can.  Makes for less chance of it
becoming out of sync over time.

> +	regval = FIELD_PREP(BD79124_MASK_AUTO_INTERVAL, BD79124_INTERVAL_075);
> +	ret = regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
> +				 BD79124_MASK_AUTO_INTERVAL, regval);
> +	if (ret)
> +		return ret;






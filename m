Return-Path: <linux-iio+bounces-15289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85152A2F7F9
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 19:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC481886734
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 18:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC2025E461;
	Mon, 10 Feb 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp/P4iNI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870D25E454;
	Mon, 10 Feb 2025 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739213673; cv=none; b=mu2pZEvY10e8qDuHH2BkACj+R/LNdHueNgmvk1CgIpt11hIF1GWJ42yvkOe+NVRl9yLHUK/Q6wU5X751sdLfpv2GfzxQMOKlXiPRrcTz4r/39rFHom/r+UfKi9Y6pMXUEX+BSqB/oLEsALdo2Wqf+bzrnU4r9AsSW1tZQff+sdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739213673; c=relaxed/simple;
	bh=jmk5FbAXpRJJs+zhZ1kUBUtl6Iq0ro+zbpNJ6Mnrfi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6j3Nls9JBJt0ksC98OwPU1o5WXxc8WtZlDQ2JbnjNwwF9lAhOjDukHhTSTJoQYzJ472mRBRXVhdkt4ixeE7MkY58kPoeFfcAJxIQqhy8+rpsPZ/r3Z/fyqdO4jpYqq/8mIG+6LmV5KqgYFAXIuvh5YjBDE6x38yAjAnSnyVfhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp/P4iNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07935C4CED1;
	Mon, 10 Feb 2025 18:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739213672;
	bh=jmk5FbAXpRJJs+zhZ1kUBUtl6Iq0ro+zbpNJ6Mnrfi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sp/P4iNIWJV4FvGznJghtSsryXgA4WOjiI5dCtQdaK416ONwSjfhr7SKh0dckeFUO
	 p8hCvDagkulR3WuGeTOciM4qGk7EQR1v8T8BaK7Y8M0Ev7F18T09CaCcAkCAurfT+7
	 tPiRibBE1xGIPouE7gv1KF9kGUvYrOasrGuQlBivvg/GPPQhdzWDKxMEFUBywjy3Ab
	 Byxm3T4EFyuV0CErHtA59G44F2F64M9oNDDrbRxfHdTTlrEymjZPtqSJz76LSgscPk
	 iqi2MhU9GdtwfLbDZIYPcvnT15CjwQsItTJQdzl2TYDiCX5b1MBZGSvLxwqEqkihOq
	 QPqD28ygr4/2A==
Date: Mon, 10 Feb 2025 18:54:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 14/17] iio: adc: ad4695: Add support for SPI offload
Message-ID: <20250210185421.67d06a57@jic23-huawei>
In-Reply-To: <8a8432e7-86b9-43dd-9aa0-75875747eedb@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
	<20250207-dlech-mainline-spi-engine-offload-2-v8-14-e48a489be48c@baylibre.com>
	<8a8432e7-86b9-43dd-9aa0-75875747eedb@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 10:01:57 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/7/25 2:09 PM, David Lechner wrote:
> > Add support for SPI offload to the ad4695 driver. SPI offload allows
> > sampling data at the max sample rate (500kSPS or 1MSPS).
> > 
> > This is developed and tested against the ADI example FPGA design for
> > this family of ADCs [1].
> > 
> > [1]: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >   
> 
> ...
> 
> > ---
> >  drivers/iio/adc/Kconfig  |   1 +
> >  drivers/iio/adc/ad4695.c | 445 +++++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 429 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 995b9cacbaa964d26424346120c139858f93cdcd..ec60b64c46e187e2be18ab1f8ca9e6f4f03299f9 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -52,6 +52,7 @@ config AD4695
> >  	tristate "Analog Device AD4695 ADC Driver"
> >  	depends on SPI
> >  	select IIO_BUFFER
> > +	select IIO_BUFFER_DMAENGINE
> >  	select IIO_TRIGGERED_BUFFER
> >  	select REGMAP  
> 
> I missed adding
> 
> 	select SPI_OFFLOAD
> 
> Closes: https://lore.kernel.org/oe-kbuild-all/202502090910.ganYXEeF-lkp@intel.com/
> 
> >  	help  
> 
Thanks. Fixed up whilst applying.
> ...
> 
> 
> > +static int ad4695_offload_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4695_state *st = iio_priv(indio_dev);
> > +	struct spi_offload_trigger_config config = {
> > +		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
> > +	};
> > +	struct spi_transfer *xfer = &st->buf_read_xfer[0];
> > +	struct pwm_state state;
> > +	u8 temp_chan_bit = st->chip_info->num_voltage_inputs;
> > +	u8 num_slots = 0;
> > +	u8 temp_en = 0;
> > +	unsigned int bit;
> > +	int ret;
> > +
> > +	iio_for_each_active_channel(indio_dev, bit) {
> > +		if (bit == temp_chan_bit) {
> > +			temp_en = 1;
> > +			continue;
> > +		}
> > +
> > +		ret = regmap_write(st->regmap, AD4695_REG_AS_SLOT(num_slots),
> > +				   FIELD_PREP(AD4695_REG_AS_SLOT_INX, bit));
> > +		if (ret)
> > +			return ret;
> > +
> > +		num_slots++;
> > +	}
> > +
> > +	/*
> > +	 * For non-offload, we could discard data to work around this
> > +	 * restriction, but with offload, that is not possible.
> > +	 */
> > +	if (num_slots < 2) {
> > +		dev_err(&st->spi->dev,
> > +			"At least two voltage channels must be enabled.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = regmap_update_bits(st->regmap, AD4695_REG_TEMP_CTRL,
> > +				 AD4695_REG_TEMP_CTRL_TEMP_EN,
> > +				 FIELD_PREP(AD4695_REG_TEMP_CTRL_TEMP_EN,
> > +					    temp_en));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Each BUSY event means just one sample for one channel is ready. */
> > +	memset(xfer, 0, sizeof(*xfer));
> > +	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> > +	/* Using 19 bits per word to allow for possible oversampling */
> > +	xfer->bits_per_word = 19;
> > +	xfer->len = 4;
> > +
> > +	spi_message_init_with_transfers(&st->buf_read_msg, xfer, 1);
> > +	st->buf_read_msg.offload = st->offload;
> > +
> > +	ret = spi_optimize_message(st->spi, &st->buf_read_msg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * NB: technically, this is part the SPI offload trigger enable, but it
> > +	 * doesn't work to call it from the offload trigger enable callback
> > +	 * because it requires accessing the SPI bus. Calling it from the
> > +	 * trigger enable callback could cause a deadlock.
> > +	 */
> > +	ret = regmap_set_bits(st->regmap, AD4695_REG_GP_MODE,
> > +			      AD4695_REG_GP_MODE_BUSY_GP_EN);
> > +	if (ret)
> > +		goto err_unoptimize_message;
> > +
> > +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> > +					 &config);
> > +	if (ret)
> > +		goto err_disable_busy_output;
> > +
> > +	ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
> > +	if (ret)
> > +		goto err_offload_trigger_disable;
> > +
> > +	guard(mutex)(&st->cnv_pwm_lock);  
> 
> Apparently clang doesn't like this guard() after goto, so I'll have to figure
> out what to do about that. Probably need to add a helper function to avoid
> goto below from jumping out of scoped_guard().
> 
> https://lore.kernel.org/oe-kbuild-all/202502090806.KxEvxCZC-lkp@intel.com/

Easiest option don't use guard(). Sometimes they are not the right choice!

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index d73d2ff77625..d1e7634001b3 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -800,7 +800,7 @@ static int ad4695_offload_buffer_postenable(struct iio_dev *indio_dev)
        if (ret)
                goto err_offload_trigger_disable;
 
-       guard(mutex)(&st->cnv_pwm_lock);
+       mutex_lock(&st->cnv_pwm_lock);
        pwm_get_state(st->cnv_pwm, &state);
        /*
         * PWM subsystem generally rounds down, so requesting 2x minimum high
@@ -808,6 +808,7 @@ static int ad4695_offload_buffer_postenable(struct iio_dev *indio_dev)
         */
        state.duty_cycle = AD4695_T_CNVH_NS * 2;
        ret = pwm_apply_might_sleep(st->cnv_pwm, &state);
+       mutex_unlock(st->cnv_pwm_lock);
        if (ret)
                goto err_offload_exit_conversion_mode;


For now I've applied this as I want to get some build testing on this series,  but
feel free to send a patch to tweak this to a different solution.

Jonathan

> 
> > +	pwm_get_state(st->cnv_pwm, &state);
> > +	/*
> > +	 * PWM subsystem generally rounds down, so requesting 2x minimum high
> > +	 * time ensures that we meet the minimum high time in any case.
> > +	 */
> > +	state.duty_cycle = AD4695_T_CNVH_NS * 2;
> > +	ret = pwm_apply_might_sleep(st->cnv_pwm, &state);
> > +	if (ret)
> > +		goto err_offload_exit_conversion_mode;
> > +
> > +	return 0;
> > +
> > +err_offload_exit_conversion_mode:
> > +	/*
> > +	 * We have to unwind in a different order to avoid triggering offload.
> > +	 * ad4695_exit_conversion_mode() triggers a conversion, so it has to be
> > +	 * done after spi_offload_trigger_disable().
> > +	 */
> > +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> > +	ad4695_exit_conversion_mode(st);
> > +	goto err_disable_busy_output;
> > +
> > +err_offload_trigger_disable:
> > +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> > +
> > +err_disable_busy_output:
> > +	regmap_clear_bits(st->regmap, AD4695_REG_GP_MODE,
> > +			  AD4695_REG_GP_MODE_BUSY_GP_EN);
> > +
> > +err_unoptimize_message:
> > +	spi_unoptimize_message(&st->buf_read_msg);
> > +
> > +	return ret;
> > +}  



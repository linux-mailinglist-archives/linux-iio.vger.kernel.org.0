Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5804600F5
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 19:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244099AbhK0SrC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 27 Nov 2021 13:47:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58424 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbhK0SpB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 13:45:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5F6860F02;
        Sat, 27 Nov 2021 18:41:46 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 002C4C53FAD;
        Sat, 27 Nov 2021 18:41:41 +0000 (UTC)
Date:   Sat, 27 Nov 2021 18:46:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v6 3/3] iio: addac: add AD74413R driver
Message-ID: <20211127184617.2a7c7c14@jic23-huawei>
In-Reply-To: <20211126160219.674665-4-demonsingur@gmail.com>
References: <20211126160219.674665-1-demonsingur@gmail.com>
        <20211126160219.674665-4-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Nov 2021 18:02:19 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> The AD74412R and AD74413R are quad-channel software configurable input/output
> solutions for building and process control applications. They contain
> functionality for analog output, analog input, digital input, resistance
> temperature detector, and thermocouple measurements integrated
> into a single chip solution with an SPI interface.
> The devices feature a 16-bit ADC and four configurable 13-bit DACs to provide
> four configurable input/output channels and a suite of diagnostic functions.
> The AD74413R differentiates itself from the AD74412R by being HART-compatible.
> 
> When configured with channel 0 as voltage output, channel 1 as current
> output, channel 2 as voltage input and channel 3 as current input, the
> following structure is created under the corresponding IIO device.

Thanks for the example. This definitely helps.  

> 
> .
> ├── in_current0_offset
> ├── in_current0_raw
> ├── in_current0_sampling_frequency

The sampling frequency per channel is a bit unusual, but oddly enough that
is how it is documented even when in sequence mode.  So I guess we should
just live with it being strange...  Obviously the actual sampling frequency
will be lower because we'll be measuring other things between each reading
of this channel. Oh well. odd :)

> ├── in_current0_sampling_frequency_available
> ├── in_current0_scale
> ├── in_voltage1_offset
> ├── in_voltage1_raw
> ├── in_voltage1_sampling_frequency
> ├── in_voltage1_sampling_frequency_available
> ├── in_voltage1_scale
> ├── in_voltage2_offset
> ├── in_voltage2_raw
> ├── in_voltage2_sampling_frequency
> ├── in_voltage2_sampling_frequency_available
> ├── in_voltage2_scale
> ├── in_current3_offset
> ├── in_current3_raw
> ├── in_current3_sampling_frequency
> ├── in_current3_sampling_frequency_available
> ├── in_current3_scale
> ├── out_voltage0_raw
> ├── out_voltage0_scale
> ├── out_current1_raw
> ├── out_current1_scale
> ├── name
> ├── buffer
> │   ├── data_available
> │   ├── enable
> │   ├── length
> │   └── watermark
> └── scan_elements
>     ├── in_current0_en
>     ├── in_current0_index
>     ├── in_current0_type
>     ├── in_voltage1_en
>     ├── in_voltage1_index
>     ├── in_voltage1_type
>     ├── in_voltage2_en
>     ├── in_voltage2_index
>     ├── in_voltage2_type
>     ├── in_current3_en
>     ├── in_current3_index
>     └── in_current3_type
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

Unless I'm missing something, you are being overly cautious with the DMA
buffer alignments. Forcing that for the first one only should be enough.
> +};
> +
> +struct ad74413r_state {
> +	struct ad74413r_channel_config	channel_configs[AD74413R_CHANNEL_MAX];
> +	unsigned int			gpo_gpio_offsets[AD74413R_CHANNEL_MAX];
> +	unsigned int			comp_gpio_offsets[AD74413R_CHANNEL_MAX];
> +	struct gpio_chip		gpo_gpiochip;
> +	struct gpio_chip		comp_gpiochip;
> +	struct mutex			lock;
> +	struct completion		adc_data_completion;
> +	unsigned int			num_gpo_gpios;
> +	unsigned int			num_comparator_gpios;
> +	u32				rsense_resistance_ohms;
> +
> +	const struct ad74413r_chip_info	*chip_info;
> +	struct spi_device		*spi;
> +	struct regulator		*refin_reg;
> +	struct regmap			*regmap;
> +	struct device			*dev;
> +	struct iio_trigger		*trig;
> +
> +	size_t			adc_active_channels;
> +	struct spi_message	adc_samples_msg;
> +	struct spi_transfer	adc_samples_xfer[AD74413R_CHANNEL_MAX + 1];
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	struct {
> +		u8 rx_buf[AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX];
> +		s64 timestamp;
> +	} adc_samples_buf ____cacheline_aligned;
> +
> +	u8	adc_samples_tx_buf[AD74413R_FRAME_SIZE * AD74413R_CHANNEL_MAX]
> +			____cacheline_aligned;

I'm surprised I didn't mention this before but you only need to ensure that any
memory used for DMA is not in a cacheline with memory used for other things that
might change concurrently.

I'm assuming there is only one DMA transaction going on to one piece of hardwre
here so you should be fine with just forcing the alignment of adc_samples_buf
to be ____cacheline_aligned.  That will ensure non of these DMA buffers share
a line with anything other than each other.

To give the short explanation of why we jump through these hoops.

1) DMA transfer started - it grabs a whole cacheline because that is how this
   particular platform works (even if it is doing DMA to just one byte)
2) A flag or similar is updated in the same cacheline.
3) The DMA transfer ends and the cacheline is entirely overwritten with
   the data from the DAM and whatever was grabbed in step 1.

So as long as we are only dealing with buffers in the same DMA transaction
it will be safe for them to share cachelines.

Note that we play games with the alignment of iio_priv() region at allocation
to ensure that is appropriately aligned, such that when we align an element
within it the alignment ends up right as well.  This case was so common
it was worth the 'magic' handling to ensure we could embed DMA buffers.


> +	u8	reg_tx_buf[AD74413R_FRAME_SIZE] ____cacheline_aligned;
> +	u8	reg_rx_buf[AD74413R_FRAME_SIZE] ____cacheline_aligned;
> +};




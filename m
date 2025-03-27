Return-Path: <linux-iio+bounces-17295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64715A73D98
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 18:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A643BCE65
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F9521931E;
	Thu, 27 Mar 2025 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKAVIMcc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25281FF613;
	Thu, 27 Mar 2025 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743098103; cv=none; b=XBwDWehXx5FokWh3dqe60QRBBBL/V1pqhVb+0Uu8F5HO9KuXV8v2PcOlaAKQSFQzddJbrPaPTDng11KpBhWBFpcmbNlIu7iZIQl5u9EwlJSYFihxjv/SP5+ulsCH/bK4HuzVlSWpgYl34PVgjpcKn36mAfvXiM4X2u4yjL8wSnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743098103; c=relaxed/simple;
	bh=fhmnk5e9Gn0IDCxvmT/YUvjUy6W1WYvG2k9b2kZddVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4tiBEMaSk2RM5tciG8xK+COIYv1zVHYofV4/HezwzU5vMBHjw4flTvKURlAn1rg/DZWUbRBgPtbO3geGSZYgbCcharGQX0dqdBxGAMO0giURdGhZVzVEh0jutOFxGzpioa3QJxh9MaubUQSFKzA83mMGfd8crbdhYMgW4e2OTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKAVIMcc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2254e0b4b79so36412195ad.2;
        Thu, 27 Mar 2025 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743098101; x=1743702901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+dfyZTJfEZSOrQCPA/NAklJvs+/esRIRB3hCYOb0ug=;
        b=MKAVIMccrVb9CBRAbDQFuat/A2Y3Fd7baxY+UjAn4UW91jdCWEkxqQnC39N3+57W83
         vmNcC52VFbKcto1I2xw+/WkXhWsY4fXhwoSVYbGlRVorUIEz8Q63apzub6BrVUz/CfGT
         s7eak2Vrtjmlcbgw3NZ6/i5IkQRsoYNuHgWoS3FSDXj5taJHdl9rr+/pKYlqQnJlrOTE
         kunxeItx3//CNwRacMmRZdUQhESk8qPPU2aVIic8Dh4FE7vuW20qqw6jtXXWOJ8lkdMZ
         H+dlroJb4iSwwI+cMM8jRJLybDnnFR2Vf5nCClXGXB6bwhoIsfMVl7FqNJvkog+rHJvk
         pCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743098101; x=1743702901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+dfyZTJfEZSOrQCPA/NAklJvs+/esRIRB3hCYOb0ug=;
        b=OWiTLGNv3IJ/SenhzfdPEqGdty+Sytjh6f+oHOXXgTiuAWkicRwkdSs2k0n9+Sz+PM
         hUG6bUO4pE3IrvGhM+p48jKFKNcfUUnGOvB+OABZMP/oBwIXcRygH8wrsRw9v5uSzBJR
         Vpd0PB4fSuZv1ur6YwxA2tLil3Ir3jRtCampCGFGo0YdHgQz16F0YcW3kYcsVuzyRaXX
         sKZLSZtE3DYUsBl2U6D3aWJjq/2PXYc81R6pXFSgxCAdpdLEXGshuV2VyT/S21bQOiEj
         pJxoj7fxURKUSxGfMmizJpHry+KsJj0mAjZ5a5GymPX7xvLbzHpAqzLWTB3e57iuogiS
         Bc0A==
X-Forwarded-Encrypted: i=1; AJvYcCUIrwwG24e1G0Moi1jxNzPoHaWmEm5nsEBdtsrU5IydvTcLWeaMHZp2c8GsvITWT7JW6Uo9suUgSSE=@vger.kernel.org, AJvYcCUP18u2YvHnwCtF/3bP6UM0JhiVhDwxRUa9xvK2/EFyJdj9lHHavEomqiZe3aq7PYBXj8cKsK82HbaaOYTD@vger.kernel.org, AJvYcCXHkyayUzfLInOowQsWC2T5c8vGvr/sKgFMStLZjCm+Oybeg6YqUgNLNOvT/i8KpVDkcUmDM06H6FX2@vger.kernel.org
X-Gm-Message-State: AOJu0YwDQkJEPNL5AKrvDfLm/KDOjmYJrLpFHyrSo4OS6jYNqCs3okhx
	BTmu4tSzmaNgdgXiyrJOWVn23a5d7XddU5FGM9xV754HWtPhLW2d
X-Gm-Gg: ASbGnct3fYfh8ECWi3oblW2oW3j0zZ2iDIBt30TqfZMuED6xEnhySU/sW3GvKUYB6f/
	O5ED+9/rBV9tMKXhd5dBy/AlNhjyj21fs+rBcrGTaggIcpx+Iz7E/VhmTWyCl/InrBhw3xRyWws
	kR+YqRdUjTO7ToXErxPGbUvTHDa2MRwp4EPiFKPyZk5RjDUZmI6Ix9eYpb74yIHuL03wiFiElcF
	rkxB6ZDWwr5weO9c6f0BRQ/HY0XKVYSsiQG9UQKyb/UppYoGEg0MakfFanqxd0B4bR4irWyqU1b
	+L3v9BzH5VkJM4KTzrIVqqyLPPt8et0e3lKITXDChWIas3Bq8pZRtw==
X-Google-Smtp-Source: AGHT+IHpiwzukvLFEEn+mnHcCDcr2sJr2j0XYOPHiRJDKyDpVgLTHnbBXJVUaPsUzhVZ6DOLQVeCJA==
X-Received: by 2002:a17:903:22cf:b0:21f:164d:93fe with SMTP id d9443c01a7336-2280491397fmr68063005ad.53.1743098100605;
        Thu, 27 Mar 2025 10:55:00 -0700 (PDT)
Received: from localhost ([2804:30c:b03:ee00:e0b8:a8b8:44aa:8d0b])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eec543csm2823045ad.38.2025.03.27.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 10:54:59 -0700 (PDT)
Date: Thu, 27 Mar 2025 14:56:02 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	corbet@lwn.net
Subject: Re: [PATCH v3 1/4] iio: adc: ad4000: Add support for SPI offload
Message-ID: <Z-WRMih3UCFjym9p@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1742992305.git.marcelo.schmitt@analog.com>
 <d67e71b9fab270d16b6b5e26a3594dfc73be1ae5.1742992305.git.marcelo.schmitt@analog.com>
 <35f4d22a-e478-4a43-bbb6-f9d34ce1f888@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f4d22a-e478-4a43-bbb6-f9d34ce1f888@baylibre.com>

Hi David, thank you for your review.
Hope I don't sound harsh on my reply.
Comments inline.

Thanks

On 03/27, David Lechner wrote:
> On 3/26/25 8:24 AM, Marcelo Schmitt wrote:
> > FPGA HDL projects can include a PWM generator in addition to SPI-Engine.
> > The PWM IP is used to trigger SPI-Engine offload modules that in turn set
> > SPI-Engine to execute transfers to poll data from the ADC. That allows data
> > to be read at the maximum sample rates. Also, it is possible to set a
> > specific sample rate by setting the proper PWM duty cycle and related state
> > parameters, thus allowing an adjustable ADC sample rate when a PWM (offload
> > trigger) is used in combination with SPI-Engine.
> > 
> > Add support for SPI offload.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> 
...
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/spi/spi.h>
> > +#include <linux/spi/offload/consumer.h>
> 
> Alphabetical order?

Ah drat, yes. Hope I've put that in the correct order now.

> 
> >  #include <linux/units.h>
> >  #include <linux/util_macros.h>
> >  #include <linux/iio/iio.h>
> >  
> >  #include <linux/iio/buffer.h>
> > +#include <linux/iio/buffer-dmaengine.h>
> >  #include <linux/iio/triggered_buffer.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  
Also changing to
...
#include <linux/units.h>
#include <linux/util_macros.h>

#include <linux/iio/iio.h>
#include <linux/iio/buffer.h>
#include <linux/iio/buffer-dmaengine.h>
...

> 
> ...
> 
> >  
> > +/*
> > + * When SPI offload is configured, transfers are executed withouth CPU
> 
> s/withouth/without/
Ack

> > + * intervention so no soft timestamp can be recorded when transfers run.
> > + * Because of that, the macros that set timestamp channel are only used when
> > + * transfers are not offloaded.
> > + */
...
> > @@ -784,7 +1081,10 @@ static int ad4000_probe(struct spi_device *spi)
> >  	switch (st->sdi_pin) {
> >  	case AD4000_SDI_MOSI:
> >  		indio_dev->info = &ad4000_reg_access_info;
> > -		indio_dev->channels = chip->reg_access_chan_spec;
> > +
> > +		/* Set CNV/CS high time for when turbo mode is used */
> > +		spi->cs_inactive.value = st->time_spec->t_quiet1_ns;
> > +		spi->cs_inactive.unit = SPI_DELAY_UNIT_NSECS;
> 
> This code path later calls ad4000_prepare_3wire_mode_message() which sets:
> 
> 	xfers[0].cs_change_delay.value = st->time_spec->t_conv_ns;
> 
> Which contradicts/overrides this.

Oof, good point. Though, it's probably not a problem if single-shot transfers
use a longer delay, right? Would that also override cs_inactive or be of any
trouble for SPI controllers?

...
> >  
> > +		if (st->using_offload) {
> > +			indio_dev->channels = &chip->reg_access_offload_chan_spec;
> > +			indio_dev->num_channels = 1;
> > +			ret = ad4000_prepare_offload_message(st, indio_dev->channels);
> > +			if (ret)
> > +				return dev_err_probe(dev, ret,
> > +						     "Failed to optimize SPI msg\n");
> > +		} else {
> > +			indio_dev->channels = chip->reg_access_chan_spec;
> > +			indio_dev->num_channels = ARRAY_SIZE(chip->reg_access_chan_spec);
> > +		}
> > +
> > +		/*
> > +		 * Call ad4000_prepare_3wire_mode_message() so single-shot read
> > +		 * SPI messages are always initialized.
> > +		 */
> >  		ret = ad4000_prepare_3wire_mode_message(st, &indio_dev->channels[0]);
> >  		if (ret)
> > -			return ret;
> > +			return dev_err_probe(dev, ret,
> > +					     "Failed to optimize SPI msg\n");
> >  
> >  		ret = ad4000_config(st);
> >  		if (ret < 0)
> > @@ -806,19 +1123,47 @@ static int ad4000_probe(struct spi_device *spi)
> >  
> >  		break;
> >  	case AD4000_SDI_VIO:
> > -		indio_dev->info = &ad4000_info;
> > -		indio_dev->channels = chip->chan_spec;
> > +		if (st->using_offload) {
> > +			indio_dev->info = &ad4000_offload_info;
> > +			indio_dev->channels = &chip->offload_chan_spec;
> > +			indio_dev->num_channels = 1;
> > +
> > +			/* Set CNV/CS high time for when turbo mode is not used */
> > +			if (!st->cnv_gpio) {
> > +				spi->cs_inactive.value = st->time_spec->t_conv_ns;
> > +				spi->cs_inactive.unit = SPI_DELAY_UNIT_NSECS;
> 
> I'm still not sold on this. We know it has no effect with AXI SPI Engine and
> it is writing over something that usually comes from DT. It is misleading.

I thought it was okay to set cs_inactive and call spi_setup() from the field
doc in include/linux/spi/spi.h.

	set_cs_timing() method is for SPI controllers that supports
	configuring CS timing.
	
	This hook allows SPI client drivers to request SPI controllers
	to configure specific CS timing through spi_set_cs_timing() after
	spi_setup().

Would it be better to set spi-cs-inactive-delay-ns in ADC dt node?
Or it still doesn't look like a proper use of cs_inactive?

> 
> And the non-offload case already does:
> 
> 	xfers[0].cs_change_delay.value = st->time_spec->t_conv_ns;
> 
> which actually does work with the AXI SPI Engine. So why not be consistent and
> do it the same way for the offload case?

One of the points in using `bits_per_word` in spi transfers was to reach high
frequency sample rate, right? I think it makes sense to use them for SPI offload
transfers. But we were also trying to set a proper CNV/CS dealy so that ADC
conversion could complete properly before starting requesting the data. That
also sound reasonable to me. But, spi_transfer struct doesn't provide a good
way of setting a CS inactive delay if only one transfer is executed. If we
use `cs_change_delay`, we would then be running two transfers, no? Plus, the ADC
would be doing two conversions (one after CS deasert of previous message and
one after CS deassert at the end of the first transfer) while we only read one
of them.

The offload message preparation would look like what we had in v2:

static int ad4000_prepare_offload_turbo_message(struct ad4000_state *st,
						const struct iio_chan_spec *chan)
{
	struct spi_transfer *xfers = st->offload_xfers;

	/* Dummy transfer to guarantee enough CS high time. */
	xfers[0].cs_change = 1;
	xfers[0].cs_change_delay.value = st->time_spec->t_quiet1_ns;
	xfers[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;

	xfers[1].bits_per_word = chan->scan_type.realbits;
	xfers[1].len = chan->scan_type.realbits > 16 ? 4 : 2;
	xfers[1].delay.value = st->time_spec->t_quiet2_ns;
	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
	xfers[1].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;

	spi_message_init_with_transfers(&st->offload_msg, xfers, 2);
	st->offload_msg.offload = st->offload;

	return devm_spi_optimize_message(&st->spi->dev, st->spi, &st->offload_msg);
}

Are we worried about a few clock cycles in between transfers but not worried
about running an entire dummy transfer?

Plus, I've tested the single-transfer offload message version with ADAQ4003 on
CoraZ7 and verified the results were correct.
FWIW, I put a copy of the dts I used for the tests at the end of this email.

> 
> It also seems safe to omit this altogether in the offload case and assume that
> the max sample rate will also ensure that the miniumum time for CS deasserted
> is respected.

If we can assume that, then I think that's another reason why we don't need
a dummy transfer to set CS high delay.

> 
> > +				ret = spi_setup(spi);
> > +				if (ret < 0)
> > +					return ret;
> > +			}
> > +
> > +			ret = ad4000_prepare_offload_message(st, indio_dev->channels);
> > +			if (ret)
> > +				return dev_err_probe(dev, ret,
> > +						     "Failed to optimize SPI msg\n");
> > +		} else {
> > +			indio_dev->info = &ad4000_info;
> > +			indio_dev->channels = chip->chan_spec;
> > +			indio_dev->num_channels = ARRAY_SIZE(chip->chan_spec);
> > +		}
> > +
> >  		ret = ad4000_prepare_3wire_mode_message(st, &indio_dev->channels[0]);
> >  		if (ret)
> > -			return ret;
> > +			return dev_err_probe(dev, ret,
> > +					     "Failed to optimize SPI msg\n");
> >  
> >  		break;


---------- zynq-coraz7s-adaq4003.dts { ------------------

// SPDX-License-Identifier: GPL-2.0
/*
 * Analog Devices ADAQ4003
 *
 * hdl_project: <pulsar_adc/coraz7s>
 * Link: https://github.com/analogdevicesinc/hdl/tree/main/projects/pulsar_adc
 * board_revision: <A>
 *
 * Copyright (C) 2023 Analog Devices Inc.
 */
/dts-v1/;
#include "zynq-coraz7s.dtsi"
#include <dt-bindings/interrupt-controller/irq.h>
#include <dt-bindings/gpio/gpio.h>

/ {
	adc_vref: regulator-vref {
		compatible = "regulator-fixed";
		regulator-name = "EVAL 5V Vref";
		regulator-min-microvolt = <5000000>;
		regulator-max-microvolt = <5000000>;
		regulator-always-on;
	};

	adc_vdd: regulator-vdd {
		compatible = "regulator-fixed";
		regulator-name = "Eval VDD supply";
		regulator-min-microvolt = <5000000>;
		regulator-max-microvolt = <5000000>;
		regulator-always-on;
	};

	adc_vio: regulator-vio {
		compatible = "regulator-fixed";
		regulator-name = "Eval VIO supply";
		regulator-min-microvolt = <3300000>;
		regulator-max-microvolt = <3300000>;
		regulator-always-on;
	};

	trigger_pwm: adc-pwm-trigger {
		compatible = "pwm-trigger";
		#trigger-source-cells = <0>;
		pwms = <&adc_trigger 0 1000000 0>;
	};
};

&fpga_axi {

	adc_trigger: pwm@0x44b00000 {
		compatible = "adi,axi-pwmgen-2.00.a";
		reg = <0x44b00000 0x1000>;
		label = "adc_conversion_trigger";
		#pwm-cells = <2>;
		clocks = <&spi_clk>;
	};

	spi_engine: spi@44a00000 {
		compatible = "adi,axi-spi-engine-1.00.a";
		reg = <0x44a00000 0x10000>;
		interrupt-parent = <&intc>;
		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
		clocks = <&clkc 15 &spi_clk>;
		clock-names = "s_axi_aclk", "spi_clk";

		dmas = <&rx_dma 0>;
		dma-names = "offload0-rx";
		trigger-sources = <&trigger_pwm>;

		#address-cells = <0x1>;
		#size-cells = <0x0>;

		adc@0 {
			compatible = "adi,adaq4003";
			reg = <0>;
			spi-max-frequency = <100000000>;
			vdd-supply = <&adc_vdd>;
			vio-supply = <&adc_vio>;
			ref-supply = <&adc_vref>;
			adi,high-z-input;
			adi,gain-milli = /bits/ 16 <454>;
		};
	};

	rx_dma: rx-dmac@44a30000 {
		compatible = "adi,axi-dmac-1.00.a";
		reg = <0x44a30000 0x1000>;
		#dma-cells = <1>;
		interrupt-parent = <&intc>;
		interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
		clocks = <&clkc 16>;
	};

	spi_clk: axi-clkgen@0x44a70000 {
		compatible = "adi,axi-clkgen-2.00.a";
		reg = <0x44a70000 0x10000>;
		#clock-cells = <0>;
		clocks = <&clkc 15>, <&clkc 15>;
		clock-names = "s_axi_aclk", "clkin1";
		clock-output-names = "spi_clk";

		assigned-clocks = <&spi_clk>;
		assigned-clock-rates = <200000000>;
	};
};

---------- } zynq-coraz7s-adaq4003.dts ------------------


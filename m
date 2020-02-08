Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25C4815650A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2020 16:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgBHPRQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Feb 2020 10:17:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbgBHPRQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Feb 2020 10:17:16 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B8C21775;
        Sat,  8 Feb 2020 15:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581175034;
        bh=9vkfK4DkTkSFl20zyERXBNXCrVgaHj2kIkQRFdy7WN4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N2qxL6gAtuzDtZtroGakANCp9F41AFDwqMvjvi0XZluUdpu0bOOyAE+j521taclbc
         DOAHcIYrtt8EIi3nDhhAqCqXYVVtJVgQVUtlzv1taw9CEIM+Tp337URe3j5vMG5GRn
         Yh+IaWQBUf1GDV06gpX1ULb8vmG1581BU1TwvGWc=
Date:   Sat, 8 Feb 2020 15:17:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomas Novotny <tomas@novotny.cz>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Subject: Re: [PATCH 5/5] iio: light: vcnl4000: add control of multi pulse
Message-ID: <20200208151710.4a9cbc13@archlinux>
In-Reply-To: <20200205101655.11728-6-tomas@novotny.cz>
References: <20200205101655.11728-1-tomas@novotny.cz>
        <20200205101655.11728-6-tomas@novotny.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  5 Feb 2020 11:16:55 +0100
Tomas Novotny <tomas@novotny.cz> wrote:

> Multi pulse settings allow to emit more pulses during one measurement
> (up to 8 on vcnl4040 and vcnl4200). The raw reading is approximately
> multiplied by the multi pulse settings. More information is available in
> the added documentation.
> 
> Multi pulse is specific only for proximity sensor. Only the vcnl4040 and
> vcnl4200 hardware supports this settings.

A few comments but this one is more or less good.

Thanks,

Jonathan

> 
> Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-vcnl4000 | 21 +++++++++
>  drivers/iio/light/vcnl4000.c                     | 60 ++++++++++++++++++++++++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-vcnl4000 b/Documentation/ABI/testing/sysfs-bus-iio-vcnl4000
> index 4860f409dbf0..923a78dc9869 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-vcnl4000
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-vcnl4000
> @@ -16,3 +16,24 @@ KernelVersion:	5.7
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		The on/off available duty ratios.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_multi_pulse

This is less ambiguous than duty_cycle, but perhaps something 
in_proximity_led_pulse_count is more specific?

> +Date:		February 2020
> +KernelVersion:	5.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Instead of one single pulse per every measurement, more pulses
> +		may be programmed. This leads to a longer led current on-time
> +		for each proximity measurement, which also results in a higher
> +		detection range. The raw reading is approximately multiplied by
> +		the multi pulse settings. The duty ration is not changed. The

Hmm. Normal meaning of duty ratio would be changed by this...  It's uneven but
multiple pulses == more on time hence lower duty ratio.

> +		settings cannot be changed when the proximity channel is
> +		enabled.  Valid values are in the respective '_available'
> +		attribute.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_multi_pulse_available
> +Date:		February 2020
> +KernelVersion:	5.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		List of multi pulse values.
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index a8c2ce1056a6..cc75e5e7e634 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -46,6 +46,7 @@
>  
>  #define VCNL4200_AL_CONF	0x00 /* Ambient light configuration */
>  #define VCNL4200_PS_CONF1	0x03 /* Proximity configuration */
> +#define VCNL4200_PS_CONF3	0x04 /* Proximity conf., white channel, LED I */
>  #define VCNL4200_PS_DATA	0x08 /* Proximity data */
>  #define VCNL4200_AL_DATA	0x09 /* Ambient light data */
>  #define VCNL4200_DEV_ID		0x0e /* Device ID, slave address and version */
> @@ -65,6 +66,8 @@
>  #define VCNL4200_PS_DUTY_MASK	GENMASK(7, 6) /* Proximity duty ratio */
>  #define VCNL4200_PS_DUTY_SHIFT	6
>  #define VCNL4200_PS_SD		BIT(0) /* Proximity shutdown */
> +#define VCNL4200_PS_MPS_MASK	GENMASK(6, 5)
> +#define VCNL4200_PS_MPS_SHIFT	5

You could probably use the FIELD_PREP  macros etc to avoid having both mask and
shift defines.

>  
>  enum vcnl4000_device_ids {
>  	VCNL4000,
> @@ -223,11 +226,24 @@ static const char * const vcnl4200_ps_duty_ratio_items[] = {
>  	"1/1280"
>  };
>  
> +/* Values are directly mapped to register values. */
> +static const char * const vcnl4200_ps_multi_pulse_items[] = {
> +	"1",
> +	"2",
> +	"4",
> +	"8"
> +};
> +
>  static int vcnl4200_get_ps_duty_ratio(struct iio_dev *indio_dev,
>  				      const struct iio_chan_spec *chan);
>  static int vcnl4200_set_ps_duty_ratio(struct iio_dev *indio_dev,
>  				      const struct iio_chan_spec *chan,
>  				      unsigned int mode);
> +static int vcnl4200_get_ps_multi_pulse(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan);
> +static int vcnl4200_set_ps_multi_pulse(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       unsigned int mode);
>  
>  static const struct iio_enum vcnl4040_ps_duty_ratio_enum = {
>  	.items = vcnl4040_ps_duty_ratio_items,
> @@ -243,15 +259,26 @@ static const struct iio_enum vcnl4200_ps_duty_ratio_enum = {
>  	.set = vcnl4200_set_ps_duty_ratio,
>  };
>  
> +static const struct iio_enum vcnl4200_ps_multi_pulse_enum = {
> +	.items = vcnl4200_ps_multi_pulse_items,
> +	.num_items = ARRAY_SIZE(vcnl4200_ps_multi_pulse_items),
> +	.get = vcnl4200_get_ps_multi_pulse,
> +	.set = vcnl4200_set_ps_multi_pulse,
> +};
> +
>  static const struct iio_chan_spec_ext_info vcnl4040_ps_ext_info[] = {
>  	IIO_ENUM("duty_ratio", IIO_SEPARATE, &vcnl4040_ps_duty_ratio_enum),
>  	IIO_ENUM_AVAILABLE("duty_ratio", &vcnl4040_ps_duty_ratio_enum),
> +	IIO_ENUM("multi_pulse", IIO_SEPARATE, &vcnl4200_ps_multi_pulse_enum),
> +	IIO_ENUM_AVAILABLE("multi_pulse", &vcnl4200_ps_multi_pulse_enum),
>  	{ },
>  };
>  
>  static const struct iio_chan_spec_ext_info vcnl4200_ps_ext_info[] = {
>  	IIO_ENUM("duty_ratio", IIO_SEPARATE, &vcnl4200_ps_duty_ratio_enum),
>  	IIO_ENUM_AVAILABLE("duty_ratio", &vcnl4200_ps_duty_ratio_enum),
> +	IIO_ENUM("multi_pulse", IIO_SEPARATE, &vcnl4200_ps_multi_pulse_enum),
> +	IIO_ENUM_AVAILABLE("multi_pulse", &vcnl4200_ps_multi_pulse_enum),
>  	{ },
>  };
>  
> @@ -638,6 +665,39 @@ static int vcnl4200_set_ps_duty_ratio(struct iio_dev *indio_dev,
>  	return vcnl4200_set_samp_rate(data, IIO_PROXIMITY);
>  };
>  
> +static int vcnl4200_get_ps_multi_pulse(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan)
> +{
> +	int ret;
> +	unsigned int val;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	ret = regmap_read(data->regmap, VCNL4200_PS_CONF3, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val &= VCNL4200_PS_MPS_MASK;
> +	val >>= VCNL4200_PS_MPS_SHIFT;
> +
> +	return val;
> +};
> +
> +static int vcnl4200_set_ps_multi_pulse(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       unsigned int mode)
> +{
> +	int ret;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	ret = vcnl4200_check_enabled(data, IIO_PROXIMITY);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap, VCNL4200_PS_CONF3,
> +				  VCNL4200_PS_MPS_MASK,
> +				  mode << VCNL4200_PS_MPS_SHIFT);
> +};
> +
>  static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
>  	[VCNL4000] = {
>  		.prod = "VCNL4000",


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A495ACC21
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 12:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfIHKlA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 06:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbfIHKlA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 06:41:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E286A21479;
        Sun,  8 Sep 2019 10:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567939258;
        bh=ociWGpLiJNcrDuxPrDDxdeP9JEnYr6iUTWIQDkrAaqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aIWd6Q0xiHiSrJVQpTEFwfv1qATg2A0oGPzzKHl8VeFZ+j5BRP9lHVfNjFBbOWMZ/
         uGAF6lZnSoxdZMAHFZoWTT5iO6VDobe4+qkvsFhELQkr9lSXKJd8TRgsmB+zVMYH+T
         vWB5k9fixYQAFw9IK9GEy2o9SojBzt3xrrQxUDAY=
Date:   Sun, 8 Sep 2019 10:36:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH V4 3/4] staging: iio: adc: ad7192: Add system
 calibration support
Message-ID: <20190908103659.46319d90@archlinux>
In-Reply-To: <20190902130831.23057-3-mircea.caprioru@analog.com>
References: <20190902130831.23057-1-mircea.caprioru@analog.com>
        <20190902130831.23057-3-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Sep 2019 16:08:30 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch will add a system calibration attribute for each channel. Using
> this option the user will have the ability to calibrate each channel for
> zero scale and full scale. It uses the iio_chan_spec_ext_info and IIO_ENUM
> to implement the functionality.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>

I can see this may at somepoint become a 'general' interface and I think
your ABI choice is sufficiently flexible to allow that.

Hence applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changelog V2:
> - no changes here
> 
> Changelog V3:
> - no changes here
> 
> Changelog V4:
> - add an attribute to start the system calibration
> - the mode attribute does not trigger the calibration
> - added ABI documentation
> 
>  .../ABI/testing/sysfs-bus-iio-adc-ad7192      | 24 ++++++
>  drivers/staging/iio/adc/ad7192.c              | 79 ++++++++++++++++++-
>  2 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> index 74a2873045bf..7627d3be08f5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> @@ -13,3 +13,27 @@ Description:
>  		need to minimize the system current consumption.
>  		Reading gives the state of the bridge switch.
>  		Writing '1' enables the bridge switch.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Initiates the system calibration procedure. This is done on a
> +		single channel at a time. Write '1' to start the calibration.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a list with the possible calibration modes.
> +		There are two available options:
> +		"zero_scale" - calibrate to zero scale
> +		"full_scale" - calibrate to full scale
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Sets up the calibration mode used in the system calibration
> +		procedure. Reading returns the current calibration mode.
> +		Writing sets the system calibration mode.
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index d58ce08f3693..c5106d98c9b3 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -155,6 +155,11 @@
>   * The DOUT/RDY output must also be wired to an interrupt capable GPIO.
>   */
>  
> +enum {
> +   AD7192_SYSCALIB_ZERO_SCALE,
> +   AD7192_SYSCALIB_FULL_SCALE,
> +};
> +
>  struct ad7192_state {
>  	struct regulator		*avdd;
>  	struct regulator		*dvdd;
> @@ -169,10 +174,80 @@ struct ad7192_state {
>  	u8				devid;
>  	u8				clock_sel;
>  	struct mutex			lock;	/* protect sensor state */
> +	u8				syscalib_mode[8];
>  
>  	struct ad_sigma_delta		sd;
>  };
>  
> +static const char * const ad7192_syscalib_modes[] = {
> +	[AD7192_SYSCALIB_ZERO_SCALE] = "zero_scale",
> +	[AD7192_SYSCALIB_FULL_SCALE] = "full_scale",
> +};
> +
> +static int ad7192_set_syscalib_mode(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    unsigned int mode)
> +{
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +
> +	st->syscalib_mode[chan->channel] = mode;
> +
> +	return 0;
> +}
> +
> +static int ad7192_get_syscalib_mode(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan)
> +{
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +
> +	return st->syscalib_mode[chan->channel];
> +}
> +
> +static ssize_t ad7192_write_syscalib(struct iio_dev *indio_dev,
> +				     uintptr_t private,
> +				     const struct iio_chan_spec *chan,
> +				     const char *buf, size_t len)
> +{
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +	bool sys_calib;
> +	int ret, temp;
> +
> +	ret = strtobool(buf, &sys_calib);
> +	if (ret)
> +		return ret;
> +
> +	temp = st->syscalib_mode[chan->channel];
> +	if (sys_calib) {
> +		if (temp == AD7192_SYSCALIB_ZERO_SCALE)
> +			ret = ad_sd_calibrate(&st->sd, AD7192_MODE_CAL_SYS_ZERO,
> +					      chan->address);
> +		else
> +			ret = ad_sd_calibrate(&st->sd, AD7192_MODE_CAL_SYS_FULL,
> +					      chan->address);
> +	}
> +
> +	return ret ? ret : len;
> +}
> +
> +static const struct iio_enum ad7192_syscalib_mode_enum = {
> +	.items = ad7192_syscalib_modes,
> +	.num_items = ARRAY_SIZE(ad7192_syscalib_modes),
> +	.set = ad7192_set_syscalib_mode,
> +	.get = ad7192_get_syscalib_mode
> +};
> +
> +static const struct iio_chan_spec_ext_info ad7192_calibsys_ext_info[] = {
> +	{
> +		.name = "sys_calibration",
> +		.write = ad7192_write_syscalib,
> +		.shared = IIO_SEPARATE,
> +	},
> +	IIO_ENUM("sys_calibration_mode", IIO_SEPARATE,
> +		 &ad7192_syscalib_mode_enum),
> +	IIO_ENUM_AVAILABLE("sys_calibration_mode", &ad7192_syscalib_mode_enum),
> +	{}
> +};
> +
>  static struct ad7192_state *ad_sigma_delta_to_ad7192(struct ad_sigma_delta *sd)
>  {
>  	return container_of(sd, struct ad7192_state, sd);
> @@ -769,9 +844,11 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
>  		*chan = channels[i];
>  		chan->info_mask_shared_by_all |=
>  			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY);
> -		if (chan->type != IIO_TEMP)
> +		if (chan->type != IIO_TEMP) {
>  			chan->info_mask_shared_by_type_available |=
>  				BIT(IIO_CHAN_INFO_SCALE);
> +			chan->ext_info = ad7192_calibsys_ext_info;
> +		}
>  		chan++;
>  	}
>  


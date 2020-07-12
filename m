Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A3521C8AD
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jul 2020 13:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgGLLHz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jul 2020 07:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgGLLHz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Jul 2020 07:07:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 625252070B;
        Sun, 12 Jul 2020 11:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594552075;
        bh=VQYnof+3zxRfw57/Ng3rwFQWh3H071SZuRU7Lssd3Y4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fuATGhEthg/Tu6uL2oHbYJBBgOmIAXEf/88abryDxMPV6rZeNjwTW6mO0ECJgTgiv
         xq6VUHmBz5TUgh0aqPEzbK1L94FPuUIdu6Ji0A2Sh3Q9LMOalWyL44FYiByq9rI1di
         zioVrDlEjKBYD6kSg1W1dXT6408w1ShHxmyqKepc=
Date:   Sun, 12 Jul 2020 12:07:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: cros_ec_accel_legacy: Add Read Only frequency
 entries
Message-ID: <20200712120751.7e7fb7a4@archlinux>
In-Reply-To: <853ea3f1-83d8-2a4a-8994-1351d36cbe66@collabora.com>
References: <20200709180924.2437466-1-gwendal@chromium.org>
        <853ea3f1-83d8-2a4a-8994-1351d36cbe66@collabora.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jul 2020 10:21:47 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Hi Gwendal,
> 
> On 9/7/20 20:09, Gwendal Grignou wrote:
> > Report to user space that 10Hz is the sampling frequency of
> > the accelerometers in legacy mode, and it can not be changed.
> > 
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>  
> 
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
I'm fairly sure you could have just used IIO_VAL_INT as the return
value given the micro part is 0.  Doesn't make any practical difference
though so applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it!

Thanks,

Jonathan

> 
> > ---
> > Changes since v2:
> > - fix compilation warning
> > Changes since v1:
> > - Use a static array to store the single frequency allowed.
> > 
> >  drivers/iio/accel/cros_ec_accel_legacy.c | 46 +++++++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > index 2532b9ad33842..b6f3471b62dcf 100644
> > --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > @@ -33,6 +33,11 @@
> >   */
> >  #define ACCEL_LEGACY_NSCALE 9586168
> >  
> > +/*
> > + * Sensor frequency is hard-coded to 10Hz.
> > + */
> > +static const int cros_ec_legacy_sample_freq[] = { 10, 0 };
> > +
> >  static int cros_ec_accel_legacy_read_cmd(struct iio_dev *indio_dev,
> >  				  unsigned long scan_mask, s16 *data)
> >  {
> > @@ -96,6 +101,11 @@ static int cros_ec_accel_legacy_read(struct iio_dev *indio_dev,
> >  		*val = 0;
> >  		ret = IIO_VAL_INT;
> >  		break;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		*val = cros_ec_legacy_sample_freq[0];
> > +		*val2 = cros_ec_legacy_sample_freq[1];
> > +		ret = IIO_VAL_INT_PLUS_MICRO;
> > +		break;
> >  	default:
> >  		ret = cros_ec_sensors_core_read(st, chan, val, val2,
> >  				mask);
> > @@ -120,9 +130,39 @@ static int cros_ec_accel_legacy_write(struct iio_dev *indio_dev,
> >  	return -EINVAL;
> >  }
> >  
> > +/**
> > + * cros_ec_accel_legacy_read_avail() - get available values
> > + * @indio_dev:		pointer to state information for device
> > + * @chan:	channel specification structure table
> > + * @vals:	list of available values
> > + * @type:	type of data returned
> > + * @length:	number of data returned in the array
> > + * @mask:	specifies which values to be requested
> > + *
> > + * Return:	an error code or IIO_AVAIL_LIST
> > + */
> > +static int cros_ec_accel_legacy_read_avail(struct iio_dev *indio_dev,
> > +					   struct iio_chan_spec const *chan,
> > +					   const int **vals,
> > +					   int *type,
> > +					   int *length,
> > +					   long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		*length = ARRAY_SIZE(cros_ec_legacy_sample_freq);
> > +		*vals = cros_ec_legacy_sample_freq;
> > +		*type = IIO_VAL_INT_PLUS_MICRO;
> > +		return IIO_AVAIL_LIST;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> >  static const struct iio_info cros_ec_accel_legacy_info = {
> >  	.read_raw = &cros_ec_accel_legacy_read,
> >  	.write_raw = &cros_ec_accel_legacy_write,
> > +	.read_avail = &cros_ec_accel_legacy_read_avail,
> >  };
> >  
> >  /*
> > @@ -142,7 +182,11 @@ static const struct iio_info cros_ec_accel_legacy_info = {
> >  		.info_mask_separate =					\
> >  			BIT(IIO_CHAN_INFO_RAW) |			\
> >  			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
> > -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
> > +		.info_mask_shared_by_all =				\
> > +			BIT(IIO_CHAN_INFO_SCALE) |			\
> > +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> > +		.info_mask_shared_by_all_available =			\
> > +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> >  		.ext_info = cros_ec_sensors_ext_info,			\
> >  		.scan_type = {						\
> >  			.sign = 's',					\
> >   


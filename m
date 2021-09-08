Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9503A403E16
	for <lists+linux-iio@lfdr.de>; Wed,  8 Sep 2021 19:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352371AbhIHRGM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Sep 2021 13:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235666AbhIHRGL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 Sep 2021 13:06:11 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1301961139;
        Wed,  8 Sep 2021 17:05:00 +0000 (UTC)
Date:   Wed, 8 Sep 2021 18:08:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Roan van Dijk <roan@protonic.nl>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 3/3] drivers: iio: chemical: Add support for
 Sensirion SCD4x CO2 sensor
Message-ID: <20210908180826.7074161d@jic23-huawei>
In-Reply-To: <7b93a51a-3856-63a8-20fb-e2b7f341254a@protonic.nl>
References: <20210901105911.178646-1-roan@protonic.nl>
        <20210901105911.178646-4-roan@protonic.nl>
        <20210905152253.3ea6beb3@jic23-huawei>
        <7b93a51a-3856-63a8-20fb-e2b7f341254a@protonic.nl>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 7 Sep 2021 16:10:40 +0200
Roan van Dijk <roan@protonic.nl> wrote:

> On 05-09-2021 16:22, Jonathan Cameron wrote:
> > On Wed,  1 Sep 2021 12:59:11 +0200
> > Roan van Dijk <roan@protonic.nl> wrote:
> >  
> >> This is a driver for the SCD4x CO2 sensor from Sensirion. The sensor is
> >> able to measure CO2 concentration, temperature and relative humdity.
> >> The sensor uses a photoacoustic principle for measuring CO2 concentration.
> >> An I2C interface is supported by this driver in order to communicate with
> >> the sensor.
> >>
> >> Signed-off-by: Roan van Dijk <roan@protonic.nl>  
> > Hi Roan,
> >
> > Various comments inline.
> >
> > Thanks,
> >
> > Jonathan  
> Hi Jonathan,
> 
> Thank you for your feedback. Changes due to your
> comments will be added in the next patch.
> 
> However, I have some questions about some of the comments.
> I added my questions to your inline comments.
> Could you help me with these questions?
> 
> Thanks,
> 
> Roan
Replies follow,

Jonathan

> >> +static int scd4x_read_raw(struct iio_dev *indio_dev,
> >> +			struct iio_chan_spec const *chan, int *val,
> >> +			int *val2, long mask)
> >> +{
> >> +	struct scd4x_state *state = iio_priv(indio_dev);
> >> +	int ret;
> >> +	uint16_t tmp;
> >> +
> >> +	mutex_lock(&state->lock);
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_RAW:
> >> +	case IIO_CHAN_INFO_PROCESSED:
> >> +		ret = iio_device_claim_direct_mode(indio_dev);
> >> +		if (ret)
> >> +			break;
> >> +
> >> +		ret = scd4x_read_poll(state);  
> > Perhaps neater to wrap scd4x_read_poll() as scd4x_read_channel() that
> > returns the value for the requested channel.  That would make this
> > look like
> > 		
> > 		ret = scd4x_read_poll(state, chan->address);
> > 		iio_device_release_direct_mode();
> > 		if (ret)
> > 			return ret;
> >
> > 		*val = ret;
> > 		return IIO_VAL_INT;  
> The scd4x_read_poll() can return errors, like -ETIMEOUT. In that case
> we need to check here if ret has returned an error or data for the
> requested channel. Which could make the readability a bit harder.

This is pretty common for read type functions so readability impact
is not great.

> Besides the scd4x_read_poll() is also used in scd4x_trigger_handler()
> to read all channels at once instead of just one channel. So I think
> changing it to a request for one channel at a time, will not make it neater.

I'm suggesting a wrapper around that function not removing it.
What I would like to avoid is 'stashing' temporary variables inside
the state structure when there is not need.  An alternative would be to
pass in a buffer on the stack and put the value in that. 

> Or am I mistaken? I could still rename the function to
> scd4x_read_channels() if that makes more sense or do you have
> other suggestions?

The rename is a good idea anyway.

> >> +		if (ret) {
> >> +			iio_device_release_direct_mode(indio_dev);
> >> +			break;
> >> +		}
> >> +		*val = state->meas[chan->address];  
> > If you need to protect a local variable, use a local lock as well as
> > iio_device_release_direct_mode().  Today that function provides the
> > mutual exclusion you want but it isn't necessarily always going to do
> > so...
> >  
> >> +		iio_device_release_direct_mode(indio_dev);
> >> +		ret = IIO_VAL_INT;
> >> +		break;
> >> +	case IIO_CHAN_INFO_CALIBBIAS:
> >> +		ret = scd4x_read(state, CMD_GET_TEMP_OFFSET, &tmp, 3);
> >> +		if (ret)
> >> +			break;
> >> +		*val = 175000 * be16_to_cpu(tmp) / 65536;
> >> +		ret = IIO_VAL_INT;
> >> +		break;
> >> +	}
> >> +	mutex_unlock(&state->lock);
> >> +
> >> +	return ret;
> >> +}

...


> >> +
> >> +static ssize_t calibration_forced_value_store(struct device *dev,
> >> +					struct device_attribute *attr,
> >> +					const char *buf, size_t len)
> >> +{
> >> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >> +	struct scd4x_state *state = iio_priv(indio_dev);
> >> +	uint16_t val, arg;
> >> +	int ret;
> >> +
> >> +	ret = kstrtou16(buf, 0, &arg);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (arg < SCD4X_FRC_MIN_PPM || arg > SCD4X_FRC_MAX_PPM)
> >> +		return -EINVAL;
> >> +
> >> +	mutex_lock(&state->lock);
> >> +	ret = scd4x_write_and_fetch(state, CMD_FRC, arg, &val, 3);
> >> +	mutex_unlock(&state->lock);
> >> +
> >> +	if (val == 0xff) {
> >> +		dev_err(state->dev, "forced calibration has failed");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return ret ?: len;
> >> +}
> >> +
> >> +static IIO_DEVICE_ATTR_RW(calibration_auto_enable, 0);
> >> +static IIO_DEVICE_ATTR_WO(calibration_forced_value, 0);
> >> +
> >> +static struct attribute *scd4x_attrs[] = {
> >> +	&iio_dev_attr_calibration_auto_enable.dev_attr.attr,  
> > Documentation in Documentation/ABI/sysfs-bus-iio-scd4x or similar needed.  
> What do you think is the best way to do this? To keep the ABI as simple
> as possible, I used the same attributes for scd4x as used by the scd30 
> driver.
> These attributes are already described in
> Documentation/ABI/sysfs-bus-iio-scd30. So should I make a new file for
> the scd4x with the same information or maybe rename the scd30 file
> to a shared file like Documentation/ABI/sysfs-bus-iio-scdxx?

Unfortunately the documentation build system doesn't support repeated
naming in multiple files.  So you need to pull this into a common file.
Given it isn't c02 sensor specific, move it from the scd30 to the
main sysfs-bus-iio file.

> >> +	&iio_dev_attr_calibration_forced_value.dev_attr.attr,
> >> +	NULL
> >> +};
> >> +

...

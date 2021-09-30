Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B1A41DE23
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 17:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346647AbhI3P5H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 11:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346736AbhI3P5H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Sep 2021 11:57:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8960661411;
        Thu, 30 Sep 2021 15:55:20 +0000 (UTC)
Date:   Thu, 30 Sep 2021 16:59:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Roan van Dijk <roan@protonic.nl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 3/4] drivers: iio: chemical: Add support for
 Sensirion SCD4x CO2 sensor
Message-ID: <20210930165915.50fc831b@jic23-huawei>
In-Reply-To: <b9cffd75-0b86-544c-4832-070d12606de4@protonic.nl>
References: <20210922103925.2742362-1-roan@protonic.nl>
        <20210922103925.2742362-4-roan@protonic.nl>
        <20210925172307.305be961@jic23-huawei>
        <b9cffd75-0b86-544c-4832-070d12606de4@protonic.nl>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Sep 2021 14:28:24 +0200
Roan van Dijk <roan@protonic.nl> wrote:

> On 25-09-2021 18:23, Jonathan Cameron wrote:
> > On Wed, 22 Sep 2021 12:39:24 +0200
> > Roan van Dijk <roan@protonic.nl> wrote:
> >   
> >> This is a driver for the SCD4x CO2 sensor from Sensirion. The sensor is
> >> able to measure CO2 concentration, temperature and relative humdity.
> >> The sensor uses a photoacoustic principle for measuring CO2 concentration.
> >> An I2C interface is supported by this driver in order to communicate with
> >> the sensor.
> >>
> >> Signed-off-by: Roan van Dijk <roan@protonic.nl>  
> > 
> > Hi Roan,
> > 
> > Only thing in here of significance is that the format for available attribute
> > is wrong + it needs adding to the ABI docs.
> > 
> > Given we are going to have a v4, I noted a few other minor things to tidy up.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> Thank you for your feedback. I will make a new patch with these fixes.
> 
> The documentation for the _available and the fixes you suggested, have 
> already been added in patch [PATCH v3 4/4]. Do I still need to add 
> something to the ABI documentation or is it fine like this?

Ah. I missed _available documentation for some reason. Sorry about that
it's fine as you have it.

> 
> However, I will change the KernelVersion to 5.15 of the _available 
> description in patch v4. I left this at 5.8 and that's not right, 
> because this information is newly added.
Good spot.

J

> 
> Thanks,
> 
> Roan
> 
> >   
> >> +static int scd4x_read(struct scd4x_state *state, enum scd4x_cmd cmd,
> >> +			void *response, int response_sz)
> >> +{
> >> +	struct i2c_client *client = state->client;
> >> +	char buf[SCD4X_READ_BUF_SIZE];
> >> +	char *rsp = response;
> >> +	int i, ret;
> >> +	char crc;
> >> +
> >> +	/*
> >> +	 * Measurement needs to be stopped before sending commands.
> >> +	 * Except for reading measurement and data ready command.
> >> +	 */
> >> +	if ((cmd != CMD_GET_DATA_READY) && (cmd != CMD_READ_MEAS)) {
> >> +		ret = scd4x_send_command(state, CMD_STOP_MEAS);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		/* execution time for stopping measurement */
> >> +		msleep_interruptible(500);
> >> +	}
> >> +
> >> +	/*CRC byte for every 2 bytes of data */  
> > 
> > /* CRC..
> > 
> > Please check for similar as otherwise we'll get 'cleanup' patches the moment various
> > scripts hit this new code and it'll waste our time!
> >   
> >> +	response_sz += response_sz / 2;
> >> +
> >> +	put_unaligned_be16(cmd, buf);
> >> +	ret = scd4x_i2c_xfer(state, buf, 2, buf, response_sz);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	for (i = 0; i < response_sz; i += 3) {
> >> +		crc = crc8(scd4x_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
> >> +		if (crc != buf[i + 2]) {
> >> +			dev_err(&client->dev, "CRC error\n");
> >> +			return -EIO;
> >> +		}
> >> +
> >> +		*rsp++ = buf[i];
> >> +		*rsp++ = buf[i + 1];
> >> +	}
> >> +
> >> +	/* start measurement */
> >> +	if ((cmd != CMD_GET_DATA_READY) && (cmd != CMD_READ_MEAS)) {
> >> +		ret = scd4x_send_command(state, CMD_START_MEAS);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +  
> > 
> > ...
> >   
> >> +
> >> +static IIO_DEVICE_ATTR_RW(calibration_auto_enable, 0);
> >> +static IIO_DEVICE_ATTR_WO(calibration_forced_value, 0);
> >> +
> >> +static IIO_CONST_ATTR(calibration_forced_value_available,
> >> +	       __stringify(SCD4X_FRC_MIN_PPM 1 SCD4X_FRC_MAX_PPM));  
> > 
> > Ah, I wasn't completely clear on this.  See the main ABI doc for
> > _available
> > 
> > Format for this needs to include brackets to indicate it's a range
> > rather than 3 numbers
> > "[MIN 1  MAX]"
> > 
> > 
> > Having added this it also needs to be in the ABI documentation.
> > Whilst somewhat trivial, all ABI should be documented there.
> >   
> >> +
> >> +static struct attribute *scd4x_attrs[] = {
> >> +	&iio_dev_attr_calibration_auto_enable.dev_attr.attr,
> >> +	&iio_dev_attr_calibration_forced_value.dev_attr.attr,
> >> +	&iio_const_attr_calibration_forced_value_available.dev_attr.attr,
> >> +	NULL
> >> +};
> >> +
> >> +static const struct attribute_group scd4x_attr_group = {
> >> +	.attrs = scd4x_attrs,
> >> +};
> >> +
> >> +static const struct iio_info scd4x_info = {
> >> +	.attrs = &scd4x_attr_group,
> >> +	.read_raw = scd4x_read_raw,
> >> +	.write_raw = scd4x_write_raw,
> >> +};
> >> +  
> > 
> > ...
> >   
> >> +
> >> +static irqreturn_t scd4x_trigger_handler(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *indio_dev = pf->indio_dev;
> >> +	struct scd4x_state *state = iio_priv(indio_dev);
> >> +	struct {
> >> +		uint16_t data[3];
> >> +		int64_t ts __aligned(8);
> >> +	} scan;
> >> +	int ret;
> >> +	uint16_t buf[3];
> >> +
> >> +	mutex_lock(&state->lock);
> >> +	ret = scd4x_read_poll(state, buf);
> >> +	mutex_unlock(&state->lock);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	memset(&scan, 0, sizeof(scan));
> >> +	memcpy(scan.data, buf, sizeof(buf));  
> > 
> > I missed this before, but why not do the scd4x_read_poll() directly into scan->data after
> > you've done the memset?  That way you avoid the need for a memcpy.
> > 
> > i.e.
> > 
> > 	memset(&scan, 0, sizeof(scan));
> > 	mutex_lock(&state->lock)
> > 	ret = scd4x_read_poll(state, scan->data);
> > 	mutex_unlock(&state->lock);
> > 	if (ret)
> > 	...
> > 
> >   
> >> +
> >> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
> >> +out:
> >> +	iio_trigger_notify_done(indio_dev->trig);
> >> +	return IRQ_HANDLED;
> >> +}
> >> +  


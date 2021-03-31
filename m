Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2660234FBB0
	for <lists+linux-iio@lfdr.de>; Wed, 31 Mar 2021 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhCaIcs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Mar 2021 04:32:48 -0400
Received: from foss.arm.com ([217.140.110.172]:33970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232984AbhCaIcc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 31 Mar 2021 04:32:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 608CCD6E;
        Wed, 31 Mar 2021 01:32:32 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B9AA3F792;
        Wed, 31 Mar 2021 01:32:30 -0700 (PDT)
Date:   Wed, 31 Mar 2021 09:32:19 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 25/38] iio/scmi: port driver to the new
 scmi_sensor_proto_ops interface
Message-ID: <20210331083219.GE43717@e120937-lin>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
 <20210316124903.35011-26-cristian.marussi@arm.com>
 <20210330123325.00000456@Huawei.com>
 <20210330125113.GD43717@e120937-lin>
 <20210330183404.00001909@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330183404.00001909@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan

On Tue, Mar 30, 2021 at 06:34:04PM +0100, Jonathan Cameron wrote:
> On Tue, 30 Mar 2021 13:51:13 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Hi Jonathan,
> > 
> > On Tue, Mar 30, 2021 at 12:33:25PM +0100, Jonathan Cameron wrote:
> > > On Tue, 16 Mar 2021 12:48:50 +0000
> > > Cristian Marussi <cristian.marussi@arm.com> wrote:
> > >   
> > > > Port driver to the new SCMI Sensor interface based on protocol handles
> > > > and common devm_get_ops().
> > > > 
> > > > Cc: Jyoti Bhayana <jbhayana@google.com>
> > > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>  
> > > 
> > > +CC linux-iio@vger.kernel.org
> > > 
> > > Rule of thumb if it doesn't go there it ends up in randomly location based
> > > on other lists and I might not see it for a few weeks :(
> > >   
> > 
> > Ah sorry, I thought the direct CC was enough.
> 
> No problem. Too much email :)
> 
> > 
> > > > ---
> > > >  drivers/iio/common/scmi_sensors/scmi_iio.c | 91 ++++++++++------------
> > > >  1 file changed, 41 insertions(+), 50 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > index 872d87ca6256..b4bdc3f3a946 100644
> > > > --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> > > > @@ -21,8 +21,10 @@
> > > >  
> > > >  #define SCMI_IIO_NUM_OF_AXIS 3
> > > >  
> > > > +static const struct scmi_sensor_proto_ops *sensor_ops;  
> > > 
> > > Hmm.   I'm not keen on globals when they really should not be necessary.
> > > They just result in lifetimes being out of sync.  Here you are fine because
> > > you set it to an appropriate value as the first thing you do in probe, and
> > > I assume the function only ever returns on answer on repeated calls.
> > > 
> > > Why not put a copy of that pointer inside the struct scmi_iio_priv structures?
> > >   
> > 
> > The reason for this, as I said to Jyoyi who made the same comment indeed,
> > from my point of view (maybe wrong..) was that while the protocol_handle,
> > and previously the handle, are 'per-instance data' (so that you get a
> > different one each time this driver is possibly probed against a different
> > platform-handle) and as such are stored in scmi_iio_priv, the _ops are
> > just plain code pointers and are returned always the same for the same
> > protocol no matter how many times you probe this driver:
> 
> As that's the case, I'm a little confused to why you have added the complexity
> of a query interface in the first place?  Why not just export the ops and
> have the various drivers access them directly?  If there is only
> one set of scmi_sensor_ops etc, then let drivers at it directly, or
> indeed export the functions that make up the ops structure directly.
> 
> This sounds like a bit of abstraction that only serves to make the
> code harder to read.
> 

Thanks for your comments, let me explain a bit.

While the ops are indeed per-protocol common code available to SCMI drivers,
the protocol handle, which you also obtain with devm_protocol_get(), is
instead an opaque reference bound to the specific protocol instance
associated to the platform handle you're using, so that, in case there are
multiple SCMI platforms defined on the system, you'll get, at each probe a
specific and distinct protocol_handle to use with your ops: this way
you'll act upon a completely distinct initialized protocol stack, using
a distinct underlying transport layer toward your platform of choice.

Since this series wanted to unify SCMI standard and custom protocol interfaces
and enable modularization too, the get/put abstraction is there indeed to be
able to track internally protocol users and do resource accounting so that an
SCMI driver has to explicitly ask to use a protocol: the protocols instances are
then initialized on demand only when the first user shows up and more importantly
a hold is put on the protocol module refs avoiding its possible unloading
while still in use (even though only custom protocol are allowed as loadable
modules as of now...)

Coming to the ops instead, the reason not to simply export them was...well...
...not to export new symbols, and not just to stick to the old handle->ops()
interface way of non-exporting ops, or because I'm pavid at exporting new symbols
(I am :D), but because the idea was that in this way it would also have been
easier for vendors writing custom protocol modules to be able to just use them
in their own SCMI driver without the need to export also their new custom ops.
(and same goes generally for any new possible future standard protocol
 which will not require endlessly further exports)

Just for these reasons I attached the ops retrieval the same protocol_get()
interface already introduced to handle all of the above.

> > you just end up
> > calling them against the proper different saved protocol_handle; so it
> > seemed to me an unneeded duplication to stick a copy of the same _ops
> > inside each per-instance scmi_iio_priv, and at the same time it seemed
> > also more straigthforward to access them without too many indirections
> > from inside the scmi_iio_priv struct).
> > 
> > But if these are not valid points I can change this in IIO now, and in
> > the future also in all the other SCMI drivers that currently use this
> > same API and pattern of usage with global ops. (..at least because I'd
> > have to collect again all the other ACks agains and it's a bit later for
> > that now)
> 
> I'm fine with leaving it as is.  There's no fundamental issue, it's just
> a little bit ugly and I'm fussy :)
> 

I'm not fullly liking it too, but it was the best I could come up to cope
with the above reqs (and the limited amount of my grey-matter :D)

But if in the future we can come up with something better, or some reqs
are dropped/revisited I'll be happy to flood the list with another
jumbo-series.

Thanks

Cristian

> > 
> > Thanks
> > 
> > Cristian
> > 
> > > Otherwise this all looks like straight forward refactoring so given the
> > > above is more a 'bad smell' than a bug and I'm rather late to the game.
> > > 
> > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > >   
> > > > +
> > > >  struct scmi_iio_priv {
> > > > -	struct scmi_handle *handle;
> > > > +	struct scmi_protocol_handle *ph;
> > > >  	const struct scmi_sensor_info *sensor_info;
> > > >  	struct iio_dev *indio_dev;
> > > >  	/* adding one additional channel for timestamp */
> > > > @@ -82,7 +84,6 @@ static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
> > > >  static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
> > > >  {
> > > >  	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > -	u32 sensor_id = sensor->sensor_info->id;
> > > >  	u32 sensor_config = 0;
> > > >  	int err;
> > > >  
> > > > @@ -92,27 +93,11 @@ static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
> > > >  
> > > >  	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> > > >  				    SCMI_SENS_CFG_SENSOR_ENABLE);
> > > > -
> > > > -	err = sensor->handle->notify_ops->register_event_notifier(sensor->handle,
> > > > -			SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> > > > -			&sensor_id, &sensor->sensor_update_nb);
> > > > -	if (err) {
> > > > -		dev_err(&iio_dev->dev,
> > > > -			"Error in registering sensor update notifier for sensor %s err %d",
> > > > -			sensor->sensor_info->name, err);
> > > > -		return err;
> > > > -	}
> > > > -
> > > > -	err = sensor->handle->sensor_ops->config_set(sensor->handle,
> > > > -			sensor->sensor_info->id, sensor_config);
> > > > -	if (err) {
> > > > -		sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
> > > > -				SCMI_PROTOCOL_SENSOR,
> > > > -				SCMI_EVENT_SENSOR_UPDATE, &sensor_id,
> > > > -				&sensor->sensor_update_nb);
> > > > +	err = sensor_ops->config_set(sensor->ph, sensor->sensor_info->id,
> > > > +				     sensor_config);
> > > > +	if (err)
> > > >  		dev_err(&iio_dev->dev, "Error in enabling sensor %s err %d",
> > > >  			sensor->sensor_info->name, err);
> > > > -	}
> > > >  
> > > >  	return err;
> > > >  }
> > > > @@ -120,25 +105,13 @@ static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
> > > >  static int scmi_iio_buffer_postdisable(struct iio_dev *iio_dev)
> > > >  {
> > > >  	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > > -	u32 sensor_id = sensor->sensor_info->id;
> > > >  	u32 sensor_config = 0;
> > > >  	int err;
> > > >  
> > > >  	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> > > >  				    SCMI_SENS_CFG_SENSOR_DISABLE);
> > > > -
> > > > -	err = sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
> > > > -			SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> > > > -			&sensor_id, &sensor->sensor_update_nb);
> > > > -	if (err) {
> > > > -		dev_err(&iio_dev->dev,
> > > > -			"Error in unregistering sensor update notifier for sensor %s err %d",
> > > > -			sensor->sensor_info->name, err);
> > > > -		return err;
> > > > -	}
> > > > -
> > > > -	err = sensor->handle->sensor_ops->config_set(sensor->handle, sensor_id,
> > > > -						     sensor_config);
> > > > +	err = sensor_ops->config_set(sensor->ph, sensor->sensor_info->id,
> > > > +				     sensor_config);
> > > >  	if (err) {
> > > >  		dev_err(&iio_dev->dev,
> > > >  			"Error in disabling sensor %s with err %d",
> > > > @@ -161,8 +134,8 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
> > > >  	u32 sensor_config;
> > > >  	char buf[32];
> > > >  
> > > > -	int err = sensor->handle->sensor_ops->config_get(sensor->handle,
> > > > -			sensor->sensor_info->id, &sensor_config);
> > > > +	int err = sensor_ops->config_get(sensor->ph, sensor->sensor_info->id,
> > > > +					 &sensor_config);
> > > >  	if (err) {
> > > >  		dev_err(&iio_dev->dev,
> > > >  			"Error in getting sensor config for sensor %s err %d",
> > > > @@ -208,8 +181,8 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
> > > >  	sensor_config |=
> > > >  		FIELD_PREP(SCMI_SENS_CFG_ROUND_MASK, SCMI_SENS_CFG_ROUND_AUTO);
> > > >  
> > > > -	err = sensor->handle->sensor_ops->config_set(sensor->handle,
> > > > -			sensor->sensor_info->id, sensor_config);
> > > > +	err = sensor_ops->config_set(sensor->ph, sensor->sensor_info->id,
> > > > +				     sensor_config);
> > > >  	if (err)
> > > >  		dev_err(&iio_dev->dev,
> > > >  			"Error in setting sensor update interval for sensor %s value %u err %d",
> > > > @@ -274,8 +247,8 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
> > > >  	u32 sensor_config;
> > > >  	int mult;
> > > >  
> > > > -	int err = sensor->handle->sensor_ops->config_get(sensor->handle,
> > > > -			sensor->sensor_info->id, &sensor_config);
> > > > +	int err = sensor_ops->config_get(sensor->ph, sensor->sensor_info->id,
> > > > +					 &sensor_config);
> > > >  	if (err) {
> > > >  		dev_err(&iio_dev->dev,
> > > >  			"Error in getting sensor config for sensor %s err %d",
> > > > @@ -542,15 +515,17 @@ static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
> > > > -					 struct scmi_handle *handle,
> > > > -					 const struct scmi_sensor_info *sensor_info)
> > > > +static struct iio_dev *
> > > > +scmi_alloc_iiodev(struct scmi_device *sdev, struct scmi_protocol_handle *ph,
> > > > +		  const struct scmi_sensor_info *sensor_info)
> > > >  {
> > > >  	struct iio_chan_spec *iio_channels;
> > > >  	struct scmi_iio_priv *sensor;
> > > >  	enum iio_modifier modifier;
> > > >  	enum iio_chan_type type;
> > > >  	struct iio_dev *iiodev;
> > > > +	struct device *dev = &sdev->dev;
> > > > +	const struct scmi_handle *handle = sdev->handle;
> > > >  	int i, ret;
> > > >  
> > > >  	iiodev = devm_iio_device_alloc(dev, sizeof(*sensor));
> > > > @@ -560,7 +535,7 @@ static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
> > > >  	iiodev->modes = INDIO_DIRECT_MODE;
> > > >  	iiodev->dev.parent = dev;
> > > >  	sensor = iio_priv(iiodev);
> > > > -	sensor->handle = handle;
> > > > +	sensor->ph = ph;
> > > >  	sensor->sensor_info = sensor_info;
> > > >  	sensor->sensor_update_nb.notifier_call = scmi_iio_sensor_update_cb;
> > > >  	sensor->indio_dev = iiodev;
> > > > @@ -595,6 +570,17 @@ static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
> > > >  					  sensor_info->axis[i].id);
> > > >  	}
> > > >  
> > > > +	ret = handle->notify_ops->devm_event_notifier_register(sdev,
> > > > +				SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
> > > > +				&sensor->sensor_info->id,
> > > > +				&sensor->sensor_update_nb);
> > > > +	if (ret) {
> > > > +		dev_err(&iiodev->dev,
> > > > +			"Error in registering sensor update notifier for sensor %s err %d",
> > > > +			sensor->sensor_info->name, ret);
> > > > +		return ERR_PTR(ret);
> > > > +	}
> > > > +
> > > >  	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
> > > >  	iiodev->channels = iio_channels;
> > > >  	return iiodev;
> > > > @@ -604,24 +590,29 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
> > > >  {
> > > >  	const struct scmi_sensor_info *sensor_info;
> > > >  	struct scmi_handle *handle = sdev->handle;
> > > > +	struct scmi_protocol_handle *ph;
> > > >  	struct device *dev = &sdev->dev;
> > > >  	struct iio_dev *scmi_iio_dev;
> > > >  	u16 nr_sensors;
> > > >  	int err = -ENODEV, i;
> > > >  
> > > > -	if (!handle || !handle->sensor_ops) {
> > > > +	if (!handle)
> > > > +		return -ENODEV;
> > > > +
> > > > +	sensor_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_SENSOR, &ph);
> > > > +	if (IS_ERR(sensor_ops)) {
> > > >  		dev_err(dev, "SCMI device has no sensor interface\n");
> > > > -		return -EINVAL;
> > > > +		return PTR_ERR(sensor_ops);
> > > >  	}
> > > >  
> > > > -	nr_sensors = handle->sensor_ops->count_get(handle);
> > > > +	nr_sensors = sensor_ops->count_get(ph);
> > > >  	if (!nr_sensors) {
> > > >  		dev_dbg(dev, "0 sensors found via SCMI bus\n");
> > > >  		return -ENODEV;
> > > >  	}
> > > >  
> > > >  	for (i = 0; i < nr_sensors; i++) {
> > > > -		sensor_info = handle->sensor_ops->info_get(handle, i);
> > > > +		sensor_info = sensor_ops->info_get(ph, i);
> > > >  		if (!sensor_info) {
> > > >  			dev_err(dev, "SCMI sensor %d has missing info\n", i);
> > > >  			return -EINVAL;
> > > > @@ -636,7 +627,7 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
> > > >  		    sensor_info->axis[0].type != RADIANS_SEC)
> > > >  			continue;
> > > >  
> > > > -		scmi_iio_dev = scmi_alloc_iiodev(dev, handle, sensor_info);
> > > > +		scmi_iio_dev = scmi_alloc_iiodev(sdev, ph, sensor_info);
> > > >  		if (IS_ERR(scmi_iio_dev)) {
> > > >  			dev_err(dev,
> > > >  				"failed to allocate IIO device for sensor %s: %ld\n",  
> > >   
> 

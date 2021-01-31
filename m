Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42180309EFC
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 21:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhAaUnS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jan 2021 15:43:18 -0500
Received: from foss.arm.com ([217.140.110.172]:37514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhAaUnQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 15:43:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B9771042;
        Sun, 31 Jan 2021 12:42:30 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BB3B3F71A;
        Sun, 31 Jan 2021 12:42:27 -0800 (PST)
Date:   Sun, 31 Jan 2021 20:42:20 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jyoti Bhayana <jbhayana@google.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        sudeep.holla@arm.com, egranata@google.com,
        mikhail.golubev@opensynergy.com, Igor.Skalkin@opensynergy.com,
        Peter.hilber@opensynergy.com, ankitarora@google.com
Subject: Re: [RFC PATCH v4 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20210131204220.GB8355@e120937-lin>
References: <20210129221818.3540620-1-jbhayana@google.com>
 <20210129221818.3540620-2-jbhayana@google.com>
 <20210131131141.468f1cc2@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131131141.468f1cc2@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

a clarification down below regarding something I pointed out in the
other thread (just to be sure I have not pointed out something
plain wrong :D)

Thanks

Cristian

On Sun, Jan 31, 2021 at 01:11:41PM +0000, Jonathan Cameron wrote:
> On Fri, 29 Jan 2021 22:18:18 +0000
> Jyoti Bhayana <jbhayana@google.com> wrote:
> 
> > This change provides ARM SCMI Protocol based IIO device.
> > This driver provides support for Accelerometer and Gyroscope using
> > SCMI Sensor Protocol extensions added in the SCMIv3.0 ARM specification
> > 
> > Signed-off-by: Jyoti Bhayana <jbhayana@google.com>
> 
> A few minor things noticed on a fresh read through, but mostly I think
> we are down to figuring out how to deal with the range (as discussed
> in the thread continuing on v3).
> 
> On another note, probably time to drop the RFC or give a bit more detail
> on why you think this isn't ready to be applied.
> 
> Thanks,
> 
> Jonathan
> 
[snip]

> > +
> > +static int scmi_iio_dev_probe(struct scmi_device *sdev)
> > +{
> > +	const struct scmi_sensor_info *sensor_info;
> > +	struct scmi_handle *handle = sdev->handle;
> > +	struct device *dev = &sdev->dev;
> > +	struct iio_dev *scmi_iio_dev;
> > +	u16 nr_sensors;
> > +	int err, i;
> > +
> > +	if (!handle || !handle->sensor_ops) {
> > +		dev_err(dev, "SCMI device has no sensor interface\n");
> I'm going to guess we can't actually get here because the registration
> would't have happened if either of those are true?
> If so perhaps drop the error message.
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	nr_sensors = handle->sensor_ops->count_get(handle);
> > +	if (!nr_sensors) {
> > +		dev_dbg(dev, "0 sensors found via SCMI bus\n");
> -ENODEV maybe?
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_dbg(dev, "%d sensors found via SCMI bus\n", nr_sensors);
> 
> Clear out any debug prints out that don't provide info that can't be obtained
> farily easily from elsewhere.  In this case they will either be registered
> or not and we'll get error messages.
> These sort of prints bitrot over time so we want to limit them to the truely
> useful.
> 
> > +
> > +	for (i = 0; i < nr_sensors; i++) {
> > +		sensor_info = handle->sensor_ops->info_get(handle, i);
> > +		if (!sensor_info) {
> > +			dev_err(dev, "SCMI sensor %d has missing info\n", i);
> > +			return -EINVAL;
> > +		}
> > +
> > +		/* Skipping scalar sensor,as this driver only supports accel and gyro */
> > +		if (sensor_info->num_axis == 0)
> > +			continue;
> 
> So there is a situation where this driver never creates anything?  In that path I'd
> like to see an -ENODEV error return.
> 
You mean -ENODEV only if this driver does not find at least one
good/supported GYRO/ACCEL sensor right ?

I would expect a system to possibly expose a bunch of other SCMI sensors
maybe unsupported by this IIO driver but currently handled by other
drivers, as an example on JUNO a number of temps/volts/currents sensors
are exposed and handled by the SCMI hwmon driver.


> > +
> > +		err = scmi_alloc_iiodev(dev, handle, sensor_info,
> > +					&scmi_iio_dev);
> > +		if (err < 0) {
> > +			dev_err(dev,
> > +				"failed to allocate IIO device for sensor %s: %d\n",
> > +				sensor_info->name, err);
> > +			return err;
> > +		}
> > +
> > +		err = scmi_iio_buffers_setup(scmi_iio_dev);
> > +		if (err < 0) {
> > +			dev_err(dev,
> > +				"IIO buffer setup error at sensor %s: %d\n",
> > +				sensor_info->name, err);
> > +			return err;
> > +		}
> > +
> > +		err = devm_iio_device_register(dev, scmi_iio_dev);
> > +		if (err) {
> > +			dev_err(dev,
> > +				"IIO device registration failed at sensor %s: %d\n",
> > +				sensor_info->name, err);
> > +			return err;
> > +		}
> > +	}
> > +	return err;
> > +}
> > +
> > +static const struct scmi_device_id scmi_id_table[] = {
> > +	{ SCMI_PROTOCOL_SENSOR, "iiodev" },
> 
> I'm curious on this.  What actually causes a match on that
> iiodev?  From digging around the scmi core am I right in thinking
> that this iiodev id needs to be explicitly listed?
> 
> It would be good to include any changes needed there in this
> series.
> 
> > +	{},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> > +
> > +static struct scmi_driver scmi_iiodev_driver = {
> > +	.name = "scmi-sensor-iiodev",
> > +	.probe = scmi_iio_dev_probe,
> > +	.id_table = scmi_id_table,
> > +};
> > +
> > +module_scmi_driver(scmi_iiodev_driver);
> > +
> > +MODULE_AUTHOR("Jyoti Bhayana <jbhayana@google.com>");
> > +MODULE_DESCRIPTION("SCMI IIO Driver");
> > +MODULE_LICENSE("GPL v2");
> 

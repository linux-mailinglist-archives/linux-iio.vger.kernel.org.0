Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234E5309C44
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 14:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhAaNAN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jan 2021 08:00:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231922AbhAaMN5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 07:13:57 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B90B164D9F;
        Sun, 31 Jan 2021 12:04:16 +0000 (UTC)
Date:   Sun, 31 Jan 2021 12:04:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jyoti Bhayana <jbhayana@google.com>
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Enrico Granata <egranata@google.com>,
        Mikhail Golubev <mikhail.golubev@opensynergy.com>,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>,
        Ankit Arora <ankitarora@google.com>
Subject: Re: [RFC PATCH v3 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20210131120410.10498129@archlinux>
In-Reply-To: <CA+=V6c05LVmi65ZXjWhhAic6TABnoPuhc7d2gTVoZdK34trDcQ@mail.gmail.com>
References: <20210121232147.1849509-1-jbhayana@google.com>
        <20210121232147.1849509-2-jbhayana@google.com>
        <f6570855-6660-01c6-c46b-915d3253e3b3@opensynergy.com>
        <CA+=V6c05LVmi65ZXjWhhAic6TABnoPuhc7d2gTVoZdK34trDcQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Jan 2021 14:50:20 -0800
Jyoti Bhayana <jbhayana@google.com> wrote:

> Hi Peter,
> 
> I have modified the comments in v4 of that patch. Regarding your
> suggestion of this driver handling a greater value range
> by adjusting the scale accordingly, it would also require the driver
> to change the sensor readings as well based on the updated scale and
> the accuracy of the sensor reading will be lost as the sensor readings
> are 64 bit integers and not float.
> If the IIO driver needs to support a 64 bit sensor range, then I would
> prefer to add a new IIO val type for 64 bit fractional value which
> takes 4 int vals: val_high,val_low, val2_high and val2_low.

The problem with that sort of change is that you have to make
all various users of callbacks in the kernel deal with more parameters.
read_raw gets called form a lot of places.

I'm really not keen to do that.  It means making a big mess to deal
with this one case of too many layers of abstraction and values claiming
considerably more precision than they actually have.  We decided on
an integer pair a long time back as it provides more than enough precision
for any real sensor.

Given that you are using fractional values to generate a sysfs string
(for direct exposure to userspace anyway), just do the maths inside
the driver to fit it into a INT_PLUS_MICRO or similar.

Jonathan

> 
> Thanks,
> Jyoti
> 
> On Tue, Jan 26, 2021 at 7:29 AM Peter Hilber
> <peter.hilber@opensynergy.com> wrote:
> >
> > On 22.01.21 00:21, Jyoti Bhayana wrote:
> >
> > <snip>
> >  
> > > +
> > > +static int scmi_iio_get_sensor_max_range(struct iio_dev *iio_dev, int *val,
> > > +                                      int *val2)
> > > +{
> > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > +     int max_range_high, max_range_low;
> > > +     long long max_range;
> > > +
> > > +     /*
> > > +      * All the axes are supposed to have the same value for max range.
> > > +      * We are just using the values from the Axis 0 here.
> > > +      */
> > > +     if (sensor->sensor_info->axis[0].extended_attrs) {
> > > +             max_range = sensor->sensor_info->axis[0].attrs.max_range;
> > > +             max_range_high = H32(max_range);
> > > +             max_range_low = L32(max_range);
> > > +
> > > +             /*
> > > +              * As IIO Val types have no provision for 64 bit values,
> > > +              * and currently there are no known sensors using 64 bit
> > > +              * for the range, this driver only supports sensor with
> > > +              * 32 bit range value.
> > > +              */  
> > This comment and the corresponding one in
> > scmi_iio_get_sensor_min_range() seem to be misleading to me. The extrema
> > will probably exceed 32 bits even for physical sensors which do have
> > less than 32 bits of resolution. The reason is that the SCMI sensor
> > management protocol does not transmit a `scale' value as used by IIO.
> > Instead, SCMI transmits an exponent with base ten.
> >
> > So, an SCMI sensor with a unit/LSB value which is not a power of ten
> > will have its unit/LSB value split into an exponent (with base ten) and
> > a mantissa.
> >
> > The SCMI platform (which exposes the physical sensor) will have to
> > incorporate the mantissa into the sensor value. The simplest approach is
> > to just multiply the mantissa with the raw physical sensor value, which
> > will use more bits than the raw physical sensor value, depending on the
> > unit/LSB value (and on the split of the unit/LSB value into exponent and
> > mantissa).
> >
> > So I think the comment should at least make clear that the overflow may
> > also happen for physical sensors with less than 32 bit of resolution,
> > since it cannot be assumed that SCMI platforms will, without any
> > apparent need, restrict the values to 32 bits, when that would mean
> > additional complexity and potential loss of accuracy. (And in the long
> > term this driver could IMHO try to handle a greater value range by
> > adjusting the `scale' value accordingly.)
> >
> > Best regards,
> >
> > Peter
> >  
> > > +             if (max_range_high != 0)
> > > +                     return -EINVAL;
> > > +
> > > +             *val = max_range_low;
> > > +             *val2 = 1;
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > > +static void scmi_iio_get_sensor_resolution(struct iio_dev *iio_dev, int *val,
> > > +                                        int *val2)
> > > +{
> > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > +
> > > +     /*
> > > +      * All the axes are supposed to have the same value for resolution
> > > +      * and exponent. We are just using the values from the Axis 0 here.
> > > +      */
> > > +     if (sensor->sensor_info->axis[0].extended_attrs) {
> > > +             uint resolution = sensor->sensor_info->axis[0].resolution;
> > > +             s8 exponent = sensor->sensor_info->axis[0].exponent;
> > > +             s8 scale = sensor->sensor_info->axis[0].scale;
> > > +
> > > +             /*
> > > +              * To provide the raw value for the resolution to the userspace,
> > > +              * need to divide the resolution exponent by the sensor scale
> > > +              */
> > > +             exponent = exponent - scale;
> > > +             if (exponent >= 0) {
> > > +                     *val = resolution * int_pow(10, exponent);
> > > +                     *val2 = 1;
> > > +             } else {
> > > +                     *val = resolution;
> > > +                     *val2 = int_pow(10, abs(exponent));
> > > +             }
> > > +     }
> > > +}
> > > +
> > > +static int scmi_iio_get_sensor_min_range(struct iio_dev *iio_dev, int *val,
> > > +                                      int *val2)
> > > +{
> > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > +     int min_range_high, min_range_low;
> > > +     long long min_range;
> > > +
> > > +     /*
> > > +      * All the axes are supposed to have the same value for min range.
> > > +      * We are just using the values from the Axis 0 here.
> > > +      */
> > > +     if (sensor->sensor_info->axis[0].extended_attrs) {
> > > +             min_range = sensor->sensor_info->axis[0].attrs.min_range;
> > > +             min_range_high = H32(min_range);
> > > +             min_range_low = L32(min_range);
> > > +
> > > +             /*
> > > +              * As IIO Val types have no provision for 64 bit values,
> > > +              * and currently there are no known sensors using 64 bit
> > > +              * for the range, this driver only supports sensor with
> > > +              * 32 bit range value.
> > > +              */
> > > +             if (min_range_high != 0xFFFFFFFF)
> > > +                     return -EINVAL;
> > > +
> > > +             *val = min_range_low;
> > > +             *val2 = 1;
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > > +static int scmi_iio_set_sensor_range_avail(struct iio_dev *iio_dev)
> > > +{
> > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > +     int ret;
> > > +
> > > +     ret = scmi_iio_get_sensor_min_range(iio_dev, &sensor->range_avail[0],
> > > +                                         &sensor->range_avail[1]);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     scmi_iio_get_sensor_resolution(iio_dev, &sensor->range_avail[2],
> > > +                                    &sensor->range_avail[3]);
> > > +     ret = scmi_iio_get_sensor_max_range(iio_dev, &sensor->range_avail[4],
> > > +                                         &sensor->range_avail[5]);
> > > +     return ret;
> > > +}
> > > +
> > > +static int scmi_iio_set_sampling_freq_avail(struct iio_dev *iio_dev)
> > > +{
> > > +     u64 cur_interval_ns, low_interval_ns, high_interval_ns, step_size_ns,
> > > +             hz, uhz;
> > > +     unsigned int cur_interval, low_interval, high_interval, step_size;
> > > +     struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> > > +     int i;
> > > +
> > > +     sensor->freq_avail = devm_kzalloc(&iio_dev->dev,
> > > +                                       sizeof(u32) * (sensor->sensor_info->intervals.count * 2),
> > > +                                       GFP_KERNEL);
> > > +     if (!sensor->freq_avail)
> > > +             return -ENOMEM;
> > > +
> > > +     if (sensor->sensor_info->intervals.segmented) {
> > > +             low_interval = sensor->sensor_info->intervals
> > > +                                    .desc[SCMI_SENS_INTVL_SEGMENT_LOW];
> > > +             low_interval_ns = scmi_iio_convert_interval_to_ns(low_interval);
> > > +             convert_ns_to_freq(low_interval_ns, &hz, &uhz);
> > > +             sensor->freq_avail[0] = hz;
> > > +             sensor->freq_avail[1] = uhz;
> > > +
> > > +             step_size = sensor->sensor_info->intervals
> > > +                                 .desc[SCMI_SENS_INTVL_SEGMENT_STEP];
> > > +             step_size_ns = scmi_iio_convert_interval_to_ns(step_size);
> > > +             convert_ns_to_freq(step_size_ns, &hz, &uhz);
> > > +             sensor->freq_avail[2] = hz;
> > > +             sensor->freq_avail[3] = uhz;
> > > +
> > > +             high_interval = sensor->sensor_info->intervals
> > > +                                     .desc[SCMI_SENS_INTVL_SEGMENT_HIGH];
> > > +             high_interval_ns =
> > > +                     scmi_iio_convert_interval_to_ns(high_interval);
> > > +             convert_ns_to_freq(high_interval_ns, &hz, &uhz);
> > > +             sensor->freq_avail[4] = hz;
> > > +             sensor->freq_avail[5] = uhz;
> > > +     } else {
> > > +             for (i = 0; i < sensor->sensor_info->intervals.count; i++) {
> > > +                     cur_interval = sensor->sensor_info->intervals.desc[i];
> > > +                     cur_interval_ns = scmi_iio_convert_interval_to_ns(cur_interval);
> > > +                     convert_ns_to_freq(cur_interval_ns, &hz, &uhz);
> > > +                     sensor->freq_avail[i * 2] = hz;
> > > +                     sensor->freq_avail[i * 2 + 1] = uhz;
> > > +             }
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > > +static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
> > > +{
> > > +     struct iio_buffer *buffer;
> > > +
> > > +     buffer = devm_iio_kfifo_allocate(&scmi_iiodev->dev);
> > > +     if (!buffer)
> > > +             return -ENOMEM;
> > > +
> > > +     iio_device_attach_buffer(scmi_iiodev, buffer);
> > > +     scmi_iiodev->modes |= INDIO_BUFFER_SOFTWARE;
> > > +     scmi_iiodev->setup_ops = &scmi_iio_buffer_ops;
> > > +     return 0;
> > > +}
> > > +
> > > +static int scmi_alloc_iiodev(struct device *dev, struct scmi_handle *handle,
> > > +                          const struct scmi_sensor_info *sensor_info,
> > > +                          struct iio_dev **scmi_iio_dev)
> > > +{
> > > +     struct iio_chan_spec *iio_channels;
> > > +     struct scmi_iio_priv *sensor;
> > > +     enum iio_modifier modifier;
> > > +     enum iio_chan_type type;
> > > +     struct iio_dev *iiodev;
> > > +     int i, ret;
> > > +
> > > +     iiodev = devm_iio_device_alloc(dev, sizeof(*sensor));
> > > +     if (!iiodev)
> > > +             return -ENOMEM;
> > > +
> > > +     iiodev->modes = INDIO_DIRECT_MODE;
> > > +     iiodev->dev.parent = dev;
> > > +     sensor = iio_priv(iiodev);
> > > +     sensor->handle = handle;
> > > +     sensor->sensor_info = sensor_info;
> > > +     sensor->sensor_update_nb.notifier_call = scmi_iio_sensor_update_cb;
> > > +     sensor->indio_dev = iiodev;
> > > +
> > > +     /* adding one additional channel for timestamp */
> > > +     iiodev->num_channels = sensor_info->num_axis + 1;
> > > +     iiodev->name = sensor_info->name;
> > > +     iiodev->info = &scmi_iio_info;
> > > +
> > > +     iio_channels =
> > > +             devm_kzalloc(dev,
> > > +                          sizeof(*iio_channels) * (iiodev->num_channels),
> > > +                          GFP_KERNEL);
> > > +     if (!iio_channels)
> > > +             return -ENOMEM;
> > > +
> > > +     scmi_iio_set_sampling_freq_avail(iiodev);
> > > +
> > > +     ret = scmi_iio_set_sensor_range_avail(iiodev);
> > > +     if (ret) {
> > > +             dev_err(dev, "Error while setting the sensor %s range %d",
> > > +                     sensor_info->name, ret);
> > > +             return ret;
> > > +     }
> > > +
> > > +     for (i = 0; i < sensor_info->num_axis; i++) {
> > > +             ret = scmi_iio_get_chan_type(sensor_info->axis[i].type, &type);
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +
> > > +             ret = scmi_iio_get_chan_modifier(sensor_info->axis[i].name,
> > > +                                              &modifier);
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +
> > > +             scmi_iio_set_data_channel(&iio_channels[i], type, modifier,
> > > +                                       sensor_info->axis[i].id);
> > > +     }
> > > +
> > > +     scmi_iio_set_timestamp_channel(&iio_channels[i], i);
> > > +     iiodev->channels = iio_channels;
> > > +     *scmi_iio_dev = iiodev;
> > > +     return ret;
> > > +}
> > > +
> > > +static int scmi_iio_dev_probe(struct scmi_device *sdev)
> > > +{
> > > +     const struct scmi_sensor_info *sensor_info;
> > > +     struct scmi_handle *handle = sdev->handle;
> > > +     struct device *dev = &sdev->dev;
> > > +     struct iio_dev *scmi_iio_dev;
> > > +     u16 nr_sensors;
> > > +     int err, i;
> > > +
> > > +     if (!handle || !handle->sensor_ops || !handle->sensor_ops->count_get ||
> > > +         !handle->sensor_ops->info_get || !handle->sensor_ops->config_get ||
> > > +         !handle->sensor_ops->config_set) {
> > > +             dev_err(dev, "SCMI device has no sensor interface\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     nr_sensors = handle->sensor_ops->count_get(handle);
> > > +     if (!nr_sensors) {
> > > +             dev_dbg(dev, "0 sensors found via SCMI bus\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     dev_dbg(dev, "%d sensors found via SCMI bus\n", nr_sensors);
> > > +
> > > +     for (i = 0; i < nr_sensors; i++) {
> > > +             sensor_info = handle->sensor_ops->info_get(handle, i);
> > > +             if (!sensor_info) {
> > > +                     dev_err(dev, "SCMI sensor %d has missing info\n", i);
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > > +             /* Skipping scalar sensor,as this driver only supports accel and gyro */
> > > +             if (sensor_info->num_axis == 0)
> > > +                     continue;
> > > +
> > > +             err = scmi_alloc_iiodev(dev, handle, sensor_info,
> > > +                                     &scmi_iio_dev);
> > > +             if (err < 0) {
> > > +                     dev_err(dev,
> > > +                             "failed to allocate IIO device for sensor %s: %d\n",
> > > +                             sensor_info->name, err);
> > > +                     return err;
> > > +             }
> > > +
> > > +             err = scmi_iio_buffers_setup(scmi_iio_dev);
> > > +             if (err < 0) {
> > > +                     dev_err(dev,
> > > +                             "IIO buffer setup error at sensor %s: %d\n",
> > > +                             sensor_info->name, err);
> > > +                     return err;
> > > +             }
> > > +
> > > +             err = devm_iio_device_register(dev, scmi_iio_dev);
> > > +             if (err) {
> > > +                     dev_err(dev,
> > > +                             "IIO device registration failed at sensor %s: %d\n",
> > > +                             sensor_info->name, err);
> > > +                     return err;
> > > +             }
> > > +     }
> > > +     return err;
> > > +}
> > > +
> > > +static const struct scmi_device_id scmi_id_table[] = {
> > > +     { SCMI_PROTOCOL_SENSOR, "iiodev" },
> > > +     {},
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> > > +
> > > +static struct scmi_driver scmi_iiodev_driver = {
> > > +     .name = "scmi-sensor-iiodev",
> > > +     .probe = scmi_iio_dev_probe,
> > > +     .id_table = scmi_id_table,
> > > +};
> > > +
> > > +module_scmi_driver(scmi_iiodev_driver);
> > > +
> > > +MODULE_AUTHOR("Jyoti Bhayana <jbhayana@google.com>");
> > > +MODULE_DESCRIPTION("SCMI IIO Driver");
> > > +MODULE_LICENSE("GPL v2");
> > >  
> >
> >  


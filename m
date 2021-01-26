Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645663042C1
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 16:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390949AbhAZPhZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 10:37:25 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:60385 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392778AbhAZPgi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2021 10:36:38 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jan 2021 10:36:34 EST
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 52D6FA08D9;
        Tue, 26 Jan 2021 16:29:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=R+gpa3Ay4y5I
        ZHuKbf+9U2UwznxYRn3Trz5NmB6ah+4=; b=Emc+T3M3oHmDvE0xMZHKXdIWf5Mk
        QJvoZC6oE/u0zdqSP8xTJU714C02AEAVPVkEv7ssjve6hd+hu0xC0uZcbBDsYMv9
        BqFMEXNU6ILSTrzRrO755adE8Uy2sG6Efb6v8Y4fPqQFOOyXna5QZ8ivpP1UrD+0
        wNz4Bfha4gfuqx82UYw/Fl0qrxhFOf4GNHd/PPoGcoPOsqWsXPDg+VVZEMfztamg
        UDon3trEN4y548yQDWNe2Cg0tllp1QFJbwMd0whOmXntR1am9Fy8exUWoBZRPfkf
        xB+N/zfAFjRS8+FalUjO2BweGO3790m2fP5UCok5CPlg8pLJNddDixX0OQ==
Subject: Re: [RFC PATCH v3 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
To:     Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <cristian.marussi@arm.com>, <sudeep.holla@arm.com>,
        <egranata@google.com>, <mikhail.golubev@opensynergy.com>,
        <Igor.Skalkin@opensynergy.com>, <ankitarora@google.com>
References: <20210121232147.1849509-1-jbhayana@google.com>
 <20210121232147.1849509-2-jbhayana@google.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Autocrypt: addr=peter.hilber@opensynergy.com; prefer-encrypt=mutual; keydata=
 mQGNBFuyHTIBDAClsxKaykR7WINWbw2hd8SjAU5Ft7Vx2qOyRR3guringPRMDvc5sAQeDPP4
 lgFIZS5Ow3Z+0XMb/MtbJt0vQHg4Zi6WQtEysvctmAN4JG08XrO8Kf1Ly86Z0sJOrYTzd9oA
 JoNqk7/JufMre4NppAMUcJnB1zIDyhKkkGgM1znDvcW/pVkAIKZQ4Be3A9297tl7YjhVLkph
 kuw3yL8eyj7fk+3vruuEbMafYytozKCSBn5pM0wabiNUlPK39iQzcZd8VMIkh1BszRouInlc
 7hjiWjBjGDQ2eAbMww09ETAP1u38PpDolrO8IlTFb7Yy7OlD4lzr8AV+a2CTJhbKrCJznDQS
 +GPGwLtOqTP5S5OJ0DCqVHdQyKoZMe1sLaZSPLMLx1WYAGN5R8ftCZSBjilVpwJ3lFsqO5cj
 t5w1/JfNeVBWa4cENt5Z0B2gTuZ4F8j0QAc506uGxWO0wxH1rWNv2LuInSxj8d1yIUu76MqY
 p92TS3D4t/myerODX3xGnjkAEQEAAbQ7cGV0ZXIuaGlsYmVyQG9wZW5zeW5lcmd5LmNvbSA8
 cGV0ZXIuaGlsYmVyQG9wZW5zeW5lcmd5LmNvbT6JAc4EEwEIADgCGwMFCwkIBwIGFQoJCAsC
 BBYCAwECHgECF4AWIQTj5TCZN1jYfjl5iwQiPT9iQ46MNwUCXXd8PQAKCRAiPT9iQ46MN1PT
 C/4mgNGlWB1/vsStNH+TGfJKt3eTi1Oxn6Uo0y4sXzZg+CHXYXnrG2OdLgOa/ZdA+O/o1ofU
 v/nLKki7XH/cGsOtZ6n3Q5+irkLsUI9tcIlxLCZZlgDPqmJO3lu+8Uf2d96udw/5JLiPyhk/
 DLtKEnvIOnn2YU9LK80WuJk7CMK4ii/bIipS6WFV6s67YG8HrzMKEwIzScf/7dC/dN221wh0
 f3uUMht0A7eVOfEuC/i0//Y+ytuoPcqyT5YsAdvNk4Ns7dmWTJ8MS2t2m55BHQnYh7UBOIqB
 BkEWLOxbs2zZnC5b/yjg7FOhVxUmSP4wU1Tp/ye+MoVhiUXwzXps5JmOuKahLbIysIpeRNxf
 B8ndHEjKRl6YglPtqwJ45AF+BFEcblLe4eHk3Gl43jfoBJ43jFUSkge9K7wddB2FpaXrpfwM
 KupTSWeavVwnjDb+mXfqr4e7C4CX3VoyBQvoGGPpK/93cVZInu5zV/OAxSayXt6NqZECkMBu
 mg7W7hbcQey0K1BldGVyIEhpbGJlciA8cGV0ZXIuaGlsYmVyQG9wZW5zeW5lcmd5LmNvbT6J
 Ac4EEwEIADgWIQTj5TCZN1jYfjl5iwQiPT9iQ46MNwUCXjAOKgIbAwULCQgHAgYVCgkICwIE
 FgIDAQIeAQIXgAAKCRAiPT9iQ46MN6G+C/0R2UCwDr4XdHCjDETK+nGzwEADTkb/bVvnSP8U
 1XpoNuFoG0hpx/L9IOacxKCUwL5wGLQ2YjqfmWl5h5nwL/VmisSjtDBU/E9Te825J6avxyXm
 aSYehTMlBNgGq6gTgGZ2UywbTx51iPtbtqk5IWQSrJfhHgegyapOvDIe3W/L7WdWhpEUAOS2
 Rn1pW//rR1RZW0aCuQSi8eT+HKiFid84Kh9x858oNRc9W1bCGjmkFxyhJdxlF7SdwgFahJDm
 JHfdRyBcpp31WyofNodzNi/39gnrYbxyQmMSMU6Wi5Y9QIGubBB6BN+JlqL0WKgWfyye/6dp
 R6BrgRLUHBXFegWWLVvQGDli31kXBT0Aey9GQs2sEG3yoYHRAi9/dOip+rJgzqc+k6exP13g
 ZNBPc5SCrhWk9B/VrZ+frVBhqbu0hYlAnX39cB4szyOJVkGvXPJ6vsewQBv486kIY7IDC+Rk
 YtC1zNZKSIWSK1+bIXrIBA45rWb6SGq0CgMYdMvUGd25AY0EW7IdMwEMANZOEgW7gpZr0l4M
 HVvEZomKRgHmKghiKffCyR/cZdB5CWPEsyD0QMkQCQHg0FUQIB/SyS7hV/MOYL47Zb+QUlBo
 sMGkyyseEBWx0UgxgdMOh88JxAEHs0gQFYjL13DFLX/JfPyUqEnmWHLmvPpwPy2Qp7M1PPYb
 /KT8YxQEcJ0agxiSSGC+0c6efziPLW1uvGnQpBXhbLRdmUVS9JE390vQLCjIQWQP34e6MnKr
 ylqPpOeaiVSC9Nvr44f7LDk0X3Hsg3b4kV9TInGcbskXCB9QnKo6lVgXI9Q419WZtI9T/d8n
 5Wx54P+iaw4pISqDHi6v+U9YhHACInqJm8S4WhlRIXhXmDVXBjyPvMkxEYp9EGxT5yeu49fN
 5oB1SQCf819obhO7GfP2pUx8H3dy96TvKFEQmuh15iXYCxgltrvy9TjUIHj9SbKiaXW1O45t
 jlDohZJofA0AZ1gU0X8ZVXwqn3vEmrMLDBiko3gdBy7mx2vl+Z1LJyqYKBBvw+pi7wARAQAB
 iQG2BBgBCAAgAhsMFiEE4+UwmTdY2H45eYsEIj0/YkOOjDcFAl13fD0ACgkQIj0/YkOOjDfF
 hwv9F6qVRBlMFPmb3dWIs+QcbdgUW9ViGOHNyjCnr+UBE5jc0ERP3IOzcgqavcL5YpuWadfP
 n4/LyMDhVcl5SQGIdk5oZlRWQRiSpqS+IIU8idu+Ogl/Hdsp4n9S8GiINNwNh5KzWoCNN0Pp
 crjuMTacJnZur9/ym9tjr+mMvW7Z0k52lnS9L+CRHLKHpVJSnccpTpShQHa335c5YvRC8NN+
 Ygj1uZL/98+1GmP1WMZ6nc1LSFDUxR60cxnlbgH7cwBuy8y5DBeCCYiPHKBglVIp5nUFZdLG
 /HmufQT3f4/GVoDEo2Q7H0lq3KULX1xEwHFeXHw4NXR7mYeX/eftz/9GFMVU29c72NTw8Uih
 Oy9qJgNo19wroRYKHLz1eWtMVcqS3hbXm0/QcrG9+C9qCPXVxpC/L0YLAtmdvEIyaFtXWRyW
 7UQ3us6klHh4XUvSpsQhOgzLHFJ1LpfcupeBYECJQdxgIYyhgFAwRHeLGIPxjlvUmk22C0ua
 lbekkuPTQs/m
Message-ID: <f6570855-6660-01c6-c46b-915d3253e3b3@opensynergy.com>
Date:   Tue, 26 Jan 2021 16:29:26 +0100
MIME-Version: 1.0
In-Reply-To: <20210121232147.1849509-2-jbhayana@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 22.01.21 00:21, Jyoti Bhayana wrote:

<snip>

> +
> +static int scmi_iio_get_sensor_max_range(struct iio_dev *iio_dev, int *val,
> +					 int *val2)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	int max_range_high, max_range_low;
> +	long long max_range;
> +
> +	/*
> +	 * All the axes are supposed to have the same value for max range.
> +	 * We are just using the values from the Axis 0 here.
> +	 */
> +	if (sensor->sensor_info->axis[0].extended_attrs) {
> +		max_range = sensor->sensor_info->axis[0].attrs.max_range;
> +		max_range_high = H32(max_range);
> +		max_range_low = L32(max_range);
> +
> +		/*
> +		 * As IIO Val types have no provision for 64 bit values,
> +		 * and currently there are no known sensors using 64 bit
> +		 * for the range, this driver only supports sensor with
> +		 * 32 bit range value.
> +		 */
This comment and the corresponding one in
scmi_iio_get_sensor_min_range() seem to be misleading to me. The extrema
will probably exceed 32 bits even for physical sensors which do have
less than 32 bits of resolution. The reason is that the SCMI sensor
management protocol does not transmit a `scale' value as used by IIO.
Instead, SCMI transmits an exponent with base ten.

So, an SCMI sensor with a unit/LSB value which is not a power of ten
will have its unit/LSB value split into an exponent (with base ten) and
a mantissa.

The SCMI platform (which exposes the physical sensor) will have to
incorporate the mantissa into the sensor value. The simplest approach is
to just multiply the mantissa with the raw physical sensor value, which
will use more bits than the raw physical sensor value, depending on the
unit/LSB value (and on the split of the unit/LSB value into exponent and
mantissa).

So I think the comment should at least make clear that the overflow may
also happen for physical sensors with less than 32 bit of resolution,
since it cannot be assumed that SCMI platforms will, without any
apparent need, restrict the values to 32 bits, when that would mean
additional complexity and potential loss of accuracy. (And in the long
term this driver could IMHO try to handle a greater value range by
adjusting the `scale' value accordingly.)

Best regards,

Peter

> +		if (max_range_high != 0)
> +			return -EINVAL;
> +
> +		*val = max_range_low;
> +		*val2 = 1;
> +	}
> +	return 0;
> +}
> +
> +static void scmi_iio_get_sensor_resolution(struct iio_dev *iio_dev, int *val,
> +					   int *val2)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +
> +	/*
> +	 * All the axes are supposed to have the same value for resolution
> +	 * and exponent. We are just using the values from the Axis 0 here.
> +	 */
> +	if (sensor->sensor_info->axis[0].extended_attrs) {
> +		uint resolution = sensor->sensor_info->axis[0].resolution;
> +		s8 exponent = sensor->sensor_info->axis[0].exponent;
> +		s8 scale = sensor->sensor_info->axis[0].scale;
> +
> +		/*
> +		 * To provide the raw value for the resolution to the userspace,
> +		 * need to divide the resolution exponent by the sensor scale
> +		 */
> +		exponent = exponent - scale;
> +		if (exponent >= 0) {
> +			*val = resolution * int_pow(10, exponent);
> +			*val2 = 1;
> +		} else {
> +			*val = resolution;
> +			*val2 = int_pow(10, abs(exponent));
> +		}
> +	}
> +}
> +
> +static int scmi_iio_get_sensor_min_range(struct iio_dev *iio_dev, int *val,
> +					 int *val2)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	int min_range_high, min_range_low;
> +	long long min_range;
> +
> +	/*
> +	 * All the axes are supposed to have the same value for min range.
> +	 * We are just using the values from the Axis 0 here.
> +	 */
> +	if (sensor->sensor_info->axis[0].extended_attrs) {
> +		min_range = sensor->sensor_info->axis[0].attrs.min_range;
> +		min_range_high = H32(min_range);
> +		min_range_low = L32(min_range);
> +
> +		/*
> +		 * As IIO Val types have no provision for 64 bit values,
> +		 * and currently there are no known sensors using 64 bit
> +		 * for the range, this driver only supports sensor with
> +		 * 32 bit range value.
> +		 */
> +		if (min_range_high != 0xFFFFFFFF)
> +			return -EINVAL;
> +
> +		*val = min_range_low;
> +		*val2 = 1;
> +	}
> +	return 0;
> +}
> +
> +static int scmi_iio_set_sensor_range_avail(struct iio_dev *iio_dev)
> +{
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	int ret;
> +
> +	ret = scmi_iio_get_sensor_min_range(iio_dev, &sensor->range_avail[0],
> +					    &sensor->range_avail[1]);
> +	if (ret)
> +		return ret;
> +
> +	scmi_iio_get_sensor_resolution(iio_dev, &sensor->range_avail[2],
> +				       &sensor->range_avail[3]);
> +	ret = scmi_iio_get_sensor_max_range(iio_dev, &sensor->range_avail[4],
> +					    &sensor->range_avail[5]);
> +	return ret;
> +}
> +
> +static int scmi_iio_set_sampling_freq_avail(struct iio_dev *iio_dev)
> +{
> +	u64 cur_interval_ns, low_interval_ns, high_interval_ns, step_size_ns,
> +		hz, uhz;
> +	unsigned int cur_interval, low_interval, high_interval, step_size;
> +	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
> +	int i;
> +
> +	sensor->freq_avail = devm_kzalloc(&iio_dev->dev,
> +					  sizeof(u32) * (sensor->sensor_info->intervals.count * 2),
> +					  GFP_KERNEL);
> +	if (!sensor->freq_avail)
> +		return -ENOMEM;
> +
> +	if (sensor->sensor_info->intervals.segmented) {
> +		low_interval = sensor->sensor_info->intervals
> +				       .desc[SCMI_SENS_INTVL_SEGMENT_LOW];
> +		low_interval_ns = scmi_iio_convert_interval_to_ns(low_interval);
> +		convert_ns_to_freq(low_interval_ns, &hz, &uhz);
> +		sensor->freq_avail[0] = hz;
> +		sensor->freq_avail[1] = uhz;
> +
> +		step_size = sensor->sensor_info->intervals
> +				    .desc[SCMI_SENS_INTVL_SEGMENT_STEP];
> +		step_size_ns = scmi_iio_convert_interval_to_ns(step_size);
> +		convert_ns_to_freq(step_size_ns, &hz, &uhz);
> +		sensor->freq_avail[2] = hz;
> +		sensor->freq_avail[3] = uhz;
> +
> +		high_interval = sensor->sensor_info->intervals
> +					.desc[SCMI_SENS_INTVL_SEGMENT_HIGH];
> +		high_interval_ns =
> +			scmi_iio_convert_interval_to_ns(high_interval);
> +		convert_ns_to_freq(high_interval_ns, &hz, &uhz);
> +		sensor->freq_avail[4] = hz;
> +		sensor->freq_avail[5] = uhz;
> +	} else {
> +		for (i = 0; i < sensor->sensor_info->intervals.count; i++) {
> +			cur_interval = sensor->sensor_info->intervals.desc[i];
> +			cur_interval_ns = scmi_iio_convert_interval_to_ns(cur_interval);
> +			convert_ns_to_freq(cur_interval_ns, &hz, &uhz);
> +			sensor->freq_avail[i * 2] = hz;
> +			sensor->freq_avail[i * 2 + 1] = uhz;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
> +{
> +	struct iio_buffer *buffer;
> +
> +	buffer = devm_iio_kfifo_allocate(&scmi_iiodev->dev);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	iio_device_attach_buffer(scmi_iiodev, buffer);
> +	scmi_iiodev->modes |= INDIO_BUFFER_SOFTWARE;
> +	scmi_iiodev->setup_ops = &scmi_iio_buffer_ops;
> +	return 0;
> +}
> +
> +static int scmi_alloc_iiodev(struct device *dev, struct scmi_handle *handle,
> +			     const struct scmi_sensor_info *sensor_info,
> +			     struct iio_dev **scmi_iio_dev)
> +{
> +	struct iio_chan_spec *iio_channels;
> +	struct scmi_iio_priv *sensor;
> +	enum iio_modifier modifier;
> +	enum iio_chan_type type;
> +	struct iio_dev *iiodev;
> +	int i, ret;
> +
> +	iiodev = devm_iio_device_alloc(dev, sizeof(*sensor));
> +	if (!iiodev)
> +		return -ENOMEM;
> +
> +	iiodev->modes = INDIO_DIRECT_MODE;
> +	iiodev->dev.parent = dev;
> +	sensor = iio_priv(iiodev);
> +	sensor->handle = handle;
> +	sensor->sensor_info = sensor_info;
> +	sensor->sensor_update_nb.notifier_call = scmi_iio_sensor_update_cb;
> +	sensor->indio_dev = iiodev;
> +
> +	/* adding one additional channel for timestamp */
> +	iiodev->num_channels = sensor_info->num_axis + 1;
> +	iiodev->name = sensor_info->name;
> +	iiodev->info = &scmi_iio_info;
> +
> +	iio_channels =
> +		devm_kzalloc(dev,
> +			     sizeof(*iio_channels) * (iiodev->num_channels),
> +			     GFP_KERNEL);
> +	if (!iio_channels)
> +		return -ENOMEM;
> +
> +	scmi_iio_set_sampling_freq_avail(iiodev);
> +
> +	ret = scmi_iio_set_sensor_range_avail(iiodev);
> +	if (ret) {
> +		dev_err(dev, "Error while setting the sensor %s range %d",
> +			sensor_info->name, ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < sensor_info->num_axis; i++) {
> +		ret = scmi_iio_get_chan_type(sensor_info->axis[i].type, &type);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = scmi_iio_get_chan_modifier(sensor_info->axis[i].name,
> +						 &modifier);
> +		if (ret < 0)
> +			return ret;
> +
> +		scmi_iio_set_data_channel(&iio_channels[i], type, modifier,
> +					  sensor_info->axis[i].id);
> +	}
> +
> +	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
> +	iiodev->channels = iio_channels;
> +	*scmi_iio_dev = iiodev;
> +	return ret;
> +}
> +
> +static int scmi_iio_dev_probe(struct scmi_device *sdev)
> +{
> +	const struct scmi_sensor_info *sensor_info;
> +	struct scmi_handle *handle = sdev->handle;
> +	struct device *dev = &sdev->dev;
> +	struct iio_dev *scmi_iio_dev;
> +	u16 nr_sensors;
> +	int err, i;
> +
> +	if (!handle || !handle->sensor_ops || !handle->sensor_ops->count_get ||
> +	    !handle->sensor_ops->info_get || !handle->sensor_ops->config_get ||
> +	    !handle->sensor_ops->config_set) {
> +		dev_err(dev, "SCMI device has no sensor interface\n");
> +		return -EINVAL;
> +	}
> +
> +	nr_sensors = handle->sensor_ops->count_get(handle);
> +	if (!nr_sensors) {
> +		dev_dbg(dev, "0 sensors found via SCMI bus\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "%d sensors found via SCMI bus\n", nr_sensors);
> +
> +	for (i = 0; i < nr_sensors; i++) {
> +		sensor_info = handle->sensor_ops->info_get(handle, i);
> +		if (!sensor_info) {
> +			dev_err(dev, "SCMI sensor %d has missing info\n", i);
> +			return -EINVAL;
> +		}
> +
> +		/* Skipping scalar sensor,as this driver only supports accel and gyro */
> +		if (sensor_info->num_axis == 0)
> +			continue;
> +
> +		err = scmi_alloc_iiodev(dev, handle, sensor_info,
> +					&scmi_iio_dev);
> +		if (err < 0) {
> +			dev_err(dev,
> +				"failed to allocate IIO device for sensor %s: %d\n",
> +				sensor_info->name, err);
> +			return err;
> +		}
> +
> +		err = scmi_iio_buffers_setup(scmi_iio_dev);
> +		if (err < 0) {
> +			dev_err(dev,
> +				"IIO buffer setup error at sensor %s: %d\n",
> +				sensor_info->name, err);
> +			return err;
> +		}
> +
> +		err = devm_iio_device_register(dev, scmi_iio_dev);
> +		if (err) {
> +			dev_err(dev,
> +				"IIO device registration failed at sensor %s: %d\n",
> +				sensor_info->name, err);
> +			return err;
> +		}
> +	}
> +	return err;
> +}
> +
> +static const struct scmi_device_id scmi_id_table[] = {
> +	{ SCMI_PROTOCOL_SENSOR, "iiodev" },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> +
> +static struct scmi_driver scmi_iiodev_driver = {
> +	.name = "scmi-sensor-iiodev",
> +	.probe = scmi_iio_dev_probe,
> +	.id_table = scmi_id_table,
> +};
> +
> +module_scmi_driver(scmi_iiodev_driver);
> +
> +MODULE_AUTHOR("Jyoti Bhayana <jbhayana@google.com>");
> +MODULE_DESCRIPTION("SCMI IIO Driver");
> +MODULE_LICENSE("GPL v2");
> 



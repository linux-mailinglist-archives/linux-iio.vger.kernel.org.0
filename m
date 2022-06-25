Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7624655A9FB
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jun 2022 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiFYMdt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jun 2022 08:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiFYMdr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 08:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B035A1F2F2
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656160423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7r45OBtcSvV8alCxjvUuc4IXaLxOYe/Rqvpzaxy4hcc=;
        b=YkfgNnkrAsZEo6Ksq9GYMhW+OB63bgEtDfGZpCjhry+xjzOrx3mjf3I4zhlqik1m3dRDmV
        Ha1OgkrTEUkW7S++sUCJvPKYSLsne/8GlElMb+2e+Z1uXkBhSGkqecnhgz4DxW5gSW6j5Z
        RHrlc77RVXUjjhq7JVH0Rpo36bekzXQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-4HJ0AoK6ODi_xF4tHaKnOQ-1; Sat, 25 Jun 2022 08:33:42 -0400
X-MC-Unique: 4HJ0AoK6ODi_xF4tHaKnOQ-1
Received: by mail-ej1-f70.google.com with SMTP id kv9-20020a17090778c900b007262b461ecdso1456360ejc.6
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 05:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7r45OBtcSvV8alCxjvUuc4IXaLxOYe/Rqvpzaxy4hcc=;
        b=jForinilijIv2DS78immhXzu93RfTJIJtrbsnehIZTTj116SIW0IB3MJyGCYGBsQo8
         16ieykz1WSqr2DUrZtQjT/Y2RZkWVAcWoW/hJLQwQfgO9BxSMJwERSs9WZm5fF0JzJYI
         aKjvnKPRBy5CaARJuNrW4eUzS7ZdHLN7uJAAfrHVbjuovdWJWnfzJorerVH+WQpIZwvR
         mnW2TSlSewaf44+cuFIngPj2GhYd/cgHmOAibth1R5arO0y0CFKaKiYW2zM5Vb0rzBmb
         2tyQXaXC4F6JFQgK+c0QiNozNntQ53vTVCYGAHcx2Izvr2IFC/ZNoRCz14HbJXmVRgOu
         ntng==
X-Gm-Message-State: AJIora+t8WXy+IhrgRMKOjO+EhMqNWJ71YPvvQ+dpGvHWooTRVck9SNM
        rKb3RkS6rSrlB3lNjFLEZxwfd2l1vuFfpcxOr3VdfLd3F4bzHmCnFCcqaI+mMaMaG/X6LstjFrz
        aip1IaGNZaZgLWzPW51fL
X-Received: by 2002:a05:6402:2402:b0:435:3418:61b5 with SMTP id t2-20020a056402240200b00435341861b5mr4690395eda.82.1656160420500;
        Sat, 25 Jun 2022 05:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tyAeA123QaSPoLE1BBDFcR10xU3ZA9e7WNHr81vpNMgW73gETM60tOpWfcd77CZHv/gB4lcA==
X-Received: by 2002:a05:6402:2402:b0:435:3418:61b5 with SMTP id t2-20020a056402240200b00435341861b5mr4690376eda.82.1656160420220;
        Sat, 25 Jun 2022 05:33:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709064e4600b007121b22b376sm2532874ejw.105.2022.06.25.05.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 05:33:39 -0700 (PDT)
Message-ID: <937c3317-91f7-9236-70a8-39ca4c2f6396@redhat.com>
Date:   Sat, 25 Jun 2022 14:33:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] iio/hid: Add mount_matrix
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        wpsmith@google.com, linux-iio@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
References: <20220624223341.2625231-1-gwendal@chromium.org>
 <20220625120937.24c51ca4@jic23-huawei>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220625120937.24c51ca4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Jonathan, thanks for Cc-ing me on this.

On 6/25/22 13:09, Jonathan Cameron wrote:
> On Fri, 24 Jun 2022 15:33:41 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
> 
>> ISH based sensors do not naturally return data in the W3C 'natural'
>> orientation.
>> They returns all data inverted, to match Microsoft Windows requirement:
>> [https://docs.microsoft.com/en-us/windows/uwp/devices-sensors/sensors#accelerometer]
>> """ If the device has the SimpleOrientation of FaceUp on a table, then
>> the accelerometer would read -1 G on the Z axis. """
> 
> Probably reference the HID Usage Tables 1.3 spec rather than the MS one.
> https://usb.org/sites/default/files/hut1_3_0.pdf
> After some waving around of my left and right hand I'm fairly sure that says the same
> thing as the MS spec. Section 4.4 Vector Usages 
> 
>> While W3C defines [https://www.w3.org/TR/motion-sensors/#accelerometer-sensor]
>> """The Accelerometer sensor is an inertial-frame sensor, this means that
>> when the device is in free fall, the acceleration is 0 m/s2 in the
>> falling direction, and when a device is laying flat on a table, the
>> acceleration in upwards direction will be equal to the Earth gravity,
>> i.e. g ≡ 9.8 m/s2 as it is measuring the force of the table pushing the
>> device upwards."""
>>
>> Fixes all HID sensors that defines IIO_MOD_[XYZ] attributes.
>>
>> Tested on "HP Spectre x360 Convertible 13" and "Dell XPS 13 9365".
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> 
> Ah.  Whilst this is a fix, it seems likely to break a whole bunch of existing
> users that are compensating for the wrong orientation in userspace.  Also, do
> we know how universal this is?  I have a nasty feeling it'll turn out some
> HID sensors do it the other way whatever the spec says.  Bastien, are you
> carrying a local fix for this in your userspace code?
> 
> +CC a few people who are likely to know more on just how bad that will be...

Right, so Linux userspace expects an axis system similar to the Android one,
which is actually the one which seems to be described here.

The axis system expect is that when a tablet is layed flat on the table,
the x and y axis are as one would expect when drawing a mathematics
graph on the surface of the tablet.

So X-axis goes from left to right, with left side being lower numbers and
right side higher numbers.

And Y-axis goes from bottom to top, with the bottom being lower numbers and
the top higher numbers.

That leaves the Z-axis which comes out of the screen at a 90° angle (to both
the X and Y axis) and the vector coming out of the screen towards to the user /
observer of the screen indicates positive numbers where as imagining the same
axis pointing down through the table on which the tables is lying towards
the floor represents negative numbers.

This means that the accel values of a tablet resting on a table, expresses
in units of 1G are: [ 0, 0, -1 ] and I've seen quite a few HID sensors
with accel reporting on various devices and they all adhere to this
without applying any accel matrix. Or in other words, HID sensors behave
as expected by userspace when applying the norm matrix of:

	.rotation = {
		"1", "0", "0",
		"0", "1", "0",
		"0", "0", "1"

And this patch will cause the image to be upside down (no matter what the
rotation) when using auto-rotation with iio-sensor-proxy.

So big NACK from me for this patch.

I'm not sure what this patch is trying to fix but it looks to me like it
is a bug in the HID sensors implementation of the specific device.

Again HID-sensors already work fine on tons of existing devices without
any matrix getting applied.

Merging this patch would break existing userspace on tons of devices!

Regards,

Hans





> 
> One other thing inline.  The mount matrix you've provided isn't a rotation matrix.
> 
> I'd forgotten the annoyance of graphics folks using the right handed sensor
> axis whilst nearly all other uses are left handed. It drove me mad many years
> ago - every code base that used sensors and rendered the result needed a
> flip of the z axis - it was never well documented, so half the time
> the code ended up with many axis flips based on people debugging local
> orientation problems.  *sigh*
> 
> 
>> ---
>>  drivers/iio/accel/hid-sensor-accel-3d.c       |  3 +++
>>  .../hid-sensors/hid-sensor-attributes.c       | 21 +++++++++++++++++++
>>  drivers/iio/gyro/hid-sensor-gyro-3d.c         |  3 +++
>>  drivers/iio/magnetometer/hid-sensor-magn-3d.c |  3 +++
>>  include/linux/hid-sensor-hub.h                |  2 ++
>>  5 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
>> index a2def6f9380a3..980bbd7fba502 100644
>> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
>> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
>> @@ -59,6 +59,7 @@ static const struct iio_chan_spec accel_3d_channels[] = {
>>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>>  		.scan_index = CHANNEL_SCAN_INDEX_X,
>> +		.ext_info = hid_sensor_ext_info,
>>  	}, {
>>  		.type = IIO_ACCEL,
>>  		.modified = 1,
>> @@ -69,6 +70,7 @@ static const struct iio_chan_spec accel_3d_channels[] = {
>>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>>  		.scan_index = CHANNEL_SCAN_INDEX_Y,
>> +		.ext_info = hid_sensor_ext_info,
>>  	}, {
>>  		.type = IIO_ACCEL,
>>  		.modified = 1,
>> @@ -79,6 +81,7 @@ static const struct iio_chan_spec accel_3d_channels[] = {
>>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>>  		.scan_index = CHANNEL_SCAN_INDEX_Z,
>> +		.ext_info = hid_sensor_ext_info,
>>  	},
>>  	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
>>  };
>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> index 9b279937a24e0..e367e4b482ef0 100644
>> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>> @@ -585,6 +585,27 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>>  }
>>  EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, IIO_HID);
>>  
>> +static const struct iio_mount_matrix hid_sensor_windows_axis = {
>> +	.rotation = {
>> +		"-1", "0", "0",
>> +		"0", "-1", "0",
>> +		"0", "0", "-1"
> 
> Unless my memory of rotation matrices serves me wrong, that's not a rotation matrix.
> (det(R) != 1)
> 
> That's a an axis flip from a right handed set of axis to a left handed one.
> So to fix this up, you would need to invert the raw readings of at least one axis
> rather than rely on the mount matrix or make the scale negative.
> 
> Jonathan
> 
> 
>> +	}
>> +};
>> +
>> +static const struct iio_mount_matrix *
>> +hid_sensor_get_mount_matrix(const struct iio_dev *indio_dev,
>> +				const struct iio_chan_spec *chan)
>> +{
>> +	return &hid_sensor_windows_axis;
>> +}
>> +
>> +const struct iio_chan_spec_ext_info hid_sensor_ext_info[] = {
>> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, hid_sensor_get_mount_matrix),
>> +	{ }
>> +};
>> +EXPORT_SYMBOL(hid_sensor_ext_info);
>> +
>>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
>>  MODULE_DESCRIPTION("HID Sensor common attribute processing");
>>  MODULE_LICENSE("GPL");
>> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
>> index 8f0ad022c7f1b..b852f5166bb21 100644
>> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
>> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
>> @@ -58,6 +58,7 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
>>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>>  		.scan_index = CHANNEL_SCAN_INDEX_X,
>> +		.ext_info = hid_sensor_ext_info,
>>  	}, {
>>  		.type = IIO_ANGL_VEL,
>>  		.modified = 1,
>> @@ -68,6 +69,7 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
>>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>>  		.scan_index = CHANNEL_SCAN_INDEX_Y,
>> +		.ext_info = hid_sensor_ext_info,
>>  	}, {
>>  		.type = IIO_ANGL_VEL,
>>  		.modified = 1,
>> @@ -78,6 +80,7 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
>>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>>  		.scan_index = CHANNEL_SCAN_INDEX_Z,
>> +		.ext_info = hid_sensor_ext_info,
>>  	},
>>  	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
>>  };
>> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
>> index e85a3a8eea908..aefbdb9b0869a 100644
>> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
>> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
>> @@ -74,6 +74,7 @@ static const struct iio_chan_spec magn_3d_channels[] = {
>>  		BIT(IIO_CHAN_INFO_SCALE) |
>>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>> +		.ext_info = hid_sensor_ext_info,
>>  	}, {
>>  		.type = IIO_MAGN,
>>  		.modified = 1,
>> @@ -83,6 +84,7 @@ static const struct iio_chan_spec magn_3d_channels[] = {
>>  		BIT(IIO_CHAN_INFO_SCALE) |
>>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>> +		.ext_info = hid_sensor_ext_info,
>>  	}, {
>>  		.type = IIO_MAGN,
>>  		.modified = 1,
>> @@ -92,6 +94,7 @@ static const struct iio_chan_spec magn_3d_channels[] = {
>>  		BIT(IIO_CHAN_INFO_SCALE) |
>>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
>> +		.ext_info = hid_sensor_ext_info,
>>  	}, {
>>  		.type = IIO_ROT,
>>  		.modified = 1,
>> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
>> index c27329e2a5ad5..ee7d5b430a785 100644
>> --- a/include/linux/hid-sensor-hub.h
>> +++ b/include/linux/hid-sensor-hub.h
>> @@ -236,6 +236,8 @@ struct hid_sensor_common {
>>  	struct work_struct work;
>>  };
>>  
>> +extern const struct iio_chan_spec_ext_info hid_sensor_ext_info[];
>> +
>>  /* Convert from hid unit expo to regular exponent */
>>  static inline int hid_sensor_convert_exponent(int unit_expo)
>>  {
> 


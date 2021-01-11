Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6C2F1259
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jan 2021 13:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbhAKMfA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 11 Jan 2021 07:35:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2303 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbhAKMe7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2021 07:34:59 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DDtNn4cw6z67WP5;
        Mon, 11 Jan 2021 20:31:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 11 Jan 2021 13:34:17 +0100
Received: from localhost (10.47.69.27) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 11 Jan
 2021 12:34:16 +0000
Date:   Mon, 11 Jan 2021 12:33:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jyoti Bhayana <jbhayana@google.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Enrico Granata <egranata@google.com>,
        Mikhail Golubev <mikhail.golubev@opensynergy.com>,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>,
        Peter Hilber <Peter.hilber@opensynergy.com>,
        Ankit Arora <ankitarora@google.com>
Subject: Re: Reply to [RFC PATCH v2 0/1] Adding support for IIO SCMI based
 sensors
Message-ID: <20210111123338.00007c06@Huawei.com>
In-Reply-To: <CA+=V6c3f5Z4_JOr+KzvxpL9nOcPrNAZYmG_VpUF+QAW4=cfy=Q@mail.gmail.com>
References: <20210106161233.GA44413@e120937-lin>
        <20210106212353.951807-1-jbhayana@google.com>
        <20210109190133.61051fab@archlinux>
        <CA+=V6c3f5Z4_JOr+KzvxpL9nOcPrNAZYmG_VpUF+QAW4=cfy=Q@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.69.27]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 10 Jan 2021 22:44:44 -0800
Jyoti Bhayana <jbhayana@google.com> wrote:

> Hi Jonathan,
> 
> In section 4.7.2.5.1 of the specification, the following exponent is
> the scale value
> 
> uint32 axis_attributes_high
> Bits[15:11] Exponent: The power-of-10 multiplier in two’s-complement
> format that is applied to the sensor unit
> specified by the SensorType field.
> 
> and the resolution is
> 
> uint32 axis_resolution
> Bits[31:27] Exponent: The power-of-10 multiplier in two’s-complement format
> that is applied to the Res field. Bits[26:0] Res: The resolution of
> the sensor axis.
> 
> From code in scmi_protocol.h
> /**
>  * scmi_sensor_axis_info  - describes one sensor axes
>  * @id: The axes ID.
>  * @type: Axes type. Chosen amongst one of @enum scmi_sensor_class.
>  * @scale: Power-of-10 multiplier applied to the axis unit.
>  * @name: NULL-terminated string representing axes name as advertised by
>  *  SCMI platform.
>  * @extended_attrs: Flag to indicate the presence of additional extended
>  *    attributes for this axes.
>  * @resolution: Extended attribute representing the resolution of the axes.
>  * Set to 0 if not reported by this axes.
>  * @exponent: Extended attribute representing the power-of-10 multiplier that
>  *      is applied to the resolution field. Set to 0 if not reported by
>  *      this axes.
>  * @attrs: Extended attributes representing minimum and maximum values
>  *   measurable by this axes. Set to 0 if not reported by this sensor.
>  */
> 
> struct scmi_sensor_axis_info {
> unsigned int id;
> unsigned int type;
> int scale; //This is the scale used for min/max range
> char name[SCMI_MAX_STR_SIZE];
> bool extended_attrs;
> unsigned int resolution;
> int exponent; // This is the scale used in resolution
> struct scmi_range_attrs attrs;
> };
> 
> The scale above  is the Power-of-10 multiplier which is applied to the min range
> and the max range value
> but the resolution is equal to resolution and multiplied by
> Power-of-10 multiplier
> of exponent in the above struct.
> So as can be seen above the value of the power of 10 multiplier used
> for min/max range
> can be different than the value of the power of 10 multiplier used for
> the resolution.
> Hence, if I have to use IIO_AVAIL_RANGE to specify min/max range and as well
> as resolution, then I have to use the float format with the scale applied.
> 
> If there is another way which you know of and prefer, please let me know.
I'll confess I've gotten a bit lost here.

So I think where we are is how to describe the range of the sensor and why we can't
use in_accel_x_raw_available to provide the 

Understood that the resolution can have different scaling.  That is presumably
to allow for the case where a device is reporting values at a finer scale than
it's real resolution.  Resolution might take into account expected noise for
example.  So it should be decoupled from the scaling of both the actual measurements
and the axis high / low limits.

However, I'd read that as saying the axis high / low limits and the actual sensor
readings should be scaled by the exponent in axis_attributes_high.
So I think we are fine for the range, but my earlier assumption that resolution
was equivalent to scale in IIO (real world value for 1LSB) may be completely wrong
as resolution may be unconnected to how you convert to a real world value?

If nothing else I'd like to suggest the spec needs to be tightened a bit here
to say exactly how we convert a value coming in to real world units (maybe
I'm just missing it).

Anyhow, I suspect we've been looking at this the wrong way and what we actually
need is non standard ABI for resolution.

Jonathan




> 
> Thanks,
> Jyoti
> 
> 
> 
> 
> Thanks,
> Jyoti
> 
> On Sat, Jan 9, 2021 at 11:01 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Wed,  6 Jan 2021 21:23:53 +0000
> > Jyoti Bhayana <jbhayana@google.com> wrote:
> >  
> > > Hi Jonathan,
> > >
> > > Instead of adding IIO_VAL_INT_H32_L32, I am thinking of adding IIO_VAL_FRACTIONAL_LONG
> > > or IIO_VAL_FRACTIONAL_64 as the scale/exponent used for min/max range can be different
> > > than the one used in resolution according to specification.  
> >
> > That's somewhat 'odd'.  Given min/max are inherently values the sensor is supposed to
> > be able to return why give them different resolutions?  Can you point me at a specific
> > section of the spec?  The axis_min_range_low etc fields don't seem to have units specified
> > but I assumed they were in sensor units and so same scale factors?
> >  
> > >
> > > I am planning to use read_avail for IIO_CHAN_INFO_PROCESSED using IIO_AVAIL_RANGE
> > > and this new IIO_VAL_FRACTIONAL_64 for min range,max range and resolution.
> > > Instead of two values used in IIO_VAL_FRACTIONAL, IIO_VAL_FRACTIONAL_64 will use 4 values
> > > val_high,val_low,and val2_high and val2_low.  
> >
> > I'm not keen on the changing that internal kernel interface unless we absolutely
> > have to.  read_avail() is called from consumer drivers and they won't know anything
> > about this new variant.
> >  
> > >
> > > Let me know if that is an acceptable solution.  
> >
> > Hmm. It isn't a standard use of the ABI given the value in the buffer is (I assume)
> > raw (needs scale applied).  However, it isn't excluded by the ABI docs.  Whether
> > a standard userspace is going to expect it is not clear to me.
> >
> > I don't want to end up in a position where we end up with available being generally
> > added for processed when what most people care about is what the value range they
> > might get from a polled read is (rather than via a buffer).
> >
> > So I'm not that keen on this solution but if we can find a way to avoid it.
> >
> > Jonathan
> >
> >  
> > >
> > >
> > > Thanks,
> > > Jyoti
> > >  
> >  


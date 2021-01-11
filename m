Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2231A2F21A3
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jan 2021 22:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbhAKVSo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jan 2021 16:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbhAKVSn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2021 16:18:43 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E366C061786
        for <linux-iio@vger.kernel.org>; Mon, 11 Jan 2021 13:18:03 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id i7so485527pgc.8
        for <linux-iio@vger.kernel.org>; Mon, 11 Jan 2021 13:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nBq8cnegMcFqmX5hhT5dzI5AeLuMtKfjBG3sc44kchc=;
        b=o3vluW07MzRqDzNyV8oTwXanP/FL26lBSakJTU8dEJFugHhAGb0TdhMd7lUGtWWiAY
         0tK7qe4pKKW9JEpymaM9TG/t8UhWOzZeJcGuhX8XdF6z9FWJltRh5ad87vTnbWCiO8LE
         7wzo7aGyJooeQ6UWlZHaefk0X5BaFNVBSaE/YfqeUh9gqMa+2q0no2bF8G05nHJd+scV
         mu5VD+J4Hipb0v37sBLyI0RXupQ36XeSzyQdgzQssb1SDAZG/NCAmW1IQKJru9tRxnUH
         pEfT8KPEz0u04csciiMET3eUX04B3mA7U/kVtQZQ5ul4R+903SQGuFdjB76T56dOPVaY
         i5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nBq8cnegMcFqmX5hhT5dzI5AeLuMtKfjBG3sc44kchc=;
        b=Z0rVgHwo5BauUYOzd0HeAp04zCmtdkR14UZxME5+BX9jqnjuXHLXPMlpigvLyyMWeF
         KRQyWNfRLAZx5m7KaUBDb1FNr/UhZ8xceJ+66AlbjVobB/fVKesbb8ZGaX0dekZDZqT9
         D2Tt9Hiw4nFKEvG2Ua1lnat9Y6v04S0jPsIgN4ULZD8NIVpqgVaGrFkgPgpBbuwGvmYI
         NT2HDV46a/mcg6oyxf5fUiLUZl9VniLcZCqbO9Lf9gyP/HTVgxKRHCf/T/fpoyq2OUOC
         sC2IGFAVixMH8ydX0RsS9FyHfQMiPFjP4dUGPDEsNoG4jQ5R8VJcYWpIj37Z9n9bQLgB
         BlXA==
X-Gm-Message-State: AOAM532C7T1RTkCbYzdkMmhGGYXc0ZoRx5548QPFZLK8nnI03kpMaTk0
        BJ9QS16gROXL3jOh6A84xu3jzw0U6L9cBlyu47XyBA==
X-Google-Smtp-Source: ABdhPJwIWWBDk1mtHtGx04TaroddtBJHTnR+Hzohwjywe/lVErXoyoeOwRI3gUGkPYPMLCfch1z3AXkvCXHXe80ENNY=
X-Received: by 2002:a63:1f21:: with SMTP id f33mr1387320pgf.31.1610399882598;
 Mon, 11 Jan 2021 13:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20210106161233.GA44413@e120937-lin> <20210106212353.951807-1-jbhayana@google.com>
 <20210109190133.61051fab@archlinux> <CA+=V6c3f5Z4_JOr+KzvxpL9nOcPrNAZYmG_VpUF+QAW4=cfy=Q@mail.gmail.com>
 <20210111123338.00007c06@Huawei.com>
In-Reply-To: <20210111123338.00007c06@Huawei.com>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Mon, 11 Jan 2021 13:17:51 -0800
Message-ID: <CA+=V6c1F1ViZRjdwZOC-YC4TryJ4dCcwpc=wvOZkb2HYMYGcmw@mail.gmail.com>
Subject: Re: Reply to [RFC PATCH v2 0/1] Adding support for IIO SCMI based sensors
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
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
        Peter Hilber <Peter.hilber@opensynergy.com>,
        Ankit Arora <ankitarora@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

I know it is a bit confusing. Let me try to explain it with some
examples to hopefully clarify some things here.
SCMI Platform talks to the native/actual sensor, gets the raw values
from the native sensor and applies the scale and then sends those
values to the SCMI agent and the SCMI IIO driver.
Since the sensor readings which SCMI IIO driver gets are integer, to
convert them to float , we need to apply scale to these sensor values
which is the unit_exponent(power-of-10 multiplier in two=E2=80=99s-compleme=
nt
format) specified in the SCMI specification

Native Sensor -> SCMI platform->SCMI Agent->SCMI IIO Driver

So if Native Sensor gets the sensor value
32767 and the scale the SCMI Platform is using is 0.002392.
SCMI platform does the calculation of 32767 * 0.002392 =3D 78.378664
and send the sensor value as 78378664 and the scale as .000001 to the
SCMI agent and SCMI IIO driver

so for SCMI IIO driver the sensor reading =3D 78378664 and scale =3D .00000=
1
and  the sensor value is sensor_reading * scale =3D 78378664 *  .000001
=3D  78.378664
and the resolution which the SCMI Platform sends to the SCMI agent is 0.002=
392.
In the SCMI IIO driver, scale which is .000001 is applied to the min
range/max range and the actual sensor values.
sensor resolution which is  0.002392 is just passed to the userspace
layer so that they know the Native sensor resolution/scale
being applied by the SCMI platform.

Regarding your comments in the previous email, when you mentioned
"what we actually
need is non standard ABI for resolution"? Does that mean that it is ok
to have sensor resolution
as the IIO attribute shown below?

static IIO_DEVICE_ATTR(sensor_resolution, 0444, scmi_iio_get_sensor_resolut=
ion,
                     NULL, 0);

static struct attribute *scmi_iio_attributes[] =3D {
       &iio_dev_attr_sensor_resolution.dev_attr.attr,
       NULL,
};

and for the min/max range, I can use the read_avail callback?

Also, for the min/max range, there were two options discussed in the
email thread:
option 1)  Add new IIO val Type IIO_VAL_INT_H32_L32, and modify the
iio_format_value to format the 64 bit int properly for the userspace
option 2) Ignore the H32 bits and use the existing IIO_VAL_INT as just
L32 bits should be sufficient for current sensor values.

Let me know which option you prefer for min/max range. and also please
confirm if it is ok to have an IIO attribute for resolution like
mentioned above.


Thanks,
Jyoti

Thank you so much

Jyoti



On Mon, Jan 11, 2021 at 4:34 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sun, 10 Jan 2021 22:44:44 -0800
> Jyoti Bhayana <jbhayana@google.com> wrote:
>
> > Hi Jonathan,
> >
> > In section 4.7.2.5.1 of the specification, the following exponent is
> > the scale value
> >
> > uint32 axis_attributes_high
> > Bits[15:11] Exponent: The power-of-10 multiplier in two=E2=80=99s-compl=
ement
> > format that is applied to the sensor unit
> > specified by the SensorType field.
> >
> > and the resolution is
> >
> > uint32 axis_resolution
> > Bits[31:27] Exponent: The power-of-10 multiplier in two=E2=80=99s-compl=
ement format
> > that is applied to the Res field. Bits[26:0] Res: The resolution of
> > the sensor axis.
> >
> > From code in scmi_protocol.h
> > /**
> >  * scmi_sensor_axis_info  - describes one sensor axes
> >  * @id: The axes ID.
> >  * @type: Axes type. Chosen amongst one of @enum scmi_sensor_class.
> >  * @scale: Power-of-10 multiplier applied to the axis unit.
> >  * @name: NULL-terminated string representing axes name as advertised b=
y
> >  *  SCMI platform.
> >  * @extended_attrs: Flag to indicate the presence of additional extende=
d
> >  *    attributes for this axes.
> >  * @resolution: Extended attribute representing the resolution of the a=
xes.
> >  * Set to 0 if not reported by this axes.
> >  * @exponent: Extended attribute representing the power-of-10 multiplie=
r that
> >  *      is applied to the resolution field. Set to 0 if not reported by
> >  *      this axes.
> >  * @attrs: Extended attributes representing minimum and maximum values
> >  *   measurable by this axes. Set to 0 if not reported by this sensor.
> >  */
> >
> > struct scmi_sensor_axis_info {
> > unsigned int id;
> > unsigned int type;
> > int scale; //This is the scale used for min/max range
> > char name[SCMI_MAX_STR_SIZE];
> > bool extended_attrs;
> > unsigned int resolution;
> > int exponent; // This is the scale used in resolution
> > struct scmi_range_attrs attrs;
> > };
> >
> > The scale above  is the Power-of-10 multiplier which is applied to the =
min range
> > and the max range value
> > but the resolution is equal to resolution and multiplied by
> > Power-of-10 multiplier
> > of exponent in the above struct.
> > So as can be seen above the value of the power of 10 multiplier used
> > for min/max range
> > can be different than the value of the power of 10 multiplier used for
> > the resolution.
> > Hence, if I have to use IIO_AVAIL_RANGE to specify min/max range and as=
 well
> > as resolution, then I have to use the float format with the scale appli=
ed.
> >
> > If there is another way which you know of and prefer, please let me kno=
w.
> I'll confess I've gotten a bit lost here.
>
> So I think where we are is how to describe the range of the sensor and wh=
y we can't
> use in_accel_x_raw_available to provide the
>
> Understood that the resolution can have different scaling.  That is presu=
mably
> to allow for the case where a device is reporting values at a finer scale=
 than
> it's real resolution.  Resolution might take into account expected noise =
for
> example.  So it should be decoupled from the scaling of both the actual m=
easurements
> and the axis high / low limits.
>
> However, I'd read that as saying the axis high / low limits and the actua=
l sensor
> readings should be scaled by the exponent in axis_attributes_high.
> So I think we are fine for the range, but my earlier assumption that reso=
lution
> was equivalent to scale in IIO (real world value for 1LSB) may be complet=
ely wrong
> as resolution may be unconnected to how you convert to a real world value=
?
>
> If nothing else I'd like to suggest the spec needs to be tightened a bit =
here
> to say exactly how we convert a value coming in to real world units (mayb=
e
> I'm just missing it).
>
> Anyhow, I suspect we've been looking at this the wrong way and what we ac=
tually
> need is non standard ABI for resolution.
>
> Jonathan
>
>
>
>
> >
> > Thanks,
> > Jyoti
> >
> >
> >
> >
> > Thanks,
> > Jyoti
> >
> > On Sat, Jan 9, 2021 at 11:01 AM Jonathan Cameron <jic23@kernel.org> wro=
te:
> > >
> > > On Wed,  6 Jan 2021 21:23:53 +0000
> > > Jyoti Bhayana <jbhayana@google.com> wrote:
> > >
> > > > Hi Jonathan,
> > > >
> > > > Instead of adding IIO_VAL_INT_H32_L32, I am thinking of adding IIO_=
VAL_FRACTIONAL_LONG
> > > > or IIO_VAL_FRACTIONAL_64 as the scale/exponent used for min/max ran=
ge can be different
> > > > than the one used in resolution according to specification.
> > >
> > > That's somewhat 'odd'.  Given min/max are inherently values the senso=
r is supposed to
> > > be able to return why give them different resolutions?  Can you point=
 me at a specific
> > > section of the spec?  The axis_min_range_low etc fields don't seem to=
 have units specified
> > > but I assumed they were in sensor units and so same scale factors?
> > >
> > > >
> > > > I am planning to use read_avail for IIO_CHAN_INFO_PROCESSED using I=
IO_AVAIL_RANGE
> > > > and this new IIO_VAL_FRACTIONAL_64 for min range,max range and reso=
lution.
> > > > Instead of two values used in IIO_VAL_FRACTIONAL, IIO_VAL_FRACTIONA=
L_64 will use 4 values
> > > > val_high,val_low,and val2_high and val2_low.
> > >
> > > I'm not keen on the changing that internal kernel interface unless we=
 absolutely
> > > have to.  read_avail() is called from consumer drivers and they won't=
 know anything
> > > about this new variant.
> > >
> > > >
> > > > Let me know if that is an acceptable solution.
> > >
> > > Hmm. It isn't a standard use of the ABI given the value in the buffer=
 is (I assume)
> > > raw (needs scale applied).  However, it isn't excluded by the ABI doc=
s.  Whether
> > > a standard userspace is going to expect it is not clear to me.
> > >
> > > I don't want to end up in a position where we end up with available b=
eing generally
> > > added for processed when what most people care about is what the valu=
e range they
> > > might get from a polled read is (rather than via a buffer).
> > >
> > > So I'm not that keen on this solution but if we can find a way to avo=
id it.
> > >
> > > Jonathan
> > >
> > >
> > > >
> > > >
> > > > Thanks,
> > > > Jyoti
> > > >
> > >
>

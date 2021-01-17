Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32A02F9551
	for <lists+linux-iio@lfdr.de>; Sun, 17 Jan 2021 22:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbhAQVDZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Jan 2021 16:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbhAQVDX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Jan 2021 16:03:23 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55028C061574
        for <linux-iio@vger.kernel.org>; Sun, 17 Jan 2021 13:02:43 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id c132so9698852pga.3
        for <linux-iio@vger.kernel.org>; Sun, 17 Jan 2021 13:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=55jRM/BbdoehD4CyZ2U1Bc9MqbdUlvYJ7KrKDNJ8mQs=;
        b=W7lVDmEXeg8utxglMharIZ8qXbtsFIFF7hezilIsG2ePkHwHJAj804jStzbFtnRxva
         mybTXejzaF4tSat7XdNfMJvA3dXYsntCgfAzJNIhmsqmuiURzXR7fRODk7AWvQg/rKMt
         aM+7i2xGD/TjLA6OgJL6xHr6QYRUZDLy5jR+/QqDCLWRWp9nXGojZfuRQ7ctB1dx+ysW
         eqad28M0FYIYt6E6Cxx1qXReg0YOC47wfRqhpnbvxDTAyciwd2qqwXgs8YqTVE3tc4LT
         /5SNdTDjrY3Hdh6/YStZ2sGAfszd1AKLvMLdFLucwzA8WB5+q2GzqCALS4U0XGpdOkxW
         shwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=55jRM/BbdoehD4CyZ2U1Bc9MqbdUlvYJ7KrKDNJ8mQs=;
        b=f8/MH+zViThzKUoG7rmUPgUAvH7Bd6WMKcPUhcj5oRlc7IjvmlCb9UZhtMAO3fL5/0
         cjmtnOU+uOmbY1VM+F4HHmb719GALWLls6F3SouuS0jFL9q5HnUFf1tobX7DAOWo1ylT
         jdRZp4q+tqWmMV3s5zO7GjcbRm8PxF1PC/qZmULFmPGb0RfNuUIqT8fuqbpJ5d8hxMVk
         DxAJyWgozPacyJ12Y4pHA3eBeyOEq4B+HUuli74Whiu1B8EQHbdBGQ3OY37/tB+v6OEw
         MDbq54SWyT5Fenel9Cb0cx+znDgCxoE2PssZDIQEzM5qtQcGAg55JaE1pszm14+pwTxY
         wASA==
X-Gm-Message-State: AOAM532AAwdIIc409dbcDXGKoyrKqk64/V9Mwr3DFHdzm6fkVChR0KyT
        H9eNTBv2JgNYz6mR+FF4qXx8Eg8QMfASwNM/LSff6Q==
X-Google-Smtp-Source: ABdhPJy9RiW+bhIYw6cenD2Ike5YR3RV5XHnbwO3EybJ5zpDtGfWn+FCP53eDMdWBjDS1YjL7FPS4bQYR7hVT2wlHS0=
X-Received: by 2002:aa7:95a4:0:b029:19e:abd2:4a88 with SMTP id
 a4-20020aa795a40000b029019eabd24a88mr23453132pfk.2.1610917362374; Sun, 17 Jan
 2021 13:02:42 -0800 (PST)
MIME-Version: 1.0
References: <20210106161233.GA44413@e120937-lin> <20210106212353.951807-1-jbhayana@google.com>
 <20210109190133.61051fab@archlinux> <CA+=V6c3f5Z4_JOr+KzvxpL9nOcPrNAZYmG_VpUF+QAW4=cfy=Q@mail.gmail.com>
 <20210111123338.00007c06@Huawei.com> <CA+=V6c1F1ViZRjdwZOC-YC4TryJ4dCcwpc=wvOZkb2HYMYGcmw@mail.gmail.com>
 <20210116193319.436f2c87@archlinux> <CA+=V6c0j_CGs6S6oWKE1m_BH3y-z4pNiMVkWUU=Zs2BAcoK7Gg@mail.gmail.com>
 <20210117115607.3f787388@archlinux>
In-Reply-To: <20210117115607.3f787388@archlinux>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Sun, 17 Jan 2021 13:02:31 -0800
Message-ID: <CA+=V6c2AxWNJv6DhrsGXexjtAoq4dL6-jnmxgBXpsQLC3PSmCQ@mail.gmail.com>
Subject: Re: Reply to [RFC PATCH v2 0/1] Adding support for IIO SCMI based sensors
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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

Instead of IIO_VAL_INT_PLUS_MICRO, we can also use IIO_VAL_FRACTIONAL
right for the raw values for min/max range and resolution? But, to
keep things simple though, it will be nice if the IIO driver uses
IIO_VAL_INT and throws an error if there is a negative exponent in the
following  calculation for the resolution which means the res_exponent
is always the same or greater than the scale_exponent.

 [res] x 10^(res_exponent - exponent)

so the IIO driver will use IIO_AVAIL_RANGE and IIO_VAL_INT and throw
error and not support that sensor if the following conditions happen:
1) min/max range is using H32 bits
2) resolution exponent is greater than the scale exponent.


Thanks,
Jyoti


On Sun, Jan 17, 2021 at 3:56 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 16 Jan 2021 23:15:56 -0800
> Jyoti Bhayana <jbhayana@google.com> wrote:
>
> > Hi Jonathan,
> >
> > Can you clarify one thing ? If we go with option 2 which is using
> > IIO_AVAIL_RANGE for min,step,high using IIO_VAL_INT then how will it
> > ensure the possible floating value for step as we are using int type?
> As you've identified we can't go with IIO_VAL_INT if we are doing that
> approach, would need to be IIO_VAL_INT_PLUS_MICRO (possibly NANO)
>
> That is why it comes unstuck if we need to use both val and val2 to
> do 64 bit integers...
>
> For the  min and max we just set the val2 value to 0.
>
> Jonathan
>
>
> >
> > Thanks,
> > Jyoti
> >
> > On Sat, Jan 16, 2021 at 11:33 AM Jonathan Cameron <jic23@kernel.org> wr=
ote:
> > >
> > > On Mon, 11 Jan 2021 13:17:51 -0800
> > > Jyoti Bhayana <jbhayana@google.com> wrote:
> > >
> > > > Hi Jonathan,
> > > >
> > > > I know it is a bit confusing. Let me try to explain it with some
> > > > examples to hopefully clarify some things here.
> > > > SCMI Platform talks to the native/actual sensor, gets the raw value=
s
> > > > from the native sensor and applies the scale and then sends those
> > > > values to the SCMI agent and the SCMI IIO driver.
> > > > Since the sensor readings which SCMI IIO driver gets are integer, t=
o
> > > > convert them to float , we need to apply scale to these sensor valu=
es
> > > > which is the unit_exponent(power-of-10 multiplier in two=E2=80=99s-=
complement
> > > > format) specified in the SCMI specification
> > > >
> > > > Native Sensor -> SCMI platform->SCMI Agent->SCMI IIO Driver
> > > >
> > > > So if Native Sensor gets the sensor value
> > > > 32767 and the scale the SCMI Platform is using is 0.002392.
> > > > SCMI platform does the calculation of 32767 * 0.002392 =3D 78.37866=
4
> > > > and send the sensor value as 78378664 and the scale as .000001 to t=
he
> > > > SCMI agent and SCMI IIO driver
> > > >
> > > > so for SCMI IIO driver the sensor reading =3D 78378664 and scale =
=3D .000001
> > > > and  the sensor value is sensor_reading * scale =3D 78378664 *  .00=
0001
> > > > =3D  78.378664
> > > > and the resolution which the SCMI Platform sends to the SCMI agent =
is 0.002392.
> > > > In the SCMI IIO driver, scale which is .000001 is applied to the mi=
n
> > > > range/max range and the actual sensor values.
> > > > sensor resolution which is  0.002392 is just passed to the userspac=
e
> > > > layer so that they know the Native sensor resolution/scale
> > > > being applied by the SCMI platform.
> > >
> > > That was pretty much where I'd gotten to.
> > > Whilst the reasoning might be different it is equivalent to a sensor
> > > providing info on expected noise by giving a 'valid resolution'.
> > > In that case as well you have a sensor providing a number that looks =
to have
> > > more precision than it actually does.
> > >
> > > Anyhow, that similarity doesn't really matter here.
> > >
> > > I'll also add that a design that applies scale in two places is inher=
ently
> > > less than ideal.   A cleaner design would have maintained the separat=
ion
> > > between scale and raw value all the way up the stack.  That would res=
ult
> > > in 0 loss of information and also be a cleaner interface.
> > > Ah well, we live with what we have :)
> > >
> > > >
> > > > Regarding your comments in the previous email, when you mentioned
> > > > "what we actually
> > > > need is non standard ABI for resolution"? Does that mean that it is=
 ok
> > > > to have sensor resolution
> > > > as the IIO attribute shown below?
> > > >
> > > > static IIO_DEVICE_ATTR(sensor_resolution, 0444, scmi_iio_get_sensor=
_resolution,
> > > >                      NULL, 0);
> > >
> > > We could do something new (see later for why I don't think we need to=
)
> > > Would need to clearly reflect what it applies to and I'm not sure res=
olution
> > > is even an unambiguous name given sensor resolution is often describe=
d as 8bit
> > > 10bit etc.  E.g. this selection table from Maxim for ADCs.
> > > https://www.maximintegrated.com/en/products/parametric/search.html?fa=
m=3Dprec_adc&tree=3Dmaster&metaTitle=3DPrecision%20ADCs%20(%20%205Msps)&hid=
e=3D270
> > > Of course sometimes it's also used for what you want here.
> > >
> > > Hohum.  So we might be still be able to do this with standard ABI but=
 we
> > > are going to need to do some maths in the driver.
> > > So if we were to express it via
> > >
> > > in_accel_raw_avail for example we could use the [low step high] form.
> > >
> > > low and high are straight forward as those are expressed directly fro=
m
> > > axis_min_range and axis_max_range which I think are in the same units
> > > as the _raw channel itself.
> > >
> > > For resolution, we have it expressed as [res] x 10^res_exponent
> > > and if we just put that in as the 'step' above it would have the wron=
g
> > > exponent (as we'd expect to still have to apply your 0.00001 from abo=
ve
> > > example).
> > >
> > > Hence we express it as [res] x 10^(res_exponent - exponent)
> > >
> > > I'm going to slightly modify your example above because the two expon=
ents
> > > are the same so it's hard to tell if I have them right way around.
> > > Hence let res =3D 0.00293 =3D 293 x 10^(-5)  (I just dropped the trai=
ling 2)
> > >
> > > scale =3D 10^(-6) exponent =3D -6
> > >
> > > So step =3D 2392 x 10^(-5 + 6) =3D 2390
> > > giving us
> > >
> > > [min 2390 max] for _raw_available
> > >
> > > Hence when userspace comes along and wants this in relevant base unit=
s (here
> > > m/sec^2) it applies the x10^(-6) mutliplier from _scale we get out ex=
pected value
> > > of 0.00239 m/sec^2
> > >
> > > That should work for any case we see but the maths done in the driver=
 will have
> > > to cope with potential negative exponents for step.
> > >
> > > One catch will be the 64 bit potential values for min and max :(
> > >
> > > >
> > > > static struct attribute *scmi_iio_attributes[] =3D {
> > > >        &iio_dev_attr_sensor_resolution.dev_attr.attr,
> > > >        NULL,
> > > > };
> > > >
> > > > and for the min/max range, I can use the read_avail callback?
> > >
> > > I would have said yes normally but if we are going to cope with
> > > a potential floating point value for step as touched on above we
> > > may have to do it by hand in the driver.  Not ideal but may
> > > be only option :(
> > >
> > > >
> > > > Also, for the min/max range, there were two options discussed in th=
e
> > > > email thread:
> > > > option 1)  Add new IIO val Type IIO_VAL_INT_H32_L32, and modify the
> > > > iio_format_value to format the 64 bit int properly for the userspac=
e
> > > > option 2) Ignore the H32 bits and use the existing IIO_VAL_INT as j=
ust
> > > > L32 bits should be sufficient for current sensor values.
> > >
> > > Ignore is a strong way of putting it.  We would definitely want to
> > > shout about it if we do get anything set in H32.
> > >
> > > If we are fairly sure that we aren't going to anything greater than
> > > 32 bits than we are fine.
> > >
> > > It should be possible to work through the worst cases given
> > > limits of say +-20g for accelerometers for example and the relatively
> > > limited exponents (5 bits).  + sensible resolution.
> > >
> > > If it's fairly safe I'd like to go for option 2. as it would ensure w=
e
> > > can do floating point for the step (which is then used to compute the
> > > resolution value for android)
> > >
> > > Thanks
> > >
> > > Jonathan
> > >
> > > >
> > > > Let me know which option you prefer for min/max range. and also ple=
ase
> > > > confirm if it is ok to have an IIO attribute for resolution like
> > > > mentioned above.
> > > >
> > > >
> > > > Thanks,
> > > > Jyoti
> > > >
> > > > Thank you so much
> > > >
> > > > Jyoti
> > > >
> > > >
> > > >
> > > > On Mon, Jan 11, 2021 at 4:34 AM Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > >
> > > > > On Sun, 10 Jan 2021 22:44:44 -0800
> > > > > Jyoti Bhayana <jbhayana@google.com> wrote:
> > > > >
> > > > > > Hi Jonathan,
> > > > > >
> > > > > > In section 4.7.2.5.1 of the specification, the following expone=
nt is
> > > > > > the scale value
> > > > > >
> > > > > > uint32 axis_attributes_high
> > > > > > Bits[15:11] Exponent: The power-of-10 multiplier in two=E2=80=
=99s-complement
> > > > > > format that is applied to the sensor unit
> > > > > > specified by the SensorType field.
> > > > > >
> > > > > > and the resolution is
> > > > > >
> > > > > > uint32 axis_resolution
> > > > > > Bits[31:27] Exponent: The power-of-10 multiplier in two=E2=80=
=99s-complement format
> > > > > > that is applied to the Res field. Bits[26:0] Res: The resolutio=
n of
> > > > > > the sensor axis.
> > > > > >
> > > > > > From code in scmi_protocol.h
> > > > > > /**
> > > > > >  * scmi_sensor_axis_info  - describes one sensor axes
> > > > > >  * @id: The axes ID.
> > > > > >  * @type: Axes type. Chosen amongst one of @enum scmi_sensor_cl=
ass.
> > > > > >  * @scale: Power-of-10 multiplier applied to the axis unit.
> > > > > >  * @name: NULL-terminated string representing axes name as adve=
rtised by
> > > > > >  *  SCMI platform.
> > > > > >  * @extended_attrs: Flag to indicate the presence of additional=
 extended
> > > > > >  *    attributes for this axes.
> > > > > >  * @resolution: Extended attribute representing the resolution =
of the axes.
> > > > > >  * Set to 0 if not reported by this axes.
> > > > > >  * @exponent: Extended attribute representing the power-of-10 m=
ultiplier that
> > > > > >  *      is applied to the resolution field. Set to 0 if not rep=
orted by
> > > > > >  *      this axes.
> > > > > >  * @attrs: Extended attributes representing minimum and maximum=
 values
> > > > > >  *   measurable by this axes. Set to 0 if not reported by this =
sensor.
> > > > > >  */
> > > > > >
> > > > > > struct scmi_sensor_axis_info {
> > > > > > unsigned int id;
> > > > > > unsigned int type;
> > > > > > int scale; //This is the scale used for min/max range
> > > > > > char name[SCMI_MAX_STR_SIZE];
> > > > > > bool extended_attrs;
> > > > > > unsigned int resolution;
> > > > > > int exponent; // This is the scale used in resolution
> > > > > > struct scmi_range_attrs attrs;
> > > > > > };
> > > > > >
> > > > > > The scale above  is the Power-of-10 multiplier which is applied=
 to the min range
> > > > > > and the max range value
> > > > > > but the resolution is equal to resolution and multiplied by
> > > > > > Power-of-10 multiplier
> > > > > > of exponent in the above struct.
> > > > > > So as can be seen above the value of the power of 10 multiplier=
 used
> > > > > > for min/max range
> > > > > > can be different than the value of the power of 10 multiplier u=
sed for
> > > > > > the resolution.
> > > > > > Hence, if I have to use IIO_AVAIL_RANGE to specify min/max rang=
e and as well
> > > > > > as resolution, then I have to use the float format with the sca=
le applied.
> > > > > >
> > > > > > If there is another way which you know of and prefer, please le=
t me know.
> > > > > I'll confess I've gotten a bit lost here.
> > > > >
> > > > > So I think where we are is how to describe the range of the senso=
r and why we can't
> > > > > use in_accel_x_raw_available to provide the
> > > > >
> > > > > Understood that the resolution can have different scaling.  That =
is presumably
> > > > > to allow for the case where a device is reporting values at a fin=
er scale than
> > > > > it's real resolution.  Resolution might take into account expecte=
d noise for
> > > > > example.  So it should be decoupled from the scaling of both the =
actual measurements
> > > > > and the axis high / low limits.
> > > > >
> > > > > However, I'd read that as saying the axis high / low limits and t=
he actual sensor
> > > > > readings should be scaled by the exponent in axis_attributes_high=
.
> > > > > So I think we are fine for the range, but my earlier assumption t=
hat resolution
> > > > > was equivalent to scale in IIO (real world value for 1LSB) may be=
 completely wrong
> > > > > as resolution may be unconnected to how you convert to a real wor=
ld value?
> > > > >
> > > > > If nothing else I'd like to suggest the spec needs to be tightene=
d a bit here
> > > > > to say exactly how we convert a value coming in to real world uni=
ts (maybe
> > > > > I'm just missing it).
> > > > >
> > > > > Anyhow, I suspect we've been looking at this the wrong way and wh=
at we actually
> > > > > need is non standard ABI for resolution.
> > > > >
> > > > > Jonathan
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Jyoti
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Jyoti
> > > > > >
> > > > > > On Sat, Jan 9, 2021 at 11:01 AM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > > > > > >
> > > > > > > On Wed,  6 Jan 2021 21:23:53 +0000
> > > > > > > Jyoti Bhayana <jbhayana@google.com> wrote:
> > > > > > >
> > > > > > > > Hi Jonathan,
> > > > > > > >
> > > > > > > > Instead of adding IIO_VAL_INT_H32_L32, I am thinking of add=
ing IIO_VAL_FRACTIONAL_LONG
> > > > > > > > or IIO_VAL_FRACTIONAL_64 as the scale/exponent used for min=
/max range can be different
> > > > > > > > than the one used in resolution according to specification.
> > > > > > >
> > > > > > > That's somewhat 'odd'.  Given min/max are inherently values t=
he sensor is supposed to
> > > > > > > be able to return why give them different resolutions?  Can y=
ou point me at a specific
> > > > > > > section of the spec?  The axis_min_range_low etc fields don't=
 seem to have units specified
> > > > > > > but I assumed they were in sensor units and so same scale fac=
tors?
> > > > > > >
> > > > > > > >
> > > > > > > > I am planning to use read_avail for IIO_CHAN_INFO_PROCESSED=
 using IIO_AVAIL_RANGE
> > > > > > > > and this new IIO_VAL_FRACTIONAL_64 for min range,max range =
and resolution.
> > > > > > > > Instead of two values used in IIO_VAL_FRACTIONAL, IIO_VAL_F=
RACTIONAL_64 will use 4 values
> > > > > > > > val_high,val_low,and val2_high and val2_low.
> > > > > > >
> > > > > > > I'm not keen on the changing that internal kernel interface u=
nless we absolutely
> > > > > > > have to.  read_avail() is called from consumer drivers and th=
ey won't know anything
> > > > > > > about this new variant.
> > > > > > >
> > > > > > > >
> > > > > > > > Let me know if that is an acceptable solution.
> > > > > > >
> > > > > > > Hmm. It isn't a standard use of the ABI given the value in th=
e buffer is (I assume)
> > > > > > > raw (needs scale applied).  However, it isn't excluded by the=
 ABI docs.  Whether
> > > > > > > a standard userspace is going to expect it is not clear to me=
.
> > > > > > >
> > > > > > > I don't want to end up in a position where we end up with ava=
ilable being generally
> > > > > > > added for processed when what most people care about is what =
the value range they
> > > > > > > might get from a polled read is (rather than via a buffer).
> > > > > > >
> > > > > > > So I'm not that keen on this solution but if we can find a wa=
y to avoid it.
> > > > > > >
> > > > > > > Jonathan
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Jyoti
> > > > > > > >
> > > > > > >
> > > > >
> > >
>

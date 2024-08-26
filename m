Return-Path: <linux-iio+bounces-8782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EDB95EDAE
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 11:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B121C21692
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46182146D53;
	Mon, 26 Aug 2024 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQQ3kK9N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CC1465AE;
	Mon, 26 Aug 2024 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665807; cv=none; b=iDAcYT1BeoapZ+ZwWbRlnH0FNCwtZKQXbWYAC+lRGW/ctGV3p+8eRtuATAHNFCnqejIShTi+4k3Dh2QCFnfKPbUKLWhLkqDMGg+RFUfmGuhP3VStRLSRIYuIhRn+81lIm5PhzGppA06m62vOov3b+f5RqW5LshRgD9JxVEd4yNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665807; c=relaxed/simple;
	bh=X4XtTIQ4M47FVIdcgJule4UXJUzrtFvBwfomuOxhSNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNVDooQbPCdJwRk5Nup1OOu9gIAIK6gYpRL5wmdR3Rnk/dC89X4ZD/EXlg53b3u2FajQIZTwCoBFCFWJQzFLgPnPhzfn2qjy0FJqIDUPUGSuMFUbSjJxgOU/wpX8nq/2ovt/MAQROZRq6nMwrV1GOPFFkOhE3nQ9zEFmmoJiSTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQQ3kK9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B5FC4FE00;
	Mon, 26 Aug 2024 09:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724665806;
	bh=X4XtTIQ4M47FVIdcgJule4UXJUzrtFvBwfomuOxhSNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nQQ3kK9N+iwDLbwezr69Ra9UmNixoWdrH1kXvvkP6/x6o9Q/tysOt6phcbc2AymHg
	 nBFgYKoq2+r8qCM5gUF/yNEUv02H2zahX07DaCKhyQsdHRQjOpW0xflpZu5n7/f/X9
	 RGPVYav3U0dL/J82Zi00UTLLNCvKDb5jN66B5sklFL0sYmsfHEejNQOMlo2OqpbDtN
	 dHHd+Y7jzubpc5s2AYxGSmB9mXamhW8zcVRWoZUYd6VXs1Z5Hhtuv0sZNDiGNim1rJ
	 qMlYyHPz8MPIW7b2QV3xCIh5qVmT3drmreQsWukeK1apYpCmP7G1ksskuRseDgQ1mp
	 KiNwVygSdjYpg==
Date: Mon, 26 Aug 2024 10:49:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Li, Hua Qian" <HuaQian.Li@siemens.com>
Cc: "Zeng, Chao" <chao.zeng@siemens.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "conor@kernel.org" <conor@kernel.org>, "Su, Bao Cheng"
 <baocheng.su@siemens.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "Lopes Ivo, Diogo Miguel" <diogo.ivo@siemens.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: Add everlight pm16d17 binding
Message-ID: <20240826104947.61613a3c@jic23-huawei>
In-Reply-To: <18528634e39eec1307777a0fed5eda7324e78575.camel@siemens.com>
References: <cover.1723527641.git.jan.kiszka@siemens.com>
	<f6476e06cd8d1cf3aff6563530612c536cd45716.1723527641.git.jan.kiszka@siemens.com>
	<20240813-captivity-spellbind-d36ca0f31e22@spud>
	<a458a2cbc96a23c0a2ef89327e1f8bcd2e2777e6.camel@siemens.com>
	<20240817144215.1b2e9db3@jic23-huawei>
	<18528634e39eec1307777a0fed5eda7324e78575.camel@siemens.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 07:12:53 +0000
"Li, Hua Qian" <HuaQian.Li@siemens.com> wrote:

> On Sat, 2024-08-17 at 14:42 +0100, Jonathan Cameron wrote:
> > On Fri, 16 Aug 2024 01:48:36 +0000
> > "Li, Hua Qian" <HuaQian.Li@siemens.com> wrote:
> >  
> > > On Tue, 2024-08-13 at 16:52 +0100, Conor Dooley wrote:  
> > > > On Tue, Aug 13, 2024 at 07:40:41AM +0200, Jan Kiszka wrote:  
> > > > > From: Chao Zeng <chao.zeng@siemens.com>
> > > > >
> > > > > Add the binding document for the everlight pm16d17 sensor.
> > > > >
> > > > > Signed-off-by: Chao Zeng <chao.zeng@siemens.com>
> > > > > Co-developed-by: Baocheng Su <baocheng.su@siemens.com>
> > > > > Signed-off-by: Baocheng Su <baocheng.su@siemens.com>  
> > > >
> > > > Ditto here Jan.
> > > >  
> > > > > ---
> > > > >  .../iio/proximity/everlight,pm16d17.yaml      | 95
> > > > > +++++++++++++++++++
> > > > >  1 file changed, 95 insertions(+)
> > > > >  create mode 100644
> > > > > Documentation/devicetree/bindings/iio/proximity/everlight,pm16d
> > > > > 17.y
> > > > > aml
> > > > >
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/iio/proximity/everlight,pm1
> > > > > 6d17
> > > > > .yaml
> > > > > b/Documentation/devicetree/bindings/iio/proximity/everlight,pm1
> > > > > 6d17
> > > > > .yaml
> > > > > new file mode 100644
> > > > > index 000000000000..fadc3075181a
> > > > > --- /dev/null
> > > > > +++
> > > > > b/Documentation/devicetree/bindings/iio/proximity/everlight,pm1
> > > > > 6d17
> > > > > .yaml
> > > > > @@ -0,0 +1,95 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id:
> > > > > http://devicetree.org/schemas/iio/proximity/everlight,pm16d17.yaml#
> > > > > +$schema:
> > > > > http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Everlight PM-16D17 Ambient Light & Proximity Sensor
> > > > > +
> > > > > +maintainers:
> > > > > +  - Chao Zeng <chao.zeng@siemens.com>
> > > > > +
> > > > > +description: |
> > > > > +  This sensor uses standard I2C interface. Interrupt function
> > > > > is
> > > > > not covered.  
> > > >
> > > > Bindings should be complete, even if software doesn't use the
> > > > interrupts. Can you document them please.
> > > >  
> > > > > +  Datasheet:
> > > > > https://en.everlight.com/sensor/category-proximity_sensor/digital_proximity_sensor/
> > > > >  
> > > >
> > > > Do you have a link to a datasheet? The link to the pm16d17 here
> > > > 404s
> > > > for
> > > > me.
> > > >  
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - everlight,pm16d17
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  ps-gain:
> > > > > +    description: Receiver gain of proximity sensor
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +    enum: [1, 2, 4, 8]
> > > > > +    default: 1
> > > > > +  
> How about using `in_proximity0_hw_gain` as a userspace interface here?

hwgain is used for cases where the gain does not affect the singal
reported (so things like brightness on a time of flight sensor).
If this directly affects the output values for proximity then
it should be scale. If there are multiple things affecting the scale
it is up to the driver to figure out the 'right' combination to satisfy the
user request.

> > > > > +  ps-itime:  
> > > >
> > > > How did you get itime from conversion time? To the layman (like
> > > > me!)
> > > > conversion-time would make more sense...
> > > >
> > > > Also, "ps"? The whole thing is a proxy sensor, so why have that
> > > > prefix
> > > > on properties. What is missing however is a vendor prefix.  
> How about using `in_proximity0_conversion_time` as a userspace
> interface here?

See if you can use standard ABI.  New ABI is effectively ABI that
is unused by all existing software and unlikely to be adopted by
anything generic in future.

We have various controls this might map to.  integration_time
for the amount of exposure time for a given sensor, sampling_frequency
covers the rate at which the overall process occurs (1/sampling period).
That covers the majority of cases.  If it's something else that
can't be mapped to these interfaces I want to fully understand
why userspace would choose to change it.

> > > >  
> > > > > +    description: Conversion time for proximity sensor [ms]
> > > > > +    $ref: /schemas/types.yaml#/definitions/string  
> > > >
> > > > Instead of a string, please use the -us suffix, and put this in
> > > > microseconds instead.
> > > >
> > > > In total, that would be s/ps-itime/everlight,conversion-time-us/.
> > > >
> > > > I would, however, like to know why this is a property of the
> > > > hardware.
> > > > What factors do you have to consider when determining what value
> > > > to
> > > > put
> > > > in here?
> > > >  
> > > > > +    enum:
> > > > > +      - "0.4"
> > > > > +      - "0.8"
> > > > > +      - "1.6"
> > > > > +      - "3.2"
> > > > > +      - "6.3"
> > > > > +      - "12.6"
> > > > > +      - "25.2"
> > > > > +    default: "0.4"
> > > > > +
> > > > > +  ps-wtime:
> > > > > +    description: Waiting time for proximity sensor [ms]
> > > > > +    $ref: /schemas/types.yaml#/definitions/string  
> > > >
> > > > All of the same comments apply here. E.g. why "wtime" isntead of
> > > > "waiting-time" and so on.
> > > > I would really like to know why these things are properties of
> > > > the
> > > > hardware, rather than something that software should control.
> > > >  
> How about using `in_proximity0_wait_time` as a userspace interface
> here?
Again, if you add new ABI, it will be unused.
So basically do not do so.  Work out how to map to existing ABI.

Superficially seems like sampling_frequency = 1/(wait_time + conversion_time)
And 'maybe' conversion time is close at least to 'integration_time'.

It is sometimes a pain to map to standard ABI for hardware that chooses
different control schemes, but it is necessary to do so if you want to be
able to use normal software / scripts etc.

If there is something we can't represent and a strong usecase for
why userspace will want to directly tune it (rather than it being
one element of the hardware controls that back a single userspace
control) then it is fine to propose new userspace ABI along with
documentation.  We'll consider it, but it will be much more challenging
to get accepted than using standard ABI.

> > > > > +    enum:
> > > > > +      - "12.5"
> > > > > +      - "25"
> > > > > +      - "50"
> > > > > +      - "100"
> > > > > +      - "200"
> > > > > +      - "400"
> > > > > +      - "800"
> > > > > +      - "1600"
> > > > > +    default: "12.5"
> > > > > +
> > > > > +  ps-ir-led-pulse-count:
> > > > > +    description: IR LED drive pulse count
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32  
> > > >
> > > > All custom properties require a vendor prefix, not "ps". Again,
> > > > what
> > > > makes this a property of the hardware, rather than something that
> > > > software should control?
> > > >  
> How about using `in_proximity0_pulse_count` as a userspace interface
> here?
This one is unsual, so I want to understand what it actually means
for a user.  Why would they control pulse count? What does it do?
- Increase gain / sensitivity?
- Reduce noise?

> > > > > +    minimum: 1
> > > > > +    maximum: 256
> > > > > +    default: 1
> > > > > +
> > > > > +  ps-offset-cancel:
> > > > > +    description: |
> > > > > +      When PS offset cancel function is enabled, the result of
> > > > > subtracting any
> > > > > +      value specified by the PS offset cancel register from
> > > > > the
> > > > > internal PS
> > > > > +      output data is written to the PS output data register.  
> > > >  
> How about using `in_proximity0_offset_cancel` as a userspace interface
> here?

This seems likely to be calibbias or offset.  The cancel or not
is just whether the offset value is 0 or not.

> > > > Again, what makes this a property of the hardware? What hardware
> > > > related
> > > > factors determine that value that you put in here?
> > > >
> > > > Thanks,
> > > > Conor.  
> > >
> > > Certain parameters such as conversion time, wait time, or sampling
> > > rate
> > > are directly tied to the physical characteristics and capabilities
> > > of
> > > the sensor.  
> >
> > Ah. I think I'd missed this uses an external LED (rather than it
> > being
> > in package).  In that case, the characteristics that 'work' for
> > proximity sensing are somewhat dependent on the system design
> > (simplifying heavily, led output for a given current, optical filter
> >  on that LED etc).
> >
> > For the sensor specific side, it should be just from the compatible,
> > but
> > when another part is involved, DT binding based tuning may make sense
> > as long as it is 'per consumer device / board' not per specific
> > instance.
> >
> >
> >
> >  
> > > These parameters are typically determined by the sensor
> > > specifications, and the datasheet usually provides recommended
> > > values
> > > for these parameters. Below is an excerpt from the datasheet:
> > >
> > > /*
> > > +-----------------------+-------+------+------+------+-----+-------
> > > ---+  
> > > > Parameter             | Symbol| Min  | Typ  | Max  | Unit|
> > > > Condition|  
> > > +-----------------------+-------+------+------+------+-----+-------
> > > ---+  
> > > > PS A/D conversion time| TPS   | 21.4 | 25.2 | 28.9 | ms  | PS  
> > > A/DC=16bit  |  
> > > > PS wait time setting  | TPSWAIT| 10.6| 12.5 | 14.3 | ms  | 12.5ms  
> > > setting |
> > > +-----------------------+-------+------+------+------+-----+-------
> > > ---+
> > > */  
> >
> > Doesn't apply to everything you have here though. wtime / wait time
> > is about how often you get a reading not the physical device.  How is
> > that affected by the physical device?
> >
> > I 'think' the table above is giving precision of the value for a
> > particular
> > control setting. If you set wtime to 12.5msec (value 0 in register)
> > then it will actually be between 10.6 and 14.3 msec, not that you
> > should
> > set it to 12.5msec.
> >
> > There are 3 controls related to gain that you could argue for
> > defaults
> > for in DT (maybe) but given proximity sensing is also about the
> > target, not just the measurement device, there won't be a right
> > answer
> > unless your proximity sensor is being used for a fixed purpose (e.g.
> > WIFI signal strength limiting or a button type control).  
> > >
> > >
> > > However, there are some similar cases in the kernel, as follows:
> > >
> > > Documentation/devicetree/bindings/iio/proximity/devantech-
> > > srf04.yaml
> > >     - startup-time-ms  
> > That's after a resume and I think depends one exactly what the
> > circuitry
> > is (in this case the device is more of a reference design than a
> > single
> > device).
> >  
> > > Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> > > Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > > Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
> > >     - semtech,avg-pos-strength
> > >     - semtech,ph01-resolution
> > >     - semtech,input-analog-gain  
> > These are SAR sensors I think, so the sensor element is external to
> > the device.  In theory we could have described the sensing element
> > and used that to work out the right values of these, but in practice
> > it was easier to just provide the parameters from some 'per design'
> > tuning.
> >  
> > >     - ...
> > > Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yam
> > > l
> > >     - vishay,led-current-microamp  
> >
> > I think this is about whether you can burn the external LED out or
> > not.
> > On the datasheet I'm looking at for this device, only value 000 is
> > specified in this 3bit field so I guess it's not controllable?
> >
> > Pulse counts are less likely to be relevant to the LED burning out,
> > but
> > maybe(?)
> >
> > Anyhow, it's not entirely obvious to me that it makes sense to
> > control
> > so much in DT for this device.  Better to put it in userspace control
> > and rely on udev etc setting things right for a given device +
> > application.
> >
> > Jonathan
> >  
> I agree with your comments, we'll modify the DT to allow userspace
> control as introduced above. Consequently, all the dt properites will
> be removed.

That's good, but do focus on how to fit existing ABI as that's
what existing userspace is aware of.

Jonathan

> 
> 
> Thanks,
> Hua Qian
> >
> >
> >  
> > >
> > > This is why we are leveraging the hardware properties.
> > >
> > > Thanks,
> > > Hua Qian
> > >  
> > > >  
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +    default: 0
> > > > > +    maximum: 65535
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +
> > > > > +unevaluatedProperties: false
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    i2c {
> > > > > +        #address-cells = <1>;
> > > > > +        #size-cells = <0>;
> > > > > +
> > > > > +        lightsensor: pm16d17@44 {
> > > > > +            compatible = "everlight,pm16d17";
> > > > > +            reg = <0x44>;
> > > > > +
> > > > > +            ps-gain = <1>;
> > > > > +            ps-itime = "0.4";
> > > > > +            ps-wtime = "12.5";
> > > > > +            ps-ir-led-pulse-count = <1>;
> > > > > +            ps-offset-cancel = <280>;
> > > > > +        };
> > > > > +    };
> > > > > --
> > > > > 2.43.0
> > > > >  
> > >  
> >  
> 
> --
> Hua Qian Li
> Siemens AG
> http://www.siemens.com/



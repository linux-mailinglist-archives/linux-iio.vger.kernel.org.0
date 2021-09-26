Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C45B418993
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhIZOx6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 26 Sep 2021 10:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231888AbhIZOx6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 10:53:58 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7149060F48;
        Sun, 26 Sep 2021 14:52:18 +0000 (UTC)
Date:   Sun, 26 Sep 2021 15:56:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Fabrice GASNIER <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 4/4] iio: adc: stm32-dfsdm: add scale and offset support
Message-ID: <20210926155607.3a7fae81@jic23-huawei>
In-Reply-To: <2ac8eafa-25fe-6640-edef-960e56733534@foss.st.com>
References: <20200204101008.11411-1-olivier.moysan@st.com>
        <20200204101008.11411-5-olivier.moysan@st.com>
        <20200208161847.76c7d6e8@archlinux>
        <8400827e-5f3d-ad3f-99c8-986934b1a7b8@st.com>
        <20200214131113.70aa36b8@archlinux>
        <5b2e74a0-71bd-46d0-0096-b33ff17f780b@st.com>
        <20200214151011.20111e8c@archlinux>
        <AM9PR10MB43558CEB8DAE7F373E9E7A5DF9D69@AM9PR10MB4355.EURPRD10.PROD.OUTLOOK.COM>
        <78f4e4b9-ef4c-982f-7cd3-8d3052d99150@foss.st.com>
        <20210912182617.5635fa06@jic23-huawei>
        <a38906b8-7d28-b5e0-939b-e8108bd7266c@foss.st.com>
        <20210919191414.09270f4e@jic23-huawei>
        <2ac8eafa-25fe-6640-edef-960e56733534@foss.st.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Sep 2021 15:14:20 +0200
Olivier MOYSAN <olivier.moysan@foss.st.com> wrote:

> Hi Jonathan,
> 
> On 9/19/21 8:14 PM, Jonathan Cameron wrote:
> > On Tue, 14 Sep 2021 17:43:15 +0200
> > Olivier MOYSAN <olivier.moysan@foss.st.com> wrote:
> >   
> >> Hi Jonathan,
> >>
> >> Thanks, for your comments.
> >>
> >> On 9/12/21 7:26 PM, Jonathan Cameron wrote:  
> >>> On Fri, 10 Sep 2021 17:56:45 +0200
> >>> Olivier MOYSAN <olivier.moysan@foss.st.com> wrote:
> >>>      
> >>>> Hi Jonathan,
> >>>>
> >>>> On 9/10/21 4:05 PM, Olivier MOYSAN wrote:  
> >>>>>
> >>>>>
> >>>>>
> >>>>> ST Restricted
> >>>>>
> >>>>> -----Original Message-----
> >>>>> From: Jonathan Cameron <jic23@kernel.org>
> >>>>> Sent: vendredi 14 février 2020 16:10
> >>>>> To: Olivier MOYSAN <olivier.moysan@st.com>
> >>>>> Cc: robh+dt@kernel.org; mark.rutland@arm.com; knaack.h@gmx.de; lars@metafoo.de; devicetree@vger.kernel.org; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; pmeerw@pmeerw.net; linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org
> >>>>> Subject: Re: [PATCH 4/4] iio: adc: stm32-dfsdm: add scale and offset support
> >>>>>
> >>>>> On Fri, 14 Feb 2020 14:49:18 +0000
> >>>>> Olivier MOYSAN <olivier.moysan@st.com> wrote:
> >>>>>         
> >>>>>> Hi Jonathan,
> >>>>>>
> >>>>>> On 2/14/20 2:11 PM, Jonathan Cameron wrote:  
> >>>>>>> On Tue, 11 Feb 2020 15:19:01 +0000
> >>>>>>> Olivier MOYSAN <olivier.moysan@st.com> wrote:
> >>>>>>>           
> >>>>>>>> Hi Jonathan,
> >>>>>>>>
> >>>>>>>> On 2/8/20 5:18 PM, Jonathan Cameron wrote:  
> >>>>>>>>> On Tue, 4 Feb 2020 11:10:08 +0100
> >>>>>>>>> Olivier Moysan <olivier.moysan@st.com> wrote:
> >>>>>>>>>              
> >>>>>>>>>> Add scale and offset attributes support to STM32 DFSDM.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>  
> >>>>>>>>> Hmm. I can't remember this history of this but we've kind of ended
> >>>>>>>>> up backwards wrt to other consumer drivers.
> >>>>>>>>>
> >>>>>>>>> In some sense this is similar to the analog gyroscopes.  In those
> >>>>>>>>> the consumer driver is the gyroscope which is consuming the raw
> >>>>>>>>> readings from an ADC connected to the channel.  This results in us
> >>>>>>>>> getting readings reported by the gyroscope driver.
> >>>>>>>>>
> >>>>>>>>> Here we have a sigma delta convertor consuming the pulse train
> >>>>>>>>> from a sigma delta device.  So the channels are reported by the
> >>>>>>>>> sigma delta receiver, whereas i think the nearest equivalent to
> >>>>>>>>> the analog voltage outputing gyroscopes would have been if we had
> >>>>>>>>> reported the channel values at the sigma delta converter.  
> >>>>>>>> The DFSDM driver is currently used as a consumer of the sd modulator.
> >>>>>>>> The scale and offset values of the channels are already computed by
> >>>>>>>> the DFSDM driver, and provided by this driver to the IIO ABI.
> >>>>>>>> However, the DFSDM has no voltage reference, so it has to retrieve
> >>>>>>>> it from sd-modulator channels, for the scale factor computation.
> >>>>>>>>
> >>>>>>>>                                          scale  offset
> >>>>>>>>                                            ^      ^
> >>>>>>>>                                            |      |       IIO ABI
> >>>>>>>> +-------------------------------------------------------------+
> >>>>>>>>               +---------------+          +-------------+
> >>>>>>>>               |sd driver      |          |DFSDM driver |
> >>>>>>>>               +---------------+          +-------------+
> >>>>>>>> +-------------------------------------------------------------+
> >>>>>>>>                                                               HW
> >>>>>>>>               +---------------+          +-------------+
> >>>>>>>> +------->+ sd-modulator  +--------->+ DFSDM +-------->
> >>>>>>>> analog   +------+--------+          +-------------+ output input
> >>>>>>>> ^
> >>>>>>>>                      | vref
> >>>>>>>>                      +
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Is it the topology your are expecting ?  
> >>>>>>> It's not the one we'd expect if we are aligning with similar cases
> >>>>>>> elsewhere in IIO.  For example, if we attach an analog accelerometer
> >>>>>>> to an ADC, we report the accel channels on the accelerometer not the
> >>>>>>> ADC.  The equivalent would be to see the DFSDM as providing a
> >>>>>>> conversion service to the SD device which is actually executing the
> >>>>>>> measurement and has the input channels.
> >>>>>>>
> >>>>>>>
> >>>>>>>              scale  offset  raw
> >>>>>>>                ^      ^      ^
> >>>>>>>                |      |      |                              IIO ABI
> >>>>>>>      +-------------------------------------------------------------+
> >>>>>>>                +---------------+          +-------------+
> >>>>>>>                |sd driver      |          |DFSDM driver |
> >>>>>>>                +---------------+          +-------------+
> >>>>>>>      +-------------------------------------------------------------+
> >>>>>>>                                                                HW
> >>>>>>>                +---------------+          +-------------+
> >>>>>>>      +------->+ sd-modulator  +--------->+ DFSDM +-------->
> >>>>>>>      analog   +------+--------+          +-------------+ output
> >>>>>>>      input           ^
> >>>>>>>                       | vref  
> >>>>>>>>                      +
> >>>>>>>>           
> >>>>>> Thanks for your clarification.
> >>>>>> ok, moving to this logic is a significant change.
> >>>>>> I need to evaluate further the impact on the dfsdm driver.  
> >>>>>
> >>>>> Understood!  If we can't do it without potentially breaking users then such is life.
> >>>>>
> >>>>> Jonathan
> >>>>>         
> >>>>
> >>>> I come back to this old, but still valid topic.  
> >>>
> >>> I'd forgotten about this one, so apologies if it takes me a bit of time to
> >>> get back up to speed!
> >>>      
> >>>> You mentioned the example of analog gyroscopes in a previous message.
> >>>> Looking at gyroscope drivers, I found rcar-gyroadc driver which shows  
> >>>
> >>> Not a gyroscope driver despite the name :)  I was thinking more of the
> >>> case where we have a gyroscope that can be wired up to a bunch of different
> >>> ADCs.
> >>>      
> >>>> requirements similar to dfsdm needs:
> >>>> https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/adc/renesas%2Crcar-gyroadc.yaml
> >>>>
> >>>> rcar-gyroadc driver main characterisitics:
> >>>> - the parent device (gyroadc) is a consumer of sub devices (SPI ADCs)
> >>>> - the channels are populated from the sub devices
> >>>> - the iio device is associated to the parent device  
> >>>
> >>> I wouldn't necessarily take that as a golden example.  We were still figuring
> >>> out how this stuff would fit together.
> >>>   From what I recall (and it's been a few years) that device provides no
> >>> configuration type interfaces for the SPI ADCs - they end up having no
> >>> existence in the device model as a result.  There is no means of
> >>> sharing anything between the ways this device uses the SPI ADCs and the
> >>> way any other device does.
> >>>      
> >>>>
> >>>>
> >>>> I took the example of gyroadc to reconsider dfsdm topology and explore
> >>>> some variants according to IIO devices use.
> >>>>
> >>>> 1) current topology: one IIO device per SD modulator and one iio device
> >>>> per DFSDM filter
> >>>>        The DFSDM is used as a consumer of SD modulator through the hw
> >>>>        consumer API.
> >>>>        * cons
> >>>>            - SD modulator and DFSDM filter have their own channel
> >>>>            specification.
> >>>>            - DFSDM retrieves channels scale information from SD
> >>>>            modulator to initialized its channels
> >>>>            - SD modulator IIO sysfs interface is useless
> >>>>
> >>>> +------------+     +-------+     +---------+  sysfs
> >>>> | sd0 iiodev | --> | chan0 | --> | filter0 | ------->
> >>>> +------------+     +-------+     +---------+
> >>>>      |                                ^
> >>>>      | sysfs                          |
> >>>>      v                                |
> >>>>                                       |
> >>>>                                       |
> >>>>                                       |
> >>>> +------------+     +-------+       |
> >>>> | sd1 iiodev | --> | chan1 | ------+
> >>>> +------------+     +-------+
> >>>>      |
> >>>>      | sysfs
> >>>>      v
> >>>>
> >>>>
> >>>> 2) "conversion service" topology: one IIO device per SD modulator
> >>>>        * cons
> >>>>            - Data transfers: in this case the converted data from
> >>>>            DFSDM filter have to be sent back to SD modulator to be 	
> >>>> 	available on sysfs interface.
> >>>>            - Scan mode: this topology seems not compatible with scan
> >>>>            mode, where multiplexed channels are expected are on
> >>>> 	IIO device interface.
> >>>>     
> >>>> 	=> I don't find a proper way to address scan mode with multi SD  
> >>>> 	modulator connected to one DFSM filter  
> >>>
> >>> Good point, there isn't a means of combining the scans from multiple
> >>> IIO devices and that is what we end up having in this model.
> >>>
> >>> You can 'split' the channels so that enabling sd0 and sd1 buffered
> >>> mode will result in scans from the filter filling FIFOs for each of them
> >>> but that may not fit the use model you have in mind.
> >>>      
> >>
> >> Yes, this model may be an option when we have independent data on each
> >> channel. If we want to handle data correlated in time, things become
> >> more tricky, yet.
> >> The following presentation shows some examples of use cases for STM32
> >> DFSDM (page 20 to 24):
> >> https://st-onlinetraining.s3.amazonaws.com/STM32L4_System_Digital_Filter_for_SD_Modulators_interface_(DFSDM)/index.html
> >>
> >> Looking at 3-phase electricity meter example (page 23), the voltages
> >> from three SD modulators are captured and processed by one DFSDM filter.
> >> The mutiplexed filtered data can then be used for further processing.
> >> If we get the filtered data from three SD IIO devices, it looks
> >> difficult to guarantee time alignment between these data.  
> > 
> > We can cheat and ensure they all have the same timestamp, but I agree
> > it is less than ideal.
> >   
> >>
> >> It seems to me that the solution 2, may reduce the field of use cases
> >> that could be addressed by the DFSDM.  
> > 
> > Agreed, that's not good.
> >   
> >>  
> >>> This sort of demux is more often done for when we have a consumer in
> >>> the form of say a touchscreen that uses a couple of channels off a
> >>> general purpose ADC. We have no reason to want to ensure any alignment
> >>> between the data going to the touchscreen and that going to the
> >>> who ever is interested in the other ADC channels.
> >>>      
> >>>>
> >>>> +------------+      +-------+     +---------+
> >>>> | sd0 iiodev | <--> | chan0 | <-> | filter0 |
> >>>> +------------+      +-------+     +---------+
> >>>>      |                                 ^
> >>>>      | sysfs                           |
> >>>>      v                                 |
> >>>>                                        |
> >>>>                                        |
> >>>>                                        |
> >>>> +------------+      +-------+       |
> >>>> | sd1 iiodev | <--> | chan1 | <-----+
> >>>> +------------+      +-------+
> >>>>      |
> >>>>      | sysfs
> >>>>      v
> >>>>
> >>>>
> >>>> 3) gyroadc like topology: one iio device per DFSDM filter
> >>>> (no SD modulator iio device registered)
> >>>>        For DFSDM scale and offset, the required information are SD
> >>>>        modulator reference voltage and channel types.
> >>>>
> >>>>        voltage reference: the regulator voltage can be retrieved as it
> >>>>        is done in  gyroadc driver.
> >>>>        Maybe we can dropped merely SD modulator, and describe voltage
> >>>>        as a property of the channel (through generic channel binding)
> >>>>        This may be too restrictive if more hardware has to be
> >>>>        configured in the SD modulator, yet.  
> >>>
> >>> That is indeed the key question. Do we need to configure the modulator
> >>> devices? If we do then they need to have an existence in the device model.
> >>> Mapping them as IIO devices provides reusability across multiple
> >>> filter implementations.
> >>>      
> >>
> >> We need to be able to manage a wide range of application. So, we have to
> >> be flexible enough to configure SD modulator when necessary.
> >> I agree, that the SD device has to be kept from this point of view.
> >>  
> >>>>
> >>>>        channel type: IIO generic channel binding could be used here
> >>>>        instead of proprietary properties
> >>>>        to describe the channels
> >>>>
> >>>>        binding sample:
> >>>>        dfsdm_pdm1: filter@1 {
> >>>>            compatible = "st,stm32-dfsdm-adc";
> >>>>            reg = <1>;
> >>>>            interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> >>>>            dmas = <&dmamux1 102 0x400 0x01>;
> >>>>            dma-names = "rx";
> >>>>            st,filter-order = <1>;
> >>>>
> >>>>            channel@2 {
> >>>>                reg = <2>;
> >>>>                label = "in2";
> >>>>                st,adc-channel-types = "SPI_R";
> >>>>                st,adc-channel-clk-src = "CLKOUT_F";
> >>>>
> >>>>                sd@0 {    ?
> >>>>                    reg = <0>;
> >>>>                    compatible = "sd-mod";
> >>>>                    vref-supply = <&vref>;
> >>>>                };
> >>>>            };
> >>>>        };
> >>>>
> >>>>        * cons
> >>>>            - The sub devices are embedded in the driver and are not
> >>>>            based on general device API.
> >>>>            Alternatively, if we want to use standard device model
> >>>>            and avoid the creation of an unrelevant IIO device for
> >>>>            SD modulator, a specific type of device may be
> >>>>            provided by IIO framework. This could be a kind of
> >>>>            "backend" device without IIO sysfs interface attached.  
> >>>
> >>> That may be an option.  It was always on the list of things to do
> >>> to allow for IIO devices that have no 'IIO interface' to userspace.
> >>> The main usecase was SoC ADCs where all the channels are going to
> >>> other in kernel consumers, but it might be applicable here as well.
> >>>      
> >>
> >> Can you see another alternative to solution 2, to allow full support of
> >> DFSDM features ?  
> > 
> > Anything I can come up with also has issues.
> > A) Assume that if we have multiple channels that we want to capture together that
> >     they are going through matched modulator devices.  So make the modulator driver
> >     able to handle multiple channels.  That way we could wrap it all up together.
> > 	Cons: What if they are using different modulators but still want to capture
> > 	      the data as one scan?
> > 
> > B) Add the logic to mux devices back together (this is nasty but bear with me)
> > 
> > +--------------------+    +--------+   +-----------------+
> > | Channel interleaver|----| SD0    |---| Filter 0 iiodev |
> > |                    |    +--------+   |                 |
> > |                    |    +--------+   |                 |
> > |                    |----| SD1    |---|                 |
> > |                    |    +--------+   +-----------------+
> > +--------------------+
> > 
> > I did mention this got nasty :) It might be a useful concept in general though
> > for other usecases.
> > 
> > We introduce a new interleaver device that is a consumer of other devices that
> > are assumed to all run of the same "trigger".  It will be a consumer of
> > both modulator IIO devices and will receive data from the both.
> > It will have 2 channels which in turn will gain their scale etc by querying
> > the modulators. Those modulators will get their actual data as consumers
> > from the filter device.
> > 
> > So for buffered use the flow will be:
> > "scan" comes into the filter driver.  It demuxes and passes through to the
> > two separate modulator drivers.  Those then pass it on to the channel interleaver.
> > Given I wouldn't want to constrain the order, that driver then has to buffer
> > them up until it has a full 'scan' which it in turn pushed into it's kfifo
> > buffer for userspace consumption.
> > 
> > Other than the horrible data flow, this does match all our requirements.
> > It represents the filter and any filter specific controls as one device.
> > Each modulator has it's own representation as well and so scaling etc is
> > in an appropriate place.  The interleaver is then a software construct to
> > allow us to grab multiple data flows from independent devices (that we
> > expect to 'trigger' together) and combine them into a single flow.
> > I'm not keen on the race conditions that would probably occur, but it
> > could be made to work.
> > 
> > I've thought about doing this before to allow cases like.
> > 
> >                        Trigger
> >                          |
> > +--------------------+  +-+--------+
> > | Channel interleaver|--c-| ACCEL  |
> > |                    |  | +--------+
> > |                    |  +-+--------+
> > |                    |----| Gyro   |
> > |                    |    +--------+
> > +--------------------+
> > 
> > That is an IMU built of separate components but with a common trigger signal
> > or say a high resolution timer based trigger.   Today we have to fuse that
> > data in userspace which is rather messy.
> >   
> 
> In scan mode the DFSDM acts actually as an interleaver, so from this 
> point of view it can be put at the interleaver place in the flow. 
> Instead of a software block, we get a driver which represents a hardware 
> interleaver device. But here we come back to the initial topolgy (case 1 
> above) with the scaling problem.

I'd go with 'sort of' for it matching that topology.  I agree it's
doing the hardware job of measuring the multiple channels, but it
doesn't represent the data flow of multiple unrelated devices infront
of the dfsdm. 

It's bit clunky as an analogy but imagine this maps to.

Interleaver represents some 'physical thing' - in the example of
accel and gyro it's a physical device we are moving around.  We ultimately
want a single data stream to tell us how that is moving.
It has a bunch of properties which we are then measuring with
a gyro and an accelerometer (which generate an analog signal). Those
measurements are then in turn obtained by using an ADC.

Still, whether this actually maps usefully to what we have here isn't
totally clear to me.

> 
> I'am wondering if we cannot manage the scale a bit differently.
> In the initial proposal, the global scale was exposed at the DFSDM IIO 
> device. As we have two IIO devices serialized, the global scale could be 
> calculated at application level from both IIO devices sysfs 
> informations. The SD modulator would provide the scale (in mV unit) and 
> the DFSDM could be seen has a device giving a gain.
> 
> Currently we have:
> data = (raw-dfsdm << shift-dfsdm + offset-dfsdm) x scale-dfsdm
> where scale-dfsdm is computed from SD modulator scale info
> 
> This may be changed to:
> data = (raw-dfsdm << shift-dfsdm + offset-dfsdm) x gain-dfsdm x scale-sd
> In this case the DFSDM does not retrieve the scale from SD modulator.
> The DFSDM does not provide scale information but only a gain information
> (actual resolution / full resolution).
> May 'hardwaregain' ABI be a relevant way to describe such gain ?

Hardware gain is a bit of oddity. 

Normally hardwaregain is applied to devices where
the gain isn't on the the 'thing being measured' but on something else that
affects that measurement.  An example being the gain of the light sensor used
in a time of flight distance measurement.

However, we have used in cases where we have an amplifier that is typically
amplifying signals not actually visible to us, for example the ad8366
which I think get used as a baseband amplifier in radio applications.

                         +---------+
Some analog signal ----->|AMPLIFIER|----->  some other analog signal, not heading to an ADC.
                         +---------+
> What looks fine here, is that we remove the dependency between the DFSDM 
> and the SD modulator, and each IIO device expose consistent sysfs 
> informations regarding their actual hardware scope.
> 
> Does this approach seems valid to you ?

Loosing the dependency removes an obvious way for generic software to
actually understand what is going on. That software just wants to measure
an analog signal, not figure out the wiring diagram of the components in
the path.

> 
> >>
> >> If 'backend' option turns out to be the most appropriated to match DFSDM
> >> constraints, I can prepare some patches to support it.
> >> Would you have some guidelines or requirements for the implementation of
> >> such feature, in this case ?  
> > 
> > Closest example is that rcar-gyroadc but in this case we'd want to define
> > something standard to support the modulators so that if we have other filters
> > in future we can reuse them.
> > 
> > That means implementing them as child devices of the filter - probably put
> > the on the IIO bus, but as different device type.  Take a look at how
> > triggers are done in industrialio-trigger.c
> > You need struct device_type sd_modulator
> > and a suitable device struct (burred in an iio_sd_modulator struct probably).
> > 
> > Also needed would be a bunch of standard callbacks to allow you to query things
> > like scaling.   Keep that interface simple. Until we have a lot of modulator
> > drivers it will be hard to know exactly what is needed.  Also whilst we don't
> > have many it is easy to modify the interface.
> > 
> > Then have your filter driver walk it's own dt children and instantiate
> > appropriate new elements and register them on the iio_bus.  They will have
> > the filter as their parent.
> > 
> > There are various examples of this sort of thing in tree.
> > If you want a good one, drivers/cxl does a lot of this sort magic to manage
> > a fairly complex graph of devices including some nice registration stuff to
> > cause the correct device drivers to load automatically.
> > 
> > Hmm.  Thinking more on this, there is an ordering issue for driver load.
> > Instead of making the modulator nodes children of the modulator, you may need
> > to give them their own existence and use a phandle to reference them.
> > That will let you defer probe in the filter driver until those
> > modulator drivers are ready.
> > 
> > This isn't going to be particularly simple, so you may want to have a look
> > at how various other subsystems do similar things and mock up the dependencies
> > to make sure you have something that doesn't end up with a loop of dependencies.
> > In some ways the modulators are on a bus below the filter, but the filter driver
> > needs them to be in place to do the rest.
> > You may end up with some sort of delayed load.
> > 1. Initial filter driver load + parsing of the modulator dt children (if done that way).
> > 2. Filter driver goes to sleep until...
> > 3. Modulator drivers call something on the filter driver to say they are ready.
> > 4. Filter driver finishes loading and create the IIO device etc.
> > You'll need some reference counting etc in there to make removal safe etc but it
> > shouldn't be 'too bad'.
> > 
> > Good luck!
> > 
> > Jonathan
> >   
> 
> The device hierachy you have detailled above, is probably the most 
> flexible one to address a wide range of use cases, but it is quite a 
> huge work ... especially in comparison to current need.

Understood.  Maybe its something we can evolve towards over time.
I'd like to say I'll get time sometime in the near future to put a prototype
together but sadly I have too many other things on the todo list to commit
to anything.

Jonathan

> Thanks anyway for all the hints you gave here.

No problem.  These stm32 parts manage to continue pushing the boundaries
of our rather simplified model of how the world works!

Jonathan

> 
> Regards
> Olivier
> > 
> >   
> >>
> >> Regards
> >> Olivier
> >>  
> >>>>     
> >>>>        => This solution could be applicable but some details in the  
> >>>>        implementation will have to be clarified further.
> >>>>        May we consider adding a "backend" device without IIO interface
> >>>>        in the IIO framework ?
> >>>>        May the SD modulator be dropped ?
> >>>>
> >>>> +-----+     +-------+     +----------------+  sysfs
> >>>> | sd0 | --> | chan0 | --> | filter0 iiodev | ------->
> >>>> +-----+     +-------+     +----------------+
> >>>>                                ^
> >>>>                                |
> >>>>                                |
> >>>> +-----+     +-------+       |
> >>>> | sd1 | --> | chan1 | ------+
> >>>> +-----+     +-------+
> >>>>
> >>>>
> >>>> Here there is a point that needs to be clarified in relation to the
> >>>> previous discussions I think.
> >>>> If I refer to the last comment of the current thread, I understand that
> >>>> you were expecting the IIO sysfs interface to be attached to the SD
> >>>> modulator. (solution 2)  
> >>>
> >>> Yes.
> >>>      
> >>>> For the gyroadc, the channels are indeed populated by the sub devices.
> >>>> However the IIO device corresponds to the ADC consumer and not the ADCs
> >>>> themselves. (solution 3)  
> >>>
> >>> That one is a rather odd case because no generic handling is possible
> >>> of the ADCs. For example it doesn't use the ad7476 driver because we can't
> >>> talk to the device even though it's the same ADC as the ad7476 driver supports.
> >>>      
> >>>>
> >>>> What is the the preferred approach for you ?  
> >>>
> >>> I still favour solution 2, but if you need to have the channels cleanly
> >>> presented in a scan despite them coming from different modulators, then that
> >>> solution may not be sufficient and we need to think about how else to do
> >>> things.
> >>>
> >>> Jonathan
> >>>      
> >>>>
> >>>> Thanks for your feedback
> >>>> Best regards
> >>>> Olivier
> >>>>
> >>>>     
> >>>>>>
> >>>>>> Regards
> >>>>>> Olivier  
> >>>>>>>> If not, I probably missedsomething. Could you please clarify this point ?
> >>>>>>>>
> >>>>>>>> Regards
> >>>>>>>> Olivier  
> >>>>>>>>> This wasn't really an issue when the only values available were
> >>>>>>>>> raw, but if we are adding scale and offset, they are things that
> >>>>>>>>> belong to the ad1201 for example, not the upstream stm32-dfsdm unit.
> >>>>>>>>>
> >>>>>>>>> Thinking of it another way, we don't report an SPI ADC output in
> >>>>>>>>> the driver for the SPI master.
> >>>>>>>>>
> >>>>>>>>> Could we flip it around without breaking anything?
> >>>>>>>>>
> >>>>>>>>> Jonathan
> >>>>>>>>>              
> >>>>>>>>>> ---
> >>>>>>>>>>       drivers/iio/adc/stm32-dfsdm-adc.c | 105 +++++++++++++++++++++++++++++-
> >>>>>>>>>>       1 file changed, 102 insertions(+), 3 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c
> >>>>>>>>>> b/drivers/iio/adc/stm32-dfsdm-adc.c
> >>>>>>>>>> index 07b9dfdf8e76..b85fd3e90496 100644
> >>>>>>>>>> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> >>>>>>>>>> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> >>>>>>>>>> @@ -10,6 +10,7 @@
> >>>>>>>>>>       #include <linux/dma-mapping.h>
> >>>>>>>>>>       #include <linux/iio/adc/stm32-dfsdm-adc.h>
> >>>>>>>>>>       #include <linux/iio/buffer.h>
> >>>>>>>>>> +#include <linux/iio/consumer.h>
> >>>>>>>>>>       #include <linux/iio/hw-consumer.h>
> >>>>>>>>>>       #include <linux/iio/sysfs.h>
> >>>>>>>>>>       #include <linux/iio/timer/stm32-lptim-trigger.h>
> >>>>>>>>>> @@ -67,6 +68,13 @@ struct stm32_dfsdm_dev_data {
> >>>>>>>>>>       	const struct regmap_config *regmap_cfg;
> >>>>>>>>>>       };
> >>>>>>>>>>       
> >>>>>>>>>> +struct stm32_dfsdm_sd_chan_info {
> >>>>>>>>>> +	int scale_val;
> >>>>>>>>>> +	int scale_val2;
> >>>>>>>>>> +	int offset;
> >>>>>>>>>> +	unsigned int differential;
> >>>>>>>>>> +};
> >>>>>>>>>> +
> >>>>>>>>>>       struct stm32_dfsdm_adc {
> >>>>>>>>>>       	struct stm32_dfsdm *dfsdm;
> >>>>>>>>>>       	const struct stm32_dfsdm_dev_data *dev_data; @@ -79,6 +87,7
> >>>>>>>>>> @@ struct stm32_dfsdm_adc {
> >>>>>>>>>>       	struct iio_hw_consumer *hwc;
> >>>>>>>>>>       	struct completion completion;
> >>>>>>>>>>       	u32 *buffer;
> >>>>>>>>>> +	struct stm32_dfsdm_sd_chan_info *sd_chan;
> >>>>>>>>>>       
> >>>>>>>>>>       	/* Audio specific */
> >>>>>>>>>>       	unsigned int spi_freq;  /* SPI bus clock frequency */ @@
> >>>>>>>>>> -1271,7 +1280,10 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
> >>>>>>>>>>       				int *val2, long mask)
> >>>>>>>>>>       {
> >>>>>>>>>>       	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> >>>>>>>>>> -	int ret;
> >>>>>>>>>> +	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
> >>>>>>>>>> +	struct stm32_dfsdm_filter_osr *flo = &fl->flo[fl->fast];
> >>>>>>>>>> +	u32 max = flo->max << (flo->lshift - chan->scan_type.shift);
> >>>>>>>>>> +	int ret, idx = chan->scan_index;
> >>>>>>>>>>       
> >>>>>>>>>>       	switch (mask) {
> >>>>>>>>>>       	case IIO_CHAN_INFO_RAW:
> >>>>>>>>>> @@ -1307,6 +1319,41 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
> >>>>>>>>>>       		*val = adc->sample_freq;
> >>>>>>>>>>       
> >>>>>>>>>>       		return IIO_VAL_INT;
> >>>>>>>>>> +
> >>>>>>>>>> +	case IIO_CHAN_INFO_SCALE:
> >>>>>>>>>> +		/*
> >>>>>>>>>> +		 * Scale is expressed in mV.
> >>>>>>>>>> +		 * When fast mode is disabled, actual resolution may be lower
> >>>>>>>>>> +		 * than 2^n, where n=realbits-1.
> >>>>>>>>>> +		 * This leads to underestimating input voltage. To
> >>>>>>>>>> +		 * compensate this deviation, the voltage reference can be
> >>>>>>>>>> +		 * corrected with a factor = realbits resolution / actual max
> >>>>>>>>>> +		 */
> >>>>>>>>>> +		*val = div_u64((u64)adc->sd_chan[idx].scale_val *
> >>>>>>>>>> +			       (u64)BIT(DFSDM_DATA_RES - 1), max);
> >>>>>>>>>> +		*val2 = chan->scan_type.realbits;
> >>>>>>>>>> +		if (adc->sd_chan[idx].differential)
> >>>>>>>>>> +			*val *= 2;
> >>>>>>>>>> +
> >>>>>>>>>> +		return IIO_VAL_FRACTIONAL_LOG2;
> >>>>>>>>>> +
> >>>>>>>>>> +	case IIO_CHAN_INFO_OFFSET:
> >>>>>>>>>> +		/*
> >>>>>>>>>> +		 * DFSDM output data are in the range [-2^n,2^n-1],
> >>>>>>>>>> +		 * with n=realbits-1.
> >>>>>>>>>> +		 * - Differential modulator:
> >>>>>>>>>> +		 * Offset correspond to SD modulator offset.
> >>>>>>>>>> +		 * - Single ended modulator:
> >>>>>>>>>> +		 * Input is in [0V,Vref] range, where 0V corresponds to -2^n.
> >>>>>>>>>> +		 * Add 2^n to offset. (i.e. middle of input range)
> >>>>>>>>>> +		 * offset = offset(sd) * vref / res(sd) * max / vref.
> >>>>>>>>>> +		 */
> >>>>>>>>>> +		*val = div_u64((u64)max * adc->sd_chan[idx].offset,
> >>>>>>>>>> +			       BIT(adc->sd_chan[idx].scale_val2 - 1));
> >>>>>>>>>> +		if (!adc->sd_chan[idx].differential)
> >>>>>>>>>> +			*val += max;
> >>>>>>>>>> +
> >>>>>>>>>> +		return IIO_VAL_INT;
> >>>>>>>>>>       	}
> >>>>>>>>>>       
> >>>>>>>>>>       	return -EINVAL;
> >>>>>>>>>> @@ -1430,7 +1477,9 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
> >>>>>>>>>>       	 * IIO_CHAN_INFO_RAW: used to compute regular conversion
> >>>>>>>>>>       	 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used to set oversampling
> >>>>>>>>>>       	 */
> >>>>>>>>>> -	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> >>>>>>>>>> +	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >>>>>>>>>> +				 BIT(IIO_CHAN_INFO_SCALE) |
> >>>>>>>>>> +				 BIT(IIO_CHAN_INFO_OFFSET);
> >>>>>>>>>>       	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> >>>>>>>>>>       					BIT(IIO_CHAN_INFO_SAMP_FREQ);
> >>>>>>>>>>       
> >>>>>>>>>> @@ -1481,8 +1530,10 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
> >>>>>>>>>>       {
> >>>>>>>>>>       	struct iio_chan_spec *ch;
> >>>>>>>>>>       	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> >>>>>>>>>> +	struct iio_channel *channels, *chan;
> >>>>>>>>>> +	struct stm32_dfsdm_sd_chan_info *sd_chan;
> >>>>>>>>>>       	int num_ch;
> >>>>>>>>>> -	int ret, chan_idx;
> >>>>>>>>>> +	int ret, chan_idx, val2;
> >>>>>>>>>>       
> >>>>>>>>>>       	adc->oversamp = DFSDM_DEFAULT_OVERSAMPLING;
> >>>>>>>>>>       	ret = stm32_dfsdm_compute_all_osrs(indio_dev, adc->oversamp);
> >>>>>>>>>> @@ -1506,6 +1557,22 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
> >>>>>>>>>>       	if (!ch)
> >>>>>>>>>>       		return -ENOMEM;
> >>>>>>>>>>       
> >>>>>>>>>> +	/* Get SD modulator channels */
> >>>>>>>>>> +	channels = iio_channel_get_all(&indio_dev->dev);
> >>>>>>>>>> +	if (IS_ERR(channels)) {
> >>>>>>>>>> +		dev_err(&indio_dev->dev, "Failed to get channel %ld\n",
> >>>>>>>>>> +			PTR_ERR(channels));
> >>>>>>>>>> +		return PTR_ERR(channels);
> >>>>>>>>>> +	}
> >>>>>>>>>> +	chan = &channels[0];
> >>>>>>>>>> +
> >>>>>>>>>> +	adc->sd_chan = devm_kzalloc(&indio_dev->dev,
> >>>>>>>>>> +				    sizeof(*adc->sd_chan) * num_ch, GFP_KERNEL);
> >>>>>>>>>> +	if (!adc->sd_chan)
> >>>>>>>>>> +		return -ENOMEM;
> >>>>>>>>>> +
> >>>>>>>>>> +	sd_chan = adc->sd_chan;
> >>>>>>>>>> +
> >>>>>>>>>>       	for (chan_idx = 0; chan_idx < num_ch; chan_idx++) {
> >>>>>>>>>>       		ch[chan_idx].scan_index = chan_idx;
> >>>>>>>>>>       		ret = stm32_dfsdm_adc_chan_init_one(indio_dev,
> >>>>>>>>>> &ch[chan_idx]); @@ -1513,6 +1580,38 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
> >>>>>>>>>>       			dev_err(&indio_dev->dev, "Channels init failed\n");
> >>>>>>>>>>       			return ret;
> >>>>>>>>>>       		}
> >>>>>>>>>> +
> >>>>>>>>>> +		if (!chan->indio_dev)
> >>>>>>>>>> +			return -EINVAL;
> >>>>>>>>>> +
> >>>>>>>>>> +		ret = iio_read_channel_scale(chan, &sd_chan->scale_val,
> >>>>>>>>>> +					     &sd_chan->scale_val2);
> >>>>>>>>>> +		if (ret < 0) {
> >>>>>>>>>> +			dev_err(&indio_dev->dev,
> >>>>>>>>>> +				"Failed to get channel %d scale\n", chan_idx);
> >>>>>>>>>> +			return ret;
> >>>>>>>>>> +		}
> >>>>>>>>>> +
> >>>>>>>>>> +		if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_OFFSET)) {
> >>>>>>>>>> +			ret = iio_read_channel_offset(chan, &sd_chan->offset,
> >>>>>>>>>> +						      &val2);
> >>>>>>>>>> +			if (ret < 0) {
> >>>>>>>>>> +				dev_err(&indio_dev->dev,
> >>>>>>>>>> +					"Failed to get channel %d offset\n",
> >>>>>>>>>> +					chan_idx);
> >>>>>>>>>> +				return ret;
> >>>>>>>>>> +			}
> >>>>>>>>>> +		}
> >>>>>>>>>> +
> >>>>>>>>>> +		sd_chan->differential = chan->channel->differential;
> >>>>>>>>>> +
> >>>>>>>>>> +		dev_dbg(&indio_dev->dev, "Channel %d %s scale ref=%d offset=%d",
> >>>>>>>>>> +			chan_idx, chan->channel->differential ?
> >>>>>>>>>> +			"differential" : "single-ended",
> >>>>>>>>>> +			sd_chan->scale_val, sd_chan->offset);
> >>>>>>>>>> +
> >>>>>>>>>> +		chan++;
> >>>>>>>>>> +		sd_chan++;
> >>>>>>>>>>       	}
> >>>>>>>>>>       
> >>>>>>>>>>       	indio_dev->num_channels = num_ch;  
> >>>      
> >   


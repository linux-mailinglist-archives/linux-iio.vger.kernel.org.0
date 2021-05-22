Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D596C38D707
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 20:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhEVSri convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 22 May 2021 14:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231252AbhEVSrh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 May 2021 14:47:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 105F361182;
        Sat, 22 May 2021 18:46:06 +0000 (UTC)
Date:   Sat, 22 May 2021 19:47:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?SsOzenNlZiBIb3J2w6F0aA==?= <info@ministro.hu>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Gene Chen <gene_chen@richtek.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: driver for texas instruments ads7142
Message-ID: <20210522194729.3221998e@jic23-huawei>
In-Reply-To: <20210519165045.GA3176@dev>
References: <9f9c64ca70f80d8a024ea66e3963350e35f27c1d.1621105931.git.info@ministro.hu>
        <20210516122840.22cab9b5@jic23-huawei>
        <20210516190751.GB16211@dev>
        <20210517102804.00002ff8@Huawei.com>
        <20210519165045.GA3176@dev>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 May 2021 16:50:46 +0000
József Horváth <info@ministro.hu> wrote:

> On Mon, May 17, 2021 at 10:28:04AM +0100, Jonathan Cameron wrote:
> > On Sun, 16 May 2021 19:07:55 +0000
> > József Horváth <info@ministro.hu> wrote:
> >   
> > > On Sun, May 16, 2021 at 12:28:40PM +0100, Jonathan Cameron wrote:  
> > > > On Sun, 16 May 2021 07:30:35 +0000
> > > > Jozsef Horvath <info@ministro.hu> wrote:
> > > >     
> > > > > This is an iio driver for
> > > > >  Texas Instruments ADS7142 dual-channel, programmable sensor monitor.    
> > > > 
> > > > Hi,
> > > > 
> > > > Note I review in reverse, so it's possible my comments will make more
> > > > sense read in that direction!
> > > > 
> > > > Various comments inline, but mostly this seems to be coming together nicely!
> > > > 
> > > > Jonathan    
> > > > > 
> > > > > All of the data buffer modes, supported by the device are selectable
> > > > >  over sysfs:
> > > > >   /sys/bus/iio/devices/iio:deviceX/buffer_mode
> > > > > 
> > > > > Data buffer operation modes:
> > > > >   - start_burst:    
> > > > 
> > > > I'd like to see a lot of this info in the ABI docs.  Not the internals
> > > > part but the 'what needs to be configured' element.
> > > > 
> > > > Some of the flow related stuff should go in the driver itself.
> > > > It's non obvious and no one reads patch descriptions after the code has
> > > > merged! 
> > > >     
> > > 
> > > Ok, I'll write a more detailed description with configuration
> > >  requirements
> > >   
> > > >     
> > > > >     In triggered buffer preenable hook: not relevant.
> > > > >     In trigger handler: the driver selects the autonomous monitoring
> > > > >       (see chapter 7.4.3 in datasheet) operation mode,
> > > > > 	  configures the channels in sequencer as specified by
> > > > >       sysfs(scan_elements/in_voltageY_en),
> > > > > 	  sets the data buffer mode to "Start Burst Mode",
> > > > >       then starts the conversion.
> > > > >     In irq handler: the driver pushes the conversion results received
> > > > >       from the device to the buffer,
> > > > >       then restarts the conversion like in trigger handler.
> > > > >     Both IRQ and trigger are required to support this mode.
> > > > >     See chapter 7.4.3.2.1 "Autonomous Mode with Start Burst"
> > > > >     in datasheet.    
> > > >     
> > > > >   - stop_burst:
> > > > >     In triggered buffer preenable hook: the driver selects the
> > > > >       autonomous monitoring (see chapter 7.4.3 in datasheet)
> > > > >       operation mode,
> > > > >       configures the channels in sequencer as
> > > > >       specified by sysfs(scan_elements/in_voltageY_en),
> > > > > 	  sets the data buffer mode to "Stop Burst Mode",
> > > > >       then starts the conversion.
> > > > >     In trigger handler: the driver pushes the conversion results received
> > > > >       from the device to the buffer,
> > > > > 	  then restarts the conversion like in preenable hook.
> > > > >     In irq handler: not relevant.
> > > > >     Trigger is required to support this mode.
> > > > >     See chapter 7.4.3.2.2 "Autonomous Mode with Stop Burst"
> > > > >     in datasheet.    
> > > >     
> > > > >   - pre_alert:
> > > > >     In triggered buffer preenable hook: the driver selects the autonomous
> > > > >       monitoring (see chapter 7.4.3 in datasheet) operation mode,
> > > > >       configures the channels in sequencer
> > > > >         as specified by sysfs(scan_elements/in_voltageY_en),
> > > > >       configures the digital window comparator and alert flags,
> > > > > 	  sets the data buffer mode to "Pre Alert Data Mode",
> > > > >       then starts the conversion.
> > > > >     In trigger handler: not relevant.
> > > > >     In irq handler: the driver pushes the conversion results received
> > > > >       from the device to the buffer,
> > > > >       then restarts the conversion like in preenable hook.
> > > > >     IRQ is required to support this mode.
> > > > >     See chapter 7.4.3.1.1 "Autonomous Mode with Pre Alert Data"
> > > > >     in datasheet
> > > > >   - post_alert:
> > > > >     The operations are same like in pre_alert mode,
> > > > >       except the data buffer mode selection, the selected mode is
> > > > >       "Post Alert Data Mode".
> > > > >     See chapter 7.4.3.1.2 "Autonomous Mode with Post Alert Data"
> > > > >     in datasheet    
> > > > 
> > > > Impressive you got all these to work reasonably cleanly.  My only
> > > > remaining question on this stuff is whether we can do anything that
> > > > looks 'more standard' to enable the use of these with general purpose
> > > > code.
> > > > 
> > > > The last two could be implemented as a trigger, be it one that can only
> > > > be used by this device.  So you would select the mode by picking the
> > > > relevant trigger.
> > > > 
> > > > However I can't see any similar way of supporting the start and stop burst
> > > > modes. So for now at least perhaps this is the best we can do (and it
> > > > won't be too painful to support this as a legacy interface if we do later
> > > > figure out a nice generic interface).
> > > > 
> > > > 
> > > > I would like to think longer term about whether we can come up with
> > > > some standard ABI for these 'burst' capture devices. We have another one
> > > > in staging (adis16240) that has been there a long time as we never
> > > > managed to make progress on the interface.
> > > > 
> > > > Looking briefly at that device, I do note that it supports somewhere
> > > > between your pre_alert and post_alert (X samples before event, so
> > > > many samples after).  Maybe we want to think about an alert mode
> > > > and use a separate control to set the 'where' part relative to
> > > > the alert mode?
> > > > 
> > > > It is hard to define general ABI with 2 devices however, so perhaps
> > > > we should stick with what you have and can always add an "alert"
> > > > buffer mode as needed for a new device. 
> > > >     
> > > 
> > > I think we can say that, all of general purpose ADCs, pressure, light, accel etc.
> > >  sensors supports "virtual" start_burst mode with at least 1 element FIFO per channel.
> > >  Flow:
> > >   1. in trigger, the host issues a start conversion request to device,
> > >      then polls or "wait" IRQ/conv rdy signal
> > >   2. device do the job, then report the state of end of operation, somehow...
> > >   3. the completion handler moves the conversion result to buffer
> > > 
> > >  Here is some device with real start_burst like support (not complete list):
> > >   accel/adxl345
> > >     datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
> > >     see: Table 22. FIFO Mode: FIFO collects up to 32 values...
> > >   accel/bmc150-accel
> > >     datasheet: https://hu.mouser.com/datasheet/2/783/BST-BMC150-DS000-1509560.pdf
> > >     see: 5.1 FIFO Operating Modes: FIFO Mode
> > >     note: obsolate
> > >   accel/bmi088-accel
> > >     datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
> > >     see: 4.9.1 FIFO operating modes: FIFO or stop-at-full mode
> > >   gyro/bmg160
> > >     datasheet: https://hu.mouser.com/datasheet/2/783/BST-BMG160-DS000-1509613.pdf
> > >     see: 5.1 FIFO Operating Modes: FIFO Mode
> > >     note: obsolete
> > >   health/max30100
> > >     datasheet: https://datasheets.maximintegrated.com/en/ds/MAX30100.pdf
> > >     see: FIFO (0x02–0x05)
> > >     note: this mode is very close to start_burst mode of ti-ads7141
> > > 
> > >  The current generalized triggered_buffer API covers this mode completely.  
> > 
> > Not quite.  The triggered buffer API covers the one scan mode only (fifo depth 1).
> > It doesn't in general cover using a trigger to start fifo capture.  We have talked about
> > adding this layered trigger approach before (conceptually it is one trigger starting
> > a hardware trigger that we can't see), but not done it yet.  The reason
> > for this restriction is that most triggers can also be used to drive additional
> > sensors (so capture from N devices at roughly the same time + at the same
> > frequency).  We do have a few devices which provide their own triggers limited
> > to local use as a means of selecting modes like this (often complex ADCs like
> > the stm32 ones where a bunch of other signals in the SoC can be used to
> > autonomously start capture of a scan).
> > 
> > Mostly the fifo mode on the above devices is implemented without a trigger.
> > Triggers being attached makes them fall back into a 1 entry fifo so it is
> > one trigger per scan.
> > 
> > It might be possible to safely adapt the semantics of this mode to support
> > such capture using existing interfaces, but we need to be very careful not
> > to break existing ABI assumptions.
> >  
> 
> It's clear now, for me.
> The problem we are facing is how can we represent a more than one element FIFO
>  scan collection, we can call this "capture".
> You are right, the industrialio-buffer is not covers this requirement, we dontt
>  know, where the received scan line came from.

Do we need to know that?  Normally if we have scan's triggered from different
sources they should be in different buffers.

> The "item" definition in the capture context:
>  One item in the capture is one or multiple lines of scans.
> 
> This problem is very similar to capturing images from a video device.
> The solution what I'm thinking for, is close to videobuf2 queued buffer
>  mechanism(videobuf2-v4l2.c).

Somewhat similar indeed, though with potential for variable sized frames (taking
the analogy too far perhaps).

> 
> I think this kind of operation and the required configuration can be managed via sysfs,
>  but there is some useful IOCTL's for video buffer configuration/allocation
>  (VIDIOC_QBUF, VIDIOC_DQBUF), and pointer exchange between user and system
>  is faster and better for the high speed capture devices than copying from kernel to user,
>  and we can define/make similar IOCTL's over iio char device.

A bunch of drivers already do this, but not with an explicit trigger, except in the
case of stm32 where IIRC we have triggers that in turn allow other triggers to be
set for them (so chaining of triggers).  Also, the dma buffer system works entirely
on this basis (but again, is not normally associated with a trigger because there
is no advantage in exposing that signal to userspace).

So I think the only small addition we need here is to define an interface that makes
it clear the trigger is starting a "batch" of scans rather than just a single scan.

Perhaps have a current_batch_trigger sysfs attribute or something like that?


> 
> The new ABI name could be: industrialio-capture.
> 
> > > 
> > > Some of sensors under iio supports stop_burst mode with FIFO.
> > >  Flow could be:
> > >   1. in somewhere(probably buffer_{pre,post} enable), the host configures the FIFO
> > >      then starts conversion
> > >   2. in trigger, the host reads FIFO content,
> > >      then push the result to buffer,
> > >      then restart the conversion or not, it depends of application/device etc.
> > > 
> > >  Here is some device with stop_burst like support (not complete list):
> > >   accel/adxl345
> > >     datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
> > >     see: Table 22. Stream Mode: FIFO holds the last 32 data values...
> > >   accel/bmc150-accel
> > >     datasheet: https://hu.mouser.com/datasheet/2/783/BST-BMC150-DS000-1509560.pdf
> > >     see: 5.1 FIFO Operating Modes: Stream Mode
> > >     note: obsolate
> > >   accel/bmi088-accel
> > >     datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
> > >     see: 4.9.1 FIFO operating modes: STREAM mode
> > >   gyro/bmg160
> > >     datasheet: https://hu.mouser.com/datasheet/2/783/BST-BMG160-DS000-1509613.pdf
> > >     see: 5.1 FIFO Operating Modes: STREAM mode
> > >     note: obsolete  
> > 
> > Agreed this could be done, though I'm not convinced it makes that much sense.  The main
> > operating mode for these sensors in that mode is likely to be using a fifo watermark
> > - the aim being to never drop data.  The biggest exception to this would be very high
> > speed devices where there is no hope of reading the data out without dropping, so
> > you are looking for a very high frequency dataset of a short time period.
> > 
> > So could do it, but I'm not sure many driver authors would implement it.
> > 
> > From a proposal point of view, you are suggesting implementing in the drivers anyway
> > so we can definitely support it for devices that care.
> >   
> > > 
> > > Some of sensors under iio supports {pre,post}_alert or we can call near_{event,trigger}
> > >   or {before,after,around}_{event,trigger} with FIFO.
> > >  Flow could be:
> > >   1. in configure_fifo hook(see below), the host configures the device FIFO mode/size
> > >   2. in {pre,post}enable hook, the host starts conversion
> > >   3. in IRQ handler, the host reads FIFO content,
> > >      then push the result to buffer, and reports events to user,
> > >      then restart the conversion or not, it depends of application/device etc.
> > > 
> > >  Here is some device (not complete list):
> > >   accel/adxl345
> > >     datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
> > >     see: Table 22. Trigger Mode: When triggered by the trigger bit...
> > >     note: as I understand the datasheet, this mode can be pre or post alert too,
> > >      it depends of the value of FIFO_CTL[4:0](Samples Bits)
> > >   staging/accel/adis16240
> > >   adc/ti-ads7142
> > > 
> > > Overall, not only 2 devices, but many devices are affected under iio,
> > >  and I think in addition to "buffer_mode", the FIFO configuration should
> > >  also be included this ABI. And here, I think, the fifo_mode is a better name than buffer_mode.
> > > 
> > > Here is my suggestion:
> > > 
> > > This should be configured with buffered mode.
> > > 
> > > enum iio_chan_info_enum {
> > > ...
> > > 	IIO_CHAN_INFO_CALIBAMBIENT,
> > > +	IIO_CHAN_INFO_FIFOSIZE,
> > > };
> > > 
> > > IIO_CHAN_INFO_FIFOSIZE: a new sysfs entry comes up under /sys/bus/iio/devices/iio:deviceX/
> > >  with "fifosize" postfix. This will be per device property mostly.  
> > 
> > Add this to the hwfifo_ attributes that are already defined. 
> > This is going to be per buffer rather than per channel so should
> > be something like bufferX/hwfifo_length 
> > 
> >   
> > > 
> > > +enum iio_fifo_mode {
> > > +	IIO_FIFO_MODE_START_BURST,
> > > +	IIO_FIFO_MODE_STOP_BURST,
> > > +	IIO_FIFO_MODE_BEFORE_EVENT,
> > > +	IIO_FIFO_MODE_AFTER_EVENT,
> > > +	IIO_FIFO_MODE_AROUND_EVENT,
> > > +};  
> > 
> > Can we collapse the 3 event cases to
> > IIO_FIFO_MODE_EVENT then
> > provide separate controls around 
> > hfifo_event_prescans
> > hfifo_event_postscans
> > (not sure on that naming!)
> > and use normal rules that any IIO write may effect other attributes
> > + _available attributes to specify what range these can take.
> > 
> > Obviously would make the internals of drivers a little more complex
> > but would avoid an odd corner case where a device supports a fully
> > flexible AROUND_EVENT that can also == BEFORE_EVENT or AFTER_EVENT
> > depending on the settings.
> >   
> > > 
> > > struct iio_buffer_setup_ops {
> > > 	int (*preenable)(struct iio_dev *);
> > > 	int (*postenable)(struct iio_dev *);
> > > 	int (*predisable)(struct iio_dev *);
> > > 	int (*postdisable)(struct iio_dev *);
> > > 	bool (*validate_scan_mask)(struct iio_dev *indio_dev,
> > > 				   const unsigned long *scan_mask);
> > > +	int fifo_mode_mask;
> > > +	int (*configure_fifo)(struct iio_dev*);
> > > };
> > > 
> > > If the device supports any of iio_fifo_mode, it can be configured with fifo_mode_mask.
> > > If fifo_mode_mask have any flags, two new sysfs entry comes up
> > >  /sys/bus/iio/devices/iio:deviceX/buffer/fifo_mode
> > >  /sys/bus/iio/devices/iio:deviceX/buffer/fifo_mode_available  
> > 
> > bufferY/hwfifo_mode* but otherwise agreed..
> >   
> > > I dont think, different fifo modes will be configurable by channel in the future,
> > >  but in that case, fifo_mode_mask_separate, etc can be added.  
> > 
> > No chance of it by definition.  A buffer is a set of scans run together, if
> > individual channels can have different options for this, they are in different
> > buffers.
> >   
> > > 
> > > The new configure_fifo hook could be called before preenable hook.  
> > 
> > Hmm. Maybe, or perhaps for now we leave it as a job for preenable/postenable
> > and see how a number of drivers end up looking.  I'm not 100% sure we need
> > an additional callback for this.   There is a reasonable argument
> > we should think about pulling the sysfs stuff for hwfifo_ setup
> > into the core, but there is no rush to do that either.
> >   
> > > 
> > > I think this can cover the requirements for a while.  
> > 
> > Nice explanation and I agree it should work.
> > 
> >   
> > >   
> > > >     
> > > > > 
> > > > > The in_voltageY_raw can be used, if the buffering mode is not enabled
> > > > >  in sysfs(buffer/enable).
> > > > >  The driver initiates a single conversion in the device for each
> > > > >  read request(in_voltageY_raw).
> > > > >  This is a one-shot conversion.
> > > > >  See chapter 7.4.2.2 "Manual Mode with AUTO Sequence" in datasheet.
> > > > > 
> > > > > Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
> > > > > 
> > > > > Signed-off-by: Jozsef Horvath <info@ministro.hu>    
> > > >     
> > > > > ---
> > > > > 
> > > > > changes v1
> > > > >   - All of the buffer opertaion modes
> > > > >     (pre_alert, post_alert, start_burst, stop_burst)
> > > > > 	are added
> > > > >   - Added triggered buffer
> > > > >   - Added buffer operation mode selection sysfs support
> > > > >   - Redundant parameters (ti,threshold-rising, etc.)
> > > > >     are removed
> > > > >   - Supply name changed(vref -> avdd)
> > > > >   - Added dvdd supply
> > > > >   - Added device sampling rate calculation
> > > > >   - Use device-managed functions for regulator, iio device register
> > > > >     and triggered buffer
> > > > > 
> > > > > changes v2
> > > > >   - Unreachable statements removed
> > > > >   - ti_ads7142_buffered_setup_and_start returns without error when
> > > > >     pre/post alert mode is selected, but no thresh_{rising/falling}
> > > > >     enabled on any channel. Fixed with return -EINVAL in the case above.
> > > > >   - Stylistical changes
> > > > >   - devm_regulator_get return value error/NULL handling.
> > > > >   - "ti,prealert-count" parameter added, just for completeness.
> > > > > ---
> > > > >  .../ABI/testing/sysfs-bus-iio-adc-ti-ads7142  |   11 +
> > > > >  MAINTAINERS                                   |    7 +
> > > > >  drivers/iio/adc/Kconfig                       |   13 +
> > > > >  drivers/iio/adc/Makefile                      |    1 +
> > > > >  drivers/iio/adc/ti-ads7142.c                  | 1461 +++++++++++++++++
> > > > >  5 files changed, 1493 insertions(+)
> > > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ads7142
> > > > >  create mode 100644 drivers/iio/adc/ti-ads7142.c
> > > > > 
> > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ads7142 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ads7142
> > > > > new file mode 100644
> > > > > index 000000000000..485017235f4a
> > > > > --- /dev/null
> > > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ads7142
> > > > > @@ -0,0 +1,11 @@
> > > > > +What:		/sys/bus/iio/devices/iio:deviceX/buffer_mode_available
> > > > > +Date:		May 2021
> > > > > +KernelVersion:	5.13
> > > > > +Contact:	info@ministro.hu
> > > > > +Description: 	List all available buffer_mode settings.    
> > > > 
> > > > List them out with detailed explanation of what each one does + how it interacts
> > > > with the trigger etc.
> > > >     
> > > 
> > > Ok, I'll do that.
> > >   
> > > > > +
> > > > > +What:		/sys/bus/iio/devices/iio:deviceX/buffer_mode
> > > > > +Date:		May 2021
> > > > > +KernelVersion:	5.13
> > > > > +Contact:	info@ministro.hu
> > > > > +Description: 	Sets up the device data buffer mode.  
> > 
> > ...
> >   
> > > > > +#include <linux/iio/triggered_buffer.h>
> > > > > +
> > > > > +#define TI_ADS7142_NAME					"ads7142"
> > > > > +
> > > > > +#define TI_ADS7142_DATA_VALID_TIMEOUT			100
> > > > > +
> > > > > +/* Opcodes for commands */
> > > > > +/* General */
> > > > > +#define TI_ADS7142_OC_GENERAL				0x00    
> > > > 
> > > > the names of the defines are fairly self explanatory. I'd drop the comments
> > > > unless you think they add a lot.  (Keep the Opcodes for commands line though
> > > > as OC isn't obvious).
> > > >     
> > > 
> > > I tried to follow the structure and names like in datasheet  
> > 
> > Sure, just saying you don't need the comments for most of this
> > /* Single Register Read */ is obviously from SINGLE_REG_READ
> > 
> > All comments like this end up doing is bit rotting so only use
> > them if they add significant value.
> >   
> > >   
> > > > > +/* Single Register Read */
> > > > > +#define TI_ADS7142_OC_SINGLE_REG_READ			0x10
> > > > > +/* Single Register Write */
> > > > > +#define TI_ADS7142_OC_SINGLE_REG_WRITE			0x08
> > > > > +/* Single Bit Set */
> > > > > +#define TI_ADS7142_OC_SET_BIT				0x18
> > > > > +/* Single Bit Clear */
> > > > > +#define TI_ADS7142_OC_CLEAR_BIT				0x20
> > > > > +/* Block Register Read */
> > > > > +#define TI_ADS7142_OC_BLOCK_READ			0x30
> > > > > +/* Block Register Write */
> > > > > +#define TI_ADS7142_OC_BLOCK_WRITE			0x28
> > > > > +  
> > 
> > ...
> > 
> > ...
> >   
> > > > > +
> > > > > +static int ti_ads7142_hys_set(struct iio_dev *indio_dev, int channel,
> > > > > +			      int hysteresis)
> > > > > +{
> > > > > +	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> > > > > +	int ret;
> > > > > +
> > > > > +	if (hysteresis < 0 || hysteresis > TI_ADS7142_HYSTERESIS_MSK)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_DWC_HYS_CH0 + channel,
> > > > > +				   hysteresis & TI_ADS7142_HYSTERESIS_MSK);    
> > > > 
> > > > I'd suggest either a cache of current value, or even better think about using
> > > > regmap to handle all the caching for you.
> > > >     
> > > 
> > > I'll use regmap.  
> > 
> > I'm not sure how it will interact with the fact not everything on this
> > device is register based, but good to give it a quick go and see what
> > it looks like.
> >  
> 
> As I see, I have to use dvm_regmap_init with custom regmap_bus and config.
> I'll try and, we will see it. I see some devices(ads7924, ads7138, ads7128,
>  tla2528, ...) with similar I2C protocol, maybe worth it to do. 
>  
> > >   
> >   
> > > > > +		goto seq_start;
> > > > > +
> > > > > +	/*
> > > > > +	 * Pre and post alert settings
> > > > > +	 */
> > > > > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_PRE_ALT_EVT_CNT,
> > > > > +				   priv->config.prealert_count &
> > > > > +				   TI_ADS7142_PRE_ALT_EVT_CNT_MSK);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_ALT_LOW_FLAGS,
> > > > > +				   TI_ADS7142_ALT_LOW_FLAGS_CH0
> > > > > +				   | TI_ADS7142_ALT_LOW_FLAGS_CH1);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_ALT_HIGH_FLAGS,
> > > > > +				   TI_ADS7142_ALT_HIGH_FLAGS_CH0
> > > > > +				   | TI_ADS7142_ALT_HIGH_FLAGS_CH1);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	for_each_set_bit(i, indio_dev->active_scan_mask,
> > > > > +			 indio_dev->masklength) {
> > > > > +		channel = ti_ads7142_address2channel(indio_dev, i);
> > > > > +		if (!channel)
> > > > > +			return -ENODEV;
> > > > > +
> > > > > +		ret = ti_ads7142_hth_set(indio_dev, channel->channel,
> > > > > +					 channel->config.high_threshold);
> > > > > +		if (ret)
> > > > > +			return ret;
> > > > > +
> > > > > +		ret = ti_ads7142_lth_set(indio_dev, channel->channel,
> > > > > +					 channel->config.low_threshold);
> > > > > +		if (ret)
> > > > > +			return ret;
> > > > > +
> > > > > +		ret = ti_ads7142_hys_set(indio_dev, channel->channel,
> > > > > +					 channel->config.hysteresis);
> > > > > +		if (ret)
> > > > > +			return ret;
> > > > > +
> > > > > +		if (channel->config.alert_low ||
> > > > > +		    channel->config.alert_high) {
> > > > > +			alert_ch |= 1 << channel->channel;
> > > > > +		}    
> > > > 
> > > > It's unusual to only have events enable if the buffer is also enabled.
> > > > Is there any way we can allow an events only configuration?
> > > > If not, fair enough but we may need to think about whether we need some
> > > > extra documentation around that.
> > > >     
> > > 
> > > I think, without threshold value/enable, the pre/post alert is pointless.
> > > I'll explain it in docs  
> > 
> > Ah. So these basically exist to give control over the events.
> > Definitely needs documentation.
> > 
> > We also need some way of linking the buffer back to the particular
> > event.  That may need some thought.  If we have a device that supports
> > N events but only one is used to trigger pre / post alert, then we need
> > to be able to specify which.   Could do that by providing triggers to
> > represent the different available events (only useable by this driver)
> >   
> 
> Could we extend the buffer items with meta info? (timestamp is now exists).

Yes, it's possible, but it isn't easy to define in a generic fashion and
that would be a requirement for any additional metadata.

Note we need to keep to fixed size scans, so meta data that is only sometimes
present could only be handled via a level of indirection.  Basically you'd
have some sort of metadata buffer index, that points to a separate kfifo or
similar with metadata.  Metadata you can have for every scan is easier
to handle, or where you don't mind wasting a bit of space.

However, I'm not sure it's needed here.  Can you have more than one trigger
event enabled at the same time?  If you can, do you actually care what caused
the event (in a fashion that can't be trivially established from the data?)
If it was an over event, you'd expect the relevant data point to be over
the limit for example.
 
> 
> > > > > +static int ti_ads7142_buffered_collect(struct iio_dev *indio_dev,
> > > > > +				       int *channel_collected)
> > > > > +{
> > > > > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > > > > +	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> > > > > +	int scan_channel_count;
> > > > > +	int have_valid_data;
> > > > > +	int data_valid;
> > > > > +	u16 data_buffer;
> > > > > +	u16 buffer[TI_ADS7142_CHANNEL_COUNT];
> > > > > +	u8 seq_channels = 0;
> > > > > +	int channel_address;
> > > > > +	int value;
> > > > > +	int i, j;
> > > > > +	int ret;
> > > > > +
> > > > > +	scan_channel_count = bitmap_weight(indio_dev->active_scan_mask,
> > > > > +					   indio_dev->masklength);
> > > > > +	if (!scan_channel_count)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	for_each_set_bit(i, indio_dev->active_scan_mask,
> > > > > +			 indio_dev->masklength) {
> > > > > +		seq_channels |= 1 << i;
> > > > > +	}    
> > > > 
> > > > Kernel style is no brackets around a single line statement like this.
> > > > Also, isn't this duplicating the active_scan_mask?
> > > >     
> > > 
> > > You are right, this is redundancy
> > >   
> > > > > +
> > > > > +	do {
> > > > > +		memset(priv->scan_data, 0x00, indio_dev->scan_bytes);    
> > > > 
> > > > This should be unnecessary as the priv data is kzalloc'd in the first place, so
> > > > all we can do here is leak old timestamps or channel values (actually timestamps
> > > > can't leak anyway because either we write it or it never goes in the buffer, but
> > > > that's harder to explain ;)
> > > >     
> > > 
> > > Ok, I'll remove it
> > >   
> > > >     
> > > > > +		have_valid_data = 0;
> > > > > +		for (i = 0; i < scan_channel_count; i++) {
> > > > > +			ret = ti_ads7142_data_buffer_read(client,
> > > > > +							  sizeof(data_buffer),
> > > > > +							  &data_buffer);
> > > > > +			if (ret)
> > > > > +				return ret;
> > > > > +			data_buffer = be16_to_cpu(data_buffer);    
> > > > 
> > > > Definitely preferred to have two local variables when doing endian conversions
> > > > Lets use track what endian a particular one is.  Not to mention you'll get
> > > > static checker warnings on this as it stands.
> > > >    
> > > 
> > > I'll correct this. Thank you for explanation
> > >    
> > > >     
> > > > > +			data_valid = data_buffer & 1;
> > > > > +			if (!data_valid) {
> > > > > +				ret = -ENOENT;
> > > > > +				break;
> > > > > +			}
> > > > > +
> > > > > +			channel_address = (data_buffer >> 1) & 0x7;    
> > > > 
> > > > FIELD_GET() perhaps?
> > > >     
> > > > > +			if (!(seq_channels & 1 << channel_address)) {    
> > > > 
> > > > test_bit()    
> > > 
> > > Ok, I'll do that
> > >   
> > > >     
> > > > > +				dev_err(indio_dev->dev.parent,
> > > > > +					"%s: invalid channel address(%d)",
> > > > > +					__func__, channel_address);
> > > > > +				return -EIO;
> > > > > +			}
> > > > > +
> > > > > +			value = data_buffer >> 4;
> > > > > +			buffer[channel_address] = value;
> > > > > +			have_valid_data = 1;
> > > > > +			if (channel_collected)
> > > > > +				*channel_collected |= 1 << channel_address;
> > > > > +		}
> > > > > +
> > > > > +		if (!have_valid_data)
> > > > > +			continue;
> > > > > +
> > > > > +		j = 0;
> > > > > +		for_each_set_bit(i, indio_dev->active_scan_mask,
> > > > > +				 indio_dev->masklength) {    
> > > > 
> > > > This confuses me somewhat.  The code above appears to suggest that you will only
> > > > be reading the entries you want anyway, so why can you not just fill scan_data
> > > > directly in that loop?
> > > >     
> > > 
> > > This is because the buffer[] indexed with channel_address value, reported by the device
> > >  for the conversion result, and if only the AIN1 selected for scanning, the conversion
> > >  result goes to buffer[1], but scan_bytes in this case is 2, so the
> > >  iio_push_to_buffers_with_timestamp will shows the priv->scan_data[0] to the user.  
> > 
> > But the choice to put the channel into the location referenced by channel_address
> > is made in this code.   You could store it directly into priv->scan_data[0] where
> > you currently put it into buffer[1], just need to use a similar j++ type pattern
> > to what you have here in the above loop rather than this one.  
> 
> You are right.
> 
> >   
> > >   
> > > > > +			priv->scan_data[j] = buffer[i];
> > > > > +			j++;
> > > > > +		}
> > > > > +		iio_push_to_buffers_with_timestamp(indio_dev, priv->scan_data,
> > > > > +						   iio_get_time_ns(indio_dev));
> > > > > +	} while (data_valid);
> > > > > +
> > > > > +	return ret;
> > > > > +}  
> > ...
> >   
> > > > > +	if (priv->config.buffer_mode == TI_ADS7142_BUFFM_START_BURST ||
> > > > > +	    priv->config.buffer_mode == TI_ADS7142_BUFFM_STOP_BURST) {
> > > > > +		ret = ti_ads7142_buffered_setup_and_start(indio_dev);
> > > > > +		if (ret) {
> > > > > +			dev_err(indio_dev->dev.parent,
> > > > > +				"%s: error(%d) when starting %s mode",
> > > > > +				__func__, ret,
> > > > > +				ti_ads7142_buffer_modes[priv->config.buffer_mode]);
> > > > > +			goto err_unlock;    
> > > > 
> > > > What code to return when you get an error in an interrupt handler is always
> > > > an interesting question.   However, in this case we've handled the interrupt, but
> > > > not restarted capture.  Returning IRQ_NONE doesn't feel right.
> > > >     
> > > 
> > > You are right, but who knows what happends with the device.
> > > In this case, what about iio_trigger_notify_done? It reenables the pollfunc.  
> > 
> > Yup. Though in that case we will just end up stuck rather than potentially 
> > triggering misleading spurious interrupt messages in the log.
> > 
> > There isn't really a right answer for this though.
> >  
> 
> Ok, I'll change dev_err's to dev_dbg, and skip iio_trigger_notify_done
>  in case of error.
>  
> > >   
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	mutex_unlock(&priv->lock);
> > > > > +	iio_trigger_notify_done(indio_dev->trig);
> > > > > +
> > > > > +	return IRQ_HANDLED;
> > > > > +
> > > > > +err_unlock:
> > > > > +	mutex_unlock(&priv->lock);
> > > > > +	return IRQ_NONE;
> > > > > +}
> > > > > +  
> > 
> > Fun device and interesting driver :)
> >   
> 
> It seems, it raised more questions than I thought. I started this driver because
>  I needed a super mini, low-power ADC and I developed the pre_alert mode support
>  just for fun.
> The problems we are facing are very interesting for me.
> 
> My plan:
> 1. I would complete this driver as is.

Great.

> 2. I would start working on industrialio-capture
>   - I'll add capture support to ti-ads7142 driver
>   - I'll add capture(DMA) support to ti_am335x_adc driver
>     (I have an am3359 devkit on my shelf.)
>   These two example will show, how simple is to add capture support :)

As mentioned I think a small addition to the interface will work for this,
without confusing the existing ABI or really introducing any new concepts
(we have too many concepts in IIO already!)

For the am335x, I would want to understand the usecase that isn't fulfilled
by existing capture mechanism.  I don't recall it having a threshold driven
start / stop, so it might be a stretch to argue in favour of something that
could just be implemented as normal buffer enable / disable signals from
userspace.

> 3. I would extend the industrialio-buffer with event metadata

That one is hard to do, because the description of metadata tends to be
have a huge space.  We've had it come up quite a few times, and no
workable proposals yet. (Actually I'm not sure it ever got beyond the
level of questions you have here :)

> > Jonathan  
> 
> 
> Thank you
> 
> Best regards
> József


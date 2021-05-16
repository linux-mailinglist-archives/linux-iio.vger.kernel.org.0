Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706D738208D
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 21:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhEPTJ4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 15:09:56 -0400
Received: from bmail1.ministro.hu ([5.249.150.236]:42482 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhEPTJz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 15:09:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 43275123FB1;
        Sun, 16 May 2021 21:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1621192118;
        bh=Rx3cO1YTuAfgJuImsIs7DV9okrj1bieLIKlPrZOmfuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYX6X3QbNbYtNkjZYhP71ze0qK6pmBX5yxHN48Hyjs9UzpNiw4x7eq5OQo4dGSFcO
         ifoNoQ6jou8PX4qWrdkrjbG846c/Kz9B2uCM/OViYAg/BGp87yLbL4kmEynxpitDd4
         g4SbWfWrH9wK7+xtiiHBC5UBIP3oizhWGP+2wbcvb17qQDY7ABtjJEGKGecc9Gfmio
         RpaNWM74ojLZvKKH0kYmwo8oKTpSfiy2+1X29T5JJz7bO3fD5ALjgPSaAkBeKVrd4Q
         T2JImv5AE7NcZyy/0axPFGMWgWllu0QdC9bz7Nqn0cJk68yL1AS4cHG36s9HeXbC6M
         cC+ve4vQmhPFg==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wo54AxVz0FKI; Sun, 16 May 2021 21:07:59 +0200 (CEST)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id AF70D123FA7;
        Sun, 16 May 2021 21:07:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1621192079;
        bh=Rx3cO1YTuAfgJuImsIs7DV9okrj1bieLIKlPrZOmfuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSY6UmzVc02h3I8+l8q0srHPIuZRuQ++SGy4DMLKDyw/lCaMP1mjh0wv9qPhoZOvx
         aJp3MQyRnsKJFBG5kuz5uLIBi/HTNQesnGZXhzgn3aLrz8Xbh69iJ97o6YdLIuVylZ
         jhGFaXHM7UYdBbRWWtvtHYVr6GBDuEdvw1/7DdN+R38b0D1kUdoPFk2LJNh7rbbCcf
         SuUZ1yT+713CamF3YGRqnrMZ2D5BEDtxupVisCCZj5nTJGti/U8KB5q4YBBUDi3X+a
         ijFCMjFDGIijIC98HJzph1fSK4aSQLONpRz9UIzFAF8858Z9JY19yN3o2o/NwmWAEv
         +xNpZ+HUTCHlA==
Date:   Sun, 16 May 2021 19:07:55 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
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
Message-ID: <20210516190751.GB16211@dev>
References: <9f9c64ca70f80d8a024ea66e3963350e35f27c1d.1621105931.git.info@ministro.hu>
 <20210516122840.22cab9b5@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210516122840.22cab9b5@jic23-huawei>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 16, 2021 at 12:28:40PM +0100, Jonathan Cameron wrote:
> On Sun, 16 May 2021 07:30:35 +0000
> Jozsef Horvath <info@ministro.hu> wrote:
> 
> > This is an iio driver for
> >  Texas Instruments ADS7142 dual-channel, programmable sensor monitor.
> 
> Hi,
> 
> Note I review in reverse, so it's possible my comments will make more
> sense read in that direction!
> 
> Various comments inline, but mostly this seems to be coming together nicely!
> 
> Jonathan
> > 
> > All of the data buffer modes, supported by the device are selectable
> >  over sysfs:
> >   /sys/bus/iio/devices/iio:deviceX/buffer_mode
> > 
> > Data buffer operation modes:
> >   - start_burst:
> 
> I'd like to see a lot of this info in the ABI docs.  Not the internals
> part but the 'what needs to be configured' element.
> 
> Some of the flow related stuff should go in the driver itself.
> It's non obvious and no one reads patch descriptions after the code has
> merged! 
> 

Ok, I'll write a more detailed description with configuration
 requirements

> 
> >     In triggered buffer preenable hook: not relevant.
> >     In trigger handler: the driver selects the autonomous monitoring
> >       (see chapter 7.4.3 in datasheet) operation mode,
> > 	  configures the channels in sequencer as specified by
> >       sysfs(scan_elements/in_voltageY_en),
> > 	  sets the data buffer mode to "Start Burst Mode",
> >       then starts the conversion.
> >     In irq handler: the driver pushes the conversion results received
> >       from the device to the buffer,
> >       then restarts the conversion like in trigger handler.
> >     Both IRQ and trigger are required to support this mode.
> >     See chapter 7.4.3.2.1 "Autonomous Mode with Start Burst"
> >     in datasheet.
> 
> >   - stop_burst:
> >     In triggered buffer preenable hook: the driver selects the
> >       autonomous monitoring (see chapter 7.4.3 in datasheet)
> >       operation mode,
> >       configures the channels in sequencer as
> >       specified by sysfs(scan_elements/in_voltageY_en),
> > 	  sets the data buffer mode to "Stop Burst Mode",
> >       then starts the conversion.
> >     In trigger handler: the driver pushes the conversion results received
> >       from the device to the buffer,
> > 	  then restarts the conversion like in preenable hook.
> >     In irq handler: not relevant.
> >     Trigger is required to support this mode.
> >     See chapter 7.4.3.2.2 "Autonomous Mode with Stop Burst"
> >     in datasheet.
> 
> >   - pre_alert:
> >     In triggered buffer preenable hook: the driver selects the autonomous
> >       monitoring (see chapter 7.4.3 in datasheet) operation mode,
> >       configures the channels in sequencer
> >         as specified by sysfs(scan_elements/in_voltageY_en),
> >       configures the digital window comparator and alert flags,
> > 	  sets the data buffer mode to "Pre Alert Data Mode",
> >       then starts the conversion.
> >     In trigger handler: not relevant.
> >     In irq handler: the driver pushes the conversion results received
> >       from the device to the buffer,
> >       then restarts the conversion like in preenable hook.
> >     IRQ is required to support this mode.
> >     See chapter 7.4.3.1.1 "Autonomous Mode with Pre Alert Data"
> >     in datasheet
> >   - post_alert:
> >     The operations are same like in pre_alert mode,
> >       except the data buffer mode selection, the selected mode is
> >       "Post Alert Data Mode".
> >     See chapter 7.4.3.1.2 "Autonomous Mode with Post Alert Data"
> >     in datasheet
> 
> Impressive you got all these to work reasonably cleanly.  My only
> remaining question on this stuff is whether we can do anything that
> looks 'more standard' to enable the use of these with general purpose
> code.
> 
> The last two could be implemented as a trigger, be it one that can only
> be used by this device.  So you would select the mode by picking the
> relevant trigger.
> 
> However I can't see any similar way of supporting the start and stop burst
> modes. So for now at least perhaps this is the best we can do (and it
> won't be too painful to support this as a legacy interface if we do later
> figure out a nice generic interface).
> 
> 
> I would like to think longer term about whether we can come up with
> some standard ABI for these 'burst' capture devices. We have another one
> in staging (adis16240) that has been there a long time as we never
> managed to make progress on the interface.
> 
> Looking briefly at that device, I do note that it supports somewhere
> between your pre_alert and post_alert (X samples before event, so
> many samples after).  Maybe we want to think about an alert mode
> and use a separate control to set the 'where' part relative to
> the alert mode?
> 
> It is hard to define general ABI with 2 devices however, so perhaps
> we should stick with what you have and can always add an "alert"
> buffer mode as needed for a new device. 
> 

I think we can say that, all of general purpose ADCs, pressure, light, accel etc.
 sensors supports "virtual" start_burst mode with at least 1 element FIFO per channel.
 Flow:
  1. in trigger, the host issues a start conversion request to device,
     then polls or "wait" IRQ/conv rdy signal
  2. device do the job, then report the state of end of operation, somehow...
  3. the completion handler moves the conversion result to buffer

 Here is some device with real start_burst like support (not complete list):
  accel/adxl345
    datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
    see: Table 22. FIFO Mode: FIFO collects up to 32 values...
  accel/bmc150-accel
    datasheet: https://hu.mouser.com/datasheet/2/783/BST-BMC150-DS000-1509560.pdf
    see: 5.1 FIFO Operating Modes: FIFO Mode
    note: obsolate
  accel/bmi088-accel
    datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
    see: 4.9.1 FIFO operating modes: FIFO or stop-at-full mode
  gyro/bmg160
    datasheet: https://hu.mouser.com/datasheet/2/783/BST-BMG160-DS000-1509613.pdf
    see: 5.1 FIFO Operating Modes: FIFO Mode
    note: obsolete
  health/max30100
    datasheet: https://datasheets.maximintegrated.com/en/ds/MAX30100.pdf
    see: FIFO (0x02–0x05)
    note: this mode is very close to start_burst mode of ti-ads7141

 The current generalized triggered_buffer API covers this mode completely.

Some of sensors under iio supports stop_burst mode with FIFO.
 Flow could be:
  1. in somewhere(probably buffer_{pre,post} enable), the host configures the FIFO
     then starts conversion
  2. in trigger, the host reads FIFO content,
     then push the result to buffer,
     then restart the conversion or not, it depends of application/device etc.

 Here is some device with stop_burst like support (not complete list):
  accel/adxl345
    datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
    see: Table 22. Stream Mode: FIFO holds the last 32 data values...
  accel/bmc150-accel
    datasheet: https://hu.mouser.com/datasheet/2/783/BST-BMC150-DS000-1509560.pdf
    see: 5.1 FIFO Operating Modes: Stream Mode
    note: obsolate
  accel/bmi088-accel
    datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
    see: 4.9.1 FIFO operating modes: STREAM mode
  gyro/bmg160
    datasheet: https://hu.mouser.com/datasheet/2/783/BST-BMG160-DS000-1509613.pdf
    see: 5.1 FIFO Operating Modes: STREAM mode
    note: obsolete

Some of sensors under iio supports {pre,post}_alert or we can call near_{event,trigger}
  or {before,after,around}_{event,trigger} with FIFO.
 Flow could be:
  1. in configure_fifo hook(see below), the host configures the device FIFO mode/size
  2. in {pre,post}enable hook, the host starts conversion
  3. in IRQ handler, the host reads FIFO content,
     then push the result to buffer, and reports events to user,
     then restart the conversion or not, it depends of application/device etc.

 Here is some device (not complete list):
  accel/adxl345
    datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
    see: Table 22. Trigger Mode: When triggered by the trigger bit...
    note: as I understand the datasheet, this mode can be pre or post alert too,
     it depends of the value of FIFO_CTL[4:0](Samples Bits)
  staging/accel/adis16240
  adc/ti-ads7142

Overall, not only 2 devices, but many devices are affected under iio,
 and I think in addition to "buffer_mode", the FIFO configuration should
 also be included this ABI. And here, I think, the fifo_mode is a better name than buffer_mode.

Here is my suggestion:

This should be configured with buffered mode.

enum iio_chan_info_enum {
...
	IIO_CHAN_INFO_CALIBAMBIENT,
+	IIO_CHAN_INFO_FIFOSIZE,
};

IIO_CHAN_INFO_FIFOSIZE: a new sysfs entry comes up under /sys/bus/iio/devices/iio:deviceX/
 with "fifosize" postfix. This will be per device property mostly.

+enum iio_fifo_mode {
+	IIO_FIFO_MODE_START_BURST,
+	IIO_FIFO_MODE_STOP_BURST,
+	IIO_FIFO_MODE_BEFORE_EVENT,
+	IIO_FIFO_MODE_AFTER_EVENT,
+	IIO_FIFO_MODE_AROUND_EVENT,
+};

struct iio_buffer_setup_ops {
	int (*preenable)(struct iio_dev *);
	int (*postenable)(struct iio_dev *);
	int (*predisable)(struct iio_dev *);
	int (*postdisable)(struct iio_dev *);
	bool (*validate_scan_mask)(struct iio_dev *indio_dev,
				   const unsigned long *scan_mask);
+	int fifo_mode_mask;
+	int (*configure_fifo)(struct iio_dev*);
};

If the device supports any of iio_fifo_mode, it can be configured with fifo_mode_mask.
If fifo_mode_mask have any flags, two new sysfs entry comes up
 /sys/bus/iio/devices/iio:deviceX/buffer/fifo_mode
 /sys/bus/iio/devices/iio:deviceX/buffer/fifo_mode_available
I dont think, different fifo modes will be configurable by channel in the future,
 but in that case, fifo_mode_mask_separate, etc can be added.

The new configure_fifo hook could be called before preenable hook.

I think this can cover the requirements for a while.

> 
> > 
> > The in_voltageY_raw can be used, if the buffering mode is not enabled
> >  in sysfs(buffer/enable).
> >  The driver initiates a single conversion in the device for each
> >  read request(in_voltageY_raw).
> >  This is a one-shot conversion.
> >  See chapter 7.4.2.2 "Manual Mode with AUTO Sequence" in datasheet.
> > 
> > Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
> > 
> > Signed-off-by: Jozsef Horvath <info@ministro.hu>
> 
> > ---
> > 
> > changes v1
> >   - All of the buffer opertaion modes
> >     (pre_alert, post_alert, start_burst, stop_burst)
> > 	are added
> >   - Added triggered buffer
> >   - Added buffer operation mode selection sysfs support
> >   - Redundant parameters (ti,threshold-rising, etc.)
> >     are removed
> >   - Supply name changed(vref -> avdd)
> >   - Added dvdd supply
> >   - Added device sampling rate calculation
> >   - Use device-managed functions for regulator, iio device register
> >     and triggered buffer
> > 
> > changes v2
> >   - Unreachable statements removed
> >   - ti_ads7142_buffered_setup_and_start returns without error when
> >     pre/post alert mode is selected, but no thresh_{rising/falling}
> >     enabled on any channel. Fixed with return -EINVAL in the case above.
> >   - Stylistical changes
> >   - devm_regulator_get return value error/NULL handling.
> >   - "ti,prealert-count" parameter added, just for completeness.
> > ---
> >  .../ABI/testing/sysfs-bus-iio-adc-ti-ads7142  |   11 +
> >  MAINTAINERS                                   |    7 +
> >  drivers/iio/adc/Kconfig                       |   13 +
> >  drivers/iio/adc/Makefile                      |    1 +
> >  drivers/iio/adc/ti-ads7142.c                  | 1461 +++++++++++++++++
> >  5 files changed, 1493 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ads7142
> >  create mode 100644 drivers/iio/adc/ti-ads7142.c
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ads7142 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ads7142
> > new file mode 100644
> > index 000000000000..485017235f4a
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ads7142
> > @@ -0,0 +1,11 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/buffer_mode_available
> > +Date:		May 2021
> > +KernelVersion:	5.13
> > +Contact:	info@ministro.hu
> > +Description: 	List all available buffer_mode settings.
> 
> List them out with detailed explanation of what each one does + how it interacts
> with the trigger etc.
> 

Ok, I'll do that.

> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/buffer_mode
> > +Date:		May 2021
> > +KernelVersion:	5.13
> > +Contact:	info@ministro.hu
> > +Description: 	Sets up the device data buffer mode.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6582d19cdf7a..97922bffd766 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18086,6 +18086,13 @@ T:	git git://github.com/czankel/xtensa-linux.git
> >  F:	arch/xtensa/
> >  F:	drivers/irqchip/irq-xtensa-*
> >  
> > +TEXAS INSTRUMENTS ADS7142 ADC DRIVER
> > +M:	Jozsef Horvath <info@ministro.hu>
> > +S:	Maintained
> > +F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ads7142
> > +F:	Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
> > +F:	drivers/iio/adc/ti-ads7142.c
> > +
> >  TEXAS INSTRUMENTS ASoC DRIVERS
> >  M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
> >  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index db0c8fb60515..6c34ede355e4 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -1111,6 +1111,19 @@ config TI_ADS1015
> >  	  This driver can also be built as a module. If so, the module will be
> >  	  called ti-ads1015.
> >  
> > +config TI_ADS7142
> > +	tristate "Texas Instruments ADS7142 ADC driver"
> > +	depends on I2C
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	help
> > +	  This driver is for Texas Instruments ADS7142 Nanopower,
> > +	   Dual-Channel, Programmable Sensor Monitor.
> 
> Keep spacing as tab + 2 space
> 

Ok, I'll correct this.

> > +	  Say 'Y' here if you wish to use it.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ti-ads7142.
> > +
...
> > +#include <linux/iio/triggered_buffer.h>
> > +
> > +#define TI_ADS7142_NAME					"ads7142"
> > +
> > +#define TI_ADS7142_DATA_VALID_TIMEOUT			100
> > +
> > +/* Opcodes for commands */
> > +/* General */
> > +#define TI_ADS7142_OC_GENERAL				0x00
> 
> the names of the defines are fairly self explanatory. I'd drop the comments
> unless you think they add a lot.  (Keep the Opcodes for commands line though
> as OC isn't obvious).
> 

I tried to follow the structure and names like in datasheet

> > +/* Single Register Read */
> > +#define TI_ADS7142_OC_SINGLE_REG_READ			0x10
> > +/* Single Register Write */
> > +#define TI_ADS7142_OC_SINGLE_REG_WRITE			0x08
> > +/* Single Bit Set */
> > +#define TI_ADS7142_OC_SET_BIT				0x18
> > +/* Single Bit Clear */
> > +#define TI_ADS7142_OC_CLEAR_BIT				0x20
> > +/* Block Register Read */
> > +#define TI_ADS7142_OC_BLOCK_READ			0x30
> > +/* Block Register Write */
> > +#define TI_ADS7142_OC_BLOCK_WRITE			0x28
> > +
> > +/* Registers */
> > +/* Reset registers */
> > +#define TI_ADS7142_WKEY					0x17
> > +#define TI_ADS7142_DEVICE_RESET				0x14
> > +/* Functional mode select registers */
> > +#define TI_ADS7142_OFFSET_CAL				0x15
> > +#define TI_ADS7142_OPMODE_SEL				0x1C
> > +#define TI_ADS7142_OPMODE_SEL_MANUALCH0			(0)
> > +#define TI_ADS7142_OPMODE_SEL_MANUALSEQ			(4)
> > +#define TI_ADS7142_OPMODE_SEL_MONITORING		(6)
> > +#define TI_ADS7142_OPMODE_SEL_HIGHPREC			(7)
> > +#define TI_ADS7142_OPMODE_STATUS			0x00
> > +#define TI_ADS7142_OPMODE_STATUS_OPMODE_MSK		(3)
> > +#define TI_ADS7142_OPMODE_STATUS_OPMODE_MANUAL		(0)
> > +#define TI_ADS7142_OPMODE_STATUS_OPMODE_AUTO		(2)
> > +#define TI_ADS7142_OPMODE_STATUS_OPMODE_HIGHPREC	(3)
> > +#define TI_ADS7142_OPMODE_STATUS_HS_MODE		BIT(2)
> > +
> > +/* Input config register */
> > +#define TI_ADS7142_CH_INPUT_CFG				0x24
> > +#define TI_ADS7142_CH_INPUT_CFG_TCSE			(0)
> > +#define TI_ADS7142_CH_INPUT_CFG_SCSE			(1)
> > +#define TI_ADS7142_CH_INPUT_CFG_SCPD			(2)
> > +/* Analog mux and sequencer registers */
> > +#define TI_ADS7142_AUTO_SEQ_CHEN			0x20
> > +#define TI_ADS7142_AUTO_SEQ_CHEN_CH0			BIT(0)
> > +#define TI_ADS7142_AUTO_SEQ_CHEN_CH1			BIT(1)
> > +#define TI_ADS7142_START_SEQUENCE			0x1E
> > +#define TI_ADS7142_START_SEQUENCE_SEQ_START		BIT(0)
> > +#define TI_ADS7142_ABORT_SEQUENCE			0x1F
> > +#define TI_ADS7142_ABORT_SEQUENCE_SEQ_ABORT		BIT(0)
> > +#define TI_ADS7142_SEQUENCE_STATUS			0x04
> > +#define TI_ADS7142_SEQUENCE_STATUS_SEQ_ERR_ST_MSK	(0x06)
> 
> No need to bracket constant values.
> 

Ok, I'll remove all of them

> > +#define TI_ADS7142_SEQUENCE_STATUS_SEQ_DISABLED		(0x00)
> > +#define TI_ADS7142_SEQUENCE_STATUS_SEQ_ENABLED		(0x02)
> > +#define TI_ADS7142_SEQUENCE_STATUS_SEQ_ERROR		(0x06)
> 
> I would suggest that use of FIELD_PREP() etc would make this neater but
> I'm not that bothered if you really want to keep it this way.
> 

Ok, it's not too mutch, I'll do that

> > +/* Oscillator and timing control registers */
> > +#define TI_ADS7142_OSC_SEL				0x18
> > +#define TI_ADS7142_OSC_SEL_HSZ_LP			BIT(0)
> > +#define TI_ADS7142_NCLK_SEL				0x19
> > +#define TI_ADS7142_NCLK_SEL_MSK				0xFF
> > +/* Data buffer control register */
> > +#define TI_ADS7142_DATA_BUFFER_OPMODE			0x2C
> > +#define TI_ADS7142_DATA_BUFFER_OPMODE_STOP_BURST	(0)
> > +#define TI_ADS7142_DATA_BUFFER_OPMODE_START_BURST	(1)
> > +#define TI_ADS7142_DATA_BUFFER_OPMODE_PRE_ALERT		(4)
> > +#define TI_ADS7142_DATA_BUFFER_OPMODE_POST_ALERT	(6)
> > +#define TI_ADS7142_DOUT_FORMAT_CFG			0x28
> > +#define TI_ADS7142_DOUT_FORMAT_CFG_12B			(0)
> > +#define TI_ADS7142_DOUT_FORMAT_CFG_12BCH		(1)
> > +#define TI_ADS7142_DOUT_FORMAT_CFG_12BCHDV		(2)
> > +#define TI_ADS7142_DATA_BUFFER_STATUS			0x01
> > +/* Accumulator control register */
> > +#define TI_ADS7142_ACC_EN				0x30
> > +#define TI_ADS7142_ACC_CH0_LSB				0x08
> > +#define TI_ADS7142_ACC_CH0_MSB				0x09
> > +#define TI_ADS7142_ACC_CH1_LSB				0x0A
> > +#define TI_ADS7142_ACC_CH1_MSB				0x0B
> > +#define TI_ADS7142_ACC_STATUS				0x02
> > +/* Digital window comparator registers */
> > +#define TI_ADS7142_ALERT_DWC_EN				0x37
> > +#define TI_ADS7142_ALERT_DWC_EN_BLOCK_EN		BIT(0)
> > +#define TI_ADS7142_ALERT_CHEN				0x34
> > +#define TI_ADS7142_DWC_HTH_CH0_LSB			0x38
> > +#define TI_ADS7142_DWC_HTH_CH0_MSB			0x39
> > +#define TI_ADS7142_DWC_LTH_CH0_LSB			0x3A
> > +#define TI_ADS7142_DWC_LTH_CH0_MSB			0x3B
> > +#define TI_ADS7142_DWC_HYS_CH0				0x40
> > +#define TI_ADS7142_DWC_HTH_CH1_LSB			0x3C
> > +#define TI_ADS7142_DWC_HTH_CH1_MSB			0x3D
> > +#define TI_ADS7142_DWC_LTH_CH1_LSB			0x3E
> > +#define TI_ADS7142_DWC_LTH_CH1_MSB			0x3F
> > +#define TI_ADS7142_DWC_HYS_CH1				0x41
> > +#define TI_ADS7142_PRE_ALT_EVT_CNT			0x36
> > +#define TI_ADS7142_PRE_ALT_EVT_CNT_MSK			0x0F
> > +#define TI_ADS7142_ALT_TRIG_CHID			0x03
> > +#define TI_ADS7142_ALT_LOW_FLAGS			0x0C
> > +#define TI_ADS7142_ALT_LOW_FLAGS_CH0			BIT(0)
> > +#define TI_ADS7142_ALT_LOW_FLAGS_CH1			BIT(1)
> > +#define TI_ADS7142_ALT_HIGH_FLAGS			0x0E
> It can be helpful to add something to naming of register defines to make
> it clear what is an address vs a field.  Afterall
> ALT_HIGH_FLAGS could easily bee the FLAGS field of ALT_HIGH
> 
> I'd suggest
> #define TI_ADS7142_ALT_HIGH_FLAGS_REG (_ADR works as well)
> #define   TI_ADS7152_ALT_HIGH_FLAGS_CH0
> 
> Note the small amount of indenting which can help readability but is
> entirely up to you.

it's most readable, you are right

> 
> > +#define TI_ADS7142_ALT_HIGH_FLAGS_CH0			BIT(0)
> > +#define TI_ADS7142_ALT_HIGH_FLAGS_CH1			BIT(1)
> > +
> > +#define TI_ADS7142_THRESHOLD_MSK			0xFFF
> > +#define TI_ADS7142_HYSTERESIS_MSK			0x3F
> > +
> > +#define TI_ADS7142_HSO_FREQ				20000000
> > +#define TI_ADS7142_HSO_NCLK_MIN				21
> > +#define TI_ADS7142_HSO_NCLK_MAX				255
> > +#define TI_ADS7142_HSO_MIN_SS				78431
> > +#define TI_ADS7142_HSO_MAX_SS				952380
> > +#define TI_ADS7142_LPO_FREQ				10504
> > +#define TI_ADS7142_LPO_NCLK_MIN				18
> > +#define TI_ADS7142_LPO_NCLK_MAX				255
> > +#define TI_ADS7142_LPO_MIN_SS				42
> > +#define TI_ADS7142_LPO_MAX_SS				583
> > +
> > +#define TI_ADS7142_CHANNEL_COUNT			2
> > +
> > +#define TI_ADS7142_PROP_REG				"reg"
> > +#define TI_ADS7142_PROP_PREALERT_COUNT			"ti,prealert-count"
> 
> Unless these are used lots of times, just put the strings inline.
> That ends up more readable than having a block of strings up here.
> 

Ok, I'll remove it

> 
> > +
> > +struct ti_ads7142_channel_config {
> > +	bool alert_low;
> > +	bool alert_high;
> > +	int high_threshold;
> > +	int low_threshold;
> > +	int hysteresis;
> > +};
> > +
> > +struct ti_ads7142_channel {
> > +	struct ti_ads7142_channel_config config;
> > +	u32 channel;
> > +};
> > +
> > +struct ti_ads7142_config {
> > +	bool osc_sel;
> > +	u32 n_clk;
> > +	u32 prealert_count;
> > +	int buffer_mode;
> > +};
> > +
> > +struct ti_ads7142_priv {
> > +	struct mutex lock; /* For syncing access to device */
> > +	struct regulator *avdd;
> > +	struct regulator *dvdd;
> > +	struct ti_ads7142_config config;
> > +	struct ti_ads7142_channel *channels;
> > +	bool irq_present;
> > +	bool monitor_pending;
> > +	u16 scan_data[TI_ADS7142_CHANNEL_COUNT] ____cacheline_aligned;
> 
> You are using scan_data to marshal the data for iio_push_to_buffers_with_timestamp().
> Note that doesn't require full cacheline_aligned (which would be needed if you were
> doing DMA into this buffer, but you aren't).
> 
> That function has some 'unusual' requirements.   There is a large fix set going through
> and after that we'll put some better docs in place etc.
> Anyhow, requirements are:
> 1) Buffer has to be large enough for data you are putting in it + a naturally aligned 8 byte
> timestamp.
> 2) The timestamp location must also be naturally aligned.
> 
> Probably the most elegant construct to do this is:
> 
> 	struct {
> 		u16 channels[TI_ADS7142_CHANNEL_COUNT];
> 		s64 timestamp __aligned(8); //this is needed to avoid an oddity of x86_32
> 	} scan;
> 
> It relies on the c standard requiring any structure to be aligned to the alignment of
> the maximum required alignment of elements inside the structure.
> 

Thank you for explanation

> 
> > +};
> > +
...
> > +
> > +static int ti_ads7142_data_buffer_read(const struct i2c_client *client,
> > +				       int length, void *data)
> 
> All users of this are length 2 and type __be16  so change the function to
> assume it is reading one channel and have data as __be16 *
> 

Ok, you are right.

> > +{
> > +	int ret;
> > +
> > +	ret = i2c_master_recv(client, data, length);
> > +	if (ret >= 0 && ret != length)
> > +		ret = -EIO;
> > +
> > +	return ret == length ? 0 : ret;
> > +}
> > +
...
> > +
> > +static int ti_ads7142_osc_calc_get(struct iio_dev *indio_dev, int *result)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	u32 n_clk;
> > +	u32 osc_freq;
> > +
> > +	if (priv->config.osc_sel) {
> > +		// Low power oscillator
> 
> /* */ preferred in IIO drivers.
> 

Ok, I'll correct it here and below.

> > +		n_clk = priv->config.n_clk;
> > +		if (n_clk < TI_ADS7142_LPO_NCLK_MIN)
> > +			n_clk = TI_ADS7142_LPO_NCLK_MIN;
> > +		if (n_clk > TI_ADS7142_LPO_NCLK_MAX)
> > +			n_clk = TI_ADS7142_LPO_NCLK_MAX;
> > +		osc_freq = TI_ADS7142_LPO_FREQ;
> > +	} else {
> > +		// High speed oscillator
> > +		n_clk = priv->config.n_clk;
> > +		if (n_clk < TI_ADS7142_HSO_NCLK_MIN)
> > +			n_clk = TI_ADS7142_HSO_NCLK_MIN;
> > +		if (n_clk > TI_ADS7142_HSO_NCLK_MAX)
> > +			n_clk = TI_ADS7142_HSO_NCLK_MAX;
> > +		osc_freq = TI_ADS7142_HSO_FREQ;
> > +	}
> > +	*result = osc_freq / n_clk;
> > +	return 0;
> > +}
> > +
...
> > +
> > +static int ti_ads7142_hys_set(struct iio_dev *indio_dev, int channel,
> > +			      int hysteresis)
> > +{
> > +	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> > +	int ret;
> > +
> > +	if (hysteresis < 0 || hysteresis > TI_ADS7142_HYSTERESIS_MSK)
> > +		return -EINVAL;
> > +
> > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_DWC_HYS_CH0 + channel,
> > +				   hysteresis & TI_ADS7142_HYSTERESIS_MSK);
> 
> I'd suggest either a cache of current value, or even better think about using
> regmap to handle all the caching for you.
> 

I'll use regmap.

> > +	return ret;
> > +}
> > +
> > +static int ti_ads7142_buffered_setup_and_start(struct iio_dev *indio_dev)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> > +	struct ti_ads7142_channel *channel;
> > +	int i;
> > +	u8 alert_ch = 0;
> > +	u8 buffer_op_mode;
> > +	u8 seq_channels = 0;
> > +	int ret;
> > +
> > +	if (!priv->config.buffer_mode)
> > +		return 0;
> > +
> > +	priv->monitor_pending = false;
> > +
> > +	ret = ti_ads7142_sequence_abort(indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ti_ads7142_osc_set(indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ti_ads7142_input_cfg_set(indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ti_ads7142_dout_format_set(indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (priv->config.buffer_mode) {
> > +	case TI_ADS7142_BUFFM_STOP_BURST:
> > +		buffer_op_mode = TI_ADS7142_DATA_BUFFER_OPMODE_STOP_BURST;
> > +		break;
> > +	case TI_ADS7142_BUFFM_START_BURST:
> > +		buffer_op_mode = TI_ADS7142_DATA_BUFFER_OPMODE_START_BURST;
> > +		break;
> > +	case TI_ADS7142_BUFFM_PRE_ALERT:
> > +		buffer_op_mode = TI_ADS7142_DATA_BUFFER_OPMODE_PRE_ALERT;
> > +		break;
> > +	case TI_ADS7142_BUFFM_POST_ALERT:
> > +		buffer_op_mode = TI_ADS7142_DATA_BUFFER_OPMODE_POST_ALERT;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_DATA_BUFFER_OPMODE,
> > +				   buffer_op_mode);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_OPMODE_SEL,
> > +				   TI_ADS7142_OPMODE_SEL_MONITORING);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for_each_set_bit(i, indio_dev->active_scan_mask,
> > +			 indio_dev->masklength) {
> > +		seq_channels |= 1 << i;
> 
> No brackets needed as only one line.
> 

Ok, I'll do that

> > +	}
> > +
> > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_AUTO_SEQ_CHEN,
> > +				   seq_channels);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (priv->config.buffer_mode < TI_ADS7142_BUFFM_PRE_ALERT)
> 
> I'd prefer an explicit match here to make it clear which buffer
> settings lead to skipping the next bit.  It might be clearer to
> break the following section out to another function and just have
> 
> 	if (priv...)
> 		*_setup_pre_post_alert()
> 
> 	etc.

You are right

> > +		goto seq_start;
> > +
> > +	/*
> > +	 * Pre and post alert settings
> > +	 */
> > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_PRE_ALT_EVT_CNT,
> > +				   priv->config.prealert_count &
> > +				   TI_ADS7142_PRE_ALT_EVT_CNT_MSK);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_ALT_LOW_FLAGS,
> > +				   TI_ADS7142_ALT_LOW_FLAGS_CH0
> > +				   | TI_ADS7142_ALT_LOW_FLAGS_CH1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_ALT_HIGH_FLAGS,
> > +				   TI_ADS7142_ALT_HIGH_FLAGS_CH0
> > +				   | TI_ADS7142_ALT_HIGH_FLAGS_CH1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for_each_set_bit(i, indio_dev->active_scan_mask,
> > +			 indio_dev->masklength) {
> > +		channel = ti_ads7142_address2channel(indio_dev, i);
> > +		if (!channel)
> > +			return -ENODEV;
> > +
> > +		ret = ti_ads7142_hth_set(indio_dev, channel->channel,
> > +					 channel->config.high_threshold);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = ti_ads7142_lth_set(indio_dev, channel->channel,
> > +					 channel->config.low_threshold);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = ti_ads7142_hys_set(indio_dev, channel->channel,
> > +					 channel->config.hysteresis);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (channel->config.alert_low ||
> > +		    channel->config.alert_high) {
> > +			alert_ch |= 1 << channel->channel;
> > +		}
> 
> It's unusual to only have events enable if the buffer is also enabled.
> Is there any way we can allow an events only configuration?
> If not, fair enough but we may need to think about whether we need some
> extra documentation around that.
> 

I think, without threshold value/enable, the pre/post alert is pointless.
I'll explain it in docs

> > +	}
> > +
> > +	/*
> > +	 * This means no threshold enabled for any channel.
> > +	 * In Pre/Post alert mode this state is invalid.
> > +	 */
> > +	if (!alert_ch)
> > +		return -EINVAL;
> > +
> > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_ALERT_DWC_EN,
> > +				   alert_ch ? TI_ADS7142_ALERT_DWC_EN_BLOCK_EN : 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_ALERT_CHEN,
> > +				   alert_ch);
> > +	if (ret)
> > +		return ret;
> > +
> > +seq_start:
> > +	ret = ti_ads7142_sequence_start(indio_dev);
> > +	priv->monitor_pending = !ret;
> > +
> > +	return ret;
> > +}
> > +
> > +static int ti_ads7142_buffered_collect(struct iio_dev *indio_dev,
> > +				       int *channel_collected)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> > +	int scan_channel_count;
> > +	int have_valid_data;
> > +	int data_valid;
> > +	u16 data_buffer;
> > +	u16 buffer[TI_ADS7142_CHANNEL_COUNT];
> > +	u8 seq_channels = 0;
> > +	int channel_address;
> > +	int value;
> > +	int i, j;
> > +	int ret;
> > +
> > +	scan_channel_count = bitmap_weight(indio_dev->active_scan_mask,
> > +					   indio_dev->masklength);
> > +	if (!scan_channel_count)
> > +		return -EINVAL;
> > +
> > +	for_each_set_bit(i, indio_dev->active_scan_mask,
> > +			 indio_dev->masklength) {
> > +		seq_channels |= 1 << i;
> > +	}
> 
> Kernel style is no brackets around a single line statement like this.
> Also, isn't this duplicating the active_scan_mask?
> 

You are right, this is redundancy

> > +
> > +	do {
> > +		memset(priv->scan_data, 0x00, indio_dev->scan_bytes);
> 
> This should be unnecessary as the priv data is kzalloc'd in the first place, so
> all we can do here is leak old timestamps or channel values (actually timestamps
> can't leak anyway because either we write it or it never goes in the buffer, but
> that's harder to explain ;)
> 

Ok, I'll remove it

> 
> > +		have_valid_data = 0;
> > +		for (i = 0; i < scan_channel_count; i++) {
> > +			ret = ti_ads7142_data_buffer_read(client,
> > +							  sizeof(data_buffer),
> > +							  &data_buffer);
> > +			if (ret)
> > +				return ret;
> > +			data_buffer = be16_to_cpu(data_buffer);
> 
> Definitely preferred to have two local variables when doing endian conversions
> Lets use track what endian a particular one is.  Not to mention you'll get
> static checker warnings on this as it stands.
>

I'll correct this. Thank you for explanation
 
> 
> > +			data_valid = data_buffer & 1;
> > +			if (!data_valid) {
> > +				ret = -ENOENT;
> > +				break;
> > +			}
> > +
> > +			channel_address = (data_buffer >> 1) & 0x7;
> 
> FIELD_GET() perhaps?
> 
> > +			if (!(seq_channels & 1 << channel_address)) {
> 
> test_bit()

Ok, I'll do that

> 
> > +				dev_err(indio_dev->dev.parent,
> > +					"%s: invalid channel address(%d)",
> > +					__func__, channel_address);
> > +				return -EIO;
> > +			}
> > +
> > +			value = data_buffer >> 4;
> > +			buffer[channel_address] = value;
> > +			have_valid_data = 1;
> > +			if (channel_collected)
> > +				*channel_collected |= 1 << channel_address;
> > +		}
> > +
> > +		if (!have_valid_data)
> > +			continue;
> > +
> > +		j = 0;
> > +		for_each_set_bit(i, indio_dev->active_scan_mask,
> > +				 indio_dev->masklength) {
> 
> This confuses me somewhat.  The code above appears to suggest that you will only
> be reading the entries you want anyway, so why can you not just fill scan_data
> directly in that loop?
> 

This is because the buffer[] indexed with channel_address value, reported by the device
 for the conversion result, and if only the AIN1 selected for scanning, the conversion
 result goes to buffer[1], but scan_bytes in this case is 2, so the
 iio_push_to_buffers_with_timestamp will shows the priv->scan_data[0] to the user.

> > +			priv->scan_data[j] = buffer[i];
> > +			j++;
> > +		}
> > +		iio_push_to_buffers_with_timestamp(indio_dev, priv->scan_data,
> > +						   iio_get_time_ns(indio_dev));
> > +	} while (data_valid);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ti_ads7142_buffered_abort(struct iio_dev *indio_dev)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = ti_ads7142_sequence_abort(indio_dev);
> > +	if (!ret)
> > +		priv->monitor_pending = false;
> 
> For consistency / readability it's usually better to have the error path 
> out of line.  Just saves a few brain cycles for reviewers.
> 
> 	if (ret)
> 		return ret;
> 
> 	priv->monitoring_pending = false;
> 
> 	return 0;
> 

Ok, I'll do that

> > +
> > +	return ret;
> > +}
> > +
> > +static int ti_ads7142_manual_read(struct iio_dev *indio_dev,
> > +				  int address, int *val)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> > +	u16 data_buffer;
> > +	int ret;
> > +
> > +	mutex_lock(&priv->lock);
> > +	ret = ti_ads7142_sequence_abort(indio_dev);
> > +	if (ret)
> > +		goto final;
> > +
> > +	ret = ti_ads7142_osc_set(indio_dev);
> 
> There seems to be an awful lot to do just to read a single channel.
> Can some of this be avoided with appropriate caching of registers?
> 
> Often people will read the same channel multiple times without changing anything
> so ti would be nice to make that lighter weight if possible.
> 

I'll use regmap

> > +	if (ret)
> > +		goto final;
> > +
> > +	ret = ti_ads7142_input_cfg_set(indio_dev);
> > +	if (ret)
> > +		goto final;
> > +
> > +	ret = ti_ads7142_dout_format_set(indio_dev);
> > +	if (ret)
> > +		goto final;
> > +
> > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_OPMODE_SEL,
> > +				   TI_ADS7142_OPMODE_SEL_MANUALSEQ);
> > +	if (ret)
> > +		goto final;
> > +
> > +	ret = ti_ads7142_reg_write(client, TI_ADS7142_AUTO_SEQ_CHEN,
> > +				   1 << address);
> > +	if (ret)
> > +		goto final;
> > +
> > +	ret = ti_ads7142_sequence_start(indio_dev);
> > +	if (ret)
> > +		goto final;
> > +
> > +	ret = ti_ads7142_data_buffer_read(client, sizeof(data_buffer),
> > +					  &data_buffer);
> > +	if (ret)
> > +		goto abort;
> > +
> > +	*val = (be16_to_cpu(data_buffer) >> 4);
> 
> data_buffer should be __be16.  Unless there is a very strong reason, we
> maintain the endian markings on variables as it allows a bunch of automated
> checking to find places where we've messed up or forgotten a conversion.
> 

Ok, I'll do that. Thank you for explanation

> > +
> > +abort:
> > +	ret = ti_ads7142_sequence_abort(indio_dev);
> > +final:
> > +	mutex_unlock(&priv->lock);
> > +	return ret;
> > +}
> > +
> > +static irqreturn_t ti_ads7142_ist(int irq, void *dev_id)
> > +{
> > +	struct iio_dev *indio_dev = dev_id;
> > +	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	struct ti_ads7142_channel *channel;
> > +	u8 low_flags;
> > +	u8 high_flags;
> > +	u8 seq_st;
> > +	int i;
> > +	int ret;
> > +	int channel_collected;
> > +	s64 timestamp = iio_get_time_ns(indio_dev);
> > +
> > +	mutex_lock(&priv->lock);
> > +	if (!priv->config.buffer_mode || !priv->monitor_pending) {
> > +		mutex_unlock(&priv->lock);
> 
> Use the err_unlock label you've defined for these cases.
> 

You are right

> > +		return IRQ_NONE;
> > +	}
> > +
> > +	/*
> > +	 * BUSY/PDY fires when the sequence stopped in
> > +	 * trigger handler(ti_ads7142_trigger_handler),
> 
> Please wrap closer to 80 chars unless there is a strong reason
> to do pretty formatting at a lower number of characters per line.
>

I'll pay more attention

> > +	 * if buffer mode is stop_burst, all the required
> > +	 * operations are in trigger handler, so irq handler
> > +	 * simple returns at this point.
> > +	 */
> > +	if (priv->config.buffer_mode == TI_ADS7142_BUFFM_STOP_BURST) {
> > +		mutex_unlock(&priv->lock);
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	ret = ti_ads7142_reg_read(client, TI_ADS7142_SEQUENCE_STATUS, &seq_st);
> > +	if (ret) {
> > +		dev_err(indio_dev->dev.parent,
> > +			"%s: SEQUENCE_STATUS reg read error(%i)",
> > +			__func__, ret);
> > +		goto err_unlock;
> > +	}
> > +
> > +	if ((seq_st & TI_ADS7142_SEQUENCE_STATUS_SEQ_ERR_ST_MSK)
> > +	    != TI_ADS7142_SEQUENCE_STATUS_SEQ_ENABLED) {
> 
> Perhaps use FIELD_GET() and friends to make this a little more readable?
> 
> > +		dev_err(indio_dev->dev.parent,
> 
> Perhaps worth a local variable for indio_dev->dev.parent given you are
> using it a lot.
> 

Ok, I'll do that

> > +			"%s: SEQUENCE_STATUS error(%i)",
> > +			__func__, seq_st);
> > +		goto err_unlock;
> > +	}
> > +
> > +	ret = ti_ads7142_reg_read(client, TI_ADS7142_ALT_LOW_FLAGS,
> > +				  &low_flags);
> > +	if (ret) {
> > +		dev_err(indio_dev->dev.parent,
> > +			"%s: ALT_LOW_FLAGS reg read error(%i)",
> > +			__func__, ret);
> 
> Never bother printing __func__ explicitly.  The kernel's dynamic debug can be
> used to add that information at runtime if anyone wants it.
>

Ok, I'll correct this log messages.
 
> > +		goto err_unlock;
> > +	}
> > +
> > +	ret = ti_ads7142_reg_read(client, TI_ADS7142_ALT_HIGH_FLAGS,
> > +				  &high_flags);
> > +	if (ret) {
> > +		dev_err(indio_dev->dev.parent,
> > +			"%s: ALT_HIGH_FLAGS reg read error(%i)",
> > +			__func__, ret);
> > +		goto err_unlock;
> > +	}
> > +
> > +	ret = ti_ads7142_sequence_abort(indio_dev);
> > +	if (ret)
> > +		goto err_unlock;
> > +
> > +	priv->monitor_pending = false;
> > +
> > +	channel_collected = 0;
> > +	ret = ti_ads7142_buffered_collect(indio_dev, &channel_collected);
> > +	if (ret && ret != -ENOENT) {
> > +		dev_err(indio_dev->dev.parent,
> > +			"%s: error(%d) when collecting result for %s mode",
> > +			__func__, ret,
> > +			ti_ads7142_buffer_modes[priv->config.buffer_mode]);
> > +		goto err_unlock;
> > +	}
> > +
> > +	if (!channel_collected)
> > +		goto out_unlock;
> > +
> > +	if (priv->config.buffer_mode < TI_ADS7142_BUFFM_PRE_ALERT)
> > +		goto out_unlock;
> > +
> > +	for_each_set_bit(i, indio_dev->active_scan_mask,
> > +			 indio_dev->masklength) {
> > +		channel = ti_ads7142_address2channel(indio_dev, i);
> > +		if (!channel)
> > +			goto err_unlock;
> > +
> > +		if (!(channel_collected & (1 << channel->channel)))
> > +			continue;
> > +		if (channel->config.alert_low &&
> 
> Silly question, but if these aren't being collected, can the flags be set?
> I.e. do you need to protect this with which channels were collected, or could
> you just check them all anyway?
> 

Probably no, but I never tested without this. I'll test it.

> I mention it below, but the fact events are dependent on IRQ should change
> what is visible to userspace.
> 

You are right, I'll fix this

> > +		    (low_flags & (1 << channel->channel))) {
> > +			iio_push_event(indio_dev,
> > +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> > +							    i,
> > +							    IIO_EV_TYPE_THRESH,
> > +							    IIO_EV_DIR_FALLING),
> > +				       timestamp);
> > +		}
> > +
> > +		if (channel->config.alert_high &&
> > +		    (high_flags & (1 << channel->channel))) {
> > +			iio_push_event(indio_dev,
> > +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> > +							    i,
> > +							    IIO_EV_TYPE_THRESH,
> > +							    IIO_EV_DIR_RISING),
> > +				       timestamp);
> > +		}
> > +	}
> > +
> > +out_unlock:
> > +	if (priv->config.buffer_mode >= TI_ADS7142_BUFFM_PRE_ALERT) {
> > +		ret = ti_ads7142_buffered_setup_and_start(indio_dev);
> > +		if (ret) {
> > +			dev_err(indio_dev->dev.parent,
> > +				"%s: error(%d) when starting %s mode",
> > +				__func__, ret,
> > +				ti_ads7142_buffer_modes[priv->config.buffer_mode]);
> > +			goto err_unlock;
> > +		}
> > +	}
> > +	mutex_unlock(&priv->lock);
> > +	return IRQ_HANDLED;
> > +
> > +err_unlock:
> > +	mutex_unlock(&priv->lock);
> > +	return IRQ_NONE;
> > +}
> > +
> > +static int ti_ads7142_read_raw(struct iio_dev *indio_dev,
> > +			       struct iio_chan_spec const *chan,
> > +			       int *val, int *val2, long info)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (iio_buffer_enabled(indio_dev))
> > +			return -EBUSY;
> 
> If buffer is enabled, claim_direct_mode() will fail so no advantage
> in checking iio_buffer_enabled() here.
> 
> The purpose of claim_direct_mode() is to avoid the races we'd otherwise
> get with a simple check of whether the buffer is enabled at the start
> of a function like this.
> 

Ok, I'll remove it. Thank you for explanation

> > +		ret = iio_device_claim_direct_mode(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +		ret = ti_ads7142_manual_read(indio_dev, chan->address,
> > +					     val);
> > +		if (!ret)
> > +			ret = IIO_VAL_INT;
> > +		iio_device_release_direct_mode(indio_dev);
> > +		return ret;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		ti_ads7142_osc_calc_get(indio_dev, val);
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		if (!priv->avdd)
> > +			return -EINVAL;
> > +
> > +		*val = regulator_get_voltage(priv->avdd) / 1000;
> > +		*val2 = (1 << chan->scan_type.realbits) - 1;
> > +		return IIO_VAL_FRACTIONAL;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
...
> > +static int ti_ads7142_triggered_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (!priv->config.buffer_mode)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Start/stop burst buffer modes requires trigger
> 	/* Start/stop... */
> 
> Use one line comment syntax when they fit on one line.
> 

Ok, I'll corret it

> > +	 */
> > +	if (priv->config.buffer_mode <= TI_ADS7142_BUFFM_START_BURST &&
> > +	    !indio_dev->trig) {
> > +		dev_err(indio_dev->dev.parent,
> > +			"%s: Start/stop burst buffer modes requires trigger",
> > +			__func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * Start burst and pre/post alert modes requires irq
> 
> If so, then don't present them as options if we don't have an irq.
> 

You are right, without IRQ only stop_burst is available.

> > +	 */
> > +	if (priv->config.buffer_mode >= TI_ADS7142_BUFFM_START_BURST &&
> > +	    !priv->irq_present) {
> > +		dev_err(indio_dev->dev.parent,
> > +			"%s: Start burst and pre/post alert modes requires irq",
> > +			__func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	mutex_lock(&priv->lock);
> > +	/*
> > +	 * Start burst mode started in trigger handler.
> > +	 * Sequencer aborted here, just for safe.
> > +	 */
> > +	if (priv->config.buffer_mode == TI_ADS7142_BUFFM_START_BURST)
> > +		ret = ti_ads7142_buffered_abort(indio_dev);
> > +	else
> > +		ret = ti_ads7142_buffered_setup_and_start(indio_dev);
> > +	mutex_unlock(&priv->lock);
> > +
> > +	return ret;
> > +}
> > +
...
> > +
> > +static irqreturn_t ti_ads7142_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	int ret = 0;
> > +
> > +	mutex_lock(&priv->lock);
> > +	if (priv->config.buffer_mode == TI_ADS7142_BUFFM_STOP_BURST) {
> > +		ret = ti_ads7142_buffered_abort(indio_dev);
> > +		if (ret) {
> > +			dev_err(indio_dev->dev.parent,
> > +				"%s: error(%d) when aborting in %s mode",
> > +				__func__, ret,
> > +				ti_ads7142_buffer_modes[priv->config.buffer_mode]);
> > +			goto err_unlock;
> > +		}
> > +
> > +		ret = ti_ads7142_buffered_collect(indio_dev, NULL);
> > +		if (ret && ret != -ENOENT) {
> > +			dev_err(indio_dev->dev.parent,
> > +				"%s: error(%d) when collecting result for %s mode",
> > +				__func__, ret,
> > +				ti_ads7142_buffer_modes[priv->config.buffer_mode]);
> > +			goto err_unlock;
> > +		}
> > +	}
> > +	if (priv->config.buffer_mode == TI_ADS7142_BUFFM_START_BURST ||
> > +	    priv->config.buffer_mode == TI_ADS7142_BUFFM_STOP_BURST) {
> > +		ret = ti_ads7142_buffered_setup_and_start(indio_dev);
> > +		if (ret) {
> > +			dev_err(indio_dev->dev.parent,
> > +				"%s: error(%d) when starting %s mode",
> > +				__func__, ret,
> > +				ti_ads7142_buffer_modes[priv->config.buffer_mode]);
> > +			goto err_unlock;
> 
> What code to return when you get an error in an interrupt handler is always
> an interesting question.   However, in this case we've handled the interrupt, but
> not restarted capture.  Returning IRQ_NONE doesn't feel right.
> 

You are right, but who knows what happends with the device.
In this case, what about iio_trigger_notify_done? It reenables the pollfunc.

> > +		}
> > +	}
> > +
> > +	mutex_unlock(&priv->lock);
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +
> > +err_unlock:
> > +	mutex_unlock(&priv->lock);
> > +	return IRQ_NONE;
> > +}
> > +
> > +static int ti_ads7142_get_buffer_mode(struct iio_dev *indio_dev,
> > +				      const struct iio_chan_spec *chan)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +
> > +	return priv->config.buffer_mode;
> > +}
> > +
> > +static int ti_ads7142_set_buffer_mode(struct iio_dev *indio_dev,
> > +				      const struct iio_chan_spec *chan,
> > +				      unsigned int mode)
> > +{
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (mode > TI_ADS7142_BUFFM_STOP_BURST && !priv->irq_present) {
> 
> If irq isn't present, then the interface should never be presented in the
> first place.  The best ABI for a control not being usable is to not be
> able to see the control in the first place.
> 

Ok, I'll do that

> > +		dev_err(indio_dev->dev.parent,
> > +			"%s: no irq(BUSY/RDY) specified, mode %s is not supported",
> > +			__func__, ti_ads7142_buffer_modes[mode]);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = iio_device_claim_direct_mode(indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	priv->config.buffer_mode = mode;
> > +	iio_device_release_direct_mode(indio_dev);
> > +	return 0;
> > +}
> > +
> > +static int ti_ads7142_probe(struct i2c_client *client,
> > +			    const struct i2c_device_id *id)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct ti_ads7142_priv *priv;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*priv));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	i2c_set_clientdata(client, indio_dev);
> > +	priv = iio_priv(indio_dev);
> > +
> > +	/**
> > +	 * starting from v5.9-rc1 iio_device_alloc
> > +	 *  sets indio_dev->dev.parent, but older versions not :(
> 
> /** means kernel doc and this isn't.
> 
> 	/*
> 	 * starting from...
> 
> However, I'm not sure there is huge benefit carrying a comment relevant to
> backporting in a driver we take upstream.  There are lots of other things
> that will need changing if you go back a significant distance, and we don't
> want to call them all out.
> 
> 

Sorry, I noted this for myself, because my target platform is 5.1

> > +	 **/
> > +	if (!indio_dev->dev.parent)
> > +		indio_dev->dev.parent = &client->dev;
> > +	indio_dev->name = TI_ADS7142_NAME;
> > +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> > +	indio_dev->info = &ti_ads7142_iio_info;
> > +
> > +	priv->avdd = devm_regulator_get(&client->dev, "avdd");
> > +	if (IS_ERR(priv->avdd))
> > +		return PTR_ERR(priv->avdd);
> > +
> > +	if (priv->avdd) {
> > +		ret = regulator_enable(priv->avdd);
> As below, I don't see why you need the protections in here.  It'll do
> some pointless calling of stubs, but it should work.
> 
> The only thing that won't is if you query the voltage anywhere.
> 

Ok, I'll remove this checks.

> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = devm_add_action_or_reset(&client->dev,
> > +					       ti_ads7142_regulator_disable,
> > +					       priv->avdd);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	priv->dvdd = devm_regulator_get(&client->dev, "dvdd");
> > +	if (IS_ERR(priv->dvdd))
> > +		return PTR_ERR(priv->dvdd);
> > +
> > +	if (priv->dvdd) {
> > +		ret = regulator_enable(priv->dvdd);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = devm_add_action_or_reset(&client->dev,
> > +					       ti_ads7142_regulator_disable,
> > +					       priv->dvdd);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ret = ti_ads7142_soft_reset(client);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ti_ads7142_parse_config(&client->dev, indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_init(&priv->lock);
> > +
> > +	if (client->irq) {
> 
> As irq is optional, I'd expect to see some control over what channel elements
> are presented depending on whether we have one or not.  Normally that's a case
> of picking between static channel definition arrays for _events and _no_events.
> 

Ok, I'll do that

> > +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> > +						NULL, ti_ads7142_ist,
> > +						IRQF_ONESHOT | IRQF_SHARED,
> > +						dev_name(&client->dev),
> > +						indio_dev);
> > +		if (ret) {
> > +			dev_err(&client->dev, "Unable to request IRQ %i",
> > +				client->irq);
> > +			return ret;
> > +		}
> > +		priv->irq_present = true;
> > +	}
> > +
> > +	ret = devm_iio_triggered_buffer_setup(&client->dev,
> > +					      indio_dev,
> > +					      &iio_pollfunc_store_time,
> > +					      &ti_ads7142_trigger_handler,
> > +					      &ti_ads7142_triggered_buffer_ops);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +
> > +static int __maybe_unused ti_ads7142_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +
> > +	mutex_lock(&priv->lock);
> > +	do {
> > +		/*
> > +		 * Keep all regulators on when the device in autonomous
> > +		 *  monitoring mode.
> > +		 * The device can wake up the system with ALERT pin
> > +		 */
> > +		if (priv->monitor_pending &&
> > +		    (priv->config.buffer_mode == TI_ADS7142_BUFFM_PRE_ALERT ||
> > +		     priv->config.buffer_mode == TI_ADS7142_BUFFM_POST_ALERT))
> > +			continue;
> > +
> > +		if (priv->avdd)
> > +			regulator_disable(priv->avdd);
> 
> Same comments as for resume()
> 

Ok, I'll remove these checks

> > +		if (priv->dvdd)
> > +			regulator_disable(priv->dvdd);
> > +	} while (0);
> > +	mutex_unlock(&priv->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused ti_ads7142_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > +	struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> > +	int ret = 0;
> > +
> > +	mutex_lock(&priv->lock);
> > +	do {
> > +		/*
> > +		 * Nothing to do when the device in autonomous monitoring mode.
> > +		 */
> > +		if (priv->monitor_pending &&
> > +		    (priv->config.buffer_mode == TI_ADS7142_BUFFM_PRE_ALERT ||
> > +		     priv->config.buffer_mode == TI_ADS7142_BUFFM_POST_ALERT))
> > +			continue;
> > +
> > +		if (priv->avdd) {
> > +			ret = regulator_enable(priv->avdd);
> 
> As the only way (I think) that avdd can be NULL is because CONFIG_REGULATOR=n
> we would then hit the stubs and for regulator_enable() that should be fine
> https://elixir.bootlin.com/linux/v5.13-rc1/source/include/linux/regulator/consumer.h#L416
> 
> So you should not need these protections.
> 
> > +			if (ret)
> > +				continue;
> > +		}
> > +		if (priv->dvdd) {
> > +			ret = regulator_enable(priv->dvdd);
> > +			if (ret)
> > +				continue;
> > +		}
> > +	} while (0);
> 
> Rather than a do / while, the more common kernel style is to use goto and a label
> just before the mutex_unlock()  Either works, but goto has advantage of not
> adding to indent level for no particular gain.
>

Ok, I'll change it to goto
 
> 
> > +	mutex_unlock(&priv->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(ti_ads7142_pm_ops, ti_ads7142_suspend,
> > +			 ti_ads7142_resume);
> > +
> > +static const struct i2c_device_id ti_ads7142_id[] = {
> > +	{ TI_ADS7142_NAME, 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ti_ads7142_id);
> > +
> > +static const struct of_device_id ti_ads7142_of_match[] = {
> > +	{ .compatible = "ti,ads7142" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, ti_ads7142_of_match);
> > +
> > +static struct i2c_driver ti_ads7142_driver = {
> > +	.driver = {
> > +		.name = TI_ADS7142_NAME,
> > +		.of_match_table = ti_ads7142_of_match,
> > +		.pm = &ti_ads7142_pm_ops,
> > +	},
> > +	.probe		= ti_ads7142_probe,
> > +	.id_table	= ti_ads7142_id,
> > +};
> > +
> > +module_i2c_driver(ti_ads7142_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Jozsef Horvath <info@ministro.hu>");
> > +MODULE_DESCRIPTION("Texas Instruments ADS7142 ADC driver");
> 

Thank you

Best regards
József

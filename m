Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6455519EB66
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 15:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgDENEB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 09:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgDENEB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 09:04:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 814C520672;
        Sun,  5 Apr 2020 13:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586091840;
        bh=/zIggEWmd9IzVWdyyi2lM+j/xEjWAjQDXXWFuJUba7g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EYoMQsT9sXqVS5m+yWRskgIVJr7gav3gERS4Dzt85KRQpl0ZuzenvQYzfZsVnuHFZ
         YMfFh1EJqJiAmf+vrt6irIDGag91fHyMtR7kdcYNW6/G7FVqgywfKpJMajIzI4puUs
         mqB7JGg37J66OXIhOcK4iOm4X7IykmNkD+Vo3kqc=
Date:   Sun, 5 Apr 2020 14:03:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     yarl-baudig@mailoo.org
Cc:     denis.ciocca@st.com, linux-iio@vger.kernel.org
Subject: Re: lsm303dlhc magnetometer: please help
Message-ID: <20200405140356.15700701@archlinux>
In-Reply-To: <ea-mime-5e8880d8-2b90-69383931@www-2.mailo.com>
References: <ea-mime-5e8880d8-2b90-69383931@www-2.mailo.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  4 Apr 2020 14:43:04 +0200 (CEST)
yarl-baudig@mailoo.org wrote:

> Good afternoun,
> 
> I have an lsm303dlhc that I'm trying to get to work with a triggered buffer, the magnetometer part of it.
> The problem with this sensor is that the dataready signal has, I think, a different
> meaning than the one expected by the ST sensor driver set.
> On this sensor the signal is always high except when the sensor is writing new values to its data
> registers. The problem with the driver is that it expects the sensor to have a register
> to check if new data is available:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/iio/common/st_sensors/st_sensors_trigger.c?h=testing#n36
> the lsm303dlhc magnetometer is not configured with such a register:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/iio/magnetometer/st_magn_core.c?h=testing#n183
> There is one in the sensor but the dataready bit is just the value of the signal, so
> even if I added the address and mask for this information, the meaning would be
> wrong from the point of view of  function and the while loop would run endlessly:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/iio/common/st_sensors/st_sensors_trigger.c?h=testing#n113
> 
Looking at the datasheet, it is a rather dumb device isn't it and the datasheet
doesn't supply anywhere near enough info..  It says it's a system in package
so in theory we could find out what the sensor actually is and that might
have a better datasheet.

Then we have the data ready bit as you say and a lock bit that fires when we
successfully start reading (ensuring we get a full set from the same 'scan')
The dataready bit description says:
"Data-ready bit. This bit is when a new set of measurements is available."
I admit I'm reading between the lines, but that sounds like it will clear when
the data has been read.  If it clears on it's own then there isn't much
we can do reliably.

We could just treat the irq as a iio-trigger-interrupt trigger as long as we definitely don't
need to do anything to clear it.  That will not hit any of the paths you are
looking at as will directly call st_sensors_trigger_handler.

Unfortunately that doesn't seem to have a device tree binding yet (obviously
not much used except on very old platforms). I don't have a handy platform to
test it on at the moment unfortunately but should just be a case of adding
a device tree id table to the driver.  Then the dt entry will simply contain
the interrupt line.

Denis, any more info on this part and whether the using a dumb interrupt trigger
is the way to go or if we can do anything more clever?

It may be a case where the best bet is to ignore that line and use a high
resolution time trigger running at half the raw sampling frequency of the device
(to avoid repeated values)

Thanks,

Jonathan


> I then modified a bit, patch below.
> 
> Let me first tell you that it work one out of two time:
> I boot, load this device-tree:
> ---
> /dts-v1/;
> /plugin/;
> 
> / {
>   compatible = "brcm,bcm2708";
> 
>   fragment@0 {
>     target = <&gpio>;
>     __overlay__ {
>       magn_pins: nine_dof_pins {
>         brcm,pins = <27>;
>         brcm,function = <0>;
>         brcm,pull = <1>;
>         status = "okay";
>       };
>     };
>   };
> 
>   fragment@1 {
>     target = <&i2c_arm>;
>     __overlay__ {
>       status = "okay";
>       #address-cells = <1>;
>       #size-cells = <0>;
>       magn@1e {
>         compatible = "st,lsm303dlhc-magn";
>         reg = <0x1e>;
>         status = "okay";
>         interrupt-parent = <&gpio>;
>         interrupts = <27 1>;
>       };
>     };
>   };
> };
> ---
> I then enable scan_elements, enable buffer (echo 1 > buffer/enable)
> interrupts are coming regularly at sampling_frequency. It works fine.
> If I now disable the buffer then re-enable it, one and only interrupt,
> doesn't work fine..
> re-disable, re-re-enable: works fine!
> and it seem to be always that, it works modulo 2.
> 
> On my first try I didn't change st_magn_buffer_preenable and st_magn_buffer_postenable
> But I thought that maybe, the problem was some sort of bad writting, reading timing
> because 
> (1) request_threaded_irq is called for a rising signal while it is already high.
> 
> I make a break here and ask you a question:
> As you read, I am a kernel newbie: is doing (1) bad?
Interesting question.  There is so little info in the datasheet that it is hard
to tell. It might be a level_high interrupt.

> end of break.
> 
> So I added st_magn_buffer_preenable and modified st_magn_buffer_postenable to
> try to mask the irq during the arppropriate interval.
> 
> No visible change.
> I never almost never wrote kernel code before.
> I tried to get closer to what was happening using gdb/kgdb, first time I used this.
> I am now pretty discouraged and any suggestions are welcome.
> 
> Thank you.
> 
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 11 +++++++++++
>  .../iio/common/st_sensors/st_sensors_trigger.c  |  9 +++++++++
>  drivers/iio/magnetometer/st_magn_buffer.c       | 17 ++++++++++++++++-
>  drivers/iio/magnetometer/st_magn_core.c         |  3 +++
>  include/linux/iio/common/st_sensors.h           |  2 ++
>  5 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 09279e40c55c..fef6b70976b4 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -480,6 +480,17 @@ int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
>  	u8 drdy_addr, drdy_mask;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
> +	if (sdata->sensor_settings->drdy_irq.simple) {
> +		/*
> +		 * some devices very simple. No register to enable, disable
> +		 * or configure the signal. Actually, when it is low it means that
> +		 * sensor is writing data to its register, when it is high it
> +		 * means that data can be read. i.e when rising new data is available.
> +		 */
> +		sdata->hw_irq_trigger = enable;
> +		return 0;
> +	}
> +
>  	if (!sdata->sensor_settings->drdy_irq.int1.addr &&
>  	    !sdata->sensor_settings->drdy_irq.int2.addr) {
>  		/*
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index fdcc5a891958..146aaae0a85c 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -30,6 +30,13 @@ static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
>  	u8 status;
>  	int ret;
>  
> +	/* We simply trust the signal */
> +	if (sdata->sensor_settings->drdy_irq.simple) {
> +		if (indio_dev->active_scan_mask)
> +			return 1;
> +		return 0;
> +	}
> +
>  	/* How would I know if I can't check it? */
>  	if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
>  		return -EINVAL;
> @@ -90,6 +97,8 @@ static irqreturn_t st_sensors_irq_thread(int irq, void *p)
>  	if (sdata->hw_irq_trigger &&
>  	    st_sensors_new_samples_available(indio_dev, sdata)) {
>  		iio_trigger_poll_chained(p);
> +		if (sdata->sensor_settings->drdy_irq.simple)
> +			return IRQ_HANDLED;
>  	} else {
>  		dev_dbg(sdata->dev, "spurious IRQ\n");
>  		return IRQ_NONE;
> diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
> index 37ab30566464..ae13e4339127 100644
> --- a/drivers/iio/magnetometer/st_magn_buffer.c
> +++ b/drivers/iio/magnetometer/st_magn_buffer.c
> @@ -30,6 +30,16 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
>  	return st_sensors_set_dataready_irq(indio_dev, state);
>  }
>  
> +static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct st_sensor_data *mdata = iio_priv(indio_dev);
> +
> +	if (mdata->sensor_settings->drdy_irq.simple) {
> +		disable_irq(mdata->get_irq_data_ready(indio_dev));
> +	}
> +	return 0;
> +}
> +
>  static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	int err;
> @@ -45,7 +55,11 @@ static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>  	if (err < 0)
>  		goto st_magn_buffer_postenable_error;
>  
> -	return st_sensors_set_enable(indio_dev, true);
> +	err = st_sensors_set_enable(indio_dev, true);
> +
> +	enable_irq(mdata->get_irq_data_ready(indio_dev));
> +
> +	return err;
>  
>  st_magn_buffer_postenable_error:
>  	kfree(mdata->buffer_data);
> @@ -70,6 +84,7 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
>  }
>  
>  static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
> +	.preenable = &st_magn_buffer_preenable,
>  	.postenable = &st_magn_buffer_postenable,
>  	.predisable = &st_magn_buffer_predisable,
>  };
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 72f6d1335a04..0fb0915529e9 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -259,6 +259,9 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
>  				},
>  			},
>  		},
> +    .drdy_irq = {
> +      .simple = true,
> +    },
>  		.multi_read_bit = false,
>  		.bootime = 2,
>  	},
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index f9bd6e8ab138..e25b5f033557 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -154,6 +154,7 @@ struct st_sensor_int_drdy {
>   * struct ig1 - represents the Interrupt Generator 1 of sensors.
>   * @en_addr: address of the enable ig1 register.
>   * @en_mask: mask to write the on/off value for enable.
> + * @simple: the data-ready is a "very simple implementation".
>   */
>  struct st_sensor_data_ready_irq {
>  	struct st_sensor_int_drdy int1;
> @@ -168,6 +169,7 @@ struct st_sensor_data_ready_irq {
>  		u8 en_addr;
>  		u8 en_mask;
>  	} ig1;
> +	bool simple;
>  };
> 
> 


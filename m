Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC3C17CE47
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 14:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgCGNFH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 08:05:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgCGNFH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 08:05:07 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 211142073C;
        Sat,  7 Mar 2020 13:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583586305;
        bh=ONFocAkrUcHoVQEyEgxN8icyVv9InTwdB8WDDcNQl3s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Fk/1wobdEc6sU534pRZd2KrZ37yXXxMQr8Q2ehM2euopFA6qmaIqDQ6oqWbMXBAW
         JfadcYCR6HYmc3RHJBFxN7QAIxSo4C3Dx7OXVDut9zQgft2A9LOFnQQlUizkXw4l8T
         F0XX2JvnrWwYNPL7Qd+O6Jt23hjADUvwQEHAFrtI=
Date:   Sat, 7 Mar 2020 13:05:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] counter: 104-quad-8: Support Differential Encoder
 Cable Status
Message-ID: <20200307130502.5b27b73e@archlinux>
In-Reply-To: <20200301220719.25173-1-vilhelm.gray@gmail.com>
References: <20200301220719.25173-1-vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  1 Mar 2020 17:07:19 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The ACCES 104-QUAD-8 series provides status information about the
> connection state of the differential encoder cable inputs. This patch
> implements support to expose such information from these devices.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Looks good to me.  Applied to the togreg branch of iio.git
and pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v3:
>  - Split cable_status attribute into cable_fault and cable_fault_enable;
>    both under each Signal so we can control each channel independently
>  - Initialize to a default state of disabled for all channels
> 
>  .../ABI/testing/sysfs-bus-counter-104-quad-8  | 18 +++++
>  drivers/counter/104-quad-8.c                  | 75 +++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> index 3c905d3cf5d7..eac32180c40d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> @@ -1,3 +1,21 @@
> +What:		/sys/bus/counter/devices/counterX/signalY/cable_fault
> +KernelVersion:	5.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates whether a differential
> +		encoder cable fault (not connected or loose wires) is detected
> +		for the respective channel of Signal Y. Valid attribute values
> +		are boolean. Detection must first be enabled via the
> +		corresponding cable_fault_enable attribute.
> +
> +What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable
> +KernelVersion:	5.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Whether detection of differential encoder cable faults for the
> +		respective channel of Signal Y is enabled. Valid attribute
> +		values are boolean.
> +
>  What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler
>  KernelVersion:	5.7
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 0cfc813ee2cb..9dab190c49b0 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -31,6 +31,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>  /**
>   * struct quad8_iio - IIO device private data structure
>   * @counter:		instance of the counter_device
> + * @fck_prescaler:	array of filter clock prescaler configurations
>   * @preset:		array of preset values
>   * @count_mode:		array of count mode configurations
>   * @quadrature_mode:	array of quadrature mode configurations
> @@ -39,6 +40,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>   * @preset_enable:	array of set_to_preset_on_index attribute configurations
>   * @synchronous_mode:	array of index function synchronous mode configurations
>   * @index_polarity:	array of index function polarity configurations
> + * @cable_fault_enable:	differential encoder cable status enable configurations
>   * @base:		base port address of the IIO device
>   */
>  struct quad8_iio {
> @@ -52,11 +54,13 @@ struct quad8_iio {
>  	unsigned int preset_enable[QUAD8_NUM_COUNTERS];
>  	unsigned int synchronous_mode[QUAD8_NUM_COUNTERS];
>  	unsigned int index_polarity[QUAD8_NUM_COUNTERS];
> +	unsigned int cable_fault_enable;
>  	unsigned int base;
>  };
>  
>  #define QUAD8_REG_CHAN_OP 0x11
>  #define QUAD8_REG_INDEX_INPUT_LEVELS 0x16
> +#define QUAD8_DIFF_ENCODER_CABLE_STATUS 0x17
>  /* Borrow Toggle flip-flop */
>  #define QUAD8_FLAG_BT BIT(0)
>  /* Carry Toggle flip-flop */
> @@ -1143,6 +1147,66 @@ static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
>  	return len;
>  }
>  
> +static ssize_t quad8_signal_cable_fault_read(struct counter_device *counter,
> +					     struct counter_signal *signal,
> +					     void *private, char *buf)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +	const size_t channel_id = signal->id / 2;
> +	const bool disabled = !(priv->cable_fault_enable & BIT(channel_id));
> +	unsigned int status;
> +	unsigned int fault;
> +
> +	if (disabled)
> +		return -EINVAL;
> +
> +	/* Logic 0 = cable fault */
> +	status = inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
> +
> +	/* Mask respective channel and invert logic */
> +	fault = !(status & BIT(channel_id));
> +
> +	return sprintf(buf, "%u\n", fault);
> +}
> +
> +static ssize_t quad8_signal_cable_fault_enable_read(
> +	struct counter_device *counter, struct counter_signal *signal,
> +	void *private, char *buf)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +	const size_t channel_id = signal->id / 2;
> +	const unsigned int enb = !!(priv->cable_fault_enable & BIT(channel_id));
> +
> +	return sprintf(buf, "%u\n", enb);
> +}
> +
> +static ssize_t quad8_signal_cable_fault_enable_write(
> +	struct counter_device *counter, struct counter_signal *signal,
> +	void *private, const char *buf, size_t len)
> +{
> +	struct quad8_iio *const priv = counter->priv;
> +	const size_t channel_id = signal->id / 2;
> +	bool enable;
> +	int ret;
> +	unsigned int cable_fault_enable;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret)
> +		return ret;
> +
> +	if (enable)
> +		priv->cable_fault_enable |= BIT(channel_id);
> +	else
> +		priv->cable_fault_enable &= ~BIT(channel_id);
> +
> +	/* Enable is active low in Differential Encoder Cable Status register */
> +	cable_fault_enable = ~priv->cable_fault_enable;
> +
> +	outb(cable_fault_enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
> +
> +	return len;
> +}
> +
>  static ssize_t quad8_signal_fck_prescaler_read(struct counter_device *counter,
>  	struct counter_signal *signal, void *private, char *buf)
>  {
> @@ -1180,6 +1244,15 @@ static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
>  }
>  
>  static const struct counter_signal_ext quad8_signal_ext[] = {
> +	{
> +		.name = "cable_fault",
> +		.read = quad8_signal_cable_fault_read
> +	},
> +	{
> +		.name = "cable_fault_enable",
> +		.read = quad8_signal_cable_fault_enable_read,
> +		.write = quad8_signal_cable_fault_enable_write
> +	},
>  	{
>  		.name = "filter_clock_prescaler",
>  		.read = quad8_signal_fck_prescaler_read,
> @@ -1383,6 +1456,8 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  		/* Disable index function; negative index polarity */
>  		outb(QUAD8_CTR_IDR, base_offset + 1);
>  	}
> +	/* Disable Differential Encoder Cable Status for all channels */
> +	outb(0xFF, base[id] + QUAD8_DIFF_ENCODER_CABLE_STATUS);
>  	/* Enable all counters */
>  	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
>  


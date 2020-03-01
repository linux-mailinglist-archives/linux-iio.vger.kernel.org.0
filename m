Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A630E174F81
	for <lists+linux-iio@lfdr.de>; Sun,  1 Mar 2020 21:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCAUSB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 15:18:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgCAUSB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 15:18:01 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A436246BF;
        Sun,  1 Mar 2020 20:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583093880;
        bh=v8CQ/Vk08LpPLK20LK0xMU0V8MT8aNDZSukNATFwahU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y5k/FuSN/Qqlh0hjHkCDS9G9eSk8RYH1CwXShlGbG5yfALvuqToeJHLHCiFblB4+G
         0to24IEan09DFuN3JwXS0p+ep6C/yJ7ReGRO1GcLY3h8N9yYOfTfCOghObIwUGXWEH
         vS4ZWFEyQU96EBmE9pA+5S9ZySgO96EdxIWCKUi4=
Date:   Sun, 1 Mar 2020 20:17:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: 104-quad-8: Support Filter Clock Prescaler
Message-ID: <20200301201752.35014f30@archlinux>
In-Reply-To: <20200222164958.105288-1-vilhelm.gray@gmail.com>
References: <20200222164958.105288-1-vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 22 Feb 2020 11:49:58 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The ACCES 104-QUAD-8 series does active filtering on the quadrature
> input signals via the PC/104 bus clock (OSC 14.318 MHz). This patch
> exposes the filter clock prescaler available on each channel.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Looks good to me.  

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

thanks,

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-counter-104-quad-8  |  7 +++
>  drivers/counter/104-quad-8.c                  | 61 ++++++++++++++++++-
>  2 files changed, 65 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> index 46b1f33b2fce..3c905d3cf5d7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> @@ -1,3 +1,10 @@
> +What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler
> +KernelVersion:	5.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Filter clock factor for input Signal Y. This prescaler value
> +		affects the inputs of both quadrature pair signals.
> +
>  What:		/sys/bus/counter/devices/counterX/signalY/index_polarity
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 17e67a84777d..0cfc813ee2cb 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -43,6 +43,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>   */
>  struct quad8_iio {
>  	struct counter_device counter;
> +	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
>  	unsigned int preset[QUAD8_NUM_COUNTERS];
>  	unsigned int count_mode[QUAD8_NUM_COUNTERS];
>  	unsigned int quadrature_mode[QUAD8_NUM_COUNTERS];
> @@ -84,6 +85,8 @@ struct quad8_iio {
>  #define QUAD8_RLD_PRESET_CNTR 0x08
>  /* Transfer Counter to Output Latch */
>  #define QUAD8_RLD_CNTR_OUT 0x10
> +/* Transfer Preset Register LSB to FCK Prescaler */
> +#define QUAD8_RLD_PRESET_PSC 0x18
>  #define QUAD8_CHAN_OP_ENABLE_COUNTERS 0x00
>  #define QUAD8_CHAN_OP_RESET_COUNTERS 0x01
>  #define QUAD8_CMR_QUADRATURE_X1 0x08
> @@ -1140,6 +1143,50 @@ static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
>  	return len;
>  }
>  
> +static ssize_t quad8_signal_fck_prescaler_read(struct counter_device *counter,
> +	struct counter_signal *signal, void *private, char *buf)
> +{
> +	const struct quad8_iio *const priv = counter->priv;
> +	const size_t channel_id = signal->id / 2;
> +
> +	return sprintf(buf, "%u\n", priv->fck_prescaler[channel_id]);
> +}
> +
> +static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
> +	struct counter_signal *signal, void *private, const char *buf,
> +	size_t len)
> +{
> +	struct quad8_iio *const priv = counter->priv;
> +	const size_t channel_id = signal->id / 2;
> +	const int base_offset = priv->base + 2 * channel_id;
> +	u8 prescaler;
> +	int ret;
> +
> +	ret = kstrtou8(buf, 0, &prescaler);
> +	if (ret)
> +		return ret;
> +
> +	priv->fck_prescaler[channel_id] = prescaler;
> +
> +	/* Reset Byte Pointer */
> +	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> +
> +	/* Set filter clock factor */
> +	outb(prescaler, base_offset);
> +	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
> +	     base_offset + 1);
> +
> +	return len;
> +}
> +
> +static const struct counter_signal_ext quad8_signal_ext[] = {
> +	{
> +		.name = "filter_clock_prescaler",
> +		.read = quad8_signal_fck_prescaler_read,
> +		.write = quad8_signal_fck_prescaler_write
> +	}
> +};
> +
>  static const struct counter_signal_ext quad8_index_ext[] = {
>  	COUNTER_SIGNAL_ENUM("index_polarity", &quad8_index_pol_enum),
>  	COUNTER_SIGNAL_ENUM_AVAILABLE("index_polarity",	&quad8_index_pol_enum),
> @@ -1147,9 +1194,11 @@ static const struct counter_signal_ext quad8_index_ext[] = {
>  	COUNTER_SIGNAL_ENUM_AVAILABLE("synchronous_mode", &quad8_syn_mode_enum)
>  };
>  
> -#define	QUAD8_QUAD_SIGNAL(_id, _name) {	\
> -	.id = (_id),			\
> -	.name = (_name)			\
> +#define QUAD8_QUAD_SIGNAL(_id, _name) {		\
> +	.id = (_id),				\
> +	.name = (_name),			\
> +	.ext = quad8_signal_ext,		\
> +	.num_ext = ARRAY_SIZE(quad8_signal_ext)	\
>  }
>  
>  #define	QUAD8_INDEX_SIGNAL(_id, _name) {	\
> @@ -1314,6 +1363,12 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  		base_offset = base[id] + 2 * i;
>  		/* Reset Byte Pointer */
>  		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> +		/* Reset filter clock factor */
> +		outb(0, base_offset);
> +		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
> +		     base_offset + 1);
> +		/* Reset Byte Pointer */
> +		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
>  		/* Reset Preset Register */
>  		for (j = 0; j < 3; j++)
>  			outb(0x00, base_offset);


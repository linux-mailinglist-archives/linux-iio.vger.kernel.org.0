Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EB131B1E6
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 19:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhBNSUh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 13:20:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhBNSUd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 13:20:33 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93DD264E4E;
        Sun, 14 Feb 2021 18:19:49 +0000 (UTC)
Date:   Sun, 14 Feb 2021 18:19:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 21/22] counter: 104-quad-8: Replace mutex with
 spinlock
Message-ID: <20210214181946.1d2f7e78@archlinux>
In-Reply-To: <d2e72eac404ca5b7c99d8a642f2c07ebb2eb240a.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
        <d2e72eac404ca5b7c99d8a642f2c07ebb2eb240a.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Feb 2021 21:13:45 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch replaces the mutex I/O lock with a spinlock. This is in
> preparation for a subsequent patch adding IRQ support for 104-QUAD-8
> devices; we can't sleep in an interrupt context, so we'll need to use a
> spinlock instead.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Why do these need to be raw_spin_locks?
Normally only need to do that if in code related to interrupt chips etc,
not their use.

Jonathan

> ---
>  drivers/counter/104-quad-8.c | 90 +++++++++++++++++++++---------------
>  1 file changed, 53 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 41fdbd228be3..2b47f9991acc 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/types.h>
> +#include <linux/spinlock.h>
>  
>  #define QUAD8_EXTENT 32
>  
> @@ -28,6 +29,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>  
>  /**
>   * struct quad8 - device private data structure
> + * @lock:		synchronization lock to prevent I/O race conditions
>   * @counter:		instance of the counter_device
>   * @fck_prescaler:	array of filter clock prescaler configurations
>   * @preset:		array of preset values
> @@ -42,7 +44,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>   * @base:		base port address of the device
>   */
>  struct quad8 {
> -	struct mutex lock;
> +	raw_spinlock_t lock;
>  	struct counter_device counter;
>  	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
>  	unsigned int preset[QUAD8_NUM_COUNTERS];
> @@ -123,6 +125,7 @@ static int quad8_count_read(struct counter_device *counter,
>  	unsigned int flags;
>  	unsigned int borrow;
>  	unsigned int carry;
> +	unsigned long irqflags;
>  	int i;
>  
>  	flags = inb(base_offset + 1);
> @@ -132,7 +135,7 @@ static int quad8_count_read(struct counter_device *counter,
>  	/* Borrow XOR Carry effectively doubles count range */
>  	*val = (unsigned long)(borrow ^ carry) << 24;
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	/* Reset Byte Pointer; transfer Counter to Output Latch */
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
> @@ -141,7 +144,7 @@ static int quad8_count_read(struct counter_device *counter,
>  	for (i = 0; i < 3; i++)
>  		*val |= (unsigned long)inb(base_offset) << (8 * i);
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	return 0;
>  }
> @@ -151,13 +154,14 @@ static int quad8_count_write(struct counter_device *counter,
>  {
>  	struct quad8 *const priv = counter->priv;
>  	const int base_offset = priv->base + 2 * count->id;
> +	unsigned long irqflags;
>  	int i;
>  
>  	/* Only 24-bit values are supported */
>  	if (val > 0xFFFFFF)
>  		return -ERANGE;
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	/* Reset Byte Pointer */
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> @@ -182,7 +186,7 @@ static int quad8_count_write(struct counter_device *counter,
>  	/* Reset Error flag */
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	return 0;
>  }
> @@ -200,8 +204,9 @@ static int quad8_function_read(struct counter_device *counter,
>  {
>  	struct quad8 *const priv = counter->priv;
>  	const int id = count->id;
> +	unsigned long irqflags;
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	if (priv->quadrature_mode[id])
>  		switch (priv->quadrature_scale[id]) {
> @@ -218,7 +223,7 @@ static int quad8_function_read(struct counter_device *counter,
>  	else
>  		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	return 0;
>  }
> @@ -233,10 +238,11 @@ static int quad8_function_write(struct counter_device *counter,
>  	unsigned int *const scale = priv->quadrature_scale + id;
>  	unsigned int *const synchronous_mode = priv->synchronous_mode + id;
>  	const int base_offset = priv->base + 2 * id + 1;
> +	unsigned long irqflags;
>  	unsigned int mode_cfg;
>  	unsigned int idr_cfg;
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	mode_cfg = priv->count_mode[id] << 1;
>  	idr_cfg = priv->index_polarity[id] << 1;
> @@ -271,7 +277,7 @@ static int quad8_function_write(struct counter_device *counter,
>  			break;
>  		default:
>  			/* should never reach this path */
> -			mutex_unlock(&priv->lock);
> +			raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  			return -EINVAL;
>  		}
>  	}
> @@ -279,7 +285,7 @@ static int quad8_function_write(struct counter_device *counter,
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	return 0;
>  }
> @@ -407,9 +413,10 @@ static int quad8_index_polarity_set(struct counter_device *counter,
>  	struct quad8 *const priv = counter->priv;
>  	const size_t channel_id = signal->id - 16;
>  	const int base_offset = priv->base + 2 * channel_id + 1;
> +	unsigned long irqflags;
>  	unsigned int idr_cfg = index_polarity << 1;
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	idr_cfg |= priv->synchronous_mode[channel_id];
>  
> @@ -418,7 +425,7 @@ static int quad8_index_polarity_set(struct counter_device *counter,
>  	/* Load Index Control configuration to Index Control Register */
>  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	return 0;
>  }
> @@ -447,15 +454,16 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
>  	struct quad8 *const priv = counter->priv;
>  	const size_t channel_id = signal->id - 16;
>  	const int base_offset = priv->base + 2 * channel_id + 1;
> +	unsigned long irqflags;
>  	unsigned int idr_cfg = synchronous_mode;
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	idr_cfg |= priv->index_polarity[channel_id] << 1;
>  
>  	/* Index function must be non-synchronous in non-quadrature mode */
>  	if (synchronous_mode && !priv->quadrature_mode[channel_id]) {
> -		mutex_unlock(&priv->lock);
> +		raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  		return -EINVAL;
>  	}
>  
> @@ -464,7 +472,7 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
>  	/* Load Index Control configuration to Index Control Register */
>  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	return 0;
>  }
> @@ -511,6 +519,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
>  	unsigned int count_mode;
>  	unsigned int mode_cfg;
>  	const int base_offset = priv->base + 2 * count->id + 1;
> +	unsigned long irqflags;
>  
>  	/* Map Generic Counter count mode to 104-QUAD-8 count mode */
>  	switch (cnt_mode) {
> @@ -531,7 +540,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
>  		return -EINVAL;
>  	}
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	priv->count_mode[count->id] = count_mode;
>  
> @@ -545,7 +554,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	return 0;
>  }
> @@ -565,9 +574,10 @@ static int quad8_count_enable_write(struct counter_device *counter,
>  {
>  	struct quad8 *const priv = counter->priv;
>  	const int base_offset = priv->base + 2 * count->id;
> +	unsigned long irqflags;
>  	unsigned int ior_cfg;
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	priv->ab_enable[count->id] = enable;
>  
> @@ -576,7 +586,7 @@ static int quad8_count_enable_write(struct counter_device *counter,
>  	/* Load I/O control configuration */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	return 0;
>  }
> @@ -627,16 +637,17 @@ static int quad8_count_preset_write(struct counter_device *counter,
>  				    struct counter_count *count, u64 preset)
>  {
>  	struct quad8 *const priv = counter->priv;
> +	unsigned long irqflags;
>  
>  	/* Only 24-bit values are supported */
>  	if (preset > 0xFFFFFF)
>  		return -ERANGE;
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	quad8_preset_register_set(priv, count->id, preset);
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	return 0;
>  }
> @@ -645,8 +656,9 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
>  				    struct counter_count *count, u64 *ceiling)
>  {
>  	struct quad8 *const priv = counter->priv;
> +	unsigned long irqflags;
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	/* Range Limit and Modulo-N count modes use preset value as ceiling */
>  	switch (priv->count_mode[count->id]) {
> @@ -660,7 +672,7 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
>  		break;
>  	}
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	return 0;
>  }
> @@ -669,23 +681,24 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
>  				     struct counter_count *count, u64 ceiling)
>  {
>  	struct quad8 *const priv = counter->priv;
> +	unsigned long irqflags;
>  
>  	/* Only 24-bit values are supported */
>  	if (ceiling > 0xFFFFFF)
>  		return -ERANGE;
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	/* Range Limit and Modulo-N count modes use preset value as ceiling */
>  	switch (priv->count_mode[count->id]) {
>  	case 1:
>  	case 3:
> -		mutex_unlock(&priv->lock);
> +		raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  		quad8_preset_register_set(priv, count->id, ceiling);
>  		return 0;
>  	}
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	return -EINVAL;
>  }
> @@ -707,12 +720,13 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
>  {
>  	struct quad8 *const priv = counter->priv;
>  	const int base_offset = priv->base + 2 * count->id + 1;
> +	unsigned long irqflags;
>  	unsigned int ior_cfg;
>  
>  	/* Preset enable is active low in Input/Output Control register */
>  	preset_enable = !preset_enable;
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	priv->preset_enable[count->id] = preset_enable;
>  
> @@ -721,7 +735,7 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
>  	/* Load I/O control configuration to Input / Output Control Register */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	return 0;
>  }
> @@ -732,22 +746,23 @@ static int quad8_signal_cable_fault_read(struct counter_device *counter,
>  {
>  	struct quad8 *const priv = counter->priv;
>  	const size_t channel_id = signal->id / 2;
> +	unsigned long irqflags;
>  	bool disabled;
>  	unsigned int status;
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	disabled = !(priv->cable_fault_enable & BIT(channel_id));
>  
>  	if (disabled) {
> -		mutex_unlock(&priv->lock);
> +		raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  		return -EINVAL;
>  	}
>  
>  	/* Logic 0 = cable fault */
>  	status = inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	/* Mask respective channel and invert logic */
>  	*cable_fault = !(status & BIT(channel_id));
> @@ -773,9 +788,10 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
>  {
>  	struct quad8 *const priv = counter->priv;
>  	const size_t channel_id = signal->id / 2;
> +	unsigned long irqflags;
>  	unsigned int cable_fault_enable;
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	if (enable)
>  		priv->cable_fault_enable |= BIT(channel_id);
> @@ -787,7 +803,7 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
>  
>  	outb(cable_fault_enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	return 0;
>  }
> @@ -810,8 +826,9 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
>  	struct quad8 *const priv = counter->priv;
>  	const size_t channel_id = signal->id / 2;
>  	const int base_offset = priv->base + 2 * channel_id;
> +	unsigned long irqflags;
>  
> -	mutex_lock(&priv->lock);
> +	raw_spin_lock_irqsave(&priv->lock, irqflags);
>  
>  	priv->fck_prescaler[channel_id] = prescaler;
>  
> @@ -823,7 +840,7 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
>  	     base_offset + 1);
>  
> -	mutex_unlock(&priv->lock);
> +	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>  
>  	return 0;
>  }
> @@ -992,8 +1009,7 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  	priv->counter.priv = priv;
>  	priv->base = base[id];
>  
> -	/* Initialize mutex */
> -	mutex_init(&priv->lock);
> +	raw_spin_lock_init(&priv->lock);
>  
>  	/* Reset all counters and disable interrupt function */
>  	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);


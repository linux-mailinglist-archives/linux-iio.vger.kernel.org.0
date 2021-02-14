Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F0A31B1F9
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 19:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhBNSZw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 13:25:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhBNSZr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 13:25:47 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E90861494;
        Sun, 14 Feb 2021 18:25:03 +0000 (UTC)
Date:   Sun, 14 Feb 2021 18:24:59 +0000
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
Subject: Re: [PATCH v8 22/22] counter: 104-quad-8: Add IRQ support for the
 ACCES 104-QUAD-8
Message-ID: <20210214182459.3177a277@archlinux>
In-Reply-To: <5f86041727b47573940eb5a27c0eaf27cafff55a.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
        <5f86041727b47573940eb5a27c0eaf27cafff55a.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Feb 2021 21:13:46 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The LSI/CSI LS7266R1 chip provides programmable output via the FLG pins.
> When interrupts are enabled on the ACCES 104-QUAD-8, they occur whenever
> FLG1 is active. Four functions are available for the FLG1 signal: Carry,
> Compare, Carry-Borrow, and Index.
> 
> 	Carry:
> 		Interrupt generated on active low Carry signal. Carry
> 		signal toggles every time the respective channel's
> 		counter overflows.
> 
> 	Compare:
> 		Interrupt generated on active low Compare signal.
> 		Compare signal toggles every time respective channel's
> 		preset register is equal to the respective channel's
> 		counter.
> 
> 	Carry-Borrow:
> 		Interrupt generated on active low Carry signal and
> 		active low Borrow signal. Carry signal toggles every
> 		time the respective channel's counter overflows. Borrow
> 		signal toggles every time the respective channel's
> 		counter underflows.
> 
> 	Index:
> 		Interrupt generated on active high Index signal.
> 
> These four functions correspond respectivefly to the following four
> Counter event types: COUNTER_EVENT_OVERFLOW, COUNTER_EVENT_THRESHOLD,
> COUNTER_EVENT_OVERFLOW_UNDERFLOW, and COUNTER_EVENT_INDEX. Interrupts
> push Counter events to event channel X, where 'X' is the respective
> channel whose FLG1 activated.
> 
> This patch adds IRQ support for the ACCES 104-QUAD-8. The interrupt line
> numbers for the devices may be configured via the irq array module
> parameter.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

A few minor bits inline.

Jonathan

> ---
>  drivers/counter/104-quad-8.c | 170 +++++++++++++++++++++++++++++++++--
>  drivers/counter/Kconfig      |   6 +-
>  2 files changed, 165 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 2b47f9991acc..45090cd9f813 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -11,6 +11,7 @@
>  #include <linux/errno.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/interrupt.h>
>  #include <linux/isa.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -25,11 +26,15 @@ static unsigned int num_quad8;
>  module_param_hw_array(base, uint, ioport, &num_quad8, 0);
>  MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>  
> +static unsigned int irq[max_num_isa_dev(QUAD8_EXTENT)];
> +module_param_hw_array(irq, uint, irq, NULL, 0);
> +MODULE_PARM_DESC(irq, "ACCES 104-QUAD-8 interrupt line numbers");
> +
>  #define QUAD8_NUM_COUNTERS 8
>  
>  /**
>   * struct quad8 - device private data structure
> - * @lock:		synchronization lock to prevent I/O race conditions
> + * @lock:		lock to prevent clobbering device states during R/W ops
>   * @counter:		instance of the counter_device
>   * @fck_prescaler:	array of filter clock prescaler configurations
>   * @preset:		array of preset values
> @@ -38,6 +43,8 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>   * @quadrature_scale:	array of quadrature mode scale configurations
>   * @ab_enable:		array of A and B inputs enable configurations
>   * @preset_enable:	array of set_to_preset_on_index attribute configurations
> + * @irq_trigger:	array of current IRQ trigger function configurations
> + * @next_irq_trigger:	array of next IRQ trigger function configurations
>   * @synchronous_mode:	array of index function synchronous mode configurations
>   * @index_polarity:	array of index function polarity configurations
>   * @cable_fault_enable:	differential encoder cable status enable configurations
> @@ -53,13 +60,17 @@ struct quad8 {
>  	unsigned int quadrature_scale[QUAD8_NUM_COUNTERS];
>  	unsigned int ab_enable[QUAD8_NUM_COUNTERS];
>  	unsigned int preset_enable[QUAD8_NUM_COUNTERS];
> +	unsigned int irq_trigger[QUAD8_NUM_COUNTERS];
> +	unsigned int next_irq_trigger[QUAD8_NUM_COUNTERS];
>  	unsigned int synchronous_mode[QUAD8_NUM_COUNTERS];
>  	unsigned int index_polarity[QUAD8_NUM_COUNTERS];
>  	unsigned int cable_fault_enable;
>  	unsigned int base;
>  };
>  
> +#define QUAD8_REG_INTERRUPT_STATUS 0x10
>  #define QUAD8_REG_CHAN_OP 0x11
> +#define QUAD8_REG_INDEX_INTERRUPT 0x12
>  #define QUAD8_REG_INDEX_INPUT_LEVELS 0x16
>  #define QUAD8_DIFF_ENCODER_CABLE_STATUS 0x17
>  /* Borrow Toggle flip-flop */
> @@ -92,8 +103,8 @@ struct quad8 {
>  #define QUAD8_RLD_CNTR_OUT 0x10
>  /* Transfer Preset Register LSB to FCK Prescaler */
>  #define QUAD8_RLD_PRESET_PSC 0x18
> -#define QUAD8_CHAN_OP_ENABLE_COUNTERS 0x00

This seems like an unrelated change...

>  #define QUAD8_CHAN_OP_RESET_COUNTERS 0x01
> +#define QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC 0x04
>  #define QUAD8_CMR_QUADRATURE_X1 0x08
>  #define QUAD8_CMR_QUADRATURE_X2 0x10
>  #define QUAD8_CMR_QUADRATURE_X4 0x18
> @@ -380,13 +391,103 @@ static int quad8_action_read(struct counter_device *counter,
>  	return 0;
>  }

...

>  static int quad8_probe(struct device *dev, unsigned int id)
>  {
>  	struct quad8 *priv;
>  	int i, j;
>  	unsigned int base_offset;
> +	int err;
>  
>  	if (!devm_request_region(dev, base[id], QUAD8_EXTENT, dev_name(dev))) {
>  		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
> @@ -1011,6 +1157,8 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  
>  	raw_spin_lock_init(&priv->lock);
>  
> +	/* Reset Index/Interrupt Register */
> +	outb(0x00, base[id] + QUAD8_REG_INDEX_INTERRUPT);
>  	/* Reset all counters and disable interrupt function */
>  	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
>  	/* Set initial configuration for all counters */
> @@ -1037,13 +1185,19 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  		outb(QUAD8_CTR_IOR, base_offset + 1);
>  		/* Disable index function; negative index polarity */
>  		outb(QUAD8_CTR_IDR, base_offset + 1);
> +		/* Initialize next IRQ trigger function configuration */
> +		priv->next_irq_trigger[i] = QUAD8_EVENT_NONE;
>  	}
>  	/* Disable Differential Encoder Cable Status for all channels */
>  	outb(0xFF, base[id] + QUAD8_DIFF_ENCODER_CABLE_STATUS);
> -	/* Enable all counters */
> -	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
> +	/* Enable all counters and enable interrupt function */
> +	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_OP);
> +
> +	err = devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
> +			       priv->counter.name, priv);
> +	if (err)
> +		return err;
>  
> -	/* Register Counter device */

Whilst I would agree with removing this comment as being pointless
as it's obvious, it doesn't really belong in this patch.

>  	return devm_counter_register(dev, &priv->counter);
>  }
>  
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 1391e8ea64fe..b0f8fef18b51 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -23,11 +23,11 @@ config 104_QUAD_8
>  	  A counter's respective error flag may be cleared by performing a write
>  	  operation on the respective count value attribute. Although the
>  	  104-QUAD-8 counters have a 25-bit range, only the lower 24 bits may be
> -	  set, either directly or via the counter's preset attribute. Interrupts
> -	  are not supported by this driver.
> +	  set, either directly or via the counter's preset attribute.
>  
>  	  The base port addresses for the devices may be configured via the base
> -	  array module parameter.
> +	  array module parameter. The interrupt line numbers for the devices may
> +	  be configured via the irq array module parameter.
>  
>  config STM32_TIMER_CNT
>  	tristate "STM32 Timer encoder counter driver"


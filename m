Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471F5233757
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jul 2020 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG3RHW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jul 2020 13:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3RHW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jul 2020 13:07:22 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFC3C061574;
        Thu, 30 Jul 2020 10:07:21 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so23075024iln.1;
        Thu, 30 Jul 2020 10:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PH7zIspsB255BrGxTG27lNj3xH+g55uSUZjChf+gw4E=;
        b=Mf5cyBy/BujdW2lT8Z82Ic5aq6F+fuj7AXJlLNODuY9T9lquHAuD7s6Lh498bMCVO6
         VzYToOTGoYkyICBgWv/i5k4+9wUQfxkik6Jdr8zpUneCTidIBggQ+m7GsWdGyBrfFAf5
         f2/qSfpHiiKRn9hVfNU+riLcVz0N0Lsp/NRlDaQBt8g0nXIwMwfxYgGt93ms0HB/n3R3
         7iJFUQ9c5QVJS6hJjm3R5XEnOLFxIRVe8njk4PCaVvE2KGZVnmajYPPiUwUORBvwoJy9
         ROzSmKpx2SG8zVnU/aOsDEjxTadNEH8YBF3ZcdX8TP/fj43zqE92tyQ52EiK0e6+xS5J
         cyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PH7zIspsB255BrGxTG27lNj3xH+g55uSUZjChf+gw4E=;
        b=aJttkLMC/i+lds5AJ2hHd53a1e8NnpWBbJgK4fnrDtOcrua0utfuVB86X1OCZQeZwG
         veVetZoD1wo3xbcQKY23IKx8rm+gpDoNU3IQN7DzLhamr8VAjeTYFOltu7z5PfzRnKNe
         V6eUChJNzhiXIC6AwT+vZ3Vgzc3tDrU6BkyCdxkw3BSRFcpV6wmr+DDiSnL9bJ2JyNfT
         /mFt+9TqmALDiCPXV4usOHTPJ+n3FHXY9qLYafKMkax8OJAQayAXpa0Tp2OGYFtRPAJp
         nIYR77vvmpkWPNtT5o37Z1SDuZp55rzyiVbnnzzwdnuiqckexmmh6BrXIMy75YOcxrQm
         kPQQ==
X-Gm-Message-State: AOAM530X9JK1EPIeBxJ5EXT0MdrZbMHvO8XFK/kxBx+z6kW+IxVkxsLq
        98ZXceLGmCyycNzAmtjD2OV/1kcx3WxHnz7D/SQ=
X-Google-Smtp-Source: ABdhPJwyNAl+rntCnb1+CiCqThh3O7sDJGQY6ZsSq6GIYSWeYw3tThoHqQD/3DcXQJ7r6nkBLmysRqcY98cbAcqU1Ig=
X-Received: by 2002:a05:6e02:f07:: with SMTP id x7mr28738591ilj.40.1596128840716;
 Thu, 30 Jul 2020 10:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595358237.git.vilhelm.gray@gmail.com> <d28f1d0cfb5f27ed5b24d62678d402c03ddc9f59.1595358237.git.vilhelm.gray@gmail.com>
In-Reply-To: <d28f1d0cfb5f27ed5b24d62678d402c03ddc9f59.1595358237.git.vilhelm.gray@gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Thu, 30 Jul 2020 22:37:08 +0530
Message-ID: <CACG_h5qC3umDA57dczuSP_vv8prKh=2rJe6qaFrXUUJorGCWGA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 22, 2020 at 1:06 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> The LSI/CSI LS7266R1 chip provides programmable output via the FLG pins.
> When interrupts are enabled on the ACCES 104-QUAD-8, they occur whenever
> FLG1 is active. Four functions are available for the FLG1 signal: Carry,
> Compare, Carry-Borrow, and Index.
>
>         Carry:
>                 Interrupt generated on active low Carry signal. Carry
>                 signal toggles every time the respective channel's
>                 counter overflows.
>
>         Compare:
>                 Interrupt generated on active low Compare signal.
>                 Compare signal toggles every time respective channel's
>                 preset register is equal to the respective channel's
>                 counter.
>
>         Carry-Borrow:
>                 Interrupt generated on active low Carry signal and
>                 active low Borrow signal. Carry signal toggles every
>                 time the respective channel's counter overflows. Borrow
>                 signal toggles every time the respective channel's
>                 counter underflows.
>
>         Index:
>                 Interrupt generated on active high Index signal.
>
> The irq_trigger Count extension is introduced to allow the selection of
> the desired IRQ trigger function per channel. The irq_trigger_enable
> Count extension is introduced to allow the enablement of interrupts for
> a respective channel. Interrupts push Counter events as Event X, where
> 'X' is the respective channel whose FLG1 activated.
>
> This patch adds IRQ support for the ACCES 104-QUAD-8. The interrupt line
> numbers for the devices may be configured via the irq array module
> parameter.
>
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  .../ABI/testing/sysfs-bus-counter-104-quad-8  |  32 ++
>  drivers/counter/104-quad-8.c                  | 283 +++++++++++++-----
>  drivers/counter/Kconfig                       |   6 +-
>  3 files changed, 249 insertions(+), 72 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> index eac32180c40d..718f6199c71e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> @@ -1,3 +1,35 @@
> +What:          /sys/bus/counter/devices/counterX/countY/irq_trigger
> +KernelVersion: 5.9
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               IRQ trigger function for channel Y. Four trigger functions are
> +               available: carry, compare, carry-borrow, and index.
> +
> +               carry:
> +                       Interrupt generated on active low Carry signal. Carry
> +                       signal toggles every time channel Y counter overflows.
> +
> +               compare:
> +                       Interrupt generated on active low Compare signal.
> +                       Compare signal toggles every time channel Y preset
> +                       register is equal to channel Y counter.
> +
> +               carry-borrow:
> +                       Interrupt generated on active low Carry signal and
> +                       active low Borrow signal. Carry signal toggles every
> +                       time channel Y counter overflows. Borrow signal toggles
> +                       every time channel Y counter underflows.
> +
> +               index:
> +                       Interrupt generated on active high Index signal.
> +
> +What:          /sys/bus/counter/devices/counterX/countY/irq_trigger_enable
> +KernelVersion: 5.9
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Whether generation of interrupts is enabled for channel Y. Valid
> +               attribute values are boolean.
> +
>  What:          /sys/bus/counter/devices/counterX/signalY/cable_fault
>  KernelVersion: 5.7
>  Contact:       linux-iio@vger.kernel.org
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 0f20920073d6..b43be2d5464d 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -13,23 +13,30 @@
>  #include <linux/iio/types.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/interrupt.h>
>  #include <linux/isa.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/types.h>
> +#include <linux/spinlock.h>
>
>  #define QUAD8_EXTENT 32
>
>  static unsigned int base[max_num_isa_dev(QUAD8_EXTENT)];
>  static unsigned int num_quad8;
> -module_param_array(base, uint, &num_quad8, 0);
> +module_param_hw_array(base, uint, ioport, &num_quad8, 0);
>  MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>
> +static unsigned int irq[max_num_isa_dev(QUAD8_EXTENT)];
> +module_param_hw_array(irq, uint, irq, NULL, 0);
> +MODULE_PARM_DESC(irq, "ACCES 104-QUAD-8 interrupt line numbers");
> +
>  #define QUAD8_NUM_COUNTERS 8
>
>  /**
>   * struct quad8_iio - IIO device private data structure
> + * @lock:              synchronization lock to prevent I/O race conditions
>   * @counter:           instance of the counter_device
>   * @fck_prescaler:     array of filter clock prescaler configurations
>   * @preset:            array of preset values
> @@ -38,13 +45,14 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
>   * @quadrature_scale:  array of quadrature mode scale configurations
>   * @ab_enable:         array of A and B inputs enable configurations
>   * @preset_enable:     array of set_to_preset_on_index attribute configurations
> + * @irq_trigger:       array of interrupt trigger function configurations
>   * @synchronous_mode:  array of index function synchronous mode configurations
>   * @index_polarity:    array of index function polarity configurations
>   * @cable_fault_enable:        differential encoder cable status enable configurations
>   * @base:              base port address of the IIO device
>   */
>  struct quad8_iio {
> -       struct mutex lock;
> +       raw_spinlock_t lock;
>         struct counter_device counter;
>         unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
>         unsigned int preset[QUAD8_NUM_COUNTERS];
> @@ -53,13 +61,16 @@ struct quad8_iio {
>         unsigned int quadrature_scale[QUAD8_NUM_COUNTERS];
>         unsigned int ab_enable[QUAD8_NUM_COUNTERS];
>         unsigned int preset_enable[QUAD8_NUM_COUNTERS];
> +       unsigned int irq_trigger[QUAD8_NUM_COUNTERS];
>         unsigned int synchronous_mode[QUAD8_NUM_COUNTERS];
>         unsigned int index_polarity[QUAD8_NUM_COUNTERS];
>         unsigned int cable_fault_enable;
>         unsigned int base;
>  };
>
> +#define QUAD8_REG_INTERRUPT_STATUS 0x10
>  #define QUAD8_REG_CHAN_OP 0x11
> +#define QUAD8_REG_INDEX_INTERRUPT 0x12
>  #define QUAD8_REG_INDEX_INPUT_LEVELS 0x16
>  #define QUAD8_DIFF_ENCODER_CABLE_STATUS 0x17
>  /* Borrow Toggle flip-flop */
> @@ -92,8 +103,8 @@ struct quad8_iio {
>  #define QUAD8_RLD_CNTR_OUT 0x10
>  /* Transfer Preset Register LSB to FCK Prescaler */
>  #define QUAD8_RLD_PRESET_PSC 0x18
> -#define QUAD8_CHAN_OP_ENABLE_COUNTERS 0x00
>  #define QUAD8_CHAN_OP_RESET_COUNTERS 0x01
> +#define QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC 0x04
>  #define QUAD8_CMR_QUADRATURE_X1 0x08
>  #define QUAD8_CMR_QUADRATURE_X2 0x10
>  #define QUAD8_CMR_QUADRATURE_X4 0x18
> @@ -107,6 +118,7 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
>         unsigned int flags;
>         unsigned int borrow;
>         unsigned int carry;
> +       unsigned long irqflags;
>         int i;
>
>         switch (mask) {
> @@ -124,7 +136,7 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
>                 /* Borrow XOR Carry effectively doubles count range */
>                 *val = (borrow ^ carry) << 24;
>
> -               mutex_lock(&priv->lock);
> +               raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>                 /* Reset Byte Pointer; transfer Counter to Output Latch */
>                 outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
> @@ -133,7 +145,7 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
>                 for (i = 0; i < 3; i++)
>                         *val |= (unsigned int)inb(base_offset) << (8 * i);
>
> -               mutex_unlock(&priv->lock);
> +               raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>                 return IIO_VAL_INT;
>         case IIO_CHAN_INFO_ENABLE:
> @@ -153,6 +165,7 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>  {
>         struct quad8_iio *const priv = iio_priv(indio_dev);
>         const int base_offset = priv->base + 2 * chan->channel;
> +       unsigned long flags;
>         int i;
>         unsigned int ior_cfg;
>
> @@ -165,7 +178,7 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>                 if ((unsigned int)val > 0xFFFFFF)
>                         return -EINVAL;
>
> -               mutex_lock(&priv->lock);
> +               raw_spin_lock_irqsave(&priv->lock, flags);
>
>                 /* Reset Byte Pointer */
>                 outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> @@ -190,7 +203,7 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>                 /* Reset Error flag */
>                 outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
>
> -               mutex_unlock(&priv->lock);
> +               raw_spin_unlock_irqrestore(&priv->lock, flags);
>
>                 return 0;
>         case IIO_CHAN_INFO_ENABLE:
> @@ -198,25 +211,26 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>                 if (val < 0 || val > 1)
>                         return -EINVAL;
>
> -               mutex_lock(&priv->lock);
> +               raw_spin_lock_irqsave(&priv->lock, flags);
>
>                 priv->ab_enable[chan->channel] = val;
>
> -               ior_cfg = val | priv->preset_enable[chan->channel] << 1;
> +               ior_cfg = val | priv->preset_enable[chan->channel] << 1 |
> +                         priv->irq_trigger[chan->channel] << 3;
>
>                 /* Load I/O control configuration */
>                 outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
>
> -               mutex_unlock(&priv->lock);
> +               raw_spin_unlock_irqrestore(&priv->lock, flags);
>
>                 return 0;
>         case IIO_CHAN_INFO_SCALE:
> -               mutex_lock(&priv->lock);
> +               raw_spin_lock_irqsave(&priv->lock, flags);
>
>                 /* Quadrature scaling only available in quadrature mode */
>                 if (!priv->quadrature_mode[chan->channel] &&
>                                 (val2 || val != 1)) {
> -                       mutex_unlock(&priv->lock);
> +                       raw_spin_unlock_irqrestore(&priv->lock, flags);
>                         return -EINVAL;
>                 }
>
> @@ -232,15 +246,15 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>                                 priv->quadrature_scale[chan->channel] = 2;
>                                 break;
>                         default:
> -                               mutex_unlock(&priv->lock);
> +                               raw_spin_unlock_irqrestore(&priv->lock, flags);
>                                 return -EINVAL;
>                         }
>                 else {
> -                       mutex_unlock(&priv->lock);
> +                       raw_spin_unlock_irqrestore(&priv->lock, flags);
>                         return -EINVAL;
>                 }
>
> -               mutex_unlock(&priv->lock);
> +               raw_spin_unlock_irqrestore(&priv->lock, flags);
>                 return 0;
>         }
>
> @@ -266,6 +280,7 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
>         struct quad8_iio *const priv = iio_priv(indio_dev);
>         const int base_offset = priv->base + 2 * chan->channel;
>         unsigned int preset;
> +       unsigned long irqflags;
>         int ret;
>         int i;
>
> @@ -277,7 +292,7 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
>         if (preset > 0xFFFFFF)
>                 return -EINVAL;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         priv->preset[chan->channel] = preset;
>
> @@ -288,7 +303,7 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
>         for (i = 0; i < 3; i++)
>                 outb(preset >> (8 * i), base_offset);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return len;
>  }
> @@ -309,6 +324,7 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
>         struct quad8_iio *const priv = iio_priv(indio_dev);
>         const int base_offset = priv->base + 2 * chan->channel + 1;
>         bool preset_enable;
> +       unsigned long irqflags;
>         int ret;
>         unsigned int ior_cfg;
>
> @@ -319,17 +335,18 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
>         /* Preset enable is active low in Input/Output Control register */
>         preset_enable = !preset_enable;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         priv->preset_enable[chan->channel] = preset_enable;
>
>         ior_cfg = priv->ab_enable[chan->channel] |
> -               (unsigned int)preset_enable << 1;
> +                 (unsigned int)preset_enable << 1 |
> +                 priv->irq_trigger[chan->channel] << 3;
>
>         /* Load I/O control configuration to Input / Output Control Register */
>         outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return len;
>  }
> @@ -387,8 +404,9 @@ static int quad8_set_count_mode(struct iio_dev *indio_dev,
>         struct quad8_iio *const priv = iio_priv(indio_dev);
>         unsigned int mode_cfg = cnt_mode << 1;
>         const int base_offset = priv->base + 2 * chan->channel + 1;
> +       unsigned long irqflags;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         priv->count_mode[chan->channel] = cnt_mode;
>
> @@ -399,7 +417,7 @@ static int quad8_set_count_mode(struct iio_dev *indio_dev,
>         /* Load mode configuration to Counter Mode Register */
>         outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -430,14 +448,15 @@ static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
>         struct quad8_iio *const priv = iio_priv(indio_dev);
>         const int base_offset = priv->base + 2 * chan->channel + 1;
>         unsigned int idr_cfg = synchronous_mode;
> +       unsigned long irqflags;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         idr_cfg |= priv->index_polarity[chan->channel] << 1;
>
>         /* Index function must be non-synchronous in non-quadrature mode */
>         if (synchronous_mode && !priv->quadrature_mode[chan->channel]) {
> -               mutex_unlock(&priv->lock);
> +               raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>                 return -EINVAL;
>         }
>
> @@ -446,7 +465,7 @@ static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
>         /* Load Index Control configuration to Index Control Register */
>         outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -476,9 +495,10 @@ static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
>  {
>         struct quad8_iio *const priv = iio_priv(indio_dev);
>         const int base_offset = priv->base + 2 * chan->channel + 1;
> +       unsigned long irqflags;
>         unsigned int mode_cfg;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         mode_cfg = priv->count_mode[chan->channel] << 1;
>
> @@ -498,7 +518,7 @@ static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
>         /* Load mode configuration to Counter Mode Register */
>         outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -529,8 +549,9 @@ static int quad8_set_index_polarity(struct iio_dev *indio_dev,
>         struct quad8_iio *const priv = iio_priv(indio_dev);
>         const int base_offset = priv->base + 2 * chan->channel + 1;
>         unsigned int idr_cfg = index_polarity << 1;
> +       unsigned long irqflags;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         idr_cfg |= priv->synchronous_mode[chan->channel];
>
> @@ -539,7 +560,7 @@ static int quad8_set_index_polarity(struct iio_dev *indio_dev,
>         /* Load Index Control configuration to Index Control Register */
>         outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -646,6 +667,7 @@ static int quad8_count_read(struct counter_device *counter,
>         unsigned int flags;
>         unsigned int borrow;
>         unsigned int carry;
> +       unsigned long irqflags;
>         int i;
>
>         flags = inb(base_offset + 1);
> @@ -655,7 +677,7 @@ static int quad8_count_read(struct counter_device *counter,
>         /* Borrow XOR Carry effectively doubles count range */
>         *val = (unsigned long)(borrow ^ carry) << 24;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         /* Reset Byte Pointer; transfer Counter to Output Latch */
>         outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
> @@ -664,7 +686,7 @@ static int quad8_count_read(struct counter_device *counter,
>         for (i = 0; i < 3; i++)
>                 *val |= (unsigned long)inb(base_offset) << (8 * i);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -674,13 +696,14 @@ static int quad8_count_write(struct counter_device *counter,
>  {
>         struct quad8_iio *const priv = counter->priv;
>         const int base_offset = priv->base + 2 * count->id;
> +       unsigned long irqflags;
>         int i;
>
>         /* Only 24-bit values are supported */
>         if (val > 0xFFFFFF)
>                 return -EINVAL;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         /* Reset Byte Pointer */
>         outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> @@ -705,7 +728,7 @@ static int quad8_count_write(struct counter_device *counter,
>         /* Reset Error flag */
>         outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -723,8 +746,9 @@ static int quad8_function_read(struct counter_device *counter,
>  {
>         struct quad8_iio *const priv = counter->priv;
>         const int id = count->id;
> +       unsigned long irqflags;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         if (priv->quadrature_mode[id])
>                 switch (priv->quadrature_scale[id]) {
> @@ -741,7 +765,7 @@ static int quad8_function_read(struct counter_device *counter,
>         else
>                 *function = COUNTER_COUNT_FUNCTION_PULSE_DIRECTION;
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -755,10 +779,11 @@ static int quad8_function_write(struct counter_device *counter,
>         unsigned int *const scale = priv->quadrature_scale + id;
>         unsigned int *const synchronous_mode = priv->synchronous_mode + id;
>         const int base_offset = priv->base + 2 * id + 1;
> +       unsigned long irqflags;
>         unsigned int mode_cfg;
>         unsigned int idr_cfg;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         mode_cfg = priv->count_mode[id] << 1;
>         idr_cfg = priv->index_polarity[id] << 1;
> @@ -797,7 +822,7 @@ static int quad8_function_write(struct counter_device *counter,
>         /* Load mode configuration to Counter Mode Register */
>         outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -906,9 +931,10 @@ static int quad8_index_polarity_set(struct counter_device *counter,
>         struct quad8_iio *const priv = counter->priv;
>         const size_t channel_id = signal->id - 16;
>         const int base_offset = priv->base + 2 * channel_id + 1;
> +       unsigned long irqflags;
>         unsigned int idr_cfg;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         priv->index_polarity[channel_id] = index_polarity;
>
> @@ -916,7 +942,7 @@ static int quad8_index_polarity_set(struct counter_device *counter,
>         idr_cfg = priv->synchronous_mode[channel_id] | index_polarity << 1;
>         outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -940,13 +966,14 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
>         struct quad8_iio *const priv = counter->priv;
>         const size_t channel_id = signal->id - 16;
>         const int base_offset = priv->base + 2 * channel_id + 1;
> +       unsigned long irqflags;
>         unsigned int idr_cfg;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         /* Index function must be non-synchronous in non-quadrature mode */
>         if (synchronous_mode && !priv->quadrature_mode[channel_id]) {
> -               mutex_unlock(&priv->lock);
> +               raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>                 return -EINVAL;
>         }
>
> @@ -956,7 +983,7 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
>         idr_cfg = synchronous_mode | priv->index_polarity[channel_id] << 1;
>         outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -1001,6 +1028,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
>         unsigned int count_mode;
>         unsigned int mode_cfg;
>         const int base_offset = priv->base + 2 * count->id + 1;
> +       unsigned long irqflags;
>
>         /* Map Generic Counter count mode to 104-QUAD-8 count mode */
>         switch (cnt_mode) {
> @@ -1018,7 +1046,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
>                 break;
>         }
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         priv->count_mode[count->id] = count_mode;
>
> @@ -1032,7 +1060,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
>         /* Load mode configuration to Counter Mode Register */
>         outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -1052,18 +1080,20 @@ static int quad8_count_enable_write(struct counter_device *counter,
>  {
>         struct quad8_iio *const priv = counter->priv;
>         const int base_offset = priv->base + 2 * count->id;
> +       unsigned long irqflags;
>         unsigned int ior_cfg;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         priv->ab_enable[count->id] = enable;
>
> -       ior_cfg = enable | priv->preset_enable[count->id] << 1;
> +       ior_cfg = enable | priv->preset_enable[count->id] << 1 |
> +                 priv->irq_trigger[count->id] << 3;
>
>         /* Load I/O control configuration */
>         outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -1109,16 +1139,17 @@ static int quad8_count_preset_write(struct counter_device *counter,
>                                     struct counter_count *count, u64 preset)
>  {
>         struct quad8_iio *const priv = counter->priv;
> +       unsigned long irqflags;
>
>         /* Only 24-bit values are supported */
>         if (preset > 0xFFFFFF)
>                 return -EINVAL;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         quad8_preset_register_set(priv, count->id, preset);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -1127,18 +1158,19 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
>                                     struct counter_count *count, u64 *ceiling)
>  {
>         struct quad8_iio *const priv = counter->priv;
> +       unsigned long irqflags;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         /* Range Limit and Modulo-N count modes use preset value as ceiling */
>         switch (priv->count_mode[count->id]) {
>         case 1:
>         case 3:
> -               mutex_unlock(&priv->lock);
> +               raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>                 return quad8_count_preset_read(counter, count, ceiling);
>         }
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         /* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
>         *ceiling = 0x1FFFFFF;
> @@ -1150,12 +1182,13 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
>                                      struct counter_count *count, u64 ceiling)
>  {
>         struct quad8_iio *const priv = counter->priv;
> +       unsigned long irqflags;
>
>         /* Only 24-bit values are supported */
>         if (ceiling > 0xFFFFFF)
>                 return -EINVAL;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         /* Range Limit and Modulo-N count modes use preset value as ceiling */
>         switch (priv->count_mode[count->id]) {
> @@ -1164,7 +1197,7 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
>                 return quad8_count_preset_write(counter, count, ceiling);
>         }
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return -EINVAL;
>  }
> @@ -1186,21 +1219,91 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
>  {
>         struct quad8_iio *const priv = counter->priv;
>         const int base_offset = priv->base + 2 * count->id + 1;
> +       unsigned long irqflags;
>         unsigned int ior_cfg;
>
>         /* Preset enable is active low in Input/Output Control register */
>         preset_enable = !preset_enable;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         priv->preset_enable[count->id] = preset_enable;
>
> -       ior_cfg = priv->ab_enable[count->id] | preset_enable << 1;
> +       ior_cfg = priv->ab_enable[count->id] | preset_enable << 1 |
> +                 priv->irq_trigger[count->id] << 3;
> +
> +       /* Load I/O control configuration to Input / Output Control Register */
> +       outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
> +
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
> +
> +       return 0;
> +}
> +
> +static int quad8_irq_trigger_get(struct counter_device *counter,
> +                                struct counter_count *count, u8 *irq_trigger)
> +{
> +       const struct quad8_iio *const priv = counter->priv;
> +
> +       *irq_trigger = priv->irq_trigger[count->id];
> +
> +       return 0;
> +}
> +
> +static int quad8_irq_trigger_set(struct counter_device *counter,
> +                                struct counter_count *count, u8 irq_trigger)
> +{
> +       struct quad8_iio *const priv = counter->priv;
> +       const unsigned long base_offset = priv->base + 2 * count->id + 1;
> +       unsigned long irqflags;
> +       unsigned long ior_cfg;
> +
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
> +
> +       priv->irq_trigger[count->id] = irq_trigger;
> +
> +       ior_cfg = priv->ab_enable[count->id] |
> +                 priv->preset_enable[count->id] << 1 | irq_trigger << 3;
>
>         /* Load I/O control configuration to Input / Output Control Register */
>         outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
> +
> +       return 0;
> +}
> +
> +static int quad8_irq_trigger_enable_read(struct counter_device *counter,
> +                                        struct counter_count *count, u8 *state)
> +{
> +       const struct quad8_iio *const priv = counter->priv;
> +       unsigned long irq_enabled;
> +
> +       irq_enabled = inb(priv->base + QUAD8_REG_INDEX_INTERRUPT);
> +       *state = !!(irq_enabled & BIT(count->id));
> +
> +       return 0;
> +}
> +
> +static int quad8_irq_trigger_enable_write(struct counter_device *counter,
> +                                   struct counter_count *count, u8 state)
> +{
> +       struct quad8_iio *const priv = counter->priv;
> +       unsigned long irqflags;
> +       unsigned long irq_enabled;
> +
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
> +
> +       irq_enabled = inb(priv->base + QUAD8_REG_INDEX_INTERRUPT);
> +
> +       if (state)
> +               irq_enabled |= BIT(count->id);
> +       else
> +               irq_enabled &= ~BIT(count->id);
> +
> +       outb(irq_enabled, priv->base + QUAD8_REG_INDEX_INTERRUPT);
> +
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -1211,22 +1314,23 @@ static int quad8_signal_cable_fault_read(struct counter_device *counter,
>  {
>         struct quad8_iio *const priv = counter->priv;
>         const size_t channel_id = signal->id / 2;
> +       unsigned long irqflags;
>         bool disabled;
>         unsigned int status;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         disabled = !(priv->cable_fault_enable & BIT(channel_id));
>
>         if (disabled) {
> -               mutex_unlock(&priv->lock);
> +               raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>                 return -EINVAL;
>         }
>
>         /* Logic 0 = cable fault */
>         status = inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         /* Mask respective channel and invert logic */
>         *cable_fault = !(status & BIT(channel_id));
> @@ -1252,9 +1356,10 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
>  {
>         struct quad8_iio *const priv = counter->priv;
>         const size_t channel_id = signal->id / 2;
> +       unsigned long irqflags;
>         unsigned int cable_fault_enable;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         if (enable)
>                 priv->cable_fault_enable |= BIT(channel_id);
> @@ -1266,7 +1371,7 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
>
>         outb(cable_fault_enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -1289,8 +1394,9 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
>         struct quad8_iio *const priv = counter->priv;
>         const size_t channel_id = signal->id / 2;
>         const int base_offset = priv->base + 2 * channel_id;
> +       unsigned long irqflags;
>
> -       mutex_lock(&priv->lock);
> +       raw_spin_lock_irqsave(&priv->lock, irqflags);
>
>         priv->fck_prescaler[channel_id] = prescaler;
>
> @@ -1302,7 +1408,7 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
>         outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
>              base_offset + 1);
>
> -       mutex_unlock(&priv->lock);
> +       raw_spin_unlock_irqrestore(&priv->lock, irqflags);
>
>         return 0;
>  }
> @@ -1405,7 +1511,15 @@ static const u8 quad8_cnt_modes[] = {
>
>  static DEFINE_COUNTER_AVAILABLE(quad8_count_mode_available, quad8_cnt_modes);
>
> +static const char *const quad8_irq_trigger_states[] = {
> +       "carry",
> +       "compare",
> +       "carry-borrow",
> +       "index",
> +};
> +
>  static DEFINE_COUNTER_ENUM(quad8_error_noise_enum, quad8_noise_error_states);
> +static DEFINE_COUNTER_ENUM(quad8_irq_trigger_enum, quad8_irq_trigger_states);
>
>  static struct counter_data quad8_count_ext[] = {
>         COUNTER_DATA_CEILING(quad8_count_ceiling_read,
> @@ -1420,6 +1534,11 @@ static struct counter_data quad8_count_ext[] = {
>         COUNTER_DATA_PRESET(quad8_count_preset_read, quad8_count_preset_write),
>         COUNTER_DATA_PRESET_ENABLE(quad8_count_preset_enable_read,
>                                    quad8_count_preset_enable_write),
> +       COUNTER_DATA_COUNT_ENUM("irq_trigger", quad8_irq_trigger_get,
> +                               quad8_irq_trigger_set, quad8_irq_trigger_enum),
> +       COUNTER_DATA_COUNT_BOOL("irq_trigger_enable",
> +                               quad8_irq_trigger_enable_read,
> +                               quad8_irq_trigger_enable_write),
>  };
>
>  #define QUAD8_COUNT(_id, _cntname) {                                   \
> @@ -1444,6 +1563,26 @@ static struct counter_count quad8_counts[] = {
>         QUAD8_COUNT(7, "Channel 8 Count")
>  };
>
> +static irqreturn_t quad8_irq_handler(int irq, void *quad8iio)
> +{
> +       struct quad8_iio *const priv = quad8iio;
> +       const unsigned long base = priv->base;
> +       unsigned long irq_status;
> +       unsigned long channel;
> +
> +       irq_status = inb(base + QUAD8_REG_INTERRUPT_STATUS);
> +       if (!irq_status)
> +               return IRQ_NONE;
> +
> +       for_each_set_bit(channel, &irq_status, QUAD8_NUM_COUNTERS)
> +               counter_push_event(&priv->counter, channel);
> +
> +       /* Clear pending interrupts on device */
> +       outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base + QUAD8_REG_CHAN_OP);
> +
> +       return IRQ_HANDLED;
> +}
> +
>  static int quad8_probe(struct device *dev, unsigned int id)
>  {
>         struct iio_dev *indio_dev;
> @@ -1487,9 +1626,10 @@ static int quad8_probe(struct device *dev, unsigned int id)
>         quad8iio->counter.priv = quad8iio;
>         quad8iio->base = base[id];
>
> -       /* Initialize mutex */
> -       mutex_init(&quad8iio->lock);
> +       raw_spin_lock_init(&quad8iio->lock);
>
> +       /* Reset Index/Interrupt Register */
> +       outb(0x00, base[id] + QUAD8_REG_INDEX_INTERRUPT);
>         /* Reset all counters and disable interrupt function */
>         outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
>         /* Set initial configuration for all counters */
> @@ -1519,8 +1659,8 @@ static int quad8_probe(struct device *dev, unsigned int id)
>         }
>         /* Disable Differential Encoder Cable Status for all channels */
>         outb(0xFF, base[id] + QUAD8_DIFF_ENCODER_CABLE_STATUS);
> -       /* Enable all counters */
> -       outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
> +       /* Enable all counters and enable interrupt function */
> +       outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_OP);
>
>         /* Register IIO device */
>         err = devm_iio_device_register(dev, indio_dev);
> @@ -1528,7 +1668,12 @@ static int quad8_probe(struct device *dev, unsigned int id)
>                 return err;
>
>         /* Register Counter device */
> -       return devm_counter_register(dev, &quad8iio->counter);
> +       err = devm_counter_register(dev, &quad8iio->counter);
> +       if (err)
> +               return err;
> +
> +       return devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
> +                               quad8iio->counter.name, quad8iio);
>  }
>
>  static struct isa_driver quad8_driver = {
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 2de53ab0dd25..bd42df98f522 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -23,11 +23,11 @@ config 104_QUAD_8
>           A counter's respective error flag may be cleared by performing a write
>           operation on the respective count value attribute. Although the
>           104-QUAD-8 counters have a 25-bit range, only the lower 24 bits may be
> -         set, either directly or via the counter's preset attribute. Interrupts
> -         are not supported by this driver.
> +         set, either directly or via the counter's preset attribute.
>
>           The base port addresses for the devices may be configured via the base
> -         array module parameter.
> +         array module parameter. The interrupt line numbers for the devices may
> +         be configured via the irq array module parameter.
>
>  config STM32_TIMER_CNT
>         tristate "STM32 Timer encoder counter driver"
> --
> 2.27.0
>


Reviewed-by: Syed Nayyar Waris <syednwaris@gmail.com>

Thanks.

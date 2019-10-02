Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C044CC9071
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 20:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJBSLL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 14:11:11 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37202 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBSLL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 14:11:11 -0400
Received: by mail-yb1-f196.google.com with SMTP id z125so1354ybc.4
        for <linux-iio@vger.kernel.org>; Wed, 02 Oct 2019 11:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SldGzVuFNj72atXumqKP46N3iUXq3mKE0CJK1nkIVPk=;
        b=B3ZSiH9/Nzno/9oEaf9saX+tlHAf61/Y9LkSbKqVO6T8ZwClOsuOui6WLh70c1u+Gb
         7A1GKLx45Jn0H2C3TEN1FeqBgZSQbPi9HSp3lmuahQ+YmhD0upWZudmu4NqvmKM8Oatj
         JHVteoKOdswxtq6YrpISsPPsdA6yDztXkzwesT4Ws/WEjit0peff526xenFOnTPf3YFo
         t+eBk8vxLLvW5SvNtqSqQMFfmz9WcWwLe33/IWJLmLbSOPO8OaYrBgK/4UPQusvMUC5J
         SGAehd1x2M/M8MEB5SV8huWdXXg1Ytt9RrtdiKtaZexncSqD/P0XbXJzM0vLYCmz0ObS
         sGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SldGzVuFNj72atXumqKP46N3iUXq3mKE0CJK1nkIVPk=;
        b=p1W4gZqQYK2xen33oj/frVwIUIhT5SFsKanvAvLeSKS30J/MvU/QpOklr//3i47CsX
         j/qT1haqU0QgJuDK+NwZRgcZA3mWrrFmPOJBdIA+uE4mfgSFH0F3AcKiP+/E4GUmiicQ
         8sBGPm1NJ2JycqSBxV7qWUAwbRJJEEhJXuJ11MbAveM4sQtK8oodeISFTeqEZA7/rPgd
         LiF5mINlEemE/IpUV9aOlUtI48qZMxcVaM9m1/0M05NiSbcVPp+zpEcihE11c8hsmaI1
         Mfxnq6PyvhrxJpALyXW7l/pFiSjFinW5QBkLVOoL4gMRDcQWRls6rYtQDe7HLPUBBpDN
         y2XQ==
X-Gm-Message-State: APjAAAUrkyj0tjouKJpe/LeApTaNJIPl1dbzdDqhl3mVsyiITxzOYIqF
        uH9JIAnr9oXVEHaquM4A2BflBrrr
X-Google-Smtp-Source: APXvYqwDxg57ickbyEvtp7QWPpN2/a4i28cSFbKq8BnjTzYroqDcnNDiIn3GufekqoXZ1keGcT6kPA==
X-Received: by 2002:a25:bb13:: with SMTP id z19mr3424628ybg.180.1570039869073;
        Wed, 02 Oct 2019 11:11:09 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id a130sm4496611ywc.81.2019.10.02.11.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 11:11:07 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:11:05 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] counter: introduce support for Intel QEP Encoder
Message-ID: <20191002181105.GB100041@icarus>
References: <87o8zax6ya.fsf@gmail.com>
 <20191001093237.775608-1-felipe.balbi@linux.intel.com>
 <20191001093237.775608-2-felipe.balbi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191001093237.775608-2-felipe.balbi@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 01, 2019 at 12:32:37PM +0300, Felipe Balbi wrote:
> Add support for Intel PSE Quadrature Encoder
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> ---
> Changes since v1:
> 	- Many more private sysfs files converted over to counter interface
> 
> Changes since v2:
> 	- Completed conversion to counter framework
> 	- Removed Capture Compare for now
> 	- Removed RFC from subject
> 
>  drivers/counter/Kconfig     |   6 +
>  drivers/counter/Makefile    |   1 +
>  drivers/counter/intel-qep.c | 689 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 696 insertions(+)
>  create mode 100644 drivers/counter/intel-qep.c

Hi Felipe,

Make sure to add an entry for this driver in the top-level MAINTAINERS
file so that we have a way to contact the maintainer in the future.

> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 2967d0a9ff91..f280cd721350 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -59,4 +59,10 @@ config FTM_QUADDEC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ftm-quaddec.
>  
> +config INTEL_QEP
> +	tristate "Intel Quadrature Encoder"
> +	depends on PCI
> +	help
> +	  Support for Intel Quadrature Encoder Devices

This help text seems rather short -- are you able to expand it a bit
further? The current description here gives me the impression that this
is a generic driver for all Intel quadrature encoder devices in
existence, but I suspect the Intel QEP counter driver has a much
narrower list of devices it supports; perhaps you can list those support
device models here.

> +
>  endif # COUNTER
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 40d35522937d..cf291cfd8cf0 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
>  obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
>  obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
> +obj-$(CONFIG_INTEL_QEP)		+= intel-qep.o
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> new file mode 100644
> index 000000000000..fa410a333b05
> --- /dev/null
> +++ b/drivers/counter/intel-qep.c
> @@ -0,0 +1,689 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * intel-qep.c - Intel Quadrature Encoder Driver
> + *
> + * Copyright (C) 2019 Intel Corporation - https://www.intel.com
> + *
> + * Author: Felipe Balbi <felipe.balbi@linux.intel.com>
> + */
> +#include <linux/bitops.h>
> +#include <linux/counter.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/sysfs.h>

Is the sysfs.h file include needed anymore?

> +
> +#define INTEL_QEPCON		0x00
> +#define INTEL_QEPFLT		0x04
> +#define INTEL_QEPCOUNT		0x08
> +#define INTEL_QEPMAX		0x0c
> +#define INTEL_QEPWDT		0x10
> +#define INTEL_QEPCAPDIV		0x14
> +#define INTEL_QEPCNTR		0x18
> +#define INTEL_QEPCAPBUF		0x1c
> +#define INTEL_QEPINT_STAT	0x20
> +#define INTEL_QEPINT_MASK	0x24
> +
> +/* QEPCON */
> +#define INTEL_QEPCON_EN		BIT(0)
> +#define INTEL_QEPCON_FLT_EN	BIT(1)
> +#define INTEL_QEPCON_EDGE_A	BIT(2)
> +#define INTEL_QEPCON_EDGE_B	BIT(3)
> +#define INTEL_QEPCON_EDGE_INDX	BIT(4)
> +#define INTEL_QEPCON_SWPAB	BIT(5)
> +#define INTEL_QEPCON_OP_MODE	BIT(6)
> +#define INTEL_QEPCON_PH_ERR	BIT(7)
> +#define INTEL_QEPCON_COUNT_RST_MODE BIT(8)
> +#define INTEL_QEPCON_INDX_GATING_MASK GENMASK(10, 9)
> +#define INTEL_QEPCON_INDX_GATING(n) (((n) & 3) << 9)
> +#define INTEL_QEPCON_INDX_PAL_PBL INTEL_QEPCON_INDX_GATING(0)
> +#define INTEL_QEPCON_INDX_PAL_PBH INTEL_QEPCON_INDX_GATING(1)
> +#define INTEL_QEPCON_INDX_PAH_PBL INTEL_QEPCON_INDX_GATING(2)
> +#define INTEL_QEPCON_INDX_PAH_PBH INTEL_QEPCON_INDX_GATING(3)
> +#define INTEL_QEPCON_CAP_MODE	BIT(11)
> +#define INTEL_QEPCON_FIFO_THRE_MASK GENMASK(14, 12)
> +#define INTEL_QEPCON_FIFO_THRE(n) ((((n) - 1) & 7) << 12)
> +#define INTEL_QEPCON_FIFO_EMPTY	BIT(15)
> +
> +/* QEPFLT */
> +#define INTEL_QEPFLT_MAX_COUNT(n) ((n) & 0x1fffff)
> +
> +/* QEPINT */
> +#define INTEL_QEPINT_FIFOCRIT	BIT(5)
> +#define INTEL_QEPINT_FIFOENTRY	BIT(4)
> +#define INTEL_QEPINT_QEPDIR	BIT(3)
> +#define INTEL_QEPINT_QEPRST_UP	BIT(2)
> +#define INTEL_QEPINT_QEPRST_DOWN BIT(1)
> +#define INTEL_QEPINT_WDT	BIT(0)
> +
> +#define INTEL_QEP_DIRECTION_FORWARD 1
> +#define INTEL_QEP_DIRECTION_BACKWARD !INTEL_QEP_DIRECTION_FORWARD
> +
> +#define INTEL_QEP_COUNTER_EXT_RW(_name) \
> +{ \
> +	.name = #_name, \
> +	.read = _name##_read, \
> +	.write = _name##_write, \
> +}
> +
> +#define INTEL_QEP_COUNTER_EXT_RO(_name) \
> +{ \
> +	.name = #_name, \
> +	.read = _name##_read, \
> +}
> +
> +#define INTEL_QEP_COUNTER_COUNT_EXT_RW(_name) \
> +{ \
> +	.name = #_name, \
> +	.read = _name##_read, \
> +	.write = _name##_write, \
> +}
> +
> +#define INTEL_QEP_COUNTER_COUNT_EXT_RO(_name) \
> +{ \
> +	.name = #_name, \
> +	.read = _name##_read, \
> +}

You're using the same naming convention for all your extensions, so we
can reduce some complexity here by removing one pair of defines such as
INTEL_QEP_COUNTER_COUNT_EXT_RW/INTEL_QEP_COUNTER_COUNT_EXT_RO and just
use INTEL_QEP_COUNTER_EXT_RW/INTEL_QEP_COUNTER_EXT_RO instead for all
extensions. If you start using a different naming convention for Count
extensions versus device extensions, then you can separate them out with
dedicated defines.

> +
> +struct intel_qep {
> +	struct counter_device counter;
> +	struct mutex lock;
> +	struct pci_dev *pci;
> +	struct device *dev;
> +	void __iomem *regs;
> +	u32 interrupt;
> +	int direction;
> +	bool enabled;
> +};
> +
> +#define counter_to_qep(c)	(container_of((c), struct intel_qep, counter))

This macro isn't needed since you set the counter_device priv member to
your intel_qep structure in the intel_qep_probe. What you can do instead
is simply define a pointer directly:

        struct intel_qep *const qep = counter->priv;

You do so already in several of your main callbacks, so it seems like
the counter_to_qep macro use in the extension callbacks are just
leftovers from when you converted the extensions over from direct sysfs
callbacks.

> +
> +static inline u32 intel_qep_readl(void __iomem *base, u32 offset)
> +{
> +	return readl(base + offset);
> +}
> +
> +static inline void intel_qep_writel(void __iomem *base, u32 offset, u32 value)
> +{
> +	writel(value, base + offset);
> +}
> +
> +static const struct pci_device_id intel_qep_id_table[] = {
> +	/* EHL */
> +	{ PCI_VDEVICE(INTEL, 0x4bc3), },
> +	{ PCI_VDEVICE(INTEL, 0x4b81), },
> +	{ PCI_VDEVICE(INTEL, 0x4b82), },
> +	{ PCI_VDEVICE(INTEL, 0x4b83), },
> +	{  } /* Terminating Entry */
> +};
> +MODULE_DEVICE_TABLE(pci, intel_qep_id_table);
> +
> +static void intel_qep_init(struct intel_qep *qep, bool reset)
> +{
> +	u32 reg;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +	reg &= ~INTEL_QEPCON_EN;
> +	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
> +
> +	/* make sure periperal is disabled by reading one more time */
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +
> +	if (reset) {
> +		reg &= ~(INTEL_QEPCON_OP_MODE | INTEL_QEPCON_FLT_EN);
> +		reg |= INTEL_QEPCON_EDGE_A | INTEL_QEPCON_EDGE_B |
> +			INTEL_QEPCON_EDGE_INDX | INTEL_QEPCON_COUNT_RST_MODE;
> +	}
> +
> +	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
> +
> +	intel_qep_writel(qep->regs, INTEL_QEPWDT, 0x1000);
> +	intel_qep_writel(qep->regs, INTEL_QEPINT_MASK, 0x0);
> +
> +	qep->direction = INTEL_QEP_DIRECTION_FORWARD;
> +}
> +
> +static irqreturn_t intel_qep_irq_thread(int irq, void *_qep)
> +{
> +	struct intel_qep	*qep = _qep;
> +	u32			stat;
> +
> +	mutex_lock(&qep->lock);
> +
> +	stat = qep->interrupt;
> +	if (stat & INTEL_QEPINT_FIFOCRIT)
> +		dev_dbg(qep->dev, "Fifo Critical\n");
> +
> +	if (stat & INTEL_QEPINT_FIFOENTRY)
> +		dev_dbg(qep->dev, "Fifo Entry\n");
> +
> +	if (stat & INTEL_QEPINT_QEPDIR)
> +		qep->direction = !qep->direction;
> +
> +	if (stat & INTEL_QEPINT_QEPRST_UP)
> +		qep->direction = INTEL_QEP_DIRECTION_FORWARD;
> +
> +	if (stat & INTEL_QEPINT_QEPRST_DOWN)
> +		qep->direction = INTEL_QEP_DIRECTION_BACKWARD;
> +
> +	if (stat & INTEL_QEPINT_WDT)
> +		dev_dbg(qep->dev, "Watchdog\n");
> +
> +	intel_qep_writel(qep->regs, INTEL_QEPINT_MASK, 0x00);
> +	mutex_unlock(&qep->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t intel_qep_irq(int irq, void *_qep)
> +{
> +	struct intel_qep	*qep = _qep;
> +	u32			stat;
> +
> +	stat = intel_qep_readl(qep->regs, INTEL_QEPINT_STAT);
> +	if (stat) {
> +		qep->interrupt = stat;
> +		intel_qep_writel(qep->regs, INTEL_QEPINT_MASK, 0xffffffff);
> +		intel_qep_writel(qep->regs, INTEL_QEPINT_STAT, stat);
> +		return IRQ_WAKE_THREAD;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +enum intel_qep_synapse_action {
> +	INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE,
> +	INTEL_QEP_SYNAPSE_ACTION_FALLING_EDGE,
> +};
> +
> +static enum counter_synapse_action intel_qep_synapse_actions[] = {
> +	[INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE] =
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +	

Trim the trailing whitespace here.

> +	[INTEL_QEP_SYNAPSE_ACTION_FALLING_EDGE] =
> +	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> +};
> +
> +enum intel_qep_count_function {
> +	INTEL_QEP_ENCODER_MODE_NORMAL,
> +	INTEL_QEP_ENCODER_MODE_SWAPPED,
> +};
> +
> +static const enum counter_count_function intel_qep_count_functions[] = {
> +	[INTEL_QEP_ENCODER_MODE_NORMAL] =
> +	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> +
> +	[INTEL_QEP_ENCODER_MODE_SWAPPED] =
> +	COUNTER_COUNT_FUNCTION_QUADRATURE_X4_SWAPPED,
> +};
> +
> +static int intel_qep_count_read(struct counter_device *counter,
> +		struct counter_count *count,
> +		struct counter_count_read_value *val)
> +{
> +	struct intel_qep *const qep = counter->priv;
> +	uint32_t cntval;
> +
> +	cntval = intel_qep_readl(qep, INTEL_QEPCOUNT);
> +	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &cntval);
> +
> +	return 0;
> +}
> +
> +static int intel_qep_count_write(struct counter_device *counter,
> +		struct counter_count *count,
> +		struct counter_count_write_value *val)
> +{
> +	struct intel_qep *const qep = counter->priv;
> +	u32 cnt;
> +	int err;
> +
> +	err = counter_count_write_value_get(&cnt, COUNTER_COUNT_POSITION, val);
> +	if (err)
> +		return err;
> +
> +	intel_qep_writel(qep->regs, INTEL_QEPMAX, cnt);
> +
> +	return 0;
> +}
> +
> +static int intel_qep_function_get(struct counter_device *counter,
> +		struct counter_count *count, size_t *function)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +	u32 reg;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +	if (reg & INTEL_QEPCON_SWPAB)
> +		*function = INTEL_QEP_ENCODER_MODE_SWAPPED;
> +	else
> +		*function = INTEL_QEP_ENCODER_MODE_NORMAL;
> +
> +	return 0;
> +}
> +
> +static int intel_qep_function_set(struct counter_device *counter,
> +		struct counter_count *count, size_t function)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +	u32 reg;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +	if (function == INTEL_QEP_ENCODER_MODE_SWAPPED)
> +		reg |= INTEL_QEPCON_SWPAB;
> +	else
> +		reg &= ~INTEL_QEPCON_SWPAB;
> +	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
> +
> +	return 0;
> +}
> +
> +static int intel_qep_action_get(struct counter_device *counter,
> +		struct counter_count *count, struct counter_synapse *synapse,
> +		size_t *action)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +	u32 reg;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +
> +	*action = reg & synapse->signal->id ?
> +		INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE :
> +		INTEL_QEP_SYNAPSE_ACTION_FALLING_EDGE;
> +
> +	return 0;
> +}
> +
> +static int intel_qep_action_set(struct counter_device *counter,
> +		struct counter_count *count,
> +		struct counter_synapse *synapse, size_t action)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +	u32 reg;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +
> +	if (action == INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE)
> +		reg |= synapse->signal->id;
> +	else
> +		reg &= ~synapse->signal->id;
> +
> +	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
> +
> +	return 0;
> +}
> +
> +static const struct counter_ops intel_qep_counter_ops = {
> +	.count_read = intel_qep_count_read,
> +	.count_write = intel_qep_count_write,
> +
> +	.function_get = intel_qep_function_get,
> +	.function_set = intel_qep_function_set,
> +
> +	.action_get = intel_qep_action_get,
> +	.action_set = intel_qep_action_set,
> +};
> +
> +static struct counter_signal intel_qep_signals[] = {
> +	{
> +		.id = INTEL_QEPCON_EDGE_A,
> +		.name = "Phase A",
> +	},
> +	{
> +		.id = INTEL_QEPCON_EDGE_B,
> +		.name = "Phase B",
> +	},
> +	{
> +		.id = INTEL_QEPCON_EDGE_INDX,
> +		.name = "Index",
> +	},
> +};
> +
> +static struct counter_synapse intel_qep_count_synapses[] = {
> +	{
> +		.actions_list = intel_qep_synapse_actions,
> +		.num_actions = ARRAY_SIZE(intel_qep_synapse_actions),
> +		.signal = &intel_qep_signals[0],
> +	},
> +	{
> +		.actions_list = intel_qep_synapse_actions,
> +		.num_actions = ARRAY_SIZE(intel_qep_synapse_actions),
> +		.signal = &intel_qep_signals[1],
> +	},
> +	{
> +		.actions_list = intel_qep_synapse_actions,
> +		.num_actions = ARRAY_SIZE(intel_qep_synapse_actions),
> +		.signal = &intel_qep_signals[2],
> +	},
> +};
> +
> +static ssize_t ceiling_read(struct counter_device *counter,
> +		struct counter_count *count, void *priv, char *buf)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +	u32 reg;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPMAX);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", reg);

Normally it's good to make sure you don't write over the PAGE_SIZE
limit, but this check isn't necessary here in the Counter extension
callbacks; the PAGE_SIZE check for buf will happen later on internally
so you don't have to worry about it as a Counter driver author.

Using sprintf for all the extension callbacks in your driver is fine:

        return sprintf(buf, "%d\n", reg)

> +}
> +
> +static ssize_t ceiling_write(struct counter_device *counter,
> +		struct counter_count *count, void *priv, const char *buf,
> +		size_t len)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +	u32 max;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 0, &max);
> +	if (ret < 0)
> +		return ret;
> +
> +	intel_qep_writel(qep->regs, INTEL_QEPMAX, max);
> +
> +	return len;
> +}
> +
> +static ssize_t enable_read(struct counter_device *counter,
> +		struct counter_count *count, void *priv, char *buf)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +	u32 reg;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", !!(reg & INTEL_QEPCON_EN));
> +}
> +
> +static ssize_t enable_write(struct counter_device *counter,
> +		struct counter_count *count, void *priv, const char *buf,
> +		size_t len)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +	u32 reg;
> +	u32 val;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 0, &val);

Use kstrtobool here instead so that values such as "y" and "n" can be
interpreted correctly as well.

> +	if (ret < 0)
> +		return ret;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +
> +	if (val)
> +		reg |= INTEL_QEPCON_EN;
> +	else
> +		reg &= ~INTEL_QEPCON_EN;
> +
> +	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
> +
> +	return len;
> +}
> +
> +static ssize_t direction_read(struct counter_device *counter,
> +		struct counter_count *count, void *priv, char *buf)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", qep->direction ?
> +			"forward" : "backward");

We standardized the direction extension values, so instead define a
enum counter_count_direction dir and set it to the direction you want.
When you're done, you can return like this:

        return sprintf(buf, "%s\n", counter_count_direction_str[dir])

The counter_count_direction enum constants are provided in the counter.h
header file.

> +}
> +
> +static const struct counter_count_ext intel_qep_count_ext[] = {
> +	INTEL_QEP_COUNTER_COUNT_EXT_RW(ceiling),
> +	INTEL_QEP_COUNTER_COUNT_EXT_RW(enable),
> +	INTEL_QEP_COUNTER_COUNT_EXT_RO(direction),
> +};
> +
> +static struct counter_count intel_qep_here counter_count[] = {
> +	{
> +		.id = 0,
> +		.name = "Channel 1 Count",
> +		.functions_list = intel_qep_count_functions,
> +		.num_functions = ARRAY_SIZE(intel_qep_count_functions),
> +		.synapses = intel_qep_count_synapses,
> +		.num_synapses = ARRAY_SIZE(intel_qep_count_synapses),
> +		.ext = intel_qep_count_ext,
> +		.num_ext = ARRAY_SIZE(intel_qep_count_ext),
> +	},
> +};
> +
> +static ssize_t noise_read(struct counter_device *counter, void *priv, char *buf)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +	u32 reg;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +
> +	if (!(reg & INTEL_QEPCON_FLT_EN))
> +		return snprintf(buf, PAGE_SIZE, "0\n");
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPFLT);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", INTEL_QEPFLT_MAX_COUNT(reg));
> +}
> +
> +static ssize_t noise_write(struct counter_device *counter, void *priv,
> +		const char *buf, size_t len)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +	u32 reg;
> +	u32 max;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 0, &max);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (max > 0x1fffff)
> +		max = 0x1ffff;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +
> +	if (max == 0) {
> +		reg &= ~INTEL_QEPCON_FLT_EN;
> +	} else {
> +		reg |= INTEL_QEPCON_FLT_EN;
> +		intel_qep_writel(qep->regs, INTEL_QEPFLT, max);
> +	}
> +
> +	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
> +	

Trim the trailing whitespace here.

> +	return len;
> +}

Your "noise" extension attribute will need documentation, so create a
Documentation/ABI/testing/sysfs-bus-counter-intel-qep file with all the
information for it inside.

> +
> +static ssize_t preset_read(struct counter_device *counter, void *priv, char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "0\n");
> +}
> +
> +static ssize_t preset_enable_read(struct counter_device *counter, void *priv,
> +		char *buf)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +	u32 reg;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +	return snprintf(buf, PAGE_SIZE, "%d\n",
> +			!(reg & INTEL_QEPCON_COUNT_RST_MODE));
> +}
> +
> +static ssize_t preset_enable_write(struct counter_device *counter, void *priv,
> +		const char *buf, size_t len)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +	u32 reg;
> +	u32 val;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 0, &val);

Use kstrtobool here for the same reason as the "enable" extension.

> +	if (ret < 0)
> +		return ret;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +
> +	if (val)
> +		reg &= ~INTEL_QEPCON_COUNT_RST_MODE;
> +	else
> +		reg |= INTEL_QEPCON_COUNT_RST_MODE;
> +
> +	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
> +	

Trim the trailing whitespace here.

William Breathitt Gray

> +	return len;
> +}
> +
> +static const struct counter_device_ext intel_qep_ext[] = {
> +	INTEL_QEP_COUNTER_EXT_RW(noise),
> +	INTEL_QEP_COUNTER_EXT_RO(preset),
> +	INTEL_QEP_COUNTER_EXT_RW(preset_enable)
> +};
> +
> +static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
> +{
> +	struct intel_qep	*qep;
> +	struct device		*dev = &pci->dev;
> +	void __iomem		*regs;
> +	int			ret;
> +	int			irq;
> +
> +	qep = devm_kzalloc(dev, sizeof(*qep), GFP_KERNEL);
> +	if (!qep)
> +		return -ENOMEM;
> +
> +	ret = pcim_enable_device(pci);
> +	if (ret)
> +		return ret;
> +
> +	pci_set_master(pci);
> +
> +	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
> +	if (ret)
> +		return ret;
> +
> +	regs = pcim_iomap_table(pci)[0];
> +	if (!regs)
> +		return -ENOMEM;
> +
> +	qep->pci = pci;
> +	qep->dev = dev;
> +	qep->regs = regs;
> +	mutex_init(&qep->lock);
> +
> +	intel_qep_init(qep, true);
> +	pci_set_drvdata(pci, qep);
> +
> +	qep->counter.name = pci_name(pci);
> +	qep->counter.parent = dev;
> +	qep->counter.ops = &intel_qep_counter_ops;
> +	qep->counter.counts = intel_qep_counter_count;
> +	qep->counter.num_counts = ARRAY_SIZE(intel_qep_counter_count);
> +	qep->counter.signals = intel_qep_signals;
> +	qep->counter.num_signals = ARRAY_SIZE(intel_qep_signals);
> +	qep->counter.ext = intel_qep_ext;
> +	qep->counter.num_ext = ARRAY_SIZE(intel_qep_ext);
> +	qep->counter.priv = qep;
> +
> +	ret = counter_register(&qep->counter);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_ALL_TYPES);
> +	if (ret < 0)
> +		goto err_irq_vectors;
> +
> +	irq = pci_irq_vector(pci, 0);
> +	ret = devm_request_threaded_irq(&pci->dev, irq, intel_qep_irq,
> +			intel_qep_irq_thread, IRQF_SHARED | IRQF_TRIGGER_RISING,
> +			"intel-qep", qep);
> +	if (ret)
> +		goto err_irq;
> +
> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_allow(dev);
> +
> +	return 0;
> +
> +err_irq:
> +	pci_free_irq_vectors(pci);
> +
> +err_irq_vectors:
> +	counter_unregister(&qep->counter);
> +
> +	return ret;
> +}
> +
> +static void intel_qep_remove(struct pci_dev *pci)
> +{
> +	struct intel_qep	*qep = pci_get_drvdata(pci);
> +	struct device		*dev = &pci->dev;
> +
> +	pm_runtime_forbid(dev);
> +	pm_runtime_get_noresume(dev);
> +
> +	intel_qep_writel(qep->regs, INTEL_QEPCON, 0);
> +	pci_free_irq_vectors(pci);
> +	counter_unregister(&qep->counter);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int intel_qep_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int intel_qep_resume(struct device *dev)
> +{
> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +	struct intel_qep *qep = pci_get_drvdata(pdev);
> +
> +	intel_qep_init(qep, false);
> +
> +	return 0;
> +}
> +
> +static int intel_qep_runtime_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int intel_qep_runtime_resume(struct device *dev)
> +{
> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +	struct intel_qep *qep = pci_get_drvdata(pdev);
> +
> +	intel_qep_init(qep, false);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops intel_qep_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(intel_qep_suspend,
> +				intel_qep_resume)
> +	SET_RUNTIME_PM_OPS(intel_qep_runtime_suspend, intel_qep_runtime_resume,
> +				NULL)
> +};
> +
> +static struct pci_driver intel_qep_driver = {
> +	.name		= "intel-qep",
> +	.id_table	= intel_qep_id_table,
> +	.probe		= intel_qep_probe,
> +	.remove		= intel_qep_remove,
> +	.driver = {
> +		.pm = &intel_qep_pm_ops,
> +	}
> +};
> +
> +module_pci_driver(intel_qep_driver);
> +
> +MODULE_AUTHOR("Felipe Balbi <felipe.balbi@linux.intel.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Intel Quadrature Encoder Driver");
> -- 
> 2.23.0
> 

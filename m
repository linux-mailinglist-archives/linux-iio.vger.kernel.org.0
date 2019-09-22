Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE6BAC1A
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2019 01:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388874AbfIVXf4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Sep 2019 19:35:56 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46911 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388766AbfIVXfz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Sep 2019 19:35:55 -0400
Received: by mail-io1-f68.google.com with SMTP id c6so15980211ioo.13
        for <linux-iio@vger.kernel.org>; Sun, 22 Sep 2019 16:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=14stDQVyW1PBl86fWA5cvRPENOZ6DZxtV28cB+rZGYo=;
        b=Sw84jNQrXAaK04U1agYC/sa9VNjDcX7o76/cpl2W39mQjsMtGiBMk0k5SavEfQzMin
         RVd3I1cja83yvbeXyp9RImzDAXGUM9Tq5awiT7fefIkAKa5OU0iW0+M1NCP7NlWe454g
         +8gBXdVi90VO66gn7udyHBoIPUkZYS1ZCC6pTUmCcKgDdB2xJDGF41Jl6r/tHbW9Lx2O
         8wymhIIdm7/DA6TJjZWutyamPpSg6WLGKHANAOIk/pKVlIzrSMrwz7602Veza1to7zu0
         /1HTS8ZhHAOa7PHPok4pe2L/IqyS0KICNkVFX4VOq+9ulxg1A8MLQq7DwAOg8OI+nyVy
         B8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=14stDQVyW1PBl86fWA5cvRPENOZ6DZxtV28cB+rZGYo=;
        b=OCYBq+TN62e2+kwmFhh1WizSttk3U1luk+zR0iwOcZSCAT3nxthiZm8xmHIV5jqF24
         HCmn0XcxbP/IaIjI5p74IvOtAGDfuzse6+xOok7pkVEvQtms65mgu0qrOK3va84QrGMB
         JzHktnY76HyfNkkVzp4DwU4RbgCC1wsvASeymNYEJaZ+PfAeOCSAjqx7SP/j3hNgr6D1
         oSUaPgo432Jw+k5vYHCRmuMeY30Ni4sFDTTX/HxgaHhiQqm3bwAwWkREHKxAQastZ6l1
         ls2GI0knyM3VU0pd7omKAvVEV/pBWQfuDOskxSzL2PlGUOzKXOli1xtMq6GhGsKSZ2ZI
         cgxA==
X-Gm-Message-State: APjAAAW1mLm4HqkxnXi2+Y8MFSL9Rl7nk6CY7qMF8TEvToCqmL2w1Elw
        ifWuPYh4R2HlNJrhGDGRprbMoOvtgOs=
X-Google-Smtp-Source: APXvYqz7cUhU+MNxdHj5XTnjnqQiTtas58Cc7lQqm/gROqPI+/6ahXAW0jisDECUAY0hSHiGk0HtxA==
X-Received: by 2002:a6b:6d07:: with SMTP id a7mr29277074iod.261.1569195353328;
        Sun, 22 Sep 2019 16:35:53 -0700 (PDT)
Received: from icarus (50-201-95-250-static.hfc.comcastbusiness.net. [50.201.95.250])
        by smtp.gmail.com with ESMTPSA id w16sm8358371ioa.4.2019.09.22.16.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 16:35:52 -0700 (PDT)
Date:   Mon, 23 Sep 2019 08:35:38 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     linux-iio@vger.kernel.org,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        David Lechner <david@lechnology.com>
Subject: Re: [RFC/PATCHv2 2/2] counter: introduce support for Intel QEP
 Encoder
Message-ID: <20190922233538.GA3119@icarus>
References: <20190917114403.GA8368@icarus>
 <20190919080305.960198-1-felipe.balbi@linux.intel.com>
 <20190919080305.960198-2-felipe.balbi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190919080305.960198-2-felipe.balbi@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 19, 2019 at 11:03:05AM +0300, Felipe Balbi wrote:
> Add support for Intel PSE Quadrature Encoder
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> ---
> 
> Changes since v1:
> 	- Many more private sysfs files converted over to counter interface
> 
> 
> How do you want me to model this device's Capture Compare Mode (see
> below)?

Hi Felipe,

I'm CCing Fabien and David as they may be interested in the timestamps
discussion. See below for some ideas I have on implementing this.

> For the few features which I couldn't find a matching property in
> counter framework, I still leave them as private sysfs files so we can
> discuss how to model them in the framework.
> 
> Do you want Capture Compare to be a new function mode?
> 
> BTW, I know I'm missing a Documentation file documenting sysfs files
> introduced by this driver, I'll do that once we agree how to move all
> other sysfs files to the framework. No worries.
> 
> 
> Details about the controller (do you want this in commit log?):
> 
> 
> Controller has 2 modes of operation: QEP and Capture. Both modes are
> mutually exclusive. We also have a set of maskable interrupts. Further
> details about each mode below.

I noticed your interrupt handler takes care of a number of different
scenarios. Would you be able to summarize a bit further here the
conditions for this device that cause an interrupt to be fired (watchdog
timeout, FIFO updates, etc.)?

> Quadrature Encoder Mode
> =======================
> 
> Used to measure rotational speed, direction and angle of rotation of a
> motor shaft. Feature list:
> 
> 	- Quadrature decoder providing counter pulses with x4 count
> 	  resolution and count direction
> 
> 	- 32-bit up/down Position Counter for position measurement
> 
> 	- Two modes of position counter reset:
> 		> Maximum Count (ceiling) to reset the position counter
> 		> Index pulse to reset the position counter
> 
> 	- Watchdog timer functionality for detecting ‘stall’ events
> 
> Capture Compare Mode
> ====================
> 
> Used to measure phase input signal Period or Duty Cycle. Feature List:
> 
> 	- Capture function operates either on phase A or phase B input
> 	  and can be configured to operate on lo/hi or hi/lo or both hi
> 	  and lo transitions.
> 
> 	- Free-running 32-bit counter to be configured to run at greater
>           than or equal to 4x input signal frequency

So in "Capture Compare" mode, the counter value is just increasing when
a state condition transition occurs. In that case we won't need a new
function mode to represent this behavior since one already exists:
"increase".

You can add it to your intel_qep_count_functions array like so:

        [INTEL_QEP_ENCODER_MODE_CAPTURE] =
        COUNTER_COUNT_FUNCTION_INCREASE,

The various configurations for this mode are just Synapse action modes.
If you want only Phase A, you would set the action mode for Phase A
("rising edge", "falling edge", or "both edges") and change the action
mode for Phase B to "none"; vice-versa configuration for Phase B instead
of Phase A.

One thing to keep in mind is that action_set will need to maintain valid
configurations -- so if the user tries to set the action mode for Phase
A to something other than "none", you need to automatically set Phase
B's action mode to "none" (and vice-versa).

> 	- Clock post-scaler to derive the counter clock source from the
> 	  peripheral clock

I see you already have a "prescaler" extension in your code. Is this
different from the "post-scaler" you mentioned here?

> 	- 32B wide FIFO to capture 32-bit timestamps of up to 8
> 	  transition events

You can implement this as a Count extension called "timestamps" or
similar. What we can do is have a read on this attribute return the
entire FIFO data buffer as unsigned integers, where each timestamp is
deliminated by a space.

In addition, it may be useful to have another extension called
"timestamps_layout", or something along those lines, that will report
the ordering of the buffer (i.e. whether it's "fifo", "lifo", etc.).

Would this design work for your needs?

William Breathitt Gray

>  drivers/counter/Kconfig     |   6 +
>  drivers/counter/Makefile    |   1 +
>  drivers/counter/intel-qep.c | 862 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 869 insertions(+)
>  create mode 100644 drivers/counter/intel-qep.c
> 
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
> index 000000000000..8347f9fa8e37
> --- /dev/null
> +++ b/drivers/counter/intel-qep.c
> @@ -0,0 +1,862 @@
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
> +static ssize_t phase_error_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct intel_qep *qep = dev_get_drvdata(dev);
> +	u32 reg;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n",
> +			reg & INTEL_QEPCON_PH_ERR ? "error" : "okay");
> +}
> +static DEVICE_ATTR_RO(phase_error);
> +
> +static ssize_t fifo_empty_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct intel_qep *qep = dev_get_drvdata(dev);
> +	u32 reg;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n",
> +			reg & INTEL_QEPCON_FIFO_EMPTY ? "empty" : "not empty");
> +}
> +static DEVICE_ATTR_RO(fifo_empty);
> +
> +static ssize_t operating_mode_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct intel_qep *qep = dev_get_drvdata(dev);
> +	u32 reg;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n",
> +			reg & INTEL_QEPCON_OP_MODE ? "capture" : "quadrature");
> +}
> +
> +static ssize_t operating_mode_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct intel_qep *qep = dev_get_drvdata(dev);
> +	u32 reg;
> +
> +	if (qep->enabled)
> +		return -EINVAL;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +
> +	if (sysfs_streq(buf, "capture"))
> +		reg |= INTEL_QEPCON_OP_MODE;
> +	else if (sysfs_streq(buf, "quadrature"))
> +		reg &= ~INTEL_QEPCON_OP_MODE;
> +
> +	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(operating_mode);
> +
> +static ssize_t capture_mode_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct intel_qep *qep = dev_get_drvdata(dev);
> +	u32 reg;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n",
> +			reg & INTEL_QEPCON_CAP_MODE ? "both" : "single");
> +}
> +
> +static ssize_t capture_mode_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct intel_qep *qep = dev_get_drvdata(dev);
> +	u32 reg;
> +
> +	if (qep->enabled)
> +		return -EINVAL;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +
> +	if (sysfs_streq(buf, "both"))
> +		reg |= INTEL_QEPCON_CAP_MODE;
> +	else if (sysfs_streq(buf, "single"))
> +		reg &= ~INTEL_QEPCON_CAP_MODE;
> +
> +	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(capture_mode);
> +
> +static const struct attribute *intel_qep_attrs[] = {
> +	&dev_attr_capture_mode.attr,
> +	&dev_attr_fifo_empty.attr,
> +	&dev_attr_operating_mode.attr,
> +	&dev_attr_phase_error.attr,
> +	NULL	/* Terminating Entry */
> +};
> +
> +static ssize_t capture_data_read(struct file *filp, struct kobject *kobj,
> +		struct bin_attribute *attr, char *buf,
> +		loff_t offset, size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct intel_qep *qep = dev_get_drvdata(dev);
> +	u32 reg;
> +	int i;
> +
> +	mutex_lock(&qep->lock);
> +	for (i = 0; i < count; i += 4) {
> +		reg = intel_qep_readl(qep->regs, INTEL_QEPCAPBUF);
> +
> +		buf[i + 0] = reg & 0xff;
> +		buf[i + 1] = (reg >> 8) & 0xff;
> +		buf[i + 2] = (reg >> 16) & 0xff;
> +		buf[i + 3] = (reg >> 24) & 0xff;
> +	}
> +	mutex_unlock(&qep->lock);
> +
> +	return count;
> +}
> +
> +static BIN_ATTR_RO(capture_data, 4);
> +
> +static struct bin_attribute *intel_qep_bin_attrs[] = {
> +	&bin_attr_capture_data,
> +	NULL	/* Terminating Entry */
> +};
> +
> +static const struct attribute_group intel_qep_device_aattr_group = {
> +	.name = "qep",
> +	.attrs = (struct attribute **) intel_qep_attrs,
> +	.bin_attrs = intel_qep_bin_attrs,
> +};
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
> +		sysfs_notify(&qep->dev->kobj, "qep", "capture_buffer");
> +
> +	if (stat & INTEL_QEPINT_FIFOENTRY)
> +		sysfs_notify(&qep->dev->kobj, "qep", "capture_buffer");
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
> +	if (req & INTEL_QEPCON_SWPAB)
> +		*function = INTEL_QEP_ENCODER_MODE_SWAPPED;
> +	else
> +		*function = INTEL_QEP_ENCODER_MODE_NORMAL;
> +
> +	return 0;
> +}
> +
> +static int intel_qep_function_set(struct counter_device *counter,
> +		struct counter_count *count, size_t *function)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +	u32 reg;
> +
> +	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
> +	if (*function == INTEL_QEP_ENCODER_MODE_SWAPPED)
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
> +static const char * const intel_qep_clock_prescalers[] = {
> +	"1", "2", "4", "8", "16", "32", "64", "128"
> +};
> +
> +static int intel_qep_clock_prescaler_get(struct counter_device *counter,
> +		struct counter_count *count, size_t *mode)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +	
> +	*mode = intel_qep_readl(qep->regs, INTEL_QEPCAPDIV);
> +
> +	return 0;
> +}
> +
> +static int intel_qep_clock_prescaler_set(struct counter_device *counter,
> +		struct counter_count *count, size_t mode)
> +{
> +	struct intel_qep *qep = counter_to_qep(counter);
> +
> +	intel_qep_writel(qep->regs, INTEL_QEPCAPDIV, ffs(mode) - 1);
> +
> +	return 0;
> +}
> +
> +static struct counter_count_enum_ext intel_qep_clock_prescaler_enum = {
> +	.items = intel_qep_clock_prescalers,
> +	.num_items = ARRAY_SIZE(intel_qep_clock_prescalers),
> +	.get = intel_qep_clock_prescaler_get,
> +	.set = intel_qep_clock_prescaler_set,
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
> +}
> +
> +static const struct counter_count_ext intel_qep_count_ext[] = {
> +	COUNTER_COUNT_ENUM("prescaler", &intel_qep_clock_prescaler_enum),
> +	COUNTER_COUNT_ENUM_AVAILABLE("prescaler",
> +			&intel_qep_clock_prescaler_enum),
> +
> +	INTEL_QEP_COUNTER_COUNT_EXT_RW(ceiling),
> +	INTEL_QEP_COUNTER_COUNT_EXT_RW(enable),
> +	INTEL_QEP_COUNTER_COUNT_EXT_RO(direction),
> +};
> +
> +static struct counter_count intel_qep_counter_count[] = {
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
> +	return len;
> +}
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

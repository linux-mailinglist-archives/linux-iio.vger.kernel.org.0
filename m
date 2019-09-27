Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 069CDC03C0
	for <lists+linux-iio@lfdr.de>; Fri, 27 Sep 2019 12:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfI0K5t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Sep 2019 06:57:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:9889 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfI0K5t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Sep 2019 06:57:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 03:57:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,555,1559545200"; 
   d="scan'208";a="204140510"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga001.fm.intel.com with ESMTP; 27 Sep 2019 03:57:47 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: add support for Intel ADC
In-Reply-To: <20190917143800.000046c1@huawei.com>
References: <20190916103400.321981-1-felipe.balbi@linux.intel.com> <20190917143800.000046c1@huawei.com>
Date:   Fri, 27 Sep 2019 13:57:46 +0300
Message-ID: <87lfuaxaz9.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Hi,

Jonathan Cameron <jonathan.cameron@huawei.com> writes:
>> diff --git a/drivers/iio/adc/intel-adc.c b/drivers/iio/adc/intel-adc.c
>> new file mode 100644
>> index 000000000000..381958668563
>> --- /dev/null
>> +++ b/drivers/iio/adc/intel-adc.c
>> @@ -0,0 +1,482 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/**
>> + * intel-adc.c - Intel ADC Driver
>> + *
>> + * Copyright (C) 2018 Intel Corporation
>> + *
>> + * Author: Felipe Balbi <felipe.balbi@linux.intel.com>
>> + */
>> +
>> +#include <linux/completion.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/iio/buffer.h>
>
> You aren't currently supporting the buffered interface
> or triggers so a few headers to clean out.

removed

>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +
>> +#define PCI_DEVICE_ID_INTEL_EHLLP	0x4bb8
>
> Perhaps just put this inline as it's obvious what it is from
> context so doesn't really need a 'name'.

removed

>> +/* ADC Interrupt Mask Register */
>> +#define ADC_INTR_LOOP_DONE_INTR		BIT(22)
>> +#define ADC_INTR_FIFO_EMPTY_INTR	BIT(21)
>> +#define ADC_INTR_DMA_DONE_INTR		BIT(20)
>> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_7 BIT(19)
>> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_7 BIT(18)
>> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_6 BIT(17)
>> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_6 BIT(16)
>> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_5 BIT(15)
>> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_5 BIT(14)
>> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_4 BIT(13)
>> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_4 BIT(12)
>> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_3 BIT(11)
>> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_3 BIT(10)
>> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_2 BIT(9)
>> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_2 BIT(8)
>> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_1 BIT(7)
>> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_1 BIT(6)
>> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_0 BIT(5)
>> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_0 BIT(4)
>> +#define ADC_INTR_PWR_DWN_EXIT_INTR	BIT(3)
>> +#define ADC_INTR_FIFO_FULL_INTR		BIT(2)
>> +#define ADC_INTR_SMPL_DONE_INTR		BIT(0)
>
> Seems to be a mixture of aligned spacing and non aligned.
> I don't mind which, but consistency is good.

I did it like this because otherwise I would need another tab for all
defines and some of them would cross 80-columns. I can change, no
worries, just let me know.

>> +#define ADC_INTR_ALL_MASK	(ADC_INTR_LOOP_DONE_INTR |		\
>> +				ADC_INTR_FIFO_EMPTY_INTR |		\
>> +				ADC_INTR_DMA_DONE_INTR |		\
>> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_7 |	\
>> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_7 |	\
>> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_6 |	\
>> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_6 |	\
>> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_5 |	\
>> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_5 |	\
>> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_4 |	\
>> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_4 |	\
>> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_3 |	\
>> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_3 |	\
>> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_2 |	\
>> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_2 |	\
>> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_1 |	\
>> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_1 |	\
>> +				ADC_INTR_DATA_THRSHLD_LOW_INTR_0 |	\
>> +				ADC_INTR_DATA_THRSHLD_HIGH_INTR_0 |	\
>> +				ADC_INTR_PWR_DWN_EXIT_INTR |		\
>> +				ADC_INTR_FIFO_FULL_INTR |		\
>> +				ADC_INTR_SMPL_DONE_INTR)
>> +
>> +#define ADC_VREF_UV		1600000 /* uV */
>
> Units are in the define name (which is nice btw) so probably no need for
> the comment.
>
>> +#define ADC_DEFAULT_CONVERSION_TIMEOUT 5000 /* ms */
>
> Give this one explicit units in it's naming as well.

done

> The ADC prefix is a bit generic, but I suppose it's unlikely to get
> used in standard headers etc...

okay

>> +
>> +struct intel_adc {
>> +	struct completion completion;
>> +	struct pci_dev *pci;
>> +	struct iio_dev *iio;
>
> As noted below, this pointer appears unused. I'm not sure the
> pci one is used either...

removed both

>> +static int intel_adc_read_raw(struct iio_dev *iio,
>> +		struct iio_chan_spec const *channel, int *val, int *val2,
>> +		long mask)
>> +{
>> +	struct intel_adc *adc = iio_priv(iio);
>> +	int shift;
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		shift = channel->scan_type.shift;
>> +
>> +		ret = iio_device_claim_direct_mode(iio);
>> +		if (ret)
>> +			break;
>> +
>> +		intel_adc_enable(adc);
>> +
>> +		ret = intel_adc_single_channel_conversion(adc, channel, val);
>> +		if (ret) {
>> +			intel_adc_disable(adc);
>> +			iio_device_release_direct_mode(iio);
>> +			break;
>
> nitpick (feel free to ignore).
> It might be nice to pull this case block as a separate function, then you
> could cleanly use goto to do the unwinding.

you mean something like below:

static int intel_adc_read_info_raw(...)
{
	....
}

static int intel_adc_read_raw(...)
{
	switch (mask) {
        case IIO_CHAN_INFO_RAW:
        	ret = intel_adc_read_info_raw(...);
                break;
        default:
        	ret = -EINVAL;
        }
}

??

>> +#define INTEL_ADC_DIFF_CHAN(c1, c2)			\
>> +{							\
>> +	.type = IIO_VOLTAGE,				\
>> +	.differential = true,				\
>> +	.indexed = 1,					\
>> +	.channel = (c1),				\
>> +	.channel2 = (c2),				\
>> +	.scan_index = (c1),				\
>
> I think we get overlapping index values between these and
> the SINGLE_CHAN ones. These should be unique.
>
> Also, without buffered interface support they don't actually
> do anything so drop them for now.  Same with scan_type.

removed

>> +#define INTEL_ADC_SINGLE_CHAN(c)			\
>> +{							\
>> +	.type = IIO_VOLTAGE,				\
>> +	.indexed = 1,					\
>> +	.channel = (c),					\
>> +	.scan_index = (c),				\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>> +	.scan_type = {					\
>> +		.sign = 's',				\
>> +		.realbits = 14,				\
>> +		.storagebits = 32,			\
>> +		.shift = 0,				\
>
> No need to specify shift of 0 as that's the 'obviousish' default.

removed

>> +static int intel_adc_probe(struct pci_dev *pci, const struct pci_device_id *id)
>> +{
>> +	struct intel_adc *adc;
>> +	struct iio_dev *iio;
>> +	int ret;
>> +	int irq;
>> +
>> +	iio = devm_iio_device_alloc(&pci->dev, sizeof(*adc));
>> +	if (!iio)
>> +		return -ENOMEM;
>> +
>> +	adc = iio_priv(iio);
>> +	adc->pci = pci;
>> +	adc->iio = iio;
>
> This pointer look usually means that the driver could be slightly
> adjusted to remove the need to go from iio_dev -> private
> and private-> iio_dev.
>
> In this case I can't find a user of adc->iio so get rid of it.

removed

>> +	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_ALL_TYPES);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	irq = pci_irq_vector(pci, 0);
>> +	ret = devm_request_irq(&pci->dev, irq, intel_adc_irq,
>> +			IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_RISING,
>> +			"intel-adc", adc);
>
> Requesting the interrupt only after exposing userspace and in kernel
> interfaces seems liable to cause problem.

It goes the other way around, rather. If I request the interrupt before,
then I could get interrupts before IIO subsystem knows about the device,
no?

>> +	if (ret)
>> +		goto err;
>> +
>> +	pm_runtime_set_autosuspend_delay(&pci->dev, 1000);
>> +	pm_runtime_use_autosuspend(&pci->dev);
>> +	pm_runtime_put_autosuspend(&pci->dev);
>> +	pm_runtime_allow(&pci->dev);
>> +
>> +	return 0;
>> +
>> +err:
>> +	pci_free_irq_vectors(pci);
>> +	return ret;
>> +}
>> +
>> +static void intel_adc_remove(struct pci_dev *pci)
>> +{
>> +	pm_runtime_forbid(&pci->dev);
>> +	pm_runtime_get_noresume(&pci->dev);
>> +
>> +	pci_free_irq_vectors(pci);
>
> There is a theoretical race here.  We have freed the irq vectors
> before removing the userspace and in kernel interfaces.

There's no way to sort this out, though. Is there? Apart from switching
away from device managed resources.

>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int intel_adc_suspend(struct device *dev)
>> +{
>
> Why provide empty sleep and resume functions?

no reason, removed.

>> +	return 0;
>> +}
>> +
>> +static int intel_adc_resume(struct device *dev)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(intel_adc_pm_ops, intel_adc_suspend, intel_adc_resume);

then removed this

>> +static const struct pci_device_id intel_adc_id_table[] = {
>> +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_EHLLP), },
>> +	{  } /* Terminating Entry */
>> +};
>> +MODULE_DEVICE_TABLE(pci, intel_adc_id_table);
>> +
>> +static struct pci_driver intel_adc_driver = {
>> +	.name		= "intel-adc",
>> +	.probe		= intel_adc_probe,
>> +	.remove		= intel_adc_remove,
>> +	.id_table	= intel_adc_id_table,
>> +	.driver = {
>> +	.pm = &intel_adc_pm_ops,
>
> .pm should be indented one more level.

and this

-- 
balbi

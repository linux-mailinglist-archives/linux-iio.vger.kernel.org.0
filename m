Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B88AC9F53
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2019 15:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfJCNXX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Oct 2019 09:23:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726199AbfJCNXX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Oct 2019 09:23:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 385834BC135FC9AB15BA;
        Thu,  3 Oct 2019 21:23:21 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 3 Oct 2019
 21:23:18 +0800
Date:   Thu, 3 Oct 2019 14:23:09 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: add support for Intel ADC
Message-ID: <20191003142309.000062ca@huawei.com>
In-Reply-To: <87lfuaxaz9.fsf@gmail.com>
References: <20190916103400.321981-1-felipe.balbi@linux.intel.com>
        <20190917143800.000046c1@huawei.com>
        <87lfuaxaz9.fsf@gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Sep 2019 13:57:46 +0300
Felipe Balbi <felipe.balbi@linux.intel.com> wrote:

> Hi,

Late reply obviously so you may well have resolved queries in your
v2 patch.

...
> 
> >> +/* ADC Interrupt Mask Register */
> >> +#define ADC_INTR_LOOP_DONE_INTR		BIT(22)
> >> +#define ADC_INTR_FIFO_EMPTY_INTR	BIT(21)
> >> +#define ADC_INTR_DMA_DONE_INTR		BIT(20)
> >> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_7 BIT(19)
> >> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_7 BIT(18)
> >> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_6 BIT(17)
> >> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_6 BIT(16)
> >> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_5 BIT(15)
> >> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_5 BIT(14)
> >> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_4 BIT(13)
> >> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_4 BIT(12)
> >> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_3 BIT(11)
> >> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_3 BIT(10)
> >> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_2 BIT(9)
> >> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_2 BIT(8)
> >> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_1 BIT(7)
> >> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_1 BIT(6)
> >> +#define ADC_INTR_DATA_THRSHLD_LOW_INTR_0 BIT(5)
> >> +#define ADC_INTR_DATA_THRSHLD_HIGH_INTR_0 BIT(4)
> >> +#define ADC_INTR_PWR_DWN_EXIT_INTR	BIT(3)
> >> +#define ADC_INTR_FIFO_FULL_INTR		BIT(2)
> >> +#define ADC_INTR_SMPL_DONE_INTR		BIT(0)  
> >
> > Seems to be a mixture of aligned spacing and non aligned.
> > I don't mind which, but consistency is good.  
> 
> I did it like this because otherwise I would need another tab for all
> defines and some of them would cross 80-columns. I can change, no
> worries, just let me know.

I'll go with whatever you did as don't care that strongly!

..

> >> +static int intel_adc_read_raw(struct iio_dev *iio,
> >> +		struct iio_chan_spec const *channel, int *val, int *val2,
> >> +		long mask)
> >> +{
> >> +	struct intel_adc *adc = iio_priv(iio);
> >> +	int shift;
> >> +	int ret;
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_RAW:
> >> +		shift = channel->scan_type.shift;
> >> +
> >> +		ret = iio_device_claim_direct_mode(iio);
> >> +		if (ret)
> >> +			break;
> >> +
> >> +		intel_adc_enable(adc);
> >> +
> >> +		ret = intel_adc_single_channel_conversion(adc, channel, val);
> >> +		if (ret) {
> >> +			intel_adc_disable(adc);
> >> +			iio_device_release_direct_mode(iio);
> >> +			break;  
> >
> > nitpick (feel free to ignore).
> > It might be nice to pull this case block as a separate function, then you
> > could cleanly use goto to do the unwinding.  
> 
> you mean something like below:
> 
> static int intel_adc_read_info_raw(...)
> {
> 	....
> }
> 
> static int intel_adc_read_raw(...)
> {
> 	switch (mask) {
>         case IIO_CHAN_INFO_RAW:
>         	ret = intel_adc_read_info_raw(...);
>                 break;
>         default:
>         	ret = -EINVAL;
>         }
> }
> 
> ??

Yes, exactly that.

...

> 
> >> +static int intel_adc_probe(struct pci_dev *pci, const struct pci_device_id *id)
> >> +{
> >> +	struct intel_adc *adc;
> >> +	struct iio_dev *iio;
> >> +	int ret;
> >> +	int irq;
> >> +
> >> +	iio = devm_iio_device_alloc(&pci->dev, sizeof(*adc));
> >> +	if (!iio)
> >> +		return -ENOMEM;
> >> +
> >> +	adc = iio_priv(iio);
> >> +	adc->pci = pci;
> >> +	adc->iio = iio;  
> >
> > This pointer look usually means that the driver could be slightly
> > adjusted to remove the need to go from iio_dev -> private
> > and private-> iio_dev.
> >
> > In this case I can't find a user of adc->iio so get rid of it.  
> 
> removed
> 
> >> +	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_ALL_TYPES);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	irq = pci_irq_vector(pci, 0);
> >> +	ret = devm_request_irq(&pci->dev, irq, intel_adc_irq,
> >> +			IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_RISING,
> >> +			"intel-adc", adc);  
> >
> > Requesting the interrupt only after exposing userspace and in kernel
> > interfaces seems liable to cause problem.  
> 
> It goes the other way around, rather. If I request the interrupt before,
> then I could get interrupts before IIO subsystem knows about the device,
> no?

Only if your device comes up with interrupts already enabled.  Normally they
only turn on in response to some userspace interaction, such as enabling
a threshold. Unless there is a hardware limitation, then at startup no
such interrupt sources should be enabled.

> 
> >> +	if (ret)
> >> +		goto err;
> >> +
> >> +	pm_runtime_set_autosuspend_delay(&pci->dev, 1000);
> >> +	pm_runtime_use_autosuspend(&pci->dev);
> >> +	pm_runtime_put_autosuspend(&pci->dev);
> >> +	pm_runtime_allow(&pci->dev);
> >> +
> >> +	return 0;
> >> +
> >> +err:
> >> +	pci_free_irq_vectors(pci);
> >> +	return ret;
> >> +}
> >> +
> >> +static void intel_adc_remove(struct pci_dev *pci)
> >> +{
> >> +	pm_runtime_forbid(&pci->dev);
> >> +	pm_runtime_get_noresume(&pci->dev);
> >> +
> >> +	pci_free_irq_vectors(pci);  
> >
> > There is a theoretical race here.  We have freed the irq vectors
> > before removing the userspace and in kernel interfaces.  
> 
> There's no way to sort this out, though. Is there? Apart from switching
> away from device managed resources.

There is the rather helpful,

devm_add_action_or_reset() that allows you to define additional cleanup
actions to be automatically run.  It's either that, or stop using
device managed resources from the point at which something that isn't
device managed occurs in probe.

..

Thanks,

Jonathan


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2033CDE12
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 11:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfJGJQM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 05:16:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34998 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727262AbfJGJQM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 05:16:12 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BF43A33FB8834C0A5477;
        Mon,  7 Oct 2019 17:16:10 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 7 Oct 2019
 17:16:05 +0800
Date:   Mon, 7 Oct 2019 10:15:55 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: add support for Intel ADC
Message-ID: <20191007101555.000028e2@huawei.com>
In-Reply-To: <87wodlqajd.fsf@gmail.com>
References: <20190916103400.321981-1-felipe.balbi@linux.intel.com>
        <20190917143800.000046c1@huawei.com>
        <87lfuaxaz9.fsf@gmail.com>
        <20191003142309.000062ca@huawei.com>
        <87wodlqajd.fsf@gmail.com>
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

On Fri, 4 Oct 2019 09:39:34 +0300
Felipe Balbi <felipe.balbi@linux.intel.com> wrote:

> Hi,
> 
> Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> >> >> +static int intel_adc_read_raw(struct iio_dev *iio,
> >> >> +		struct iio_chan_spec const *channel, int *val, int *val2,
> >> >> +		long mask)
> >> >> +{
> >> >> +	struct intel_adc *adc = iio_priv(iio);
> >> >> +	int shift;
> >> >> +	int ret;
> >> >> +
> >> >> +	switch (mask) {
> >> >> +	case IIO_CHAN_INFO_RAW:
> >> >> +		shift = channel->scan_type.shift;
> >> >> +
> >> >> +		ret = iio_device_claim_direct_mode(iio);
> >> >> +		if (ret)
> >> >> +			break;
> >> >> +
> >> >> +		intel_adc_enable(adc);
> >> >> +
> >> >> +		ret = intel_adc_single_channel_conversion(adc, channel, val);
> >> >> +		if (ret) {
> >> >> +			intel_adc_disable(adc);
> >> >> +			iio_device_release_direct_mode(iio);
> >> >> +			break;    
> >> >
> >> > nitpick (feel free to ignore).
> >> > It might be nice to pull this case block as a separate function, then you
> >> > could cleanly use goto to do the unwinding.    
> >> 
> >> you mean something like below:
> >> 
> >> static int intel_adc_read_info_raw(...)
> >> {
> >> 	....
> >> }
> >> 
> >> static int intel_adc_read_raw(...)
> >> {
> >> 	switch (mask) {
> >>         case IIO_CHAN_INFO_RAW:
> >>         	ret = intel_adc_read_info_raw(...);
> >>                 break;
> >>         default:
> >>         	ret = -EINVAL;
> >>         }
> >> }
> >> 
> >> ??  
> >
> > Yes, exactly that.  
> 
> I'll change it, no worries.
> 
> >> >> +	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_ALL_TYPES);
> >> >> +	if (ret < 0)
> >> >> +		return ret;
> >> >> +
> >> >> +	irq = pci_irq_vector(pci, 0);
> >> >> +	ret = devm_request_irq(&pci->dev, irq, intel_adc_irq,
> >> >> +			IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_RISING,
> >> >> +			"intel-adc", adc);    
> >> >
> >> > Requesting the interrupt only after exposing userspace and in kernel
> >> > interfaces seems liable to cause problem.    
> >> 
> >> It goes the other way around, rather. If I request the interrupt before,
> >> then I could get interrupts before IIO subsystem knows about the device,
> >> no?  
> >
> > Only if your device comes up with interrupts already enabled.  Normally they
> > only turn on in response to some userspace interaction, such as enabling
> > a threshold. Unless there is a hardware limitation, then at startup no
> > such interrupt sources should be enabled.  
> 
> We have FW that _may_ use the hardware and leave it at unpredictable
> state. There is a potential for irq status bits being left over by
> FW.
> 

If it is only status bits rather than actually leaving the interrupt enabled
I'd do whatever actions are needed to clear those so you are in a
clean state when the driver loads (basically do the equivalent of what
you would get if there was a "soft reset" function.

Unpredictable is nasty! :)

Jonathan


> 
> >> >> +	if (ret)
> >> >> +		goto err;
> >> >> +
> >> >> +	pm_runtime_set_autosuspend_delay(&pci->dev, 1000);
> >> >> +	pm_runtime_use_autosuspend(&pci->dev);
> >> >> +	pm_runtime_put_autosuspend(&pci->dev);
> >> >> +	pm_runtime_allow(&pci->dev);
> >> >> +
> >> >> +	return 0;
> >> >> +
> >> >> +err:
> >> >> +	pci_free_irq_vectors(pci);
> >> >> +	return ret;
> >> >> +}
> >> >> +
> >> >> +static void intel_adc_remove(struct pci_dev *pci)
> >> >> +{
> >> >> +	pm_runtime_forbid(&pci->dev);
> >> >> +	pm_runtime_get_noresume(&pci->dev);
> >> >> +
> >> >> +	pci_free_irq_vectors(pci);    
> >> >
> >> > There is a theoretical race here.  We have freed the irq vectors
> >> > before removing the userspace and in kernel interfaces.    
> >> 
> >> There's no way to sort this out, though. Is there? Apart from switching
> >> away from device managed resources.  
> >
> > There is the rather helpful,
> >
> > devm_add_action_or_reset() that allows you to define additional cleanup
> > actions to be automatically run.  It's either that, or stop using
> > device managed resources from the point at which something that isn't
> > device managed occurs in probe.  
> 
> I'll have a look, thanks.
> 



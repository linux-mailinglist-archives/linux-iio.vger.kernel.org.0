Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38D1CB48D
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2019 08:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbfJDGji (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Oct 2019 02:39:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:11421 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387864AbfJDGjh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 4 Oct 2019 02:39:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 23:39:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,255,1566889200"; 
   d="scan'208";a="392204039"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga005.fm.intel.com with ESMTP; 03 Oct 2019 23:39:34 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: add support for Intel ADC
In-Reply-To: <20191003142309.000062ca@huawei.com>
References: <20190916103400.321981-1-felipe.balbi@linux.intel.com> <20190917143800.000046c1@huawei.com> <87lfuaxaz9.fsf@gmail.com> <20191003142309.000062ca@huawei.com>
Date:   Fri, 04 Oct 2019 09:39:34 +0300
Message-ID: <87wodlqajd.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Hi,

Jonathan Cameron <jonathan.cameron@huawei.com> writes:
>> >> +static int intel_adc_read_raw(struct iio_dev *iio,
>> >> +		struct iio_chan_spec const *channel, int *val, int *val2,
>> >> +		long mask)
>> >> +{
>> >> +	struct intel_adc *adc = iio_priv(iio);
>> >> +	int shift;
>> >> +	int ret;
>> >> +
>> >> +	switch (mask) {
>> >> +	case IIO_CHAN_INFO_RAW:
>> >> +		shift = channel->scan_type.shift;
>> >> +
>> >> +		ret = iio_device_claim_direct_mode(iio);
>> >> +		if (ret)
>> >> +			break;
>> >> +
>> >> +		intel_adc_enable(adc);
>> >> +
>> >> +		ret = intel_adc_single_channel_conversion(adc, channel, val);
>> >> +		if (ret) {
>> >> +			intel_adc_disable(adc);
>> >> +			iio_device_release_direct_mode(iio);
>> >> +			break;  
>> >
>> > nitpick (feel free to ignore).
>> > It might be nice to pull this case block as a separate function, then you
>> > could cleanly use goto to do the unwinding.  
>> 
>> you mean something like below:
>> 
>> static int intel_adc_read_info_raw(...)
>> {
>> 	....
>> }
>> 
>> static int intel_adc_read_raw(...)
>> {
>> 	switch (mask) {
>>         case IIO_CHAN_INFO_RAW:
>>         	ret = intel_adc_read_info_raw(...);
>>                 break;
>>         default:
>>         	ret = -EINVAL;
>>         }
>> }
>> 
>> ??
>
> Yes, exactly that.

I'll change it, no worries.

>> >> +	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_ALL_TYPES);
>> >> +	if (ret < 0)
>> >> +		return ret;
>> >> +
>> >> +	irq = pci_irq_vector(pci, 0);
>> >> +	ret = devm_request_irq(&pci->dev, irq, intel_adc_irq,
>> >> +			IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_RISING,
>> >> +			"intel-adc", adc);  
>> >
>> > Requesting the interrupt only after exposing userspace and in kernel
>> > interfaces seems liable to cause problem.  
>> 
>> It goes the other way around, rather. If I request the interrupt before,
>> then I could get interrupts before IIO subsystem knows about the device,
>> no?
>
> Only if your device comes up with interrupts already enabled.  Normally they
> only turn on in response to some userspace interaction, such as enabling
> a threshold. Unless there is a hardware limitation, then at startup no
> such interrupt sources should be enabled.

We have FW that _may_ use the hardware and leave it at unpredictable
state. There is a potential for irq status bits being left over by
FW.


>> >> +	if (ret)
>> >> +		goto err;
>> >> +
>> >> +	pm_runtime_set_autosuspend_delay(&pci->dev, 1000);
>> >> +	pm_runtime_use_autosuspend(&pci->dev);
>> >> +	pm_runtime_put_autosuspend(&pci->dev);
>> >> +	pm_runtime_allow(&pci->dev);
>> >> +
>> >> +	return 0;
>> >> +
>> >> +err:
>> >> +	pci_free_irq_vectors(pci);
>> >> +	return ret;
>> >> +}
>> >> +
>> >> +static void intel_adc_remove(struct pci_dev *pci)
>> >> +{
>> >> +	pm_runtime_forbid(&pci->dev);
>> >> +	pm_runtime_get_noresume(&pci->dev);
>> >> +
>> >> +	pci_free_irq_vectors(pci);  
>> >
>> > There is a theoretical race here.  We have freed the irq vectors
>> > before removing the userspace and in kernel interfaces.  
>> 
>> There's no way to sort this out, though. Is there? Apart from switching
>> away from device managed resources.
>
> There is the rather helpful,
>
> devm_add_action_or_reset() that allows you to define additional cleanup
> actions to be automatically run.  It's either that, or stop using
> device managed resources from the point at which something that isn't
> device managed occurs in probe.

I'll have a look, thanks.

-- 
balbi

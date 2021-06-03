Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C7C39A575
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 18:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhFCQMh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 12:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhFCQMh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 12:12:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1867B6121D;
        Thu,  3 Jun 2021 16:10:49 +0000 (UTC)
Date:   Thu, 3 Jun 2021 17:12:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v4] counter: Add support for Intel Quadrature Encoder
 Peripheral
Message-ID: <20210603171233.37009042@jic23-huawei>
In-Reply-To: <20210602113259.158674-1-jarkko.nikula@linux.intel.com>
References: <20210602113259.158674-1-jarkko.nikula@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Jun 2021 14:32:59 +0300
Jarkko Nikula <jarkko.nikula@linux.intel.com> wrote:

> Add support for Intel Quadrature Encoder Peripheral found on Intel
> Elkhart Lake platform.
> 
> Initial implementation was done by Felipe Balbi while he was working at
> Intel with later changes from Raymond Tan and me.
> 
> Co-developed-by: Felipe Balbi (Intel) <balbi@kernel.org>
> Signed-off-by: Felipe Balbi (Intel) <balbi@kernel.org>
> Co-developed-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Hi,

Sorry I only got to this on v4 :(

Given all my comments are either minor or not specifically about code here,
feel free to send a follow up if you want to tidy them up.

Applied to the togreg branch of iio.git, initially pushed out as testing for
0-day etc to poke at it.

Thanks,

Jonathan

> ---
...
> +
> +static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
> +{
> +	struct intel_qep *qep;
> +	struct device *dev = &pci->dev;
> +	void __iomem *regs;
> +	int ret;
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
> +	qep->dev = dev;
> +	qep->regs = regs;
> +	mutex_init(&qep->lock);
> +
> +	intel_qep_init(qep);
> +	pci_set_drvdata(pci, qep);
> +
> +	qep->counter.name = pci_name(pci);
> +	qep->counter.parent = dev;
> +	qep->counter.ops = &intel_qep_counter_ops;
> +	qep->counter.counts = intel_qep_counter_count;
> +	qep->counter.num_counts = ARRAY_SIZE(intel_qep_counter_count);
> +	qep->counter.signals = intel_qep_signals;
> +	qep->counter.num_signals = ARRAY_SIZE(intel_qep_signals);
> +	qep->counter.priv = qep;
> +	qep->enabled = false;
> +
> +	pm_runtime_put(dev);
> +	pm_runtime_allow(dev);
> +
> +	return devm_counter_register(&pci->dev, &qep->counter);
> +}
> +
> +static void intel_qep_remove(struct pci_dev *pci)
> +{
> +	struct intel_qep *qep = pci_get_drvdata(pci);

to_pci_dev()

> +	struct device *dev = &pci->dev;
> +
> +	pm_runtime_forbid(dev);
> +	if (!qep->enabled)
> +		pm_runtime_get(dev);

Ouch, I'd not encountered this pci related weirdness before
(All about overriding the fact PCI opts out of runtime)

> +
> +	intel_qep_writel(qep, INTEL_QEPCON, 0);
> +}
> +
> +#ifdef CONFIG_PM

Up to William and yourself, but I would prefer not to see these ifdefs
but instead mark the functions __maybe_unused and let the linker
drop them.  It tends to be less error prone if the pm handling gets
more complex in future.

> +static int intel_qep_suspend(struct device *dev)
> +{
> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);

to_pci_dev()
Though if all you are doing is using it to then get the drvdata
avoid the round trip.  There have been a few patch sets tidying this up
in recent years and good not to add the noise of having that happen here.

struct intel_qep *qep = dev_get_drvdata(dev);


> +	struct intel_qep *qep = pci_get_drvdata(pdev);
> +
> +	qep->qepcon = intel_qep_readl(qep, INTEL_QEPCON);
> +	qep->qepflt = intel_qep_readl(qep, INTEL_QEPFLT);
> +	qep->qepmax = intel_qep_readl(qep, INTEL_QEPMAX);
> +
> +	return 0;
> +}
> +
> +static int intel_qep_resume(struct device *dev)
> +{
> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);

to_pci_dev()

> +	struct intel_qep *qep = pci_get_drvdata(pdev);
> +
> +	/*
> +	 * Make sure peripheral is disabled when restoring registers and
> +	 * control register bits that are writable only when the peripheral
> +	 * is disabled
> +	 */
> +	intel_qep_writel(qep, INTEL_QEPCON, 0);
> +	intel_qep_readl(qep, INTEL_QEPCON);
> +
> +	intel_qep_writel(qep, INTEL_QEPFLT, qep->qepflt);
> +	intel_qep_writel(qep, INTEL_QEPMAX, qep->qepmax);
> +	intel_qep_writel(qep, INTEL_QEPINT_MASK, INTEL_QEPINT_MASK_ALL);
> +
> +	/* Restore all other control register bits except enable status */
> +	intel_qep_writel(qep, INTEL_QEPCON, qep->qepcon & ~INTEL_QEPCON_EN);
> +	intel_qep_readl(qep, INTEL_QEPCON);
> +
> +	/* Restore enable status */
> +	intel_qep_writel(qep, INTEL_QEPCON, qep->qepcon);
> +
> +	return 0;
> +}
> +#endif
> +
> +static UNIVERSAL_DEV_PM_OPS(intel_qep_pm_ops,
> +			    intel_qep_suspend, intel_qep_resume, NULL);
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
> +static struct pci_driver intel_qep_driver = {
> +	.name = "intel-qep",
> +	.id_table = intel_qep_id_table,
> +	.probe = intel_qep_probe,
> +	.remove = intel_qep_remove,
> +	.driver = {
> +		.pm = &intel_qep_pm_ops,
> +	}
> +};
> +
> +module_pci_driver(intel_qep_driver);
> +
> +MODULE_AUTHOR("Felipe Balbi (Intel)");
> +MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
> +MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Intel Quadrature Encoder Peripheral driver");


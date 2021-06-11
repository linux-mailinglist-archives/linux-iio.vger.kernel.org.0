Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32BA3A47D1
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFKRXi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhFKRXi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:23:38 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6BF061040;
        Fri, 11 Jun 2021 17:21:39 +0000 (UTC)
Date:   Fri, 11 Jun 2021 18:23:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH 1/2] counter: intel-qep: Mark PM callbacks with
 __maybe_unused
Message-ID: <20210611182334.61133958@jic23-huawei>
In-Reply-To: <20210611115558.796338-1-jarkko.nikula@linux.intel.com>
References: <20210611115558.796338-1-jarkko.nikula@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Jun 2021 14:55:57 +0300
Jarkko Nikula <jarkko.nikula@linux.intel.com> wrote:

> Remove CONFIG_PM ifdef and mark PM callbacks with __maybe_unused.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Both applied to the togreg branch of iio.git and pushed out
as testing to let 0-day poke at them.

William, if you want to give feedback on these, still time for
me to add tags etc. They just seem trivial enough its not worth
wasting your time :)

Jonathan


> ---
>  drivers/counter/intel-qep.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index ab10ba33f46a..a8d3dccecc0f 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -473,8 +473,7 @@ static void intel_qep_remove(struct pci_dev *pci)
>  	intel_qep_writel(qep, INTEL_QEPCON, 0);
>  }
>  
> -#ifdef CONFIG_PM
> -static int intel_qep_suspend(struct device *dev)
> +static int __maybe_unused intel_qep_suspend(struct device *dev)
>  {
>  	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
>  	struct intel_qep *qep = pci_get_drvdata(pdev);
> @@ -486,7 +485,7 @@ static int intel_qep_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int intel_qep_resume(struct device *dev)
> +static int __maybe_unused intel_qep_resume(struct device *dev)
>  {
>  	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
>  	struct intel_qep *qep = pci_get_drvdata(pdev);
> @@ -512,7 +511,6 @@ static int intel_qep_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static UNIVERSAL_DEV_PM_OPS(intel_qep_pm_ops,
>  			    intel_qep_suspend, intel_qep_resume, NULL);


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA16B41DEEF
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 18:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350292AbhI3Q05 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 12:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350163AbhI3Q05 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Sep 2021 12:26:57 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9967361507;
        Thu, 30 Sep 2021 16:25:13 +0000 (UTC)
Date:   Thu, 30 Sep 2021 17:29:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: Kconfig: add COMPILE_TEST dep for
 berlin2-adc
Message-ID: <20210930172908.10a31910@jic23-huawei>
In-Reply-To: <20210926192642.4051329-2-aardelean@deviqon.com>
References: <20210926192642.4051329-1-aardelean@deviqon.com>
        <20210926192642.4051329-2-aardelean@deviqon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Sep 2021 22:26:42 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> Otherwise most build checks will omit this driver from a compile-test due
> to it's dependency only on the BERLIN_ARCH symbol.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
I was rather expecting this to need more dependencies, but I can't find
anything that isn't appropriately stubbed out.

Guess time to let 0-day and it's brute force builds work their magic.

Series applied to the togreg branch of iio.git and pushed out as testing to
see if we did miss a select or two in here.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 0ceea8e69e3c..8bf5b62a73f4 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -354,7 +354,7 @@ config BCM_IPROC_ADC
>  
>  config BERLIN2_ADC
>  	tristate "Marvell Berlin2 ADC driver"
> -	depends on ARCH_BERLIN
> +	depends on ARCH_BERLIN || COMPILE_TEST
>  	help
>  	  Marvell Berlin2 ADC driver. This ADC has 8 channels, with one used for
>  	  temperature measurement.


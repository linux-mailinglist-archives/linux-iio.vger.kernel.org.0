Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80C531B060
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 13:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhBNMl1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 07:41:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhBNMl1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 07:41:27 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1330F64DC4;
        Sun, 14 Feb 2021 12:40:45 +0000 (UTC)
Date:   Sun, 14 Feb 2021 12:40:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michael.hennerich@analog.com>
Subject: Re: [PATCH] iio: adc: adi-axi-adc: add proper Kconfig dependencies
Message-ID: <20210214124042.527bcfce@archlinux>
In-Reply-To: <20210210105044.48914-1-alexandru.ardelean@analog.com>
References: <20210210105044.48914-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 Feb 2021 12:50:44 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The ADI AXI ADC driver requires IO mem access and OF to work. This change
> adds these dependencies to the Kconfig symbol of the driver.
> 
> This was also found via the lkp bot, as the
> devm_platform_ioremap_resource() symbol was not found at link-time on the
> S390 architecture.
> 
> Fixes: ef04070692a21 ("iio: adc: adi-axi-adc: add support for AXI ADC IP core")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 769381b05b9a..d20a3b574af9 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -266,6 +266,8 @@ config ADI_AXI_ADC
>  	select IIO_BUFFER
>  	select IIO_BUFFER_HW_CONSUMER
>  	select IIO_BUFFER_DMAENGINE
> +	depends on HAS_IOMEM
> +	depends on OF
>  	help
>  	  Say yes here to build support for Analog Devices Generic
>  	  AXI ADC IP core. The IP core is used for interfacing with


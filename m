Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6982A4182B6
	for <lists+linux-iio@lfdr.de>; Sat, 25 Sep 2021 16:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbhIYO2L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Sep 2021 10:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233738AbhIYO2L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Sep 2021 10:28:11 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFC2760E94;
        Sat, 25 Sep 2021 14:26:34 +0000 (UTC)
Date:   Sat, 25 Sep 2021 15:30:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: exynos: describe drivers in KConfig
Message-ID: <20210925153023.06ef72ec@jic23-huawei>
In-Reply-To: <20210924133515.112357-1-krzysztof.kozlowski@canonical.com>
References: <20210924133515.112357-1-krzysztof.kozlowski@canonical.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Sep 2021 15:35:15 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

> Describe better which driver applies to which SoC, to make configuring
> kernel for Samsung SoC easier.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Seems reasonable.  Applied thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index af168e1c9fdb..6cc1268da184 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -430,9 +430,9 @@ config EXYNOS_ADC
>  	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210 || (OF && COMPILE_TEST)
>  	depends on HAS_IOMEM
>  	help
> -	  Core support for the ADC block found in the Samsung EXYNOS series
> -	  of SoCs for drivers such as the touchscreen and hwmon to use to share
> -	  this resource.
> +	  Driver for the ADC block found in the Samsung S3C (S3C2410, S3C2416,
> +	  S3C2440, S3C2443, S3C6410), S5Pv210 and Exynos SoCs.
> +	  Choose Y here only if you build for such Samsung SoC.
>  
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called exynos_adc.


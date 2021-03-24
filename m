Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3423480DA
	for <lists+linux-iio@lfdr.de>; Wed, 24 Mar 2021 19:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbhCXSpX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Mar 2021 14:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbhCXSpU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Mar 2021 14:45:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A49C061763;
        Wed, 24 Mar 2021 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=HTSdwoRP5dmxsgCF/xA6hkpSAAHIJMb2ezjmo0YktMo=; b=KykvmMgjsL+ZpU2ypuOiwW8NaY
        jZZn0Vk4VucY5RM/Fjms3j/17U4XRl14dIOIH7UbL/ZJQIPzd4gx7GyZeyMEPGAKFV6Az2Dk3AA2K
        aOegWKg09XYGT5zTfV4SluWDNk9+vfjfB9wYF+R/QbaTmiYDKJiC6TQ/kMafOM/PADySxxWr/3d9P
        oWhKpStTM76Y3pizH6t799phwF0IGRhQS1MyZThhRGJwHPEgrDVBwCkinC0p1kkPoyB/CfUu7IKlg
        L3S7jnmSr7+BLGhvPzRpTUqC8CGZMDDCgcajzd8eV+ZNHJKiJ/p9nmLkTpS9CTT9mf8w3pY4kiqSj
        yUMrBNcA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP8VI-0004lw-PM; Wed, 24 Mar 2021 18:45:17 +0000
Subject: Re: [PATCH] iio: adc: Kconfig: make AD9467 depend on ADI_AXI_ADC
 symbol
To:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, linux@deviqon.com
References: <20210324182746.9337-1-aardelean@deviqon.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c0220f77-da29-56a0-d528-90cafc0b391b@infradead.org>
Date:   Wed, 24 Mar 2021 11:45:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324182746.9337-1-aardelean@deviqon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/24/21 11:27 AM, Alexandru Ardelean wrote:
> Because a dependency on HAS_IOMEM and OF was added for the ADI AXI ADC
> driver, this makes the AD9467 driver have some build/dependency issues
> when OF is disabled (typically on ACPI archs like x86).
> 
> This is because the selection of the AD9467 enforces the ADI_AXI_ADC symbol
> which is blocked by the OF (and potentially HAS_IOMEM) being disabled.
> 
> To fix this, we make the AD9467 driver depend on the ADI_AXI_ADC symbol.
> The AD9467 driver cannot operate on it's own. It requires the ADI AXI ADC
> driver to stream data (or some similar IIO interface).
> 
> So, the fix here is to make the AD9467 symbol depend on the ADI_AXI_ADC
> symbol. At some point this could become it's own subgroup of high-speed
> ADCs.
> 
> Fixes: be24c65e9fa24 ("iio: adc: adi-axi-adc: add proper Kconfig dependencies")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> Apologies for this being too late.
> I made the patch but forgot it in a local tree.
> 
> Related to discussion:
>    https://lkml.org/lkml/2021/3/18/1007
> 
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index e0667c4b3c08..dda0f1e37ec1 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -249,7 +249,7 @@ config AD799X
>  config AD9467
>  	tristate "Analog Devices AD9467 High Speed ADC driver"
>  	depends on SPI
> -	select ADI_AXI_ADC
> +	depends on ADI_AXI_ADC
>  	help
>  	  Say yes here to build support for Analog Devices:
>  	  * AD9467 16-Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
> 


-- 
~Randy


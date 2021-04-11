Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFF635B588
	for <lists+linux-iio@lfdr.de>; Sun, 11 Apr 2021 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhDKOAf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Apr 2021 10:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233514AbhDKOAe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Apr 2021 10:00:34 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55A8B611AD;
        Sun, 11 Apr 2021 14:00:15 +0000 (UTC)
Date:   Sun, 11 Apr 2021 15:00:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  iio: adc: exynos: drop unneeded variable assignment
Message-ID: <20210411150039.1dcc76b8@jic23-huawei>
In-Reply-To: <20210410164728.8096-1-krzysztof.kozlowski@canonical.com>
References: <20210410164728.8096-1-krzysztof.kozlowski@canonical.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 10 Apr 2021 18:47:28 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

> The initialization of 'ret' variable in probe function is shortly after
> overwritten.  This initialization is simply not used.
> 
> Addresses-Coverity: Unused value
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Too late for this cycle, but I've queued it up for the next one.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if we missed anything.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/exynos_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 784c10deeb1a..2d8e36408f0e 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -794,7 +794,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  	struct s3c2410_ts_mach_info *pdata = dev_get_platdata(&pdev->dev);
>  	struct iio_dev *indio_dev = NULL;
>  	bool has_ts = false;
> -	int ret = -ENODEV;
> +	int ret;
>  	int irq;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct exynos_adc));


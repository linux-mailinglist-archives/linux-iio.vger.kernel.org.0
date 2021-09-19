Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3866410CAB
	for <lists+linux-iio@lfdr.de>; Sun, 19 Sep 2021 19:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhISRbO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Sep 2021 13:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:32782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhISRbM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Sep 2021 13:31:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 739766101C;
        Sun, 19 Sep 2021 17:29:44 +0000 (UTC)
Date:   Sun, 19 Sep 2021 18:33:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>, <linux-iio@vger.kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: stm32-dac:  Make use of the helper function
 devm_platform_ioremap_resource()
Message-ID: <20210919183325.7bb5a8d9@jic23-huawei>
In-Reply-To: <20210908105638.1525-1-caihuoqing@baidu.com>
References: <20210908105638.1525-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 8 Sep 2021 18:56:38 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if it can find any problems that we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/stm32-dac-core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
> index 906436780347..9a6a68b11b2a 100644
> --- a/drivers/iio/dac/stm32-dac-core.c
> +++ b/drivers/iio/dac/stm32-dac-core.c
> @@ -90,7 +90,6 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  	const struct stm32_dac_cfg *cfg;
>  	struct stm32_dac_priv *priv;
>  	struct regmap *regmap;
> -	struct resource *res;
>  	void __iomem *mmio;
>  	struct reset_control *rst;
>  	int ret;
> @@ -106,8 +105,7 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  	cfg = (const struct stm32_dac_cfg *)
>  		of_match_device(dev->driver->of_match_table, dev)->data;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mmio = devm_ioremap_resource(dev, res);
> +	mmio = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(mmio))
>  		return PTR_ERR(mmio);
>  


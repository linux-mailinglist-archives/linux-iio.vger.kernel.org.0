Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8AB1417ED
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 15:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgAROWS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 09:22:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgAROWS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 09:22:18 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD87A2469A;
        Sat, 18 Jan 2020 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579357337;
        bh=JrvLwcwKSbaYduAx1j/+g7iO4bO/gKI4RPpGC3Yexg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2F4p9QMA24NQEzvX8OMBVSJIXSbPlzCAGzcy7QK5fdv+s54Bng2xUXf16+eqBBPak
         F4JrGFYDJ/Vsq2R+jFQ2rTEUstN43mvE352lpE1zuRvwXNzyJllpx7bvQL1MrpGvzH
         bfcTjg1H+8ckLLEdj7MCzWokAPBgoAi6Aq+5l65U=
Date:   Sat, 18 Jan 2020 14:22:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <etienne.carriere@st.com>
Subject: Re: [PATCH] iio: adc: stm32-adc: don't print an error on probe
 deferral
Message-ID: <20200118142212.55ea44fd@archlinux>
In-Reply-To: <1578921539-6353-1-git-send-email-fabrice.gasnier@st.com>
References: <1578921539-6353-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jan 2020 14:18:59 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> From: Etienne Carriere <etienne.carriere@st.com>
> 
> Do not print an error trace when deferring probe for some resource.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc-core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 97655d7..2df88d2 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -688,7 +688,8 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	priv->vref = devm_regulator_get(&pdev->dev, "vref");
>  	if (IS_ERR(priv->vref)) {
>  		ret = PTR_ERR(priv->vref);
> -		dev_err(&pdev->dev, "vref get failed, %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "vref get failed, %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -696,7 +697,8 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->aclk)) {
>  		ret = PTR_ERR(priv->aclk);
>  		if (ret != -ENOENT) {
> -			dev_err(&pdev->dev, "Can't get 'adc' clock\n");
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(&pdev->dev, "Can't get 'adc' clock\n");
>  			return ret;
>  		}
>  		priv->aclk = NULL;
> @@ -706,7 +708,8 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->bclk)) {
>  		ret = PTR_ERR(priv->bclk);
>  		if (ret != -ENOENT) {
> -			dev_err(&pdev->dev, "Can't get 'bus' clock\n");
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(&pdev->dev, "Can't get 'bus' clock\n");
>  			return ret;
>  		}
>  		priv->bclk = NULL;


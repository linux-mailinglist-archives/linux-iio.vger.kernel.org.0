Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6490B1A771
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfEKKJk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 06:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfEKKJk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 06:09:40 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3222F208C0;
        Sat, 11 May 2019 10:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557569379;
        bh=lhbK+i4DBoD29MQ6wtvmJNog/VnQ3v6fvRLB/M5EOzU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oei5RmKiBXQGpIfBoODyvkMH3Rlv1lT4YNkPlGO2ptQBZivYPlEuyQx8YjtPUZS6i
         iXIoeC5eRrfnmuwXrd5bR+wBSOAbn6wYyAqk9m24sEiQZ/0gH6ahxe1FsVc3DG5ozQ
         Hi7BGigEBpeLiiMlv9riVkNxOrjujUsBVb+8sUOE=
Date:   Sat, 11 May 2019 11:09:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     linux-iio@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] iio: stmpe-adc: Enable all stmpe-adc interrupts
 just once
Message-ID: <20190511110932.75b2b186@archlinux>
In-Reply-To: <20190507143615.28477-3-dev@pschenker.ch>
References: <20190507143615.28477-1-dev@pschenker.ch>
        <20190507143615.28477-3-dev@pschenker.ch>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  7 May 2019 16:36:13 +0200
Philippe Schenker <dev@pschenker.ch> wrote:

> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> This commit will enable the interrupts of all channels handled by this
> driver only once in the probe function.
> 
> This will improve performance because one byte less has to be written over
> i2c on each read out of the adc. On the fastest ADC mode this will improve
> read out speed by 15%.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
>  drivers/iio/adc/stmpe-adc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> index b3872eb37293..82b43e4522b6 100644
> --- a/drivers/iio/adc/stmpe-adc.c
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -74,9 +74,6 @@ static int stmpe_read_voltage(struct stmpe_adc *info,
>  		return -EINVAL;
>  	}
>  
> -	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_EN,
> -			STMPE_ADC_CH(info->channel));
> -
>  	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_CAPT,
>  			STMPE_ADC_CH(info->channel));
>  
> @@ -336,6 +333,9 @@ static int stmpe_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_EN,
> +			~(norequest_mask & 0xFF));
> +
>  	return devm_iio_device_register(&pdev->dev, indio_dev);
>  }
>  


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1041A78B
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 12:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfEKKYh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 06:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbfEKKYg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 06:24:36 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE1E62173B;
        Sat, 11 May 2019 10:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557570276;
        bh=Ol9ib5bihEYIjrd1c8mt+AxCWFeb4Ti7BaHuwJkxvQA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v4U603/bLabnldrLM6MOiPNDVz7DK0r/MC9QoaiSqqorwz+ySd4TjrJKypZ3+bF9s
         Oi7pE83vuWve+W8K6qopE3LO/K10MtfkVM1TJXht3uXte67oWPnpF2vxXDyky7JEUN
         So9eLCXfDPm7MdKyCanuDsLdFHH6/rXp2DvYpyD8=
Date:   Sat, 11 May 2019 11:24:29 +0100
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
Subject: Re: [PATCH 5/5] iio: stmpe-adc: Reset possible interrupts
Message-ID: <20190511112429.25ddd84d@archlinux>
In-Reply-To: <20190507143615.28477-5-dev@pschenker.ch>
References: <20190507143615.28477-1-dev@pschenker.ch>
        <20190507143615.28477-5-dev@pschenker.ch>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  7 May 2019 16:36:15 +0200
Philippe Schenker <dev@pschenker.ch> wrote:

> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Clear any interrupt that still is on the device on every channel
> this driver is activated for in probe and specific channels in
> the timeout handler.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
I'm never particularly clean on blanket resets as they do tend to
hide bugs. However, the probe one is something that would happen anyway
if there was a 'reset' function.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> ---
> 
>  drivers/iio/adc/stmpe-adc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> index cc752a47444c..a5990e9f2c80 100644
> --- a/drivers/iio/adc/stmpe-adc.c
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -80,6 +80,8 @@ static int stmpe_read_voltage(struct stmpe_adc *info,
>  	ret = wait_for_completion_timeout(&info->completion, STMPE_ADC_TIMEOUT);
>  
>  	if (ret <= 0) {
> +		stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_STA,
> +				STMPE_ADC_CH(info->channel));
>  		mutex_unlock(&info->lock);
>  		return -ETIMEDOUT;
>  	}
> @@ -326,6 +328,9 @@ static int stmpe_adc_probe(struct platform_device *pdev)
>  	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_EN,
>  			~(norequest_mask & 0xFF));
>  
> +	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_STA,
> +			~(norequest_mask & 0xFF));
> +
>  	return devm_iio_device_register(&pdev->dev, indio_dev);
>  }
>  


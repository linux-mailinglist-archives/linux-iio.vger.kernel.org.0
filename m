Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310913FB36A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 11:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhH3JuA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 05:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236269AbhH3Jt7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 05:49:59 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7F406103D;
        Mon, 30 Aug 2021 09:49:01 +0000 (UTC)
Date:   Mon, 30 Aug 2021 10:52:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [RESEND v4 12/15] iio: adc: aspeed: Add func to set sampling
 rate.
Message-ID: <20210830105213.25ee20a2@jic23-huawei>
In-Reply-To: <FE947284-E67B-49DB-B538-3ECAD8317BD4@aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
        <202108250003.17P03KRU092474@twspam01.aspeedtech.com>
        <20210829163659.2f7f5974@jic23-huawei>
        <FE947284-E67B-49DB-B538-3ECAD8317BD4@aspeedtech.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Aug 2021 08:35:53 +0000
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Hi Jonathan,
> 
> On 2021/8/29, 11:33 PM, "Jonathan Cameron" <jic23@kernel.org> wrote:
> 
>     On Tue, 24 Aug 2021 17:12:40 +0800
>     Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> 
>     >> Add the function to set the sampling rate and keep the sampling period
>     >> for a driver used to wait the lastest value.
>     >> 
>     >> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>  
> 
>     > Why move the code as well as factoring out the setter function?
>     > I doubt it does any harm, but I'd like to understand why you did it.  
> 
>     > Jonathan  
> 
>     >> +	ret = clk_prepare_enable(data->clk_scaler->clk);
>     >> +	if (ret)
>     >> +		return ret;
>     >> +
>     >> +	ret = devm_add_action_or_reset(data->dev,
>     >> +				       aspeed_adc_clk_disable_unprepare,
>     >> +				       data->clk_scaler->clk);
>     >> +	if (ret)
>     >> +		return ret;
>     >> +
>     >> +	ret = aspeed_adc_set_sampling_rate(indio_dev, ASPEED_ADC_DEF_SAMPLING_RATE);
>     >> +	if (ret)
>     >> +		return ret;
>     >> +
>     >>  	ret = aspeed_adc_vref_config(indio_dev);
>     >>  	if (ret)
>     >>  		return ret;
>     >> @@ -413,16 +445,6 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>     >>  	}
>     >>  
>     >>  	/* Start all channels in normal mode. */  
> 
>     > Why move this code up?  
> 
> Because the ADC clock is required when initializing the ADC device.
> In our system, the clock is always on. Thus, the legacy driver won't encounter any issues.
> I move the clk_prepare_enable ahead of initializing phase for making the driver probe logically closer to the hardware. 

Thanks. Please add something to the patch description to say this.

Jonathan

> 
>     >> -	ret = clk_prepare_enable(data->clk_scaler->clk);
>     >> -	if (ret)
>     >> -		return ret;
>     >> -
>     >> -	ret = devm_add_action_or_reset(data->dev,
>     >> -				       aspeed_adc_clk_disable_unprepare,
>     >> -				       data->clk_scaler->clk);
>     >> -	if (ret)
>     >> -		return ret;
>     >> -
>     >>  	adc_engine_control_reg_val =
>     >>  		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
>     >>  	adc_engine_control_reg_val |=  
> 
> 
> Best Regards,
> Billy Tsai
> 


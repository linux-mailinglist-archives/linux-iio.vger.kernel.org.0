Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF3039FC6
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 15:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfFHNBd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 09:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfFHNBc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 09:01:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40CF320693;
        Sat,  8 Jun 2019 13:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559998892;
        bh=lEIcalaH40D/Gfqlg8EJH6JZshvXrRFZWeDDh7rbnSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mxn+KXZ7+s7avp3I2qKqTkhwMjDfGuGUQClhhHWHXZJU1soR+JGLBvBdyPZ2miAzV
         Gkp3c8lnRzFzlGWyBUxk3oR5JUF2f4rEeIbDP47B7oPMmuO2eIXR4aqSPyYN2yMWs+
         XrVxHKc+1GYdJml6LLjs1W3SkehEQgXBMV+yLu78=
Date:   Sat, 8 Jun 2019 14:01:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     andrew.smirnov@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: imx7d_adc: Remove unneeded 'average_en' member
Message-ID: <20190608140128.31e11cc8@archlinux>
In-Reply-To: <20190603193433.6394-4-festevam@gmail.com>
References: <20190603193433.6394-1-festevam@gmail.com>
        <20190603193433.6394-4-festevam@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Jun 2019 16:34:33 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> average_en is always true, so there is not really need for
> this structure member.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/imx7d_adc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index 46e88899ad74..26a7bbe4d534 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -101,8 +101,6 @@ struct imx7d_adc_feature {
>  	enum imx7d_adc_average_num avg_num;
>  
>  	u32 core_time_unit;	/* impact the sample rate */
> -
> -	bool average_en;
>  };
>  
>  struct imx7d_adc {
> @@ -180,7 +178,6 @@ static void imx7d_adc_feature_config(struct imx7d_adc *info)
>  	info->adc_feature.clk_pre_div = IMX7D_ADC_ANALOG_CLK_PRE_DIV_4;
>  	info->adc_feature.avg_num = IMX7D_ADC_AVERAGE_NUM_32;
>  	info->adc_feature.core_time_unit = 1;
> -	info->adc_feature.average_en = true;
>  }
>  
>  static void imx7d_adc_sample_rate_set(struct imx7d_adc *info)
> @@ -241,9 +238,8 @@ static void imx7d_adc_channel_set(struct imx7d_adc *info)
>  
>  	/* the channel choose single conversion, and enable average mode */
>  	cfg1 |= (IMX7D_REG_ADC_CH_CFG1_CHANNEL_EN |
> -		 IMX7D_REG_ADC_CH_CFG1_CHANNEL_SINGLE);
> -	if (info->adc_feature.average_en)
> -		cfg1 |= IMX7D_REG_ADC_CH_CFG1_CHANNEL_AVG_EN;
> +		 IMX7D_REG_ADC_CH_CFG1_CHANNEL_SINGLE |
> +		 IMX7D_REG_ADC_CH_CFG1_CHANNEL_AVG_EN);
>  
>  	/*
>  	 * physical channel 0 chose logical channel A


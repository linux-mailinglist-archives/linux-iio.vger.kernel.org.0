Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698C339FC4
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfFHM77 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 08:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfFHM77 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 08:59:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E42320693;
        Sat,  8 Jun 2019 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559998798;
        bh=PkQk5FIQJV3vu/JUOqen1dJP636GHH8iU1GtMIttjxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EHrnoYZcPLcpxO+BxD84iIgP/dEvVDfVEwsYwtwAE7jNE0RPCp8bSVKlVYZAGFGx6
         3JAqGzbvs7ylKTGvWkRe2IRNhTWAK4738pjlwGBb1f/v1ig5YPapy158E9DIKOQKR0
         4Lc58PxpkZ7J0VC7Q36kRaFPFbLwWtzbKwBwokcU=
Date:   Sat, 8 Jun 2019 13:59:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     andrew.smirnov@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: imx7d_adc: Introduce a definition for the
 input clock
Message-ID: <20190608135955.40b70718@archlinux>
In-Reply-To: <20190603193433.6394-2-festevam@gmail.com>
References: <20190603193433.6394-1-festevam@gmail.com>
        <20190603193433.6394-2-festevam@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Jun 2019 16:34:31 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Since the input clock is always 24MHz, there is no need for storing
> this value into a variable.
> 
> Use a definition instead, which is more appropriate in this case.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

thanks,

Jonathan

> ---
>  drivers/iio/adc/imx7d_adc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index 23c7b0ee945f..bffc172e7635 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -78,6 +78,7 @@
>  #define IMX7D_REG_ADC_INT_STATUS_CHANNEL_CONV_TIME_OUT		0xf0000
>  
>  #define IMX7D_ADC_TIMEOUT		msecs_to_jiffies(100)
> +#define IMX7D_ADC_INPUT_CLK		24000000
>  
>  enum imx7d_adc_clk_pre_div {
>  	IMX7D_ADC_ANALOG_CLK_PRE_DIV_4,
> @@ -272,13 +273,11 @@ static void imx7d_adc_channel_set(struct imx7d_adc *info)
>  
>  static u32 imx7d_adc_get_sample_rate(struct imx7d_adc *info)
>  {
> -	/* input clock is always 24MHz */
> -	u32 input_clk = 24000000;
>  	u32 analogue_core_clk;
>  	u32 core_time_unit = info->adc_feature.core_time_unit;
>  	u32 tmp;
>  
> -	analogue_core_clk = input_clk / info->pre_div_num;
> +	analogue_core_clk = IMX7D_ADC_INPUT_CLK / info->pre_div_num;
>  	tmp = (core_time_unit + 1) * 6;
>  
>  	return analogue_core_clk / tmp;


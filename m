Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F8F20C131
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 14:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgF0MEM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 08:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgF0MEL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 08:04:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D94732145D;
        Sat, 27 Jun 2020 12:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593259450;
        bh=pbXWf2axhgwYgYswNc0d/Ahxvv0J/0oR8gflxM/Q7Kw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ikVKT0XmmwKlq9NPPgam/knWLKMpmxpuAjNlHg31G2iC3RkI9jxO3NKC0flg89krT
         I2wYAQPiLAcyQ8c71gSqLrGzvnaqfuj9Qairvw4oT4lRek811xMROOBNK1s7uCl+5m
         j+hRPBiklKO0dblPvKsJaWaHgbPcZsadrrOiNdiA=
Date:   Sat, 27 Jun 2020 13:04:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, xxm@rock-chips.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v6 2/3] iio: adc: rockchip_saradc: better prefix for
 channel constant
Message-ID: <20200627130406.1c9dd371@archlinux>
In-Reply-To: <20200623233011.2319035-2-heiko@sntech.de>
References: <20200623233011.2319035-1-heiko@sntech.de>
        <20200623233011.2319035-2-heiko@sntech.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Jun 2020 01:30:10 +0200
Heiko Stuebner <heiko@sntech.de> wrote:

> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> As suggested give the current ADC_CHANNEL constant a distinct
> and consistent prefix.
> 
> Suggested-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
> changes in v6:
> - none
> changes in v5:
> - new patch
> 
>  drivers/iio/adc/rockchip_saradc.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 1a7990d60f9f..5d2e07dc72fd 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -118,7 +118,7 @@ static const struct iio_info rockchip_saradc_iio_info = {
>  	.read_raw = rockchip_saradc_read_raw,
>  };
>  
> -#define ADC_CHANNEL(_index, _id) {				\
> +#define SARADC_CHANNEL(_index, _id) {				\
>  	.type = IIO_VOLTAGE,					\
>  	.indexed = 1,						\
>  	.channel = _index,					\
> @@ -128,9 +128,9 @@ static const struct iio_info rockchip_saradc_iio_info = {
>  }
>  
>  static const struct iio_chan_spec rockchip_saradc_iio_channels[] = {
> -	ADC_CHANNEL(0, "adc0"),
> -	ADC_CHANNEL(1, "adc1"),
> -	ADC_CHANNEL(2, "adc2"),
> +	SARADC_CHANNEL(0, "adc0"),
> +	SARADC_CHANNEL(1, "adc1"),
> +	SARADC_CHANNEL(2, "adc2"),
>  };
>  
>  static const struct rockchip_saradc_data saradc_data = {
> @@ -141,8 +141,8 @@ static const struct rockchip_saradc_data saradc_data = {
>  };
>  
>  static const struct iio_chan_spec rockchip_rk3066_tsadc_iio_channels[] = {
> -	ADC_CHANNEL(0, "adc0"),
> -	ADC_CHANNEL(1, "adc1"),
> +	SARADC_CHANNEL(0, "adc0"),
> +	SARADC_CHANNEL(1, "adc1"),
>  };
>  
>  static const struct rockchip_saradc_data rk3066_tsadc_data = {
> @@ -153,12 +153,12 @@ static const struct rockchip_saradc_data rk3066_tsadc_data = {
>  };
>  
>  static const struct iio_chan_spec rockchip_rk3399_saradc_iio_channels[] = {
> -	ADC_CHANNEL(0, "adc0"),
> -	ADC_CHANNEL(1, "adc1"),
> -	ADC_CHANNEL(2, "adc2"),
> -	ADC_CHANNEL(3, "adc3"),
> -	ADC_CHANNEL(4, "adc4"),
> -	ADC_CHANNEL(5, "adc5"),
> +	SARADC_CHANNEL(0, "adc0"),
> +	SARADC_CHANNEL(1, "adc1"),
> +	SARADC_CHANNEL(2, "adc2"),
> +	SARADC_CHANNEL(3, "adc3"),
> +	SARADC_CHANNEL(4, "adc4"),
> +	SARADC_CHANNEL(5, "adc5"),
>  };
>  
>  static const struct rockchip_saradc_data rk3399_saradc_data = {


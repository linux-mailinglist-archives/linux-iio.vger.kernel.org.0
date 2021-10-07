Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFA142590C
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 19:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbhJGRQS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 13:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242964AbhJGRQR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 13:16:17 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE32E61108;
        Thu,  7 Oct 2021 17:14:20 +0000 (UTC)
Date:   Thu, 7 Oct 2021 18:18:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2 1/8] iio: dac: ad8801: Make use of the helper
 function dev_err_probe()
Message-ID: <20211007181741.65f56d13@jic23-huawei>
In-Reply-To: <20210928013902.1341-1-caihuoqing@baidu.com>
References: <20210928013902.1341-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Sep 2021 09:38:54 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Hi Cai,

I made a modification to this patch whilst applying as described below.
Please take care to not mix different types of change like you did here
in one patch.

With that change applied to the togreg branch of iio.git and pushed out as testing
for 0-day to work it's magic and see if we missed anything,

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad8801.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad8801.c b/drivers/iio/dac/ad8801.c
> index 6354b7c8f052..8acb9fee273c 100644
> --- a/drivers/iio/dac/ad8801.c
> +++ b/drivers/iio/dac/ad8801.c
> @@ -123,10 +123,9 @@ static int ad8801_probe(struct spi_device *spi)
>  	id = spi_get_device_id(spi);
>  
>  	state->vrefh_reg = devm_regulator_get(&spi->dev, "vrefh");
> -	if (IS_ERR(state->vrefh_reg)) {
> -		dev_err(&spi->dev, "Vrefh regulator not specified\n");
> -		return PTR_ERR(state->vrefh_reg);
> -	}
> +	if (IS_ERR(state->vrefh_reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(state->vrefh_reg),
> +				     "Vrefh regulator not specified\n");
>  
>  	ret = regulator_enable(state->vrefh_reg);
>  	if (ret) {
> @@ -146,15 +145,15 @@ static int ad8801_probe(struct spi_device *spi)
>  	if (id->driver_data == ID_AD8803) {
>  		state->vrefl_reg = devm_regulator_get(&spi->dev, "vrefl");
>  		if (IS_ERR(state->vrefl_reg)) {
> -			dev_err(&spi->dev, "Vrefl regulator not specified\n");
> -			ret = PTR_ERR(state->vrefl_reg);
> +			ret = dev_err_probe(&spi->dev, PTR_ERR(state->vrefl_reg),
> +					    "Vrefl regulator not specified\n");
>  			goto error_disable_vrefh_reg;
>  		}
>  
>  		ret = regulator_enable(state->vrefl_reg);
>  		if (ret) {
> -			dev_err(&spi->dev, "Failed to enable vrefl regulator: %d\n",
> -					ret);
> +			dev_err(&spi->dev,
> +				"Failed to enable vrefl regulator: %d\n", ret);
This last change is unconnected to the rest of the patch. I've dropped it whilst
applying.

>  			goto error_disable_vrefh_reg;
>  		}
>  


Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE84425937
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 19:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbhJGRVN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 13:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241682AbhJGRVH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 13:21:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 645CA61108;
        Thu,  7 Oct 2021 17:19:10 +0000 (UTC)
Date:   Thu, 7 Oct 2021 18:23:14 +0100
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
Subject: Re: [PATCH v2 8/8] iio: dac: ti-dac7311: Make use of the helper
 function dev_err_probe()
Message-ID: <20211007182314.6c53158e@jic23-huawei>
In-Reply-To: <20210928013902.1341-8-caihuoqing@baidu.com>
References: <20210928013902.1341-1-caihuoqing@baidu.com>
        <20210928013902.1341-8-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Sep 2021 09:39:01 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Series applied to the togreg branch of iio.git and pushed out as testing for
0-day to see if it can find any problems before I push this out in a place
where it can make a mess of linux-next

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ti-dac7311.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/ti-dac7311.c b/drivers/iio/dac/ti-dac7311.c
> index 9d0b253be841..09218c3029f0 100644
> --- a/drivers/iio/dac/ti-dac7311.c
> +++ b/drivers/iio/dac/ti-dac7311.c
> @@ -266,10 +266,9 @@ static int ti_dac_probe(struct spi_device *spi)
>  	ti_dac->resolution = spec->resolution;
>  
>  	ti_dac->vref = devm_regulator_get(dev, "vref");
> -	if (IS_ERR(ti_dac->vref)) {
> -		dev_err(dev, "error to get regulator\n");
> -		return PTR_ERR(ti_dac->vref);
> -	}
> +	if (IS_ERR(ti_dac->vref))
> +		return dev_err_probe(dev, PTR_ERR(ti_dac->vref),
> +				     "error to get regulator\n");
>  
>  	ret = regulator_enable(ti_dac->vref);
>  	if (ret < 0) {


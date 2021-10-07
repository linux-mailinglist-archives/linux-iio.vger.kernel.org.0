Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18064425955
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhJGR0E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 13:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233431AbhJGR0C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 13:26:02 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10CD36113E;
        Thu,  7 Oct 2021 17:24:06 +0000 (UTC)
Date:   Thu, 7 Oct 2021 18:28:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH v2 1/2] iio: st_sensors: Make use of the helper function
 dev_err_probe()
Message-ID: <20211007182810.245d5502@jic23-huawei>
In-Reply-To: <20210928014055.1431-1-caihuoqing@baidu.com>
References: <20210928014055.1431-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Sep 2021 09:40:53 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
+CC Denis though this looks simple enough I'll take it now.

Applied to the togreg branch of iio.git and pushed out as testing for all the
normal reasons.

Thanks,

Jonathan

> ---
> v1->v2: Remove the separate line of PTR_ERR().
> 
>  .../iio/common/st_sensors/st_sensors_core.c    | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index a5a140de9a23..732d0f8f99f6 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -228,10 +228,10 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
>  
>  	/* Regulators not mandatory, but if requested we should enable them. */
>  	pdata->vdd = devm_regulator_get(parent, "vdd");
> -	if (IS_ERR(pdata->vdd)) {
> -		dev_err(&indio_dev->dev, "unable to get Vdd supply\n");
> -		return PTR_ERR(pdata->vdd);
> -	}
> +	if (IS_ERR(pdata->vdd))
> +		return dev_err_probe(&indio_dev->dev, PTR_ERR(pdata->vdd),
> +				     "unable to get Vdd supply\n");
> +
>  	err = regulator_enable(pdata->vdd);
>  	if (err != 0) {
>  		dev_warn(&indio_dev->dev,
> @@ -243,10 +245,10 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
>  		return err;
>  
>  	pdata->vdd_io = devm_regulator_get(parent, "vddio");
> -	if (IS_ERR(pdata->vdd_io)) {
> -		dev_err(&indio_dev->dev, "unable to get Vdd_IO supply\n");
> -		return PTR_ERR(pdata->vdd_io);
> -	}
> +	if (IS_ERR(pdata->vdd_io))
> +		return dev_err_probe(&indio_dev->dev, PTR_ERR(pdata->vdd_io),
> +				     "unable to get Vdd_IO supply\n");
> +
>  	err = regulator_enable(pdata->vdd_io);
>  	if (err != 0) {
>  		dev_warn(&indio_dev->dev,


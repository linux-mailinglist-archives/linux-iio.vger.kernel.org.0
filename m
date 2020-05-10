Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2F41CCA30
	for <lists+linux-iio@lfdr.de>; Sun, 10 May 2020 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgEJKYX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 May 2020 06:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgEJKYW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 May 2020 06:24:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE3AC207DD;
        Sun, 10 May 2020 10:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589106262;
        bh=nyOHSQ2FNu3ylsodACsA1C8WkrdfFaSaWV5/EwOdWdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u2svKgegrkGdy/DBfzCb4ftBgLueIc34lm0CABqR+jdB5hlYIySgw+kFP7S0Oi8OV
         kQTG2r+jsWUV6OSmbNtdrq2ZsjNwUSmKizar78OCPGGbcZYGnK5/EmXhRyYGSNMijW
         zBBsLo7rzXkkNA42IKXVSUxqSweYh4rl9sKxW/qI=
Date:   Sun, 10 May 2020 11:24:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        kgene@kernel.org, krzk@kernel.org, cw00.choi@samsung.com,
        kstewart@linuxfoundation.org, mpe@ellerman.id.au,
        m.szyprowski@samsung.com, swboyd@chromium.org, tglx@linutronix.de,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Add scaling support to exynos adc driver
Message-ID: <20200510112417.1e54d66e@archlinux>
In-Reply-To: <BN6PR04MB066058A68D6471E7F6AFCFF7A3A20@BN6PR04MB0660.namprd04.prod.outlook.com>
References: <BN6PR04MB066058A68D6471E7F6AFCFF7A3A20@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  8 May 2020 14:14:00 -0700
Jonathan Bakker <xc-racer2@live.ca> wrote:

> Currently the driver only exposes the raw counts.  As we
> have the regulator voltage and the maximum value (stored in
> the data mask), we can trivially produce a scaling fraction
> of voltage / max value.
> 
> This assumes that the regulator voltage is in fact the max
> voltage, which appears to be the case for all mainline dts
> and cross referenced with the public Exynos4412 and S5PV210
> datasheets.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

Seems reasonable to me. I'd like an exynos Ack though before applying.

thanks,

Jonathan


> ---
>  drivers/iio/adc/exynos_adc.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 22131a677445..9d29b56805cd 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -531,8 +531,19 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
>  	unsigned long timeout;
>  	int ret;
>  
> -	if (mask != IIO_CHAN_INFO_RAW)
> +	if (mask == IIO_CHAN_INFO_SCALE) {
> +		ret = regulator_get_voltage(info->vdd);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Regulator voltage is in uV, but need mV */
> +		*val = ret / 1000;
> +		*val2 = info->data->mask;
> +
> +		return IIO_VAL_FRACTIONAL;
> +	} else if (mask != IIO_CHAN_INFO_RAW) {
>  		return -EINVAL;
> +	}
>  
>  	mutex_lock(&indio_dev->mlock);
>  	reinit_completion(&info->completion);
> @@ -683,6 +694,7 @@ static const struct iio_info exynos_adc_iio_info = {
>  	.channel = _index,				\
>  	.address = _index,				\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
>  	.datasheet_name = _id,				\
>  }
>  


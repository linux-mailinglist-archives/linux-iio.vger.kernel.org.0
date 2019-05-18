Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4B522247
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 10:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfERIl2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 04:41:28 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:44972 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfERIl2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 04:41:28 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 2C7E39E8317;
        Sat, 18 May 2019 09:41:25 +0100 (BST)
Date:   Sat, 18 May 2019 09:41:24 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH][RESEND] iio: ad9523-1: Improve reported VCO frequency
 accuracy
Message-ID: <20190518094124.517568ca@archlinux>
In-Reply-To: <20190517133711.21266-1-alexandru.ardelean@analog.com>
References: <20190326132658.16724-1-alexandru.ardelean@analog.com>
        <20190517133711.21266-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 May 2019 16:37:11 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> To improve the accuracy of the reported VCO frequency perform all
> multiplications before divisions. This reduces rounding errors and makes
> sure the reported rates are accurate down to the last digit.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Not sure how I missed this one the first time around!  Thanks for the
resend and applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/frequency/ad9523.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index 246e38d76eff..541cb5975dd9 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -1140,9 +1140,11 @@ static int ad9523_setup(struct iio_dev *indio_dev)
>  	if (ret < 0)
>  		return ret;
>  
> -	st->vco_freq = (pdata->vcxo_freq * (pdata->pll2_freq_doubler_en ? 2 : 1)
> -			/ pdata->pll2_r2_div) * AD9523_PLL2_FB_NDIV(pdata->
> -			pll2_ndiv_a_cnt, pdata->pll2_ndiv_b_cnt);
> +	st->vco_freq = div_u64((unsigned long long)pdata->vcxo_freq *
> +			       (pdata->pll2_freq_doubler_en ? 2 : 1) *
> +			       AD9523_PLL2_FB_NDIV(pdata->pll2_ndiv_a_cnt,
> +						   pdata->pll2_ndiv_b_cnt),
> +			       pdata->pll2_r2_div);
>  
>  	ret = ad9523_write(indio_dev, AD9523_PLL2_VCO_CTRL,
>  		AD9523_PLL2_VCO_CALIBRATE);


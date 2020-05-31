Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394A91E9707
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 12:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgEaKsG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 06:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgEaKsG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 06:48:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A306C2074A;
        Sun, 31 May 2020 10:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590922085;
        bh=VKuSydnCA8GbAnW/vXcAF5F4KY9bvvxAF6aLZVGJkXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kJYMVbx0SmXng/5nf6YHI7Q0zQOJ2gjlrxWGdSXENmp5n9U2t13PTRGYEDIi4wSoZ
         /O2mflibc5V3x1oJsfCHOuRkVywRwozEEiJrbMF1MR76m2beUvUFL8yCuG1XnK8iii
         GOHWT+FVHhgGXIYH6k2fPuNhaoFyczSYkEV3usuA=
Date:   Sun, 31 May 2020 11:48:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, andy.shevchenko@gmail.com,
        amit.kucheria@verdurent.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V6 3/7] iio: adc: Add info property under adc_data
Message-ID: <20200531114800.6527be21@archlinux>
In-Reply-To: <1590684869-15400-4-git-send-email-jprakash@codeaurora.org>
References: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
        <1590684869-15400-4-git-send-email-jprakash@codeaurora.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 May 2020 22:24:25 +0530
Jishnu Prakash <jprakash@codeaurora.org> wrote:

> Add info property under adc_data to support adding ADC variants
> which may use different iio_info than the one defined for PMIC5.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>

Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c   | 4 +++-
>  drivers/iio/adc/qcom-vadc-common.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 21fdcde..0fa1d37 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -629,6 +629,7 @@ static const struct adc5_data adc5_data_pmic = {
>  	.full_scale_code_volt = 0x70e4,
>  	.full_scale_code_cur = 0x2710,
>  	.adc_chans = adc5_chans_pmic,
> +	.info = &adc5_info,
>  	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
>  				{250, 420, 840},
>  	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> @@ -643,6 +644,7 @@ static const struct adc5_data adc5_data_pmic_rev2 = {
>  	.full_scale_code_volt = 0x4000,
>  	.full_scale_code_cur = 0x1800,
>  	.adc_chans = adc5_chans_rev2,
> +	.info = &adc5_info,
>  	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
>  				{256, 512, 1024},
>  	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> @@ -777,7 +779,7 @@ static int adc5_probe(struct platform_device *pdev)
>  	indio_dev->dev.of_node = node;
>  	indio_dev->name = pdev->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->info = &adc5_info;
> +	indio_dev->info = adc->data->info;
>  	indio_dev->channels = adc->iio_chans;
>  	indio_dev->num_channels = adc->nchannels;
>  
> diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
> index e074902a..6a7553f 100644
> --- a/drivers/iio/adc/qcom-vadc-common.h
> +++ b/drivers/iio/adc/qcom-vadc-common.h
> @@ -136,6 +136,7 @@ struct adc5_data {
>  	const u32	full_scale_code_volt;
>  	const u32	full_scale_code_cur;
>  	const struct adc5_channels *adc_chans;
> +	const struct iio_info *info;
>  	unsigned int	*decimation;
>  	unsigned int	*hw_settle_1;
>  	unsigned int	*hw_settle_2;


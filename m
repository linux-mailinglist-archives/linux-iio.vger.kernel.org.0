Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5160720C164
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 15:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgF0NLZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 09:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgF0NLY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 09:11:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEF33207E8;
        Sat, 27 Jun 2020 13:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593263483;
        bh=TcBMrqRjXWcw8ga4N0865jJrdI0oTOwN6bqoO7ZV6/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n31t26JPZtZBQNfnzcI3/CfV9K1FLVi2uruQunOCF99BrU5NXTM5o3hz75vkuTAuT
         TT8qTVUhKj82n1CxK6HN53AaW9bFp4P2SsGZuJjKKkwjoC/+xgo/X7OInnKGMBQag9
         ROj/I/rZ4tKoUkQdCXsH45gHz0afoL2Z0GAcR45Y=
Date:   Sat, 27 Jun 2020 14:11:17 +0100
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
Subject: Re: [PATCH V7 7/7] iio: adc: Combine read functions for PMIC5 and
 PMIC7
Message-ID: <20200627141117.4f4593d3@archlinux>
In-Reply-To: <1592897399-24089-8-git-send-email-jprakash@codeaurora.org>
References: <1592897399-24089-1-git-send-email-jprakash@codeaurora.org>
        <1592897399-24089-8-git-send-email-jprakash@codeaurora.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Jun 2020 12:59:59 +0530
Jishnu Prakash <jprakash@codeaurora.org> wrote:

> Add a common function used for read_raw callback for both PMIC5
> and PMIC7 ADCs.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>

Looks good. Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 49 ++++++++++++++++------------------------
>  1 file changed, 19 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 0f9af66..88efadb 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -449,6 +449,11 @@ static int adc7_do_conversion(struct adc5_chip *adc,
>  	return ret;
>  }
>  
> +typedef int (*adc_do_conversion)(struct adc5_chip *adc,
> +			struct adc5_channel_prop *prop,
> +			struct iio_chan_spec const *chan,
> +			u16 *data_volt, u16 *data_cur);
> +
>  static irqreturn_t adc5_isr(int irq, void *dev_id)
>  {
>  	struct adc5_chip *adc = dev_id;
> @@ -487,9 +492,9 @@ static int adc7_of_xlate(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> -static int adc5_read_raw(struct iio_dev *indio_dev,
> +static int adc_read_raw_common(struct iio_dev *indio_dev,
>  			 struct iio_chan_spec const *chan, int *val, int *val2,
> -			 long mask)
> +			 long mask, adc_do_conversion do_conv)
>  {
>  	struct adc5_chip *adc = iio_priv(indio_dev);
>  	struct adc5_channel_prop *prop;
> @@ -500,8 +505,8 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> -		ret = adc5_do_conversion(adc, prop, chan,
> -				&adc_code_volt, &adc_code_cur);
> +		ret = do_conv(adc, prop, chan,
> +					&adc_code_volt, &adc_code_cur);
>  		if (ret)
>  			return ret;
>  
> @@ -518,36 +523,20 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static int adc7_read_raw(struct iio_dev *indio_dev,
> +static int adc5_read_raw(struct iio_dev *indio_dev,
>  			 struct iio_chan_spec const *chan, int *val, int *val2,
>  			 long mask)
>  {
> -	struct adc5_chip *adc = iio_priv(indio_dev);
> -	struct adc5_channel_prop *prop;
> -	u16 adc_code_volt, adc_code_cur;
> -	int ret;
> -
> -	prop = &adc->chan_props[chan->address];
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_PROCESSED:
> -		ret = adc7_do_conversion(adc, prop, chan,
> -					&adc_code_volt, &adc_code_cur);
> -		if (ret)
> -			return ret;
> -
> -		ret = qcom_adc5_hw_scale(prop->scale_fn_type,
> -			&adc5_prescale_ratios[prop->prescale],
> -			adc->data,
> -			adc_code_volt, val);
> -
> -		if (ret)
> -			return ret;
> +	return adc_read_raw_common(indio_dev, chan, val, val2,
> +				mask, adc5_do_conversion);
> +}
>  
> -		return IIO_VAL_INT;
> -	default:
> -		return -EINVAL;
> -	}
> +static int adc7_read_raw(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan, int *val, int *val2,
> +			 long mask)
> +{
> +	return adc_read_raw_common(indio_dev, chan, val, val2,
> +				mask, adc7_do_conversion);
>  }
>  
>  static const struct iio_info adc5_info = {


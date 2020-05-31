Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4A81E9715
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 12:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgEaKwc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 06:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgEaKwa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 06:52:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D43E92077D;
        Sun, 31 May 2020 10:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590922349;
        bh=GtfQqpLz+UA0E0hOaFJGXiH9ZOAFoetaFP4PLzghpaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=whX4xGE+O46Lk8RKfVNzPjfTl9BNo/bX8dVULJ6+OzOxkdriGZqxGL247/cu2ZrAt
         v81BLHTvbgPOCd3HJ0rtTFLsFRacW0+HaMfSAPUz+N+IKqc/6odhvQwzIAWVypzEZv
         KBJqiycdHHQcIsXRzmpM/2ha1YKsO1RTXu5OWfLc=
Date:   Sun, 31 May 2020 11:52:24 +0100
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
Subject: Re: [PATCH V6 7/7] iio: adc: Add a common read function for PMIC5
 and PMIC7
Message-ID: <20200531115224.700b11d3@archlinux>
In-Reply-To: <1590684869-15400-8-git-send-email-jprakash@codeaurora.org>
References: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
        <1590684869-15400-8-git-send-email-jprakash@codeaurora.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 May 2020 22:24:29 +0530
Jishnu Prakash <jprakash@codeaurora.org> wrote:

> Add a common function used for read_raw callback for both PMIC5
> and PMIC7 ADCs.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>

Hmm. I'm not completely sold on this one.   Suggestions below.

Jonathan


> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 53 +++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 0f9af66..fe49741 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -449,6 +449,13 @@ static int adc7_do_conversion(struct adc5_chip *adc,
>  	return ret;
>  }
>  
> +struct adc_do_conversion {
> +	int (*adc_do_conversion)(struct adc5_chip *adc,
> +			struct adc5_channel_prop *prop,
> +			struct iio_chan_spec const *chan,
> +			u16 *data_volt, u16 *data_cur);

Why use a structure for this? It's just a function pointer.
If they form is too long you can always use a typedef.

This is fine if you have other stuff coming shortly that will add
to this structure but for now it's just a bit confusing.

Directly passing the function pointer will reduce the amount
of coded added here and make the argument in favour of refactoring
rather stronger.


> +};
> +
>  static irqreturn_t adc5_isr(int irq, void *dev_id)
>  {
>  	struct adc5_chip *adc = dev_id;
> @@ -487,9 +494,9 @@ static int adc7_of_xlate(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> -static int adc5_read_raw(struct iio_dev *indio_dev,
> +static int adc_read_raw_common(struct iio_dev *indio_dev,
>  			 struct iio_chan_spec const *chan, int *val, int *val2,
> -			 long mask)
> +			 long mask, struct adc_do_conversion do_conv)
>  {
>  	struct adc5_chip *adc = iio_priv(indio_dev);
>  	struct adc5_channel_prop *prop;
> @@ -500,8 +507,8 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> -		ret = adc5_do_conversion(adc, prop, chan,
> -				&adc_code_volt, &adc_code_cur);
> +		ret = do_conv.adc_do_conversion(adc, prop, chan,
> +					&adc_code_volt, &adc_code_cur);
>  		if (ret)
>  			return ret;
>  
> @@ -518,36 +525,26 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
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
> +	struct adc_do_conversion do_conv;
>  
> -		ret = qcom_adc5_hw_scale(prop->scale_fn_type,
> -			&adc5_prescale_ratios[prop->prescale],
> -			adc->data,
> -			adc_code_volt, val);
> +	do_conv.adc_do_conversion = adc5_do_conversion;
> +	return adc_read_raw_common(indio_dev, chan, val, val2,
> +				mask, do_conv);
> +}
>  
> -		if (ret)
> -			return ret;
> +static int adc7_read_raw(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan, int *val, int *val2,
> +			 long mask)
> +{
> +	struct adc_do_conversion do_conv;
>  
> -		return IIO_VAL_INT;
> -	default:
> -		return -EINVAL;
> -	}
> +	do_conv.adc_do_conversion = adc7_do_conversion;
> +	return adc_read_raw_common(indio_dev, chan, val, val2,
> +				mask, do_conv);
>  }
>  
>  static const struct iio_info adc5_info = {


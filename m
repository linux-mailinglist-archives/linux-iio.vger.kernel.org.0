Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961D01DFED1
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 14:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgEXMEs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 08:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgEXMEr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 08:04:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B52D1207FB;
        Sun, 24 May 2020 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590321886;
        bh=p+CVYafn6nwoKLUG0OnDkhYwnz2spdrkgSqs5Qmh9kE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1oihyt6VjS4WOcA2/fEo+2MNN4ngWYqxVXxRtz0RQ/Nj1g+ZNpiTHXLoW1xClqvkH
         3ITBVWtKWS5r4sfmRM0UvfoNQoLtl9DTRRIqMu45CMIVnEICV7ZCRYIfKKyyVVD/AM
         3cZo/yuhBrQfa+gDUVDD+ia0tl2czljmXkz+zb+g=
Date:   Sun, 24 May 2020 13:04:40 +0100
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
Subject: Re: [PATCH V5 5/5] iio: adc: Clean up ADC code common to PMIC5 and
 PMIC7
Message-ID: <20200524130440.250edb2e@archlinux>
In-Reply-To: <1590157452-27179-6-git-send-email-jprakash@codeaurora.org>
References: <1590157452-27179-1-git-send-email-jprakash@codeaurora.org>
        <1590157452-27179-6-git-send-email-jprakash@codeaurora.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 May 2020 19:54:12 +0530
Jishnu Prakash <jprakash@codeaurora.org> wrote:

> This commit includes the following changes:
> 
> Add a common function used for read_raw callback for both PMIC5
> and PMIC7 ADCs.
> 
> Add exit function for ADC.

Hi Jishnu,

I don't understand why one is needed, and if it is you can't do
what you have here without introducing some nasty races.
So if you need it clearly explain why in comments in the code
and also consider how it may race with new requests coming in etc
as the userspace interfaces are still visible.

Move the eoc_irq addition to the structure here as well as makes
no sense in earlier patch.

Thanks,

Jonathan


> 
> Add info_property under adc_data to more efficiently distinguish
> PMIC5 and PMIC7 ADCs.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c   | 81 +++++++++++++++++++++-----------------
>  drivers/iio/adc/qcom-vadc-common.h |  1 +
>  2 files changed, 46 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 11eb97c..0208da3 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -167,8 +167,6 @@ static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
>  	{.num =  1, .den = 16}
>  };
>  
> -static const struct adc5_data adc7_data_pmic;
> -
>  static int adc5_read(struct adc5_chip *adc, u16 offset, u8 *data, int len)
>  {
>  	return regmap_bulk_read(adc->regmap, adc->base + offset, data, len);
> @@ -452,6 +450,13 @@ static int adc7_do_conversion(struct adc5_chip *adc,
>  	return ret;
>  }
>  
> +struct adc_do_conversion {
> +	int (*adc_do_conversion)(struct adc5_chip *adc,
> +			struct adc5_channel_prop *prop,
> +			struct iio_chan_spec const *chan,
> +			u16 *data_volt, u16 *data_cur);
> +};
> +
>  static irqreturn_t adc5_isr(int irq, void *dev_id)
>  {
>  	struct adc5_chip *adc = dev_id;
> @@ -490,9 +495,9 @@ static int adc7_of_xlate(struct iio_dev *indio_dev,
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
> @@ -503,8 +508,8 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
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
> @@ -521,36 +526,26 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
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
> +	struct adc_do_conversion do_conv;
>  
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
> @@ -706,7 +701,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  
>  	/* virtual channel number = sid << 8 | channel number */
>  
> -	if (adc->data == &adc7_data_pmic) {
> +	if (adc->data->info == &adc7_info) {
>  		sid = chan >> ADC_CHANNEL_OFFSET;
>  		chan = chan & ADC_CHANNEL_MASK;
>  	}
> @@ -772,7 +767,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  		/* Digital controller >= 5.3 have hw_settle_2 option */
>  		if ((dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
>  			dig_version[1] >= ADC5_HW_SETTLE_DIFF_MAJOR) ||
> -			adc->data == &adc7_data_pmic)
> +			adc->data->info == &adc7_info)
>  			ret = adc5_hw_settle_time_from_dt(value,
>  							data->hw_settle_2);
>  		else
> @@ -822,6 +817,7 @@ static const struct adc5_data adc5_data_pmic = {
>  	.full_scale_code_volt = 0x70e4,
>  	.full_scale_code_cur = 0x2710,
>  	.adc_chans = adc5_chans_pmic,
> +	.info = &adc5_info,
>  	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
>  				{250, 420, 840},
>  	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> @@ -835,6 +831,7 @@ static const struct adc5_data adc5_data_pmic = {
>  static const struct adc5_data adc7_data_pmic = {
>  	.full_scale_code_volt = 0x70e4,
>  	.adc_chans = adc7_chans_pmic,
> +	.info = &adc7_info,
>  	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
>  				{85, 340, 1360},
>  	.hw_settle_2 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> @@ -847,6 +844,7 @@ static const struct adc5_data adc5_data_pmic_rev2 = {
>  	.full_scale_code_volt = 0x4000,
>  	.full_scale_code_cur = 0x1800,
>  	.adc_chans = adc5_chans_rev2,
> +	.info = &adc5_info,
>  	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
>  				{256, 512, 1024},
>  	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> @@ -961,10 +959,7 @@ static int adc5_probe(struct platform_device *pdev)
>  	adc->dev = dev;
>  	adc->base = reg;
>  
> -	if (of_device_is_compatible(node, "qcom,spmi-adc7"))
> -		indio_dev->info = &adc7_info;
> -	else
> -		indio_dev->info = &adc5_info;
> +	platform_set_drvdata(pdev, adc);
>  
>  	init_completion(&adc->complete);
>  	mutex_init(&adc->lock);
> @@ -975,6 +970,8 @@ static int adc5_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	indio_dev->info = adc->data->info;
> +
>  	irq_eoc = platform_get_irq(pdev, 0);
>  	if (irq_eoc < 0) {
>  		if (irq_eoc == -EPROBE_DEFER || irq_eoc == -EINVAL)
> @@ -987,6 +984,8 @@ static int adc5_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> +	adc->irq_eoc = irq_eoc;
> +
>  	indio_dev->dev.parent = dev;
>  	indio_dev->dev.of_node = node;
>  	indio_dev->name = pdev->name;
> @@ -997,12 +996,22 @@ static int adc5_probe(struct platform_device *pdev)
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> +static int adc5_exit(struct platform_device *pdev)
> +{
> +	struct adc5_chip *adc = platform_get_drvdata(pdev);
> +
> +	if (adc->irq_eoc >= 0)
> +		disable_irq(adc->irq_eoc);

So here you are disabling an irq?  Why.  We should be removing it
cleanly in the managed flow shortly anyway.  If you did do this
here for some reason I'm not thinking of then you would have
a race against the userspace being removed on the unwind
of the iio device register.

> +	return 0;
> +}
> +
>  static struct platform_driver adc5_driver = {
>  	.driver = {
>  		.name = "qcom-spmi-adc5.c",
>  		.of_match_table = adc5_match_table,
>  	},
>  	.probe = adc5_probe,
> +	.remove = adc5_exit,
>  };
>  module_platform_driver(adc5_driver);
>  
> diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
> index f10250b..17b2fc4 100644
> --- a/drivers/iio/adc/qcom-vadc-common.h
> +++ b/drivers/iio/adc/qcom-vadc-common.h
> @@ -150,6 +150,7 @@ struct adc5_data {
>  	const u32	full_scale_code_volt;
>  	const u32	full_scale_code_cur;
>  	const struct adc5_channels *adc_chans;
> +	const struct iio_info *info;
>  	unsigned int	*decimation;
>  	unsigned int	*hw_settle_1;
>  	unsigned int	*hw_settle_2;


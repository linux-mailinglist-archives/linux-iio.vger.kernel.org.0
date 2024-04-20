Return-Path: <linux-iio+bounces-4403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C019B8ABC26
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 17:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BF41C20CCA
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 15:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F302B28387;
	Sat, 20 Apr 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcAdZ3Zh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE71DF43;
	Sat, 20 Apr 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713626001; cv=none; b=FXUpiihlQ24z6baae8kajgBD04I59TkqfYqZGCbyItjfDLaIsWlNNKTpaL9n0yfVIxQIJYd4sz5bslP0WoM1Q5AJpn+sp3sbd4daIIgbxh8WntzGZYj0tZluf1HM30f3wiUyurmGkH6yqHe9PyfYcP6/MHC3yy3hqANWQNF075g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713626001; c=relaxed/simple;
	bh=Ore1GJ4+xs2n/Ajx0XOCs2afoCsJOuQp1xQ9q+wWW7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmjx27YKxjTI4EV9iIeQRn7PqhBydKvR5aP1w0BAVpCIM2yIOOgr7Q11D3kLKfO0k8W1YWr8dUi/QsHh20eHGpZ6YZUtWmJ0FEGUNVkXp/S4Y3l21uWvPuWEAjPXjpxPXyEYbd0dj+WRxn6rgZZT9UiYK3TEjL+hZFFE4vyhPNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcAdZ3Zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B99FC072AA;
	Sat, 20 Apr 2024 15:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713626001;
	bh=Ore1GJ4+xs2n/Ajx0XOCs2afoCsJOuQp1xQ9q+wWW7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FcAdZ3ZhdlKQX8wg3I+eQF7xU1oDD5g66j/fpb1eEHlQKEXxG5oLPuN92RnrMQ3eh
	 UVqN3cHcCwYWZhZDMyTVrkaPSH2awJvQBKrvsf/d1YCblfesjQYyl0bK8ZoVtaFVyO
	 Ak8K2vxBHI02WsjXWex4MKNCRXlKJoSA/In01QXP549kk/cTgeTN/Gviu/uT+RoR6A
	 6PAcCpr3Oc8opZodGE0vPrlu+6N/SasKrwhH1ziiHnnwnxY+FSFOMsCUHdR4KoDfUG
	 ohVdovh2FTCR2vNfMOaprwl/Qn9KQDaioT8rffGMWd+BRaEFK7iVB+eHkZLZAe5Jer
	 eFhXXsekhUHVA==
Date: Sat, 20 Apr 2024 16:13:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 6/8] iio: adc: adi-axi-adc: support digital interface
 calibration
Message-ID: <20240420161308.67018515@jic23-huawei>
In-Reply-To: <20240419-ad9467-new-features-v1-6-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	<20240419-ad9467-new-features-v1-6-3e7628ff6d5e@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 17:36:49 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Implement the new IIO backend APIs for calibrating the data
> digital interfaces.
> 
> While at it, removed the tabs in 'struct adi_axi_adc_state' and used
> spaces for the members.

Ideally a precursor patch, but meh, it's 2 lines so I'll just moan about
it and move on.

A few minor things inline.


> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/adi-axi-adc.c | 113 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 111 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index b312369b7366..d58fa05499c4 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -7,11 +7,13 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> @@ -37,6 +39,9 @@
>  #define   ADI_AXI_REG_RSTN_MMCM_RSTN		BIT(1)
>  #define   ADI_AXI_REG_RSTN_RSTN			BIT(0)
>  
> +#define ADI_AXI_ADC_REG_CTRL			0x0044
> +#define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
> +
>  /* ADC Channel controls */
>  
>  #define ADI_AXI_REG_CHAN_CTRL(c)		(0x0400 + (c) * 0x40)
> @@ -51,14 +56,28 @@
>  #define   ADI_AXI_REG_CHAN_CTRL_PN_TYPE_OWR	BIT(1)
>  #define   ADI_AXI_REG_CHAN_CTRL_ENABLE		BIT(0)
>  
> +#define ADI_AXI_ADC_REG_CHAN_STATUS(c)		(0x0404 + (c) * 0x40)
> +#define   ADI_AXI_ADC_CHAN_STAT_PN_MASK		GENMASK(2, 1)
> +
> +#define ADI_AXI_ADC_REG_CHAN_CTRL_3(c)		(0x0418 + (c) * 0x40)
> +#define   ADI_AXI_ADC_CHAN_PN_SEL_MASK		GENMASK(19, 16)
> +
> +/* IO Delays */
> +#define ADI_AXI_ADC_REG_DELAY(l)		(0x0800 + (l) * 0x4)
> +#define   AXI_ADC_DELAY_CTRL_MASK		GENMASK(4, 0)
> +
> +#define ADI_AXI_ADC_MAX_IO_NUM_LANES		15
> +
>  #define ADI_AXI_REG_CHAN_CTRL_DEFAULTS		\
>  	(ADI_AXI_REG_CHAN_CTRL_FMT_SIGNEXT |	\
>  	 ADI_AXI_REG_CHAN_CTRL_FMT_EN |		\
>  	 ADI_AXI_REG_CHAN_CTRL_ENABLE)
>  
>  struct adi_axi_adc_state {
> -	struct regmap				*regmap;
> -	struct device				*dev;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	/* lock to protect multiple accesses to the device registers */

Why?  The locking in regmap protects register accesses in general I believe.
I guess this is to prevent accesses during that error detection routine?
Needs more detail in the comment.

> +	struct mutex lock;
>  };
>  
>  static int axi_adc_enable(struct iio_backend *back)
> @@ -104,6 +123,92 @@ static int axi_adc_data_format_set(struct iio_backend *back, unsigned int chan,
>  				  ADI_AXI_REG_CHAN_CTRL_FMT_MASK, val);
>  }
>  
> +static int axi_adc_data_sample_trigger(struct iio_backend *back,
> +				       enum iio_backend_sample_trigger trigger)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +
> +	if (trigger == IIO_BACKEND_SAMPLE_TRIGGER_EDGE_RISING)

It's an enum, so can't have more than one. Hence switch statement is probably
more extensible and natural to read.

> +		return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
> +					 ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK);
> +	if (trigger == IIO_BACKEND_SAMPLE_TRIGGER_EDGE_FALLING)
> +		return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
> +				       ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK);
> +
> +	return -EINVAL;
> +}
> +


> +static int axi_adc_chan_status(struct iio_backend *back, unsigned int chan,
> +			       struct iio_backend_chan_status *status)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	int ret;
> +	u32 val;
> +
> +	guard(mutex)(&st->lock);
> +	/* reset test bits by setting them */
> +	ret = regmap_write(st->regmap, ADI_AXI_ADC_REG_CHAN_STATUS(chan),
> +			   ADI_AXI_ADC_CHAN_STAT_PN_MASK);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(1000);
Why this particular length sleep?  Is this a case of let it sit a while an dsee
if an error shows up?  If so a comment on that would be good.
> +
> +	ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_CHAN_STATUS(chan), &val);
> +	if (ret)
> +		return ret;
> +
> +	if (ADI_AXI_ADC_CHAN_STAT_PN_MASK & val)
> +		status->errors = true;
> +
> +	return 0;
> +}
> +
>  static int axi_adc_chan_enable(struct iio_backend *back, unsigned int chan)
>  {
>  	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> @@ -166,6 +271,10 @@ static const struct iio_backend_ops adi_axi_adc_generic = {
>  	.chan_disable = axi_adc_chan_disable,
>  	.request_buffer = axi_adc_request_buffer,
>  	.free_buffer = axi_adc_free_buffer,
> +	.data_sample_trigger = axi_adc_data_sample_trigger,
> +	.iodelay_set = axi_adc_iodelays_set,
> +	.test_pattern_set = axi_adc_test_pattern_set,
> +	.chan_status = axi_adc_chan_status,
>  };
>  
>  static int adi_axi_adc_probe(struct platform_device *pdev)
> 



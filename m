Return-Path: <linux-iio+bounces-1620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D082C4CA
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jan 2024 18:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EDD4B21BC7
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jan 2024 17:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DCA22634;
	Fri, 12 Jan 2024 17:33:41 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35AA175A3;
	Fri, 12 Jan 2024 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TBT8s0qvjz6J9SV;
	Sat, 13 Jan 2024 01:31:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 18D6D140B2A;
	Sat, 13 Jan 2024 01:33:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 17:33:34 +0000
Date: Fri, 12 Jan 2024 17:33:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
CC: <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>
Subject: Re: [PATCH v5 7/8] iio: adc: ad9467: convert to backend framework
Message-ID: <20240112173333.00002ed1@Huawei.com>
In-Reply-To: <20240112-iio-backend-v5-7-bdecad041ab4@analog.com>
References: <20240112-iio-backend-v5-0-bdecad041ab4@analog.com>
	<20240112-iio-backend-v5-7-bdecad041ab4@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 12 Jan 2024 17:40:21 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Convert the driver to use the new IIO backend framework. The device
> functionality is expected to be the same (meaning no added or removed
> features).
> 
> Also note this patch effectively breaks ABI and that's needed so we can
> properly support this device and add needed features making use of the
> new IIO framework.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Hi Nuno,

Some trivial stuff in here (not I reviewed in reverse so might make more
sense read that way).  Mostly little changes that will reduce what
appears to be going on in this patch to the minimum possible


>  
> -static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
> +static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
>  {
> -	const struct adi_axi_adc_chip_info *info = conv->chip_info;

Keep an info variable around in here as well.

> -	const struct ad9467_chip_info *info1 = to_ad9467_chip_info(info);
> -	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
>  	unsigned int i, vref_val;
>  	int ret;
>  
> @@ -282,25 +276,23 @@ static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
>  	if (ret < 0)
>  		return ret;
>  
> -	vref_val = ret & info1->vref_mask;
> +	vref_val = ret & st->info->vref_mask;
>  
> -	for (i = 0; i < info->num_scales; i++) {
> -		if (vref_val == info->scale_table[i][1])
> +	for (i = 0; i < st->info->num_scales; i++) {
> +		if (vref_val == st->info->scale_table[i][1])
>  			break;
>  	}
>  
> -	if (i == info->num_scales)
> +	if (i == st->info->num_scales)
>  		return -ERANGE;
>  
> -	__ad9467_get_scale(conv, i, val, val2);
> +	__ad9467_get_scale(st, i, val, val2);
>  
>  	return IIO_VAL_INT_PLUS_MICRO;
>  }
>  
> -static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
> +static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
>  {
> -	const struct adi_axi_adc_chip_info *info = conv->chip_info;
> -	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);

Definitely good to keep local info variable here.

>  	unsigned int scale_val[2];
>  	unsigned int i;
>  	int ret;
> @@ -308,14 +300,14 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
>  	if (val != 0)
>  		return -EINVAL;
>  
> -	for (i = 0; i < info->num_scales; i++) {
> -		__ad9467_get_scale(conv, i, &scale_val[0], &scale_val[1]);
> +	for (i = 0; i < st->info->num_scales; i++) {
> +		__ad9467_get_scale(st, i, &scale_val[0], &scale_val[1]);
>  		if (scale_val[0] != val || scale_val[1] != val2)
>  			continue;
>  
>  		guard(mutex)(&st->lock);
>  		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
> -				       info->scale_table[i][1]);
> +				       st->info->scale_table[i][1]);
>  		if (ret < 0)
>  			return ret;
>  

>  }
>  
> -static int ad9467_write_raw(struct adi_axi_adc_conv *conv,
> +static int ad9467_write_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int val, int val2, long mask)
>  {
> -	const struct adi_axi_adc_chip_info *info = conv->chip_info;
> -	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
> +	struct ad9467_state *st = iio_priv(indio_dev);
Even here I'd keep a local info variable as it's harmless and
reduces what is changed in this patch.

>  	long r_clk;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> -		return ad9467_set_scale(conv, val, val2);
> +		return ad9467_set_scale(st, val, val2);
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		r_clk = clk_round_rate(st->clk, val);
> -		if (r_clk < 0 || r_clk > info->max_rate) {
> +		if (r_clk < 0 || r_clk > st->info->max_rate) {
>  			dev_warn(&st->spi->dev,
>  				 "Error setting ADC sample rate %ld", r_clk);
>  			return -EINVAL;
> @@ -369,26 +360,53 @@ static int ad9467_write_raw(struct adi_axi_adc_conv *conv,
>  	}
>  }
>  
> -static int ad9467_read_avail(struct adi_axi_adc_conv *conv,
> +static int ad9467_read_avail(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     const int **vals, int *type, int *length,
>  			     long mask)
>  {
> -	const struct adi_axi_adc_chip_info *info = conv->chip_info;
> -	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
> +	struct ad9467_state *st = iio_priv(indio_dev);
As below, I'd keep the local info variable to reduce scope of changes
to the minimum.

>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		*vals = (const int *)st->scales;
>  		*type = IIO_VAL_INT_PLUS_MICRO;
>  		/* Values are stored in a 2D matrix */
> -		*length = info->num_scales * 2;
> +		*length = st->info->num_scales * 2;
>  		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  

> +
>  static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
>  {
>  	int ret;
> @@ -401,19 +419,17 @@ static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
>  				AN877_ADC_TRANSFER_SYNC);
>  }
>  
> -static int ad9467_scale_fill(struct adi_axi_adc_conv *conv)
> +static int ad9467_scale_fill(struct ad9467_state *st)
>  {
> -	const struct adi_axi_adc_chip_info *info = conv->chip_info;
> -	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
>  	unsigned int i, val1, val2;
	const struct adi_axi_adc_chip_info *info = st->info;
I think...

Makes this patch more minimal which is nice and it's not a bad change
in it's own right..

Same with some other cases changed by this patch.

>  
> -	st->scales = devm_kmalloc_array(&st->spi->dev, info->num_scales,
> +	st->scales = devm_kmalloc_array(&st->spi->dev, st->info->num_scales,
>  					sizeof(*st->scales), GFP_KERNEL);
>  	if (!st->scales)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < info->num_scales; i++) {
> -		__ad9467_get_scale(conv, i, &val1, &val2);
> +	for (i = 0; i < st->info->num_scales; i++) {
> +		__ad9467_get_scale(st, i, &val1, &val2);
>  		st->scales[i][0] = val1;
>  		st->scales[i][1] = val2;
>  	}
> @@ -421,11 +437,27 @@ static int ad9467_scale_fill(struct adi_axi_adc_conv *conv)
>  	return 0;
>  }
>  
> -static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
> +static int ad9467_setup(struct ad9467_state *st)
>  {
> -	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
> +	struct iio_backend_data_fmt data = {
> +		.sign_extend = true,
> +		.enable = true,
> +	};
> +	unsigned int c, mode;
> +	int ret;
> +
> +	mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;

Bit of a long line. Perhaps break it after the |

> +	ret = ad9467_outputmode_set(st->spi, mode);
> +	if (ret)
> +		return ret;
>  
> -	return ad9467_outputmode_set(st->spi, st->output_mode);
> +	for (c = 0; c < st->info->num_channels; c++) {
> +		ret = iio_backend_data_format_set(st->back, c, &data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static int ad9467_reset(struct device *dev)
> @@ -443,25 +475,64 @@ static int ad9467_reset(struct device *dev)
>  	return 0;
>  }
>  
> +static int ad9467_iio_backend_get(struct ad9467_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct device_node *__back;
> +
> +	st->back = devm_iio_backend_get(&st->spi->dev, NULL);
> +	/* If not found, don't error out as we might have legacy DT property */
> +	if (IS_ERR(st->back) && PTR_ERR(st->back) != -ENOENT)
> +		return PTR_ERR(st->back);
> +	if (!IS_ERR(st->back))
> +		return 0;
Why not do this one first? I know I normally moan about having error handlers
out of line, but in this case the good is out of line whatever.

	if (!IS_ERR(st->back)
		return 0;

	if (PTR_ERR(st->back) != ENOENT)
		return PTR_ERR(st->back);

	...


> +	/*
> +	 * if we don't get the backend using the normal API's, use the legacy
> +	 * 'adi,adc-dev' property. So we get all nodes with that property, and
> +	 * look for the one pointing at us. Then we directly lookup that fwnode
> +	 * on the backend list of registered devices. This is done so we don't
> +	 * make io-backends mandatory which would break DT ABI.
> +	 */
> +	for_each_node_with_property(__back, "adi,adc-dev") {
> +		struct device_node *__me;
> +
> +		__me = of_parse_phandle(__back, "adi,adc-dev", 0);
> +		if (!__me)
> +			continue;
> +
> +		if (!device_match_of_node(dev, __me)) {
> +			of_node_put(__me);
> +			continue;
> +		}
> +
> +		of_node_put(__me);
> +		st->back = __devm_iio_backend_get_from_fwnode_lookup(dev,
> +								     of_fwnode_handle(__back));
> +		of_node_put(__back);
> +		return PTR_ERR_OR_ZERO(st->back);
> +	}
> +
> +	return -ENODEV;
> +}
> +
>  static int ad9467_probe(struct spi_device *spi)
>  {
>

>  
> -	st->output_mode = info->default_output_mode |
> -			  AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
> +	ret = ad9467_iio_backend_get(st);
> +	if (ret)
> +		return ret;
>  
> -	return 0;
> +	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_enable(st->back);
> +	if (ret)
> +		return ret;

I'm curious there is no iio_backend_disable() to be done in the exit path?

> +
> +	ret = ad9467_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct of_device_id ad9467_of_match[] = {
> @@ -529,4 +610,4 @@ module_spi_driver(ad9467_driver);
>  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD9467 ADC driver");
>  MODULE_LICENSE("GPL v2");
> -MODULE_IMPORT_NS(IIO_ADI_AXI);
> +MODULE_IMPORT_NS(IIO_BACKEND);
> 



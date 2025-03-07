Return-Path: <linux-iio+bounces-16529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CBCA56AC9
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 15:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0681171F92
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939EB19D8A8;
	Fri,  7 Mar 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzaxJD32"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79438BE5;
	Fri,  7 Mar 2025 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358906; cv=none; b=TaFUC5ntItqNEzmnbIF9fX6LpMDErzd8+YMb1R0bDXdHCQ/aG9ocom/Iouu8ZvB1gbOABEy2D3KtRYDhru7eF3vgYtfqu8Ak/8TOw6cR3adHC2S2nYbh8TXabZyx82Syy1yX3RnStQewhaAJE7MrKGOHcaop8a6LEWOlxhWjNf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358906; c=relaxed/simple;
	bh=M2OkvnNxpvzS165+JIvvwSlevm5ozmXGBdo6NJjOt2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+OLeKf0ZEUGUQI1XRIf87tevylAP+PT/83Wwhd6GXu4u8BX7fuXBXzht/L5cxzFqB5U9kGDhDnfU12M/tWi6ha0jOufGURkyy9/4UV4ErPfRy2ipkCyEDYEmto6Y5M2dbmB5+QPjapWkJBqO06QOUqLOjd+WYejWIE4L6BXWOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzaxJD32; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22334203781so58691845ad.0;
        Fri, 07 Mar 2025 06:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741358904; x=1741963704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ioh5SQLz7gpii5kUXtkklEFD5Pb6kb4fEtFbn053urw=;
        b=LzaxJD32+UkUgrCdNoMhRm+GABvA+07kuOQsr47l+x/2h6jXUDRLYKDkpfu6YxTtl0
         tY2WFq+RfEGB6+l+sudMN8pwQqDQD9KE2OS8KvZb0+edTDe45V1igHMNEhXupNYs8czE
         TjaBO18dBkvtpp/p+N89paWi7UbGsLLFV5BoJdlZyJY6CKWmGv5eqpzukVyKgAmD29ag
         E+fyasH/yM8vwhY9MetJyTnKnNpeGXLsMpm6pEuM892zJjcpEJusSju4kkcBezcVz93E
         1GMUucg+nrDc/fIFPgAsxNnJcMTLOClhwX/U1C4wAWE0ewXF820l/8ADPrsqbj/Tqks3
         gQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741358904; x=1741963704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioh5SQLz7gpii5kUXtkklEFD5Pb6kb4fEtFbn053urw=;
        b=SyfinIGAsVwkZEj+G8qsrL+snNWFAjywL2qBuCrQNIRViAkXkWuqT2fdSfzzYoqY+m
         HoG/GoQ2JLnMMwCWS8yK+QuiPZOkAsOxqxmFf7HVpKRTPh2isWe1AVsTHif2f7MPU3Q7
         XaQXMRvyMpVvO9AvrXaqCFFFwylSeQdaWeATxtg5nZbI69k9DcoJJa3HF8JcZF6SifOi
         szLnjQ9Uyj8W8Xe5+4rZ6ozbiKtzQFJgUEW3S4Yf+2TfyjV4ROWA+dvgBV4A7t9jQN8z
         jTgNUJaIhOnDAyG74zpodRI7WHB1kHE9cPikBUP9M86vUtK28eIHL8uSBcTfmZvnrI22
         ZzpA==
X-Forwarded-Encrypted: i=1; AJvYcCUA+e7eguWyZ2sXHjTNMHfFEQt+qnrxjmOA7iE/SMyotDHJ1cxPucq8ZccyebDojBNFXNywlOdqASIn@vger.kernel.org, AJvYcCUYqv5HcJ7F2EIVxUnzYq4tofmCyXgPSsuhNYcspZebOUU+hjXvM7ohxYwNLQby8ekVUoOX/EcRw3EIyprB@vger.kernel.org, AJvYcCXlhpVR2WyJMapR1BEHRD4rt3qzQM6gv+9ZaY0Ked8C5eYnONUP1K+TWQ9XlR+dvraed73XM3MLYOoxMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mNU9nQTpVjj+x1mDLIUyQrwnabQxJxyLbvCHpm6kJsbh7mq7
	LPOYsF4PTE1n4fLMHfAcEaPEjOCdnw7FOgn0g6e7/atcXRnKeuEF
X-Gm-Gg: ASbGncupXqB6KtbK/HT3Bcfk/XphrU3ssKyUcpusWTaICJ/Lx2NhPvqqNIDkGu8QKl2
	dBNBfJfKSBA6B59TM6OhqaQ0kaQHyMGcs1QhNopom2UwK53Mb8vN+FH53omLqIgG0X/szoBeNIh
	xAF2fO6pORyaHOM4DIl35YRJ9qLFc27dzHBlvFGdGcb+097sXz6qvJQXWwSAj6MI3+8osewUfS9
	yhqbB28TMuMFY/01e4gKt5C5mfRMP7lCFX5FhIvcUq5U+TVz6Y5dTlbkWm6dwCm7kFrzjyjojLv
	hqcqI0KNxhRGvB9W39vNwWiYv/P9gKD5bVAu+JgJv9mT0s/8p52ESw==
X-Google-Smtp-Source: AGHT+IHRcx0iwE4iShkhV9lEkg6KwfBUXIIAw+cZOq0H8/XJhguouoeDBfKO+SVgxCD51qwrQMXK2A==
X-Received: by 2002:a05:6a00:1816:b0:732:706c:c4ff with SMTP id d2e1a72fcca58-73693f731b2mr13179089b3a.7.1741358903972;
        Fri, 07 Mar 2025 06:48:23 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7369824402bsm3299375b3a.49.2025.03.07.06.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 06:48:23 -0800 (PST)
Date: Fri, 7 Mar 2025 11:49:16 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, lgirdwood@gmail.com, broonie@kernel.org,
	dlechner@baylibre.com, jonath4nns@gmail.com
Subject: Re: [PATCH v4 15/17] iio: adc: ad7768-1: replace manual attribute
 declaration
Message-ID: <Z8sHbNJcxtlAJHn7@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <6d429bf18851e9e423e90252d351db550b2da536.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d429bf18851e9e423e90252d351db550b2da536.1741268122.git.Jonathan.Santos@analog.com>

On 03/06, Jonathan Santos wrote:
> Use read_avail callback from struct iio_info to replace the manual
> declaration of sampling_frequency_available attribute.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

> ---
> v4 Changes:
> * Added ad7768_fill_samp_freq_tbl() helper function.
> * Sampling frequency table is precomputed at probe.
> 
> v3 Changes:
> * New patch in v3.
> ---
>  drivers/iio/adc/ad7768-1.c | 63 +++++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index c48d3e0af985..0bdf2ae903c6 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -187,6 +187,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.indexed = 1,
>  		.channel = 0,
>  		.scan_index = 0,
> @@ -208,6 +209,7 @@ struct ad7768_state {
>  	unsigned int mclk_freq;
>  	unsigned int dec_rate;
>  	unsigned int samp_freq;
> +	unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_clk_config)];
>  	struct completion completion;
>  	struct iio_trigger *trig;
>  	struct gpio_desc *gpio_sync_in;
> @@ -306,6 +308,15 @@ static int ad7768_send_sync_pulse(struct ad7768_state *st)
>  	return 0;
>  }
>  
> +static void ad7768_fill_samp_freq_tbl(struct ad7768_state *st)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++)
> +		st->samp_freq_avail[i] = DIV_ROUND_CLOSEST(st->mclk_freq,
> +							   ad7768_clk_config[i].clk_div);
> +}
> +
>  static int ad7768_set_mode(struct ad7768_state *st,
>  			   enum ad7768_conv_mode mode)
>  {
> @@ -566,28 +577,6 @@ static int ad7768_set_freq(struct ad7768_state *st,
>  	return 0;
>  }
>  
> -static ssize_t ad7768_sampling_freq_avail(struct device *dev,
> -					  struct device_attribute *attr,
> -					  char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ad7768_state *st = iio_priv(indio_dev);
> -	unsigned int freq;
> -	int i, len = 0;
> -
> -	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
> -		freq = DIV_ROUND_CLOSEST(st->mclk_freq,
> -					 ad7768_clk_config[i].clk_div);
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", freq);
> -	}
> -
> -	buf[len - 1] = '\n';
> -
> -	return len;
> -}
> -
> -static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ad7768_sampling_freq_avail);
> -
>  static int ad7768_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long info)
> @@ -635,6 +624,24 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int ad7768_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = (int *)st->samp_freq_avail;
> +		*length = ARRAY_SIZE(ad7768_clk_config);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int ad7768_write_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int val, int val2, long info)
> @@ -657,15 +664,6 @@ static int ad7768_read_label(struct iio_dev *indio_dev,
>  	return sprintf(label, "%s\n", st->labels[chan->channel]);
>  }
>  
> -static struct attribute *ad7768_attributes[] = {
> -	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> -	NULL
> -};
> -
> -static const struct attribute_group ad7768_group = {
> -	.attrs = ad7768_attributes,
> -};
> -
>  static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
>  					const struct iio_chan_spec *chan)
>  {
> @@ -676,8 +674,8 @@ static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_info ad7768_info = {
> -	.attrs = &ad7768_group,
>  	.read_raw = &ad7768_read_raw,
> +	.read_avail = &ad7768_read_avail,
>  	.write_raw = &ad7768_write_raw,
>  	.read_label = ad7768_read_label,
>  	.get_current_scan_type = &ad7768_get_current_scan_type,
> @@ -1134,6 +1132,7 @@ static int ad7768_probe(struct spi_device *spi)
>  		return PTR_ERR(st->mclk);
>  
>  	st->mclk_freq = clk_get_rate(st->mclk);
> +	ad7768_fill_samp_freq_tbl(st);
>  
>  	indio_dev->channels = ad7768_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
> -- 
> 2.34.1
> 


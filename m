Return-Path: <linux-iio+bounces-18653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9117A9C9FA
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 15:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F81A5A280C
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB471E871;
	Fri, 25 Apr 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSIJ6EpO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCE85695
	for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587092; cv=none; b=uHXW9+R2yWaLsH0OiOrl9lyF/KolaYFRKoPV+ItEh6VsHFL6FdD9sNyO3Pv0FBvPtfXsYp4U0oY0i8jR6sOPAMmQVRXX1Ku2/mAxzaMQebyqP5jJ0I+DbpUeN/OiHaNjwMmWFpnxddQTEW1irUg2inBRXZUSPuLnLnQhNcB1brU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587092; c=relaxed/simple;
	bh=9juRr8sLTz6yET5bKxGWoa/rfH2ALpXj1tjC+No5OIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP6HFHdxO6B/HsBlvHuPxcKrHS7c4u0WzjsdT7o11Om668urO3QIM0l77YfwlAYW0GHCpzoGvuBJc1aNyE4LOdKqQ4A78w6QYt3Ll/5vh6GdqEIPm3n3J/CsqFyEm6kYAKiQ3rD6wRo9dLM5TwFyqtGtN5VHUH+hf1d4l01e/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SSIJ6EpO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ede096d73so16407195e9.2
        for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745587088; x=1746191888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WiZQEQXbMAh4QSTUazeZTDFr/XgIvOyC1vsWeFbPWQo=;
        b=SSIJ6EpOQHGtxCVRlcZO1nXaURtpTb/0CxK8rh4yPLpVgDFPuBuBLBE7ho6cpghRPW
         gGTA2lJhezpU/77kPBbmO2nH0xDBhJ0uyjAAZ4gasPW9F3LlM5xUE9SprM5fft6pQCJj
         ICxMrUKI9s2bRCVCal3av+RWPP79jHsgdaJkBitLd/aQm160gk6K54151KI8jiQERGvp
         EbzX8K6kJoHrQdOaMaCxURKk5Q+hq8Oz5gX2UMb9VsCI00yXSSlr4ReYCsmkb/6DeWMH
         f7AlQ/oWYk+ocPTsv6VUBQrAIeR3Vt/u8zeqIApZVAnz8X3K2yZkfJhPGpHExIwo2kgh
         ccjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745587088; x=1746191888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiZQEQXbMAh4QSTUazeZTDFr/XgIvOyC1vsWeFbPWQo=;
        b=HIkdF15aNhK62dvpMvyINzuMqS5C2qeY/7Yn5BrfjyIr52++I9kPblcOXKxZRmGOmT
         aVb2mVldCRphkzwt1PY/zFIwtfL26eb3Ddf3/rv5q78l2CwO8CcxYaJRTfaneysTBqBt
         cAZm3J6m/IIx5EaRNcA6D0Mdi2a5DT6ABQ9eryPjM5CTUaeY18qbqb66nCHUxohVPm12
         9zK7O5pxhI2CWt7oE0EdzZyJBYvCAKpQVm/M9AlFH/l5kOUFYh7F2gnkcQm99G/lfdUd
         +0TiU14P48nQMZJyhkX/hQ6MLt0lWdeQCeUjy0eB+vyJxvckx28NUBUvfxPWGQdhzGHa
         KvJg==
X-Forwarded-Encrypted: i=1; AJvYcCXAFcyXlCbomaebwrYgUl5YoWjD5yp5aFy8DBE7x6mcdWmJ8bazETN5SC3xsgd8Jiw2KNmUgr6U2zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJ3IMVc8qDeHhgihD+eqjJe0/mokb4Mv0IRqHnmg8lpAkkuu2
	d9+yUN8xClstDPKtkgXiL10HrInVBt67cgBuWsCODzOF97GcS0uJYjnacOLmH+o=
X-Gm-Gg: ASbGnctOvHn1Idb7rbapJvrAn3nJUIiNpkIJZiDh9ehHWwVcN+rNxJF4Fd4cWsWhjFA
	SKx0XmF8eqkp4Yw7sc3QQhW0zJidU2Ztv1knOktN8rGrGf4uwTyc7LBjdKMK2n3G3grgsMfOGA7
	seZqR5AtmVoab5xtmEkUGw84zeRVlajGUB7XHfgowRhAw08Uc88+dAklBIbjLDK6HVyd+Hb1/1F
	G2kcqOynZ+h2qDAwl9nTmwMWwga8k8Ewske9cPMrkHfwJEcbq84cO4UN/1cSAhmBrRGUEpEjjhj
	I5xfg5k3Mq/L3J9oAHJZBicdU/MzGyBC1M5yLA7XKQS4SA==
X-Google-Smtp-Source: AGHT+IHbDjS1PQI7NTlpMT+Bu2EFu2dfDgHH1BOBPjpV0q2B/rN6BZiZF+DNqb4h89r5ixKpK9+CrA==
X-Received: by 2002:a05:600c:3b83:b0:43d:ed:acd5 with SMTP id 5b1f17b1804b1-440a65def49mr25292515e9.10.1745587087859;
        Fri, 25 Apr 2025 06:18:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073cbe386sm2330109f8f.42.2025.04.25.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 06:18:07 -0700 (PDT)
Date: Fri, 25 Apr 2025 16:18:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: andy@kernel.org, dlechner@baylibre.com, gregkh@linuxfoundation.org,
	jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com, nuno.sa@analog.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v4 2/2] staging: iio: frequency: ad9832: Refactor
 powerdown control
Message-ID: <0771a9a7-ec49-487e-afaa-46a39f0b8ba2@stanley.mountain>
References: <20250424223210.91317-1-gshahrouzi@gmail.com>
 <20250424223210.91317-3-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424223210.91317-3-gshahrouzi@gmail.com>

On Thu, Apr 24, 2025 at 06:32:09PM -0400, Gabriel Shahrouzi wrote:
> Replace custom implementation with out_altvoltage_powerdown ABI. The
> attribute's logic is inverted (1 now enables powerdown) to match the
> standard.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
> V3 -> v4:
> 	- Use guard(mutex) for simplified locking.
> 	- Use an extended attribute.
> v2 -> v3:
> v1 -> v2:
> 	Refactor powerdown functionality.
> ---
>  drivers/staging/iio/frequency/ad9832.c | 69 +++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 2e555084ff98a..b8b52302abf36 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -174,6 +174,32 @@ static int ad9832_write_phase(struct ad9832_state *st,
>  	return spi_sync(st->spi, &st->phase_msg);
>  }
>  
> +static ssize_t ad9832_write_powerdown(struct iio_dev *indio_dev, uintptr_t private,
> +				      const struct iio_chan_spec *chan,
> +				      const char *buf, size_t len)
> +{
> +	struct ad9832_state *st = iio_priv(indio_dev);
> +	int ret;
> +	bool val;

Declare val before ret.  Use reverse Christmas tree order.

	long long long_name;
	medium name;
	short name;

> +
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +	if (val)
> +		st->ctrl_src |= AD9832_SLEEP;
> +	else
> +		st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
> +				 AD9832_CLR);
> +
> +	st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
> +					  st->ctrl_src);
> +	ret = spi_sync(st->spi, &st->msg);
> +
> +	return ret ? ret : len;
> +}
> +
>  static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  			    const char *buf, size_t len)
>  {
> @@ -185,9 +211,9 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  
>  	ret = kstrtoul(buf, 10, &val);
>  	if (ret)
> -		goto error_ret;
> +		return ret;

This is unrelated.  Do this in a separate patch.

>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);

same.

>  	switch ((u32)this_attr->address) {
>  	case AD9832_FREQ0HM:
>  	case AD9832_FREQ1HM:
> @@ -232,22 +258,9 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  						  st->ctrl_fp);
>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
> -	case AD9832_OUTPUT_EN:
> -		if (val)
> -			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP | AD9832_CLR);
> -		else
> -			st->ctrl_src |= FIELD_PREP(AD9832_SLEEP, 1);
> -
> -		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
> -						  st->ctrl_src);
> -		ret = spi_sync(st->spi, &st->msg);
> -		break;

This is related.  Keep this.

>  	default:
>  		ret = -ENODEV;
>  	}
> -	mutex_unlock(&st->lock);
> -
> -error_ret:
>  	return ret ? ret : len;

Unrelated.

>  }
>  
> @@ -270,8 +283,6 @@ static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
>  
>  static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
>  				ad9832_write, AD9832_PINCTRL_EN);
> -static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
> -				ad9832_write, AD9832_OUTPUT_EN);
>  
>  static struct attribute *ad9832_attributes[] = {
>  	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
> @@ -285,7 +296,6 @@ static struct attribute *ad9832_attributes[] = {
>  	&iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -293,6 +303,27 @@ static const struct attribute_group ad9832_attribute_group = {
>  	.attrs = ad9832_attributes,
>  };
>  
> +static const struct iio_chan_spec_ext_info ad9832_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.shared = IIO_SEPARATE,
> +		.write = ad9832_write_powerdown,
> +	},
> +	{ },
           ^
No comma after a sentinal.

> +};
> +

regards,
dan carpenter



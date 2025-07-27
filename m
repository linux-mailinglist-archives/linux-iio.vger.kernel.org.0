Return-Path: <linux-iio+bounces-22058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BD8B130A0
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 18:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7DC3A6975
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16981F0E2E;
	Sun, 27 Jul 2025 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbpHtpPW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775BE286A9;
	Sun, 27 Jul 2025 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633894; cv=none; b=A1cg5GFRzU1P/E3iDR05x5ZCK60VkDxTPc62obz6eMPlsEr8pCis+pKIk9UrDUIa0QlLTaEKeIsH0F4vv9rJ5CgZ1+DJI7bMA7aoAu5hBmtO8puGu3rrLcVCgWWEqRDQh0mEAzk2woeFkI0RyZ7l+O099o5DVcysInSFP6tue+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633894; c=relaxed/simple;
	bh=s6OwdlifNz9JuEFPYBMqHXhyqDHMIVdb1DTGoTpI/VI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HB1uqQAkAmCGa3DZJJjQS+Q84JP1IfESYmk38yLddCILv1iBhrh8JHyjTmHy4LvMrOWsCo1SF/dN42DeflYnWvyVwMb0BSM4tc/uGRvao3ujylJxpzP9Z6nEiAYV/E2xyrExTLONqaf00nvrDksZ4N9uIJeeejNlEFLc4cVODS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbpHtpPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3B8C4CEEB;
	Sun, 27 Jul 2025 16:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753633894;
	bh=s6OwdlifNz9JuEFPYBMqHXhyqDHMIVdb1DTGoTpI/VI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZbpHtpPWGnwId0GMOpX5Zy4vYZGYSEcIR4vO7CgaRSP/ghX6NimU7h8DvxN33l9BI
	 YLf3SABKxLZIPyZgFNLjgOGntMATRJjwhr2zOGxSaiaD4qsKWqqjEyN3LpxGUIUVDv
	 T8Glc7XcxT49UjU+5Atg5Yv1cDU0WKJ7TatbypzOqT/d669ZFRErOOhVceaCuATlwn
	 JtbnN+r9HIjPxs6jgkrm/qeydJM4Y32WUkbVRbrDgwnNUjpE1rP0EsSXkszfdrF0DK
	 azcg6m6bj0kzRAWq+dJPrZSnx9Ti67ADyst341/IB/UKMEx82k+imtSOtxKeCGXw3V
	 IV/lfXaHrOC4g==
Date: Sun, 27 Jul 2025 17:31:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 5/7] hwmon: iio: Add helper function for creating
 attributes
Message-ID: <20250727173125.407f92fa@jic23-huawei>
In-Reply-To: <20250715012023.2050178-6-sean.anderson@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	<20250715012023.2050178-6-sean.anderson@linux.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 21:20:21 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> Add a helper function to create attributes and initialize their fields.
> This reduces repetition when creating several attributes per channel.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  drivers/hwmon/iio_hwmon.c | 78 +++++++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> index bba8919377eb..7dc156d2aea4 100644
> --- a/drivers/hwmon/iio_hwmon.c
> +++ b/drivers/hwmon/iio_hwmon.c
> @@ -24,13 +24,15 @@
>   * @attr_group:		the group of attributes
>   * @groups:		null terminated array of attribute groups
>   * @attrs:		null terminated array of attribute pointers.
> + * @num_attrs:          length of @attrs
>   */
>  struct iio_hwmon_state {
>  	struct iio_channel *channels;
> -	int num_channels;
>  	struct attribute_group attr_group;
>  	const struct attribute_group *groups[2];
>  	struct attribute **attrs;
> +	size_t num_attrs;

It's a little unfortunate that we need to keep the state around when it
is only relevant in probe.

> +	int num_channels;
>  };
>  
>  static ssize_t iio_hwmon_read_label(struct device *dev,
> @@ -93,12 +95,39 @@ static ssize_t iio_hwmon_read_val(struct device *dev,
>  	return sprintf(buf, "%d\n", result);
>  }
>  
> +static int add_device_attr(struct device *dev, struct iio_hwmon_state *st,

That's a very generic name. I'd prefix it to avoid potential namespace
issues in future.

> +			   ssize_t (*show)(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf),
> +			   int i, const char *fmt, ...)
> +{
> +	struct sensor_device_attribute *a;
> +	va_list ap;
> +
> +	a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
> +	if (!a)
> +		return -ENOMEM;
> +
> +	sysfs_attr_init(&a->dev_attr.attr);
> +	va_start(ap, fmt);
> +	a->dev_attr.attr.name = devm_kvasprintf(dev, GFP_KERNEL, fmt, ap);
> +	va_end(ap);
> +	if (!a->dev_attr.attr.name)
> +		return -ENOMEM;
> +
> +	a->dev_attr.show = show;
> +	a->dev_attr.attr.mode = 0444;
> +	a->index = i;
> +
> +	st->attrs[st->num_attrs++] = &a->dev_attr.attr

I wonder if we should break this up into
	static attribute *iio_hwmon_alloc_attr();

and setting st->attrs in the caller as then we can make num_attrs a local
variable.

> +	return 0;
> +}
> +
>  static int iio_hwmon_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct iio_hwmon_state *st;
> -	struct sensor_device_attribute *a;
> -	int ret, i, attr = 0;
> +	int ret, i;
>  	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1, power_i = 1;
>  	enum iio_chan_type type;
>  	struct iio_channel *channels;
> @@ -136,11 +165,6 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  		const char *prefix;
>  		int n;
>  
> -		a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
> -		if (a == NULL)
> -			return -ENOMEM;
> -
> -		sysfs_attr_init(&a->dev_attr.attr);
>  		ret = iio_get_channel_type(&st->channels[i], &type);
>  		if (ret < 0)
>  			return ret;
> @@ -170,36 +194,18 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  			return -EINVAL;
>  		}
>  
> -		a->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
> -						       "%s%d_input",
> -						       prefix, n);
> -		if (a->dev_attr.attr.name == NULL)
> -			return -ENOMEM;
> -
> -		a->dev_attr.show = iio_hwmon_read_val;
> -		a->dev_attr.attr.mode = 0444;
> -		a->index = i;
> -		st->attrs[attr++] = &a->dev_attr.attr;
> +		ret = add_device_attr(dev, st, iio_hwmon_read_val, i,
> +				      "%s%d_input", prefix, n);
> +		if (ret)
> +			return ret;
>  
>  		/* Let's see if we have a label... */
> -		if (iio_read_channel_label(&st->channels[i], buf) < 0)
> -			continue;
> -
> -		a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
> -		if (a == NULL)
> -			return -ENOMEM;
> -
> -		sysfs_attr_init(&a->dev_attr.attr);
> -		a->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
> -						       "%s%d_label",
> -						       prefix, n);
> -		if (!a->dev_attr.attr.name)
> -			return -ENOMEM;
> -
> -		a->dev_attr.show = iio_hwmon_read_label;
> -		a->dev_attr.attr.mode = 0444;
> -		a->index = i;
> -		st->attrs[attr++] = &a->dev_attr.attr;
> +		if (iio_read_channel_label(&st->channels[i], buf) >= 0) {
> +			ret = add_device_attr(dev, st, iio_hwmon_read_label,
> +					      i, "%s%d_label", prefix, n);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  
>  	devm_free_pages(dev, (unsigned long)buf);



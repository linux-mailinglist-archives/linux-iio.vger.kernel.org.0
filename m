Return-Path: <linux-iio+bounces-6682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B19B19128F6
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 17:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D5F1F27933
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 15:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6525551C42;
	Fri, 21 Jun 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi/UBviU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671D836AF8;
	Fri, 21 Jun 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982487; cv=none; b=aK8OPsWrkNLa8AtJRBpwRxyaA/FqxV6t5M6itDkjotpTbDW4SNyo46MXU3kI+bDaBq4KiBfCJQQ2Am8tK+4n+HzO80jSSPzXgGuoFr7AADufpuCom1AYWVv5SAYXPWLiBZNdQBxvo4EZ+BdTnHqOyirrYI3utskbD3j/NqtBpMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982487; c=relaxed/simple;
	bh=/LI1EFglHicmPa2b+tmq2lF6s3WfGiEfZxty5ZfKyLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwyxHutTypjVTYobsQMuXcoRPRGgwyJjkEAHISBQiUoooX8jRYiQYzCdj8AcpZ6Hd94AFeQAZhzknaLs+T/l2MGcGGxp17EtY6tvbwcT9AAcwMJV4Z9+YnUWPPSJIIv6cspqxTUMvDIpgtEtkzDXBHyUMC3Z0QyTI3wHEalxxA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi/UBviU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f44b5b9de6so17238905ad.3;
        Fri, 21 Jun 2024 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718982485; x=1719587285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XSsWDvdOrDlG0QQlpeHf9yq3prYXPh8BBfB8s0Jhz08=;
        b=Fi/UBviUIYjL9pOHwtuXUBMQVHF95yP+fj1xrNKepd2c5r7vn9IZgwvTcHEskM9yHO
         gMC4XY37TOUd7cU5hTR5jUYwEIGYu3Yys3UK1g2YBGOC+LDfYFyU0IBFx1Cejidz35Ok
         H599Y4QEP4sby17kitSyy7k9pwDyQItfPZSzVAqhVvj9ISPURoOxE5Ac9/qbXQEpz+Vn
         jLY/QyX1Ij9YjOa7lHm84TzyEVb1v4MMoSq1bWKPK2NAFbhtu6aduooAh9uEX8dEsCt1
         T9PKTX/6NPSm3sHYw7/kRwT6fijh8ctAHLCDmFNMHKKUuzcDw4NVzZQrr6Xgixl95E8S
         cHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718982485; x=1719587285;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSsWDvdOrDlG0QQlpeHf9yq3prYXPh8BBfB8s0Jhz08=;
        b=ObfJ4+Kml5BONWZDAHopQJe929dcIA7sSFIIJP54A3fGAjgq35SwSrOJd5HK++Ds6R
         PWoNuvHGLfHTMnom+hACIQDV7YEVqHO2xWYM4mTwx8g1ccYnW7gb06kRr9ENnnYQSY+i
         5f797vCcuC2qOSv9xGNFN0IWCuby8DZdJntqs2JVzEcRx8nzMZjKsw9mollDhzKbcXIh
         m9Ij8XrYRVDv7xYAPRUkoIdjSoKCN109LOXz8cW/2n16M3p4XgYKO8jfQz8w4OaWBB9S
         qOEklqXinf8B1is111zkZ5NFdB9eP254b0+P3FOu6Cb/iO2tKC8GITjcYCmGLx+z9ZR/
         4GcA==
X-Forwarded-Encrypted: i=1; AJvYcCU3BmtYWW/FZ4bbTqBxc/kjS+PmeRR6zZgPPmX0J95ZUc8U+OECBSXCYP533uaoCAKZaNzHir6IjvgUaS33dzcBD/k35AStQyrWzrN2PSvMvwm87beKfPSWMrmFvdtfw+W/43pqxFTUSWVFZKBds4qyYtLdRAVttBfFRQ0uDocX+iDbBF0=
X-Gm-Message-State: AOJu0YyKNoUaHLZjh3sYqCSry4QGFvkKRyk61K9qgEDQbbeo+D5QUrba
	k1tPqz1ZJnsICZQwHzn322nvwRsrwLXhC/XrqnzMy0hYpsZqmdgIaTMRRg==
X-Google-Smtp-Source: AGHT+IEDPdR9pwgNLL4ffmwfzlqgKtvurobbHggCk0ugfEB1/qFTgKUHlagUrSZGcFtxaNmFKZMPMQ==
X-Received: by 2002:a17:902:c401:b0:1f7:1b97:e911 with SMTP id d9443c01a7336-1f9aa3aef56mr98041305ad.2.1718982484372;
        Fri, 21 Jun 2024 08:08:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ed2sm15137195ad.155.2024.06.21.08.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 08:08:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0c74406c-291d-4b0f-935e-989fb2f870ce@roeck-us.net>
Date: Fri, 21 Jun 2024 08:08:01 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: iio: Add labels from IIO channels
To: Sean Anderson <sean.anderson@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
References: <20240620211310.820579-1-sean.anderson@linux.dev>
 <20240620211310.820579-3-sean.anderson@linux.dev>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240620211310.820579-3-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/24 14:13, Sean Anderson wrote:
> Add labels from IIO channels to our channels. This allows userspace to
> display more meaningful names instead of "in0" or "temp5".
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   drivers/hwmon/iio_hwmon.c | 33 ++++++++++++++++++++++++++++++---
>   1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> index 4c8a80847891..588b64c18e63 100644
> --- a/drivers/hwmon/iio_hwmon.c
> +++ b/drivers/hwmon/iio_hwmon.c
> @@ -33,6 +33,17 @@ struct iio_hwmon_state {
>   	struct attribute **attrs;
>   };
>   
> +static ssize_t iio_hwmon_read_label(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
> +	struct iio_hwmon_state *state = dev_get_drvdata(dev);
> +	struct iio_channel *chan = &state->channels[sattr->index];
> +
> +	return iio_read_channel_label(chan, buf);

This can return -EINVAL if there is no label. Since the label attribute
is created unconditionally, every affected system would end up with
lots of error messages when running the "sensors" command.
This is not acceptable.

Guenter

> +}
> +
>   /*
>    * Assumes that IIO and hwmon operate in the same base units.
>    * This is supposed to be true, but needs verification for
> @@ -90,12 +101,12 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>   
>   	st->channels = channels;
>   
> -	/* count how many attributes we have */
> +	/* count how many channels we have */
>   	while (st->channels[st->num_channels].indio_dev)
>   		st->num_channels++;
>   
>   	st->attrs = devm_kcalloc(dev,
> -				 st->num_channels + 1, sizeof(*st->attrs),
> +				 2 * st->num_channels + 1, sizeof(*st->attrs),
>   				 GFP_KERNEL);
>   	if (st->attrs == NULL)
>   		return -ENOMEM;
> @@ -147,7 +158,23 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>   		a->dev_attr.show = iio_hwmon_read_val;
>   		a->dev_attr.attr.mode = 0444;
>   		a->index = i;
> -		st->attrs[i] = &a->dev_attr.attr;
> +		st->attrs[2 * i] = &a->dev_attr.attr;
> +
> +		a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
> +		if (a == NULL)
> +			return -ENOMEM;
> +
> +		sysfs_attr_init(&a->dev_attr.attr);
> +		a->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
> +						       "%s%d_label",
> +						       prefix, n);
> +		if (!a->dev_attr.attr.name)
> +			return -ENOMEM;
> +
> +		a->dev_attr.show = iio_hwmon_read_label;
> +		a->dev_attr.attr.mode = 0444;
> +		a->index = i;
> +		st->attrs[2 * i + 1] = &a->dev_attr.attr;
>   	}
>   
>   	st->attr_group.attrs = st->attrs;



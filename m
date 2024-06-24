Return-Path: <linux-iio+bounces-6836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A760F9156A1
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 20:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954111C21197
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 18:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C045A224D1;
	Mon, 24 Jun 2024 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH848sXj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCFB107A0;
	Mon, 24 Jun 2024 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254865; cv=none; b=RW1+IBv5uFvsqWYk30J9zNVyWtAWN48SrGCtlnN+D+1YgyhZ5TDB2cmbJoUrd+eik4eDmbf5yHrIKu325B7dzXmnUQQ2ludtFzkgaNJ2lgWzMJruhrkyaMLrSUlnXhM6jQ9J1vlmEZlalYCpKsSBGspwT4AXhd7OLy42tb+ZWlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254865; c=relaxed/simple;
	bh=iSRiFadtGmfW5DinBrHg7lzX64qYBLqS8iUI82vKX44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCfm0zm1Wgc08c+o5fMI4dOVBP/RRyQkp5Nvw9wy9PYg95IAKD67VzGaWRn0feUTCJPmEXUpeo3MSrnFTODukwL+5cvbOqIeU4PoZg8HUyJFEWj6Ex3HmsDmCwHp7w8kB29T6tMmX/QfR/iZKxlOf743lGUm8v+GJPTnhtkp4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KH848sXj; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b9706c84e5so2638900eaf.1;
        Mon, 24 Jun 2024 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719254863; x=1719859663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SgFYgh/xElk+4fWUpR1t91Wn0xTw9rHNL06B0HuItYU=;
        b=KH848sXjcdozfe0gAostAiZIF0J0LsUzK07auX4CGjCWFm/jkq1Kc80hnvxdOxRfwp
         UGGYeE+MHFAaZM8Z3XzHGSXfbWwn54dXJuKAq6G2fg4sQLrC+qho/WKbPMuySpji9Wd/
         4XxeL2Dp6ezdh8AShYjlnNfofyGqz2cmpxoxMQwwhzEpavL63Sqv5WJtGB3VhJCo4GAY
         SvqqGk1Zw8rZiOXOZYtyBQcx3kp5DF5mLezc0E0qDaibYAP0BRTRDWZgnBpibPpnQDu3
         sjG3wDMzMlrLBGv/KFavzyg1kWR7RyzRwHcoWy86cs02J4KKERUiJ6VsJav4u4bb4bGS
         8ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719254863; x=1719859663;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgFYgh/xElk+4fWUpR1t91Wn0xTw9rHNL06B0HuItYU=;
        b=vcQO1pgKcYhJ14ZNPnOxl+XQLDZ2PvrUS7QyiDEFmTApuUk1h5APRYLvlnimziuuvU
         AC6PzLCouBE0TvfoBpDWfUScp5wIYZxjowg0Hw3sR4L+BPoidt/c4bWa56fuoP4LitnD
         0S/YCfFnwEyjshzYwJzWBKVK2AFjk9myHSCjxauKQoTjE1xIVqGhjdpwfEvd/8CpuT6V
         Nu0MuvkkTSeHnGu/q+txXonfBt920Ul55l92P6tvAXABTMpxR5K2IskpigN5TAGHy4sH
         NmzRvvjqgoAiW1+w93ESVDLEWm1zHxIS5FxwbQNYnrAdVBsgzvU0eqkEXctUIwm8NJ5b
         9LAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmBUeelJQ8MZlwhfD4d7qLsUJPKG8seEvXYleM9TmyFBbvzedcDKh5skvqdX2zmylHKQ2BE7Wrf0n0CpnQcfsmCitdHF07e2Dfq/ANiF2HFPX5XOZ/wpLq7F2fmAvVVWVQnJFP8tI=
X-Gm-Message-State: AOJu0Yy+dicSeKaydsk36MniPtNRcdG1NhV27C8VVe7PqnfB4p3AbKDD
	Rbc1oH8Una4M5PN8z6ZNM8O1IfuMeUB6Ki4Xqt++6Y5WZuoWc7h+hjw9bw==
X-Google-Smtp-Source: AGHT+IH3qGAzIZZqhyg+fbdWD7v0fLPcqvPul2GmQ7kiC7/GdvcJO7n1z86LFMIDJm7HkhUXeLG0Jw==
X-Received: by 2002:a05:6358:808a:b0:1a1:c718:d2db with SMTP id e5c5f4694b2df-1a23c1c5c64mr725394855d.27.1719254862799;
        Mon, 24 Jun 2024 11:47:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716baf4bedbsm5840324a12.76.2024.06.24.11.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 11:47:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ff43e01e-5a26-4b75-bfaa-ed3ad4395e7c@roeck-us.net>
Date: Mon, 24 Jun 2024 11:47:39 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: iio: Add labels from IIO channels
To: Sean Anderson <sean.anderson@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
References: <20240624174601.1527244-1-sean.anderson@linux.dev>
 <20240624174601.1527244-3-sean.anderson@linux.dev>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240624174601.1527244-3-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/24 10:46, Sean Anderson wrote:
> Add labels from IIO channels to our channels. This allows userspace to
> display more meaningful names instead of "in0" or "temp5".
> 
> Although lm-sensors gracefully handles errors when reading channel
> labels, the ABI says the label attribute
> 
>> Should only be created if the driver has hints about what this voltage
>> channel is being used for, and user-space doesn't.
> 
> Therefore, we test to see if the channel has a label before
> creating the attribute.
> 

FWIW, complaining about an ABI really does not belong into a commit
message. Maybe you and lm-sensors don't care about error returns when
reading a label, but there are other userspace applications which may
expect drivers to follow the ABI. Last time I checked, the basic rule
was still "Don't break userspace", and that doesn't mean "it's ok to
violate / break an ABI as long as no one notices".

> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - Check if the label exists before creating the attribute
> 
>   drivers/hwmon/iio_hwmon.c | 45 ++++++++++++++++++++++++++++++++++-----
>   1 file changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> index 4c8a80847891..5722cb9d81f9 100644
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
> +}
> +

I personally find it a bit kludgy that an in-kernel API would do a
sysfs write like this and expect a page-aligned buffer as parameter,
but since Jonathan is fine with it:

Acked-by: Guenter Roeck <linux@roeck-us.net>

Jonathan, please apply through your tree.

Thanks,
Guenter



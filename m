Return-Path: <linux-iio+bounces-13405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788A59EFACC
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 19:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA52C18969C3
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2446922913F;
	Thu, 12 Dec 2024 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Lo1ganxf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE129A9;
	Thu, 12 Dec 2024 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027351; cv=none; b=GOHV16TDd8TgmsmDIUM3nQAbUkTcUEHkivsIA/8KYGMwjiDRmRKGHty/KTkcQAV2ymbX7+qjWljozo37NrPrVdI01lm80D5+hZpV8ZTW1QgKB6/S1YfUfQl2CMZb3sYaE1BLb/+ZaQWkrnSPi87bynLMDyxcYS0chaBFORxnIjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027351; c=relaxed/simple;
	bh=NonqIIpR2rZqfuU/6o62PeGLSlzdLle31fGOi6fT5zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcfl/vYHRYWPbTPv2QsVfKy96uyJ0lOBC9jiIANAgIMkhFS+164LpypLvIxMVuBiHCnHZ4oWg5MYvV5QTl2rLDzxsjkXAmqG0DqpvUdfcsUPcb40JVKu2fzyVA19yhq5IEUD7HX9VAcG7v4Vi9EhLPlDRecBVnuIdsTY7cQNqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Lo1ganxf; arc=none smtp.client-ip=80.12.242.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Lnirtq7nnaH0QLnistCYQy; Thu, 12 Dec 2024 19:15:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1734027340;
	bh=CTi2UNElzpzeGsPWf9yWpV5Gm1O9oqnXVg6317n4Hhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Lo1ganxfVOLwGMLUOoC/RZqOizklywFG503w2dQXXbYAJxhSoKv2gOmte9/A5UCVP
	 OHXhKRuWV8St9+lAneGVDnzdN4JZpFdtwcFx5GnZyh2W+RzQWasRRrDRG5FHiGxewh
	 5gCHYCxmimVmIuSMunzVj+JOp8aFC7ntBdieHqFyRz6HFu5ZUJ1Q8ysSl6vjILZFzk
	 TlDlZwc16vHQGUTmTJsHQEWmHs5h4a/ZC2taawez3qwxPth8SEJ/eqLJr4sJ7IL2g/
	 zsoVVvX6E/v+ysellVnGS+rIVzDcnHKJxIMqVT3lNQCq7K1FABuEWYZJ2VUvJO3wy2
	 IrSrp1tGjKl4g==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 12 Dec 2024 19:15:40 +0100
X-ME-IP: 90.11.132.44
Message-ID: <e8564c63-0c2b-4327-8e39-767530b29b11@wanadoo.fr>
Date: Thu, 12 Dec 2024 19:15:37 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: light: as73211: fix channel handling in
 only-color triggered buffer
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Christian Eggers <ceggers@arri.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241212-iio_memset_scan_holes-v3-1-7f496b6f7222@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241212-iio_memset_scan_holes-v3-1-7f496b6f7222@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/12/2024 à 18:56, Javier Carrasco a écrit :
> The channel index is off by one unit if AS73211_SCAN_MASK_ALL is not
> set (optimized path for color channel readings), and it must be shifted
> instead of leaving an empty channel for the temperature when it is off.
> 
> Once the channel index is fixed, the uninitialized channel must be set
> to zero to avoid pushing uninitialized data.
> 
> Add available_scan_masks for all channels and only-color channels to let
> the IIO core demux and repack the enabled channels.
> 
> Cc: stable@vger.kernel.org
> Fixes: 403e5586b52e ("iio: light: as73211: New driver")
> Tested-by: Christian Eggers <ceggers@arri.de>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

...

> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index be0068081ebb..4be2e349a068 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -177,6 +177,12 @@ struct as73211_data {
>   	BIT(AS73211_SCAN_INDEX_TEMP) | \
>   	AS73211_SCAN_MASK_COLOR)
>   
> +static const unsigned long as73211_scan_masks[] = {
> +	AS73211_SCAN_MASK_ALL,
> +	AS73211_SCAN_MASK_COLOR,
> +	0,
> +};
> +
>   static const struct iio_chan_spec as73211_channels[] = {
>   	{
>   		.type = IIO_TEMP,
> @@ -672,9 +678,12 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
>   
>   		/* AS73211 starts reading at address 2 */

Should this comment be updated?

Or maybe moved close to "if (*indio_dev->active_scan_mask == 
AS73211_SCAN_MASK_ALL)" below?

>   		ret = i2c_master_recv(data->client,
> -				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
> +				(char *)&scan.chan[0], 3 * sizeof(scan.chan[0]));
>   		if (ret < 0)
>   			goto done;
> +
> +		/* Avoid pushing uninitialized data */
> +		scan.chan[3] = 0;
>   	}
>   
>   	if (data_result) {
> @@ -682,9 +691,15 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
>   		 * Saturate all channels (in case of overflows). Temperature channel
>   		 * is not affected by overflows.
>   		 */
> -		scan.chan[1] = cpu_to_le16(U16_MAX);
> -		scan.chan[2] = cpu_to_le16(U16_MAX);
> -		scan.chan[3] = cpu_to_le16(U16_MAX);
> +		if (*indio_dev->active_scan_mask == AS73211_SCAN_MASK_ALL) {

Should [0]...

> +			scan.chan[1] = cpu_to_le16(U16_MAX);
> +			scan.chan[2] = cpu_to_le16(U16_MAX);
> +			scan.chan[3] = cpu_to_le16(U16_MAX);
> +		} else {
> +			scan.chan[0] = cpu_to_le16(U16_MAX);
> +			scan.chan[1] = cpu_to_le16(U16_MAX);
> +			scan.chan[2] = cpu_to_le16(U16_MAX);

... and [3] be forced as-well?
(just a blind guess)

CJ

> +		}
>   	}
>   
>   	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
> @@ -758,6 +773,7 @@ static int as73211_probe(struct i2c_client *client)
>   	indio_dev->channels = data->spec_dev->channels;
>   	indio_dev->num_channels = data->spec_dev->num_channels;
>   	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->available_scan_masks = as73211_scan_masks;
>   
>   	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_OSR);
>   	if (ret < 0)
> 
> ---
> base-commit: 91e71d606356e50f238d7a87aacdee4abc427f07
> change-id: 20241123-iio_memset_scan_holes-a673833ef932
> 
> Best regards,



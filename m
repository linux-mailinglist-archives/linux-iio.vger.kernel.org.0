Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604B2383AD1
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 19:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbhEQRNa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 13:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235847AbhEQRN3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 May 2021 13:13:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ADCF61263;
        Mon, 17 May 2021 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621271532;
        bh=myekqU/aHMu+SNpPjDj6HSNb54sVhWc06AyYqeEhmNo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JuCpCfV6Yzo2MEVHxX3JPqBahyG2xLM+rVOy4JFtqvG7iy6jdEcgyXv0ksHRbkYKj
         eVYWePGxXWmLtp3JeJbkRO5hHqRV0BjFAHk/x+I08IcHPuwDt4Nve5g2ihCdLoI2k5
         qufBm5gcpz4F9pPy3M28Z4JM2qNH0OWOkUNRjvX+s8H60Ytf4SwLTBLfAX2ZLtIJEH
         msMsssNVN3cGDY1b9N/QTsIZ3cG8Gn9KBHhps++ZiyxQQ8OBXsMgsgjCTakgCwE2dN
         oOktwdyhIO3zmxeE+/3SvKsANM9C+J6bhLIQjVhM9zl30gpm6y1/iuzYPP+USe6mit
         EHGnp8r6NmpmQ==
Subject: Re: [PATCH 2/4] iio: light: si1133: Drop remaining uses of %hhx
 format string.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?Q?Maxime_Roussin-B=c3=a9langer?= 
        <maxime.roussinbelanger@gmail.com>
References: <20210517125554.1463156-1-jic23@kernel.org>
 <20210517125554.1463156-3-jic23@kernel.org>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <ec2a5309-bec8-adb8-61d8-d359e12fdb2f@kernel.org>
Date:   Mon, 17 May 2021 10:12:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517125554.1463156-3-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/17/2021 5:55 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Since:
> commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
> unnecessary %h[xudi] and %hh[xudi]")
> use of these format strings has been discouraged.
> 
> As there are not that many in IIO, this is part of an effort to clear
> them out so we don't have any instances that might get coppied into
> new drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
> Cc: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>   drivers/iio/light/si1133.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> index fd302480262b..0af36176907d 100644
> --- a/drivers/iio/light/si1133.c
> +++ b/drivers/iio/light/si1133.c
> @@ -352,22 +352,22 @@ static int si1133_parse_response_err(struct device *dev, u32 resp, u8 cmd)
>   
>   	switch (resp) {
>   	case SI1133_ERR_OUTPUT_BUFFER_OVERFLOW:
> -		dev_warn(dev, "Output buffer overflow: %#02hhx\n", cmd);
> +		dev_warn(dev, "Output buffer overflow: %#02x\n", cmd);
>   		return -EOVERFLOW;
>   	case SI1133_ERR_SATURATION_ADC_OR_OVERFLOW_ACCUMULATION:
> -		dev_warn(dev, "Saturation of the ADC or overflow of accumulation: %#02hhx\n",
> +		dev_warn(dev, "Saturation of the ADC or overflow of accumulation: %#02x\n",
>   			 cmd);
>   		return -EOVERFLOW;
>   	case SI1133_ERR_INVALID_LOCATION_CMD:
>   		dev_warn(dev,
> -			 "Parameter access to an invalid location: %#02hhx\n",
> +			 "Parameter access to an invalid location: %#02x\n",
>   			 cmd);
>   		return -EINVAL;
>   	case SI1133_ERR_INVALID_CMD:
> -		dev_warn(dev, "Invalid command %#02hhx\n", cmd);
> +		dev_warn(dev, "Invalid command %#02x\n", cmd);
>   		return -EINVAL;
>   	default:
> -		dev_warn(dev, "Unknown error %#02hhx\n", cmd);
> +		dev_warn(dev, "Unknown error %#02x\n", cmd);
>   		return -EINVAL;
>   	}
>   }
> @@ -400,7 +400,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
>   
>   	err = regmap_write(data->regmap, SI1133_REG_COMMAND, cmd);
>   	if (err) {
> -		dev_warn(dev, "Failed to write command %#02hhx, ret=%d\n", cmd,
> +		dev_warn(dev, "Failed to write command %#02x, ret=%d\n", cmd,
>   			 err);
>   		goto out;
>   	}
> @@ -425,7 +425,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
>   					       SI1133_CMD_TIMEOUT_MS * 1000);
>   		if (err) {
>   			dev_warn(dev,
> -				 "Failed to read command %#02hhx, ret=%d\n",
> +				 "Failed to read command %#02x, ret=%d\n",
>   				 cmd, err);
>   			goto out;
>   		}
> 


Return-Path: <linux-iio+bounces-10792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD39A9A4EB1
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 16:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084231C23147
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D19477F1B;
	Sat, 19 Oct 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB3ayMje"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CDE28F1;
	Sat, 19 Oct 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729348469; cv=none; b=XSz/Ikha7wlFO+ZzI73mcTFSDgbRJ2d/qJWNbZVPVCu4edyVhz7D5vbXWqRvHK9/KjN7zQlaY9TCv679wpDkfgJ4H1pPxeOY7GWeQVnDWjJa0DWbbfpSknOskm6G20vmfWaWhX8XmLGzNedIHoedsP6ERy27zzIMXUAHedZiHnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729348469; c=relaxed/simple;
	bh=EN2pJm8CsnqE5Nqnwx01B6lZEI8XjbHkYX+r0Te3o+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFJG0CJCLM9yOequaj7LVhbgnmtr46ILUcu5YNj+3Q3Ui2FVDL5t9OC9o2kX4xiEcbDDdtU+OOj4UWhvgZtbjtbqjVnkv6eW/21FtmLD/Dk8Jtc6NPjWoSFpH4RsFVuCxCV7WmNT/ycnICN2SMk8uugIQIJnzP8geFUB7V9weNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB3ayMje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49B9C4CEC5;
	Sat, 19 Oct 2024 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729348468;
	bh=EN2pJm8CsnqE5Nqnwx01B6lZEI8XjbHkYX+r0Te3o+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oB3ayMjeIakUXhrSgPyVyCClsu2ylGaxMtwmrpyhvBEOsijT6rP+ngZA+bE5aPyL8
	 DArGsFfCn3eh7tTPb8A2ew/Y4JnVSBjyL/USfA4KmAWIzzqHfsh4r2cHhaLZYJT1Rd
	 STXNir8WPdpoWjKQJtTgCVpyMlgCmRGVkfczQi8s26BYuwUZ1qdsxuHn3txT1Oe66B
	 dUmmSNh7JYQSUGwmnMWo9GBacvIXY2XuWEPKywqXglPQrEk1cf7N3q+GNwJrE8uqys
	 xEwBfpCWdUHNy04EDf6KN2AUiZvpAt0hIa/xNBcJ48WShFyAgHMot58SBOqwXG/k5l
	 r69JjaMj8sgCg==
Date: Sat, 19 Oct 2024 15:33:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: veml6030: fix microlux value calculation
Message-ID: <20241019153359.43f0c1af@jic23-huawei>
In-Reply-To: <20241016-veml6030-fix-processed-micro-v1-1-4a5644796437@gmail.com>
References: <20241016-veml6030-fix-processed-micro-v1-1-4a5644796437@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 19:04:31 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The raw value conversion to obtain a measurement in lux as
> INT_PLUS_MICRO does not calculate the decimal part properly to display
> it as micro (in this case microlux). It only calculates the module to
> obtain the decimal part from a resolution that is 10000 times the
> provided in the datasheet (0.5376 lux/cnt for the veml6030). The
> resulting value must still be multiplied by 100 to make it micro.
> 
> This bug was introduced with the original implementation of the driver.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
> I found this almost by chance while testing new supported devices. The
> decimal part was always suspiciously small, and when I compared samples
> to the expected value according to the datasheet, it became clear what was
> going on.
> 
> Example with a veml7700 (same resolution as the veml6030):
> 
> Resolution for gain = 1/8, IT = 100 ms: 0.5736 lux/cnt.
> 
> cat in_illuminance_raw in_illuminance_input
> 40
> 21.005040 -> wrong! 40 * 0.5736 is 21.504.
> 
> Tested with a veml6035 and a veml7700, the same will happen with the
> original veml6030, as the operation is identical for all devices.
> ---
>  drivers/iio/light/veml6030.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index d6f3b104b0e6..a0bf03e37df7 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -691,7 +691,7 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
>  			}
>  			if (mask == IIO_CHAN_INFO_PROCESSED) {
>  				*val = (reg * data->cur_resolution) / 10000;
> -				*val2 = (reg * data->cur_resolution) % 10000;
> +				*val2 = (reg * data->cur_resolution) % 10000 * 100;
>  				return IIO_VAL_INT_PLUS_MICRO;
>  			}
>  			*val = reg;
> 
> ---
> base-commit: 15e7d45e786a62a211dd0098fee7c57f84f8c681
> change-id: 20241016-veml6030-fix-processed-micro-616d00d555dc
> 
> Best regards,



Return-Path: <linux-iio+bounces-9843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEF098905C
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 18:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB38B215EA
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CBA136358;
	Sat, 28 Sep 2024 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYUkt3na"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095CD28DBC;
	Sat, 28 Sep 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540469; cv=none; b=Tz1wJGzKeoWDH8vKmo/CRY/hO00Egm4G4pLe/FkvK9ENSiuVuVW24e+uaEZ10hmc9xmcItEVuD8SNUxJQBswsbaV+zA87+Sg0ZGUp9WFglenjDZ1qmN2lAE7rAjWzd/ezjBiZGFp5GkkC4BvH7g884R6OUnLlQx9dlx+VmtysVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540469; c=relaxed/simple;
	bh=xPw92/uFCnLlTNJ6/zUt+W0GFuWqJf+auw4yd0flj3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SROpQ+DvDFPlhADR8C3BMN3/wdNKzkPCzimRgKoyUlZBM6mKHNZmBnSUoojNNxzgfYsNXr0YRZm/h0Ky7uY5G1sbJOijqG1slkQJv9XPY448ocubKRufYJ7WEkfXZcT3+A4Kk6/JvWWzLE1FYl6zczqWSSIeu3rGXbd6gVfuF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYUkt3na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701E0C4CEC7;
	Sat, 28 Sep 2024 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727540468;
	bh=xPw92/uFCnLlTNJ6/zUt+W0GFuWqJf+auw4yd0flj3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EYUkt3nauUlue9Bk6yKcOE4LYamMZU79dyhdcK33+7HKwNvN2yDg9cc/0TWkVD2Ep
	 gRqvPZVR+Ru5oRy61sYNnC6CMg1bEOLZ7OD2osJBwdMkFDXi7MB4IkZM0uNpL3nNJW
	 EIkTvG1ZI3LKyk7bPMCBsmXc7I3s1l5bE+zDU9VfpQZ9oUKyqndI94VBWjffOJZLSJ
	 2CasA6Fc9YOkVK/bD7OVu8V2HZWy32UD8BnfJjnXlBQf0oWLnaZsxaH742OjpV1iAw
	 ChWr3iiHaGu6NRSELCmTTtCp9U0qJzKRAy5QiQk0EIcSN8YSqiro4RH77364ldIObA
	 sqq0ZXBh2la/g==
Date: Sat, 28 Sep 2024 17:20:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 07/10] iio: light: veml6030: drop processed info for
 white channel
Message-ID: <20240928172059.3a7fa45d@jic23-huawei>
In-Reply-To: <20240923-veml6035-v2-7-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
	<20240923-veml6035-v2-7-58c72a0df31c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Sep 2024 00:17:55 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The resolution of the WHITE channel is not provided by the manufacturer,
> neither in the datasheet nor in the application note (even their
> proprietary application only processes the ALS channel, giving raw
> values for WHITE).
> 
> The current implementation assumes that both resolutions are identical,
> which is extremely unlikely, especially for photodiodes with different
> spectral responses.
> 
> Drop the processed information as it is meaningless.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Just to note, this one is fine as it is fixing an ABI bug
so is a valid reason to change the ABI.

In theory though we should pull it out as a fix to add to stable
as well, but it's low risk that anyone is using the 'false'
channel so I don't think we care about backports for this one.

Thanks,

Jonathan

> ---
>  drivers/iio/light/veml6030.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index a3190fab3add..861bdf2edd4d 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -209,8 +209,7 @@ static const struct iio_chan_spec veml6030_channels[] = {
>  		.channel = CH_WHITE,
>  		.modified = 1,
>  		.channel2 = IIO_MOD_LIGHT_BOTH,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -				BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
>  					       BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> @@ -549,11 +548,6 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
>  				dev_err(dev, "can't read white data %d\n", ret);
>  				return ret;
>  			}
> -			if (mask == IIO_CHAN_INFO_PROCESSED) {
> -				*val = (reg * data->cur_resolution) / 10000;
> -				*val2 = (reg * data->cur_resolution) % 10000;
> -				return IIO_VAL_INT_PLUS_MICRO;
> -			}
>  			*val = reg;
>  			return IIO_VAL_INT;
>  		default:
> 



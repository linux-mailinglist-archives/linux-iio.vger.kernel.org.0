Return-Path: <linux-iio+bounces-13501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BACF9F2450
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 15:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B330F16510D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 14:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FC418FC75;
	Sun, 15 Dec 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAe7lJvI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ABC1805A;
	Sun, 15 Dec 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734271952; cv=none; b=J4Ne8tQEMsy6Bi2sPliKSYdVHGVFLDcVp+bw4WO0NlFfrlKNIpi/cinpFKUfSVIFITTRZXCVjj6N0ig4sj/N5GWSWe6w+ZxhS3h8TXZN1+GEarbFb2frz9zPHstMtYkpCm+uNQp3LstRw0K3Ip17P6+75tCP/A7HV7ME7NORPmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734271952; c=relaxed/simple;
	bh=C+fkFXJDD2gYrYFFw7MKPSxt8fU/qG5ZsjWmCqJBbVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEGpzipsIwWVOyDIZOzSOhapMCQaCwrvQdLoQ2vJSiO8myy/I702ZzOLQBGvKwrx2ODfv5yNrmYt3MAddI/puK6vPWTF9J5dETd3UcYHrBuy50AQRCHZ9trw2CzQJxvkqTakR98fZloQB2BcVmtBgW8k64hhd979brUxCKoYGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAe7lJvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D11DC4CECE;
	Sun, 15 Dec 2024 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734271952;
	bh=C+fkFXJDD2gYrYFFw7MKPSxt8fU/qG5ZsjWmCqJBbVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LAe7lJvIofTgXqxh1euei5ekS910YOX364ZSpCIQvyatdW8PVGFkHxHUKuOy5repb
	 3YpWYjyeO7LdoL9O6qNd96iFTY59IoW9MzDLRehR/HAQjGlcN89/0t0Poq10jPG8aC
	 +x9xX55JZG5mvGNOxd4SoqTIiB8hhg4qiX/RnoowuAxBf/E29G0+aznCGpfDXak2gV
	 wQ2T9KIxkv6lid4iMsz/s7Scj224NLKC+MTQB0mwZEPjUQYYYt9OONNmnsDGTJD1NI
	 3XBRbplOauDuCCXOnarGu1XUQw5IbKx7JfQz4EGpMpHaHRS+rMUGLBbq8+3djAIGAa
	 X6FFA3v7SvWLA==
Date: Sun, 15 Dec 2024 14:12:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Christian Eggers
 <ceggers@arri.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v4] iio: light: as73211: fix channel handling in
 only-color triggered buffer
Message-ID: <20241215141226.31c81048@jic23-huawei>
In-Reply-To: <20241214-iio_memset_scan_holes-v4-1-260b395b8ed5@gmail.com>
References: <20241214-iio_memset_scan_holes-v4-1-260b395b8ed5@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Dec 2024 23:55:50 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

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
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
> This issue was found after attempting to make the same mistake for
> a driver I maintain, which was fortunately spotted by Jonathan [1].
> 
> Keeping old sensor values if the channel configuration changes is known
> and not considered an issue, which is also mentioned in [1], so it has
> not been addressed by this series. That keeps most of the drivers out
> of the way because they store the scan element in iio private data,
> which is kzalloc() allocated.
> 
> This series only addresses cases where uninitialized i.e. unknown data
> is pushed to the userspace, either due to holes in structs or
> uninitialized struct members/array elements.
> 
> While analyzing involved functions, I found and fixed some triviality
> (wrong function name) in the documentation of iio_dev_opaque.
> 
> Link: https://lore.kernel.org/linux-iio/20241123151634.303aa860@jic23-huawei/ [1]
> ---
> Changes in v4:
> - Fix as73211_scan_masks[] (first MASK_COLOR, then MASK_ALL, no comma
>   after 0 i.e. the last element).
> - Link to v3: https://lore.kernel.org/r/20241212-iio_memset_scan_holes-v3-1-7f496b6f7222@gmail.com
> 
> Changes in v3:
> - as73211.c: add available_scan_masks for all channels and only-color
>   channels to let the IIO core demux and repack the enabled channels.
> - Link to v2: https://lore.kernel.org/r/20241204-iio_memset_scan_holes-v2-0-3f941592a76d@gmail.com
> 
> Changes in v2:
> - as73211.c: shift channels if no temperature is available and
>   initialize chan[3] to zero.
> - Link to v1: https://lore.kernel.org/r/20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com
> ---
>  drivers/iio/light/as73211.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index be0068081ebb..11fbdcdd26d6 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -177,6 +177,12 @@ struct as73211_data {
>  	BIT(AS73211_SCAN_INDEX_TEMP) | \
>  	AS73211_SCAN_MASK_COLOR)
>  
> +static const unsigned long as73211_scan_masks[] = {
> +	AS73211_SCAN_MASK_COLOR,
> +	AS73211_SCAN_MASK_ALL,
> +	0
> +};
> +
>  static const struct iio_chan_spec as73211_channels[] = {
>  	{
>  		.type = IIO_TEMP,
> @@ -672,9 +678,12 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
>  
>  		/* AS73211 starts reading at address 2 */
>  		ret = i2c_master_recv(data->client,
> -				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
> +				(char *)&scan.chan[0], 3 * sizeof(scan.chan[0]));
>  		if (ret < 0)
>  			goto done;
> +
> +		/* Avoid pushing uninitialized data */
> +		scan.chan[3] = 0;
>  	}
>  
>  	if (data_result) {
> @@ -682,9 +691,15 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
>  		 * Saturate all channels (in case of overflows). Temperature channel
>  		 * is not affected by overflows.
>  		 */
> -		scan.chan[1] = cpu_to_le16(U16_MAX);
> -		scan.chan[2] = cpu_to_le16(U16_MAX);
> -		scan.chan[3] = cpu_to_le16(U16_MAX);
> +		if (*indio_dev->active_scan_mask == AS73211_SCAN_MASK_ALL) {
> +			scan.chan[1] = cpu_to_le16(U16_MAX);
> +			scan.chan[2] = cpu_to_le16(U16_MAX);
> +			scan.chan[3] = cpu_to_le16(U16_MAX);
> +		} else {
> +			scan.chan[0] = cpu_to_le16(U16_MAX);
> +			scan.chan[1] = cpu_to_le16(U16_MAX);
> +			scan.chan[2] = cpu_to_le16(U16_MAX);
> +		}
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
> @@ -758,6 +773,7 @@ static int as73211_probe(struct i2c_client *client)
>  	indio_dev->channels = data->spec_dev->channels;
>  	indio_dev->num_channels = data->spec_dev->num_channels;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->available_scan_masks = as73211_scan_masks;
>  
>  	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_OSR);
>  	if (ret < 0)
> 
> ---
> base-commit: 91e71d606356e50f238d7a87aacdee4abc427f07
> change-id: 20241123-iio_memset_scan_holes-a673833ef932
> 
> Best regards,



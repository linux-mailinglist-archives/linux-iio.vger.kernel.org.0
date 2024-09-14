Return-Path: <linux-iio+bounces-9573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E19791B7
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D323E282FCD
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2F1D049B;
	Sat, 14 Sep 2024 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaXKF4Lt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C871C1D0485;
	Sat, 14 Sep 2024 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726325948; cv=none; b=tFDnDmSR76N17COkuOS39sds85dWyAcdUSjvLKfmeZaHbvfQzCwYkbEp3Zv3NnqEXmOLEodYDiRNabeLQPBjl3Z3GfEzF9MQNGZbzG6G2EReYSG7WnWjssdixsmbGOq+a53m+KqBfkL03eUDAnuF0znHrT0ibBvKhYQiIDbSiJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726325948; c=relaxed/simple;
	bh=BM0vdAokoH9LRnEdS5/LERw/VHoYNi/1A54QAGYmytM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRi+C3yEf4kwhuxfB8D20qnAoC261Ru6HEoRxIVsOClbSAqVx4ZQFg4aqIxUEv42/HoPaCXmDopRhUiwrEb58lR9dJseqwcZ+jML3HxWsixQ5XIxE5a8zAhUbxAhFr/DOUfpB8k5fzyqzGXSGj0fTzXQ2crxRDsFjHXpaQrjn6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaXKF4Lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B530C4CEC0;
	Sat, 14 Sep 2024 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726325948;
	bh=BM0vdAokoH9LRnEdS5/LERw/VHoYNi/1A54QAGYmytM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aaXKF4LtfirhOma8Dr+B0womJCPdIhlJ6GTQsirBkexPvqVOTO0ZGaimMG13VKkwF
	 jvdi18Xh7akDB4XuDuOB0RUdnG14SWCN2f7Qu3pSUCqqGVsYvGR/aGv8BOT5ZXvGbn
	 HbSmOUQ9hdvqT+4qSOtAZbI9VhOQ64uO2NV3465vVHJ598sODgKFKSBAgJ8+FFXOAv
	 8bIChBFpj7xWfT61vcynoZwc85Hx/JuJlqOdm/vQvu2P81VlNd2hGh8N3q35/UhS+x
	 syKs76rpsIZuiHVMNa0NVUILDSlil3RDajpujGN9ph11TOnZx93WaZMQj5KxV65ZX1
	 hY5diuffqulUg==
Date: Sat, 14 Sep 2024 15:59:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6/7] iio: light: veml6030: add set up delay after any
 power on sequence
Message-ID: <20240914155902.38ec637b@jic23-huawei>
In-Reply-To: <20240913-veml6035-v1-6-0b09c0c90418@gmail.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
	<20240913-veml6035-v1-6-0b09c0c90418@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 15:19:01 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The veml6030 requires a delay of 4 ms after activating the sensor. That
> is done correctly during the hw initialization, but it's missing after
> resuming.
> 
> Move the delay to the power on function to make sure that it is always
> observerd.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/light/veml6030.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index d5add040d0b3..2945cc1db599 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -143,8 +143,17 @@ static const struct attribute_group veml6030_event_attr_group = {
>  
>  static int veml6030_als_pwr_on(struct veml6030_data *data)
>  {
> -	return regmap_clear_bits(data->regmap, VEML6030_REG_ALS_CONF,
> +	int ret;
> +
> +	ret =  regmap_clear_bits(data->regmap, VEML6030_REG_ALS_CONF,
>  				 VEML6030_ALS_SD);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait 4 ms to let processor & oscillator start correctly */
> +	usleep_range(4000, 4002);
There is no useful point in such a narrow range. Given you are moving
it let's tidy that up as well.

Just use fsleep() which will use a much wider range but is good enough.

Jonathan

> +
> +	return 0;
>  }
>  
>  static int veml6030_als_shut_down(struct veml6030_data *data)
> @@ -766,9 +775,6 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
>  		return ret;
>  	}
>  
> -	/* Wait 4 ms to let processor & oscillator start correctly */
> -	usleep_range(4000, 4002);
> -
>  	/* Clear stale interrupt status bits if any during start */
>  	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
>  	if (ret < 0) {
> 



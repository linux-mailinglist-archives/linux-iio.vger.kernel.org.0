Return-Path: <linux-iio+bounces-9840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CB9989045
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 18:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23271C21355
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7F41386D7;
	Sat, 28 Sep 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPAUV9QB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E15478E;
	Sat, 28 Sep 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540023; cv=none; b=dsGBEdHsQl9TBXQdpAVNdt0UJLI9RVKfx6RQOL4+fFbYUKlv4ls1h+WSjFWIt/l3hjJ1XWl9tesB2yBWLLrpKYzbTduM83ww1V+vUyw9Xcmfyp9QQ6sJOXi9ya2xljvV0QaFC+IYFkjbQHGco3SUY6g9Hed0adep3w5pxhWzZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540023; c=relaxed/simple;
	bh=d0p/6ot6XChhn4sksCiUYQeHLHOxQCofLU32imIixR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7cw1hDgtzHkJcGHSGOF4c6Yl9uCOft0vbeIypp5llEaaaLGrGVQQyLbqI5W7kuv+a7/AFUSl9xxOmHjkiDcd3uW2vgHgKg2U+MAuuROYwXzQ+ipK9BOdZg/Wz8E2woiXyHebaBjYbBYO4nueeFsQTAynOpU7cTwg+odO93yGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPAUV9QB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F60C4CEC3;
	Sat, 28 Sep 2024 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727540023;
	bh=d0p/6ot6XChhn4sksCiUYQeHLHOxQCofLU32imIixR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SPAUV9QBQT6mpwynps/kNy5nHVaV2TYxicBy4t25QG7OCbnbl5xTKz0ChcQElgt9/
	 7VHaEKYcrU/P0D8ZL0bhYPbQmCsLYITu4k4wdDaf5dd8/wyJZAF2MKC8Jf24QQko9/
	 R2Yw2APMyoB1qyDc48fLeAsjJfpoM9MlV12HWHKd60HANzl8trynUsRNYBVJFlewE2
	 9+Yfvnj8rTnD9iesv/j20BkLxwXvRUQvz74KwvIB3WruK8e8B3lJhkmgt/3LPbMDlg
	 WaXJyYQfeqoYzNS3+H9o4Z2S3NuFWYWL7MZLLvZ1snGgKDz6EkT+J5ccd5BtyMib4H
	 2JmLCytROCavg==
Date: Sat, 28 Sep 2024 17:13:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 02/10] iio: light: veml6030: add set up delay after
 any power on sequence
Message-ID: <20240928171334.37a6ee27@jic23-huawei>
In-Reply-To: <20240923-veml6035-v2-2-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
	<20240923-veml6035-v2-2-58c72a0df31c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Sep 2024 00:17:50 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The veml6030 requires a delay of 4 ms after activating the sensor. That
> is done correctly during the hw initialization, but it's missing after
> resuming.
> 
> Move the delay to the power on function to make sure that it is always
> observerd. When at it, use fsleep() instead of usleep_range() as such a
> narrow range is not required.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/light/veml6030.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index a3dfe56b7eec..e412a22474e0 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -144,8 +144,17 @@ static const struct attribute_group veml6030_event_attr_group = {
>  
>  static int veml6030_als_pwr_on(struct veml6030_data *data)
>  {
> -	return regmap_clear_bits(data->regmap, VEML6030_REG_ALS_CONF,
> +	int ret;
> +
> +	ret =  regmap_clear_bits(data->regmap, VEML6030_REG_ALS_CONF,

sneaky double space on the line above. Should just be 1.

>  				 VEML6030_ALS_SD);
Which will require this be indented by 1 less as well and hence
an extra line of apparent change.

> +	if (ret)
> +		return ret;
> +
> +	/* Wait 4 ms to let processor & oscillator start correctly */
> +	fsleep(4000);
> +
> +	return 0;
>  }
>  
>  static int veml6030_als_shut_down(struct veml6030_data *data)
> @@ -767,9 +776,6 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
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



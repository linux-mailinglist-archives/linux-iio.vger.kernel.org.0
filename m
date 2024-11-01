Return-Path: <linux-iio+bounces-11786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6C89B945A
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3378BB21552
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3BB1C68A6;
	Fri,  1 Nov 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbLYIlFF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C2C1B86F7;
	Fri,  1 Nov 2024 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474671; cv=none; b=uuDOYn8R0GiRXISdrwtnM1oa6ICAwPGx93Z/qT9DD7UiVEaAb9jkUxOHBy/itNhrh64a8chPNiWcynXVQ8jCEyBp4IU+PHnr3by8BNbMXrSZp8BQdVemb8nAb1qZT38NyYI7yl2SH6EvKlsMCKBP7sayPZFTKhwCKcSVpJIhlug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474671; c=relaxed/simple;
	bh=+S9uvFzfwYUkLPFmzbYaKSolz7QHTYLAlHRB4F/Jz5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fi0aNCtA9y/+oZCbgZnJo15Qw3QszB+rTHBrl0hRV9F0oTWJhzTP3yeoihLyxIHU3vo5ONOyzGjwgB41M9z4MbCOGRLo8IZu0Y7cGP6I2KNAKcQl0X/eLxUpPZQ18U5zL1HghaWCASGy1R8rKs/IuHP2M2/MJM1q9aaBOXK+Sxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbLYIlFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09812C4CECD;
	Fri,  1 Nov 2024 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730474670;
	bh=+S9uvFzfwYUkLPFmzbYaKSolz7QHTYLAlHRB4F/Jz5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RbLYIlFFlg+iCjVSQzBwXKClnwCAgt7P9vyJmV/U823clD0N4XffoPe1cS6ZzVeyC
	 uMO1t+r4fd8VfYK5YwsVoBknIANWta1Sp/5F+16I8zgWmEmvBI4xPBGTAfwJgPVLt6
	 tB2Z4mJ/+CsKiS1WTQ++jqXCYmnm+9c5aJRoc8WLFDoUiqY7o+WWkiCDEl9wi2Ok06
	 qfb7sPjV3sHUAk8QDJNuugeGetqhdo40Vy6nEm991dg8szKWPRkR0/HI0iPGadD4KU
	 ktrr8cjw+t+68y+mn9gYe4F2mPZDfXGsOlmaAXIODwMSc/XD/T6LofL/ENWvPlpgBn
	 vyfKy2yzKe/DA==
Date: Fri, 1 Nov 2024 15:24:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: adxl380: fix raw sample read
Message-ID: <20241101152423.7d3f4c94@jic23-huawei>
In-Reply-To: <20241101095202.20121-1-antoniu.miclaus@analog.com>
References: <20241101095202.20121-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 11:52:01 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The adxl380_read_chn function returns either a negative value in case an
> error occurs or the actual sample.
> 
> Check only for negative values after a channel is read.
> 
> Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
ouch. Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl380.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index f80527d899be..b19ee37df7f1 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -1181,7 +1181,7 @@ static int adxl380_read_raw(struct iio_dev *indio_dev,
>  
>  		ret = adxl380_read_chn(st, chan->address);
>  		iio_device_release_direct_mode(indio_dev);
> -		if (ret)
> +		if (ret < 0)
>  			return ret;
>  
>  		*val = sign_extend32(ret >> chan->scan_type.shift,



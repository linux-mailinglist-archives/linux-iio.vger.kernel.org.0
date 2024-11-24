Return-Path: <linux-iio+bounces-12595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A209D7716
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E598284013
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F113A86C;
	Sun, 24 Nov 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVf3kTTA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2ED6F2F3;
	Sun, 24 Nov 2024 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471388; cv=none; b=UWVwb0ZZc6u8kVaJQP3qCNyr8txjMofxyD7E+emLslaQKE6aLNZJoCRrcKzpUiYpzqi5WyS7gXwxboLDaXHL0OvSQh8VsDDNqKyzzhPwsf7UuRk5V1ezZKjKaEl9pcxM4yxYO7pezuzlg+vdbQ+OFkGTiz4jbl2XjVCpXf+2q1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471388; c=relaxed/simple;
	bh=fpsp84DIbTHppGuF3tLazQJegTXjuHnZfXtdUJcG7Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ilbi72CAhFni5E0IuKKf2a2LpSA9Rk0mdH2nWf4pbAXKy6+HS2N0qj1brBVVCGS18tMKlj/59fJNhFIRcHHezBfvx55dijdFo/GbaOj5UxYolHFgMOHeqrCNTwJdKKbX4bB2aHVRtjSImVj/Da73ZC1uL/vnQVS/+CqzqCgB5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVf3kTTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09965C4CECC;
	Sun, 24 Nov 2024 18:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732471387;
	bh=fpsp84DIbTHppGuF3tLazQJegTXjuHnZfXtdUJcG7Kw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gVf3kTTAHX8jOZxFe2FMHIoAeafYFih8ze5oOGZtl3H4eyUj1WdyIlRZHBNaQcs2k
	 6Eb4pJVl5xUIybrZ3ud824ZptrF1Ws7R/D8Gp9A2341Ak4OZTsl1rE12wdyH/2Upu2
	 +Sb3U6R5oARrPytbe6rI/JG1WG9uMF5n5Nw+exp51xZ0tGkmFL2fPfanYPIBGv3wxf
	 e2ezjwxhRxzR3LVrJEYdrrFTSiWQEsqWyQCL/5uef7p4MPDfSZxazYnW+k19cfHfHy
	 Z0ED2UbJiXrt17VTAkkDz0XztjTiS9tCol9u4y95jS0QGdNTi8xiInFIjHblzUNbx9
	 oJWzJYtt9BRqw==
Date: Sun, 24 Nov 2024 18:02:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 04/22] iio: accel: adxl345: rename to
 adxl34x_channels
Message-ID: <20241124180259.1178f22e@jic23-huawei>
In-Reply-To: <20241117182651.115056-5-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-5-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:33 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Rename the "adxl345_channels" to "adxl34x_channels". The driver
> supports several Analog accelerometers equally, e.g. adxl346 and
> adxl375.
As with previous a no to this.

We have a few drivers doing wild cards, but most are from before
I realised how often this goes wrong and started pretty strongly
insisting on naming after a single support part. It seems
so attractive, but ends up hurting us more than the confusion of
a single name applying to other parts as well.

Jonathan

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 30896555a4..2b62e79248 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -33,7 +33,7 @@ struct adxl34x_state {
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
>  }
>  
> -static const struct iio_chan_spec adxl345_channels[] = {
> +static const struct iio_chan_spec adxl34x_channels[] = {
>  	ADXL345_CHANNEL(0, X),
>  	ADXL345_CHANNEL(1, Y),
>  	ADXL345_CHANNEL(2, Z),
> @@ -203,8 +203,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->name = st->info->name;
>  	indio_dev->info = &adxl345_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = adxl345_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
> +	indio_dev->channels = adxl34x_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adxl34x_channels);
>  
>  	if (setup) {
>  		/* Perform optional initial bus specific configuration */



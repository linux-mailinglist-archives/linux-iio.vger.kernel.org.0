Return-Path: <linux-iio+bounces-12604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A979D77B8
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 20:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B90BB23910
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D533C7E765;
	Sun, 24 Nov 2024 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kslEHoLP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933BB2500AF;
	Sun, 24 Nov 2024 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732473253; cv=none; b=guOZHphW1GdCnuW9SV8lu3VLaM7d1TnDySgDbZdYaTzVOIwQxmAggCpv+TanX3pfkbKhTiNv8rNoRi+EbH4WwferpX7Z2qn2gMymMggr5Nr68AYe7r5xnioQRUf4Uw0OPgx+By9YBUjkaPvdLrE8IxcO2sX1VhFhnh9KHGFUioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732473253; c=relaxed/simple;
	bh=fvPo6IPSTku4fpZN+SQNNK5hr8bBPTZJf14FIHbm1Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfoF7VcY3dlPMXDQ8McJGHxStAB8qjYiOC28PWDSVr6J1hxqEASbdDWYgwCcxNZrcBBLstd9nn+8iKSdclVadENc8BcP85jw6BreQEHgRVOY55l+yC8BpDNQMApBbat7XAj3Xh+ZzFxOjZtagFf7MsRryCxBid1Ccv1baRS1SrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kslEHoLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740B0C4CECC;
	Sun, 24 Nov 2024 18:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732473253;
	bh=fvPo6IPSTku4fpZN+SQNNK5hr8bBPTZJf14FIHbm1Jk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kslEHoLPjA0b1qXeBx6/VPMorep/DurS2ECjIinQeInqzZr0LbDMcaKxNaej7bC45
	 jOqy9rF5PV+qZGGgaWj/TP3QVpN8A6fpY5FXzgX+yegUGWjSvXQPFxyHsPx0fJ2RtP
	 n4Oegzzp0CPMaiRbs/v32WWSkecJ8twne9M3dIIKKoE97wRPvuvKhPtS5HGCS9f8AS
	 FUiMVvyMoXpleV/SoRTA5YDu7njH3hp1TMlgIprSt0QwtJMyMjJZeVT5oIl2pUPgvR
	 LcCjXI9Deiq2XIvBVL/+myYpAAuR2z57pka6rSMlQBLvqTmm1P7Y/cLpUc3tQzehhI
	 zuKb91Pg1OaRg==
Date: Sun, 24 Nov 2024 18:34:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 12/22] iio: accel: adxl345: elaborate iio channel
 definition
Message-ID: <20241124183406.74861fef@jic23-huawei>
In-Reply-To: <20241117182651.115056-13-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-13-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:41 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Make the channel definition ready to allow for feature implementation
> for this accelerometer sensor.

Add what you need for each patch that makes use of the new data.
A separate change like this is not easy to review without seeing those
usecases and a reviewer should not need to go look for them in other
patches.

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 36 +++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index b16887ec1c..f98ddef4c5 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -141,21 +141,33 @@ struct adxl34x_state {
>  	u8 intio;
>  };
>  
> -#define ADXL345_CHANNEL(index, axis) {					\
> -	.type = IIO_ACCEL,						\
> -	.modified = 1,							\
> -	.channel2 = IIO_MOD_##axis,					\
> -	.address = index,						\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> -		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
> +#define ADXL34x_CHANNEL(index, reg, axis) {				\
> +		.type = IIO_ACCEL,					\

No reason to change the indentation.
That just makes this patch hard to read as I can't immeidately see what changed.

> +			.address = (reg),				\
> +			.modified = 1,					\
> +			.channel2 = IIO_MOD_##axis,			\
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
> +			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +			.scan_index = (index),				\
> +			.scan_type = {					\
Bring the scan stuff in as part of a patch that makes use of it. Not
beofre that.

> +				.sign = 's',				\
> +				.realbits = 13,				\
> +				.storagebits = 16,			\
> +				.shift = 0,				\
> +				.endianness = IIO_LE,			\
> +			},						\
>  }
>  
> +enum adxl34x_chans {
> +	chan_x, chan_y, chan_z,
> +};
> +
>  static const struct iio_chan_spec adxl34x_channels[] = {
> -	ADXL345_CHANNEL(0, X),
> -	ADXL345_CHANNEL(1, Y),
> -	ADXL345_CHANNEL(2, Z),
> +	ADXL34x_CHANNEL(0, chan_x, X),
> +	ADXL34x_CHANNEL(1, chan_y, Y),
> +	ADXL34x_CHANNEL(2, chan_z, Z),
>  };
>  
>  static int adxl345_read_raw(struct iio_dev *indio_dev,



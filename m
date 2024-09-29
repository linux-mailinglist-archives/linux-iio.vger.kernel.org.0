Return-Path: <linux-iio+bounces-9885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC6398964F
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 18:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676881C2110C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDA017BB11;
	Sun, 29 Sep 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5Nye+fm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A8379FD;
	Sun, 29 Sep 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727628672; cv=none; b=mQj8m7n+CVb0Ds8KN/MziAC/q/NhIwKy9+e7JWLqBsnzedAwtZTeOZQTwI65ATsQCJ8j3KT6nBR8tPAzKlJS5pnjVGvnfPtqd+/qDAz/DN1KcOimpPKAdEyxW2XYKA1fwVNhylskHDoyv7jgkpPsLoa9iBIRtfQ3RKbh3i26h00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727628672; c=relaxed/simple;
	bh=sHQCx2Ka3Wx8zcULuOaKllEgdbSzhbBr20aENOKAsVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrDMUX4tzqC93jmv4G8QjY8AYCrEbZZK9PGQ++o2oGgXvI69FRgH34nSWhCDUOFol2cAHmyQx6blO3nk6MutoHEKtoeZf4T/ezwK2+mBS2eJo7tURJ91GZ6rGXqG4gv0fOOiuRQHmrQblIiFcqfy65Cnd1J8nWT3eXnJckuXcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5Nye+fm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FEAC4CEC5;
	Sun, 29 Sep 2024 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727628672;
	bh=sHQCx2Ka3Wx8zcULuOaKllEgdbSzhbBr20aENOKAsVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h5Nye+fm7/xvXsinAtGgWobYIPU7JaGzAOx3nt0hEXZ5YDB+vuf63/VdIZkGZo5M3
	 +5BMBLQGSJNyinAiDwR/TbCRE4KxXPhZukEi7DP3Vx+8khqM74uyFuFdRa52CpOepm
	 fAM4QkE0f8PAaHvEoOxwmoelkQUgSpbDpJkRqSP29DuOboBKHMAUmUrDFlltYiEwG2
	 7TyFkW+iVG8DGwYePxU/VybavlMCciBA47xKnuUdAp9yqNWsbIHc6O2mw0YCCmS0sb
	 IjaMx1G1cjwEonKWD+lRM+4Ij90g6L8DamKrjr/Og//WMDIml1W2udn4GeeYh6ZL21
	 erfgqq76IYCng==
Date: Sun, 29 Sep 2024 17:51:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
 lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad5770r: Convert to get_unaligned_le16
Message-ID: <20240929175105.7d05b0dd@jic23-huawei>
In-Reply-To: <20240928161805.165543-1-abhashkumarjha123@gmail.com>
References: <20240928161805.165543-1-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Sep 2024 21:48:05 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Convert the manual shifting to use `get_unaligned_le16` api.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
Looks straight forward so I've applied this, but plenty of time for
additional reviews if anyone has time to take a look.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5770r.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
> index c360ebf52..12c98f3e6 100644
> --- a/drivers/iio/dac/ad5770r.c
> +++ b/drivers/iio/dac/ad5770r.c
> @@ -17,6 +17,7 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> +#include <asm/unaligned.h>
>  
>  #define ADI_SPI_IF_CONFIG_A		0x00
>  #define ADI_SPI_IF_CONFIG_B		0x01
> @@ -325,7 +326,7 @@ static int ad5770r_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return 0;
>  
> -		buf16 = st->transf_buf[0] + (st->transf_buf[1] << 8);
> +		buf16 = get_unaligned_le16(st->transf_buf);
>  		*val = buf16 >> 2;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:



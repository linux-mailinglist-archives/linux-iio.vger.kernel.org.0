Return-Path: <linux-iio+bounces-10786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912BF9A4E8A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 16:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2F01C214EA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC138FAD;
	Sat, 19 Oct 2024 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJOK5MCu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4825328EF;
	Sat, 19 Oct 2024 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729347244; cv=none; b=lgA+lVjtGY2pYVyn94o9hP4w4pYOyJtPNSEOgemHDWAJSrGbTxNfUrbAU6O2ggr+g6yWgEkduXP0SELcJgJ2ZtTEriic+DWoLo7gfbAstneZ/MVgvjAFPSH5+D40+Iqh+qf91koHkjpsR5Wi0CwG8oArohNCm/CY+Tx7bu03f6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729347244; c=relaxed/simple;
	bh=/YJl37u3gb3ecEanff2bjSph5gRr1jPvWS/wj+kZ9q4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRdr4vM90XOkpcrVf1GcaBpQY7yGAiXf4u+YlWvexCILcP27dSLFLJDz04YNE9cFytanULrlOaDhRYuXZt3OfnSdWCkbCyZZ9Aj5e1OFcRiRHloKFdK9dfQUxsA9G4bRqR7P9UJE2vNheiaT9AzWMx8AdptMezESBEIIXUSyQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJOK5MCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA69C4CEC5;
	Sat, 19 Oct 2024 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729347243;
	bh=/YJl37u3gb3ecEanff2bjSph5gRr1jPvWS/wj+kZ9q4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PJOK5MCuq81Fzh3S2E4zUpwptLihRWgb5qRhugJY1xYzlDxrciLg3c3RAZS56kkac
	 rJxVks/RuKKG4+KMozWI/8IwbfCR8KxXmJTrYhr4uTxN9j3IH0isJPPHuyNbeiXyUL
	 08ST0+8HGmUJd2C0PyT5ituXxYNPESjG+obW7tTqxZJHfN8akl6BJp6vCA5y8CYwjp
	 g3r9MwIUzqx0hWkkHsHvOoPp8/Oxfp9XarspMSJjTxoSDzsVkjgMFu0JHvp+IZX8z4
	 0BGS7R+n5X7X7qTojd+jtkt/y9Gahe14GekUPTFuKVY/UbcmzVaqXiF8ex14GMNtIU
	 ysFUCM814Q3mQ==
Date: Sat, 19 Oct 2024 15:13:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, ricardo@marliere.net,
 skhan@linuxfoundation.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: list adis16137 in Kconfig description
Message-ID: <20241019151339.553ee396@jic23-huawei>
In-Reply-To: <20241019034213.429464-1-0xff07@gmail.com>
References: <20241019034213.429464-1-0xff07@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Oct 2024 11:42:05 +0800
"Yo-Jung (Leo) Lin" <0xff07@gmail.com> wrote:

> The adis16136 driver also supports the adis16137 model, but it is not
> mentioned in the Kconfig help. Add it to the description in Kconfig.
> 
> Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
Applied.
> ---
>  drivers/iio/gyro/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index 97b86c4a53a6..3e193ee0fb61 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -27,7 +27,7 @@ config ADIS16136
>  	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
>  	help
>  	  Say yes here to build support for the Analog Devices ADIS16133, ADIS16135,
> -	  ADIS16136 gyroscope devices.
> +	  ADIS16136, ADIS16137 gyroscope devices.
>  
>  config ADIS16260
>  	tristate "Analog Devices ADIS16260 Digital Gyroscope Sensor SPI driver"



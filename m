Return-Path: <linux-iio+bounces-15963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20165A40A18
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E72017F5DB
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EE61FF1C2;
	Sat, 22 Feb 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIGzufvG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D06113C81B;
	Sat, 22 Feb 2025 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242278; cv=none; b=q21hGzBa8xrhFYsnpjR15glZQ9gb24EvGFBO0fT4a8dt+vVtaAfuIEz9Yi86YAlj1+LdI9VVBA4RU7T33dm3HrTnASbHCx1GXjRqqPlvo4uOLOEnFwSlTt2Rbo3ZJdaHerRJUuPs00jw1GfzkOt+4W5ArCGQVoWuBNvo+iUWZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242278; c=relaxed/simple;
	bh=UVtI9FKhq6xNIoP2diOooo/tNDKOY5lvDO738ZKQZU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSs6b094Hc3Lo4emzgslNXTi58JU5DMS4q3YuSyjnFShKqOCXZbWMAEIOQQ5Lu/dNyF0RIaWYdy2jqv6RXjDunv/OpPWxGv+Q+mohDdEvATyqAPuy0V547TD1XgEq7l929f5o2z8VlWzkpkMQb4M8arrAkEDPFrKhnkfoBak4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIGzufvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC79C4CED1;
	Sat, 22 Feb 2025 16:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740242277;
	bh=UVtI9FKhq6xNIoP2diOooo/tNDKOY5lvDO738ZKQZU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OIGzufvGo+L+ucJlP/R2ikGkydzv8U8kUWnVmjCzaB5ZB1hkY7TPowKZFEx7poEMN
	 p2wVAoXe83Ei2CYMby9WLWpI8hCmzRU/4Yxlh5GHNUNhYwslCpUm1j6euzX6rrl1GC
	 xFjxnWkPTC4sygck/IdzTepgGpRAcqN82UqxzuYkNmEZs0f7fwhhp+3K51VOfJjNvp
	 SZ+BMMkhhgBuaU4F4bqD6kLbXDra1ZAIbwxpVPu7UI/ChIAXMjdxtM3MgD4mxYxvMA
	 Q3CzanwzG5sMsyw2RR5LEeia7wcoHaUkAxkMGNp0iZOEpr4F1D792Zt6u7rNo5jTow
	 /THMh3deoKjUw==
Date: Sat, 22 Feb 2025 16:37:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: gyro: bmg160_spi: add of_match_table
Message-ID: <20250222163752.5eb0d694@jic23-huawei>
In-Reply-To: <20250220165001.273325-2-jerrysteve1101@gmail.com>
References: <20250220165001.273325-1-jerrysteve1101@gmail.com>
	<20250220165001.273325-2-jerrysteve1101@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 00:50:00 +0800
Jun Yan <jerrysteve1101@gmail.com> wrote:

> Add of_match_table to bmg160_spi driver.
> 
> This fixes automatic driver loading by userspace
> When using the device tree and the driver is built
> as a module, devices can be probed.
Wrap patch descriptions at 75 chars as mentioned in submitting-patches.rst

> 
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Hi.

The patch content is fine, but I'm doubtful about the autoloading.
Did you actually try this and see a failure without this patch?

For SPI autoloading even with device tree compatibles should work without
the of_match_table though it will match against the compatible without
the bosch, part.  Maybe I missed a change that means that no longer
works.

I in general don't mind the actual change because it does ensure
we have the manufacturer in the match as well so makes future
problems less likely.

Jonathan



> ---
>  drivers/iio/gyro/bmg160_spi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
> index fc2e453527b9..ac04b3b1b554 100644
> --- a/drivers/iio/gyro/bmg160_spi.c
> +++ b/drivers/iio/gyro/bmg160_spi.c
> @@ -41,9 +41,19 @@ static const struct spi_device_id bmg160_spi_id[] = {
>  
>  MODULE_DEVICE_TABLE(spi, bmg160_spi_id);
>  
> +static const struct of_device_id bmg160_of_match[] = {
> +	{ .compatible = "bosch,bmg160" },
> +	{ .compatible = "bosch,bmi055_gyro" },
> +	{ .compatible = "bosch,bmi088_gyro" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, bmg160_of_match);
> +
>  static struct spi_driver bmg160_spi_driver = {
>  	.driver = {
>  		.name	= "bmg160_spi",
> +		.of_match_table = bmg160_of_match,
>  		.pm	= &bmg160_pm_ops,
>  	},
>  	.probe		= bmg160_spi_probe,



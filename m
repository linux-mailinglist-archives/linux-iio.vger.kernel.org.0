Return-Path: <linux-iio+bounces-9920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F38989D84
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 11:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EC3286C4F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 09:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA09185B48;
	Mon, 30 Sep 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r36v9jij"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702A5183CA4;
	Mon, 30 Sep 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686853; cv=none; b=V4bzWLW7UUv5Jt35G/5KLFFIyqkg2JYHQ7FPkaPfMuCmnEReVKMSe+Q4bX8UPxZNukXKHn7JnZLZPbE/5IzgXRnHgY3O9UWXHVo5DiCm/BV9uusMtfP91K2QFsxkpi5nWhizA6XTAijQk+sdCVHLnoSCyho69wstCNey7w3My+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686853; c=relaxed/simple;
	bh=R/G0ZXf1QhcUH/f5dLniyKLj7szWbspzo4CnQ0uKYZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0Xj2T0zcf5d8S7HYXzketUZQQNq/gqvio5CTEMJYfrtF1pvKt6hj8WHQeLnISnY6WygGBIXBLeXOwX2g22pORBwMckdV2biTQKvnnUG7Anikj9/GWYqQrGygeoa8tsCALplSY+rRE162kRNlTk400BQi5dyzkVmRh/UqfMSIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r36v9jij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E05C4CEC7;
	Mon, 30 Sep 2024 09:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727686853;
	bh=R/G0ZXf1QhcUH/f5dLniyKLj7szWbspzo4CnQ0uKYZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r36v9jij4zIKQOmoLdOH5m5lxe0+Cz2i2DtaehQPg1TFq9th9kb1PEPXhN71i4V+W
	 BRCLp3zyeCl6n+F4PFSlxqe80O4PlxkAwYaCP3jGgGd+I9vsvCf+hBoQdIHSKsTiMf
	 +1Ft49biWU84e0ZEdcaw5//5VgxpKu2rdZqA0PN4pqWXwAyUuv6btUvw+kD5N/MJLm
	 pApm4y0giBNk/8WaqQ8H5xZ2EPf/LMZdD6ZG2wGbcSjK3jH3YzFObIjM/5n/LEnvds
	 a7R5XRdlX5hLr3tn67kCxiqnPhryWN08V5FkssRuDviL0a9UvSK9dtlUX3JTaTS3YR
	 H4vQWGTbYuVBQ==
Date: Mon, 30 Sep 2024 10:00:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 6/7] iio: light: veml6070: add devicetree support
Message-ID: <20240930100044.5770bb94@jic23-huawei>
In-Reply-To: <20240929-veml6070-cleanup-v1-6-a9350341a646@gmail.com>
References: <20240929-veml6070-cleanup-v1-0-a9350341a646@gmail.com>
	<20240929-veml6070-cleanup-v1-6-a9350341a646@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Sep 2024 22:38:51 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Register the compatible from the dt-bindings.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/light/veml6070.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
> index faba04e1da98..8d02899028d8 100644
> --- a/drivers/iio/light/veml6070.c
> +++ b/drivers/iio/light/veml6070.c
> @@ -192,9 +192,16 @@ static const struct i2c_device_id veml6070_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, veml6070_id);
>  
> +static const struct of_device_id veml6070_of_match[] = {
> +	{ .compatible = "vishay,veml6070" },
> +	{}
I tweaked this to { }

> +};
> +MODULE_DEVICE_TABLE(of, veml6070_of_match);
> +
>  static struct i2c_driver veml6070_driver = {
>  	.driver = {
>  		.name   = VEML6070_DRV_NAME,
> +		.of_match_table = veml6070_of_match,
>  	},
>  	.probe = veml6070_probe,
>  	.id_table = veml6070_id,
> 



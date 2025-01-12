Return-Path: <linux-iio+bounces-14161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC5CA0A860
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C35B3A1210
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456791A83FF;
	Sun, 12 Jan 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLe5+z74"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33E91A2C11;
	Sun, 12 Jan 2025 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736678781; cv=none; b=BY8Q+/W13r2BQ25TxriKaxjf3kuYSqtsMXSJ9gel9Umezj10M32iSRa3UKgXYtndYjgEGnzTHOnTp66IIs8KE1imAwmnlp5Z2C8dd6kNFac+b7xrc/jDFNZpQ25gJ3A07LaZ+8g5lIjlSN0VXp/q0GAfsFAUKY5X7jr/XT+XEi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736678781; c=relaxed/simple;
	bh=/943GGFj9VJ4OrmlGSTxiskek4n3xJ9mI+3NSb92xcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtNPwZQeCJhKfRIGyXjZdn3zPiYg0fqmYV/4Ol7jbGj8f8GG6Kugj/Es9bfjXLa5kn2CQkJGba2Wu1yef6grCT1+1gBLOmDbvHUvFhrv3iGVDDwvvDFwjY9vfujJAD4lwHV5cb47otaF3BQcItL96OTgn5xU16YVCr/ObghbDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLe5+z74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B043C4CEDF;
	Sun, 12 Jan 2025 10:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736678780;
	bh=/943GGFj9VJ4OrmlGSTxiskek4n3xJ9mI+3NSb92xcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iLe5+z74/A2/cwrmzphgtewFv058SfWLNufuWb0ez+JL1tue1com7YWXUogzzPiIV
	 hGzOGLiA9xy8gw8dbX/K+J58kfdo/Rh2XxkrMc4JUqjHqTzbLn59Fb0dG32v8wFGYS
	 xcZ940+Eyr7jirp2mY1EAqU377CN2o1z8/Q2yoyvcA6UeRfQ9dRj+hZkG0Pm6ltUvp
	 oF29q0IIPpBOpyzV7iVaFLeoQRsymKnufOZozyDc+x5v+mwSc5Uf9Z+pSoN7zVMVCl
	 cse9umLejYFVVDQxyCefHRxsvKUmtDBmx9zU/bKlTAEPfLrU/LD1/0G6GAF0qJpkUN
	 CMQYO+UJEB0bQ==
Date: Sun, 12 Jan 2025 10:46:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasiliy Doylov via B4 Relay
 <devnull+nekodevelopper.gmail.com@kernel.org>
Cc: nekodevelopper@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: accel: mc3230: add OF match table
Message-ID: <20250112104611.09fc756b@jic23-huawei>
In-Reply-To: <20250111-mainlining-mc3510c-v1-2-57be503addf8@gmail.com>
References: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
	<20250111-mainlining-mc3510c-v1-2-57be503addf8@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 23:11:07 +0300
Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org> wrote:

> From: Vasiliy Doylov <nekodevelopper@gmail.com>
> 
> This will make the driver probe-able via device-tree.

Why is it not today?  I2C has fallbacks to match against
the compatible with the vendor prefix stripped off.
For module autoprobing it will fall back to the driver name.
So are you actually seeing a problem probing this in a DT
set up?

I'm not against the change, which I think reflects best practice
as there may be mc3230 devices from other vendors with different
intended drivers.

Jonathan
 

> While the I2C match table may be sufficient, this should extend the cover
> of this driver being probed by other methods.
> 
> Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> ---
>  drivers/iio/accel/mc3230.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index 48787c0494ae6f0ef1d4d22bc5a4608035cbe123..3cad6f2d7a2a79df38f90e5656763f6ed019a920 100644
> --- a/drivers/iio/accel/mc3230.c
> +++ b/drivers/iio/accel/mc3230.c
> @@ -205,10 +205,17 @@ static const struct i2c_device_id mc3230_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
>  
> +static const struct of_device_id mc3230_of_match[] = {
> +	{ .compatible = "mcube,mc3230" },
> +	{ },
Better to have no comma after a terminating entry. We should
not make it easy for people to add stuff after this (as it
makes no sense if they do!)

Jonathan

> +};
> +MODULE_DEVICE_TABLE(of, mc3230_of_match);
> +
>  static struct i2c_driver mc3230_driver = {
>  	.driver = {
>  		.name = "mc3230",
>  		.pm = pm_sleep_ptr(&mc3230_pm_ops),
> +		.of_match_table = mc3230_of_match,
>  	},
>  	.probe		= mc3230_probe,
>  	.remove		= mc3230_remove,
> 



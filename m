Return-Path: <linux-iio+bounces-14262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB56A0B1B8
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 09:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08857A12C9
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3F0237A2E;
	Mon, 13 Jan 2025 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBd6+3Dw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4418A6CF;
	Mon, 13 Jan 2025 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758295; cv=none; b=EfS6ehjgSEnAtX4w3r5yQzH2diNt+wQDlonuvGNHNKaIL/FEOODIZwudx52eNrQ/7QxyaN0egJG3B0cxsZZ7wN6KSU0CJvbA6+w4pFKA89VziX3xhVmoGlIAwWmKO768jEUsnNp9SQTawWRRsr5JcEJZfy2vdLUG+tkEMKiPlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758295; c=relaxed/simple;
	bh=9SoAbRULM6il/pg6S9gS6s4vZ0nQF38qFOViRtUf9wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gzzc80pQqOuKcb2JpdY32xbjygZIsBItEn1UEvp3CvzGa9dw9smUy0TLIY9fWKm9A7qwT+FwN+eYtx9PNq4Ph/rjA7CFQ7nvxUh8KaBM+QllkmgAEBHOnlNJZosn5M0o77KdgSI69PP94MnXTGyFn5sXfqnbF9uq44j4j777ATg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBd6+3Dw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E15CC4CED6;
	Mon, 13 Jan 2025 08:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736758295;
	bh=9SoAbRULM6il/pg6S9gS6s4vZ0nQF38qFOViRtUf9wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBd6+3Dwnlln5dc/wxB4s4CIp0jRtbfSxEFkSxsJ2NcuUMOTBRh/m47aphHZR02wh
	 yuIFh6GPUcBjWVlzJTqtKcP+olLIaqV00HZKsF7ctz8q9c4wJmV3uFWW3QVQgbJbhg
	 6Ntmefk0/YsIPzoMkzG0kGiXWCohoWYczF62J04Kp5xVHo5FhFgK2D6J9V4qxeDvlA
	 32RvhRcI93Yw8cz8TjQ12bmAZgPiqAu0Mc0zg2ypaIjPjORfoa87dkf9V9zagOk7KP
	 9N1LbXngl9PJoBhnP7z8eCPmalvTcYKPEO4Vs98Bw/e3MyTCQdpKzWdXzi4mCuiHTS
	 I/fcctOaQrmPg==
Date: Mon, 13 Jan 2025 09:51:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasiliy Doylov <nekodevelopper@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/5] iio: accel: mc3230: add multiple devices support
Message-ID: <g7itkz3xnthnt6ipn6gtcommhwrabup3ttflhar5td27qvmfyb@nxa4x4eqtrrs>
References: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
 <20250112-mainlining-mc3510c-v3-4-9ee6520ab69d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250112-mainlining-mc3510c-v3-4-9ee6520ab69d@gmail.com>

On Sun, Jan 12, 2025 at 03:25:38PM +0300, Vasiliy Doylov wrote:
> This patch allows to add new devices to this driver.
> 
> Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> ---
>  drivers/iio/accel/mc3230.c | 50 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index ba30c904d3f67002deeb3ca5a7e12bfae312e05f..1b58f3ea50655b6563a78a2531b16a8088e8f8d5 100644
> --- a/drivers/iio/accel/mc3230.c
> +++ b/drivers/iio/accel/mc3230.c
> @@ -22,20 +22,29 @@
>  #define MC3230_MODE_OPCON_STANDBY	0x03
>  
>  #define MC3230_REG_CHIP_ID		0x18
> -#define MC3230_CHIP_ID			0x01
> -
>  #define MC3230_REG_PRODUCT_CODE		0x3b
> -#define MC3230_PRODUCT_CODE		0x19
>  
>  /*
>   * The accelerometer has one measurement range:
>   *
>   * -1.5g - +1.5g (8-bit, signed)
>   *
> - * scale = (1.5 + 1.5) * 9.81 / (2^8 - 1)	= 0.115411765
>   */
>  
> -static const int mc3230_nscale = 115411765;
> +struct mc3230_chip_info {
> +	const u8 chip_id;
> +	const char *name;
> +	const u8 product_code;
> +	const int scale;
> +};
> +
> +static struct mc3230_chip_info mc3230_chip_info = {

Why this cannot be const?

Best regards,
Krzysztof



Return-Path: <linux-iio+bounces-10767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 560679A4D19
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 13:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9BF8B22C1E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 11:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DF61DFDAD;
	Sat, 19 Oct 2024 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCZyUllW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192C2190688;
	Sat, 19 Oct 2024 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729337196; cv=none; b=mn/FTsR/9JxDvBRbxm6vjgeK6SQeP3wwBsp5CpTwK8RlJEei6hdy/KCusKXAMIcU+Qgobadz/FplI21mHq9qoun/bqjlyTHTNN4c01IYANIXBIMUGbv721ZOdz/xqUpM+0sX7hfiiY8k74x0qJoIZAClwJGJVh8Aft/bV67+q2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729337196; c=relaxed/simple;
	bh=db5Klz077IRyjZqaXz9UZi01A0v79knvYuzrPUHMHZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpIj3EKvDLwp2eEj0uiP2iGyElWNg2giiU4Ym1pExbhWKGSIQV7+bXc1hhFK5LbA3RCYTN3XA/WoMzkwZMJbnPOqXHkjdq6Ay366IKGCqR79WIKmnzfv2LInpTA+gWTqCwjOfOPtBojAHJrZX5jZMhUv4m/Y+d+7Fm/oPSjbhRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCZyUllW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31F2C4CEC5;
	Sat, 19 Oct 2024 11:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729337195;
	bh=db5Klz077IRyjZqaXz9UZi01A0v79knvYuzrPUHMHZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RCZyUllWzI3iGNx2PRmOqNwDWu/2lXn5gmgbgHzcDQn0s3K2a7IPlMsLkcp0zD6oA
	 s96GLSRMqMi+cnbLr+yse+pbvZ67yE5RBv+HWJ5t6wHGYSdKdCbBzwnYW+csvZazBw
	 8qj/kW4NJ4LdmPLJvLHxClgtxgDK/LkDWbN95gN695iFIENOCrLEP38oIrU4WiKrng
	 5eA+3bIfGHfaj87du32Cwl2Og0sUSREyDE4tNrFUwjtID9ReCH0PwA3ox4W3FUR7GB
	 rDdsj+CBYtMNgbghGs1IkezMIu33WFXW2jcXoXuFExBTxSKAAlOsd28sT5bFEDoIGs
	 LbvrRkxc0t9sA==
Date: Sat, 19 Oct 2024 12:26:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mariel Tinaco <Mariel.Tinaco@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad8460: add SPI device match table
Message-ID: <20241019122629.268197e8@jic23-huawei>
In-Reply-To: <20241018-iio-dac-ad8460-add-spi-match-table-v1-1-84a5f903bf50@baylibre.com>
References: <20241018-iio-dac-ad8460-add-spi-match-table-v1-1-84a5f903bf50@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 16:44:48 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add SPI device match table for ADI AD8460 DAC. As described in [1], this
> is required for the module to automatically load, even when using DT.
> 
> [1]: https://lore.kernel.org/all/20210921192149.50740-1-broonie@kernel.org/
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
One day I'll remember to check for this when reviewing.

This is actually another corner case and fine for now.
In the link you reference check the driver name matching just
before the warning print.

That works if there is only one ID. Still better to clean
this up as a form of hardening against future problems.

Applied.

Jonathan

> ---
>  drivers/iio/dac/ad8460.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
> index dc8c76ba573d..ded442d4060d 100644
> --- a/drivers/iio/dac/ad8460.c
> +++ b/drivers/iio/dac/ad8460.c
> @@ -929,12 +929,19 @@ static const struct of_device_id ad8460_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ad8460_of_match);
>  
> +static const struct spi_device_id ad8460_spi_match[] = {
> +	{ .name = "ad8460" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad8460_spi_match);
> +
>  static struct spi_driver ad8460_driver = {
>  	.driver = {
>  		.name = "ad8460",
>  		.of_match_table = ad8460_of_match,
>  	},
>  	.probe = ad8460_probe,
> +	.id_table = ad8460_spi_match,
>  };
>  module_spi_driver(ad8460_driver);
>  
> 
> ---
> base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
> change-id: 20241018-iio-dac-ad8460-add-spi-match-table-906dd36cb033
> 
> Best regards,



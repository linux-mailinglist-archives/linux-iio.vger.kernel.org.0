Return-Path: <linux-iio+bounces-18177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0DDA90BCD
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4817D3B2488
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C408922425D;
	Wed, 16 Apr 2025 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEebix6O"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2ED224227;
	Wed, 16 Apr 2025 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829928; cv=none; b=RW/YbrzgSVpMlRmubRT57igTWfwXDIbShAEkHQMapnil06F9UnoGPAisHHhGabvyDEsPRQAya7hU0JTZ9D33RHBa6YOjwbhp8PJf/4GivObpTt72pYgU7va11s4eSGXEAIR3vINwLO43nsxYHsV5JuSzYGMom040zmBt/vW7OG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829928; c=relaxed/simple;
	bh=/hNhJZcR4CUwBEo2blgUcniwjsPrSIgbIv64kUB5918=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWLP0Q6vlaRsY+Vx553y3HIiTo9wtKvFZ97whJ9qT849Gfv4EaD56yZq45TZRUlwMKHq0non5XulZ2kkARzRuPyIg7Wf+T8YyVFXqfs9JTKA0Wn+TJxIKj3AG4F3MeQYN4+oVvU8VtLG8FgCJQf0s0EX5TJLUblZcNGZWG4KFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEebix6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2EBC4CEE2;
	Wed, 16 Apr 2025 18:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744829928;
	bh=/hNhJZcR4CUwBEo2blgUcniwjsPrSIgbIv64kUB5918=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEebix6ON9AXItAp4J7RHk3Df2FVKYqV50SRmeR3uNoJuvSGuzKS9PTtY3HPC0Je2
	 5NvQWbmsn+lmaEEmLmR5ROuQ1Sti6E7Z1j6USfRxd1UX45GemQtVcbmoS2BV73dIRC
	 cqukW7FwZgjsQUSdIJFbtXg0nSZglEFPIh+W26OI3Nt9J/GOLgAP+qSBrNF8tND6S1
	 +bKlAnQtUk88kjXghAzLdlt9vlMpujUFVBbcrmjBa2th0Km98PYsb7bMHENTMjhmVr
	 VuqRoB6eeMsi9jnJ0Po2kyfWBR94AwUUcs/8f6ERjXUx7o2YH/dJbz+F+O1WoafKy/
	 Ao5mqGtkcq3ZQ==
Date: Wed, 16 Apr 2025 13:58:46 -0500
From: Rob Herring <robh@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2] iio: frequency: ad9832: devicetree probing support
Message-ID: <20250416185846.GA3735440-robh@kernel.org>
References: <20250322163211.253009-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322163211.253009-1-simeddon@gmail.com>

On Sat, Mar 22, 2025 at 09:58:11PM +0530, Siddharth Menon wrote:
> Introduce struct for device match of_device_id to avoid relying on fallback
> mechanisms, which could lead to false matches against other AD9832 variants
> in the future.
> 
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
>  v1->v2:
>  - updated commit message to be more informative
>  - minor changes to code formatting
>  drivers/staging/iio/frequency/ad9832.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 140ee4f9c137..7d4f655f6df1 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -431,6 +431,13 @@ static int ad9832_probe(struct spi_device *spi)
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
> +static const struct of_device_id ad9832_of_match[] = {
> +	{ .compatible = "adi,ad9832" },
> +	{ .compatible = "adi,ad9835" },

Is there some reason we can't add a binding for this?

Rob



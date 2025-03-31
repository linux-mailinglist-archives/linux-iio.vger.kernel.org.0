Return-Path: <linux-iio+bounces-17421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C6A764C7
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 13:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E623A6C11
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 11:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1931E1041;
	Mon, 31 Mar 2025 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVnYzOuL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706521DD0F2;
	Mon, 31 Mar 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743419605; cv=none; b=OHuA86zyh76dVAlUpTnlJdjC/93cGhw75D76nAeHCpxqgUjh1RJQBm7pAYsuOksRSb+LiuZE/UXZtUwuBDYugV4+cJfsFz39eU9jf4nZCmhtcvXh4oLorcRkx1fcUvEhEjySJDz81btO9PT587prSeEOP1pEDdw/iqtTW9xdrjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743419605; c=relaxed/simple;
	bh=xC5d5HV9g/QMKwpUqadQc8/+qiEuKkPATB2RIFwwMkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqJCqyl8r4jt9bI4u+Y6BMxOBw/d1NMK81/dGrFKWMkOGNN7xftQWCEjHhM2qOXLywl9xD0qXixicbuskx3iPqxyPqZfBiC4EITF0qvtr2eVYuRjC8yA/N9IepZ65NGCLtRb/PCKdNiZbfsaSDMez5MTWJfjZ0knrb0DwVIn5w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVnYzOuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A707DC4CEE3;
	Mon, 31 Mar 2025 11:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743419604;
	bh=xC5d5HV9g/QMKwpUqadQc8/+qiEuKkPATB2RIFwwMkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SVnYzOuLQJw6S/ItccfCmmtnOXug52M/1LqdxqbL8wGZTQCmSvmvteJ7Sx61sI/UV
	 1X7w5cGglO4PkHOhCPOmCfdmBB/0HwWaIIMKuO0EZDGrDVQJfACDhO3tHdAxSpgcax
	 EX5Qzxd7iDeQTj+Hi2mJhZ0M0wqzFnz23IKlTV9uJE2XQs8A/2JDyORkPOWSA+4wL2
	 r9HeNuVGOthM8KB6j2AVoVesarBWe4CJU1dC6AB4EI8vmHbU4f7p/90reaO4YgkcXD
	 LjZ7pbt5zb/dsoZVD6FdekcMpnR+L36xZViV5lav5XcV/a9EbR9FYp61mQ7i8zZlRG
	 q2GzqhiiNwNzw==
Date: Mon, 31 Mar 2025 12:13:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: adc: ti-adc128s052: Be consistent with arrays
Message-ID: <20250331121315.78178349@jic23-huawei>
In-Reply-To: <49966043aabecad8db8eb81908d0d2995b0cfc38.1742474322.git.mazziesaccount@gmail.com>
References: <cover.1742474322.git.mazziesaccount@gmail.com>
	<49966043aabecad8db8eb81908d0d2995b0cfc38.1742474322.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 11:03:13 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ti-adc128s052 driver has NULL terminated ID arrays for the
> of_device_id, spi_device_id and acpi_device_id. All of these are
> terminated by having an empty string as the last member of an array.
> Only the of_device_id array uses the /* sentinel */ comment.
> 
> It's better to be consistent.
> 
> This /* sentinel */ comment serves no real purpose these days as people
> are used to seeing these ID lists terminated with an empty array
> element.
> 
> Drop the /* sentinel */ from the of_device_id.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  drivers/iio/adc/ti-adc128s052.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index d1e31122ea0d..dd1e405bf172 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -185,7 +185,7 @@ static const struct of_device_id adc128_of_match[] = {
>  	{ .compatible = "ti,adc124s021", .data = &adc128_config[2] },
>  	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
>  	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
> -	{ /* sentinel */ },
> +	{ },

Whilst here, drop the trailing ,

More 'modern' style in kernel tends not to use them as we don't want to make it
easy to put anything after it.

If there is another such case drop the comma on that as well as part of this
patch.

I don't care that much about the /* sentinel */ though as I've let at least
one more of those in over the weekend. Still consistency is a valid argument.


>  };
>  MODULE_DEVICE_TABLE(of, adc128_of_match);
>  



Return-Path: <linux-iio+bounces-17204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10653A6CA7D
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 15:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768703B8082
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502402288D2;
	Sat, 22 Mar 2025 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZhZxOe8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E187405A;
	Sat, 22 Mar 2025 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742652842; cv=none; b=AJnKlhHl62zRaX8SZpbGwNXKcHpApm1Z66EbkoueNIC4U60djQEXyGw3MIYBCyXQSwUEQ1nt9sDwz+CGeG8sKYALxgRbh37Pd1BORmSaviAfKm3UWWb6mdhdfLFIVmFSK+6R58wmwsPpZNECM/y8eKGumpsKXUtRnNrVualxNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742652842; c=relaxed/simple;
	bh=yO/02y4E8Qq4+jqBAsG9Qhf+t4Y4BP+/g4WjBbxGnB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLxXf3Uu/jd2jeJ365QMjXHv5zLMnacBdfQNrXIkx4Rtu/W8b4YC5Aa5PJ5oJwHdHqgePwTQdodaY7TGURzXrOs+1iqBPq8EsAwHT8AJ0vol3Cmm1n+WZd8v52k2ApJqLdJAzlJ4IEmFxJSbLBuXyxE9oS5QUNrIm2sO2vg+ICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZhZxOe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1070C4CEE4;
	Sat, 22 Mar 2025 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742652841;
	bh=yO/02y4E8Qq4+jqBAsG9Qhf+t4Y4BP+/g4WjBbxGnB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bZhZxOe8lRHchPrE1hwpX3uo3lWcZwv42ghGXKJhheWZuq0awyWnbgDVxQigjtwFM
	 6TXzcCcM0bI6kwPG5YW8ld3+5G42Y1D6nFQE9Ku97Uhc/EMC7TAYKAI8pWxilnhMUs
	 qV2L/FtuW/pG70Po4X9FllPo/guTLvxOVyTGhQp1vZbfpckyPkaKeoXuoz5T/anc0Q
	 vYShqlBqoFZ+7i7NWPae3iwbFAwMq5wNF+B1MnTfS6zF8kHtTvv4Ad5qfpKq/try4b
	 MYQZcCtkPBHRW3C6KgVikV/0sa2kPPtbvhFdjbO/FZLSFSIKj4Q6UAuecXJj/bivC7
	 Sw4zI07VN+SGQ==
Date: Sat, 22 Mar 2025 14:13:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH] iio: frequency: ad9832: devicetree probing support
Message-ID: <20250322141350.3fb7d560@jic23-huawei>
In-Reply-To: <20250322081108.202654-1-simeddon@gmail.com>
References: <20250322081108.202654-1-simeddon@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Mar 2025 13:37:45 +0530
Siddharth Menon <simeddon@gmail.com> wrote:

> Introduce struct for device match of_device_id

Good to say why.   Key is that it will probe from a dts
entry without this due to the various matching fallback paths,
but it will be matching with the less informative bit after
the manufacturer.  So we might get a false match in future
against some other ad9832 part.


> 
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 9a27acd88926..506478ddede3 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -439,6 +439,13 @@ static int ad9832_probe(struct spi_device *spi)
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
> +static const struct of_device_id ad9832_of_match[] = {
> +	{ .compatible = "adi,ad9832" },
> +	{ .compatible = "adi,ad9835" },
> +	{},
No comma on a terminating entry like this.  We don't want to make it easy
to add stuff after it!
Also, I'm trying to standardize the formatting of these tables
across IIO.  So I made the random choice of having a space between
the brackets and am slowly changing drivers to that standard.
	{ }

> +};
> +MODULE_DEVICE_TABLE(of, ad9832_of_match);
> +
>  static const struct spi_device_id ad9832_id[] = {
>  	{"ad9832", 0},
>  	{"ad9835", 0},
> @@ -449,6 +456,7 @@ MODULE_DEVICE_TABLE(spi, ad9832_id);
>  static struct spi_driver ad9832_driver = {
>  	.driver = {
>  		.name	= "ad9832",
> +		.of_match_table = ad9832_of_match,
>  	},
>  	.probe		= ad9832_probe,
>  	.id_table	= ad9832_id,



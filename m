Return-Path: <linux-iio+bounces-17212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6522A6CF14
	for <lists+linux-iio@lfdr.de>; Sun, 23 Mar 2025 13:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050DB3B5510
	for <lists+linux-iio@lfdr.de>; Sun, 23 Mar 2025 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B172046AA;
	Sun, 23 Mar 2025 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVpYV9cs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EF586329;
	Sun, 23 Mar 2025 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742731336; cv=none; b=KozsLfc4qiqQa/IHXf/uYmXrvxjrFZkH0SeW4/16XHJ6k5Op22QOtvnZxgAgTXJYzFZV4JubRoupfnV+Lyc7yrJXxCmk6/weLoc9WR1f9Qr8B+LNhUT8W+PeojxK24vAXgcTAVLW03sNsRsFU8Ua2W/NO5J6wg7Z07Kuq2wl+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742731336; c=relaxed/simple;
	bh=UFizHCfqrdbhi3FBXbsSAN6ni6BpfXHOlr8OZSeTN0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfvKhm3ZwaWdPUvBy+zRJExllntoW+ovPBrMuM2JjxzDTKwrIgQUX92klyU6jgE5J8hCIBnoHony5xhjw6+7Ey8/8Px7qHkM3obOpcSg0soVoZWuyLwNz8m7eZB1wDpr9BuGVDWdYtd8oI6AK0eda0n/Hqsjm2FOHWAL8fhzdaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVpYV9cs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B942C4CEE2;
	Sun, 23 Mar 2025 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742731336;
	bh=UFizHCfqrdbhi3FBXbsSAN6ni6BpfXHOlr8OZSeTN0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RVpYV9cs+tqnDQ391TCingKr8tyjivpRACrVIPDEUSkkYVOA9WePTGF6wooCrofED
	 lqyYNe8o4b+3OVFFrLxUIODiRm07GH8r7Z3e83a4m6oh9v4z+K/LNWgiIsk4owDx/x
	 u/9qSXyqu3e+FB6Np3fSm4k/ayHzVpv+UJ69OsWEwoqcSk10Oy22m5t7kGJGgTicm/
	 5phJ5VsIt9NPBRKC5SvMWAxgfeZCV7kOusVpCJB3AnB7NloBgXNMowV4AFv/3QVHIf
	 WRgmwWIAHZDgv9tKuY/UsBDMLuYfPWXrWlskdAz0XtsC0A4J/KwcO8JCQCqTteyAV4
	 fLWS8e/5dYBUg==
Date: Sun, 23 Mar 2025 12:02:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2] iio: frequency: ad9832: devicetree probing support
Message-ID: <20250323120211.000b4305@jic23-huawei>
In-Reply-To: <20250322163211.253009-1-simeddon@gmail.com>
References: <20250322163211.253009-1-simeddon@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Mar 2025 21:58:11 +0530
Siddharth Menon <simeddon@gmail.com> wrote:

> Introduce struct for device match of_device_id to avoid relying on fallback
> mechanisms, which could lead to false matches against other AD9832 variants
> in the future.
> 
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
Marcelo gave a Reviewed-by tag.  This time I've picked it up
manually but in general it is the responsibility of the submitter
to include those on new versions. Obviously sometimes things race though so
maybe that is what happened here!

Applied

Thanks,

Jonathan


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
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad9832_of_match);
> +
>  static const struct spi_device_id ad9832_id[] = {
>  	{"ad9832", 0},
>  	{"ad9835", 0},
> @@ -441,6 +448,7 @@ MODULE_DEVICE_TABLE(spi, ad9832_id);
>  static struct spi_driver ad9832_driver = {
>  	.driver = {
>  		.name	= "ad9832",
> +		.of_match_table = ad9832_of_match,
>  	},
>  	.probe		= ad9832_probe,
>  	.id_table	= ad9832_id,



Return-Path: <linux-iio+bounces-7081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1945591D13A
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 12:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1CD1F213A0
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 10:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D8213A258;
	Sun, 30 Jun 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO23MBjF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7AD28DC1;
	Sun, 30 Jun 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719744448; cv=none; b=g6u1kykP3CXbpa40gmwZ/9nhlp8CPVoAi0SQO8EGJiACbJBewEqiIMlx7CsxfQDggaR2lkY6f28AgQC4sJFIBusraiCfT9cIxYqqPjPQx2P5af56hBQygZDdVdSzHoghUu8Ol2hpSTsRwxB7OChignDxFIHHqRO6Mx8L6IcpJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719744448; c=relaxed/simple;
	bh=smv2UoWzDrGFb+vnE2W3+bY/OSs9/gpqvWEbFpXIoNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3NJ8Xp2oN4ZXIVLvSCkeWunDt+feaQ6p/apGEuvrU+u6/CaDa1XedEJ4YOYgHbPbxzFl6jfU+Y6oS1qHdVsMoK9t/NqcPTGEeMh+Krnz8nX441zEiY1JZnXPklaDdu8+3QREv4zAmcgpG/bDL8sYfjfnL0uScRCH7LmftzA8WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vO23MBjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC39C32781;
	Sun, 30 Jun 2024 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719744447;
	bh=smv2UoWzDrGFb+vnE2W3+bY/OSs9/gpqvWEbFpXIoNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vO23MBjFqd6DyncaCOKrOAfGqIaXmPxSO/Bg56OhM0Zk3il7Ehf/VE1dA5yXTLQfW
	 LNDoDMgdYclBXzNSixb21rXgNY2t1SkFlnNluhdAkz7wjpcYWlZ4F/sda/rrYw2yTu
	 RdETpuRPZSsKhKn33TMnwtJYa947lAHRjHBXXOD8XoIDI7KYIsDv0lGTaeq5FSvmWL
	 Wk++mIP1VLekcPncOqhq2dgHHdXGA4wi3Ix7fSU/p4kd7YsVjSGwsNfkEU5pCDaYK4
	 Xg3GS3l+fy78aUt7cabcsKW80OWbzbO9DyNivLzhFYQ474Oeb09jXGCsweMEkPyWhI
	 dSG2o3z05FkZw==
Date: Sun, 30 Jun 2024 11:47:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
 <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/7] spi: Enable controllers to extend the SPI
 protocol with MOSI idle configuration
Message-ID: <20240630114716.3e06f18b@jic23-huawei>
In-Reply-To: <7eb23146ad6bf6090183c6340e4d59cb269d83a7.1719686465.git.marcelo.schmitt@analog.com>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
	<7eb23146ad6bf6090183c6340e4d59cb269d83a7.1719686465.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Jun 2024 16:04:40 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The behavior of an SPI controller data output line (SDO or MOSI or COPI
> (Controller Output Peripheral Input) for disambiguation) is usually not
> specified when the controller is not clocking out data on SCLK edges.
> However, there do exist SPI peripherals that require specific MOSI line
> state when data is not being clocked out of the controller.
> 
> Conventional SPI controllers may set the MOSI line on SCLK edges then bring
> it low when no data is going out or leave the line the state of the last
> transfer bit. More elaborated controllers are capable to set the MOSI idle
> state according to different configurable levels and thus are more suitable
> for interfacing with demanding peripherals.
> 
> Add SPI mode bits to allow peripherals to request explicit MOSI idle state
> when needed.
> 
> When supporting a particular MOSI idle configuration, the data output line
> state is expected to remain at the configured level when the controller is
> not clocking out data. When a device that needs a specific MOSI idle state
> is identified, its driver should request the MOSI idle configuration by
> setting the proper SPI mode bit.
> 
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

I always like to see some nice ascii art. Very nice documentation.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 93f59ebb5b79..c8ba5e490850 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c

> @@ -3950,6 +3956,7 @@ int spi_setup(struct spi_device *spi)
>  	 */
>  	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
>  				 SPI_NO_TX | SPI_NO_RX);
> +

Trivial grumpy comment.  Don't touch white space in unrelated code!

>  	ugly_bits = bad_bits &
>  		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
>  		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);


Return-Path: <linux-iio+bounces-13224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 286E59E863C
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152011883D75
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB8B1586CF;
	Sun,  8 Dec 2024 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcI65yja"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217C313BAD5;
	Sun,  8 Dec 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733674578; cv=none; b=pj2ALTvyJT2AEgA4xqtyBkJMK/CHH04WFM99GuMr9fkP+ylyxiknZkt/FLPJnSPuoEvuGaYu7GJeEobKpyq+QJ7zLOgvclDrlTZHIurlJUALMiAu9uNIc3plsKYqfYvDrDyRnWZG0OcXrzN87Os4n4WEHRQcZoIYIwlJSQU6JoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733674578; c=relaxed/simple;
	bh=tpELd3m3RmAM+tq2fbfUaSc0tEQjSYQnV3gru2RqO3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gw/lul+tOP7bwiLn0KhCbOZzoK4eNk90i+l5d3hmFQA/Fkf0LEcQ1DnX64S/xq3mCvD1xhWB1faUKHRyMGMIEiSkm3jGN90EEOtdyV1cNLpg/UuGGdmk/Glpys7xkavOQFoOo533/BXdSVmLhp5XFavXw9jKnPA4rF6QC/CCcKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcI65yja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98787C4CED2;
	Sun,  8 Dec 2024 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733674577;
	bh=tpELd3m3RmAM+tq2fbfUaSc0tEQjSYQnV3gru2RqO3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pcI65yjalnILofa98pig7ODOSB2MDXeaihw8Muj5GXKdw45mY7xhJT0BSTQwWoPSU
	 37zzLMICgdQsri1ODr20FJhlYuBXqoacQUZrA9sSZQA4DnYg68uvBCE//UpkowfT5E
	 MYAJjyHfrkK7YFNsM/JV6719r5FdLQqNoTWFN/W2fidqQG6zDnAA56wzp27Z93zOeL
	 BjYSL2Tt6AajVtJQVFV1Ra5ccXqo5o6nMGNZ+OyhtMJMT/GoSN32WSn6DFZ2sAP7Cj
	 50hjSyKpxTPORMEwXwQTkBWPriEXxY3WSTiW9dx+GliTzi5eU2aKbkdtbVIZcSnPM3
	 nWpLikM7kurhw==
Date: Sun, 8 Dec 2024 16:16:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 08/10] iio: accel: adxl345: initialize FIFO delay
 value for SPI
Message-ID: <20241208161607.5122712d@jic23-huawei>
In-Reply-To: <20241205171343.308963-9-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
	<20241205171343.308963-9-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Dec 2024 17:13:41 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the possibility to delay FIFO access when SPI is used. According to
> the datasheet this is needed for the adxl345. When initialization
> happens over SPI the need for delay is to be signalized, and the delay
> will be used.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,

1 trivial comment below.

Jonathan
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index 61fd9a6f5fc..9829d5d3d43 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -12,6 +12,7 @@
>  #include "adxl345.h"
>  
>  #define ADXL345_MAX_SPI_FREQ_HZ		5000000
> +#define ADXL345_MAX_FREQ_NO_FIFO_DELAY	1500000
>  
>  static const struct regmap_config adxl345_spi_regmap_config = {
>  	.reg_bits = 8,
> @@ -28,6 +29,7 @@ static int adxl345_spi_setup(struct device *dev, struct regmap *regmap)
>  static int adxl345_spi_probe(struct spi_device *spi)
>  {
>  	struct regmap *regmap;
> +	bool needs_delay;
>  
>  	/* Bail out if max_speed_hz exceeds 5 MHz */
>  	if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ)
> @@ -38,10 +40,11 @@ static int adxl345_spi_probe(struct spi_device *spi)
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>  
> +	needs_delay = (spi->max_speed_hz > ADXL345_MAX_FREQ_NO_FIFO_DELAY);

Excess brackets.  I'd drop them.

>  	if (spi->mode & SPI_3WIRE)
> -		return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_setup);
> +		return adxl345_core_probe(&spi->dev, regmap, needs_delay, adxl345_spi_setup);
>  	else
> -		return adxl345_core_probe(&spi->dev, regmap, NULL);
> +		return adxl345_core_probe(&spi->dev, regmap, needs_delay, NULL);
>  }
>  
>  static const struct adxl345_chip_info adxl345_spi_info = {



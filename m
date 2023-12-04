Return-Path: <linux-iio+bounces-580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43226803594
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 14:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24802810D2
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AC125574;
	Mon,  4 Dec 2023 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9Jvulx4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BBE24B36
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 13:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BB4C433C7;
	Mon,  4 Dec 2023 13:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701698076;
	bh=Yt42qsEglskrxT0sttipdDbX/oRzAJS4t3qsL4MIXac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N9Jvulx4+op58wlpRaJzIAuECstRCWjq/nxT0DeBL9bRqlLJ2fssUrqoAro3wHkp+
	 UAVCyq1xy1g2tg9im3QNoJEXQ4wREkbzNcYHoS6ki7eI/KhGaAsfVbbg4qh23igNI5
	 hBskAtgsVPyHUSQcw/Zv5LPHkGyKcJl4kx4W7S1O9KRs8AFgcPnW80EXkh1N7OZiiK
	 iNEPmY0gqEuyZHfH4Zq54y+ni9XgnP+EfeVUj3zeElsCWktr3GFvCrWO7JxUADi4Na
	 mWwvY3A0IYSMd1ty9KoWCuyNYO1ybmiWQIDA6y2d9tO5lDYBEbFwkEAvH3v+OBWIo/
	 WH4woiVcNIqDw==
Date: Mon, 4 Dec 2023 13:54:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <marius.cristea@microchip.com>
Cc: <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: MCP3564: fix hardware identification logic
Message-ID: <20231204135430.603709a9@jic23-huawei>
In-Reply-To: <20231129135619.63475-1-marius.cristea@microchip.com>
References: <20231129135619.63475-1-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 15:56:19 +0200
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> In mcp3564_config() fix the hardware identification logic
> based on the hardware ID registers. Second part of the code was
> disabled by an logic error.
> Fix a typo related to the "MODULE_DESCRIPTION".
> 
> Fixes: 33ec3e5fc1ea (iio: adc: adding support for MCP3564 ADC)
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mcp3564.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> index e3f1de5fcc5a..e914a885a868 100644
> --- a/drivers/iio/adc/mcp3564.c
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -1122,7 +1122,7 @@ static int mcp3564_config(struct iio_dev *indio_dev)
>  	enum mcp3564_ids ids;
>  	int ret = 0;
>  	unsigned int tmp = 0x01;
> -	bool err = true;
> +	bool err = false;
>  
>  	/*
>  	 * The address is set on a per-device basis by fuses in the factory,
> @@ -1509,5 +1509,5 @@ static struct spi_driver mcp3564_driver = {
>  module_spi_driver(mcp3564_driver);
>  
>  MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
> -MODULE_DESCRIPTION("Microchip MCP346x/MCP346xR and MCP356x/MCP346xR ADCs");
> +MODULE_DESCRIPTION("Microchip MCP346x/MCP346xR and MCP356x/MCP356xR ADCs");
>  MODULE_LICENSE("GPL v2");
> 
> base-commit: 6543f376ec8aa90a6c1ed44b765f4f0d6c3eb1db



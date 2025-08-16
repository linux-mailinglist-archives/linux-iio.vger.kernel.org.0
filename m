Return-Path: <linux-iio+bounces-22783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BCDB28CA5
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D63F1C871CB
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5526428C841;
	Sat, 16 Aug 2025 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stC+k6gC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134223958C;
	Sat, 16 Aug 2025 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755338706; cv=none; b=WHOY7+A4cXrfKuCiZKzvJbcW+AAEK/Ip9de3xCe3QXmWkSyOCQ6jAVpiyKtOZmASqQJwqcoFnIrPjaAKXBP5+1g1u5OoFxFVU+erlJigZVWYau7YoAnHbsl0Bo5igDdKHK323k+tS7q/6/jKIptcj/mdPonnvam1mOhKcT7+CRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755338706; c=relaxed/simple;
	bh=0+vPgSHCnSXS9niW6BSm6+asaZlv4TvU+YsJAl4cIXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oi/bqeT0126sBMqYhr+GjI6aRxVaF5jHGmVlJ+kIaXBN06tNamks3ZDh+uKFn3NYc6g6mV5hNN2sUD/No1e5/5bGEoIrJhkTyCTlhbeAcaaana5D6mQFRhxo0c+zJGMgqVQcsDaIA72lnl4vT+e51fze1XJbnBtw58R5Z1/8yuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stC+k6gC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DEAC4CEEF;
	Sat, 16 Aug 2025 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755338705;
	bh=0+vPgSHCnSXS9niW6BSm6+asaZlv4TvU+YsJAl4cIXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=stC+k6gCvI9KE93QCRzOFL7WumCmdZKuGZ9FqMf2wBufCxsRaTxfUpIN/0yjI4xqG
	 7aOEyBgPTx3YCK237EWHtYTHpYqMTV1NzBB510Deb+D0j5SWAURBjV+DOxqqmEDdZ+
	 x2LUGhuwLgzY8WFROs8Q5hKRUW0yAkAxrVV2RG5qNh4cbGa/GpJJppEJUFhQR3qx6r
	 ZUlAIkvkhuRS82l+cifGDAkJtNmKz+2rhXlk51CREC1OiDbUQCPIsr9VbjRcuep+4s
	 MsUiMxUy8rBXFGN//xXIbaFXH9e7ReATOZjj1apFFpJuTSTMss07ZgOkDVZUyWNHSG
	 DQISCrv3Y3c0A==
Date: Sat, 16 Aug 2025 11:04:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@watter.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: mcp9600: Recognize chip id for mcp9601
Message-ID: <20250816110458.470ea150@jic23-huawei>
In-Reply-To: <20250815164627.22002-4-bcollins@watter.com>
References: <20250815164627.22002-1-bcollins@watter.com>
	<20250815164627.22002-4-bcollins@watter.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 16:46:05 +0000
Ben Collins <bcollins@watter.com> wrote:

> The current driver works with mcp9601, but emits a warning because it
> does not recognize the chip id.
> 
> MCP9601 is a superset of MCP9600. The drivers works without changes
> on this chipset.
> 
> However, the 9601 chip supports open/closed-circuit detection if wired
> properly, so we'll need to be able to differentiate between them.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
>  drivers/iio/temperature/Kconfig   |  8 +++--
>  drivers/iio/temperature/mcp9600.c | 51 +++++++++++++++++++++++++------
>  2 files changed, 46 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 1244d8e17d504..e14ea6ebc7a24 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -173,11 +173,13 @@ config MAX31865
>  	  will be called max31865.
>  
>  config MCP9600
> -	tristate "MCP9600 thermocouple EMF converter"
> +	tristate "MCP9600 and similar thermocouple EMF converters"
>  	depends on I2C
>  	help
> -	  If you say yes here you get support for MCP9600
> -	  thermocouple EMF converter connected via I2C.
> +	  If you say yes here you get support for:
> +	  - MCP9600
> +	  - MCP9601
> +	  and similar thermocouple EMF converters connected via I2C.

If we are updating this list every time, do we need to add the 'and similar'
to the help text?  It makes sense only in the short description above where
we aren't listing them.

>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called mcp9600.
>



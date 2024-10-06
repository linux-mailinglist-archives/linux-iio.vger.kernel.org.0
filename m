Return-Path: <linux-iio+bounces-10239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F45991E7D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6E81F21A98
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447AE176FC5;
	Sun,  6 Oct 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQzCC2dy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C39170A3F;
	Sun,  6 Oct 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728221313; cv=none; b=e7/j2CgkwWveqjW5T6y3KR+xZ7FdgWp6jZXOiRHSHRz694TmntIeXS554b2zfWJ5C8q2IsHtM50W0ctSWG4dPxLqoUSNbU9EVy+YEYR7ef1TeYjpsO0GeX3G8+R+rZ4kTx/D3UY+yQpQxcTMEw9AUYFcFdVXErpqoNL7QIraNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728221313; c=relaxed/simple;
	bh=f5R0u6V8ytcUxdQlMaW5Pqf3m+aWpMJeS3jfHNy3gzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4nQyMorm3wbdb5NzfRaznfgGz1Tbhikm87W6ZuAg6G1GMDMMC1lDR/03y4NvOdpJWc/g97kfUFdOCychIUX4nw2eAG1fRFspZ2P47TESoVDw4qwd7bQ5qiXnpoaSy+TIdoa0FrZKDPLYu5MYMQQSE6Na4v5YJYgVrSxVZ4EcV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQzCC2dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3E5C4CEC5;
	Sun,  6 Oct 2024 13:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728221312;
	bh=f5R0u6V8ytcUxdQlMaW5Pqf3m+aWpMJeS3jfHNy3gzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QQzCC2dyn/loeTgWDDhOZDYgOAPglaPt5OUqB2xBEv3Euy1KCU1i3+W2UlNJSxua6
	 fF8UPlKiwXySN1H59J3ySm2vTlOXQm5e4e5LZd7PHJg0VgqSEUXHy3S9GWV4ve9/NF
	 FDwM0YV2tYB7qHo0Vpp9E6rONKpooJqbXl6WU8dWPAUvXdNuvVO4eQETAFQ6BF2go1
	 9x2RZp3pn15680fCpQ+xvUKe2Ctv9Ltyq8orAI1HubaZ4o0m4Ow26ag9/DfWSq0TDB
	 sf+NCfvV2kyceGdLSWRgf6oABXrzKvIaIFiA9RPvj6e6AcAnSqqHfpRmpJEBIrLEg2
	 pPP74fAHvB5wg==
Date: Sun, 6 Oct 2024 14:28:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Cristian Pop
 <cristian.pop@analog.com>, Mircea Caprioru <mircea.caprioru@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Fabrice Gasnier <fabrice.gasnier@st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] iio: dac: ad5770r: add missing select REGMAP_SPI in
 Kconfig
Message-ID: <20241006142818.34c5fc61@jic23-huawei>
In-Reply-To: <20241003-ad2s1210-select-v1-6-4019453f8c33@gmail.com>
References: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
	<20241003-ad2s1210-select-v1-6-4019453f8c33@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 18:49:38 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This driver makes use of regmap_spi, but does not select the required
> module.
> Add the missing 'select REGMAP_SPI'.
> 
> Fixes: cbbb819837f6 ("iio: dac: ad5770r: Add AD5770R support")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied
> ---
>  drivers/iio/dac/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 1cfd7e2a622f..3160b10f2752 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -262,6 +262,7 @@ config AD5766
>  config AD5770R
>  	tristate "Analog Devices AD5770R IDAC driver"
>  	depends on SPI_MASTER
> +	select REGMAP_SPI
>  	help
>  	  Say yes here to build support for Analog Devices AD5770R Digital to
>  	  Analog Converter.
> 



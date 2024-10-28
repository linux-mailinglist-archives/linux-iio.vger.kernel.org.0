Return-Path: <linux-iio+bounces-11515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2029B3B02
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95DDD1F22A1E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499831DF251;
	Mon, 28 Oct 2024 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6f7iRpm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F23A1DB;
	Mon, 28 Oct 2024 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145889; cv=none; b=Gc9hz5guR5Js5ICrKMyyIeV4WWm96b6OwKLt9jDRUjgAfYZyTvqHQFZaVz+kadBlwf5ZSOcZvhCxUcaTvXaB9hxemzrq74b7mfj95UAJmCmo3mESx9v5S+vA20on/l+Jeh0XTub+j6lFIiPu3z+Vxf0qwidVAvc5AP9yT2z4yGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145889; c=relaxed/simple;
	bh=KZNN1JyeVLqKYXgdrhh23aQzImf17McDSEe0V0WxjgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ik1uHD8SUSF8W5udruhwn1rD7sJ/tzDxw8jtF6EhiZfDJdt7AULy0c9c1CVjiSg43+Lixe9o9vYoFIMVMMOPEehVFu2tM8mva8BIoXuRntFK/5zE2+W87CNnjIBec3DZMBk0xh9GrfDY/gAPxuS7xCNC5eIcXN3rRXv2/gz97q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6f7iRpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3125FC4CEE3;
	Mon, 28 Oct 2024 20:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730145888;
	bh=KZNN1JyeVLqKYXgdrhh23aQzImf17McDSEe0V0WxjgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L6f7iRpmvXuJewoMM/3DVrdYThrYwmxAGmNjaJsg5iqvP6o9lROsvmuyclgDtHZPp
	 Lpv6I8fiDzvWTxfDoDtb2655AcSG+BupNqFE7VzlyrAcpFIYH2Y3T8n1ZbN6l4cfd4
	 0CuVfw7hbORqnwPCdyW1xOzqdvb47NheYB4SKb78SdCE3O9bvCXRr2GsncU5uH4D1x
	 kfbqsDOHyQET45x+P8ANcYQslXuJrny9hp4x8lvlzaZHlQIAsvJjdirYsR0ddcKzkA
	 dER+eYfS7XDpNag28SDxLni6B6t+wYOOWYhXbxiTDMmI4TqkD5lseLY9/f6e7niVr3
	 tiG88dS1PZztA==
Date: Mon, 28 Oct 2024 20:04:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ramona Alexandra Nechita <ramona.nechita@analog.com>, Arnd Bergmann
 <arnd@arndb.de>, Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: adc: ad777x depends on CRC8
Message-ID: <20241028200442.4169b6f3@jic23-huawei>
In-Reply-To: <20241028162937.2171535-1-arnd@kernel.org>
References: <20241028162937.2171535-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 16:29:15 +0000
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added driver fails to link when CONFIG_CRC8 is not set:
> 
> ld.lld-20: error: undefined symbol: crc8_populate_msb
> ld.lld-20: error: undefined symbol: crc8
> >>>               vmlinux.o:(ad7779_spi_read)  
> 
> Select this from Kconfig as we do for other drivers like it.
> 
> Fixes: cc20fa9e9ad4 ("drivers: iio: adc: add support for ad777x family")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Squashed into original patch.

Thanks!

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d8abe28eec89..849c90203071 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -290,6 +290,7 @@ config AD7768_1
>  config AD7779
>  	tristate "Analog Devices AD7779 ADC driver"
>  	depends on SPI
> +	select CRC8
>  	select IIO_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices AD777X family



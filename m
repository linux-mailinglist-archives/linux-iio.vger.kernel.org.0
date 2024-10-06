Return-Path: <linux-iio+bounces-10234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8BD991E70
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBDB1F21A4C
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF16175D44;
	Sun,  6 Oct 2024 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDnbbNLc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71DFEC5;
	Sun,  6 Oct 2024 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728220594; cv=none; b=WRuqL4yBqAUGiEK1+tkwWdPNmvq+25TTVg45nnBaSByWYCBu8W6bUN4JpZIUJndDtCF4+lP27a2tPkutoNfxcHGidO+yHeT43IJrr2+aZPJmspCbo1YKaZ+3/9GqFDEWIOC9KclyRtH0WSEXn5hyjPBlNC0GPUZrxi/NfPMbE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728220594; c=relaxed/simple;
	bh=1GBLMcK3i2eldYjScMWFaufU9bIpCwLMX0tBN/4ft2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1N3zloLVrthRGTIqz2Bfa5bg02DkFjE+oGkR5+EO0INpH3u0yBowt/ZSupn1S9HCSkxwmxTMUy5baqxaULDj9GeEyazLvJZvKG62pg8o0o9aNEmmICNww+5CCQBwz2oUmSJ90PP+VKzGuXYyaoxiAAOwhgNxCWxx0xUa+W2qTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDnbbNLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CA2C4CEC5;
	Sun,  6 Oct 2024 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728220594;
	bh=1GBLMcK3i2eldYjScMWFaufU9bIpCwLMX0tBN/4ft2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iDnbbNLc0WwD1uP9DSnnuLkB0GHW6+b7zqU51orfs5LvMZ95sNT6zbIqr40TJ0zzw
	 dbVUNwTDVXV9DsjvTIxsZOjujGPx45Vx2R/Bt+W7SCkK9R+6DlxQTrJUDWAt3Axdmv
	 HJhl+WqNnFTqqjUdAZOegpqmmqzhHqsjB1XqfF6U9BcJE2+/yLbJ4XAK8GUX14WUXY
	 GSdy0RldFxZikXZ4bN1R5w0pvV99n9SV4Ja9MWaCwtILqgv4dC7padynBpnqPsWJnx
	 eDlFaMsqL+QTWGvwEzHkprGjQnFNtAIp+nsrC8eqKsTlhJr5OjhqJnGopxfVtF3ImC
	 ymUq1MC8UjzDQ==
Date: Sun, 6 Oct 2024 14:16:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Emil Gedenryd <emil.gedenryd@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andreas Dannenberg <dannenberg@ti.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v4 2/2] iio: light: opt3001: add support for TI's
 opt3002 light sensor
Message-ID: <20241006141624.3fa5bf34@jic23-huawei>
In-Reply-To: <20241003-add_opt3002-v4-2-c550dc4591b4@axis.com>
References: <20241003-add_opt3002-v4-0-c550dc4591b4@axis.com>
	<20241003-add_opt3002-v4-2-c550dc4591b4@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 14:22:17 +0200
Emil Gedenryd <emil.gedenryd@axis.com> wrote:

> TI's opt3002 light sensor shares most properties with the opt3001
> model, with the exception of supporting a wider spectrum range.
> 
> Add support for TI's opt3002 by extending the TI opt3001 driver.
> 
> Datasheet: https://www.ti.com/product/OPT3002
> Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
> ---
>  drivers/iio/light/Kconfig   |   2 +-
>  drivers/iio/light/opt3001.c | 189 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 157 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index b68dcc1fbaca..c35bf962dae6 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -461,7 +461,7 @@ config OPT3001
>  	depends on I2C
>  	help
>  	  If you say Y or M here, you get support for Texas Instruments
> -	  OPT3001 Ambient Light Sensor.
> +	  OPT3001 Ambient Light Sensor, OPT3002 Light-to-Digital Sensor.
>  
>  	  If built as a dynamically linked module, it will be called
>  	  opt3001.
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 176e54bb48c3..ff7fc0d4b08f 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -70,6 +70,35 @@
>  #define OPT3001_RESULT_READY_SHORT	150
>  #define OPT3001_RESULT_READY_LONG	1000
>  
> +struct opt3001_scale {
> +	int	val;
> +	int	val2;
> +};
> +
> +struct opt3001_chip_info {
> +	const struct iio_chan_spec (*channels)[2];
> +	enum iio_chan_type chan_type;
> +	int num_channels;
> +
> +	const struct opt3001_scale (*scales)[12];
This doesn't compile for me as one of the two options only
has 11 entries.  You could either force them to be 12
entries each or use a pointer without the size and
add a num_scales entry in here.

Jonathan


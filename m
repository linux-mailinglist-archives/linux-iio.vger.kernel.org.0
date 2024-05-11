Return-Path: <linux-iio+bounces-4969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A668C3298
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 18:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60457B21534
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BECE1B27D;
	Sat, 11 May 2024 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho2aMbOo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5467F;
	Sat, 11 May 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715446281; cv=none; b=AVIFdRMMVT3yo7iqRFrGf4FHLVPCTHCQHW8op6hGf8sR/W7Y2r2hFUf4QGacLP2qhyzn4MxE4WVV/CItTcrcM5C6k0tiuk5lXFjehEcVDzw9KxoU9iO7Jpp493gChk+yFXGTclZSAhG3zpajiz71uBmX8Rbgg96IwvwO2AqHAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715446281; c=relaxed/simple;
	bh=VbOQwKp39EvEMHtEb152t547M0kAfy9Sqb88nc56TIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJ0FVgSFrs+cWfua61jLUSdDwKm1J/EcLgRuCVb9APIRROV63uo+7lbS5+hdIf1SyJ2xiEThPdTpdYnQXF9fsIx5G2MvftEppYi86RV1CkthrnroU44hKW1lwWJdRJz2uhhsU8hnSLY8vOtYP1vUKnUhVgtcpSdMwFwkZxDdC3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho2aMbOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28649C2BBFC;
	Sat, 11 May 2024 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715446280;
	bh=VbOQwKp39EvEMHtEb152t547M0kAfy9Sqb88nc56TIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ho2aMbOojOrK2H82OaYrPukTh5D+Hb8/pe+WvpWXYK3mK7EnCkWVljE/YDyFRzo4/
	 Vnf21ZnIq0L65FzMvx8Br4ohQFWKAvJ17IHVRWdT+vnOJvo+KnXQLNjl/k1jtqPhMg
	 PUxgYNNLIEgj9Eql0/YrsYtYsijbM+ba6fTkMAyqRqxsockzcEXMgJSJVVqqAj6StJ
	 9wzqtF6wuaoIENABRh02+EoWmmBrnWuNOMluwpsAmhBvWsvAaMizXf6bYjxIEZApN8
	 S2prjfU0ldHrTyDp+bN9TRBuHY1zXNfHLPBHQTlSoj8dW3ebNSXZ592wOasmX0fN1q
	 2mwFTsqYv3QnQ==
Date: Sat, 11 May 2024 17:51:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/8] spi: add support for hardware triggered
 offload
Message-ID: <20240511175108.5ce34c9c@jic23-huawei>
In-Reply-To: <20240510-dlech-mainline-spi-engine-offload-2-v2-3-8707a870c435@baylibre.com>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
	<20240510-dlech-mainline-spi-engine-offload-2-v2-3-8707a870c435@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Drive by comment inline.

> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index a8fc16c6bf37..ec8d875d31ff 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -632,6 +632,9 @@ struct spi_controller {
>  	/* Flag indicating that the SPI bus is locked for exclusive use */
>  	bool			bus_lock_flag;
>  
> +	/* Flag indicating the bus is reserved for use by hardware trigger */
> +	bool			offload_hw_trigger_enabled;
> +
>  	/*
>  	 * Setup mode and clock, etc (SPI driver may call many times).
>  	 *
> @@ -1594,12 +1597,26 @@ struct spi_controller_offload_ops {
>  	 * @unprepare: Callback to release any resources used by prepare().
>  	 */
>  	void (*unprepare)(struct spi_device *spi, unsigned int id);
> +
> +	/**
> +	 * @hw_trigger_enable: Callback to enable the hardware trigger for the
> +	 * given offload instance.
> +	 */
> +
Blank line in odd place..

> +	int (*hw_trigger_enable)(struct spi_device *spi, unsigned int id);
> +	/**
> +	 * @hw_trigger_disable: Callback to disable the hardware trigger for the
> +	 * given offload instance.
> +	 */
> +	void (*hw_trigger_disable)(struct spi_device *spi, unsigned int id);
>  };
>  
>  extern int spi_offload_prepare(struct spi_device *spi, unsigned int id,
>  			       struct spi_message *msg);
>  extern void spi_offload_unprepare(struct spi_device *spi, unsigned int id,
>  				  struct spi_message *msg);
> +extern int spi_offload_hw_trigger_enable(struct spi_device *spi, unsigned int id);
> +extern void spi_offload_hw_trigger_disable(struct spi_device *spi, unsigned int id);
>  
>  /*---------------------------------------------------------------------------*/
>  
> 



Return-Path: <linux-iio+bounces-19058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B1FAA885B
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 19:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1360175781
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383D61DDA2D;
	Sun,  4 May 2025 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XagVy84g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67414B086
	for <linux-iio@vger.kernel.org>; Sun,  4 May 2025 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746378794; cv=none; b=GS4bJfhtR/9IZ7yhD5RmFBpIc4XU3r3ZlR00dIW7UAWTjM1Gk2czdaU7mgNO3wuLMduWC4bn8thuyN42aRIyV3MFWLLlx68cnJAJ3NK0ucyZ/63d6xk7Ycm3MXfu5AZZSv+MgXDD+wn9JNA9j0plnAgzNbJzkwAEyG2rT82wrGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746378794; c=relaxed/simple;
	bh=1/Qxcdpav87iwp13WqwIglIAV7u4o5dqxhkI7KMvCuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcpuYmpFTGvSNYM8wLay9Xc1tYpTdQIuJo85UZZM038waKA0q3dbwDHNtfJr4K5VzfYj0ZSR88Wl4FrBTDgOk8skYzSaiwTuJpDE8pn5LngqY+l0COl0VHCP+/Te5+98w2M9yr/5FHy46URcYAcudXvk0IyasD+4/WcIf8UEl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XagVy84g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660E8C4CEE7;
	Sun,  4 May 2025 17:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746378793;
	bh=1/Qxcdpav87iwp13WqwIglIAV7u4o5dqxhkI7KMvCuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XagVy84gTn78XgfNO2qoWB+mo3BHwOOxoBHnKYVUzkMisA6zGmt23UiZI3lAmiukO
	 NWGSjf+vvGXqlfaeuf674BTPDpkc+KIo0v2dhxqaN+WbnMAs9CoznO1VemFKpRrRd/
	 903BnjKI7U6fHoXd+TtzG03i1Jd9eTVLyvkzviNlMASdE5LqQkRlht0OsnCl0lE6H8
	 szZKya5rRyNbYRUd1saA2WeCQcpEf6hMamdGmWEaXhwecueJnuZrEhwY+hGqMZzlre
	 El0ntCGvYnVO5pK+LEiozerAikc2LS1rvVgD0aWshrcL0VOEaK70k2ekpZHLiENR/L
	 GAUOGFlEGtN0A==
Date: Sun, 4 May 2025 18:13:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: r2.arthur.prince@gmail.com
Cc: linux-iio@vger.kernel.org, arthur.prince@ime.usp.br, Mariana
 =?UTF-8?B?VmFsw6lyaW8=?= <mariana.valerio2@hotmail.com>
Subject: Re: [PATCH v2] iio: adc: Kconfig: fix undefined kfifo symbol in
 ti-ads1298 module build
Message-ID: <20250504181306.132c4061@jic23-huawei>
In-Reply-To: <20250428223520.1100832-1-r2.arthur.prince@gmail.com>
References: <20250428223520.1100832-1-r2.arthur.prince@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Apr 2025 19:32:45 -0300
r2.arthur.prince@gmail.com wrote:

> From: Arthur-Prince <r2.arthur.prince@gmail.com>
>=20
> Add dependency to Kconfig=E2=80=99s ti-ads1298 because compiling it as a =
module
> failed with an undefined kfifo symbol.=20
>=20
> Signed-off-by: Arthur-Prince <r2.arthur.prince@gmail.com>
> Co-developed-by: Mariana Val=C3=A9rio <mariana.valerio2@hotmail.com>
> Signed-off-by: Mariana Val=C3=A9rio <mariana.valerio2@hotmail.com>
Hi.

Rather confusingly you sent the same patch under a different title a few
days later.  Please be careful not to do that as it confuses me ;)

Anyhow, no harm done. I applied the other one.

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 849c90203071..513f2238fdee 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1492,6 +1492,7 @@ config TI_ADS1298
>  	tristate "Texas Instruments ADS1298"
>  	depends on SPI
>  	select IIO_BUFFER
> +	select IIO_KFIFO_BUF
>  	help
>  	  If you say yes here you get support for Texas Instruments ADS1298
>  	  medical ADC chips



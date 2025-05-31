Return-Path: <linux-iio+bounces-20069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA44AC9B92
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF9C3B57EC
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC3D23D281;
	Sat, 31 May 2025 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ujryb/xX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891111185;
	Sat, 31 May 2025 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748706185; cv=none; b=dVB9lpmS9YUHh+bf9HUl3sp1joKVd6xcbuc7k56dXU20o41tEt0AYVIC4eoN4jr8AnNvOZs1VaLNy/6QhMQsUlJm2GpI1WVEWLYsRCkh33LbSiIlDTn1SWJxhaV5nc1KZN/afWX2vnkA3WTILof+c8Xl2MZAU4qu+IltGZWSI1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748706185; c=relaxed/simple;
	bh=RJrqCSxOJMSjx2fTZncUiQV6/mnDlT5rbVx7f21sSIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdY4dJk4imus1Prl2CEzUAZZ5KXeSsOZsX1sFUc3n4ArrtFCZR2Zqi+FkRrwm95CVd0tsLBQ5PVNPLbm7Oe3n3N6Y8jLKEvehq0vZPIw00ZRKXhomBmxHQiNSngOLkdNH0hepY39I4FgCOk0Jsn+Ea31RsZC70UB42O4S+3TEPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ujryb/xX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C853BC4CEEF;
	Sat, 31 May 2025 15:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748706184;
	bh=RJrqCSxOJMSjx2fTZncUiQV6/mnDlT5rbVx7f21sSIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ujryb/xXZchzHDW5TkUX8DUjsFoL1Ym96UVgQeFTGwefIBFpvAIrq+ywpACA39Z9x
	 zDdp7e8fTzhRhVZ/46VTSF0kzv/IQ9cf1o3yQ3qcaFSWhUvpEdxEbp6Dk5nW59dv+d
	 RmWTdvTNo8PLYqaHa2T3zpyPa4l+n3WSey49Qh695o7oXcqcECh7axbwfKQTjzDyiF
	 7/SdpEXvvXPC8zcd0gPnlP1OChhViADSpa0/j+qfk/1NuspW0D6F7HzUFwU5zEjZtz
	 JOCCeGtaoh2hpph5k/ySXNICJ6cJ5jR2UuH7wmv/fl8Zs0BwZHrGFiBnw0/DdFXnaG
	 IU7w5E1PAHJPA==
Date: Sat, 31 May 2025 16:42:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7476: Support ROHM BU79100G
Message-ID: <20250531164258.47f0d1a2@jic23-huawei>
In-Reply-To: <aDk2qNE9LTVnfAFM@mva-rohm>
References: <aDk2qNE9LTVnfAFM@mva-rohm>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 07:40:08 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> ROHM BU79100G is a 12-bit, single channel ADC. From the software point
> of view it is identical to the TI's ADS7866. Support reading ADC
> measurements using the ad7476.c
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied.
> ---
> 
> Please, see the relevant discussion (as to why an ID for a fallback is
> added) in:
> https://lore.kernel.org/all/f8ec547a-5924-4563-aa1d-dde8227844fa@gmail.com/
> 
> This patch was based on v6.15-rc1. I can rebase if needed.
> 
>  drivers/iio/adc/ad7476.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 37b0515cf4fc..d48ee8f1d547 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -435,6 +435,13 @@ static const struct spi_device_id ad7476_id[] = {
>  	{ "ads7866", ID_ADS7866 },
>  	{ "ads7867", ID_ADS7867 },
>  	{ "ads7868", ID_ADS7868 },
> +	/*
> +	 * The ROHM BU79100G is identical to the TI's ADS7866 from the software
> +	 * point of view. The binding document mandates the ADS7866 to be
> +	 * marked as a fallback for the BU79100G, but we still need the SPI ID
> +	 * here to make the module loading work.
> +	 */
> +	{ "bu79100g", ID_ADS7866 },
>  	{ "ltc2314-14", ID_LTC2314_14 },
>  	{ }
>  };



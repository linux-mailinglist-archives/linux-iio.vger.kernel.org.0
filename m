Return-Path: <linux-iio+bounces-10240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC7E991E88
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225F8281ECF
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4E717A590;
	Sun,  6 Oct 2024 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb/Ox0e8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9FF176FD3;
	Sun,  6 Oct 2024 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728221389; cv=none; b=dNqYGwmwT5PECqIbz/0WWG2LImsoMlOlmG9WJA/FA8r8DiGN1qnhwUF7n5IpkYejEOFNgNhq0ISZo9cu3waOKMUm+HphFtl+RzwvuA+ONkzOLZTvKznEdDNDzW6E+vPhu9whzgUFTqp5TEPDfgJWNioXGRRYCZ1K26POTkCNkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728221389; c=relaxed/simple;
	bh=6A325THGbjr3kl4xLnqU2jMS0T2T9Ay+lvXxUng20Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hgzfq7U0aXQrk7GcF1rRvYfK1xCbCmf6XYLT59E/MhNdKTkxechPFn9uOmhEDj/9+i3YMUH15Sgo3nM+BcDyEw6YJxqXfYXS6OpSa7c3swUss6I/7bfXba5vELZ36QO1sUQLvv1wE0DK14zo0LwIA+1UedgzFlUlS0uOE0Mw9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb/Ox0e8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F470C4CEC5;
	Sun,  6 Oct 2024 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728221389;
	bh=6A325THGbjr3kl4xLnqU2jMS0T2T9Ay+lvXxUng20Tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bb/Ox0e8aZGQ5lM4QyD+MW3nRz5tULbq9edD2SMJMJ5Ll7mgPOGOWLLJsHxefyG7N
	 q5jmVgYo4XBNfL/hPC+nX+WHiIbtuZ8yDRIpDe7IpGxm+Qzr9quxCoV2TqiNNInnUH
	 DB9rby/Z08jNwPIyQNn596zNgp47xCtWPm85kh9LwKV/LS5r/z7CVCZ64AnRFvfl+k
	 yPU1GCT37hGl+DqKhPXt4K3IDNi5OorwGLUlvhMExPW9MsBMluG6MLs2jb6Gyp+CKI
	 7b6xYkISM+E52Ina6gOysmIE/oJOkgooYYYQVMN2IW4kEXtao/yvFAka8Y4Bg25Cie
	 mUFhezgo3sHLg==
Date: Sun, 6 Oct 2024 14:29:41 +0100
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
Subject: Re: [PATCH 5/8] iio: amplifiers: ada4250: add missing select
 REGMAP_SPI in Kconfig
Message-ID: <20241006142941.1146386c@jic23-huawei>
In-Reply-To: <20241003-ad2s1210-select-v1-5-4019453f8c33@gmail.com>
References: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
	<20241003-ad2s1210-select-v1-5-4019453f8c33@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 18:49:37 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This driver makes use of regmap_spi, but does not select the required
> module.
> Add the missing 'select REGMAP_SPI'.
> 
> Fixes: 28b4c30bfa5f ("iio: amplifiers: ada4250: add support for ADA4250")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied.
> ---
>  drivers/iio/amplifiers/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
> index b54fe01734b0..55eb16b32f6c 100644
> --- a/drivers/iio/amplifiers/Kconfig
> +++ b/drivers/iio/amplifiers/Kconfig
> @@ -27,6 +27,7 @@ config AD8366
>  config ADA4250
>  	tristate "Analog Devices ADA4250 Instrumentation Amplifier"
>  	depends on SPI
> +	select REGMAP_SPI
>  	help
>  	  Say yes here to build support for Analog Devices ADA4250
>  	  SPI Amplifier's support. The driver provides direct access via
> 



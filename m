Return-Path: <linux-iio+bounces-18866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B0BAA16EE
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 19:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD8AA7B4B79
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D13251793;
	Tue, 29 Apr 2025 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMjQVfoo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF30227E95
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948495; cv=none; b=ewle0YNl1SE6WUWNJwLwT039Ngu34OKB4RcVaU1VgAoJDXU2iSfwnqkAPK/V7s/eotJ458c+6xtDxjiQ0n//urC2mnjSeXzCOTpfKeJO2/Cu5gu3oX8D2zKMMBbOkpnh0TDDbOXxGsmKg7RP79KJrDUoMm8zDwpZ0eFY/Ci1jb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948495; c=relaxed/simple;
	bh=IMXgnezBquMbmTkFAw3mHmT53mB/DczAb5Z7CYkdfaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uINXZ0rwkwbniBKK45hP0wjsdiedSrd58GmGUrUY4+RmCYIrGMJ/tk/TGBUK2YFRepukzqBJ3hNDHYX5L3EVGc9w4QnOx5dFuZswFEZ5ayVns21QA8CT6THdOVWRmImsQL0jddSqLTYsSitw8tSOgSaPQDybPaupmWbNpPUBXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMjQVfoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676E5C4CEE3;
	Tue, 29 Apr 2025 17:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745948495;
	bh=IMXgnezBquMbmTkFAw3mHmT53mB/DczAb5Z7CYkdfaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HMjQVfooPy7za2aeJ0sdZeKrVOoJn3yit6obEDRW9xczY6B3xrTkdFoM4KpGlG4z0
	 qpkSCdB+BuP2b4FB+5uECuJz3GxhmNAzwAyH7l2G5p8E+YERoDd6Lg/k5obldgzY1g
	 IRkx7H2SvHJsoB3SeFZ5geP4TqldMCQUxLDkDgFtZp7L5IMhvA/+f/ebHrPPMXo8j9
	 R4kFCGrsWvo7dNyXNQKId/hgaiQ1Bc+jfIedzkuOaSBVGpILfgr6O/3G4k+1xJ6YAP
	 pZvwn9RjJZrWx6AW22o2gnE2MNWEBSY5D1iTTti0xzal0G7OoF7Y5CIacPUIJdHjjT
	 7EbpL0FLdQT/g==
Date: Tue, 29 Apr 2025 18:41:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sebastian Aguilera Novoa <saguileranbr@gmail.com>
Cc: saguileran@ime.usp.br, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: hp03: Drop explicit
 hp03_is_writeable_reg and hp03_is_volatile_reg functions
Message-ID: <20250429184129.7aff4461@jic23-huawei>
In-Reply-To: <20250429165604.67984-1-saguileran@ime.usp.br>
References: <20250429165604.67984-1-saguileran@ime.usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 13:56:03 -0300
Sebastian Aguilera Novoa <saguileranbr@gmail.com> wrote:

> Drop functions hp03_is_writeable_reg and hp03_is_volatile_reg. Both
> functions always return false, regardless of the register number or
> device. They are used in a single place within the hp03_regmap_config
> and can be replaced directly.
> 
> The HP03 Series of calibrated sensor module datasheet (1) document
> does not contain any information about the register values to define
> states for the functions.
> 
> (1): https://www.sensorica.ru/pdf/HP03.pdf
> 
> Signed-off-by: Sebastian Aguilera Novoa <saguileran@ime.usp.br>

Take another look at what you are doing here.

+ the warnings it gives...

> ---
>  drivers/iio/pressure/hp03.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
> index 6f7a16787143..a69f6f5ce248 100644
> --- a/drivers/iio/pressure/hp03.c
> +++ b/drivers/iio/pressure/hp03.c
> @@ -57,16 +57,6 @@ static const struct iio_chan_spec hp03_channels[] = {
>  	},
>  };
>  
> -static bool hp03_is_writeable_reg(struct device *dev, unsigned int reg)
> -{
> -	return false;
> -}
> -
> -static bool hp03_is_volatile_reg(struct device *dev, unsigned int reg)
> -{
> -	return false;
> -}
> -
>  static const struct regmap_config hp03_regmap_config = {
>  	.reg_bits	= 8,
>  	.val_bits	= 8,
> @@ -74,8 +64,8 @@ static const struct regmap_config hp03_regmap_config = {
>  	.max_register	= HP03_EEPROM_CD_OFFSET + 1,
>  	.cache_type	= REGCACHE_RBTREE,
>  
> -	.writeable_reg	= hp03_is_writeable_reg,
> -	.volatile_reg	= hp03_is_volatile_reg,
> +	.writeable_reg	= false,
> +	.volatile_reg	= false,
>  };
>  
>  static int hp03_get_temp_pressure(struct hp03_priv *priv, const u8 reg)



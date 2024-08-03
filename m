Return-Path: <linux-iio+bounces-8209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FC1946A40
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 17:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16FCEB211CC
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 15:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF476154458;
	Sat,  3 Aug 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9dztM0R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17315442F;
	Sat,  3 Aug 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722697628; cv=none; b=U9gBMWbHVEDRr8Q27AUJpjFlVDeo1A1wO9zYT+ztS/GCjoM10YCKwVeXhHE4gRd6HgIAaa9t2K7AgWdFiCVXtfyfbLAlGYnHIxTzltw/BuCMeEbTJJkoclltzia73WdeLHQd3sQd3XPXqZUwfLJMBCH0/ZnNn+tfXy7MulNaECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722697628; c=relaxed/simple;
	bh=ykqJ0VYCZC1cPv1qO6QbXIbxggmcFELSYHYNTPY+DyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUVF5Di4tEncTs9tT0TFVGDz4aKSXge9wgWKKcyj+34LJsEsnGgidMB7wTP8yXmueUfetLT/qP1Mdtfq0nvwx29KcoUlpy49qD5f2VtcruJ/QVnMAr25KVt+a3+sju08ChBdcV2bsO06qF1bbfB7vFfxASqXsNJ0m+7X45EouLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9dztM0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CF3C116B1;
	Sat,  3 Aug 2024 15:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722697628;
	bh=ykqJ0VYCZC1cPv1qO6QbXIbxggmcFELSYHYNTPY+DyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B9dztM0RBYp0MYIXX6yFVT6TA7d2BKZFD1u7Od3nZ2VaoOGSK4o8+9pqZ4b73QDtS
	 7RuAf3/XZepFyqsDEj+rkOXn3ZcNjl7Twa9NXiBd309vLTkpzL7nalZGEqUTHfvAv/
	 hi4fGpgaxUMgvi2brXyArCSGuuE8fLQrnG9vSgE++GJM7ahXcLr1Cp1dDSEAI3Z0Df
	 +jvSq5EOTEOUfijFJZ9dU+fzzVP1Cnox8ARoqHHCgZTy9HygoDc3VH/rW3q8Yphat0
	 fF7Rv4S2C2TTFiuEYPrAhYwgYbRPtb7gmec5UAz+fPqm3YxMFBfqjZKE5ukidMF3Z3
	 h/KrZhBSiKo7A==
Date: Sat, 3 Aug 2024 16:07:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Stefan Popa <stefan.popa@analog.com>, Alexandru Tachici
 <alexandru.tachici@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <dumitru.ceclan@analog.com>
Subject: Re: [PATCH 3/4] iio: adc: ad7124: reduce the number of SPI
 transfers
Message-ID: <20240803160700.2f20479e@jic23-huawei>
In-Reply-To: <20240731-ad7124-fix-v1-3-46a76aa4b9be@analog.com>
References: <20240731-ad7124-fix-v1-0-46a76aa4b9be@analog.com>
	<20240731-ad7124-fix-v1-3-46a76aa4b9be@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 15:37:24 +0300
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> The ad7124_init_config_vref() function writes the AD7124_ADC_CONTROL
> register for each channel that is configured to use the internal
> reference.
> 
> The ad7124_write_config()function performs 7 SPI transfers for
> configuring 2 registers: config_x and filter_x.
> 
> Reduce the number of SPI transfers:
> -during the probe by only setting the st->adc_control value in
>  ad7124_init_config_vref() and writing to the device only at the end of
>  ad7124_setup().
> -in ad7124_write_config() by grouping writes to the same register.
> 
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
There doesn't seem to be any overlap between code touched by 1 and 2 (the fixes)
and 3 and 4 (non fixes), so I've picked 3 and 4 up now via the togreg branch of
iio.git which will be pushed out as testing for 0-day to look at.

Thanks,

Jonathan


Return-Path: <linux-iio+bounces-24952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302CDBD0343
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3781894BED
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5423E1A9F8F;
	Sun, 12 Oct 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gANNQYle"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B45280004;
	Sun, 12 Oct 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760278683; cv=none; b=lyOVx/QFZAxGnoSyC8o9AccVouQru/i+pu9htcNomqWnbBvYA4tMOOVQtdKhfgev2Iiahgamh4az5AybhZFcS/nR0vG3RWcvLY+vEMJisnfmeYwM4ZkeFVhZNg6LVJSbAUStwqpk33GnInpVNKVHAUyIaPz18UH7K57/VShb1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760278683; c=relaxed/simple;
	bh=lTPc8GO3wB6QyCOvObtK7gyvDMugmgilzvtPy9ig7Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijT7oj2G+PyEgN93CgREU+Rie7z97Enz90d/WpFdDciRu5TOvPju7onqB+h1IJtf9BEMrbDxFgdqElQeEBiMHpymQ7/QGp46OgZlBOxlrUgPVM/Yljb8P4VIiGnH67LCu0ANlY7ngg2nMa3II3FbFHC3T72KJFij6SUGZsMve0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gANNQYle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D53C4CEFE;
	Sun, 12 Oct 2025 14:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760278682;
	bh=lTPc8GO3wB6QyCOvObtK7gyvDMugmgilzvtPy9ig7Jg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gANNQYleH9+m072pA7KzYGtHfJOR1bnZbsJGErKwNjjR+fDruuw2/IvlZuncYOIi/
	 ipNnryl8Ls8pY1920yS1nAQOIXk9yxpmUnEbBTANVDOJm47dz8+4SEhH3ZkIrwx/6m
	 Uu2sz7cWL4UE/1Bg85NvPmSOUO3ckcOEA0rBELURuHC8lIQb7CGQNAgp2k4Md2NbkM
	 di3F0K9RUqD2SB3JAr89Ej03hej5Mn94BW1yOWO1Ao+1WfHRsiJo0xqBPfDfBet2sY
	 BVlMNhZriIJCtX0i8PzSsx45HqPgWHQM1OsqirCDlEQEqmzqbLdsnry2O4Flr1M2GK
	 joUyaEG8U71hg==
Date: Sun, 12 Oct 2025 15:17:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Taimoor Zaeem <taimoorzaeem@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/2] staging: iio: ad9834: remove empty ad9834.h file
Message-ID: <20251012151755.24db56ea@jic23-huawei>
In-Reply-To: <20251006094025.259440-2-taimoorzaeem@gmail.com>
References: <20251006094025.259440-1-taimoorzaeem@gmail.com>
	<20251006094025.259440-2-taimoorzaeem@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Oct 2025 14:40:24 +0500
Taimoor Zaeem <taimoorzaeem@gmail.com> wrote:

> Remove drivers/staging/iio/frequency/ad9834.h header file
> because it contains nothing except the include guards.
> 
Odd!  I guess left over after some other cleanup at somepoint.

Applied.

Thanks for cleaning this up.

Jonathan

> Signed-off-by: Taimoor Zaeem <taimoorzaeem@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9834.c |  3 +--
>  drivers/staging/iio/frequency/ad9834.h | 10 ----------
>  2 files changed, 1 insertion(+), 12 deletions(-)
>  delete mode 100644 drivers/staging/iio/frequency/ad9834.h
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 0038eb234d40..d339d5e8e043 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -21,9 +21,8 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include "dds.h"
>  
> -#include "ad9834.h"
> +#include "dds.h"
>  
>  /* Registers */
>  
> diff --git a/drivers/staging/iio/frequency/ad9834.h b/drivers/staging/iio/frequency/ad9834.h
> deleted file mode 100644
> index 521943aa0e61..000000000000
> --- a/drivers/staging/iio/frequency/ad9834.h
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * AD9833/AD9834/AD9837/AD9838 SPI DDS driver
> - *
> - * Copyright 2010-2011 Analog Devices Inc.
> - */
> -#ifndef IIO_DDS_AD9834_H_
> -#define IIO_DDS_AD9834_H_
> -
> -#endif /* IIO_DDS_AD9834_H_ */



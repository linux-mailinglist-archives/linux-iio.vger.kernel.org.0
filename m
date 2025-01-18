Return-Path: <linux-iio+bounces-14455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CE4A15DD4
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 16:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5643162739
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 15:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6177319CC33;
	Sat, 18 Jan 2025 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMX8sug/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D679273F9;
	Sat, 18 Jan 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737215720; cv=none; b=Z2mUQjABrZ1Uv7owTm2PAwyKoWum42VzVGDKz2gCpq+Ba5OkYthX4utjOvEfY1qnrWdOEw9q1zmL3uB0RPpd4R90nkxA39LE+JQttMMr7O9GPu39j5nWLbef9ujiI45SLMWaSZy4vTd4ZtVCGvnww+SW2uebE/jp4CL8slVxZZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737215720; c=relaxed/simple;
	bh=XnuGAYecEM/FkFCZ+PN+whtcubP68vm0YjaQX9u1qAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8U5qmrwEPzhV797kCXp04fXdPrT15xlZxBAeLRO3VD3PUck8dAsS0Ya80Wcwh60ZPTo2tVFgpQFsu9y4Eije/5FIlhKaEQ/xLMHBephD+R9fEkoC8cx3WJz0sJPYg8/H9vwbTBC471SyvpHFbHqqcuDWtcEe4w8HX1AL/1LTf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMX8sug/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F746C4CED1;
	Sat, 18 Jan 2025 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737215718;
	bh=XnuGAYecEM/FkFCZ+PN+whtcubP68vm0YjaQX9u1qAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rMX8sug/QuJgEBQkpq3ITLs2Mvxs1jMdpiVM7wYg9vZoT6y1l5yko1ycRxpupWYDo
	 L8Kwe0RHBGYL80NnwALJh80/oIYfsbtbB9VAT/P8Ea3+4pA44YRHL8ri9YKBmJy8gE
	 GjYMUc9quIO/NLI5u9wH7D6NzT/52WaS99lQbgqyDZDgCkvvGKwzQIf7mXj0zZ2SXN
	 CTtADT76Y4Q49etQUIE9+4gVH86SvrbEu5NaN14GaMexbGIo/LrqDI3fQenuifmZF2
	 36y48KF2HhOHdaB7ws693kquitkry0a2ZqTVPyNA68nothCSHOVuWWNKzDSq5LjU10
	 6gg6NMampTgvA==
Date: Sat, 18 Jan 2025 15:55:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7625: drop BSD license tag
Message-ID: <20250118155510.7532d5c5@jic23-huawei>
In-Reply-To: <20250114-ad7625_license-v1-1-6555b7be05ab@baylibre.com>
References: <20250114-ad7625_license-v1-1-6555b7be05ab@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 12:31:55 -0500
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> The ad7625 driver was submitted under a dual BSD/GPL license, but this
> isn't a requirement for the code, and adds extra complexity. To make it
> consistent with similar drivers, drop the BSD tag and leave it as
> GPL-2.0-only.
> 
> Suggested-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

Your code, so your choice either way.  Applied.

> ---
>  drivers/iio/adc/ad7625.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
> index aefe3bf75c91..8b020f22c5a8 100644
> --- a/drivers/iio/adc/ad7625.c
> +++ b/drivers/iio/adc/ad7625.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +// SPDX-License-Identifier: (GPL-2.0-only)
>  /*
>   * Analog Devices Inc. AD7625 ADC driver
>   *
> @@ -680,5 +680,5 @@ module_platform_driver(ad7625_driver);
>  
>  MODULE_AUTHOR("Trevor Gamblin <tgamblin@baylibre.com>");
>  MODULE_DESCRIPTION("Analog Devices AD7625 ADC");
> -MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_LICENSE("GPL");
>  MODULE_IMPORT_NS("IIO_BACKEND");
> 
> ---
> base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
> change-id: 20250114-ad7625_license-bcbaaa3bf449
> 
> Best regards,



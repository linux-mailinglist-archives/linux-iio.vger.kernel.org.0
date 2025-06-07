Return-Path: <linux-iio+bounces-20293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFFAAD0E1C
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 17:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AE23AFF09
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6360B1D6DC5;
	Sat,  7 Jun 2025 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtKcuTqx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F246A33B;
	Sat,  7 Jun 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749310215; cv=none; b=KUmavWb0EqivRsXAGmFK0IN1NPdrGM8uMfJgmFuBJY33IjioHPcLo16+YatUcbEXmCsaz8/vsG7DXsJfBStYeHbLMEPIS0nZyJDYQkeIMpqiYFgTF6L6HizjZJPzSpwQe4keMX/ZZeGHK1kTbjXtwJgk14h18xyqPdCHrJltYlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749310215; c=relaxed/simple;
	bh=sKLJ4kqThC0sq9tHJe28wjzBnsYeSUl8eVTtMw6w7Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCptqcHW+hkxQUovCWUPkkgP9EG6p64j79H/VcMow0k19WiVIhsey3pyiYW8bJ7EOnM5baEab2BYMOzHtOLuCV8G2fYpTHixKxEWNSJy3GMqgM1O2fDR3wHh3xihBp0L5i+WCehqiDFVQunQNRjMh1bKEfFFRrrJbMw+PF7IYG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtKcuTqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FAEC4CEE4;
	Sat,  7 Jun 2025 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749310214;
	bh=sKLJ4kqThC0sq9tHJe28wjzBnsYeSUl8eVTtMw6w7Qo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JtKcuTqxNFkIqCZvcIgYM76jlOv/FOoHHN6heQKOFsV54aCDxtu4fbt6BuXM5fyZm
	 NEiEBaEG1EapV3JJhhRcVPbHYPO409vaatyvjwvoLK6Ai/j8KopoqdAVkfa0bM8cFY
	 zspq8OhpgBliZDx50vBOMJGqdGVldfL+AEbXl5wu7QSiU+Ype9AI5WyIkDGMkzUSfR
	 ytxWWxxvYTIkSkuu9Zgvo+GhqOtAQksKPwiJMo3bHnEUkFUzVclD/788bkocOmzyPK
	 qSXDi0x6oRwtATeqsR8qFNxRzCFO8/CbojlTjCHIf8kKVGzJdKCn/mfgl9UOHb/37x
	 ESz1tGgX1fc7A==
Date: Sat, 7 Jun 2025 16:30:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH] iio: adc: axp20x_adc: Add missing sentinel to AXP717
 ADC channel maps
Message-ID: <20250607163007.21da58c0@jic23-huawei>
In-Reply-To: <20250607135627.2086850-1-wens@kernel.org>
References: <20250607135627.2086850-1-wens@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Jun 2025 21:56:27 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The AXP717 ADC channel maps is missing a sentinel entry at the end. This
> causes a KASAN warning.
> 
> Add the missing sentinel entry.
> 
> Fixes: 5ba0cb92584b ("iio: adc: axp20x_adc: add support for AXP717 ADC")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Applied to my temporary fixes tree.  I'll rebase that on rc1 in next few days.

J
> ---
>  drivers/iio/adc/axp20x_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 71584ffd3632..1b49325ec1ce 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -187,6 +187,7 @@ static struct iio_map axp717_maps[] = {
>  		.consumer_channel = "batt_chrg_i",
>  		.adc_channel_label = "batt_chrg_i",
>  	},
> +	{ }
>  };
>  
>  /*



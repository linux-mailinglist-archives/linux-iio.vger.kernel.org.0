Return-Path: <linux-iio+bounces-11342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A389B1860
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EBC4B2330C
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA371D362B;
	Sat, 26 Oct 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sugXLD8a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C001AB641;
	Sat, 26 Oct 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729947760; cv=none; b=XSsTWiL/TG9qWMglIoWp3AoUFdOT8srk6FQLugzF4C7ec2/P1fs3NBEy/jZEGkri0sEzQJ6zeul/4EFFvBy4bYTOfLeekSehijqFYixcw8EApP6jqLkYILfp6b1+wURf5cq3a5WXm1NC6X+5hmIoE0zRWNW5jY5NtwoTEORJ3Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729947760; c=relaxed/simple;
	bh=hSLRs/NeqhqcDbsXjlXESVgnbwx92MSxD/rnmFcmeXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qu2Gl4nvLvzipB8WOOLQyj2V4ZZpYqafqO7ym5SXYk4Rm7XbeJkzz5KJw2SWkhyIiEsmzp/35mPh2AFTGmTMM8BtTdrzkk3hMEOiQMz/69zfP4Dh87RYMGWBSIqpLTJQMg+cqyD7OQ1m6tVbA60QH6WwrybfQ1cVPmAKrr6MFRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sugXLD8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4C1C4CEC6;
	Sat, 26 Oct 2024 13:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729947760;
	bh=hSLRs/NeqhqcDbsXjlXESVgnbwx92MSxD/rnmFcmeXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sugXLD8aXvmYkZ3vakl64jPSmTQiAGwdOVsmLQUGQtJGq/fumi8monfQwXo8ZL5dl
	 +RRpN3x+OkWSQfa/RXtIYKSyJo2NC5TLDv2X0/9YFrECf6npjgUCUwFSADiP19v+Li
	 jvquRjOTC+apuUy+fmAYpaw8PXs+4z1IESsWhRLn4AE2nr0TB83Y0JYiDAJqzgVr0/
	 MERsTK553q1zDDRT8PaLDkuUbDACurUaQY6JtV4jMBhpma023NBqX0dKOUL8krFPN0
	 xSuw8eMshXKq2ENbUwhJFRJCttUqCO9A4+pG0j+k5kfenuTgFN858YnpALTFOiaIqc
	 vXlP4+moKQCkA==
Date: Sat, 26 Oct 2024 14:02:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: bmg160_core: remove trailing tab
Message-ID: <20241026140217.620a8d21@jic23-huawei>
In-Reply-To: <20241023-iio-gyro-bmg160_core-remove-trailing-tab-v1-1-9343c7dc4110@baylibre.com>
References: <20241023-iio-gyro-bmg160_core-remove-trailing-tab-v1-1-9343c7dc4110@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 15:39:40 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> Remove trailing tab
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Applied.
Thanks.
> ---
>  drivers/iio/gyro/bmg160_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 10728d5ccae398d15c1d51e0380306042675d5c0..9ae03631090a4ac68ffab92726ee8b8e9c1bb401 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -444,7 +444,7 @@ static int bmg160_setup_new_data_interrupt(struct bmg160_data *data,
>  
>  static int bmg160_get_bw(struct bmg160_data *data, int *val)
>  {
> -	struct device *dev = regmap_get_device(data->regmap);	
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int i;
>  	unsigned int bw_bits;
>  	int ret;
> 
> ---
> base-commit: 9090ececac9ff1e22fb7e042f3c886990a8fb090
> change-id: 20241023-iio-gyro-bmg160_core-remove-trailing-tab-19904deebd9e
> 
> Best regards,



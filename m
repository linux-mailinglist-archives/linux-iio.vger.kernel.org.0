Return-Path: <linux-iio+bounces-24508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E478BA6277
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 20:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72034189CB78
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 18:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A12522FDE8;
	Sat, 27 Sep 2025 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9Vnr79J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D67181CFA;
	Sat, 27 Sep 2025 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758997220; cv=none; b=p8Te0kFZJnM0yABqLYC0k1LjIdXkGXjwiOA76aIPy4wdd6K4VJWHKObJqsvdmbc/42Hj6jDsGnVRFjqD5tofX/+b+z37xxaIMbsr68Sa0rqwKyHyJtugu5thihtyFbLWGKe5QreZ0+EmNy87z8yXFxkudAjmQvpqWqJHMrCai8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758997220; c=relaxed/simple;
	bh=OCw3WrBvUQX9qxFyK/5ffbl5o7wxLoSTXxcs11hVamE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWUPffnc/ZqZAX1knN0ZmVkpArbE+S1iB5XwwvUaxQ9T51ym9nyYU9FuAvHYwvQEPEkll0PIXz0SAvuIV8G/gP38m5w/yP+izgwlP3NYoMDX3CuPAwknakacYRXWb+Slwv5ei7zhtpd0l1Bv2zr+HxPsS+e5I9Hvr1GrPmtx8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9Vnr79J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF3AC4CEE7;
	Sat, 27 Sep 2025 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758997219;
	bh=OCw3WrBvUQX9qxFyK/5ffbl5o7wxLoSTXxcs11hVamE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L9Vnr79Jcr57bprizgUZlfzIvNbocdi3em7xwOXkgkALkNAPOHs+dx2C6QrOKbSCD
	 73rKuHIi29UZv1sFXsFbypX3XNo5vnDtvxz7hkeNPhPJZJOYwFcRX7KHX3ZEwfxBDX
	 0Jx46wX4pSa/ACTAQfcTseBJ+3ogiiJfYBdcyPGw012hfXVFYim1BFhJ1eppUT2W8E
	 UFGNpl3MiCyfpd3ewjWgN60aXgU4AquTCFQfbJp+940QBXDwBqw6M7TRdhlflo7LLi
	 wF3+DoAnL8swFPnEUFwZOiQSbyxENZAw6qArLx7qqey7HvRSepqfvd3ixI+f+7rR+V
	 UCQGiWu5c0yig==
Date: Sat, 27 Sep 2025 19:20:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: add ext attributes to temperature
 channel
Message-ID: <20250927192010.6d6427a3@jic23-huawei>
In-Reply-To: <20250923-iio-adc-ad7124-add-ext-attributes-to-temperature-channel-v1-1-173baac28169@baylibre.com>
References: <20250923-iio-adc-ad7124-add-ext-attributes-to-temperature-channel-v1-1-173baac28169@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 15:33:18 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use the same .ext_info for the temperature channel as for the voltage
> channels. In the ADC, these all go though a mux to select the source
> and otherwise operate the same.
> 
> These attributes probably won't be used much, but since it is trivial
> to add this, we might as well include them.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Seems unlikely this with clash with the fixes in flight so
applied to the testing branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7124.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 374e39736584f55c1290db3e257dff2c60f884d2..7ed31399a875b76be08491f56acff55032c95ced 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -1348,6 +1348,7 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
>  			},
>  			.address = num_channels,
>  			.scan_index = num_channels,
> +			.ext_info = ad7124_calibsys_ext_info,
>  		};
>  	}
>  
> 
> ---
> base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
> change-id: 20250923-iio-adc-ad7124-add-ext-attributes-to-temperature-channel-dd963150dea9
> 
> Best regards,



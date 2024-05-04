Return-Path: <linux-iio+bounces-4789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CABB8BBAC1
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 13:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C7728249D
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 11:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85281C687;
	Sat,  4 May 2024 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWHfezVO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA510A16;
	Sat,  4 May 2024 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714822128; cv=none; b=AyosjvCnfMsOhmxNLtFfip09TZ4smXpzgmvX61nPXNzkB0gPaZ1fiAH/uFt2lxvR1syPHb84yRX5M4PfkPLW+JAh6QEFBkGiHa2+sCV5pTrDraKx0U1GFjsQTzs+0gJMsTotUAf/5N129Hwjpcvr0vEM7X+iJi71oarl20S9Md0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714822128; c=relaxed/simple;
	bh=Fnb+vdj/e1q9bTrUIyIq+b+Gwy/enK2PIKyaep0tiR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DlxtyCkCfBgN/02zkYM2Q7Up4lC58sw1riP5Cy9ejEmM9JaZPXshqPL9WDWN4btjFr9KP7umJLfLSaJOIEy8dMG4nrf762x66R1l4AEA350qoZ9fYNsYky9VY7G058wKwOa/76ybA5B29cr2CSNwC6BUdNQL4ISx7EBoWd6NxUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWHfezVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A430C072AA;
	Sat,  4 May 2024 11:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714822128;
	bh=Fnb+vdj/e1q9bTrUIyIq+b+Gwy/enK2PIKyaep0tiR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oWHfezVOSrsc9L6Gq3Tzix7Y9Twvotoa05UPaEL2lG86BfMQh8b4S2/unGIcwDkrN
	 hztBZACwkJg+eaV/jD92hVTN5aQiDRRbG6Eydmh5tJmQCzNug2THVS+bQPJFNlC9bf
	 zGbLQHBXviUiP81DdOkZUXH83/wA7F9IhtSNZRvWA4mWeGrhlUvIqY7fBy6x3/Rqhx
	 GN+5Mz9Kv9BEPqPhiygI21Xc7lpkwwLUZvaJfQ457EMRC/QXUVlG4x8kdnTGZpAfZm
	 oPsYtqK5a/tEJ3DphU6NugOYAeeiNSh5FFMatXEU/kX/2N3/nMM9vWQiHMXA43R3wS
	 yf5dWGLH93WCw==
Date: Sat, 4 May 2024 12:28:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad9467: fix scan type sign
Message-ID: <20240504122836.51277cfb@jic23-huawei>
In-Reply-To: <20240503-ad9467-fix-scan-type-sign-v1-1-c7a1a066ebb9@baylibre.com>
References: <20240503-ad9467-fix-scan-type-sign-v1-1-c7a1a066ebb9@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 May 2024 14:45:05 -0500
David Lechner <dlechner@baylibre.com> wrote:

> According to the IIO documentation, the sign in the scan type should be
> lower case. The ad9467 driver was incorrectly using upper case.
> 
> Fix by changing to lower case.
> 
> Fixes: 4606d0f4b05f ("iio: adc: ad9467: add support for AD9434 high-speed ADC")
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the fixes-togreg branch of iio.git.

I'll probably sit on this until after the merge window though.

Marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad9467.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index e85b763b9ffc..8f5b9c3f6e3d 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -243,11 +243,11 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
>  }
>  
>  static const struct iio_chan_spec ad9434_channels[] = {
> -	AD9467_CHAN(0, 0, 12, 'S'),
> +	AD9467_CHAN(0, 0, 12, 's'),
>  };
>  
>  static const struct iio_chan_spec ad9467_channels[] = {
> -	AD9467_CHAN(0, 0, 16, 'S'),
> +	AD9467_CHAN(0, 0, 16, 's'),
>  };
>  
>  static const struct ad9467_chip_info ad9467_chip_tbl = {
> 
> ---
> base-commit: 827dca3129708a8465bde90c86c2e3c38e62dd4f
> change-id: 20240503-ad9467-fix-scan-type-sign-425daca1bb83



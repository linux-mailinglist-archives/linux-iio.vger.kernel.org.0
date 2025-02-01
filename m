Return-Path: <linux-iio+bounces-14813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B54A24931
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 13:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15EE4163E11
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EC31ADC8A;
	Sat,  1 Feb 2025 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijJ6IcKH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7210E0;
	Sat,  1 Feb 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738414658; cv=none; b=UxeFX1Tmkc5h5mNdk2FSP2dyXtsYS/BQcvjqDcdZrw4GIl0bpvOcASksQzHmuLcxKqPjXRXfscwkE/j8s4azp14h129pGXt3jQ0H5DLqCLavjW21kxtrMkOBlMZQxdN11ejsCixxopH6jtiAKr+SxQoh9bBrHUegpnc+GqTip4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738414658; c=relaxed/simple;
	bh=qulMGWEaxKDR3NmNZoY7QPtBJBUJqndbnaNhe/PRuJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlNK4vBBrJqLvJUiENpNvrLsLA8HmXWHxcY6FknD8WLeZyln8nTdmdEF1DFM4xSSF0avM2N/GZ2hK5ndEi/AQmKPTpvk+AWZ2HQ/7OdR/jCMs+FE3v6y665uo1oyl8j0QTdEG18KwRnuouqV1j+rGswPwRgy69H2k/cYk4OOIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijJ6IcKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E73C4CED3;
	Sat,  1 Feb 2025 12:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738414657;
	bh=qulMGWEaxKDR3NmNZoY7QPtBJBUJqndbnaNhe/PRuJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ijJ6IcKHHMeGeSk7qpqsyV7mwD87joxKXaUuLunMKugg8kfcet3BF2Yzc8z2bJwvu
	 FOwKuFyVY4S6U136az91EOHDK6BKjWHHZd7ehRawF+uzISbfRI4jnrm4h3YQDXoqFS
	 DKNTzSdeFLCOfBNlPenevLhBaHOOnDCe+TI3YtF8f4ssOyB21NS5s3S6PVtANc8sFj
	 hedAoVxF4vAJHR3jabiS42xbb2P1HrJlewhM4xL5Q7nmsXgcsdxRj+imNL8uNBsyGz
	 pDdNHiRSf+F7V49muiLoWwoPuW/oJe2d4khTMLTtISXoRslHRL1xyFo6d8La23h0i4
	 F7P9s/tQzs54A==
Date: Sat, 1 Feb 2025 12:57:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alexandru
 Ardelean <aardelean@baylibre.com>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Guillaume Stols
 <gstols@baylibre.com>
Subject: Re: [PATCH v3 03/10] iio: adc: ad7606: fix wrong scale available
Message-ID: <20250201125730.1794a852@jic23-huawei>
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-3-c3aec77c0ab7@baylibre.com>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
	<20250129-wip-bl-ad7606_add_backend_sw_mode-v3-3-c3aec77c0ab7@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2025 12:03:04 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix wrong scale available list since only one value is returned:
> 
> ...
> iio:device1: ad7606b (buffer capable)
>     8 channels found:
>            voltage0:  (input, index: 0, format: le:S16/16>>0)
>            2 channel-specific attributes found:
>                  attr  0: scale value: 0.305176
>                  attr  1: scale_available value: 0.076293
> Fix as:
>            voltage0:  (input, index: 0, format: le:S16/16>>0)
>            2 channel-specific attributes found:
>                  attr  0: scale value: 0.305176
>                  attr  1: scale_available value: 0.076293 0.152588 0.305176
> 
> Fixes: 97c6d857041d ("iio: adc: ad7606: rework scale-available to be static")
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7606.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index d8e3c7a43678..d39354afd539 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -1047,7 +1047,7 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
>  
>  		cs = &st->chan_scales[ch];
>  		*vals = (int *)cs->scale_avail;
> -		*length = cs->num_scales;
> +		*length = cs->num_scales * 2;
>  		*type = IIO_VAL_INT_PLUS_MICRO;
>  
>  		return IIO_AVAIL_LIST;
> 



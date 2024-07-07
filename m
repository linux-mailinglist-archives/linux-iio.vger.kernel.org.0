Return-Path: <linux-iio+bounces-7412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 455B99298BF
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 18:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4292D1C208A8
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C5137700;
	Sun,  7 Jul 2024 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+BCGpPn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BCDEDC;
	Sun,  7 Jul 2024 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720368324; cv=none; b=chCG0tAyZ8a7voAwEF4g746SFduMe0Mu79TED/vDefZecmLSnVNsR4DA8nbJytzZSjnRcclGOLVm3+iLCI/nCVuFAfKhhhf9mua4RhRKlPEYYoR0td1fVaG1B80ur3dhrGc+/ywS62+wVHfdkoNBx/gALTLsO0H8PCNURkAo7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720368324; c=relaxed/simple;
	bh=Lkcda6feLFehLcPTehFJduuyzJx0786EXxF12GUBEJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4g2A3MlRR7Ndg0WMEmOrGjcsnpk8uDK1nelBluXBl7ExjgL2cCbE0M5hqYCLn+99+Df7Mv2qLtvcoOLpVJ/85xg1A773fLiikhj0YjazvbJBvuOkeWiqaunawIzrS8bdk8Qw5VFL1RsDPF/jmanYe+piD0V4O9PmLSzfHUvCLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+BCGpPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3FFC3277B;
	Sun,  7 Jul 2024 16:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720368323;
	bh=Lkcda6feLFehLcPTehFJduuyzJx0786EXxF12GUBEJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f+BCGpPnIlEU++hllnoHTOVOVRqbIdrjH8AYrx62thtcVli+6PL72+HYLt22mltcL
	 lhWuBlVuu1Ks/6GxLcqOunur9uPMHRiZTYdjFDqw8ILn4zronkLc8St7/GuPbDj4zj
	 C2j8P7HLeHOvSSbLIlbGsjzlRb7/RZ5a6HcTR89xZi4hBfAJJuFwa4KHDW3z5tqtvf
	 SmcbsfvVwCfzmdZx3abDw8fkg4JlEWhU+rZY9KLKN1rduueszar1E2FPaAZB52BEFi
	 MArCQRt4n/MgVQ4d63r5DGTIf851vdCSlWC/XijwTmOLYNpK4NT2n3MKKi46fhUtJu
	 4wndx4NYAY8pw==
Date: Sun, 7 Jul 2024 17:05:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ABI: testing: fix admv8818 attr description
Message-ID: <20240707170516.49e17d19@jic23-huawei>
In-Reply-To: <20240702081851.4663-1-antoniu.miclaus@analog.com>
References: <20240702081851.4663-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 11:18:50 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Fix description of the filter_mode_available attribute by pointing to
> the correct name of the attribute that can be written with valid values.
> 
> Fixes: bf92d87 ("iio:filter:admv8818: Add sysfs ABI documentation")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818 b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> index 31dbb390573f..c431f0a13cf5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> @@ -3,7 +3,7 @@ KernelVersion:
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Reading this returns the valid values that can be written to the
> -		on_altvoltage0_mode attribute:
> +		filter_mode attribute:
>  
>  		- auto -> Adjust bandpass filter to track changes in input clock rate.
>  		- manual -> disable/unregister the clock rate notifier / input clock tracking.



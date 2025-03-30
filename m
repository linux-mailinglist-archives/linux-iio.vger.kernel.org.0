Return-Path: <linux-iio+bounces-17363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF87AA75B4B
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32B637A5664
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099771C5F25;
	Sun, 30 Mar 2025 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM+uuaso"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10635973;
	Sun, 30 Mar 2025 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743354529; cv=none; b=rxIu/FybtQIvp9XON4ZjKsBif58cTqR3J/6VOYQbMt3oujc1cucVNHpQF4BUMmiRnvoaJ5qg6ULW5uEblX1ktfCKSr0c5dWdj8YbtC0VvHH5Hh3N5k7799pjTxDY5OcVgUYwX+XIroK/7C8R0dh/R8BI1Os9A57AaQ/zjvoDUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743354529; c=relaxed/simple;
	bh=3Xo51OAIBEGXV8OSmP6fgErtliftIacrPEMxpo37e+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdRie99aI3AyqCFYsH+4Fg7q3RTvx/4Wik/TvNxOpP45a4wxm78ulWuCifvk/Cv/ZkOXcSuOpAdNd7aZIFA3bGezR27hM8BzSvZtZ9IS/lF7xv7MkvtuRBvMFRh8A2NoD58pF0Ss24U3rmnn6Z51gqKBROIIchqLwomYRahgdgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM+uuaso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABECCC4CEDD;
	Sun, 30 Mar 2025 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743354529;
	bh=3Xo51OAIBEGXV8OSmP6fgErtliftIacrPEMxpo37e+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GM+uuasoAe85juqAo/HCycflDjXi3t74yL39JeDIFurDUFJ0W9k7xcKApREBB0Yqb
	 kRvTktpH3/NCYl35AuzLdoJ0rgSNJ7L7TmwwXazlyvt3Vw8gDx8W200a3AW20S9bw9
	 64yWs98aU7jYUv9uCZZYJ8etC2Mz6mcCI056Sc3NYOLUTmjJOzkgNQlWI1wPDE+Lqz
	 aT/nKN+2cZHed/zauX7uMVQLKIZeUdSGTodQ6Nlh0Kib7HXqUNyb6gOy4Hnxi5e1Rc
	 Aa/y6ifgyZxrp2+fl9lVwFBQpAFQiUQu1dpraF1YFOfo2TP76U6YnVNcveU7Bsyq9E
	 67J/NEF7u9qzw==
Date: Sun, 30 Mar 2025 18:08:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <dlechner@baylibre.com>,
 <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Documentation: ABI: add events sampling frequency
 in sysfs-bus-iio
Message-ID: <20250330180842.0e0bbc5c@jic23-huawei>
In-Reply-To: <20250321-abi-oversampling-events-frequency-v1-1-794c1ab2f079@analog.com>
References: <20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com>
	<20250321-abi-oversampling-events-frequency-v1-1-794c1ab2f079@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 15:50:01 +0100
Jorge Marques <jorge.marques@analog.com> wrote:

> Some devices have an internal clock used by the events to space the
> conversions.
> The max1363 introduced the option in
> commit 168c9d95a940 ("iio:adc:max1363 move from staging.")
> and ad799x in
> commit ba1d79613df3 ("staging:iio:ad799x: Use event spec for threshold
> hysteresis")
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Applied.

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 722aa989baac43f694076074b307d134867b4533..33c09c4ac60a4feec82308461643134f5ba84b66 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -94,6 +94,7 @@ Description:
>  What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_sampling_frequency
>  What:		/sys/bus/iio/devices/iio:deviceX/buffer/sampling_frequency
> +What:		/sys/bus/iio/devices/iio:deviceX/events/sampling_frequency
>  What:		/sys/bus/iio/devices/triggerX/sampling_frequency
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
> 



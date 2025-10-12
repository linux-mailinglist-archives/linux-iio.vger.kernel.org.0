Return-Path: <linux-iio+bounces-24951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86280BD033C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4077E3B0EAA
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48840280CCE;
	Sun, 12 Oct 2025 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk3ypCG6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D4B1E833D;
	Sun, 12 Oct 2025 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760278577; cv=none; b=UXBPPGdoWqyqrtWeR3sZhqKCrjP2f5GBy8jZD/ZycPKPRvxXlTh9YPix6ss0j7zKcFH7voVnQdsuzVk6fvsHu3blHkAoTXC5TwBM3MNgR50R2ynEm4Pa/PuAI3AH3H1X9p3k5QS7CAoCcjtj5Sp/lDPcTNMHpfzA8JSkZai8H5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760278577; c=relaxed/simple;
	bh=s0QOXXhU5Mdg6/4TltjaRzhDYtBXJYb4T4EB2oiLdrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikWCkRIlOaIk5xwAjAAz/Io/7v0TI1DesX0mfYF1U6WxMl9SLRTGDUYkjVILJtjoKvW1pEzX1aK63zNV2TfNc4k2ncZfUHtfLHRBDo5CimErrZx+ZMai8hkZTK6pSRikj7D+lzfUmSB1KHICux0c9LH06D0tFgj+Wvh7/4PcbkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk3ypCG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F34C4CEFE;
	Sun, 12 Oct 2025 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760278576;
	bh=s0QOXXhU5Mdg6/4TltjaRzhDYtBXJYb4T4EB2oiLdrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kk3ypCG6htXMXEVTgNt1pC9hUjsK6DqCRr+yiEOcjktJOMK0pV966Cd/VFQUeF7Re
	 0XNXQEw88qz2SDEr+4INt+zO4UY/Ns0Het9TK21SdK7hNNrdFfPBqKVSQ09ZmNmB/6
	 hx4HlnOb2VxdDBE0rdj4utHD3phhJ64vEQ3XV9mhowaE8cA9Fp7qxMLfhn9Ttu1QzA
	 hfl9OMiBg9p+MVUHvUJgZFd0a0swEVj03LbjevA9DVNJPSCK1Gm5D/P9qQ7ousolaV
	 ek4YX37KDkJmgmb/KoN6JPieIyOWgwEhhYNbpKXc7dh7oKhV3+8TkIMKqwSX7M5ErC
	 zmUytwb8LP24w==
Date: Sun, 12 Oct 2025 15:16:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Add ADCs support for RZ/T2H and RZ/N2H
Message-ID: <20251012151607.2d50e3ea@jic23-huawei>
In-Reply-To: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  5 Oct 2025 14:13:16 +0300
Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com> wrote:

> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include three
> 12-Bit successive approximation A/D converters.
> 
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.

Hi Cosmin,

Looks good to me.

Applied patches 1 + 2 to the testing branch of iio.git.

I'll be rebasing that on rc1 once available then pushing out as my normal
togreg branch for linux-next to pick up.

Thanks,

Jonathan

> 
> Add support for them.
> 
> V4:
>  * pick up tags
>  * require r9a09g077 as fallback for r9a09g087
>  * remove per-SoC restrictions
>  * add depends on ARCH_RENESAS || COMPILE_TEST
>  * inline RZT2H_NAME, RZT2H_ADC_VREF_MV, RZT2H_ADC_RESOLUTION values
>  * remove renesas,r9a09g087-adc from of_match_table


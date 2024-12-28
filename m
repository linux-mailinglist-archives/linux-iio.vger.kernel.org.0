Return-Path: <linux-iio+bounces-13829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F6C9FDAB7
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 14:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE8F161F93
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 13:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF67F156237;
	Sat, 28 Dec 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMqoFzNj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A39C8DF;
	Sat, 28 Dec 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735393228; cv=none; b=ozGY3znL1aVxFT8sM2HurWQ2YZbnQFbQnURnfsF7vzc1jNnkDfh0YugcfN2/2DamvEPbK3blwh7SUWdHBwHaCdrLgjZcf9F91zgHUFiRdTR3XBU4sckfmeP52HEy3HlBXewg6J/Phzs4s7djvNbE5hDUTfayTuokXOm9Pk6IYZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735393228; c=relaxed/simple;
	bh=Ws77mFO+Nb16yI+ZZOatgdOyPQiA00A6vd+eNtyHFOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVpfSiGp64N9aBULF4exGBJX7/DRPQffYUtG/648BckAtixfwfp77zTEXkBE36NlnRgx2zdwgPwb7j1yed1cXN/abzdZfvOiowaKIXuIWoyAniCoug+75am80evsRBhAprArTTaHO5Wvql85uQsHgnAS15R7I/CsD6HBuK3crVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMqoFzNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58F9C4CECD;
	Sat, 28 Dec 2024 13:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735393226;
	bh=Ws77mFO+Nb16yI+ZZOatgdOyPQiA00A6vd+eNtyHFOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fMqoFzNj25bHV/NuP1qtroxtqMG+yyQlsf8jC5lCufwQ9OC6fg6GebqQj4OjZJYtL
	 hMkoakx46m8qtazpy6i/FAbcE2cyM8Hi7S8rtPoRhOubL59+UoO80cFrovMOHy5wDe
	 zv+SG5Vps683HwwDWy+h1Y5+6LXvGarfXeBgVAxvw/PmoX1YRe6RNQyqzhg9x5THk7
	 Ldl/z5YmvtMpr8fFuZq/d1GAVimWz57exbq0G9fSIYV6hamc2f8gaR7+HqbwTqbfTP
	 EurlzY0obPVdlCApale+v9n3dCYgx5V1lRNXfBT+Tb+GIwEqFJXCwMRvbMnr/63enh
	 wlwnaCyBDPDTQ==
Date: Sat, 28 Dec 2024 13:40:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
 lars@metafoo.de, gnstark@salutedevices.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/3] iio: adc: meson: a few improvements
Message-ID: <20241228134017.321c7e60@jic23-huawei>
In-Reply-To: <20241224142941.97759-1-martin.blumenstingl@googlemail.com>
References: <20241224142941.97759-1-martin.blumenstingl@googlemail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Dec 2024 15:29:38 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> This series contains three improvements to the meson SAR ADC driver.
> None of them are meant to change the existing behavior. The goal is
> to make the driver code easier to read and understand.
> 
> Changes since v1 at [0]:
> - drop the patch 2 "iio: adc: meson: consistently use bool/enum in
>   struct meson_sar_adc_param" for now as the purpose of the fields is
>   unfortunately still not clarified
> - add space to tab conversion from former patch 2 as a separate patch
> - Cc linux-iio (which was forgotton in v1)
> 
Applied to the togreg branch of iio.git

Dropped fixes tag from patch 1.   A typo fix on something entirely internal
to the driver is just cleanup, not a fix and definitely not something
we want anyone to backport!

Thanks,

Jonathan
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20240324140429.5484eb54@jic23-huawei/T/#m81d92c2192de1936646543543501d8a62527da8d
> 
> 
> Martin Blumenstingl (3):
>   iio: adc: meson: fix voltage reference selection field name typo
>   iio: adc: meson: use tabs instead of spaces for some REG11 bit fields
>   iio: adc: meson: simplify MESON_SAR_ADC_REG11 register access
> 
>  drivers/iio/adc/meson_saradc.c | 47 ++++++++++++----------------------
>  1 file changed, 17 insertions(+), 30 deletions(-)
> 



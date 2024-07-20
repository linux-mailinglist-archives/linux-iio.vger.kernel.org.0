Return-Path: <linux-iio+bounces-7725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FD69380DE
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CD11C20FA3
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 11:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D993284DE0;
	Sat, 20 Jul 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/r1gg2Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA0376E5;
	Sat, 20 Jul 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721473477; cv=none; b=UK0au9qEEYxvbs4BEFesrOIm6oAuXY0fIa9X4IiKAfw6FOk6UD0tyRbsGzOLYkxdhHv8HK1B02ZEgbci0cRwgn74YIht9pZSP0O7FhN9yqJPmqJJxTikq7S/j9srm3Clwj95T5lFyrNd8QIPVb2CJ9nW2t5hV7u174XFLX+NDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721473477; c=relaxed/simple;
	bh=TrhzxeHjudHiGp22YEXDuaPYucVMuwE1JHaOyZaFXck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/Z69NEJFg1nik1NcH/4qLlpR0ae3HYa/Klnymbgc/+ebrtm2n6cCPJGR29UNSRWbcja1Skk+st1mbKFb5t5hyox29aqiARJscBhc3gIG0TOx0h2hofQhDD8PaW5zL5bVIiFmfS7B8N4Ng4yMPmFmMg7xwWHJI3U8u8Bh/83NoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/r1gg2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F105C2BD10;
	Sat, 20 Jul 2024 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721473477;
	bh=TrhzxeHjudHiGp22YEXDuaPYucVMuwE1JHaOyZaFXck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F/r1gg2QChWWxTSDXrHe/IlcAgdjpMEHwAYda/nvH7mcvunFzAwAeE3zeS6HK4sgK
	 oiBXbmsXSFP03zwKYrKG5RXrxicmcgad4dqBy+8wMOvZlBtczwAeLVSQ0n8grQW4UX
	 T5C2l3IsPPzzSbFXc8/33CA92Hfhm8sNb48hLZuCbWc11rvWIonJPvNpD72A5Xhpz6
	 3YK2h8c6w9t6e3SuuBDQhVnO8XrL1x+h42HEc6bNUA1XTFqm3nFlzqTBa9B9cgMb4q
	 9BGGO5St1JywEj4aldYTZSdYpIxNUgQWlhvtQWuRRphED3vf1bsW7wMDKd4pfIjJeQ
	 +pwF7zqcpeHqA==
Date: Sat, 20 Jul 2024 12:04:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/10] iio: pressure: bmp280: Fix regmap for BMP280
 device
Message-ID: <20240720120429.46aea886@jic23-huawei>
In-Reply-To: <20240711211558.106327-2-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
	<20240711211558.106327-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 23:15:49 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Up to now, the BMP280 device is using the regmap of the BME280 which
> has registers that exist only in the BME280 device.
> 
> Fixes: 14e8015f8569 ("iio: pressure: bmp280: split driver in logical parts")
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
This fix is for an ancient issue (2016) so I'm not going to rush it in
but will mark it for stable inclusion.  Advantage of taking this through
the main tree is we can move faster with the rest of the series.
So applied to the testing branch of iio.git which will be rebase on rc1
when available and become togreg for this cycle.

Thanks,

Jonathan




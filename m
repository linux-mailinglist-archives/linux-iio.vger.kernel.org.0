Return-Path: <linux-iio+bounces-8030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B78993FE71
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 21:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508A31F23DBC
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 19:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA830188CAD;
	Mon, 29 Jul 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k98QF0TB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92517187858;
	Mon, 29 Jul 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722282037; cv=none; b=cGoMwfutE4vv8ruOu2CthTjZHjDltSXfKFNoLJRxVcDQHQwhWez5fKIeI8FBybITdPKr2Xww107oIPgnsKHy2rrIVoinuVz1k5Uv7CNuBeVSP6ETKjwkigS858yuI2u7n1VY9suQd6pLDSCbS62B1Spb8+ko8RvzI2qYyy98nRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722282037; c=relaxed/simple;
	bh=SBQ2pH87hA0aDlWEhXjDb2G7eJUp6np1Zn/k71CFvCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksbqpZokCgIkwmOxnCCT0+KhugONJ4/5EKiV8nqq7BiBi23OoV41NX5HhfDxzpNgCPc0Xoyq3uopPRvra+WoTMnxSUE0RJM90Ffknv5KiIuqnhuKI/3qPtPNDdlJlkodKuFGOygKGiS0Acf6EW4vp1u277ysq1O7IVWeMEBaxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k98QF0TB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EF5C32786;
	Mon, 29 Jul 2024 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722282037;
	bh=SBQ2pH87hA0aDlWEhXjDb2G7eJUp6np1Zn/k71CFvCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k98QF0TB/OGdFu8g7+GgDbj6VjlbTXhQXIaNhxgRzQSFYQiTprTp0ZxMP/TgBukuM
	 cfdY5vBZSqllwf4v7NUAouDeWHKMGVIDk+9cCKO1KXFQMtFrhlbzZF4nxulsk6WNEH
	 sl9o9H7H0W4YmTZISeChBIOsVX2YYaN6QbUXHjsflfDJkC1uG/7JbsJ8Io19uHl0Xy
	 GsdC7imSCUD7V7cVycqpa7JyxoxMBjzNLmKgpWexNqzDVuO/XPGT+ATIWcOjrYupOY
	 CxfxD2ma3lcx8zT+H+xCkvRgwMVi+jDTx8yYMXl9aMo5LqDCr0xFHRcW1IgLlGdSkJ
	 cRLZg85bkiq/w==
Date: Mon, 29 Jul 2024 20:40:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, corbet@lwn.net, marcelo.schmitt1@gmail.com, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v6 0/7] Add support for AD4000 series of ADCs
Message-ID: <20240729204030.038e4aa3@jic23-huawei>
In-Reply-To: <172227614374.120386.3055005856415965055.b4-ty@kernel.org>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
	<172227614374.120386.3055005856415965055.b4-ty@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 19:02:23 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Sat, 29 Jun 2024 16:04:00 -0300, Marcelo Schmitt wrote:
> > This patch series extends the SPI bitbang, gpio, and spi-engine controllers to
> > support configurable MOSI line idle states.
> > It then introduces the ad4000 driver which uses the MOSI idle configuration to
> > provide improved support for the AD4000 series of ADCs.
> > Documentation is added describing the new extension to the SPI protocol.
> > The currently supported wiring modes for AD4000 devices were documented under
> > IIO documentation directory.
> > 
> > [...]  
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/7] spi: Enable controllers to extend the SPI protocol with MOSI idle configuration
>       commit: f58872f45c36ded048bccc22701b0986019c24d8
> [2/7] spi: bitbang: Implement support for MOSI idle state configuration
>       commit: 320f6693097bf89d67f9cabad24a2b911e23073f
> [3/7] spi: spi-gpio: Add support for MOSI idle state configuration
>       commit: 927d382c7efbcc2206c31fa2f672fa264c0f1d5b
> [4/7] spi: spi-axi-spi-engine: Add support for MOSI idle configuration
>       commit: a62073f4b2164028fc7c5ae45ceba10c9326cd91
Hi Mark,

Any chance of a tag + you seem to have also picked up the ADC dt binding.
Patch 5/7. dt-bindings: iio: adc: Add AD4000
which I'm assuming was not intentional.

I think I only need the definition of SPI_MOSI_IDLE_HIGH
for 5-7 to build fine.

If needed, I can use a local value for that in the driver and
we can follow up with a patch using the main define once the trees
come together upstream.

Jonathan


> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 



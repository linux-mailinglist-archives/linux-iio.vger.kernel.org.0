Return-Path: <linux-iio+bounces-8034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 976F193FEF1
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 22:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF71F2278A
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 20:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E093188CAD;
	Mon, 29 Jul 2024 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwRY8h/k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81A2E859;
	Mon, 29 Jul 2024 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284145; cv=none; b=hc1jqsOUtN3Ipy9TSWvbUf89bk7mw44uKT1gaySlNCuf4yoIeZrvvvhos+UmezbmdA71txuFjT4ktn+McN+S7FUz0rW1Ua1B1nESUggxghRyAXHnBgkionSu2ilAy7d9PNt8Bz+BJIe6kBgrbMwwzeuiSgLwqwSym9NErR3ySIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284145; c=relaxed/simple;
	bh=G7e0pk1Djj/HwrbGLFs9VMQw5zvXgCjrk/KMk86/0zg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbaS1EdCZssIgsftfMmDBCdUDZ8b5FpYXjY15/w+9tt74IwwnIBtgaffDR3Q/fhh9IFAn9z8vcXwvwExZYjtR6tHn0HJkQb1ibWMjrAZfCe974v5Gj0D8YJXF+hKuc6lTgbhQo9qkBZyyFYUtoezzkA+l9eih34lTaxyBcOC7kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwRY8h/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2358CC32786;
	Mon, 29 Jul 2024 20:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722284144;
	bh=G7e0pk1Djj/HwrbGLFs9VMQw5zvXgCjrk/KMk86/0zg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OwRY8h/kXc1796g89XF89iPyKeT5gEe6icYa4V15bFvxARk5wS3zpOrPkT9tPbQ+k
	 XwBOy0cXkd/VDtkFgtqu6FGrzbCJyXLdZW1yz6qj78a0JRy8TW/oUzOUwz9ZshtmQw
	 GfdYd8ndYXRtIKZDP6eKJyhPNN00rwfJM50QBmL+/QVoN/p7p5n7QjkMmLL+mJ93uS
	 rCiKM91K1Ow5g63mvMsTnE6qdfPlP9yBOvLVTeYlZVjKJiUdQB7TkbIhZKVoB12edH
	 fTaHPokc/n+noHRynUxHEb1hn9WgouUCVimnYGiqz5sLhEBS7891R9epY4RX0QmXnR
	 a03Eff6Tr0IJg==
Date: Mon, 29 Jul 2024 21:15:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, corbet@lwn.net, marcelo.schmitt1@gmail.com, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v7 0/7] Add support for AD4000 series of ADCs
Message-ID: <20240729211534.7389a3e3@jic23-huawei>
In-Reply-To: <172227614920.120386.13173085650328169447.b4-ty@kernel.org>
References: <cover.1720810545.git.marcelo.schmitt@analog.com>
	<172227614920.120386.13173085650328169447.b4-ty@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 19:02:29 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, 12 Jul 2024 16:20:00 -0300, Marcelo Schmitt wrote:
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
> [5/7] dt-bindings: iio: adc: Add AD4000
>       commit: 96472f18a4affdaff5013a836c48375f1eddb4a4
Ah. I replied to wrong message.

I suspect you didn't intend to pick up patch 5.

Any chance of a tag I can pull to support patches 5-7?
I need the HIGH flag in patch 1 only.
If not I'll replace it with a numeric value + comments, and queue up a patch for
next cycle to switch to the define.

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



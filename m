Return-Path: <linux-iio+bounces-25221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49353BED03F
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 15:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C523B6FD8
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 13:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4902D5C6C;
	Sat, 18 Oct 2025 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyvs9XEU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81146192B75;
	Sat, 18 Oct 2025 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760793228; cv=none; b=Kxz7HZPADkaPRXupbnowShL09zmkp7YwSx9WQ/a6sDHzr4WfShDdiQEVA+/YLncgWMshJ5Kr/7b2p5s0IFY/fxJ0zyUQGOINUFVsavrV5ST+2qUnaqm83kMJs7WC/9weOiHevWJ7Oo1AGr0tsAXPRppc5uxhJeO9irnZKlRdQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760793228; c=relaxed/simple;
	bh=JuFZRG8iOfSOpAc7xPmG9DiEYgTsPAwgyHt1Z8cbJ5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/qBPWSSQVg9TaiJJHUvr6RxtXq+KpEcW+0prE2TFidJPT99vvxxUK9nQbguHACluyd9IZaDK4BkC8kI5m9dt+BFVU9ddbFNzQcQAf8cmLyK9rv5b6KednfMG4voBUw5gBPvcAeGJGdlLUYAO9WM/BCzZZpA60/XY7pA8KX7IRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyvs9XEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC37C4CEF8;
	Sat, 18 Oct 2025 13:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760793228;
	bh=JuFZRG8iOfSOpAc7xPmG9DiEYgTsPAwgyHt1Z8cbJ5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pyvs9XEU2tZo3/kTQMxCuxKH+2HGYD56fZFH41YzPUM6FpGqWiLOtU4KrUSXBC2QR
	 VLo0+XN24lw/qVr1sQCw8TeuZfubfE97wqJX0ZE5HKHY3oWcjny6hAvv1SBTC13euL
	 T8uIsXC5XrDmAdW6t4TncjZB50C4zGOuTReG4MKZCoA7xbq2KzBvU2kb9B7opqLycP
	 0EvWpXjlRqlKPb2fY3D500a6EeQuvE1s/Yj+S7yEJ/Wo4o+n6UIS6jsEirVB0FKK2q
	 F1AOuoCKMMi3+Z3VitCmBBQCFsx8RKtBEsbpxZH/1KAfpUNZoV7xIVMyC692pJ/9Se
	 lAzObkV3KILXg==
Date: Sat, 18 Oct 2025 14:13:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Axel Haslam <ahaslam@baylibre.com>, nuno.sa@analog.com,
 dlechner@baylibre.com, andy@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 1/1] spi: offload: Add offset parameter
Message-ID: <20251018141341.3ef2f6b7@jic23-huawei>
In-Reply-To: <176053044658.105519.915414342804429574.b4-ty@kernel.org>
References: <cd315e95c0bd8523f00e91c400abcd6a418e5924.1759760519.git.marcelo.schmitt@analog.com>
	<176053044658.105519.915414342804429574.b4-ty@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 13:14:06 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Mon, 06 Oct 2025 11:25:41 -0300, Marcelo Schmitt wrote:
> > Add an offset parameter that can be passed in the periodic trigger.
> > This is useful for example when ADC drivers implement a separate periodic
> > signal to trigger conversion and need offload to read the result with
> > some delay. While at it, add some documentation to offload periodic trigger
> > parameters.
> > 
> > 
> > [...]  
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/1] spi: offload: Add offset parameter
>       commit: b83fb1b14c06bdd765903ac852ba20a14e24f227
> 
Hi Mark,

The patch called out that we are after an immutable branch or similar for this one.

"
Hello,

This patch adds a small feature that is required for a series improving ad4030
in the IIO subsystem [1]. Can we have an immutable branch with this patch so
that it can be used as base for the IIO driver changes?

[1]: https://lore.kernel.org/linux-iio/cover.1758916484.git.marcelo.schmitt@analog.com/
"

If you can still set that up, much appreciated.

Thanks,

Jonathan

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



Return-Path: <linux-iio+bounces-25470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65983C0E2EA
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4531888346
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 13:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DDC2874FB;
	Mon, 27 Oct 2025 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oi3WFxtK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C51FC3;
	Mon, 27 Oct 2025 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573223; cv=none; b=HGH40bZAhYTmkDHZ4WvkIgTFbD317csptwmjfWO/njE3eSbRA2X//5d7xpzRAVffh81o7M2/brvh2U8Xl3rZED+Qnyqv3OCGjQslWSf1/tnuwlobqzgWfR7+9EWm3qv2WcU1SCCr9YhMi3hrvjht/95zGEYQmj0twnTxcNQgac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573223; c=relaxed/simple;
	bh=00/StiGDVWb510tqEvVqkR6oykDaB4Gc8QKjJUElnZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpdVctzGLlju4oT40NqPgGsZ3f96ibRgLWJPy3meGL/WIBh3mqx6dnBFLZHH8uRDlQkIPV5LEKtNDoHbdtXeNsT0V/w2WwsOZNBe2lUtjRElPGnUZ1+9IGo9ZpiX9r5AAr8zjgynLG/HOOvwW4cv0ozqe8sKr/CHfzsq1m5ecKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oi3WFxtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D10C4CEF1;
	Mon, 27 Oct 2025 13:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573222;
	bh=00/StiGDVWb510tqEvVqkR6oykDaB4Gc8QKjJUElnZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oi3WFxtKT7qpaoHBzwtwOY2P7g679My6XIN8TmMyJfHZ44O/s4pEmcUKzlC+9+grU
	 DdjX9lQ/82q8WH4vxLxxYxREYjTTJ4ShCkrqW5teQKpSCMYY9PU/VqmN8Ym+RpxhGt
	 zeLqsOPeHkWKT6GOlViDqpQ5XQb2aD8jcG1vH5p5SIkRIAMI4/PvlyT0ZHjLyDVe+/
	 k0i0zTZAfCHL4su/gFoUxn3mcocpSc0i4+bBc/JPax9JpBBFpMEXvltlNrJgw4wkqf
	 j4TLsNJbcN2yJ1ssIrRwrVHIaPGaeKTXzBzOXzYDv/W1qbeJUEcq3xgbUdB8bnMMTY
	 BNQAtR0GHcb1g==
Date: Mon, 27 Oct 2025 13:53:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Axel Haslam <ahaslam@baylibre.com>, nuno.sa@analog.com,
 dlechner@baylibre.com, andy@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 1/1] spi: offload: Add offset parameter
Message-ID: <20251027135336.0b297370@jic23-huawei>
In-Reply-To: <20251018141341.3ef2f6b7@jic23-huawei>
References: <cd315e95c0bd8523f00e91c400abcd6a418e5924.1759760519.git.marcelo.schmitt@analog.com>
	<176053044658.105519.915414342804429574.b4-ty@kernel.org>
	<20251018141341.3ef2f6b7@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Oct 2025 14:13:41 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 15 Oct 2025 13:14:06 +0100
> Mark Brown <broonie@kernel.org> wrote:
> 
> > On Mon, 06 Oct 2025 11:25:41 -0300, Marcelo Schmitt wrote:  
> > > Add an offset parameter that can be passed in the periodic trigger.
> > > This is useful for example when ADC drivers implement a separate periodic
> > > signal to trigger conversion and need offload to read the result with
> > > some delay. While at it, add some documentation to offload periodic trigger
> > > parameters.
> > > 
> > > 
> > > [...]    
> > 
> > Applied to
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> > 
> > Thanks!
> > 
> > [1/1] spi: offload: Add offset parameter
> >       commit: b83fb1b14c06bdd765903ac852ba20a14e24f227
> >   
> Hi Mark,
> 
> The patch called out that we are after an immutable branch or similar for this one.
> 
> "
> Hello,
> 
> This patch adds a small feature that is required for a series improving ad4030
> in the IIO subsystem [1]. Can we have an immutable branch with this patch so
> that it can be used as base for the IIO driver changes?
> 
> [1]: https://lore.kernel.org/linux-iio/cover.1758916484.git.marcelo.schmitt@analog.com/
> "
> 
> If you can still set that up, much appreciated.
Hi Mark,

The ad4030 changes are stuck on resolving this or waiting a cycle :(
If you get a chance to take a look and maybe merge it a different way that would be great.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > All being well this means that it will be integrated into the linux-next
> > tree (usually sometime in the next 24 hours) and sent to Linus during
> > the next merge window (or sooner if it is a bug fix), however if
> > problems are discovered then the patch may be dropped or reverted.
> > 
> > You may get further e-mails resulting from automated or manual testing
> > and review of the tree, please engage with people reporting problems and
> > send followup patches addressing any issues that are reported if needed.
> > 
> > If any updates are required or you are submitting further changes they
> > should be sent as incremental updates against current git, existing
> > patches will not be replaced.
> > 
> > Please add any relevant lists and maintainers to the CCs when replying
> > to this mail.
> > 
> > Thanks,
> > Mark
> >   
> 
> 



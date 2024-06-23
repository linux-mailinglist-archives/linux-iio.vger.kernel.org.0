Return-Path: <linux-iio+bounces-6781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B6A913CDE
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 18:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130AC281708
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2CB183063;
	Sun, 23 Jun 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhlA7o2J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6B8BFA;
	Sun, 23 Jun 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719161232; cv=none; b=bXmMMoZu6PS8kuP+6pC4po0MW/QuQWYHCi8VjHjgMGfAVWCOo63KR0dyLW29mO5TygxyLtwz4Zz+98H7V+IWe3mQXcuiJoD2AD0kmaNTS+27RGW/XpLn9+XmBjSUWqCnUszAEz+p3IC2s5H2sZ8GgXb95/+O7xU8SyfqVCwz1eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719161232; c=relaxed/simple;
	bh=gxVeHfttQ/VVtXbUzo3h3MEUhLXLyzq7Q5DqtpU2HK4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nKYUXtI0fH7ermdJ5foNGsz+cCiYKLxiCx0B8zi/3uPO/gAolmej8pqre4b0sQJhYLAH2ejSbNc8oHCu6UB1e48fZKE+8uNC+45R2eyoa6FWB06eS1E7ieBwiv3K8JxYsNHGNtPfviQkwLTIettdkbehhNOve88BWWgmeNrmf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhlA7o2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5E2C2BD10;
	Sun, 23 Jun 2024 16:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719161231;
	bh=gxVeHfttQ/VVtXbUzo3h3MEUhLXLyzq7Q5DqtpU2HK4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rhlA7o2JDMbLLcPTQGUR+uZE8AyYlLANcbJw96lKVxe2IQ+yyVKIdW3SoJ9OSj7fR
	 +lMKRGh1YVe5VWfeGUbHnP0Lp5gkCnPXfGp5EPz0lbXrZ5w/k5H6Xj3kwtfE7yk0Qz
	 Hm2vmy+ttNWrjtbJQqUtYurMF7wB/tw8bmodXejDVgoAeOJ5HO+MEpw+bkmCxEOZmI
	 HQHN3B01byHayNltAQ3f/I7NCp5YW+FbmJia4+9a4w+Nlr6eViqoxCwPg46b7gmlKq
	 anNuhaT+0T5mPYPtNAlglek3SZWB2PF25WezR9cKacXn0/ZKWULzWis5wBE8nVqSp0
	 TSKYm32WDX51A==
From: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-iio@vger.kernel.org
In-Reply-To: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
References: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
Subject: Re: (subset) [PATCH 0/3] spi: add devm_spi_optimize_message()
 helper
Message-Id: <171916122916.345728.2892160992008688839.b4-ty@kernel.org>
Date: Sun, 23 Jun 2024 17:47:09 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 21 Jun 2024 15:51:29 -0500, David Lechner wrote:
> In the IIO subsystem, we are finding that it is common to call
> spi_optimize_message() during driver probe since the SPI message
> doesn't change for the lifetime of the driver. This patch adds a
> devm_spi_optimize_message() helper to simplify this common pattern.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] Documentation: devres: add missing SPI helpers
      commit: 9b894d65e9788ece0d51e76d2c184524900f5ec9
[2/3] spi: add devm_spi_optimize_message() helper
      commit: 17436001a6bc42c7f55dc547ca5b1a873208d91d

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark



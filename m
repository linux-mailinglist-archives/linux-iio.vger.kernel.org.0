Return-Path: <linux-iio+bounces-25093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6829BDE6C4
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 14:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB8DA504C40
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3EA32A3C1;
	Wed, 15 Oct 2025 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOirjg0l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565953277AA;
	Wed, 15 Oct 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530450; cv=none; b=Ffi/xWN2SruzZLYGAO4JLYcMSJRh3HCuSHmDAsTCny+L7aPrNdzU+q44tLBvB4AcjkbMpds/hT/cvbWg1FN9ku2l7g5/Fdvt3MiE/HUQUI598TdnTnN+MnuuZmMoZ+9AYOcP63UDBUsZJATo/UvNnmuXPD4HU6uIjnE4XmGdSNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530450; c=relaxed/simple;
	bh=YaK0FjfQd03YPkhRuDa5SE7w6ZhYlyHmOr00FCJp9sY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LfYYrsjV9S87QTDEWoP2t6o4Y8evyZeb4eKkOJQNrUCcDGFFGYZRT/gEEe+pKTqRDOx3/zFw29sHcz4EQgm4YGLAwWRj0n5qBrhmag7C58dM4udl5irFaaft8UqtvAY1XstJuNQxiDTulqFzrD7z32GUEEXazW7Bd/QPH1cUUp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOirjg0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D108CC116B1;
	Wed, 15 Oct 2025 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760530448;
	bh=YaK0FjfQd03YPkhRuDa5SE7w6ZhYlyHmOr00FCJp9sY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bOirjg0l6LuAUs8zJi8wDWaS6wMqWqVtFR0OcznISmSeqtrqtS3C9NWJShCgvlrnD
	 VfJrtBCNuGQlNcLJMP6zcyKFtolFbxBnrPOQLxL5OuIAkZf8e0b46eb9JL+TyxSEmY
	 2LJGp5fsdWterB7mC2Iz5YGrz31LdA3Tnu7MVt1Yq5RTN4UzGxNA8sXzwORSeGKkeV
	 F/19iBhpvLQmpUCeNd/Dx/udm8oS+yo/ILPsL54bHoBom4xJ48MqFg9SWnx6W5Nenq
	 GUmOT9ijpGsLom7+phoh7skx3hMbe4Wn+xUu7LU0j+QZ39qn0lRB7v9aOwLrA3Xr1w
	 p0ZFzleduRKIA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: Axel Haslam <ahaslam@baylibre.com>, jic23@kernel.org, 
 nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org, 
 marcelo.schmitt1@gmail.com
In-Reply-To: <cd315e95c0bd8523f00e91c400abcd6a418e5924.1759760519.git.marcelo.schmitt@analog.com>
References: <cd315e95c0bd8523f00e91c400abcd6a418e5924.1759760519.git.marcelo.schmitt@analog.com>
Subject: Re: [PATCH v4 1/1] spi: offload: Add offset parameter
Message-Id: <176053044658.105519.915414342804429574.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 13:14:06 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-96507

On Mon, 06 Oct 2025 11:25:41 -0300, Marcelo Schmitt wrote:
> Add an offset parameter that can be passed in the periodic trigger.
> This is useful for example when ADC drivers implement a separate periodic
> signal to trigger conversion and need offload to read the result with
> some delay. While at it, add some documentation to offload periodic trigger
> parameters.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: offload: Add offset parameter
      commit: b83fb1b14c06bdd765903ac852ba20a14e24f227

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



Return-Path: <linux-iio+bounces-6918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEFD917085
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 20:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0E328CBA5
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 18:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919C817C7AD;
	Tue, 25 Jun 2024 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V131dyNB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B415F3E8;
	Tue, 25 Jun 2024 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341170; cv=none; b=bTtQe3M2K0Zy7eZVGFykRqdxHm3P8Mj7L+Wusrl9A5C9CSjt7mwIHPHUnjX+e1VPdKvsVgcMRgDiwVvIJcrBmtVYEBhzOnhRUXE4mj83Sgj6wAcv+tkyqI+e1EZDrmm/7mKdzlz/eMFzhlk3LdLMFRmBSXIjRqhgsvj1yZWI4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341170; c=relaxed/simple;
	bh=qRohjESyEqWBF0O0TsINhdM2T84vGe2VszXjL5sNRyA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pVGavYuYPMdt4sCvSWbkeOLXH+WDlv5yVXUf11AtHtm6JyQo5LYImF5fC9czlfwiD2sm9yhQkYGl2Ued54uPmp22KFsDUCf1LrgH3YB0Q+F/NPUcaKXzsPX78/2T87kjW/ew061ZIwj/HCMIt+zORQhqWrI8P+WRz8O5LPoHluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V131dyNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC705C32782;
	Tue, 25 Jun 2024 18:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719341169;
	bh=qRohjESyEqWBF0O0TsINhdM2T84vGe2VszXjL5sNRyA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=V131dyNBVJ2hCYVBgxf31jbxmFKVBFx+td0hUGv2o0rTQx58NhQvEF2ZICo3wQHvH
	 2S7GA+pNwWEMcH42+CLVhuSiN699BF2gPXbFlwa09SuLVOeAlqQSiUeHYuwLJ0oYlu
	 086FTOyMmtu6TMwsjJ64Dll8/GDpvmhT8igoirkudxx6VeOYL6FYn+2Sq5mFB7LkpG
	 5Dl6pQeg3canos9i4uewnEux5v+j15zGRwv9ZFZSzaAGi9nCDyWTojEQSErGU3BvWg
	 bHOWMziYFYv7Z+1ukqWwXpX32Z/sd4Dvjj79OYO0qL+bkSBIoZEjYJQWkS4OG7e71C
	 aFBkA6IMlO7hQ==
From: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-iio@vger.kernel.org
In-Reply-To: <20240624-devm_spi_optimize_message-v2-0-58155c0180c2@baylibre.com>
References: <20240624-devm_spi_optimize_message-v2-0-58155c0180c2@baylibre.com>
Subject: Re: (subset) [PATCH v2 0/2] spi: add devm_spi_optimize_message()
 helper
Message-Id: <171934116763.1172279.176434160030643292.b4-ty@kernel.org>
Date: Tue, 25 Jun 2024 19:46:07 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 24 Jun 2024 15:10:29 -0500, David Lechner wrote:
> In the IIO subsystem, we are finding that it is common to call
> spi_optimize_message() during driver probe since the SPI message
> doesn't change for the lifetime of the driver. This patch adds a
> devm_spi_optimize_message() helper to simplify this common pattern.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)
      commit: 7e74a45c7afdd8a9f82d14fd79ae0383bbaaed1e

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



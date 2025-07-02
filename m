Return-Path: <linux-iio+bounces-21237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62237AF596E
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 15:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89274E2DFC
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A97B285055;
	Wed,  2 Jul 2025 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKq/GDww"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FCA2741A3;
	Wed,  2 Jul 2025 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462837; cv=none; b=Oc1b+PR98XLHTBZjz6blIcfLrccZHMFlqkycAyI41DGCUM3zVSVy2S+okPLrqHlTHP3TgorXyFim9uJHcvHws2rnNKB6cP4FGf9eauHcuW6HWwzG1rJXKx3uiPH+XNSqd+96JbPdoEV7mQpkgAoNA3vggjarGXaoZyl0IfgVelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462837; c=relaxed/simple;
	bh=aeTthio5tDo5yFm/fY8fIx8z+v+Gb5/rApZk6ukOjtw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ryz20oeDYxJGFAPTCKS4NuEWThSawLadQTwJa0L1IPj+eYxQSVhqVWLT9lDfd2HNlSfV4g8NQbbJTh3+HKSdrK4fNIKWL7g9UBkeTLbpgUAzbdFkZQKplXtTVqZOtgTD3pdaMSTTrLP25vk0DI8y13LjTMn3uzBjyzbEnC/IimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKq/GDww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4860C4CEED;
	Wed,  2 Jul 2025 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751462836;
	bh=aeTthio5tDo5yFm/fY8fIx8z+v+Gb5/rApZk6ukOjtw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JKq/GDwwbJX6fgpyTI0tB/SctVE6EfPuJkKNB1WUSGaHOqJ9tcz+Dc3JuhtcL1BiH
	 8mIG8Aju1HmStTVgo+ZFy2HTUEmyp+BbknS9eADtTGXNd/L8bOhYZ0qUfnOEc11udG
	 ZJmyif6Jaw9td5qvaE+h78K9rD0c26XbQiRXHqpMa9rmhQ7VbCliUL+NOLGZJqRflF
	 ICJFhekExYv4etDDmt7O7I6yND9RlJtmkko8I4MOzivh9dIfk5lYvAS7auctVGyAj1
	 JU6IJjJRJIeyl7zIgLpu7ZsmJekiGFBhmfCaqURsmSFcFUpUhfgDf1D5hKFiVIA9iR
	 2FDg8nv1qRFwA==
From: Mark Brown <broonie@kernel.org>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
Subject: Re: (subset) [PATCH v2 00/11] iio: adc: ad7173: add SPI offload
 support
Message-Id: <175146283155.53778.17164711650224607474.b4-ty@kernel.org>
Date: Wed, 02 Jul 2025 14:27:11 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 27 Jun 2025 18:39:56 -0500, David Lechner wrote:
> Here comes another series for adding SPI offload support to an ADC.
> 
> The primary target is AD411x, but since this uses the ad_sigma_delta
> shared module, a lot of this series is focused on that.
> 
> To start with, we have some cleanups to the ad_sigma_delta code, so feel
> free to pick these up as they are ready as they generally stand on their
> own.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[08/11] dt-bindings: trigger-source: add ADI Util Sigma-Delta SPI
        commit: e47a324d6f07c9ef252cfce1f14cfa5110cbed99
[09/11] spi: offload trigger: add ADI Util Sigma-Delta SPI driver
        commit: 3fcd3d2fe44dc9dfca20b6aed117f314a50ba0ff

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



Return-Path: <linux-iio+bounces-8028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E093FD04
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 20:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09831282517
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87C81741D9;
	Mon, 29 Jul 2024 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCRixNK1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7697283A09;
	Mon, 29 Jul 2024 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276147; cv=none; b=mECr9szAoEasQeFa05aZJ85lTY+g2zUh6IskN7WKsn2T8jRjjIUZQyZh9Y2MtNCKFstMA76MS3CbGckC+tqH86Y8C/DgTdbitmYvzNsjun7p8MapeWmItnmoORe6RJfgqqPKT5zwCo/WDOIt58DcCJnXbtRxsX7vHrUblwEKo1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276147; c=relaxed/simple;
	bh=KoE42wYCFQAOjAZ4a4ADdh/ApdMibPMqpeElX/dPg2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WBtNsALp8n8fe2D8gDyRGo/vODuJUHSH4PUVjsbQkUAqShRJTFjF6yXrHwIFaCT2eskt+ri9fvmhxkEnsFIOUfDYi7H4IJaOXuqiVQWY2uXuBqifEUDDAkskMVZv3TNMUV1bUfpg1BGTR5+/YEMJ1J9XhMCvZwTrcVOBQN6yUFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCRixNK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049BBC32786;
	Mon, 29 Jul 2024 18:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722276147;
	bh=KoE42wYCFQAOjAZ4a4ADdh/ApdMibPMqpeElX/dPg2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iCRixNK1gsc2ea0kZsxL2LB87W4bxKWS+W19+OZ8bTsXbN+bXNVoBLWozfXiTNul8
	 lPJXO/8TsKMxmYZ05ThORQgO3juMMh0g4h7GeNpG7Kv+K6k00HLsHmJvY2rNG2irHk
	 hWaQOLUuylbiv5ZVWt35bdZ31Dy+RC7L28nwxPAYQ3q9ar6OXBi2SD1hi243S4tgSa
	 IYrnbDyT/CJqlqtASof593xfgyEfv6ZBU8NmQDnwD7Qb1zeD0wuQ4VCuI1LOci9KT1
	 dtZatEuBB9EJHimMRoutspFhZEXG+qFWlK7JnOQadOESk/xmAPLd+v+auxBJkzxgIA
	 s4eHYH8XKb6GQ==
From: Mark Brown <broonie@kernel.org>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 nuno.sa@analog.com, dlechner@baylibre.com, corbet@lwn.net, 
 marcelo.schmitt1@gmail.com, Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <cover.1719686465.git.marcelo.schmitt@analog.com>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
Subject: Re: (subset) [PATCH v6 0/7] Add support for AD4000 series of ADCs
Message-Id: <172227614374.120386.3055005856415965055.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 19:02:23 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Sat, 29 Jun 2024 16:04:00 -0300, Marcelo Schmitt wrote:
> This patch series extends the SPI bitbang, gpio, and spi-engine controllers to
> support configurable MOSI line idle states.
> It then introduces the ad4000 driver which uses the MOSI idle configuration to
> provide improved support for the AD4000 series of ADCs.
> Documentation is added describing the new extension to the SPI protocol.
> The currently supported wiring modes for AD4000 devices were documented under
> IIO documentation directory.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/7] spi: Enable controllers to extend the SPI protocol with MOSI idle configuration
      commit: f58872f45c36ded048bccc22701b0986019c24d8
[2/7] spi: bitbang: Implement support for MOSI idle state configuration
      commit: 320f6693097bf89d67f9cabad24a2b911e23073f
[3/7] spi: spi-gpio: Add support for MOSI idle state configuration
      commit: 927d382c7efbcc2206c31fa2f672fa264c0f1d5b
[4/7] spi: spi-axi-spi-engine: Add support for MOSI idle configuration
      commit: a62073f4b2164028fc7c5ae45ceba10c9326cd91

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



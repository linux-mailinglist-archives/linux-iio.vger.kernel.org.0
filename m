Return-Path: <linux-iio+bounces-15268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 255ABA2F28C
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 17:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501357A2770
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64DB247DF7;
	Mon, 10 Feb 2025 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J31+ezEO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782CB24F581;
	Mon, 10 Feb 2025 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203624; cv=none; b=dZyucIXyFgJgcnRMoeBE5EfmbszxrCEGy1fTrhWt7u9peK8hJhafGoDOtAUB0cPP9mCakerclvP1LalTFS1ZfET3g4wfc/9vCPpBEbi0Hf7Eu1bo2fCfaWY9lmeF4nExbJ1f7hUeLGGVPcsVSCw/lzZOg3+86olH4wLG7e3L7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203624; c=relaxed/simple;
	bh=SRw1k0y7hlo/yKZBQQG2C4q1HQF4yRbq7z7c9vCQa3w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g0RazudOcwrOIkeWMNHfYLIliB9s0RYIQMxmrhFgY+yEmdKtJXoq0xWUBmVjVnmZdvPGcv0JlAKn7eHo8vs5DJvm2BBwWqpH0p9IGsa3SgPCM7aWw+dMYsIrmENSu3C2GS+GZNRYa4gD7mvJrzjI2LNbiFEvOPCfuQBqTdS6lFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J31+ezEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25046C4CEE7;
	Mon, 10 Feb 2025 16:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739203624;
	bh=SRw1k0y7hlo/yKZBQQG2C4q1HQF4yRbq7z7c9vCQa3w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J31+ezEOgxu409oZ9mNTPJ4US64p6hPYNfqvOSdnI7GyHsyI3tVygykx7FHcuXU9B
	 0HXWxckwuv0mggKb5Ro2cCIdlXyPN5oIQQlXMNtjrrC9kdVLtIpXBB5DaDMHqFq8V0
	 H9IpEv/20U3iQidnte8tiW7L6JQLlEVnZGDPyhI86LDvCat7eS2TyHl32sV6Gu9OOI
	 94PsHDSGsLr7eScDcaS3ffXp/CFmfUZKarukeUvYYEoZqECQSQqJFnonl8/PtvdAut
	 6wr5tPRK0t4d48FagU8OUsBZqk0Op2t41h677XOfHu7BBbGe6bx6q/Mfl56i22v4te
	 kNo0Wuh4iJOvg==
From: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Axel Haslam <ahaslam@baylibre.com>
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
Subject: Re: (subset) [PATCH v8 00/17] spi: axi-spi-engine: add offload
 support
Message-Id: <173920362087.57731.5305051508878680047.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 16:07:00 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 07 Feb 2025 14:08:57 -0600, David Lechner wrote:
> Only very minor fixes in this revision.
> 
> Also, now that trees are rebased on v6.14-rc1 we no longer have
> dependencies for the IIO patches. So Mark can pick up all of the
> patches if we want to go that way. In any case though, Jonathan will
> need an immutable branch since we have other IIO patches in-flight
> building on top of this series.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/17] spi: add basic support for SPI offloading
        commit: 8e02d188698851436f76038ea998b726193d1b10
[02/17] spi: offload: add support for hardware triggers
        commit: d7231be4b4657e5f922a4c6dc11e8dffc71fee87
[03/17] dt-bindings: trigger-source: add generic PWM trigger source
        commit: 83f37ba7b76ab17e029ab4127ec64ccccce64c00
[04/17] spi: offload-trigger: add PWM trigger driver
        commit: ebb398ae1e052c4245b7bcea679fe073111db2ce
[05/17] spi: add offload TX/RX streaming APIs
        commit: 700a281905f2a4ccf6f3b2d3cd6985e034b4b021
[06/17] spi: dt-bindings: axi-spi-engine: add SPI offload properties
        commit: e1101373df5cd7672d988bb4e9cdd5eb97003165
[07/17] spi: axi-spi-engine: implement offload support
        commit: 5a19e1985d014fab9892348f6175a19143cec810

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



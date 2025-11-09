Return-Path: <linux-iio+bounces-26104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE478C44332
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 18:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF69C188CAA2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 17:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDC1304BC9;
	Sun,  9 Nov 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQDy/aUO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720972FFF8F;
	Sun,  9 Nov 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707955; cv=none; b=NV0G9ZUPBaVcKzCXeuwP0NXhUDZE6wWlDcAbtXjwrbrkpKjn0KzUMh3IOEI2LBtR89lL/l7gbmE+O2b5mgSfM2BArxWIKmUR30holO2RO0bt6m4VWjF+h+OMGqQQDuUg+72oEZf2n1l9zYh4saOjYO5A8ETqWtXkWItLaB7o6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707955; c=relaxed/simple;
	bh=uq6su91/eoSOkuf0CnYDoKUFPEfOy20CKPmzT0IiIUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEqmxgCwBbKUjSBaAwvixTB/vAQ7HLafszfPcTWd5ef+S+D7ZwhZhNJS2Yym1QktWebKhoqA64V+P8B0eHhKiAI32bzfVrqAWNHCmkepNhXA0i8Zf84sRG4YG/eJs0SBB1GNvlEE2sCaXDjwIk6yWP96dfhElwWGloOu2kbUNFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQDy/aUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBF7C19421;
	Sun,  9 Nov 2025 17:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762707954;
	bh=uq6su91/eoSOkuf0CnYDoKUFPEfOy20CKPmzT0IiIUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gQDy/aUOmxw9AlqzgJdmX+xUF5dnZybtgq88knJlZ5QulZLnxv4LcsD6uLDDpF3Io
	 hAVt4wCofaCHJY80CEUnjSqodnBRWPN2tKKglyt8WLXKW7BXSp/a/YMobL0ptbh/vs
	 3xZwhgQVBMDlQSlRYHp6e/GMXJOMSW/jSJb2U67TmlubuIR3ddcTMvA9ekRwoZW5Vv
	 x9qM0cQvf53Okbr7YUzH/BOQfbbmiRm48g+xpM9019QW+60DKvSCmYwClp+a8Cb3y7
	 7q0mAD93CvAjWJ1tsnqMI/k7rMl/in3fLtGdwqfUcJI02Dwg2AzihTHQSG+rPgg8dl
	 kmt4ojpTtgzXw==
Date: Sun, 9 Nov 2025 17:05:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Sean Anderson
 <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/6] spi: add multi-bus support
Message-ID: <20251109170545.7e07ab41@jic23-huawei>
In-Reply-To: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Nov 2025 14:52:46 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This series is adding support for SPI controllers and peripherals that
> have multiple SPI data buses (data buses being independent sets of
> SDI/SDO lines, each with their own serializer/deserializer).
> 
> This series covers this specific use case:
> 
> +--------------+    +---------+
> | SPI          |    | SPI     |
> | Controller   |    | ADC     |
> |              |    |         |
> |          CS0 |--->| CS      |
> |         SCLK |--->| SCLK    |
> |          SDO |--->| SDI     |
> |         SDI0 |<---| SDOA    |
> |         SDI1 |<---| SDOB    |
> |         SDI2 |<---| SDOC    |
> |         SDI3 |<---| SDOD    |
> +--------------+     +--------+
> 
> The ADC is a simultaneous sampling ADC that can convert 4 samples at the
> same time. It has 4 data output lines (SDOA-D) that each contain the
> data of one of the 4 channels. So it requires a SPI controller with 4
> separate deserializers in order to receive all of the information at the
> same time.
> 
> This should also work for the use case in [1] as well. (Some of the
> patches in this series were already submitted there). In that case the
> SPI controller is used kind of like it is two separate SPI controllers,
> each with its own chip select, clock, and data lines.
> 
> [1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-1-sean.anderson@linux.dev/
> 
> The DT bindings are a fairly straight-forward mapping of which pins on
> the peripheral are connected to which pins on the controller. The SPI
> core code parses this and makes the information available to drivers.
> When a peripheral driver sees that multiple data buses are wired up, it
> can chose to use them when sending messages.
> 
> The SPI message API is a bit higher-level than just specifying the
> number of data lines for a SPI transfer though. I did some research on
> other SPI controllers that have this feature. They tend to be the kind
> meant for connecting to two flash memory chips at the same time but can
> be used more generically as well. They generally have the option to
> either use one bus at a time (Sean's use case), or can mirror the same
> data on multiple buses (no users of this yet) or can perform striping
> of a single data FIFO/DMA stream to/from the two buses (our use case).
> 
> For now, the API assumes that if you want to do mirror/striping, then
> you want to use all available data buses. Otherwise, it just uses the
> first data bus for "normal" SPI transfers.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Series looks good to me. If the SPI and DT folk are fine with it, then
I guess time to ask Mark for another immutable branch so the SPI stuff
can be in the SPI tree and IIO tree.

J
> ---
> Changes in v2:
> - Renamed devicetree property spi-buses to spi-data-buses. (Driver code
>   was already using spi->data_buses, so it matches).
> - Fixed a small bug in the AXI ADC driver changes.
> - Moved one line of code in the ADC driver changes.
> - Link to v1: https://lore.kernel.org/r/20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com
> 
> ---
> David Lechner (6):
>       spi: dt-bindings: Add spi-data-buses property
>       spi: Support multi-bus controllers
>       spi: add multi_bus_mode field to struct spi_transfer
>       spi: axi-spi-engine: support SPI_MULTI_BUS_MODE_STRIPE
>       dt-bindings: iio: adc: adi,ad7380: add spi-buses property
>       iio: adc: ad7380: Add support for multiple SPI buses
> 
>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  22 ++++
>  .../bindings/spi/spi-peripheral-props.yaml         |  12 ++
>  drivers/iio/adc/ad7380.c                           |  42 ++++---
>  drivers/spi/spi-axi-spi-engine.c                   | 128 ++++++++++++++++++++-
>  drivers/spi/spi.c                                  |  28 ++++-
>  include/linux/spi/spi.h                            |  23 ++++
>  6 files changed, 237 insertions(+), 18 deletions(-)
> ---
> base-commit: 1a26618e7466b8d825989201086c235e76aa999a
> change-id: 20250815-spi-add-multi-bus-support-1b35d05c54f6
> 
> Best regards,



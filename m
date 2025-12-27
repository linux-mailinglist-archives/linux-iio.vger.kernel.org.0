Return-Path: <linux-iio+bounces-27366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD930CDFE9C
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4431D3011769
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084762620FC;
	Sat, 27 Dec 2025 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCUneI+L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A64D25F995;
	Sat, 27 Dec 2025 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766850774; cv=none; b=Jw2CuDboDcWtLsEtv1l77MZvoNrdKMiMxZyPkqj5Svt+tjWG6Q9Ubto7ZC+5bBL6CCq/pBst6uPSkSUoE79LnBq9cK2h15IquC8VmJ0ED3HP5GhQahl3LdEvWKPjgvwo0/23tKp4tmaKEhfGVE/PiaoVdPraaGEh5XL4t94Hlns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766850774; c=relaxed/simple;
	bh=2WJC2VuUA77wKao0U1jHZAdt5NZw4EFA8Cqy4xSS9Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiAVc9xSLaEIb5WGR4NybgzyuQx1EVueQdhQfSojfGjhsGtZPclN6FOYIkby6EzOU4ct6izrSGM6RN5+CfXQmlS1bln+nJAPHH+vdAlSgRnOy/yuQlJqlSm2e3Rl7EkkUmEwcySKAiEsv8NMFN10btg7bhCoRwJnKFg2xG3a8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCUneI+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45340C4CEF1;
	Sat, 27 Dec 2025 15:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766850774;
	bh=2WJC2VuUA77wKao0U1jHZAdt5NZw4EFA8Cqy4xSS9Qo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QCUneI+Lslcu0EZNg+IgA47uhiEz37DHOv3WgR8f0xL08WZCxXaEmDj+J4DBhAamU
	 dh+O4KJzTUG7cY7SDY9wsfVVwNKXPua24e1YVR2A885JG+pJdwy1vztvyTAon4o0RL
	 xHbN7MgZliyUjWqiY3QxHo70+nzGC/JtR9Q5i+nhkIsRpJodDaqdwGl1D7nsfanjUh
	 pOuE8FiOodXYnqigmqGFqKsWsEOX2HK0F4yrSD2l/CjVTsvuaWT6zA+bpJNteqlBtx
	 j5OTWI8FPwqfrJtS2ip2UQJpkzT0A2hmXxlbQIXUx3q7PYeL6Egs+v5Exqd326HSlx
	 d3WDXCFQ50L+w==
Date: Sat, 27 Dec 2025 15:52:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: dac: adding support for Microchip
 MCP47FEB02
Message-ID: <20251227155245.6a3f5344@jic23-huawei>
In-Reply-To: <20251216-mcp47feb02-v4-2-4b687094ff90@microchip.com>
References: <20251216-mcp47feb02-v4-0-4b687094ff90@microchip.com>
	<20251216-mcp47feb02-v4-2-4b687094ff90@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Dec 2025 14:05:51 +0200
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> This is the iio driver for Microchip MCP47F(E/V)B(0/1/2)1,
> MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series
> of buffered voltage output Digital-to-Analog Converters with nonvolatile or
> volatile memory and an I2C Interface.
> 
> The families support up to 8 output channels.
> 
> The devices can be 8-bit, 10-bit and 12-bit.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
Hi Ariana,

One stale bit of documentation and I'd be surprised if the
style of text used in Kconfig short help proves sustainable.
We often end up over time moving to 'x and similar' to avoid
very complex pattern matching as more and more parts end up supported
by a given driver.

With those in mind. Applied to the togreg branch of iio.git which I'll initially
push out as testing to let 0-day take a poke at it.

Thanks

Jonathan

> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c04f3b72b1b1fc303b1bde63c281aade8a67b2f9
> --- /dev/null
> +++ b/drivers/iio/dac/mcp47feb02.c

> +/**
> + * struct mcp47feb02_data - chip configuration
> + * @chdata: options configured for each channel on the device
> + * @lock: prevents concurrent reads/writes to driver's state members
> + * @chip_features: pointer to features struct
> + * @scale_1: scales set on channels that are based on Vref1
> + * @scale: scales set on channels that are based on Vref/Vref0
> + * @active_channels_mask: enabled channels
> + * @client: the i2c-client attached to the device

Not there. I'll tidy this up whilst applying if nothing else
comes up.

> + * @regmap: regmap for directly accessing device register
> + * @vref1_buffered: Vref1 buffer is enabled
> + * @vref_buffered: Vref/Vref0 buffer is enabled
> + * @phys_channels: physical channels on the device
> + * @labels: table with channels labels
> + * @use_vref1: vref1-supply is defined
> + * @use_vref: vref-supply is defined
> + */
> +struct mcp47feb02_data {
> +	struct mcp47feb02_channel_data chdata[MCP47FEB02_MAX_CH];
> +	struct mutex lock; /* prevents concurrent reads/writes to driver's state members */
> +	const struct mcp47feb02_features *chip_features;
> +	int scale_1[2 * MCP47FEB02_MAX_SCALES_CH];
> +	int scale[2 * MCP47FEB02_MAX_SCALES_CH];
> +	unsigned long active_channels_mask;
> +	struct regmap *regmap;
> +	bool vref1_buffered;
> +	bool vref_buffered;
> +	u16 phys_channels;
> +	const char *labels[MCP47FEB02_MAX_CH];
> +	bool use_vref1;
> +	bool use_vref;
> +};



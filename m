Return-Path: <linux-iio+bounces-25250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAFCBED793
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 20:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985A53A8FCC
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D1B261594;
	Sat, 18 Oct 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNDynJSU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DC61E520C;
	Sat, 18 Oct 2025 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760811040; cv=none; b=fEeUwUi5LaX0yemU4fuBoZkJ03iFZLhUnZyuDRYCSbzw+uxFGxngkD5G6x1KSv4zo5H/B7zRl0nXHjsX99fOf4KkNG7ubVpZIkMwlJ/ldTdgcPKdUuj+wbwpr6YLtUWfTsbeKjEMdum1CZZkp6v8ss/6EZIDFjt8K/pf/fGMh/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760811040; c=relaxed/simple;
	bh=Yly71XvLU3G0NcZs/5Sn7AIzcevt6O77xNUTdZVnZL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRC4z+M6ep+GPBy2mM7GlvDuLfsouo0KyG0ud/Be2GG0Bh8lVlgUSPFFkfg2VVrGdeEAIuou3GFP4YcGbqRlvZ7nLB9IM4ofiNO6dVyQvfe0upY43jY/XvBsF7hnxtXzEJjxLr3wB/GlInoBfl3HvSGS7dBRp0tJkx9+UrwXg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNDynJSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F7BC4CEF8;
	Sat, 18 Oct 2025 18:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760811039;
	bh=Yly71XvLU3G0NcZs/5Sn7AIzcevt6O77xNUTdZVnZL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZNDynJSUOeaLiGTQUyu1It6KtyQuobQ0iKbvQwco0mrnv5M3nFRypfBdi8DbCRK+L
	 mr2Z7I7DM9tCvVAfY5y6Fy20RswrKQYMs0qt4Ubmuctq3b5D5R4s99w9ZhSpAvbFrS
	 +UJoz7VNwbdvJTMoEtAUsO0lju7L57hvagKPBsRaP8fscp2Cf8XTCZg4oyHmDQUwKP
	 tqiCRwE/XNmrGiip6yRtU4+JEfddR4IE4Az9+COR5qqpwNH5hMJ6nWljtZ6nF3bmU8
	 LsyMBBmygQMMzy3pIu8Sk1knVTGZF3h22OfxHUsfxeAAnJqOwEcjHR/f7SWeyEsuht
	 VjMrTubpxul2w==
Date: Sat, 18 Oct 2025 19:10:32 +0100
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
Subject: Re: [PATCH 6/6] iio: adc: ad7380: Add support for multiple SPI
 buses
Message-ID: <20251018191032.669f3461@jic23-huawei>
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-6-2098c12d6f5f@baylibre.com>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
	<20251014-spi-add-multi-bus-support-v1-6-2098c12d6f5f@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 17:02:16 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add support for multiple SPI buses to increase throughput. The AD7380
> family of ADCs have multiple SDO lines on the chip that can be used to
> read each channel on a separate SPI bus. If wired up to a SPI controller
> that supports it, the driver will now take advantage of this feature.
> This allows reaching the maximum sample rate advertised in the datasheet
> when combined with SPI offloading.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
This seems fine to me.  I briefly looked at the rest of the series and
nothing jumped out other the many combinations of crazy that exist which
came up in the discussion,

Thanks,

Jonathan


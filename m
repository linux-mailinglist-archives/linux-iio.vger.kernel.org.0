Return-Path: <linux-iio+bounces-27722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86352D1D721
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17A7130409E9
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0D537F8AC;
	Wed, 14 Jan 2026 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/6w/npS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891D2EE268;
	Wed, 14 Jan 2026 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382188; cv=none; b=F5fnEhQgV3SCAUGYl+ZXhLr3+F+4GCLdv1fDbi4lzfrYX5YOw3WZ6MWsyf6VKKqMsSOiUvRXbaN+6+0AwoFNKc8hoT2hLxAe8P7O0COXuUUh2c12YAPvuC2fcuBXYWoAhQEcJLMYgx3306ysSCop1P2NgJl4n6bLj37ppMT7Ezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382188; c=relaxed/simple;
	bh=T2Duxo5Hu/Y2KV2gXvB6NmGfXPwYoAp4se3BqsF32ig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xs9LK/H/xTmJ68oCkdLSmhc9Ysp1wdhFOFPUwkAE6mCgmWoix4eNrbAzSiIpnHYZ5luVTke31VlLm1iil3VEYu1ubjYx9Qkocv7l+pa8J46gRDIjiOkXyhueI/L2ihoypHAgDE73ji5/Rg5JHz/l+EO3PF9cI5c8QuBMUZM2BkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/6w/npS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AC8C4CEF7;
	Wed, 14 Jan 2026 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768382187;
	bh=T2Duxo5Hu/Y2KV2gXvB6NmGfXPwYoAp4se3BqsF32ig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j/6w/npSFptp1Gd+ZrTw/81rEsyQ9WQy/ysOs5JpDZ3w0255FMgoYOuRsmpYeDJ7T
	 SKoCCGh1wJBvigNauVFM5SLOXYoOEhp+60tYFuEuHn8kzC/VQ+KmhJ3BrqU/xlbfT4
	 y0MPctqSudvuuMWC5mFmwdSFLbEftjj2k3gIYxfg4rfRfxf6xtCZg2C7MlnE7r9bk2
	 hs7ZL/ASlW4JPC/Xjk68Dy+fuviGvrY+A0dcbKlVCg32VkevhsP3S4eSDCZUGp+UmM
	 uUYEXcwOB0r3VBeYUPJxsI0JHMFgosPcRiXZaIykK0SNh/Na0Nz7H434EYYao830hT
	 IN6Vs/53/5GWQ==
Date: Wed, 14 Jan 2026 09:16:17 +0000
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
Subject: Re: [PATCH v5 7/9] spi: axi-spi-engine: support
 SPI_MULTI_LANE_MODE_STRIPE
Message-ID: <20260114091617.170a9757@jic23-huawei>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-7-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
	<20260112-spi-add-multi-bus-support-v5-7-295f4f09f6ba@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 11:45:25 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Add support for SPI_MULTI_LANE_MODE_STRIPE to the AXI SPI engine driver.
> 
> The v2.0.0 version of the AXI SPI Engine IP core supports multiple
> lanes. This can be used with SPI_MULTI_LANE_MODE_STRIPE to support
> reading from simultaneous sampling ADCs that have a separate SDO line
> for each analog channel. This allows reading all channels at the same
> time to increase throughput.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Hi David,

I kind of hope ADI make their versions backwards compatible (or at
least try to) so the version check might be a bit over the top.

Anyhow, not my problem and the code is nice and clean.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


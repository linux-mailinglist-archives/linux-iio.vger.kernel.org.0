Return-Path: <linux-iio+bounces-22809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9309AB28DBB
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 536554E1E55
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A59E2D0C86;
	Sat, 16 Aug 2025 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGiqkoMt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA91E47BA;
	Sat, 16 Aug 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755347654; cv=none; b=CPuSIauHLetltmXLWkkav4yc0I4i9ide+vJyc5gfYwZLd11+MrH6fiCHlMQln0HcUqW3v/9VB6viw2qHxp+/TQr2rmsuyFoUM1PxpYZcqSRMUZs1+rYfbdi5uJzKNbSIAK2Qii11W0veZBQAx0xI/H9hFsUwpdWjJ87sZm6Tpw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755347654; c=relaxed/simple;
	bh=X0kaiOuEr5a9NvIWyH392M9p1jmj9WcFHXKIc55VwfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txbxizMb58V6sB5MJ28QZuWZRyYwuPo+LGudivciKJi6gmAt/ZIdUT75x0FvLuq/Enog4TN58CcIh5rM7sKPgVqrAwau9q35pGBUOGPZV7W9Za5L2xMRaveOvgxpsGLxVHHbYgCcB8NK7/nAjH1j3FZj77B/Ufz8QHlsKNTHTpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGiqkoMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D2EC4CEEF;
	Sat, 16 Aug 2025 12:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755347654;
	bh=X0kaiOuEr5a9NvIWyH392M9p1jmj9WcFHXKIc55VwfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sGiqkoMtEFdRsu4JR7tcvfUH+i6HcQP3hald1uXcvbVur531OOkeZb+M617QI+cRe
	 qD0ceXF3NVOJrk+0zkAdUv66OjSf7An7Klp6LUGSzAknCtEOLIDng9NvGercY2JtJe
	 f01C8Cxn/HwYbal9dUWa8o0fMfuAHCh/7YIYDKZNqsm5vijoleJ511u9Z7WivTzF9t
	 pFDSJp5NDD5J83L/WKLVO6Q0gIYENT6SjdQiBcgQnSo1nZJhVgGT8PrL1BwBBDazSv
	 JSmje84A/J5zB9hPeSKYZiqpx8utZMGriCa5zHt+JzV2MNtmbnmlUe0b2D5M7/Upmg
	 RqWFlCVsMOeHQ==
Date: Sat, 16 Aug 2025 13:34:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 05/21] iio: remove unneeded 'fast_io' parameter in
 regmap_config
Message-ID: <20250816133405.5ae57fd6@jic23-huawei>
In-Reply-To: <20250813161517.4746-6-wsa+renesas@sang-engineering.com>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
	<20250813161517.4746-6-wsa+renesas@sang-engineering.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 18:14:51 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Applied. Thanks


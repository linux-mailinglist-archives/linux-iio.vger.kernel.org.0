Return-Path: <linux-iio+bounces-18701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F350A9DBC8
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 17:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BED33AE73D
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844D925C6FE;
	Sat, 26 Apr 2025 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+tY5btY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40485A31;
	Sat, 26 Apr 2025 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745680566; cv=none; b=HwstCD6SwrhravApVz23iYFLPfeHBE1CRnfCtBfO2KIOIoGCXv5oRvp+9uJQE9fTi+iKCPMZoEd0lZ4wsNBHfsMeTUfwGcYO9zL2Tz/JGIGBDfhBRvJEUogds5UMtdafsOYqwR0hMbdPooauRjJz44whsxfHdEVVKsImwEXMJIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745680566; c=relaxed/simple;
	bh=Z6MESrWi4XEFceIGFhc41inyIiwT8EHhx2jA5htB/eA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnCjkcQhHBQJk5gxpSyai2JtUYExIDCAl7suYNhxUTtmOZjCQSfdVdXFW+CJ4XB1iWt6al4CKV7CvPjMGkC4bz6FGDAfsZDrocxVSwr4NRK5f5VxiGjMOs0PslZi5aI9RuP3Eql3ngWHORx60l85p02QDPCjOeJh2TQWzJTV1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+tY5btY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D64C4CEE2;
	Sat, 26 Apr 2025 15:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745680565;
	bh=Z6MESrWi4XEFceIGFhc41inyIiwT8EHhx2jA5htB/eA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b+tY5btY6KVgAwi9ORQnyL2Ge2d8zC9kv9a27tan2Dc24QO3kdWdO3YizKq9Ti7Yj
	 XJ9mEIeWHXqVTDyfdVJ8svquFpUIGr4Ijn5V0THmFCh55Ec9tc8zrBfHE8kw+cqWn0
	 c9jFUii1xRp315fN5HYP832vkCk7rg665oK1UCCOXoECkFzQE0YqdQxE7hX8WpyKR2
	 3c8opxinDeiXpwD84bwsCC+ZBlhRBK28d73Rz9sY0S0iTdLaRaGr4Xb1CXsI16KKmI
	 CeErX0jXktxpDenZ9alb3YYGRN41h4xLGxsdgoXE7xZ4EKEqh6xZOj/ev8CSR7KyAY
	 3K4WkI3Zesylw==
Date: Sat, 26 Apr 2025 16:15:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Guillaume Ranquet <granquet@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: adc: ad7173: fix compiling without gpiolib
Message-ID: <20250426161558.0be94cfa@jic23-huawei>
In-Reply-To: <20250422-iio-adc-ad7173-fix-compile-without-gpiolib-v1-1-295f2c990754@baylibre.com>
References: <20250422-iio-adc-ad7173-fix-compile-without-gpiolib-v1-1-295f2c990754@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 15:12:27 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Fix compiling the ad7173 driver when CONFIG_GPIOLIB is not set by
> selecting GPIOLIB to be always enabled and remove the #if.
> 
> Commit 031bdc8aee01 ("iio: adc: ad7173: add calibration support") placed
> unrelated code in the middle of the #if IS_ENABLED(CONFIG_GPIOLIB) block
> which caused the reported compile error.
> 
> However, later commit 7530ed2aaa3f ("iio: adc: ad7173: add openwire
> detection support for single conversions") makes use of the gpio regmap
> even when we aren't providing gpio controller support. So it makes more
> sense to always enable GPIOLIB rather than trying to make it optional.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504220824.HVrTVov1-lkp@intel.com/
> Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied and marked for stable.

Thanks,

Jonathan


Return-Path: <linux-iio+bounces-27380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A680FCE0062
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1D2E30213D1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDFB3191C8;
	Sat, 27 Dec 2025 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plgRFm2x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4321846F;
	Sat, 27 Dec 2025 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766857448; cv=none; b=sMTXgQKRB3jxygiHIwK0W0CDsC0NL+gi3QSh7t/lBLl5kOMzimw7/rjSZ9v09wens3DHKMoHWZp9B5Ece0WNJSI3oyCK/HNHQZx4kQ0ry7XjBbD9yE1xmsGWCHya22Xjwh+CS/g9T5BeyCAE8N9XNLpO5mGMDu2kuSy27TFJA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766857448; c=relaxed/simple;
	bh=rEzyn2bOa/coEWORVff+5bDDXl1nAaryf+Cd927xIOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCitHKt4eoZKCr3UjAKarjNBcYtlUVjHxAH8c+JpCer4KYv0Wvi+LcTO6X8hv/7z2UbnOfFIqBbIBPifSJCBQ9SSf4DyQFomllXVdd4albs+sZHK2P54HrcV2JVuwDARdXTPf5IAUCxmV0kl30VqjQb8YY8RLktbhrbjMoubDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plgRFm2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA24C4CEF1;
	Sat, 27 Dec 2025 17:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766857446;
	bh=rEzyn2bOa/coEWORVff+5bDDXl1nAaryf+Cd927xIOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=plgRFm2xv3fqWW5WRh8lT7O/Wmj2z7xu9xX/s7k4mnHrgMJaVSaAIgUsOCHQxxJxf
	 e6mTos4LuKjclLyR3T6+coydKFAv2N0HxD4b3au0Nb53KzuTbrBqNdvHEyliG8JKtu
	 fXiK6hG42cOmNtGWdwQ2HnSUsXb6lFMVGlWV5WG4Y90IjVbaF3u5zWUYaXHUOOHGfi
	 T4kb34NP9bp5miMS5tqjAdInUe7MkV/qIg2DSNX0OUYLIkOhT8IGd4O9Ht9ptxB6dC
	 b0B5vlls0XTmDuY9T3iuZHkSWJbQzmzXS9tvbgpr7h2Wiu0YnJGKZbh05vwAISYNZU
	 Bxz63eR8a1ZCg==
Date: Sat, 27 Dec 2025 17:43:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Krzysztof
 Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Heiko
 Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/3] iio: adc: aspeed: Simplify probe() with local 'dev'
 and 'np'
Message-ID: <20251227174355.0677f93f@jic23-huawei>
In-Reply-To: <20251221142602.47368-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251221142602.47368-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Dec 2025 15:26:03 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Simplify the probe function by using local 'dev' and 'np' variables
> instead of full pointer dereferences.  This makes several lines shorter,
> which allows to avoid wrapping making code more readable.  While
> touching the return line, simplify by avoiding unnecessary 'ret'
> assignment.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
All 3 patches applied to the togreg branch of iio.git.
Initially pushed out as testing to let the bots have a play.

Jonathan


Return-Path: <linux-iio+bounces-23756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B49B45138
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 10:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D132484269
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 08:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB33308F2B;
	Fri,  5 Sep 2025 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI2gIws5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC09308F0E;
	Fri,  5 Sep 2025 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060440; cv=none; b=AB4k/VxXLZp0/6KZWpfqUXA+dqztwQUJJrEjQ2tqsV/k1GwNA0m1SQdZxFUG9lbMpIm2J+GqJXpUdO0iN0kbE13NZZbO+O0Wwc1bl6O2i9Xu6/fMNpdZiA3v2LAUNLzx/bmwDGelKKAa96t8IqkibHfX9Na6wKk7GRjUrmkttog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060440; c=relaxed/simple;
	bh=1NT/J9zy+wp2WIDDw1MZkz4+Ema5iHWmh+YcteWPW9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgRK/0uUCdDE80+Qn2TtVj+ThcOjvIGTmw2Xur4XYtFYf6xsozQfVMiYbXKMKSl55AyHPCb6llwi40wPUkUO7Gb4vypmyvUOyKR0kMu6yPdC+XOVQyG40NbwQxhLbpuESXNYqeC8R+TSjTWH4xl3PfaFt4e+mydSRe2WdYjnm5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI2gIws5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFE0C4CEF7;
	Fri,  5 Sep 2025 08:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757060440;
	bh=1NT/J9zy+wp2WIDDw1MZkz4+Ema5iHWmh+YcteWPW9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bI2gIws5IK3KjZoCKjEfQSCveSDzyPef2WcTJ2SWU78Qo4+kuev4nc1ClkUZeHe1b
	 0T2q8lFfzXl/9pygx1vXkJ/jrzh31H72fH/hybLYLHsJKa5hq3xd0WyV+YP6tiXNfx
	 b/y5KYE6nae/LAzna+DXu8qgSirjGkxgo5dqLMe+VjClsXDcdAytJIJybGXPsVHaYw
	 gTPYudJukJkiu1+ct8nlHssSsL593gb32imFWjpSQVw3bN1oyKY1BKoXtzrIW7fBwV
	 B/aknTh/77HWQ0oztPegXY+qR/MmqYOX7Edw2ioZzLyyTzR72Pi1l3R2Pw73W8L1jd
	 5NaKsmHgdVTkg==
Date: Fri, 5 Sep 2025 10:20:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	upstream@lists.phytec.de
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: afe: current-sense-amplifier:
 Add io-channel-cells
Message-ID: <20250905-dainty-liberal-monkey-ec28bb@kuoka>
References: <20250905065503.3022107-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905065503.3022107-1-primoz.fiser@norik.com>

On Fri, Sep 05, 2025 at 08:55:02AM +0200, Primoz Fiser wrote:
> The current-sense-amplifier is an IIO provider thus can be referenced by
> IIO consumers (via "io-channels" property in consumer device node). Such
> provider is required to describe number of cells used in phandle lookup
> with "io-channel-cells" property.
> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> ---
> Changes in v2:
> - refactor commit msg drop warnings introduced by commit #2
> - drop Fixes: tag

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



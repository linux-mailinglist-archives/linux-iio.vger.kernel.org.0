Return-Path: <linux-iio+bounces-23698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFB7B436C9
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 11:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62ED43B1CE5
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 09:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D77D2EE5F5;
	Thu,  4 Sep 2025 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMSROS6x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542E2D24A1;
	Thu,  4 Sep 2025 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977404; cv=none; b=M/Nz8R+l0oxJrusd2oct6AXif2meEzvdotRpTVDa+awJ7TZYsrgjh3Ku5qsE9A3ihbyYWRwk37hTyvIJUWm7gflIMt+O/FPo5sJ5cKk6YDqpUmETAmldTOC4WYZeccZBlz/xa4IJ1H2Eqamo2FovZwSJvaX5HQbCCElg9zgRI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977404; c=relaxed/simple;
	bh=qJ5SxDn7aebXMIST+p4VUse9TikgWbIjkKE/CdROn9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlW3O8j2Afy51VxZULrbJfhtA2iVu/f/TUkOv0qsNvIg3Xhxj4l7zXUA1Y/Jm6hITXvGxxLmPeBIaqvA5/EffEa0cilLFJeVFPHN8jMWkedoWRlu3oene/V+wR7VKOrol3hz6butvWq6Zqz2wcuADP01mq86bBHTKNc/SvWLlTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMSROS6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF10C4CEF0;
	Thu,  4 Sep 2025 09:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756977403;
	bh=qJ5SxDn7aebXMIST+p4VUse9TikgWbIjkKE/CdROn9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMSROS6xqn6Hw+QYxGhXMGnvVW7hSeJNC6zcpN7wX9fJfr0sAJcKcygAN1nTLck5X
	 VKzPkCrqHWnYPYGSRq0LjM4BKknCue/yDkRwBeub5fPYREduBEJ0YMgL2kpsDiDMtp
	 vwjQppVfO/iQgeHe+0EoympPMvjfpDsh/b4Owi5SYxLfcvNv4JC5iRFdA73RwoQNTg
	 hUd2m5oyX2BWvBhsgKf6HgTL2b9Ko5DYocnHVTur/M+2Zd3n3mS1EN+BY7lMzfDrQC
	 t/rscC2WYQqaeO8/N0+4t5xkLqy4K6hbqbV9S+LRBb/6OzGDI2JAYz85uxEKQuXzXI
	 i6Ff0ILgWl6Gg==
Date: Thu, 4 Sep 2025 11:16:40 +0200
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
Subject: Re: [PATCH 1/2] dt-bindings: iio: afe: current-sense-amplifier: Add
 io-channel-cells
Message-ID: <20250904-stereotyped-swine-of-romance-f7185e@kuoka>
References: <20250903113700.3079626-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903113700.3079626-1-primoz.fiser@norik.com>

On Wed, Sep 03, 2025 at 01:36:59PM +0200, Primoz Fiser wrote:
> The current-sense-amplifier is an IIO provider thus can be referenced by
> IIO consumers (via "io-channels" property in consumer device node). Such
> provider is required to describe number of cells used in phandle lookup
> with "io-channel-cells" property, otherwise the following kernel error
> is present:
> 
>   OF: /iio-hwmon: could not get #io-channel-cells for /current-sense
> 
> Also fixes the following dtbs_check warning:
> 
>   current-sense: '#io-channel-cells' does not match any of the regexes:
>   'pinctrl-[0-9]+' from schema $id:
>   http://devicetree.org/schemas/iio/afe/current-sense-amplifier.yaml#

Which DTS has this warning? You did not include Makefile target and
quick look told me there is no such...

> 
> Fixes: fbac26b9ad21 ("dt-bindings:iio:afe:current-sense-amplifier: txt to yaml conversion.")
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Best regards,
Krzysztof



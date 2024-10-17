Return-Path: <linux-iio+bounces-10677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F009A1D3C
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 10:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335721F21DCE
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 08:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D143D1D3653;
	Thu, 17 Oct 2024 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiAfPPmy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A2214E2FD;
	Thu, 17 Oct 2024 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154001; cv=none; b=EbZ9VcsXTIQVt0tdMv61rbzm+Ca7TkZL//PLepZZ8/AAid3xn6shwl369OlxDmkxem7c0SeSKJwr2dbpBjS4n9T0JtBgCGx1enQl9Bwvb6gJqcU0gHu5Ivv6X1RWZAkYXHQWTwpIJ5dKiOHBHdVI4JSw2aSxHqtTzhqOlzBfvNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154001; c=relaxed/simple;
	bh=CbWSyASu0hxeUG4ttEARyjmDnWC6WL3R1Rar7EW5zWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FofONLswkY1jtjQCwMMKVqMPf5pns9gz5d7WySw8N9yhZTaKYPhBzR2SAithqpZaZJBJGxDkKe3A1z3jOaLaOrGj8oA+EDbupsf1/RwxI83S4H7hNe7aBS2vpsAg1PEfpJanaM+zBkto6kaRjWEOjczgTewHudtrFRpPauNXDl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiAfPPmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8077EC4CECE;
	Thu, 17 Oct 2024 08:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729153999;
	bh=CbWSyASu0hxeUG4ttEARyjmDnWC6WL3R1Rar7EW5zWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YiAfPPmyXmuDrEo4VLyXMF6iwdM1nIEe7KdaL1Aa3+4SNsuSK84vS+shb5zPnPUSq
	 7o3dcm6CqoqTq3/V1MwxKw8teaFOdRCuotEdL6QIMrEUAf80H2yAdcoh8974Bue6oM
	 +ZDI82bJly76dSmNxgl3U0jgDc8zA4kTGFSqJ2whlExtp/ABQh7bqxXHURyDlgP9/e
	 9EAk+4W0sHbCO4xw4plxnsNGvYPcKjc6ggKLmE1Wi565UfAVCjtZ5tzP0dWkCZ1VhI
	 ReEu8A5z+o18C1Z7NRwnpm7Fi/1XJ5/YTYvGdgApztmxOW3V3atNC7glprhoTrCzhM
	 fyu/jCp6a9UTQ==
Date: Thu, 17 Oct 2024 10:33:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rishi Gupta <gupt21@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: veml6030: add veml3235
Message-ID: <4ziaz5rr3hhtu3uaelrr3udijeso36ckativ26qwu7wdrvidxb@jxeb4zlqgbzp>
References: <20241016-veml3235-v1-0-b904f802daef@gmail.com>
 <20241016-veml3235-v1-1-b904f802daef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016-veml3235-v1-1-b904f802daef@gmail.com>

On Wed, Oct 16, 2024 at 11:39:31PM +0200, Javier Carrasco wrote:
> The veml3235 is another Vishay ambient light sensor that shares similar
> properties with the other sensors covered by this bindings. In this
> case, only the compatible, reg, and vdd-supply properties are required,
> and the device does not have an interrupt line, like the already
> supported veml7700.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



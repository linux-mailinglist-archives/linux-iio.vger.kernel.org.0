Return-Path: <linux-iio+bounces-21011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BA7AEC100
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 22:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF5A5647C0
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 20:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E2B2264CD;
	Fri, 27 Jun 2025 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqEB7tDP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E6E1EE03D;
	Fri, 27 Jun 2025 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751056280; cv=none; b=h7+BKR/m9gErTry+wPMsd57uGRvkAz3mZ08hmLJyU0EgeaG88yRj0/0eeXkQax4GEAvcRYT/iZqBA/MCdqfY6ScoH1akIm7XbwR8Ele7bCykqN9nnzABGm2A2ZrsqK9dWNIGl8MnA8oo0cnAQkCu3ZY75NjFWzjs1/Tswa8W1JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751056280; c=relaxed/simple;
	bh=Q4joD0I2iiCOd+XFK08HVBTF0vf7uNpdrUvs65Kql+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGiZ5KNM+ptTRwOCMxGqSM8diri+S0WkTJ+F0AUDNnLFdAkSsOlue30MTxabcOuW0fUoI7frBLIufxrVxcmA2xOWhW99ngwjPn3Oo9hcJjLU8J1hTwwjMDf73YIag3sYAZdayEhj26gNmYTLn0lW0BGG5t2tvY4fRj8/AS6jNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqEB7tDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B6CC4CEE3;
	Fri, 27 Jun 2025 20:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751056280;
	bh=Q4joD0I2iiCOd+XFK08HVBTF0vf7uNpdrUvs65Kql+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqEB7tDPwd/dTf9pdxiIjmDCdyInWkq0rHDIdKi2KUqfSLfFtfZuJSZKmUMxD/gKR
	 HaQ1LZqsvgFVw6fdg3nLITnZtSaiyeRcKjV1dGzhzY78SK8jbX3UyPvw3M7tUIlLG0
	 lz7xJn6qMAsTAEw/ExqI4nLzVVVDa+Zmm+2qpzQg7qYeoMYkulPNBkt5WbLElBFqv6
	 btk5Aap2s6xcYP+jF61BrtZ7fh9vUapTQml4FeNB4tkeWChVam03pUR4pQg+yDnrj5
	 9wfs21rfKrG/qHI4BYO76/lIczRF1GDQxqdd+oRQOhmcITXJTKFYeWEtG44qvaPBGm
	 HybCy5cIRuvaA==
Date: Fri, 27 Jun 2025 15:31:19 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: iio: adc: nxp,lpc3220-adc: allow clocks
 property
Message-ID: <175105627901.33520.13967663171471942396.robh@kernel.org>
References: <20250624201302.2515391-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624201302.2515391-1-Frank.Li@nxp.com>


On Tue, 24 Jun 2025 16:13:02 -0400, Frank Li wrote:
> Allow clocks property to fix below CHECK_DTB warning:
>   arch/arm/boot/dts/nxp/lpc/lpc3250-ea3250.dtb: adc@40048000 (nxp,lpc3220-adc): 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-adc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



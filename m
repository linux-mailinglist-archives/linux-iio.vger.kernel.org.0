Return-Path: <linux-iio+bounces-23694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F4B42C25
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 23:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71CA77AC085
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 21:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A672AE77;
	Wed,  3 Sep 2025 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG0urmAA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D82DFA2B;
	Wed,  3 Sep 2025 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936349; cv=none; b=E7TVBsO+l6A8CYobffBarkAG+ZGaKrELI74yM3AZy2OgO9+T9euNHcQ/zPEV/gdEmeRdjDKWxA4s3RfJfx27zgMeQO/qcqWbnhvKMAeReLim3KKS86WSfoFlgF1i2Yh4dcQIemTv/Vw9jxkCwKTOLztVNjlKfUO2Zc7ACPfNImo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936349; c=relaxed/simple;
	bh=2DQiBmm5Wlo3Sk/HZKXiVgdNTuFCLUGmZBGgT5C7jYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fey/jBiZ1f5s6mlMTjRv1MDvbzaJUVeKCMl1acqA2gRtHYgAfueFpbs/WlhZqLL75mf6dcIo59q81vxHLQm+8vktoOAwwYY3hojKVmsNORzJ/07FYp7z/20iAbktzbQ+aHyq5tOHMMnhm61L85MsKvz/AnEBqPJDBM3b5X4NMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG0urmAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8975FC4CEE7;
	Wed,  3 Sep 2025 21:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756936347;
	bh=2DQiBmm5Wlo3Sk/HZKXiVgdNTuFCLUGmZBGgT5C7jYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PG0urmAAF05aRJdLWTI3Cae9GCwJkKMe21J3lI79D0qeZS+72g/LXlOSppIlSYTPq
	 WXrDEN+4ykJ8s2OpgjM2BALxy7o5l/h8Xzm8uZ29WXMSy1P150J6hIfY+Ud0qLD8Ok
	 27H0uR1z3Ga3jfLIoCJYuGNvUZxvWRnOaZ30sLM2kJU/5EbnDnN/hfQWIZzp7r9Gh1
	 pdrUAQe7i440ykjeazVAanizZ4qqTAN3SzcTrg9UCkLWjo8S+IIuEwZgf68ddDpzDd
	 srXRd8yk/p3MOsVEsVP16QlWnAiiEGvCW6Ryp/3a/B6TUv53v8O1N2vMkoWMXwd1CG
	 W0ISyW3H8w9lw==
Date: Wed, 3 Sep 2025 16:52:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: krzk+dt@kernel.org, mbrugger@suse.com, conor+dt@kernel.org, s32@nxp.com,
	chester62515@gmail.com, dlechner@baylibre.com,
	devicetree@vger.kernel.org, jic23@kernel.org,
	linux-kernel@vger.kernel.org, ghennadi.procopciuc@oss.nxp.com,
	linux-iio@vger.kernel.org, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add the NXP SAR ADC for
 s32g2/3 platforms
Message-ID: <175693634467.2902578.11035954677902748188.robh@kernel.org>
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-2-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903102756.1748596-2-daniel.lezcano@linaro.org>


On Wed, 03 Sep 2025 12:27:55 +0200, Daniel Lezcano wrote:
> The s32g2 and s32g3 NXP platforms have two instances of a Successive
> Approximation Register ADC. It supports the raw, trigger and scan
> modes which involves the DMA. Add their descriptions.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../bindings/iio/adc/nxp,s32g2-sar-adc.yaml   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



Return-Path: <linux-iio+bounces-13873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5E39FF6B2
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2025 08:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602723A2441
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2025 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47329191F60;
	Thu,  2 Jan 2025 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTMfkafw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC2179A3;
	Thu,  2 Jan 2025 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735804759; cv=none; b=nJhUF//3vYABdVZmJ/zoTmswlQzmsFl8jelPf1+9ITZ5eKR5P/QxJb24DzeqRty50MhkGD3USJ6XcUb38jGUzqoiM0oYUpUaMwq/96Cy6qZEVo4ItZp5y0upDB0pIYqBGmv++gjJHwfd9OZ09OVBsm97DrwX9QurorJAtJeD8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735804759; c=relaxed/simple;
	bh=Wtds6vwJjBF4P/XZvYFiH00JqcJXxnLQHetnGMvlTUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAQoe184yvBQ3X0Hgba0TV4iHAahqk0F54kzs837aYmi+qAJDPAgdgHP8EjaLW4DAPjQoH/LGkuXaEuV912SA+xKLGN6TTElqsdBAhdYPSDq1Rw65PfjE5keeaoM+iSKmY7waVbGad/nqoCsoY0aeIPW7uNiSbXIfLbLqfgEceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTMfkafw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B16BC4CED0;
	Thu,  2 Jan 2025 07:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735804758;
	bh=Wtds6vwJjBF4P/XZvYFiH00JqcJXxnLQHetnGMvlTUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTMfkafwdqE5Xtg30VWOi0HKrhX2KrG/HBucVTsuWPOgi/HepUzTyW6wm19DAJKgs
	 KvzXYINs5yYtWlkd5lZmg+gUOoFKINYa+otZWQY2OG/qtfq+C42aojIzPOIQ2FAO9s
	 Gien8iO5D+rNiFYkai3gJi0Ox+ISHOPVFD+081P+ZTo+j4tgiv5rQfa2OCdUfxMmVP
	 5LeVe/BBXGr/l54RIoKXPYLKKdkEmPIn0hsvv/icOXIkqi3qWsE2628XStkprVP0Ot
	 AwmfDm2eLuACKbLKiE1xvclC2yaroUHinrtBR63qQGA1bv572DAlRRztj0/4RYUcQl
	 nAF9LHNEC4f+w==
Date: Thu, 2 Jan 2025 08:59:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, gnstark@salutedevices.com, jic23@kernel.org, lars@metafoo.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	christianshewitt@gmail.com
Subject: Re: [RFC PATCH v1 1/2] dt-bindings: iio: adc: amlogic,meson-saradc:
 Add GXLX SoC compatible
Message-ID: <akqtrf3yklgplxutne63fq4iz2cxw4gkzinjgxldjdabbsvusd@rfuofb3bcqmx>
References: <20241231194207.2772750-1-martin.blumenstingl@googlemail.com>
 <20241231194207.2772750-2-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241231194207.2772750-2-martin.blumenstingl@googlemail.com>

On Tue, Dec 31, 2024 at 08:42:06PM +0100, Martin Blumenstingl wrote:
> Add a compatible string for the GXLX SoC. It's very similar to GXL but
> has three additional bits in MESON_SAR_ADC_REG12 for the three MPLL
> clocks.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml        | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof



Return-Path: <linux-iio+bounces-22298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C778B1AEB0
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 08:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6773A29BD
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 06:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831E21B9DE;
	Tue,  5 Aug 2025 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWGR43jE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29081C861A;
	Tue,  5 Aug 2025 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376560; cv=none; b=jkmI8/RSGW2Q0vG0iYWb0lRf4lMdzvk6C3gvYJpY5yKYFGWHdqkvR9KNnaMokacU1Tlpa5ctA3cXUkTwyqu3GcMZlHeo3YdMgizzHuohcMCUTEeB3/ury/X78HRmBV35GmZ3yTLfatgSnPOgHrt2w6pEt4uRVrj5fwU7UQtv9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376560; c=relaxed/simple;
	bh=SbzqbxLaCPA0TZ/dsHQ//SXDXD/27T/C/5e1ebRh5Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWMmj5NaJr0dHey1nJmwNNn/uyV3bNzlpz+x+RvBNnrRSJbMmbqevuDT/zuqcwBR25mJfxSaAaGCUq5fZQ5uRx/D8r6ZhtK0MbiSpOWzV8z8xHOJQ6dC5OOa0qZt4n11nSGcL0Hg5dZdgcCKzVJ7oyZ3cgK5ZfL/Xjbrt9Spd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWGR43jE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73871C4CEF4;
	Tue,  5 Aug 2025 06:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754376559;
	bh=SbzqbxLaCPA0TZ/dsHQ//SXDXD/27T/C/5e1ebRh5Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWGR43jEK98XIi5B7vBilRtiQ33+IZDcZWNcliaGvscWwLC535n8loYNQXBJf5jQP
	 Zix8piO9RIB6jibngVFpL/8kv5iLw7d5ch6Emura2n5+EHj9i2+iAiev8+cdaClLsi
	 4cbPtosbmypUV4YHpYjr7NwzhU4STfVXM7Yb5bSmxgqd4s2jGh4SBUPy4kbnVUtZB6
	 xpKsW5BVSKQsEcJIfTHd7P8scYKq1r+0OpeHYar+CZ148xXgmP9zM9WGJ5H/olpn2Q
	 4PiHJSZ2ZT89PmXNYEGhDOvdEpjeec2wNItWlHamsDAVO4+VeoVcYztuL1ie5Ss3ER
	 e1clwW56m3H3Q==
Date: Tue, 5 Aug 2025 08:49:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: eugen.hristev@linaro.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, srini@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] dt-bindings: microchip-otpc: update dt node example
Message-ID: <20250805-warm-waxbill-of-revolution-5abe32@kuoka>
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
 <20250804100219.63325-4-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804100219.63325-4-varshini.rajendran@microchip.com>

On Mon, Aug 04, 2025 at 03:32:07PM +0530, Varshini Rajendran wrote:
> Update the example binding according to the new driver implementation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml    | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
> index cc25f2927682..e9059dce85ef 100644
> --- a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
> @@ -42,9 +42,8 @@ examples:
>          reg = <0xe8c00000 0xec>;
>          #address-cells = <1>;
>          #size-cells = <1>;
> -
> -        temperature_calib: calib@1 {
> -            reg = <OTP_PKT(1) 76>;
> +        temperature_calib: calib@41435354 {

1. You did not clean up the header.
2. I looked briefly on your driver and it seems it changes the ABI
breaking users.

Best regards,
Krzysztof



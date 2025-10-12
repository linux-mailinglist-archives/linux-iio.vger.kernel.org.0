Return-Path: <linux-iio+bounces-24985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1FEBD0838
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52EF1890FF5
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE1B2EC558;
	Sun, 12 Oct 2025 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsX/d7ie"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14972594BD;
	Sun, 12 Oct 2025 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760288812; cv=none; b=a8xD0XSqQQsVPI6WfZvTgzHgyFOIPzUotGqR+xqi7teok1MdQffOfDKXzKsKGUB5zs2XZPoE0Un4GPs9oZ7KJhxFLLKcWCCmmWQ2CfYQlogWiyKW3Sb+nBbsR8T/fDQuo0tEwXCC1nagAzqCP7kjJjRqTKnhStAgTh5vjxPgRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760288812; c=relaxed/simple;
	bh=c4XBUmYW5+yztJ9CHlJGDquaE7OdDtySN6VncUWd2bg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKBux32TjUznAACIU1aD88xagZl6ugjPzd3qaV98mPG0+Se8XtkVcLVC+LYk1C4xwc4zFVyL5Uhph2HLKG/Ogu1C3f1/KfehakhgJJjF1+G/DSTfP/aUwZhTo8N1ZUBtBhDaDzp6kSFwEqkkghvtdtQX+wr4lrYPyuhllOl/xT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsX/d7ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6C8C4CEE7;
	Sun, 12 Oct 2025 17:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760288812;
	bh=c4XBUmYW5+yztJ9CHlJGDquaE7OdDtySN6VncUWd2bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LsX/d7ie/IrQVm8XgaQ9Guws0w+MoB5TRp+V6zHrWSKBo7PY8e+HQFmk6ZMxKdyHJ
	 nKr5i3P0h4aEnpu6ArNEuPt+VToiUU9BOgtPWPAc22iwcO1XyloRHBmjwZyC5W/4Y/
	 +75VWl1mwLSI8wLj26HnjcytuXaW+za2qMHpXOZgxiPPZkqfHcoZCXVKnPVhTcRMgV
	 dCW7Jop8ZtmUV3FG+ylg0P1FKqJPaO8MpguiTLTgZ4M2BfOUfm5u+O0CIRBrDRBWtv
	 HThu9WaT6qe4mcKTU9oDeMn1kOGSHqA6hzvD6gQtYssKmhSXJP3R/XWEj5H8wZKRVO
	 bhk7ZvEfbpesQ==
Date: Sun, 12 Oct 2025 18:06:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 matt@ranostay.sg, skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: max30100: Add pulse-width
 property
Message-ID: <20251012180644.019616c9@jic23-huawei>
In-Reply-To: <20251008031737.7321-2-raskar.shree97@gmail.com>
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
	<20251008031737.7321-2-raskar.shree97@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Oct 2025 08:47:36 +0530
Shrikant Raskar <raskar.shree97@gmail.com> wrote:

> The appropriate LED pulse width for the MAX30100 depends on
> board-specific optical and mechanical design (lens, enclosure,
> LED-to-sensor distance) and the trade-off between measurement
> resolution and power consumption. Encoding it in Device Tree
> documents these platform choices and ensures consistent behavior.
> 
> Tested on: Raspberry Pi 3B + MAX30100 breakout board.
> 
> Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> 
> Changes since v1:
> Add unit suffix.
> Drop redundant description.
> 
> Link to v1:
> https://lore.kernel.org/all/20251004015623.7019-2-raskar.shree97@gmail.com/
> ---
>  .../devicetree/bindings/iio/health/maxim,max30100.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> index 967778fb0ce8..5c651a0151cc 100644
> --- a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> +++ b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> @@ -27,6 +27,11 @@ properties:
>        LED current whilst the engine is running. First indexed value is
>        the configuration for the RED LED, and second value is for the IR LED.
>  
> +  maxim,pulse-width-us:
> +    maxItems: 1
> +    description: Pulse width in microseconds
I continued the discussion on v1 but just to make sure it is not
missed, add a bit more here briefly touching on factors that govern what
the right value is here.

Thanks,

Jonathan

> +    enum: [200, 400, 800, 1600]
> +
>  additionalProperties: false
>  
>  required:
> @@ -44,6 +49,7 @@ examples:
>              compatible = "maxim,max30100";
>              reg = <0x57>;
>              maxim,led-current-microamp = <24000 50000>;
> +            maxim,pulse-width-us = <1600>;
>              interrupt-parent = <&gpio1>;
>              interrupts = <16 2>;
>          };



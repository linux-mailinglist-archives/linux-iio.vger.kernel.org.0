Return-Path: <linux-iio+bounces-4325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC68A8EF8
	for <lists+linux-iio@lfdr.de>; Thu, 18 Apr 2024 00:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4090B1F221AD
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 22:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC188175B;
	Wed, 17 Apr 2024 22:50:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75DFC1F;
	Wed, 17 Apr 2024 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713394211; cv=none; b=QQWPMuA8doIeErSVQt8kVfH5CtKD7W1HdrHMhFdWJVkpWQdkTLmHh9x28Zxjl8WxRFPpjdOTDY4vWGkteGZ5ued1jSFbxAeVgVj7OPzucmCEzURpZQn/E6e1lPnPryhiBVfKUSZYDr5seIX09Ire9cprSx79y22lFoQcT5+0JGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713394211; c=relaxed/simple;
	bh=0ridCWApA+42FCQNlNEO70mklymUBj2SsXYIR57KkW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrcX0P3lUlSE8J25xwBALnUUvfeBeWBUbrEw+XaT/IP258YvxF0QK6kwIWeSBHbwyPAgLFj/6AkcPiPViAwS5T75uv/4tcyHxiYEm/y14HZ3MqcTn0vHRl//dpogWnhxlOVRO6TznOTrctESAZDF9x2EiUucRkP6S96Q+3NjAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4150B339;
	Wed, 17 Apr 2024 15:50:36 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F4013F738;
	Wed, 17 Apr 2024 15:50:06 -0700 (PDT)
Date: Wed, 17 Apr 2024 23:49:57 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 p.zabel@pengutronix.de, sboyd@kernel.org, mturquette@baylibre.com,
 samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, Chris Morgan
 <macromorgan@hotmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: Add GPADC for Allwinner H616
Message-ID: <20240417234957.2fcd14bb@minigeek.lan>
In-Reply-To: <20240417170423.20640-3-macroalpha82@gmail.com>
References: <20240417170423.20640-1-macroalpha82@gmail.com>
	<20240417170423.20640-3-macroalpha82@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 12:04:22 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

Hi,

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the GPADC for the Allwinner H616. It is identical to
> the existing ADC for the D1/T113s/R329/T507 SoCs.

The H616 is using the same die as the T507 and the H700, and since the
T507 is already mentioned in the commit message for the original
binding, I wonder if we actually need a new compatible?
I guess we follow the usual approach and provide this new
per-SoC compatible string, since the D1 and H616 SoCs are quite
different? Just wanted to point this out...

> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml      | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> index 7ef46c90ebc8..da605a051b94 100644
> --- a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> @@ -11,8 +11,13 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - allwinner,sun20i-d1-gpadc
> +    oneOf:
> +      - enum:
> +          - allwinner,sun20i-d1-gpadc
> +      - items:
> +          - enum:
> +              - allwinner,sun50i-h616-gpadc
> +          - const: allwinner,sun20i-d1-gpadc

I think a more compact way to write this would be:
	oneOf:
	  - const: allwinner,sun20i-d1-gpadc
	  - items:
	      - const: allwinner,sun50i-h616-gpadc
	      - const: allwinner,sun20i-d1-gpadc

In general: the description in the T507 manual looks the same as in the
D1 manual, just with the former having 4, and the latter 2 channels. If
I understand correctly, this difference is not modelled in the binding
(or the Linux driver, fwiw), so using the compatible fallback looks
good.

Cheers,
Andre

>  
>    "#io-channel-cells":
>      const: 1



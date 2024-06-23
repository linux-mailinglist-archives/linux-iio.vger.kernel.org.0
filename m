Return-Path: <linux-iio+bounces-6732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B5D9137B5
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 07:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7AA2837B2
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 05:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE95179B2;
	Sun, 23 Jun 2024 05:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWAn48xh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF042F25;
	Sun, 23 Jun 2024 05:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719119115; cv=none; b=ijO+xji/mIo7V9hV/eK8STWQEAaCs65zaYnFT6J0oVCiQvj8ueyYeDheGJu/lUiHn8DhjelgesipbB0k2TkWpy/oYxFt3lxjRmxUuXq8rcqE8tyffNKpJ1TfVJn3687Zp7XVYzf9dOd8vpvQzIWBrB2aDMpYzOc27Uw2xp/xG9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719119115; c=relaxed/simple;
	bh=tJiAum9d/TW+dnQNZJH0IHW2TsxXG4uK9btlFK2zB7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxqWlzwDG7dWhrbrC05yLgD5ct6e39vztADaEydQvGTbf7VJKbDOlb3hhvWX7KUIa7UUVd1LdRr7nUDuOuCtohyKFNobhhPBVRpe7/cVNHxCvfMblAyBvw01GtWSKdOWyD+JfggYYfxTEPyWOhnNPWEUAk6+W4DDRn9QwhsGhQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWAn48xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C733CC2BD10;
	Sun, 23 Jun 2024 05:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719119115;
	bh=tJiAum9d/TW+dnQNZJH0IHW2TsxXG4uK9btlFK2zB7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWAn48xhBGnCQv3p3wxRoQkuF8UkHyxRznydVqAOdCM2mOeR1sGRTsWC0CGxeFSlP
	 TcLttQeTUtyEF+HdF69F9zjyaJfoBgPo4wFQBLYruMdRvOhWQ/DHiiqRDrgupiNJtH
	 SXuoIUsVi2ul4yOUkloiQcrFA8oPT1dHhvwLMGKtiQDnLN4WbtJLqADowgSQb4k/bL
	 lxaGnqZ+t0WDBFfcM/1BUM5oVsZhyIofounzJu/2Z47rUNqA4mXShA7tB98ftrXYM7
	 Q561VAtTMSHC/XmXO15NYEWMAsgaGXBle2AOjl5DC9KlP/wk52ex4k/Rv5p8ENzKgb
	 em1p0He5EFE8Q==
Received: by wens.tw (Postfix, from userid 1000)
	id F2C5D5FA33; Sun, 23 Jun 2024 13:05:11 +0800 (CST)
Date: Sun, 23 Jun 2024 13:05:11 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	broonie@kernel.org, lee@kernel.org, samuel@sholland.org,
	jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	lars@metafoo.de, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 3/8] power: supply: axp20x_battery: add support for AXP717
Message-ID: <ZnetByjY9HIKkGWV@wens.tw>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
 <20240617220535.359021-4-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617220535.359021-4-macroalpha82@gmail.com>

On Mon, Jun 17, 2024 at 05:05:30PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add binding information for AXP717. Also, as the driver can read
> simple-battery parameters for the AXP717 and other batteries, define
> the simple-battery parameter.

The binding should not care about whether the implementation (driver)
can or cannot do something.

Probably reword it like "the PMIC can be programmed with specific
battery parameters".

> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../power/supply/x-powers,axp20x-battery-power-supply.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
> index e0b95ecbbebd..8d6b06117f6d 100644
> --- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
> @@ -23,11 +23,18 @@ properties:
>        - const: x-powers,axp202-battery-power-supply
>        - const: x-powers,axp209-battery-power-supply
>        - const: x-powers,axp221-battery-power-supply
> +      - const: x-powers,axp717-battery-power-supply
>        - items:
>            - const: x-powers,axp803-battery-power-supply
>            - const: x-powers,axp813-battery-power-supply
>        - const: x-powers,axp813-battery-power-supply
>  
> +  monitored-battery:
> +    description: |
> +      Specifies the phandle of an optional simple-battery connected to
> +      this gauge.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
>  required:
>    - compatible
>  
> -- 
> 2.34.1
> 


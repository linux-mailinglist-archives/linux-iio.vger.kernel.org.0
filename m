Return-Path: <linux-iio+bounces-6731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CA59137B2
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 07:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC91282FF5
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 05:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE551773D;
	Sun, 23 Jun 2024 05:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNQbAJlt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C39F2F25;
	Sun, 23 Jun 2024 05:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719118969; cv=none; b=RYGnyVd4uanT2U0Tya3ZtOanN7z6swBwYMFqaT5BIqYKt5dpL7VkAwkwHfl/hnmCxtpbWeRb9/4etDP+BiuOf2AS+ePQ0wDkpjMqlvJ2bpKb9lOfMReP46k75JZMaO65NLSFbLPJS2DJh9oeR2jVijI6JEMJCLcJl5nkrkMwW44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719118969; c=relaxed/simple;
	bh=pUBev5KIqo/Xw0UnEJ+5acBfwXIJj2djxWqJwU1DlKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo21zE7gEWgssgd6WrJSUx1frW3vtZlPKGGGqttle8d1XRtek024bfA3tR4IZ3SdRhtcOgxvukT2IzQ+xwHstfamGVh3NMmnSZX8V+KVvkBGTOZHnFSphXU+/EeKzSKAWDPFZJ65Bk0OhFWNn2IyOBeuwgW3Vm8rTVUYjMeX3Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNQbAJlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6D8C2BD10;
	Sun, 23 Jun 2024 05:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719118968;
	bh=pUBev5KIqo/Xw0UnEJ+5acBfwXIJj2djxWqJwU1DlKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNQbAJlts3piVt6Nj4UvLSx/n3tYRt2UHgpVSD4/8N1vgkfu+jT6C3DFYsLYiL7B3
	 Cd0WMK3BNoYlev04V74zdvZxLvri8jHDlHAsjBzZHNC+xu1aAwf39gY+yF83JCB2da
	 IqyE4jqF+47rw698Bcvk0T3cs2pWDqWRjwzP83/1P+6y+mrVlSl9yt7Qs86pO+KX6x
	 T9Jp7cc+H2bctRoGyUL3Qvk/8Jc4WKDk+WzrkIzs+vGZtiWKmwtJhb6jwIjW13JcNy
	 6o0Re7V33GOuIvyi5qVlroCdjFlCzampSHnUKcImpU3u7YpLvofhVM4vSnTG9/lUR0
	 cfWgp0XXYdMvw==
Received: by wens.tw (Postfix, from userid 1000)
	id 63C405FA33; Sun, 23 Jun 2024 13:02:45 +0800 (CST)
Date: Sun, 23 Jun 2024 13:02:45 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	broonie@kernel.org, lee@kernel.org, samuel@sholland.org,
	jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	lars@metafoo.de, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 2/8] power: supply: axp20x_usb_power: Add support for
 AXP717
Message-ID: <ZnesdbUXhl96GLRC@wens.tw>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
 <20240617220535.359021-3-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617220535.359021-3-macroalpha82@gmail.com>

On Mon, Jun 17, 2024 at 05:05:29PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the AXP717. It has BC 1.2 detection like the AXP813
> and uses ADC channels like all other AXP devices, but otherwise is
> very different requiring new registers for most functions.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  .../power/supply/x-powers,axp20x-usb-power-supply.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> index 34b7959d6772..e5879c85c9a3 100644
> --- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> @@ -26,11 +26,17 @@ properties:
>            - x-powers,axp202-usb-power-supply
>            - x-powers,axp221-usb-power-supply
>            - x-powers,axp223-usb-power-supply
> +          - x-powers,axp717-usb-power-supply
>            - x-powers,axp813-usb-power-supply
>        - items:
>            - const: x-powers,axp803-usb-power-supply
>            - const: x-powers,axp813-usb-power-supply
>  
> +  input-current-limit-microamp:
> +    description:
> +      Optional value to clamp the maximum input current limit to for
> +      the device. The supported min and max values will vary based on
> +      the PMIC revision, consult the datasheet for supported values.
>  
>  required:
>    - compatible
> -- 
> 2.34.1
> 


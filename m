Return-Path: <linux-iio+bounces-8188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B93946952
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 13:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91AB21F21928
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 11:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C7E1509A4;
	Sat,  3 Aug 2024 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iME8lyvX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B59914F9FE;
	Sat,  3 Aug 2024 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722682773; cv=none; b=eZ9OVno+R/qyBrC5E0rAGYYzWxbWU83fnkeIRp6CiV+5PWozbKed4tf+vEnmqNon0PLpK4QXoJ28j7nd1o69kXYlL+ViCirmojY/7dL6W7gzf66qS+qTIbrlzVEzvNyUwanexs3ZksUUlmDVZVVpeWwiyMk/DhokHZ6XqW0mjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722682773; c=relaxed/simple;
	bh=hgM+f3sD+d917WGPvZIS0qL/pRruh37OfrX73Jjl+zI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLAE59ZIHll20f2oMetAC77nsR9KOsk1zlzCQDsCZF2SmuTmRxqLYmGGjOUmmWObdGRwrD842fCMMT7TPfCljqi7h51Y0tdRL/zgeSwaZ5BtO0C/ErN5I32kN77AZw2K35bfAWk13e8xFMi1ueHHkoZmXYJ6zDWQNVQ/SOf0aF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iME8lyvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBDCC116B1;
	Sat,  3 Aug 2024 10:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722682772;
	bh=hgM+f3sD+d917WGPvZIS0qL/pRruh37OfrX73Jjl+zI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iME8lyvXdeTTTsN7XF84l0J3XCvMYXI2UVihEtlXxAzmO3kiUrrywk2j1abibb9h3
	 ezGuo01aS1JJnCERR/8mz2ibfD1c5EW75iOMqS0Xq9OUkSK6Y6hcQhDBrunEik5gtj
	 s2uqonCNGiQdjBVYiJ3Jf53GICNiGYLl44PvnzT66Sv478R9SpQCDcf9FwSiGmxHUX
	 0vfc18qlY7bDFhfA+Dizx1R+s/LDAICokUNV67Cz/q3GSPTaRMDYEyLvRjNU/05A4/
	 xZB+UjgzKYASPSH08wsyjuMo752sngDY9ma9yn+/usbkM+OugZ+31l/IvXnhp7F5DC
	 IMQUQkp9AURgQ==
Date: Sat, 3 Aug 2024 11:59:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, quentin.schulz@free-electrons.com,
 mripard@kernel.org, tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com,
 u.kleine-koenig@pengutronix.de, lee@kernel.org, samuel@sholland.org,
 jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 Chris Morgan <macromorgan@hotmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH V2 08/15] dt-bindings: iio: adc: Add AXP717 compatible
Message-ID: <20240803115920.3499eefb@jic23-huawei>
In-Reply-To: <20240802192026.446344-9-macroalpha82@gmail.com>
References: <20240802192026.446344-1-macroalpha82@gmail.com>
	<20240802192026.446344-9-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 14:20:19 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add compatible binding for the axp717.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Given dependency of the driver patch on MFD. To give the option
for the whole lot to go through MFD.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../bindings/iio/adc/x-powers,axp209-adc.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
> index d40689f233f2..1caa896fce82 100644
> --- a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
> @@ -37,6 +37,17 @@ description: |
>     3 | batt_dischrg_i
>     4 | ts_v
>  
> +  AXP717
> +  ------
> +   0 | batt_v
> +   1 | ts_v
> +   2 | vbus_v
> +   3 | vsys_v
> +   4 | pmic_temp
> +   5 | batt_chrg_i
> +   6 | vmid_v
> +   7 | bkup_batt_v
> +
>    AXP813
>    ------
>     0 | pmic_temp
> @@ -52,6 +63,7 @@ properties:
>      oneOf:
>        - const: x-powers,axp209-adc
>        - const: x-powers,axp221-adc
> +      - const: x-powers,axp717-adc
>        - const: x-powers,axp813-adc
>  
>        - items:



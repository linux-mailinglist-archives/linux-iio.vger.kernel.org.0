Return-Path: <linux-iio+bounces-11897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 589FB9BBA4F
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 17:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1ED1F21369
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 16:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68E11C2317;
	Mon,  4 Nov 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldVCwoVJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3F4A08;
	Mon,  4 Nov 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737491; cv=none; b=t6xN1qcUNtb/ck/7Q6BQuwb/RdmSrZYJpC3X+1WOv+5WiKE5YhG4AdsZQpXKsD0AUjjg0JeiV0Gg2fXYe4+woYyTvYrH8djp8l05+xfIwKv5KelwT0gW4jxnMN2Kg5FizgEWTJR9keTKrYQmlX5krESwzDVBG8NpI3zMb6N69cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737491; c=relaxed/simple;
	bh=xrziI1tIaUXMk8y9dkumNzCWo0adPVQBkgRWv0bOv/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ85aG+NCv61ViDnr2Z/217GXbJ+JFmhPLIzw9s47+ebkegylDB6LOK8bp8pGC/a+uPmKKevlowFTjFAzcspW7ioojKI+c5kuNz0ePIU/6kAmDXYCQoP5jRZ9dP+q0JjEbrYXVWRASMfIntUYs527l6jAtsPd9iWeCuFCtVb8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldVCwoVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BD3C4CECE;
	Mon,  4 Nov 2024 16:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730737491;
	bh=xrziI1tIaUXMk8y9dkumNzCWo0adPVQBkgRWv0bOv/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldVCwoVJN/qV4tYPeponloeViUeJtatA8XLMiBxMPNzIx9JnBnq4SP7CRgJxD/2Tc
	 h0/BFcKu4weg8f0ZZzK1+TpyeHbXdL/1XLs09FyrzyU/UVpzPYNe58F4+dBLz2zNza
	 lZ30SAjR4S49p53lzPOk5m32e32MkuzTFOA82LEUj6a/ILg8cw339PAiCRvvhFkkB1
	 c2dhqtDcGhCxcHnlOQ7z02Zxl2mjD0TFKlmqBJyZW4Vge6FWFbVwe4N4BG3V7hqv0K
	 hVcdnAFUXtf6+zVQl+YR+tU4bReETfy4j7SVfzEdMcpNa/q+XSWXVLyvWr7PgxP8My
	 21rJFQG/DISEA==
Date: Mon, 4 Nov 2024 10:24:49 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-leds@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>, linux-pm@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mfd: sprd,sc2731: convert to YAML
Message-ID: <173073748767.396036.1315745377945875916.robh@kernel.org>
References: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>


On Mon, 04 Nov 2024 09:48:21 +0100, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC27xx PMIC bindings to DT schema. Adjust the
> filename to match the compatible of the only in-tree user, SC2731.
> Change #interrupt-cells value to 1, as according to [1] that is the
> correct value.
> Move partial examples of child nodes in the child node schemas to this new
> MFD schema to have one complete example.
> 
> [1] https://lore.kernel.org/lkml/b6a32917d1e231277d240a4084bebb6ad91247e3.1550060544.git.baolin.wang@linaro.org/
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Changes in V3:
> - remove $ref to nvmem/sc2731-efuse and list the compatibles with
>   additionalProperties: true (Krzysztof)
> 
> Changes in V2:
> - rebase on next-20241029
> - drop partial examples in child node schemas, move them here (Rob)
> 
> Link to V2: https://lore.kernel.org/lkml/ZyExK01iprBHhGm6@standask-GA-A55M-S2HP/
> Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP/
> 
>  .../bindings/iio/adc/sprd,sc2720-adc.yaml     |  17 --
>  .../bindings/leds/sprd,sc2731-bltc.yaml       |  31 ---
>  .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 252 ++++++++++++++++++
>  .../bindings/mfd/sprd,sc27xx-pmic.txt         |  40 ---
>  .../bindings/power/supply/sc2731-charger.yaml |  21 +-
>  .../bindings/power/supply/sc27xx-fg.yaml      |  38 +--
>  .../regulator/sprd,sc2731-regulator.yaml      |  21 --
>  .../bindings/rtc/sprd,sc2731-rtc.yaml         |  16 --
>  8 files changed, 254 insertions(+), 182 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



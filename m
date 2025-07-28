Return-Path: <linux-iio+bounces-22104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEC1B13C94
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 16:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A04169CC9
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 14:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F2026B749;
	Mon, 28 Jul 2025 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1ziiPBW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F34E26658F;
	Mon, 28 Jul 2025 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711090; cv=none; b=b1TGp+oPChvjtZtINQSd1uIPih8udebOJJ6zhPkMpAYP0hiD8CEDasYIWUYk/UyjdHplmuKcpX3Gd1OBzpQP3ixT25lfUbc8VLHJDoBgJVs22/1LUGMUiCwuEC/h0zRtDkRDGepbcpJv16hVGH8xz3MPWUY/Mctwy3VA9c57rBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711090; c=relaxed/simple;
	bh=aWnVacSq0TZnEf1mKVycTNmWECLkzfn4f9ZiLfMVK9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYyD1OVTBYPTxYMjAnbIYvNoZdwB4ISAdhTRwuZAtCHrwAU7UXs4vgS56bfZF5rLlIcMi1iLful1XMYck5ceEPtzpRFs7wTxgYGHrglEvDYqhFiFzodM6wJYbdhmQXs+CooR1DHeCZTAEYB1wrt7fyYLu/WpGkMmfGJbH//EQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1ziiPBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11349C4CEE7;
	Mon, 28 Jul 2025 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753711089;
	bh=aWnVacSq0TZnEf1mKVycTNmWECLkzfn4f9ZiLfMVK9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k1ziiPBWdsC8M5UZ9W5cMrfAQ0HaeEyKdib6v5MIEH0rJ1vgxwAG6NyrNla/m+5NB
	 ZnjVD0F7cdDtGqR60jXdRGivT6smpDrGxnriVgDRukYpCttn1CKzawxMWWwdH8eXSq
	 xeXviZn997zo+wofxDun0PFWSJ/qeqlfqR0dzVkHVgixgQ6P28xChPK2SIfThlcMF9
	 bwTid6s4P3JCjWAbYzEHg35ik4JUMmnap2da25OCd+bKyixNdKPzkxLXPPh92Vsq2n
	 LCHq2Q0mWKL/tvzjb5RMF8Jv3v6CtHONLP0u8Zvb/RyHl+WFL+WpjYg7IvWXi1hGDZ
	 FsQEuvmqlDQpA==
Date: Mon, 28 Jul 2025 14:57:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ramona Nechita
 <ramona.nechita@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindigs: iio: adc: Add ad777x axi variant
Message-ID: <20250728145759.1f0aa58c@jic23-huawei>
In-Reply-To: <20250728134340.3644-2-Ioana.Risteiu@analog.com>
References: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
	<20250728134340.3644-2-Ioana.Risteiu@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 16:43:33 +0300
Ioana Risteiu <Ioana.Risteiu@analog.com> wrote:

Typo in patch description.  I'll fix it when applying if nothing else comes up.
(bindings)

> Add a new compatible for the AD777x AXI IP core, a variant of the
> generic AXI ADC IP.
> 
> While sharing some operations with the generic AXI ADC IP, the AD777x
> variant has specific requirements such as setting number of lanes.
> 
> Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> index e91e421a3d6b..1265ec5390d1 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> @@ -30,6 +30,7 @@ description: |
>    https://analogdevicesinc.github.io/hdl/library/axi_ad408x/index.html
>    https://analogdevicesinc.github.io/hdl/library/axi_ad485x/index.html
>    http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
> +  https://analogdevicesinc.github.io/hdl/library/axi_ad777x/index.html
>  
>  properties:
>    compatible:
> @@ -38,6 +39,7 @@ properties:
>        - adi,axi-ad408x
>        - adi,axi-ad7606x
>        - adi,axi-ad485x
> +      - adi,axi-ad777x
>  
>    reg:
>      maxItems: 1



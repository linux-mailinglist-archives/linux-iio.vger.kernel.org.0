Return-Path: <linux-iio+bounces-9454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC659764F7
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 10:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C111C20A5A
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9870191F6E;
	Thu, 12 Sep 2024 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WFHJSOch";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="MztR/XCH"
X-Original-To: linux-iio@vger.kernel.org
Received: from a7-50.smtp-out.eu-west-1.amazonses.com (a7-50.smtp-out.eu-west-1.amazonses.com [54.240.7.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF9118BBA1;
	Thu, 12 Sep 2024 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131162; cv=none; b=BPXSHQ6PeVWXhJ5l8YTMXqyHFeH3xHEBhjH9LDD8gT1Iqa/MIKnMks216Geq1FzXIqZVKbGgRilaV3sqfnUkEmoY8F1A1EXHxsHEWH7Ln0N0zhJY0oN8OJoqycysxfHg4YylZ/HL9OmReS4iOt05DZ4rqua6n8Bxj9JrEsGKHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131162; c=relaxed/simple;
	bh=xJ9eCl1S0Iib7OyTFXyfu7E4QHZm/EK9MdR3L+m6jec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pefrxDZLjmBmAOXhbhlTMZn3vuwM2RCn2PX5fNysbMDSBSxZZ+xBSfoatCcWlCmsl3xrJ8hTJuB2zF6EAe9/NojZEwkciQzztN9nxuP4/Tw7OWTlX/l2Qc3UYt24PBownDtz9wmpVTRzo4RE8YlOFaMzMZ6K17PsXxev6ljYIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WFHJSOch; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=MztR/XCH; arc=none smtp.client-ip=54.240.7.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726131159;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=xJ9eCl1S0Iib7OyTFXyfu7E4QHZm/EK9MdR3L+m6jec=;
	b=WFHJSOch1FvME8xcQx8Vv+DhTaiZg8MNLVbiPbL5Lz2hytT1xDhsRd7PPn4D+cl9
	DP1KBtLfO1dDOhfLVIRyTi7VsQi6JkSUyQoKib+Y9McTG0EI4AUaOD81ZQsAQl96+OX
	t4aGLD8D58xVjF8qe+0S15lU+wzcrVdKNqqW6UV9dQUQiKx9CNAVzqm5eLm24MsIo+S
	EeuvjJj2hLn/Ja5E5YGyeufA8386U6O2Jj+f0yQZO9q119XS4nTpFPMMMTTnIohxXyD
	l8kqvgAiU7XVN1pb8tC3Q13r8Q8WXLTbLNnkM5JAaMBEYtftQEatV/ZIJ5pJl+5jHGv
	75wKXDK99Q==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726131159;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=xJ9eCl1S0Iib7OyTFXyfu7E4QHZm/EK9MdR3L+m6jec=;
	b=MztR/XCHSiCKUwbLYZTA3+Hhe+xQhiGVyicjuvUX1zjHqP6/8P0tiOMhNN0fA9fQ
	o8JO9d9DUrihPvbi8u8nICihzwrIyl7iyKDGrIpzKUoisFUTPxWIq6Yv/AVbO/MKCCq
	2+FYZKMRNJn5xpWQmIXOOXzZRM6//pNiBsOmKpe0=
Message-ID: <01020191e56f3f66-1afb592c-a676-4871-b75a-bc38d896ae03-000000@eu-west-1.amazonses.com>
Date: Thu, 12 Sep 2024 08:52:38 +0000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] dt-bindings: mfd: mediatek,mt6357: Describe
 Auxiliary ADC subdev
To: lee@kernel.org, robh@kernel.org
Cc: lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, andy@kernel.org, nuno.sa@analog.com, 
	bigunclemax@gmail.com, dlechner@baylibre.com, 
	marius.cristea@microchip.com, marcelo.schmitt@analog.com, 
	fr0st61te@gmail.com, mitrutzceclan@gmail.com, 
	mike.looijmans@topic.nl, marcus.folkesson@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, andy.shevchenko@gmail.com, 
	kernel@collabora.com, jic23@kernel.org
References: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
 <20240604123008.327424-3-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240604123008.327424-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.12-54.240.7.50

Il 04/06/24 14:30, AngeloGioacchino Del Regno ha scritto:
> Describe the PMIC-integrated Auxiliary Analog to Digital Converter
> subdevice node.
> Full description is available in the mediatek,mt6359-auxadc.yaml
> binding relative to that hardware.
> 

Hello,

I just realized (indeed too late) that while all of the other commits of this
series are upstream, this patch was not picked, causing dts validation warnings.

Should I resend or can you just simply pick it?

Cheers,
Angelo

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../devicetree/bindings/mfd/mediatek,mt6357.yaml       | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
> index 37423c2e0fdf..e3513cad25f6 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
> @@ -37,6 +37,11 @@ properties:
>     "#interrupt-cells":
>       const: 2
>   
> +  adc:
> +    type: object
> +    $ref: /schemas/iio/adc/mediatek,mt6359-auxadc.yaml
> +    unevaluatedProperties: false
> +
>     regulators:
>       type: object
>       $ref: /schemas/regulator/mediatek,mt6357-regulator.yaml
> @@ -83,6 +88,11 @@ examples:
>               interrupt-controller;
>               #interrupt-cells = <2>;
>   
> +            pmic_adc: adc {
> +                    compatible = "mediatek,mt6357-auxadc";
> +                    #io-channel-cells = <1>;
> +            };
> +
>               regulators {
>                   mt6357_vproc_reg: buck-vproc {
>                       regulator-name = "vproc";



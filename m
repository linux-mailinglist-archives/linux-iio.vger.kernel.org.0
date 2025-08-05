Return-Path: <linux-iio+bounces-22299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C26FCB1AEB3
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 08:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD01172FFA
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 06:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135DF21C9E5;
	Tue,  5 Aug 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usAIvtHr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FDE1C861A;
	Tue,  5 Aug 2025 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376620; cv=none; b=p+pSkCUuTNCFWi0FdS4J6HHqfzSiBdBkmdp8ovOnzaapYeVWa95FclkwpL6LuQV1sIGuEQCDUUA9ao1I+FOz05rpDMLARTmztHXjlApAFXnzZpaiIPr+OkG2neml4bbXSH07ZLSm3zu468NesA3dZYQlVfw9qBVgIeIMc+F6fSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376620; c=relaxed/simple;
	bh=ataxtz/n54x5sp9JZ6Vy9kgFTYfOAehKaIPuusetPXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUDCM+5+mvRuXAPQLumSPyF38jOE74sSU0PdUGZ70mvJbrLT6jMQDcK6k+KHZHihWjuoLn19lCUgIVNFwUrAsTdPUOb0oa7nzj8ezDv1Gn5LJcin7KrdZsMjIWJ2po5k8/AoCCnNcT7R5DBxZQhb2FKpNUNjb+k8NjYZPSYaE9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usAIvtHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2ACAC4CEF4;
	Tue,  5 Aug 2025 06:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754376620;
	bh=ataxtz/n54x5sp9JZ6Vy9kgFTYfOAehKaIPuusetPXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=usAIvtHr6Zd12HV3k5qee5KbtDSkp/5gcEVafjDCji+n4tixPSwkgSsuB5YnpwKmm
	 WfG1K9bUeSOq8TzI3EC35s/Xahb8vKfDk6TguUqjWNX5HbjkXJGUXozxlgm7aS6z1V
	 CdaoKybo/oFQ5iAiPjHvi1yzKDPWYPyvObkMGwHSLvryplZSqzNu61MtWNPaFvC8gh
	 7QSnIb2ZHnx2pwKMdUGVoogKKSBsePFHOjJTqFeksB2oTkuou9rlNt6K3cJHJoXN6O
	 DSt0+WPezIOVIGKBRrcX4ETjQqhVn05sdxYaPK1PPZIeB0ufD01TPagei+HQWOmXnS
	 73FVhtIpoQs9w==
Date: Tue, 5 Aug 2025 08:50:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: eugen.hristev@linaro.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, srini@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] nvmem: microchip-otpc: rework to access packets
 based on tag
Message-ID: <20250805-futuristic-versed-orangutan-4316d9@kuoka>
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
 <20250804100219.63325-3-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804100219.63325-3-varshini.rajendran@microchip.com>

On Mon, Aug 04, 2025 at 03:32:06PM +0530, Varshini Rajendran wrote:
> +static struct mchp_otpc_packet *mchp_otpc_tag_to_packet(struct mchp_otpc *otpc,
> +							u32 tag)
>  {
>  	struct mchp_otpc_packet *packet;
>  
> -	if (id >= otpc->npackets)
> -		return NULL;
> -
>  	list_for_each_entry(packet, &otpc->packets, list) {
> -		if (packet->id == id)
> +		if (packet->payload_info.packet_tag == tag)
>  			return packet;
>  	}

As mentioned in bindings change, this looks like breaking all the users.

Best regards,
Krzysztof



Return-Path: <linux-iio+bounces-7947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D6793D8BB
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 20:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA081C22139
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601104F218;
	Fri, 26 Jul 2024 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHKOltY0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147CB55893;
	Fri, 26 Jul 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019982; cv=none; b=YwPJuwYGkwVNbTXPO3CiunKm61eW4eC5m8EXAerIGlT29EaGbFFwz1WdvkY1/VCbF7vkEjtWfcKJZU1S2a1cvr4xbWTdh0m4TiTkkre+9FoWTh3rRNc7wz0888XK5HTFgiEQj8dG6a0y3GcyqFmnFBcEuaZY0lXjdCCl1asUFd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019982; c=relaxed/simple;
	bh=F25meDsgVhT6rrAFlD3i+G73q9RdY7t8Srzr/P23WVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I31U99SQXv79cF0de4LqcvNrD54v7INtiJhBc5dWaRAUQOgYMkeqypzBPqwvcIkhCNLwyv8hwufzigDZ3Q++XHoRlCUjWieMQuzZ13Y09jFp3JBeBAFEt/EX/K09rNSrLL7X8Rt6IJT8YSlbKr79PAlydbcmob9eHiOI7epwSLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHKOltY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A8CC32782;
	Fri, 26 Jul 2024 18:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722019981;
	bh=F25meDsgVhT6rrAFlD3i+G73q9RdY7t8Srzr/P23WVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHKOltY0k0+NvmxoF9e7wFKNk5OZ1u23kVTaXsxzfiTgOIjhdupDAP/Du8UE0TiwZ
	 vycPkBoj3lwmrl7FJKLDR/NXzIn+FdwUM73/E4yvn+uWhuvadmQhzWapuJzou9GFTq
	 BBp/zVe04DFNd5NS9LuZJx+Ns1Y3oMAMsXgRBbZMd26yQa9DiYfynrEoTinird1wM7
	 fm6zDqOvTD2BWjggGJTp0vfT4lpM+Q1hcFZaI0Y4r4Z6Qibw5BEwrycQm3obHL3xEn
	 7EOFo2bKEkxynkNQGCHdJ0J4Gk6fjFILpHWUOwU34flXKZq84E5z/GgkSbExUmuPDl
	 MXEDmsP/ZQxag==
Date: Fri, 26 Jul 2024 13:52:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] dt-bindings: iio: adc: ad7192: Fix 'single-channel'
 constraints
Message-ID: <172201986894.1860751.13842106591481858905.robh@kernel.org>
References: <20240723230904.1299744-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723230904.1299744-1-robh@kernel.org>


On Tue, 23 Jul 2024 18:09:03 -0500, Rob Herring (Arm) wrote:
> The 'single-channel' property is an uint32, not an array, so 'items' is
> an incorrect constraint. This didn't matter until dtschema recently
> changed how properties are decoded. This results in this warning:
> 
> Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dtb: adc@0: \
>   channel@1:single-channel: 1 is not of type 'array'
> 
> Fixes: caf7b7632b8d ("dt-bindings: iio: adc: ad7192: Add AD7194 support")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

I have other fixes for rc1 already, so I've applied this one.

Rob


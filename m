Return-Path: <linux-iio+bounces-21009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E94AEC08C
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 22:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE961C45966
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 20:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E842EA73F;
	Fri, 27 Jun 2025 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6YNk4To"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3A615E8B;
	Fri, 27 Jun 2025 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054573; cv=none; b=N6EpRBakstSjyQNKPJyLzy1IoE7HAPJcW6a4nammLLGMS+AYBruMBkTC0Ma5cfI1oQHKGRlatys24bDeL5d7nPJ+1SYT++B8y7C474lfWMowBAqJNUztKQKIZ1C2ugPqdk1L8xQ4dzliAj3Mpep+bi7FFWZNbf01+vgy92zcjEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054573; c=relaxed/simple;
	bh=Kn4BCp5llI7tE01yR+uf2dvC6F/CoYnl1ShENveaHkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFTV51eoxSMtWhVPWp8YZS7l2rK5eQ0by3ApziBVO6eSszvt3Pnqw/FO3qHw3JcmpMfp2xZeg8NdrD+OKOKFm5VDK5elIFm5XRdL7eZp/gwmJ5lcVnqSV8LLH/MFUDDthPaC2KSMfZd1hyVyUWDtnhe1b1PlfIGsmxRA8zxtO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6YNk4To; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE363C4CEE3;
	Fri, 27 Jun 2025 20:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751054572;
	bh=Kn4BCp5llI7tE01yR+uf2dvC6F/CoYnl1ShENveaHkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6YNk4Toj6vFLfrkCoBKx0pN8kG0bH0UB8Tm8QdeRMVACHCkx4+ZHR5qy9TeCg0yy
	 zhTe6rodmwoMHhYsQwjQQckfyPl/0cR3tbgFBrtjeuKjdgumMCInH7IJIu0qb5ykwi
	 RF2Lw0/zCqATfV/5oH0/w207nE0kOl97tUkqot5fBXuJmv2eonFC2nE+wskhNggqu9
	 200mkh2mT4R5P5ciwzYGitRZvI3zKgAqZgXMl+gKIjese/TX609bqMbpmKi9ZbN47p
	 NJn/JNlxsRzGUD8+jNhtoInRFqloUwfQP/6R3Wc5YTYSsdO1R7opzeTlOb1IWbvC1p
	 uSiUnsDiooL6Q==
Date: Fri, 27 Jun 2025 15:02:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, matthias.bgg@gmail.com,
	dlechner@baylibre.com, kernel@collabora.com, krzk+dt@kernel.org,
	jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, conor+dt@kernel.org,
	andy@kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v1 1/5] dt-bindings: iio: adc: mt6359: Add bindings for
 MT6363 PMIC AuxADC
Message-ID: <175105457149.4089682.1894322678019051751.robh@kernel.org>
References: <20250623120028.108809-1-angelogioacchino.delregno@collabora.com>
 <20250623120028.108809-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623120028.108809-2-angelogioacchino.delregno@collabora.com>


On Mon, 23 Jun 2025 14:00:24 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible and channel bindings for MediaTek's MT6363 PMIC,
> featuring an Auxiliary ADC IP with 15 ADC channels used for both
> internal temperatures and voltages and for external voltage inputs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../iio/adc/mediatek,mt6359-auxadc.yaml       |  1 +
>  .../iio/adc/mediatek,mt6363-auxadc.h          | 24 +++++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6363-auxadc.h
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



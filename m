Return-Path: <linux-iio+bounces-18467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C93DAA95814
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 23:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08C9169114
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 21:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48490219A91;
	Mon, 21 Apr 2025 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqvlGE7A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB94D21931B;
	Mon, 21 Apr 2025 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745271535; cv=none; b=pkVOItOgeqKtltgBB235gTgSKpZm3SQ+RWUBXT67YlT0osnl04xs9Zv+DSY7jPrD3+e5GgjZwQ+lJzakkiY/oF3CI8WwHT+9FavmP29kObhggT7LHpzCEehl/xnfjN+GVe85TWCc8rRkGReEYES+g1daAo2xFi2kjGgxmrFpDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745271535; c=relaxed/simple;
	bh=P6nmFQfl8tDNHNuZzm4b6tttJQZW4Sac0+eacXTdEPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dETojj1SEAWubvZOKpQOsn94m2JNRZgvZW+ndT1uXg9s7yNtC41TwH+NQc3IGU7mrI6BAjNWON3kG+7CUXjT8XHkJrN+FLFXMVFF5m2kdEMQ1kmgVue/2mdEkUdYl4NzeJ9xd/8zxYeNM/bz+HKVvEniqQOjchvIGXOzhyoHt3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqvlGE7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20443C4CEE4;
	Mon, 21 Apr 2025 21:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745271533;
	bh=P6nmFQfl8tDNHNuZzm4b6tttJQZW4Sac0+eacXTdEPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqvlGE7AxRIVNM8q2NdMVuX1QDRm31fP5PW6Me/cYE8T24hhSJ+s9XcJ9Xj6NBehq
	 Z4EJTSvJZWaFB9CLVrajvm++/uOVBw7FUS4OCI0pk1Aa1l3ZUV62B0Q4BGMID6IQYr
	 APNMubOH9TEwCY2PS+7dINzSYC9XwzzzNF/6/95/HTWs1G6K9ArEMUOytYvKVSF5mf
	 jcqT2RwfSVzOIMDUNK0LncWVGfPO40M8/ehb73KYh7ueiF2U5dMetgA4M4/KYRMu+Z
	 xI5m0LhjqEc4bN0s2Kk0umYFpKpaHTShxw59p3hzfWT3Lc3vSzS2Llx8+z0q8SXYnK
	 imSeilgUrOzCA==
Date: Mon, 21 Apr 2025 16:38:51 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, andy@kernel.org,
	dlechner@baylibre.com, matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	devicetree@vger.kernel.org, krzk+dt@kernel.org, nuno.sa@analog.com,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	zhiyong.tao@mediatek.com, kernel@collabora.com
Subject: Re: [PATCH] dt-bindings: iio: adc: Add compatible for Dimensity 1200
 MT6893
Message-ID: <174527153072.2973088.9157423165074778113.robh@kernel.org>
References: <20250416120235.147889-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416120235.147889-1-angelogioacchino.delregno@collabora.com>


On Wed, 16 Apr 2025 14:02:35 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible for the Dimensity 1200 (MT6893) SoC; The AUXADC
> IP in this chip is fully compatible with the one found in MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



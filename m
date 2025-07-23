Return-Path: <linux-iio+bounces-21922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B72CB0F775
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 17:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFE63AF7A6
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 15:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9855F1C1AAA;
	Wed, 23 Jul 2025 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmBKNNWa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A243BB48;
	Wed, 23 Jul 2025 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285831; cv=none; b=BZeZyF7kv7+qlfnQQSZAGhIgs95My/Pl8M6MHgV584SQEudZGmz7PeAGJDyoo6hP6QqWWswpM/6SldR/g0KGOcs+R8ITO1XKPH+rmsh+jldYgdVnObPwnLrLcO6CI/edwQojO+3M8AjhkF8ZyTXxpEFDkRbSfF0zij//JtLh0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285831; c=relaxed/simple;
	bh=q0RdIwl2onvcmCTOyNGzyc8T7XKOzlJKJ3pq4M0YgrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUpr3FPCUE81IWvx14tBI3q6IeiLJe4gkKqOQGKlf+yq3DwKA+eYfOorM116DmdegKYZOqtgmMfGqOL91NOYMffT5+wF6+lGD6kHqaBmg5PjTH2xWEucZM+a7dTE5zU4BoTAK4WqjBdfFohlk6xFstad/mPCka8pYgnHBW103Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmBKNNWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51412C4CEE7;
	Wed, 23 Jul 2025 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285830;
	bh=q0RdIwl2onvcmCTOyNGzyc8T7XKOzlJKJ3pq4M0YgrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SmBKNNWav95G3vsgJvAXo6iiufNuKUnjGCOlLlJ6awlSazcT+GVpf/l5k87yZbNFn
	 K3w14Y242PXRz3nw78+h6Bohl6wG5U54VpWGUqdcp902wpdo/m8CZ9QcdbAXqoUkC/
	 E88MH/T5icJwck0NvRSwhX42ciMp0O4yRqq3ubK7dtAfV0yROA1MpfN0wepLgWQH2p
	 pyIZKgqzA8UmZShrY5ukSSCQS83TLa3qcZKjZhtLj10JUjMMS6eHuhtoAd7S5qsi3k
	 g6OXWs2k+9kN0XPOPyAYmdCVHrVdoerUCnEJG5Zsw9QA9QM5ruBrYV7+OvfkZZJipn
	 G9io2fsDkj9ZA==
Date: Wed, 23 Jul 2025 16:50:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: adc: rockchip-saradc: Allow
 use of a power-domain
Message-ID: <20250723165021.4e2dd324@jic23-huawei>
In-Reply-To: <20250723085654.2273324-4-jonas@kwiboo.se>
References: <20250723085654.2273324-1-jonas@kwiboo.se>
	<20250723085654.2273324-4-jonas@kwiboo.se>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 08:56:45 +0000
Jonas Karlman <jonas@kwiboo.se> wrote:

> The SARADC controller in most Rockchip SoCs are part of power domains
> that are always powered on, i.e. PD_BUS or PD_PERI. These always powered
> on power domains have typically not been described in the device tree.
> 
> Because these power domains have been left out of the device tree there
> has not been any real need to properly describe the power domain of the
> SARADC controller.
> 
> On RK3528 the SARADC controller is part of the PD_VPU power domain.
> 
> Add support to describe an optional power-domains for the SARADC
> controller in Rockchip SoCs.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Applied to the testing branch of iio.git.

I'll be rebasing on rc1 once available.

Thanks,

Jonathan

> ---
> v2: Update commit message
> ---
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> index 41e0c56ef8e3..f776041fd08f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> @@ -47,6 +47,9 @@ properties:
>        - const: saradc
>        - const: apb_pclk
>  
> +  power-domains:
> +    maxItems: 1
> +
>    resets:
>      maxItems: 1
>  



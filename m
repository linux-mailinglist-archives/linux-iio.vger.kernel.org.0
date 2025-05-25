Return-Path: <linux-iio+bounces-19904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9075CAC3531
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA903B3BE7
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5881B1F4626;
	Sun, 25 May 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uT0d++RX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A94C62;
	Sun, 25 May 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748183533; cv=none; b=HAjGMpZgeVSpVvBJYobhnWFcJK+G7m/IBPIpwn/SPUqfSqLGsT4jeDmlCiWUBaP4hwBSXbjGNj5o3o/XSDyTke6lXOI75EE4rNvSXQbHisUOO3Dwsp8VV+SIyTdkFQcI6haHIY/u8fHgO6DxbeZfsrBLLGs00AkIV68Q1JxxYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748183533; c=relaxed/simple;
	bh=gD3iutxq4pqSFaNAhKZd5QxYH52E0Fd1DVRC+e7CGL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kfx88Gun0Bk8crqArDEMIvBewV6ND4GCHpF4nu8PNMIKsvs7EjYULz/KN2rWi1gL5Av0vVme1WX/uncKLhn5QFiMwc3asn6jwJiLaMofHMZP6FXrWxgB2B5Lb9TDgdpIjjaNMtP+y6A4bqknY10FwxiYLYBjHy5XD5wN0I4MNEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uT0d++RX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1A4C4CEEA;
	Sun, 25 May 2025 14:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748183532;
	bh=gD3iutxq4pqSFaNAhKZd5QxYH52E0Fd1DVRC+e7CGL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uT0d++RXL/JC2mIYgpix9YvqGiMzGu7LP9aCd2alUnLRCfE85To5H4yLZfezW+BGc
	 8P7I3HZzvJkYvgfeCaPJQ2HZOv8unzP+8g2mCLEPIN+Vrh8bhYEMQM70OsIpA/LSu9
	 EJGw4NeHe1nsa5kFpo0PCw1ESkMEjoHjJyZsJp+LfihOhpebU9f56GqMQGeCzqovwH
	 GskUhG7q89Yii89xmhbQxDbZxMwRrhiMcuUleKo2RSjsJdTMnAT4E+WDOlDpZhQKgv
	 Y0iSR9tFuU4YHof2FtaExlypoqntYdvLvx6wHudhQqFCA2FjJ1LHrj4iOw07yZO4Ky
	 +uIkGvRtdxglw==
Date: Sun, 25 May 2025 15:32:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>, Chukun Pan
 <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] dt-bindings: iio: adc: rockchip-saradc: Allow use
 of a power-domain
Message-ID: <20250525153201.51d733e3@jic23-huawei>
In-Reply-To: <20250518220707.669515-9-jonas@kwiboo.se>
References: <20250518220707.669515-1-jonas@kwiboo.se>
	<20250518220707.669515-9-jonas@kwiboo.se>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 May 2025 22:06:55 +0000
Jonas Karlman <jonas@kwiboo.se> wrote:

> The SARADC controller in most Rockchip SoCs are part or power domains

part of power

I can fix that whilst applying if nothing else comes up.


> that are always powered on, i.e. PD_BUS or PD_PERI.
> 
> On RK3528 the SARADC controller is part of the PD_VPU power domain.
> 
> Add support to describe power-domains for the SARADC controllers.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
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



Return-Path: <linux-iio+bounces-21900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079BBB0F466
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF5E17EBEC
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13512E889F;
	Wed, 23 Jul 2025 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY8CsQHb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588772E425D;
	Wed, 23 Jul 2025 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278455; cv=none; b=ldEu8uKVez+1Wb50wlCkKDo7bVZa9Q3mmU9T7CNHO3m3NuAj7oUk3sJEBzTVYmrHclfRYsW5adQUc5IoB1Ko16wgvkWIKPczA08PtslRfIIopTklxq5hkhDZFrvZ8Abr9NbwDMxPJS0ijp2jDYEuFyJTQbBN2gKX6jxWQq6rCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278455; c=relaxed/simple;
	bh=e4iFmU4V8FdSQBveMXcP7eTilC+19QO83wN4KtTy+Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNy/GbRyRvaDspL7FcwKUe7XABp3/QPkuKvZmviFBnsnLAGZoFZMzHhav7A9LeCaml7Eu9XWERAo+qqtfhxvL3ofLmy5wtNgxugYEYJrc3CgzMNGKj8XWIb6PuPCs9NDCBBoq+3CVhY0kftV3/hqXCogvjuvc7I4bs/Pi6hXYS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY8CsQHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21E6C4CEE7;
	Wed, 23 Jul 2025 13:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753278454;
	bh=e4iFmU4V8FdSQBveMXcP7eTilC+19QO83wN4KtTy+Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eY8CsQHbcb2OswoT+ggFsv3c+SKfn4phee/f3jbk8YITne+7vWAvq+pKn+v41trYZ
	 U6D+J+cibmnR0ZmBIszGLK9iU0OpXJuqBvH4y9Q0VJPGoQpOIA1zKDYP6ekqBERbDs
	 QugPrw354rRa7o4rZZl7+YOJhT+wR0D2wY+tCaMLp17pDUPCumTsY7frUR4SUpOdAz
	 NhMOBTZBPhuPXa/zUdu33rGWB/BYMSw6VLUkTST4KNKSZlc6m0gZ0Uw+jkHkOCiP7g
	 QWHKnGcoWcxJf0LXcEpTS1HUvhCKP+60Sq3a93WUft148wYpbv3D1+0k5FGG+gd85N
	 v9kXkk5W1rxuA==
Date: Wed, 23 Jul 2025 08:47:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Yao Zi <ziyao@disroot.org>, Andy Shevchenko <andy@kernel.org>,
	Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Cameron <jic23@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-rockchip@lists.infradead.org,
	David Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: adc: rockchip-saradc: Allow use
 of a power-domain
Message-ID: <175327845184.2145175.4601554796265618767.robh@kernel.org>
References: <20250723085654.2273324-1-jonas@kwiboo.se>
 <20250723085654.2273324-4-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723085654.2273324-4-jonas@kwiboo.se>


On Wed, 23 Jul 2025 08:56:45 +0000, Jonas Karlman wrote:
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
> ---
> v2: Update commit message
> ---
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



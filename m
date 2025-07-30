Return-Path: <linux-iio+bounces-22157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10859B16805
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 23:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B7A584D51
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 21:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F401E22156F;
	Wed, 30 Jul 2025 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM3UVRTV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897123741;
	Wed, 30 Jul 2025 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753909607; cv=none; b=uWLjlpB5RRLWooy1n19tPyGeysmAQxG/NdpMCCFbDysxTofLgtIbZxtnZGsZICNJipCA9neqegrkPX+WBfuNsKbJufyoxWd+jeR9KdSAGQFVNX6DXv35dmQqYxY6au0NG3SwfBTxcCLz0VqzkUUE2VcQji/RSCrrMBauwuRHtJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753909607; c=relaxed/simple;
	bh=N8B1RIJJdOCe90tQ0MOkEOONFi2Yq4hxMgW4vhvJIRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUiJQrLJ0IO0BCOPnCFlQQLoixm8c9DXkgh48XmkvVoL4boqBi+aGcJRWMGFuWRNRjKuSzyoGBvYpbQSecFYX+FDYqG7YNl7wTK3CwiXcZ5WlL2c5yW4O6eJRz6a6Q+olsRjLAQAa24b5iTxCPKtub1EkTqP+pOpcownXV47jgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM3UVRTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569CBC4CEE3;
	Wed, 30 Jul 2025 21:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753909607;
	bh=N8B1RIJJdOCe90tQ0MOkEOONFi2Yq4hxMgW4vhvJIRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oM3UVRTVyAxlqlkuLsaj/5u1e6PYinue3MIj17nFnoNYOXvvjIExMcId2U1X0LLJS
	 /amv5DIoTGN4C7zEe0mNXXncqMV2rny8K2h3b3eQvHfIp0tR+/F7G12zRGf9Ik92m+
	 l5tULIEFk0sCvocb3ImwS8LpKMJk1yfgzWLUtQy6UtuDPjeaESEwDADhleucfwH68x
	 IFWVp9mHfVRsgdQggNELWr6+2g2jreNi6pscPqBRpzfkIYuMV1k7dkPHDWh3r6tHd/
	 9897nxiANwJRgusTPQzRJZ6qPf32VZavVzZw/15/1sgbDso2Yeyn8yV+2fkWSQ8+Pv
	 Lc1lxPHSsguAg==
Date: Wed, 30 Jul 2025 16:06:46 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Ramona Nechita <ramona.nechita@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: iio: adc: Add IIO backend support
Message-ID: <175390960612.1745058.7399492503627683202.robh@kernel.org>
References: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
 <20250728134340.3644-4-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728134340.3644-4-Ioana.Risteiu@analog.com>


On Mon, 28 Jul 2025 16:43:35 +0300, Ioana Risteiu wrote:
> Add the generic io-backends property to the AD7779 binding to enable
> support for the IIO backend framework.
> 
> Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7779.yaml          | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



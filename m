Return-Path: <linux-iio+bounces-22156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E57E0B16800
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 23:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687CA1AA3CC5
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 21:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DBD22156F;
	Wed, 30 Jul 2025 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4om4x4o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9131023741;
	Wed, 30 Jul 2025 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753909569; cv=none; b=kkLxaCYmby1NGoqiDDe+LqOPlKoUvvUhIWK+luzSxJfljARTHGOjSM48/ia6sE1wVWhNiHD36tzec7Anm3eLFU5OOCg8QQohy2SLC9FNtNiPySdM9POF1hvBxpsXADqWZv2AW5Lvf4MhkzAACDvCiTzYvryKC3hFxsBQ/04cqvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753909569; c=relaxed/simple;
	bh=J/fViz4fQP+GBGjN0uvbi/XyNfQXS+vOpDnB9uFDGoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idIY0s505m6GKE+zDTwHOooBtMjwvZG+s+59CIv1G5R68eNdiobf+Otgj4zBk5NRVBEKV4/hKUzrNoi4gbDQWRnmydGhbcD4JXHn/FG+rNvMTE+U0VFZ7hXr1gXcaYHkMvPgRaDnKper1d2glEeokmJPGx4jLOFo/8eitlH4yZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4om4x4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE37DC4CEE3;
	Wed, 30 Jul 2025 21:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753909569;
	bh=J/fViz4fQP+GBGjN0uvbi/XyNfQXS+vOpDnB9uFDGoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4om4x4o6/U/y4vv+dXyMPxWsnpoAQ3oVh3+hEowmTBlSZDR8GCGQVy67gIhecmK1
	 AVjt1+ZtKHJAr66y31h17W2PKCB00ppz5YRqSm4Q2CUn3RsIUNfZt7dnSeXN0DO//D
	 i3XA0j1DYuQviqXDvh4i+kKvGzms2CL3Ua1In1sTbby/wyz/xIHAd1n9a2EoBQARxn
	 Ubzyf9MFTvabp/ZERKOSwt2Cta53CQfa62RXAKLkjyeGCsSg4s01qmsrFAfTkTbht7
	 KgZErFI5Z5j2C4SW05KjvKRhuflLgogBnDpan7WpKzt+IvOSXISCe1NIYUTOPdVsTz
	 zKXLk2FW9vkRQ==
Date: Wed, 30 Jul 2025 16:06:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Ramona Nechita <ramona.nechita@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindigs: iio: adc: Add ad777x axi variant
Message-ID: <175390956692.1744212.17205550995882250925.robh@kernel.org>
References: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
 <20250728134340.3644-2-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728134340.3644-2-Ioana.Risteiu@analog.com>


On Mon, 28 Jul 2025 16:43:33 +0300, Ioana Risteiu wrote:
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

Acked-by: Rob Herring (Arm) <robh@kernel.org>



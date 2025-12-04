Return-Path: <linux-iio+bounces-26773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A82FCA57C8
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 22:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A18F9317793F
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 21:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283ED305E0D;
	Thu,  4 Dec 2025 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATyEg2d8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5CB25A2A4;
	Thu,  4 Dec 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764883798; cv=none; b=EJOrpCVteHkcv8ACGntwSTSSaKnbKGYf8+ihHjef5FC533BsJxdb040WzZ4kpXHk/8qBd/NPdy6V+4SjSmHfIpFzsaEV6DG2ER87bpMLCmcNPk4ZZDVEBTwFHgxhllEgld3cfXf99D0HIWg9Jr21JxgSIoNn2UaXKkDyNU/kK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764883798; c=relaxed/simple;
	bh=oiJViTCo77ZZHo2/5WxwRWMF8RIt59uk5pImpw8ekt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjIskP5UG1wZfGjKmKItCa8aWFbpAklyrSsW00RBom50a2M/0TMHhH69cGPXQl3/iR/aHD0xqaH8b77gbBNLs5IWKA/eGzOQ5+0KW2rB8ukbGPLFyGmvhGpXrV8v3OdhOrcjCs0gFYQP2rTksBKaLlw1gcZvkMwFO4GwFew+g/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATyEg2d8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D6EC4CEFB;
	Thu,  4 Dec 2025 21:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764883798;
	bh=oiJViTCo77ZZHo2/5WxwRWMF8RIt59uk5pImpw8ekt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATyEg2d8Va1rLP+r3F4p5TZOaRT3CBIx73BFt3vvF7OGLUz2sQilebHUAZ9eipqjT
	 nenbhteox3/vKMxcam/Rq/rP/iqj8Cz2DjKlvrgGzMP7uCK0aLmnRDixXkGCPZgvip
	 QOGAIP2WjVqjPbU2ehUhwu4aMdUxY7uvfjg/RaGEUbT85+4AvCfpX8aomDp1CFfUGS
	 RB+19HvZioYLlVsAEIbYJkn4jlR2vfiV3KIIC1vVSv0pp6g98oMw3M3s2uoplnOU8A
	 KTZ0sdIxyeV/v3rvGh2LKmx+8hSClw9J3Gw6CTk6MvU2cdKbaAfmXZGCajHjZvOAKG
	 m7rsRsitkAMFg==
Date: Thu, 4 Dec 2025 15:29:34 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-spi@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 5/7] dt-bindings: iio: adc: adi,ad7380: add spi-lanes
 property
Message-ID: <176488377439.2197805.14152863143117815607.robh@kernel.org>
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-5-34e05791de83@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-spi-add-multi-bus-support-v3-5-34e05791de83@baylibre.com>


On Mon, 01 Dec 2025 20:20:43 -0600, David Lechner wrote:
> Add spi-lanes property to describe how many SDO lines are wired up on
> the ADC. These chips are simultaneous sampling ADCs and have one SDO
> line per channel, either 2 or 4 total depending on the part number.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> v3 changes:
> * Renamed "buses" to "lanes" to reflect devicetree property name change.
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



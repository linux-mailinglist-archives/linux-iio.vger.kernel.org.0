Return-Path: <linux-iio+bounces-9160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D720796CF5C
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 08:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFD51F22123
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 06:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC8C18BC2D;
	Thu,  5 Sep 2024 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBX2HOVI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E40E38B;
	Thu,  5 Sep 2024 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518126; cv=none; b=HQZYnsDh4+qntZEfjSyIFVG+IbnA6p+fcrXAUAZjM1IuwqaQYW1UR7AY47jJ1/PDpoNbORA5CqlLFPcEwEFpHFcNu3qgSa/a9klirL45gSJcLo3Ym86SccEjhL+Q+yEGOxJoKLMyL6FJdXQIMzuJWGDyeAtAXXYnthU1CKnBqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518126; c=relaxed/simple;
	bh=qz9hhEzi+LKyX6ILtUo6RYKTAdTrb4WxFnWnlXwkIwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh1t/Ed+6B6VXUx9OyzJUszYgkHGxTJ6mnfNAFd3wQWO6Y5O21X/aUCt1o+Ys8G+CUwn+FY+FYva3TbQusPNP5di1JXptcyGD7NdvaqS9SNoSrfbg2yXpbd/nQ5rB+slDORRVv+mMJzUGfDvTs0jnyaEfK38ZQ4xwGJtrwFWc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBX2HOVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17752C4CEC4;
	Thu,  5 Sep 2024 06:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725518125;
	bh=qz9hhEzi+LKyX6ILtUo6RYKTAdTrb4WxFnWnlXwkIwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tBX2HOVIi9IRWHUIbNzKW5MeghrvvAdRmpXaibPkpqRldAUOEephKkqiIb10CMuDU
	 kTN7kc9jaeHNquVussLIqbJWPD0c+IzoZ14au0YysXi8RY2Lr03zTX5Upz+WaQ++Zi
	 5Rm9ICT+rn+OacKPIdILUqEfHnAVrGyu/NQ+2SE0wqbYYkVsT37/BFJH+jzLXTJlTS
	 Ds/4rgqf7NTcjAMhMnOBe1Lv5PGuKfYRFcLHlVc171rUdLS5DryilSr7KVeakOvokM
	 rvQPNpN/EhuHRHQa6OAoisqZoKefhCAhC6NypvV9bk/colItT5Y8qfnUvzCrXx979t
	 5/iQ8WtN7SKdw==
Date: Thu, 5 Sep 2024 08:35:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>, 
	Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs
Message-ID: <v2p2zrxu2fnd3ok2hxduufiid6ho6jbhmxpppwqczo4676ojsp@gehjl7npdbpw>
References: <20240904-ad7625_r1-v4-0-78bc7dfb2b35@baylibre.com>
 <20240904-ad7625_r1-v4-1-78bc7dfb2b35@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904-ad7625_r1-v4-1-78bc7dfb2b35@baylibre.com>

On Wed, Sep 04, 2024 at 03:14:18PM -0400, Trevor Gamblin wrote:
> Add a binding specification for the Analog Devices Inc. AD7625,
> AD7626, AD7960, and AD7961 ADCs.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7625.yaml    | 176 +++++++++++++++++++++
>  MAINTAINERS                                        |   9 ++
>  2 files changed, 185 insertions(+)
>

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation: Please add
Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
or above your Signed-off-by tag. Tag is "received", when provided
in a message replied to you on the mailing list. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for tags received on the version
they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof



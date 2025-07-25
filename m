Return-Path: <linux-iio+bounces-22020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE9DB12733
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 01:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D977B4D9B
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 23:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427D4255F3C;
	Fri, 25 Jul 2025 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfNpZePx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD73143C69;
	Fri, 25 Jul 2025 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485333; cv=none; b=mnCWdpsyachKRWYIcjErANNHhWiDaFpoVsHWBtc0gPrYmT3ew0azTyznGqrSMmMr4s9j0Xf6Wnxi2TcaoFDX5fPdjnsrpzeN6pYrx8f0fjVa3qapu7lPNUpyd7F3krC3iAO9RQ8THhMGJDSK1p/zunyh9FF1QB7zWT+mOOZD/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485333; c=relaxed/simple;
	bh=hvysnKO9pk62IKH1vrOE7jWkruaWvZGK3SjRB3Cjdno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2x1jIGmAYsLPzgJD7EqEzqqhPr7djuT6sxYkgh4/Q7WSZCyLiu59r6Srf4/6I6XDOqx3+PChdAxydEbSUEMTCip+/1nRSO8PbBaS6I6Rc8ZTjYtDCRzqVktmzEyLTyaVBm3AO+whYHE5ZyuR3Ky7tjfLsJ6Z7el2gKHN9BEtyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfNpZePx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612B9C4CEE7;
	Fri, 25 Jul 2025 23:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485332;
	bh=hvysnKO9pk62IKH1vrOE7jWkruaWvZGK3SjRB3Cjdno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfNpZePxnd3pa2g1S5Gz0JGpU/ClFo5/Jt7w7fxfk23PQQY6NZUKiONCrMOiAj65h
	 B4R19nmEoz6+Cnm/nPZG8/EwEhdZdeC0Ogo9n7eA3KkKkmGqURGPNMgtrXCNcuC8vC
	 Bl8n2JwKcTtCLUYs0lVjv7LZKVn3W97gx7/XyKjOXTFnwg0lxswO3UmmE8KRol516S
	 kjn8Ho1cKrXIBpeiNW46ZBdxPt1NyirIhG3VmQoyLJ0kpIBKJqKxDA8bRQ4/v6cRK/
	 14Wosw/fWafAHvDy07O6Zzgcjl1Y4lfCrDvo3pFvKoSg7+CnT4DWuxhQY9SoJBK7UU
	 jHWxP9wKJ7Zpg==
Date: Fri, 25 Jul 2025 18:15:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dan Robertson <dan@dlrobertson.com>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Alexandru Lazar <alazar@startmail.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	linux-iio@vger.kernel.org,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	David Lechner <dlechner@baylibre.com>,
	Stefan Popa <stefan.popa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Gross <agross@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	David Heidelberg <david@ixit.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: iio: adc: samsung,exynos-adc: Use
 correct IRQ level in example
Message-ID: <175348533136.2012943.1681778116126548009.robh@kernel.org>
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
 <20250724111345.47889-7-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724111345.47889-7-krzysztof.kozlowski@linaro.org>


On Thu, 24 Jul 2025 13:13:48 +0200, Krzysztof Kozlowski wrote:
> The interrupt line to GIC is IRQ_TYPE_LEVEL_HIGH, so use that instead of
> "none".  Also replace the hard-coded GIC_SPI flag.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml    | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



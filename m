Return-Path: <linux-iio+bounces-22019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5A4B1272E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 01:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4451C2740F
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 23:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6E225DB1C;
	Fri, 25 Jul 2025 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxsLWjgG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091E25B31D;
	Fri, 25 Jul 2025 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485281; cv=none; b=CeaTR2Z73r4bQZ0uiX5uRUku9fr8H3Hsg81eMx1y7q7U5T3Rvr/W+UG0UDr4dYjOejWCDwhi5z+WZSpvKfhfA3QGPwGivCuP7hV4V+K8LDupyN8WasJ58ocYzW3syHOI1OCTYJDNa6hPUGhoNKyYaHVl0Mt77CSEX9vbiv3SaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485281; c=relaxed/simple;
	bh=NmAsnmCYqTaZnPZEOZ2cvwYlrb+q1nS2jdfYn0FBcZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdYsPbRZqKPmXCgkZzcheYytZcuU4Jo9R4d4G8ONghTuL1THuCXXnL2M96HZMLTC+Xra0SoDNKFygA41oVx/mYuRwYUmYUX7km0/KH9uzii88HBQ2C88kZvPS3mzfH6zLpKgdC00gSXXYs9II38b94Ufs/cmApIpl3Aw+ckH8vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxsLWjgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80847C4CEF4;
	Fri, 25 Jul 2025 23:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485280;
	bh=NmAsnmCYqTaZnPZEOZ2cvwYlrb+q1nS2jdfYn0FBcZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WxsLWjgGEQLyvqCxSJogxJyY4OuDHfQFYsV3vCthu3iHmxl+jx1+NtapM2OHKNcgz
	 6Wk+nzVGnRZXBZ2cIipgokG7EuSj9+Gh5ml2OMZtU+8w0h+05nbz4+j+XCCogQmpe1
	 GUtOUQzN3185vOKaqk0cwP84MpGpsyXga8cXF0GO+B58fp4TE5A7HejDc/eBpu9kqe
	 6SjzAqM2oFzge2SCcM+J33Jzx8mGL7CCglG1fDuJbAGnnZsBSaaWSdwJG/c4hsdPyM
	 Ib/eeh4wpB2dj8lWlsvQMJcUaPyWb5etNPwSgNqC9Vv6fRi1a45FkSul51yvD+YmbD
	 tMpL63GBPGFwQ==
Date: Fri, 25 Jul 2025 18:14:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Dan Robertson <dan@dlrobertson.com>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Alexandru Lazar <alazar@startmail.com>,
	linux-samsung-soc@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	David Heidelberg <david@ixit.cz>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Popa <stefan.popa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: Replace hard-coded GPIO/IRQ
 flag with a define
Message-ID: <175348527925.2011912.6805260803610107718.robh@kernel.org>
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
 <20250724111345.47889-6-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724111345.47889-6-krzysztof.kozlowski@linaro.org>


On Thu, 24 Jul 2025 13:13:47 +0200, Krzysztof Kozlowski wrote:
> For readability use known defines instead of hard-coding GPIO or
> interrupt flag.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml | 2 +-
>  Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



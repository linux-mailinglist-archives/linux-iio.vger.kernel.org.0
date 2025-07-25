Return-Path: <linux-iio+bounces-22021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2995B12736
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 01:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6132AAA517B
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 23:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5852025B66A;
	Fri, 25 Jul 2025 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5YmkPyu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A91223D2B6;
	Fri, 25 Jul 2025 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485363; cv=none; b=ayDICnmnX1wS4MOyqGEHskTgZSFt8o51zxpsvgSYOBkNNP+iEtRBllxfd5lRrjgBRdcTmF/Y5VaD5Ws1F6aKYp2mXB+XSzQMUZ2nteINZ4yR4DaRpRJW6BSctFJCTrBQw6jvp/nh/svOq2xP2MaHJy6OJJoutt74/ND8S/cOqFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485363; c=relaxed/simple;
	bh=0CgTyp/AOIFev+w3bqrF7PtG85NisSLbf2l1wMOcr1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPyuaJlOK14KQwn96P1vjbTVEoMSKqomWg7RIeeKCPJCLt0V7NPy942N/ZR5+mAynJZZPSHOwcLClZ/bIfdyUP9VMnaWjnMr2DtHRIOFqAkLHDHjTXNPyG1yMgUKUhn0ycbDj4Idkcgd5wxi5fC4G28SBJAnx3uNR5AYKH3VxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5YmkPyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70538C4CEE7;
	Fri, 25 Jul 2025 23:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485362;
	bh=0CgTyp/AOIFev+w3bqrF7PtG85NisSLbf2l1wMOcr1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5YmkPyut2WrcsL/+oo8Mpvw/Ah61bKneGhSEJNDvzrY2/JFfARSxZ2N/WbB1ZzF1
	 Njq6sIcy8S4f+53f/Mj6DS/RGxGeRMcZNAOAtcQiZWnq4tO4g9c2sfeQRlKmkUsuvv
	 gT1Mju8mPMByQB2ezM1wxh36fMOuaroJE5EVs12a69XqUQ7mpujH5BfjV4vD2yYfU2
	 iJMcfF90eUh3C1SRYPb5Z8jQOcC10JyvbZPw/vmHFHEbHGeohwUNADDao4JcVV3eO8
	 azuJ2iaGucU6UV0GTJO2A1eIbk+5mslql+83MMxXaMRlnL/XVnO9bwlA6lExajByqo
	 4MDhEYE4cpQEA==
Date: Fri, 25 Jul 2025 18:16:01 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	devicetree@vger.kernel.org,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Andreas Klinger <ak@it-klinger.de>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandru Lazar <alazar@startmail.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	linux-iio@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Dan Robertson <dan@dlrobertson.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/4] dt-bindings: iio: light: Simplify interrupts
 property in the example
Message-ID: <175348536123.2013554.16603823674806564381.robh@kernel.org>
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
 <20250724111345.47889-8-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724111345.47889-8-krzysztof.kozlowski@linaro.org>


On Thu, 24 Jul 2025 13:13:49 +0200, Krzysztof Kozlowski wrote:
> dynaimage,al3010 and dynaimage,al3320a are I2C devices, so their
> interrupts are not routed to GIC and rarely first interrupt cell is <0>.
> This looks like copy-paste from some SoC block, so drop it and also for
> readability use known defines instead of hard-coding interrupt flag.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/iio/light/dynaimage,al3010.yaml         | 2 +-
>  .../devicetree/bindings/iio/light/dynaimage,al3320a.yaml        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



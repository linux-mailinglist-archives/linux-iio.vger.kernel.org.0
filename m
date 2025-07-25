Return-Path: <linux-iio+bounces-22018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D087B1272A
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 01:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8751C272BC
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 23:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B425DAFC;
	Fri, 25 Jul 2025 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEueuhL6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB40190472;
	Fri, 25 Jul 2025 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485266; cv=none; b=nAltno6qTW7CoXOitBQf2C9pl7VIWjXqedOAf8I445K+6AoZdr9966GorltkHO6VJUgcoNka7gdCVdWiBVahscly0zu/BAXE2XMagBcN1kIPzbR22uSMHgkJDRpNiKWLFsfDQBF2aHBwEeHCb9RX5tkUZIuDMni6Mf7ixoeMQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485266; c=relaxed/simple;
	bh=roilVrcSzwsI01XzOOpsXim3Xv2gE6Ixo5ZnYOtnZz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0ra0FlZ593/x5hZlAor5qMxUN+yi0rRFEWgDZkYWb8peoBSS19cvRMFhiEmyxiaMpgUveuM/QV58zaKV24nyRp+GIy9jS32jAWrxwHsumrbniLz+6+SbfTGw9ALSVmtlqS3GVQoAzOf1URUOGp7e09P2bvtkKB1KCfT8ByNFpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEueuhL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3EDC4CEE7;
	Fri, 25 Jul 2025 23:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485265;
	bh=roilVrcSzwsI01XzOOpsXim3Xv2gE6Ixo5ZnYOtnZz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEueuhL6kYCL3Yz1JjWLfYuYvoNzMmNVJt/7eJV6SPfst67Ma33jlz8+HCoii/5KB
	 iN2w4179PaGb4JtqRVyI+2DBaebIO9YetDoMn7rO0dkOPFrzgfbplCB7NumBk76Y3j
	 EAeKUnD3GIYxANgbp4Xve3NQmDBhqIXZzkYTf0/69Eq+SUlxdktkX94nsMiJPn8Ijz
	 ux51iwGDUXjKy7/vYi4QatVzfH6DhR4X0v+IUoLXWzn+jwem1uKvT20sYNHD1BsmFD
	 hY6W7Gm2QdL10qPWF3ig+piHTBAcOxT+uyoS5UEPZ1LuM3XoKjM+9By2PC8jjqWCnt
	 2g8Es33H/D7NQ==
Date: Fri, 25 Jul 2025 18:14:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Heidelberg <david@ixit.cz>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andreas Klinger <ak@it-klinger.de>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <andersson@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Alexandru Lazar <alazar@startmail.com>,
	Puranjay Mohan <puranjay@kernel.org>, devicetree@vger.kernel.org,
	Stephan Gerhold <stephan@gerhold.net>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-samsung-soc@vger.kernel.org,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	linux-kernel@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Dan Robertson <dan@dlrobertson.com>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: iio: Drop unused header includes in
 examples
Message-ID: <175348526415.2011522.8662273220330760197.robh@kernel.org>
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>


On Thu, 24 Jul 2025 13:13:46 +0200, Krzysztof Kozlowski wrote:
> Drop includes of headers which example code does not use.  No functional
> impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml  | 1 -
>  Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml    | 2 --
>  Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml    | 2 --
>  Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml    | 2 --
>  Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml    | 2 --
>  Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml   | 1 -
>  Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml   | 1 -
>  Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml   | 1 -
>  Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml     | 1 -
>  Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml       | 1 -
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml   | 1 -
>  Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml     | 1 -
>  Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml    | 1 -
>  Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml       | 1 -
>  Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml    | 1 -
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 --
>  Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml     | 2 --
>  Documentation/devicetree/bindings/iio/light/st,vl6180.yaml      | 1 -
>  .../bindings/iio/magnetometer/voltafield,af8133j.yaml           | 1 -
>  Documentation/devicetree/bindings/iio/pressure/bmp085.yaml      | 1 -
>  20 files changed, 26 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



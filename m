Return-Path: <linux-iio+bounces-10319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A0F99418B
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 10:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3311B26525
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 08:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B2D1E25FB;
	Tue,  8 Oct 2024 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM0rVwn3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4EC1E1A09;
	Tue,  8 Oct 2024 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373911; cv=none; b=LA5ABgCzBbvM29bztWrb9OnAovS0xZD9CNi7ValHfuVA3QmWmVdfLBfaWvvu5ULH6C84HjOGg0v3WNOQHlixr5WTiPaEu/+DZpPeGVeJIWDgpFO6QKBQsDL4LhP3Z10f7W3O98SRRKvAcXbjG3Q8mi2Kydo43urGfOuX7HwaSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373911; c=relaxed/simple;
	bh=uEXaQKrRikUA6bCkNomJAeg5V99x0e8HgUGv90BG0PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dotxuGOK+IEFZAEFtYfmafhGWObjV15GCnyiEI5ZXu2T33KM8hj5MMDFvTDKu0bmhldAa3i2o5je2Fcbitr5Roo/KSLmb/G/XU//zMKildy3unCCL9MGKkuUWqdHJnacWy1+OT6iDSTTXP4QoX5i/4KkB/daZLlXsYNHNk2prLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MM0rVwn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BC3C4CEC7;
	Tue,  8 Oct 2024 07:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728373911;
	bh=uEXaQKrRikUA6bCkNomJAeg5V99x0e8HgUGv90BG0PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MM0rVwn3r4/3A2eGN9DSGcI1XKhwb/6SkgaNDatEQyGOdFg2+BUIJ3tXMWmkjm+RD
	 6WSNd1kgfy2bI3WUQ9R5H/z/1MQoUTe6NiT2eq2BSSK6kszLOEbJb3oxI4pUSCL/RD
	 ooDKzml5P+yIf2X2pR2wzjrCA8yAUubLQbQ9IBbLdvj316zGstf2lRhuBuRUNEILHo
	 5KQY5zGr9k7TVliVArMbm4voBHzM4yQFlB/TAOEEstzr2bJaJEr8TRb5OkG/5lA4Q/
	 5kci8l9V+R/2/kswimHNXHGHiJrKyxnC+FiF4B3JRq3B+VpCEm9cbGbumnrKiWDmcq
	 VdpVZJdcEofPg==
Date: Tue, 8 Oct 2024 09:51:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: ad7380: remove voltage
 reference for supplies
Message-ID: <yjfkbmcwu5rtpvzynvcki7slmrr6ia6ng6zuxdti6nzpljvudy@klfcpocgww3k>
References: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
 <20241007-ad7380-fix-supplies-v1-1-badcf813c9b9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007-ad7380-fix-supplies-v1-1-badcf813c9b9@baylibre.com>

On Mon, Oct 07, 2024 at 05:45:44PM +0200, Julien Stephan wrote:
> Voltages may not bo valid for future compatible parts, so remove them and
> remove useless description
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> index bd19abb867d9..72c51b3de97b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> @@ -55,17 +55,9 @@ properties:
>    spi-cpol: true
>    spi-cpha: true
>  
> -  vcc-supply:
> -    description: A 3V to 3.6V supply that powers the chip.
> -
> -  vlogic-supply:
> -    description:
> -      A 1.65V to 3.6V supply for the logic pins.
> -
> -  refio-supply:
> -    description:
> -      A 2.5V to 3.3V supply for the external reference voltage. When omitted,
> -      the internal 2.5V reference is used.

This is valid description. I would say all of them are useful, not
useless.

Best regards,
Krzysztof



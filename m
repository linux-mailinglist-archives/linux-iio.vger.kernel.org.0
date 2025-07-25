Return-Path: <linux-iio+bounces-22022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AA9B12742
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 01:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE2147B713E
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 23:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1993225F976;
	Fri, 25 Jul 2025 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoeHct9o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583325A630;
	Fri, 25 Jul 2025 23:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485667; cv=none; b=FoJAZaYrbciCzL2Vd74oEY74dgPA1ieXGra6JutARv+U6oBVfIt9Bzjv4pN9/gJ0SkjsebO0V7nAbcjwKKYzu0GHkRss07QJA71fIkckU/0N0LSG+yUts9R0xevjrAXM6+XHvKOi63kfAZpYzzEPFMJY2yuofLLAsau/Rh3hoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485667; c=relaxed/simple;
	bh=BBbnP/4MNf1hkVbz0RltTl/5YUhhWEOI5p2ZZ36l+Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3XWeTjAYWMMZzzL+rSk13UMFpnrM25UtA4S0aYAweT+qELVD/cAIJHitQZl2t1evPd1iJosCCb5pmL984Is/81R61Gxunx3dwigZTtSTPlzcd7fDB26V/WIWfWaiJSeRum2osuYTjWD9+vc3sLBlclATR0xwHXPNHzqbtv8jLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoeHct9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5C2C4CEF4;
	Fri, 25 Jul 2025 23:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485667;
	bh=BBbnP/4MNf1hkVbz0RltTl/5YUhhWEOI5p2ZZ36l+Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MoeHct9owQ0TJYqxPbYILn2DIwz1UQ3WNTsQSvyveva+Ja7slR9M9uhszd1ZpvMNc
	 TbH/TeVGWI0GEPaQryDc+XXxQt+7an2B5Z1WfGxeIIauy0dlZ4WUE7EXHb1lEskUpV
	 p3xYT+k0jcGpoguLeWee47SgDgSDxBrDf7XbsTKE9D/QtfrktmtaWqiYvjb2Ec8422
	 Wbot2YsUvrMmzCz+suY00GWz/kwQaDd6LFh+w0qDhdc5VIVjCVKhHeHNn1h0B4Cxww
	 znk9I0vRM9f1FiW6R4HvSZhbVgOakf2QzEuIcFdzFyBHv7p0TqdpwiqjtbXW9YuLHB
	 zTD6ewCS/A5yw==
Date: Fri, 25 Jul 2025 18:21:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: Replace bouncing Analog emails
Message-ID: <175348566588.2019384.4908547984111781460.robh@kernel.org>
References: <20250724113826.61998-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724113826.61998-2-krzysztof.kozlowski@linaro.org>


On Thu, 24 Jul 2025 13:38:27 +0200, Krzysztof Kozlowski wrote:
> Emails to stefan.popa@analog.com and alexandru.tachici@analog.com bounce
> permanently:
> 
>   Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'
> 
> so replace them with Marcelo Schmitt from Analog where appropriate.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> I don't know who from Analog should maintain these devices, so I chosen
> author from Analog of one of last commits.
> 
> Marcelo Schmitt, could you confirm that you are okay (or not) with this?
> ---
>  Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml | 2 +-
>  Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml   | 2 +-
>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml      | 2 +-
>  Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml    | 1 -
>  Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml     | 2 +-
>  Documentation/devicetree/bindings/iio/frequency/adf4371.yaml   | 2 +-
>  Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml   | 2 +-
>  7 files changed, 6 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



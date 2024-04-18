Return-Path: <linux-iio+bounces-4332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3D98A9E20
	for <lists+linux-iio@lfdr.de>; Thu, 18 Apr 2024 17:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0FD283DCE
	for <lists+linux-iio@lfdr.de>; Thu, 18 Apr 2024 15:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD616C689;
	Thu, 18 Apr 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEm/EXAR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9D16C434;
	Thu, 18 Apr 2024 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453456; cv=none; b=lm81bw6xSLOWefbj85Ad1hTgp5NpOsTfADjocHHENY3glHmMIDwoXwcMohXzLsTvwz2DzMBI/xvCRm7PkVh+vYwEZA3G6TdoAvUHE/g5Gq5W5/WfyNqVplB6XMyq0NBu0xDYRYA93V5nUwwQALyjNjM0q5AKcGmo7ftNIrPpJGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453456; c=relaxed/simple;
	bh=OnXQoJaaZduna0crf6DqxpjnV/O7YuE/F/TYknTfy8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFjobw0j2K9dffscE8OZU1+7qjZ8Mu+2udnru8b5fY5XWv30K7ZP5RYf5nKBTvg79AWdK8BH4nLJFCGDJCpb0h7n1PTjDGkoIxaF77GxcTD4mm8+Rzxe4g/ukYi5C5lJFcMxt4D2u8jxyZ3xEQ99b9zsFRt5kyHzO1QxT+2UCAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEm/EXAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3D8C113CC;
	Thu, 18 Apr 2024 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713453455;
	bh=OnXQoJaaZduna0crf6DqxpjnV/O7YuE/F/TYknTfy8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEm/EXARLK6/EpIcNP+4gcbIy8H2+iSTvu6oSegH63E76SFWI3WnsuA4lDFX7fWEn
	 HEnAFFYh0gsaxYOMSthHJJ/pF8BZNcMvBuCr3NnZGst34DdEcDAN8QC+OsB1GDQEK3
	 Tr2drpWmpY8fPKEDMxSEGoAEqKbr+H8Hd9iXM2iQNU7TJ1emS8K9hz739i2zA26nbb
	 iiQYL37pJ9qjJhuYk/rT+NTqe+eHlR5oy4DVCjjWUwOTHUhu3uCLV6U+iEnYqG5TA8
	 lkTET7QVgPE9llosw3+Tlms9rCp87ehbYHdmchISL4OfTl7O0DdY6bi6+sWnryWD5h
	 xXo00dX0r2vPg==
Date: Thu, 18 Apr 2024 10:17:33 -0500
From: Rob Herring <robh@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: sboyd@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-iio@vger.kernel.org,
	Chris Morgan <macromorgan@hotmail.com>, wens@csie.org,
	mturquette@baylibre.com, samuel@sholland.org,
	linux-sunxi@lists.linux.dev, jernej.skrabec@gmail.com,
	krzk+dt@kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: Add GPADC for Allwinner H616
Message-ID: <171345342441.1843687.15293376169534019509.robh@kernel.org>
References: <20240417170423.20640-1-macroalpha82@gmail.com>
 <20240417170423.20640-3-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417170423.20640-3-macroalpha82@gmail.com>


On Wed, 17 Apr 2024 12:04:22 -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the GPADC for the Allwinner H616. It is identical to
> the existing ADC for the D1/T113s/R329/T507 SoCs.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml      | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



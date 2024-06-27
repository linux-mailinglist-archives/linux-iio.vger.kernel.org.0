Return-Path: <linux-iio+bounces-6993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE8791B05F
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 22:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0244EB220BD
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 20:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F57719DF8B;
	Thu, 27 Jun 2024 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW62N1IA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F419DF54;
	Thu, 27 Jun 2024 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520151; cv=none; b=isx+mzlkC9O+AoWZyIO6GXSoPbYftxIT/ILL3bkjyxyiT0mrYKPWMTK7rROYIEQvgmwaAIIfEzOW5L4x4269bE3Q3zZruAsCU4O4lXY5IdAeFzR2SyUDwgjnmp2H5avJQch39V/qsStUDGyLJdqPIkoWQIat6buTDyliy8nqSyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520151; c=relaxed/simple;
	bh=b/0aNRPKXl+pJqUGj/VmecpemqeGNH4lJFUTEQRPRiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1fvSRtUAc51Bk8oX59NjXsoZEAYW+vb1+1bb70500QWlH+No+XFj7p7JMAp78a5huuPU1iqJ66ndvcc+CV5lXTHYWXVgc8cCVHIbVlx27uGxZEMIH9RMFTz6RpLXy9Nc8yTAa0DTVAUuQn4W/HzR7iA3oqaoOCZv5z8hsdzTxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW62N1IA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D203C2BBFC;
	Thu, 27 Jun 2024 20:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719520149;
	bh=b/0aNRPKXl+pJqUGj/VmecpemqeGNH4lJFUTEQRPRiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HW62N1IA8g8PIp+7o+yoQhE0hOXTHkRgKocLCbgHI0RLPk+UFoPuCaGY2ZZGjri4b
	 fc8VwD+KoLHMAljmElaUY793rAo3nXm7W6885i4xvIIDYbgd//GXTGjZNGa5fzTDYY
	 bQHJuN2Rp390mMzefwCVUAmXZgYSzTee40UsNb9F0f4wtzm9WeMyST27nj+PUeoDbF
	 CZTc2whCBRq9aLn3irP6dW1/OZVjr+Lj5AOe/+T/dwWBsFNEHhUdSt+7ih4cgYmJn9
	 vmdxZ2n5L4WAwVCDrT0NIu/zae3YK+41Ft3dyPCAoUGxk7XbGtQYcbzx2drU9jRq5S
	 EZjuAOv1T8s1w==
Date: Thu, 27 Jun 2024 14:29:08 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] dt-bindings: iio: stm32: dfsdm: fix dtbs warnings on
 dfsdm audio port
Message-ID: <171952014620.474983.15354726969773132715.robh@kernel.org>
References: <20240618115912.706912-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618115912.706912-1-olivier.moysan@foss.st.com>


On Tue, 18 Jun 2024 13:59:12 +0200, Olivier Moysan wrote:
> Fix warnings on DFSDM dtbs check
> Unevaluated properties are not allowed ('dfsdm-dai' was unexpected)
> 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Fixes: 11183ac07a74 ("dt-bindings: stm32: convert dfsdm to json-schema")
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml       | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



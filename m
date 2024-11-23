Return-Path: <linux-iio+bounces-12560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874CD9D6A5A
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 17:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163EE16186C
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF5B12FF70;
	Sat, 23 Nov 2024 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmloS9vL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D485672;
	Sat, 23 Nov 2024 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732380705; cv=none; b=b1nye2wwNlIrOLxiSM2Y+EjZxiwQDTNb81oomutXgyX+/ukhyf+k8q4RhZWY+5B6SoqvtM+wZbpRy9DhxAxdVyRRVWgL94T2qKwm/PdGoZOi2D2HoVr1OmIpKmn5smgWvj2B1VszFBcbW8K6QimvlR9wZ93tNr0sklhViC2/W0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732380705; c=relaxed/simple;
	bh=49bxM1M0YNTedM1bfDSypl9sDtlO8xeu9g6EsaDITm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4nhK9Ly9rc5QRUs6kinInpDy6+uXEcvwyIdgovMvtF9oQhHnCs5giYlqq3klLLe9XwsaZfLSjfht9DFS2xpRJUtrzefc+k6h2PXiJhXRhkY5S46mo+76I1c8qLNzM5qWO6aPGxdj0aHVEAPsd2dhLrg8DBkdeoD+v/IvW9F0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmloS9vL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DCDC4CECD;
	Sat, 23 Nov 2024 16:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732380704;
	bh=49bxM1M0YNTedM1bfDSypl9sDtlO8xeu9g6EsaDITm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmloS9vLgTFdZyybaTDudIxxTZwf9JWrGpx7TWx3VQxiwSbjQpI+hDC1FcAm34HU6
	 tMT+MFyCSVP9mmGW+801aGlPHSfIrsg29qQWSH0mrtZdNMAxTpL7f3JSIjAii+5zWf
	 K4QOoyJE1kXz4VzOvioNMG3fzXlrwL+typTzqAa/4Mkl2Osm+sRe2BhIHCQtRWh7IR
	 Wr5D9ODOzaeZ8eyWK1EHRzxHkfDrNpcdMJnBYeubstxCZZkPyVgwRkZWgHEDvXiB5S
	 gpGGaaigfLkcI2wqSForZXJpzFo7T6Qki8yMfQ24ww1Qw0hmBsVpM7FZHcjZoWh7qy
	 6l4wdvKMfFiUg==
Date: Sat, 23 Nov 2024 17:51:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tobias Sperling <tobias.sperling@softing.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Support for TI ADS7128 and ADS7138 ADCs
Message-ID: <lk2ewurvwav4e7ydblnuhojle7oke62442r6zzny2tyc3fofho@kujlkfywbrdu>
References: <20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com>

On Fri, Nov 22, 2024 at 04:15:35PM +0100, Tobias Sperling wrote:
> This patch series adds support for Texas Instruments ADS7128 and
> ADS7138, which are 12-bit, 8 channel analog-to-digital converters (ADCs)
> with build-in digital window comparator (DWC), using the I2C interface.
> 
> The driver exposes the interfaces to read the raw values, as well as the
> minimum and maximum value for each channel. In addition several settings
> can be configured, like the DWC, sampling frequency or an averaging
> filter/oversampling. Interrupts triggered by the DWC, if configured, are
> then exposed as IIO events.
> 
> ADS7128 differs in the addition of further hardware features, like a
> root-mean-square (RMS) and a zero-crossing-detect (ZCD) module, which
> are not yet supported by the driver.
> 
> Regarding the I2C interface the chips using opcodes to define the way
> how the registeres are accessed, like single or multiple register(s)
> read/write or setting/clearing only bits. 
> 
> Changes in v1:
> - dt-bindings: Extended description

Hm? Everything starts from v1.

Try - run:
b4 diff 20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com

Best regards,
Krzysztof



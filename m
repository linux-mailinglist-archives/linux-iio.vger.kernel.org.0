Return-Path: <linux-iio+bounces-15575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B5BA37541
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DD03AE6DB
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 15:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BE71922E1;
	Sun, 16 Feb 2025 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtnGPs2x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E4DC8E0;
	Sun, 16 Feb 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739721287; cv=none; b=ZoCG+ykq6dGFfU3OQgqXF2u3d7x3Ji62ohyEHoLy/y2A9qAyjry4UJb6rbiMvw45phnJvZztcwVwAA2uwXnqMJJw/KILVIw/x/1uxtTIFaqkE9Jv5y/L2WivtLoT+KZvMw6YC5EL8KhmYbBZuzwKbz+3O/wDcjGDPu9guxQRdoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739721287; c=relaxed/simple;
	bh=YI4M66rMnlM4jffL09OWWos9o9IdSGPmEKyE2XKLKsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WM/U7He6BrloEMakmkdcXyc03spGMFO/yAvFHHDyPx5ULnOHyUlvGUY1XEOGf9i62j/S8N/gggssW2diH8MZS22cHuzhH+tKa86/t5ie+2m3kF1X4MwHQlhHWkhRWzGugRRrugvCT5PRWlow3ehNb6XprejnpnVguRxoHkUFK/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtnGPs2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECE8C4CEDD;
	Sun, 16 Feb 2025 15:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739721286;
	bh=YI4M66rMnlM4jffL09OWWos9o9IdSGPmEKyE2XKLKsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MtnGPs2xt1uIXwO2ZPAKiZB2/p//rlS5qM8wtOEE9fstN9muWiJTXYPT8wr82uQbx
	 TL75TSbl9Ua7GxV1FJErdVPksDvOsXq+Lb0TvbNM8C+L0mPtI5m1PlKsSVK06Ip6X6
	 vZ9yYRcpLID0jvp2E4QZJzqMPCOMs7e4lo8X63pfjUW1r2oevwJTNi0fg7Gj+AiV26
	 9CAMjzeYrjfMeF7+JN05IcT7QfB3f8g2wH5cb09foAdWknnE0AvtC5Lz/pK3oiDVC/
	 /XSty42uT44xjwa9Qls3wYwhaz2Ar2d+ysbcH7kQOcuyy85r3O78TPh1Cz4WN5MlPe
	 vtYs/SFAqBANg==
Date: Sun, 16 Feb 2025 15:54:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tobias Sperling via B4 Relay
 <devnull+tobias.sperling.softing.com@kernel.org>
Cc: tobias.sperling@softing.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/2] Support for TI ADS7128 and ADS7138 ADCs
Message-ID: <20250216155436.239a4b35@jic23-huawei>
In-Reply-To: <20250213-adc_ml-v4-0-66b68f8fdb8c@softing.com>
References: <20250213-adc_ml-v4-0-66b68f8fdb8c@softing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 16:58:56 +0100
Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org> wrote:

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
LGTM. Applied to the togreg branch of iio.git and pushed out initially
as testing for 0-day to take a look at it.

I did notice whilst applying that the Kconfig ordering for these TI parts
has gotten scrambled. So at some point we should clean that up and
bring them back into alphanumeric order!

Jonathan


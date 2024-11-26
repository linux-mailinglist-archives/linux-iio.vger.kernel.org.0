Return-Path: <linux-iio+bounces-12670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2A59D926D
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 08:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35572837A9
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 07:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550B9192B96;
	Tue, 26 Nov 2024 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ge8MXz1b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0964E187FE0;
	Tue, 26 Nov 2024 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606039; cv=none; b=J5cf78lFQjti35Qm7Wt/zKmOpT+5BLhCBySxiGnXDQfGz1uY2/FjUulvkCWgb59d3mmp7EU6ayLSDTHLkJF2jLXbEGIhMm1YVEsJmPQaqVBTzTxcA0UkV0apFsBc6kLSEMhUySQ867BJZAQhn6qR50zG+ZCi3cjiT/EjXt0fHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606039; c=relaxed/simple;
	bh=QNmXRH6+/lQlC0NI0i2Ghsp+4+OK+Z276BhLzqpOViY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCf/V2jxwEyVdEJEhlNbm9/oJVKbQlgtDxpdxFAv4+NOppwTH2il/NiNalZXKGofd/KwO5Qf3PZbnoyRoM0JA7vNuHMcrHuqaIQ03ZvkxG0WlBgvm+kW53cMv+gq0XrffHNukAhrPs1YEvH8U5UG6VE2vD4ScxoBnJuSKtGpY8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ge8MXz1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC28C4CECF;
	Tue, 26 Nov 2024 07:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732606038;
	bh=QNmXRH6+/lQlC0NI0i2Ghsp+4+OK+Z276BhLzqpOViY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ge8MXz1bQMwwxgouGxmFm6I9hG2wMDiFQ5WvBKunH76I4sZfo/ZbnCNsm+xnvDmUf
	 L1mMW4r0dfKWGNY096+LVYr7qxWLaAfY9Y14kNhM9Cb5c8h7FPFF+35XB2puUOes0/
	 14IbvacloF7s02mg3zSWPxDlpC9o2wodKnq2e00O6laDGJd4A9Ix6UpO+HTN6J2dtd
	 Llxtt6DDgx9QYxYpZrqmotin+Gw4uxbqAG8SuoGMGEyKWGu9FypBEqrXKmsdMjuwz7
	 IYWK2H00ktYTrGBbnjmJEJ+UCMGToJRZ35P7BeGgV9+2ICZ2R39W9gKU00pK/6IjOA
	 sI8LKSh6O8IAg==
Date: Tue, 26 Nov 2024 08:27:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tobias Sperling <tobias.sperling@softing.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Introduce ADS7138
Message-ID: <eudovs2ahymft4esojrxvj4dtsbfvwks4huq3sz6rc4tzjmeii@jdlyq4vxzywj>
References: <20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com>
 <20241122-adc_ml-v1-1-0769f2e1bbc1@softing.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122-adc_ml-v1-1-0769f2e1bbc1@softing.com>

On Fri, Nov 22, 2024 at 04:15:36PM +0100, Tobias Sperling wrote:
> +description: |
> +  The ADS7128 and ADS7138 chips are 12-bit, 8 channel analog-to-digital
> +  converters (ADC) with build-in digital window comparator (DWC), using the
> +  I2C interface.
> +  ADS7128 differs in the addition of further hardware features, like a
> +  root-mean-square (RMS) and a zero-crossing-detect (ZCD) module, which are
> +  not yet supported by the driver.

driver in which operating system? If FreeBSD supports them, but Linux
not, are you going to udpate this text?

Please drop all references to operating system and describe the
hardware.

With fixed description:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



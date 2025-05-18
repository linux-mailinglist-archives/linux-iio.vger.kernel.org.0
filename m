Return-Path: <linux-iio+bounces-19638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C65ABB114
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 19:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A053A8F83
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 17:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E11221D3E2;
	Sun, 18 May 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBJjCu99"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16658A55;
	Sun, 18 May 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747588993; cv=none; b=ckBlVy2jl4DfYzgKMXGCwwYCopjX99oQXWTT9Uw5vuLDSo0cuhPURFi4a0w0dxvqUMv2ZCZqwwf4gH50f3xddCVWGYLwhsKIlFa88DPdQp5zMba8WiMmq6xqp3CeshL8nh5rtOBBENCpONenaIepgZ9v8gM+P18lCHbZojUSQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747588993; c=relaxed/simple;
	bh=utxlMrZ388Hh6aAVNrm1IDRrQ3GNBlG+3AibsdEiNHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rD1fFpDdmUahF+l+kMwxwOdryDmcNpbOBH/t8h6vOMCFATVuKj2oeXbHyBM+Bty3V4FhRXjG2ZOGljvAQ+2XOzm3euYaMKon19kUcPbdjrx0CmnaqazRVBsqEJbCIIUSx4jDnp0V+tGScRUr1j6C+DH67M1xYC89Le4DsJ4I5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBJjCu99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2240C4CEE7;
	Sun, 18 May 2025 17:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747588992;
	bh=utxlMrZ388Hh6aAVNrm1IDRrQ3GNBlG+3AibsdEiNHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sBJjCu99wCYxVqFPU7Pg89QlzvRZk8LPDHnGaDCoOYXlXCxYpS1c+Og67L3CytFXO
	 h/MpI7ehKbxeevt5PaO4ycDKEkT804UWHTPjOup/7lq/ACb+UW1kjNWJyPtxlItSel
	 JsHuoGAwawVNO5P9Rm/x/tXdUuC1aawqQ6GOwhnIhv1iOgUpv9wlmSRelCyV4B4GL9
	 G2CZsj4d+3Xe2fbzulaq8cYvnw6l9IyeVkGPQPpP8ja+lQzIVxOvwuoS4muHhTR/jv
	 AMVRWJXHvTx7uiZv74L4Dv0OHR2td4YbhQNCirpjcQPTfBy79tf1AoMOHj9E7oPfDl
	 DIhOY/I4Ze4Ew==
Date: Sun, 18 May 2025 18:23:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/10] Add support for AD4080 ADC
Message-ID: <20250518182305.24cb8bb5@jic23-huawei>
In-Reply-To: <20250516082630.8236-1-antoniu.miclaus@analog.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 11:26:20 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The AD4080 is a high-speed, low noise, low distortion, 20-bit, Easy
> Drive, successive approximation register (SAR) analog-to-digital
> converter (ADC). Maintaining high performance (signal-to-noise and
> distortion (SINAD) ratio > 90 dBFS) at signal frequencies in excess
> of 1 MHz enables the AD4080 to service a wide variety of precision,
> wide bandwidth data acquisition applications.
> 
> This driver aims to be extended in the future to support multiple parts that are
> not released yet:
>     AD4081
>     AD4082
>     AD4083
>     AD4084
>     AD4085
>     AD4086
>     AD4087
>     AD4088
> 
Applied with various tweaks as called out in the individual patch reviews

Note that this is queued up for 6.17 now as we are almost certainly too
close to the merge window (and hence not enough time in linux-next).

If the 6.15 release is delayed I might do another pull request.  If not
this will be on the togreg branch after I rebase on rc1. Until then pushed
out only as testing.

Thanks,

Jonathan

> Antoniu Miclaus (10):
>   iio: backend: add support for filter config
>   iio: backend: add support for data alignment
>   iio: backend: add support for number of lanes
>   dt-bindings: iio: adc: add ad408x axi variant
>   iio: adc: adi-axi-adc: add filter type config
>   iio: adc: adi-axi-adc: add data align process
>   iio: adc: adi-axi-adc: add num lanes support
>   dt-bindings: iio: adc: add ad4080
>   iio: adc: ad4080: add driver support
>   Documetation: ABI: add sinc1 and sinc5+pf1 filter
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |   4 +
>  .../bindings/iio/adc/adi,ad4080.yaml          |  96 +++
>  .../bindings/iio/adc/adi,axi-adc.yaml         |   2 +
>  MAINTAINERS                                   |   8 +
>  drivers/iio/adc/Kconfig                       |  14 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/ad4080.c                      | 620 ++++++++++++++++++
>  drivers/iio/adc/adi-axi-adc.c                 |  77 +++
>  drivers/iio/industrialio-backend.c            |  58 ++
>  include/linux/iio/backend.h                   |  19 +
>  10 files changed, 899 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
>  create mode 100644 drivers/iio/adc/ad4080.c
> 



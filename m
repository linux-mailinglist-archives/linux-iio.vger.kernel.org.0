Return-Path: <linux-iio+bounces-19432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A75AB292D
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 16:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7563B8FBF
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 14:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909BF25A658;
	Sun, 11 May 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/KU7lhp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF32BCF5;
	Sun, 11 May 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746974449; cv=none; b=G74iM8VyTA1rw/pBa8K+ukay8laOkhdoc073Y8d7f5xbKN2sWPkX4XfXQkMSowiMVaefzsIVloWTNm38jVGtgRZs5vBF22aSbrQoyu2+r8uJL4HYgSEQB8GXfNrVh10MI/QJISZRoUBO6tYDa1j0Um3y7wFs/2tpI9zFgkjPZwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746974449; c=relaxed/simple;
	bh=aHn2shim4HRKYpeiFSsXRPiN3gBe4/czch380lKfRwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTv6M/N2lFI2qNDyA7RqRxPUIKFPGCEkElRnymBERv+vD1E6OonWeoP/Fdf88GjYBT4FPfm3zjcAjIFhGE3T50wfVfEXm6et0zMWwQ94WmhqROEShSnkdcEleLvnzHgXUK80uL+fIz5kcWaAqXyxK6weqcdXmcf8PK3z52Vh1fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/KU7lhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4906C4CEE4;
	Sun, 11 May 2025 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746974448;
	bh=aHn2shim4HRKYpeiFSsXRPiN3gBe4/czch380lKfRwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A/KU7lhpjRKZ3jj/jjY8nN7xamKYWDj1CZVGjWo9TGalrF8GQuF+3pjSu4/5hnOer
	 6ToTXUSTfelNO5cuXqMGCr2e3jqI1/8lgv6rcPD7M5bx7n9HEMspVGzrqpzv2srBaB
	 0AkJf4hArsjM8EwkPnEGTq4EPtZnfUBT28eXcS9tfyXvK1fSq2lScFg4fDCKuG5D+u
	 4VkYX+OxMNeV9zr17zBKxvZdGbKswCm2V7IPnKVpoz6UXdckl4lMalXKZu5FOtqSPi
	 bo3Wa2uwryJy7srzxp+AtdCW9SwrIJUBQeLDnmk9DJGlf+iyMJPr4APb170WNDP2BF
	 yhLJeDRrBffcQ==
Date: Sun, 11 May 2025 15:40:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/10] Add support for AD4080 ADC
Message-ID: <20250511154041.3635c7b4@jic23-huawei>
In-Reply-To: <20250509105019.8887-1-antoniu.miclaus@analog.com>
References: <20250509105019.8887-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 May 2025 13:50:09 +0300
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

Hi. 

I took another look through and think this is now ready to apply.
However it came in on a Friday and Nuno has not yet had time to review
so I'll leave it a few days before applying if no other comments come up.

Thanks,

Jonathan

> 
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
>  Documentation/ABI/testing/sysfs-bus-iio       |   3 +
>  .../bindings/iio/adc/adi,ad4080.yaml          |  96 +++
>  .../bindings/iio/adc/adi,axi-adc.yaml         |   2 +
>  MAINTAINERS                                   |   8 +
>  drivers/iio/adc/Kconfig                       |  14 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/ad4080.c                      | 575 ++++++++++++++++++
>  drivers/iio/adc/adi-axi-adc.c                 |  77 +++
>  drivers/iio/industrialio-backend.c            |  58 ++
>  include/linux/iio/backend.h                   |  19 +
>  10 files changed, 853 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
>  create mode 100644 drivers/iio/adc/ad4080.c
> 



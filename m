Return-Path: <linux-iio+bounces-18010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C44A86D23
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 15:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772B61B669D1
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 13:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882E21E7C2B;
	Sat, 12 Apr 2025 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOlxZbke"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C7190057;
	Sat, 12 Apr 2025 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744463456; cv=none; b=p8+jSCLJm89vzZS7KOREqTkzS5qiS/d4gOEqzG+EHhjge7/zSSTTsoez9cbwZ9tINFGqYqAixd0cw7e6wOMuuCB7PSxGEGSG/L0kLy7F0LNSqVjlHhhoSJhxsFD30KzEmnmLtOQYEauGZZTXk37VPU9blE6nn0Y5msJ3JP8HtIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744463456; c=relaxed/simple;
	bh=zPnjWEDnV//Fj6ip5BNwiywdF2j4nrxppCfJXU4SIiE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzMYuvihbMm1X4jG8/V3JkrO4qi8dDTov6ToeJDh6lTnvHoUAuJcYqGeX2vsg6HMEIMTniesvqtpVwq7JaAR2B5Zl9gKHMah1a2uqbDTKlM9Mu7B1ARd4cC8kHeHwFUhA1dWBsiBQ9ZPyo6qb1B91/Ce62d/8ShTK/gnWLRUcek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOlxZbke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7E2C4CEE3;
	Sat, 12 Apr 2025 13:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744463455;
	bh=zPnjWEDnV//Fj6ip5BNwiywdF2j4nrxppCfJXU4SIiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dOlxZbkemQ3VFrv+YVoBOCstAPSS4ga/uAaU+NIyXUjPYZuLIRgDVSRh68bfKMMQV
	 QUWlgaV6Lu8KSj3NPf0tQshqa6AQeoRWFJow24bnCbguRIu2yAW/T8tbBg5t9OvlJe
	 JqKee/+Ru049ziXLZa9rJ9hBwKUWV/D3iGhaBW527dT3RTQ5vtYWmca0uyNR6lIy/Q
	 SX4Qgbwwk9zrSeySupKB4PMunbIpf3cXpwhYkTXzqxTp8+V2xKD+J3zigYxcF1Yhmi
	 Wx+1MaN8b1ytChtF1jtTyaK6/94UuGSj3LpfU+LZkJFIUed3A952O+obDTNt9U7mRF
	 QPiCreCNf9e5w==
Date: Sat, 12 Apr 2025 14:10:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sukrut Bellary <sbellary@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Matti Vaittinen
 <mazziesaccount@gmail.com>
Subject: Re: [PATCH 0/2] iio: adc: ti-adc128s052: Add support for adc102s021
Message-ID: <20250412141047.4273a8b1@jic23-huawei>
In-Reply-To: <20250408132120.836461-1-sbellary@baylibre.com>
References: <20250408132120.836461-1-sbellary@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Apr 2025 06:21:18 -0700
Sukrut Bellary <sbellary@baylibre.com> wrote:

> The patch series adds the support for adc102s021 and family.
> 
> The family of devices are easier to
> support since they all (no matter the resolution) seem to respond in
> 12-bits with the LSBs set to 0 for the reduced resolution devices.

This has raced against Matti's series
https://lore.kernel.org/linux-iio/cover.1744022065.git.mazziesaccount@gmail.com/
Support ROHM BD79104 ADC

With hindsight that wasn't obvious from the patch series name though
which should ideally have been
iio: adc: ti-adc128s052: Support ROHM BD79104 ADC

Please rebase on the iio testing branch on kernel.org or on top of that series.
Technically I've only applied the first 7 patches so far, but the 8th
should be a simple change from that v3.
 
Matti, you volunteered as maintainer :)  Hence please take a look at
this one.

One nice thing in there is we now have a __be16 buffer16 element that
can avoid at least one cast in patch 2.

Thanks,

Jonathan

> 
> Changes in v3:
> 	Patch 1:
>         - No changes in dt-bindings
> 
> 	Patch 2:
> 	- used be16_to_cpu() for the endian conversion.
> 	- used config index enum while setting up the adc128_config[]
> 
> - Link to v2:
> 	https://lore.kernel.org/lkml/20231022031203.632153-1-sukrut.bellary@linux.com/
> 
> Changes in v2:
> 	Patch 1:
> 	- No changes in dt-bindings
> 
> 	Patch 2:
> 	- Arranged of_device_id and spi_device_id in numeric order.
> 	- Used enum to index into adc128_config.
> 	- Reorder adc128_config in alphabetical.
> 	- Include channel resolution information.
> 	- Shift is calculated per resolution and used in scaling and
> 	raw data read.
> 
> - Link to v1: https://lore.kernel.org/all/20220701042919.18180-1-nm@ti.com/
> 
> Sukrut Bellary (2):
>   dt-bindings: iio: adc: ti,adc128s052: Add adc08c and adc10c family
>   iio: adc: ti-adc128s052: Add lower resolution devices support
> 
>  .../bindings/iio/adc/ti,adc128s052.yaml       |   6 +
>  drivers/iio/adc/ti-adc128s052.c               | 149 +++++++++++++-----
>  2 files changed, 118 insertions(+), 37 deletions(-)
> 



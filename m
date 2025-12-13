Return-Path: <linux-iio+bounces-27063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99023CBB110
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 17:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 728813059AD5
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 16:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B50260569;
	Sat, 13 Dec 2025 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqE7DdoL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CAB3B8D4B;
	Sat, 13 Dec 2025 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765641726; cv=none; b=LSsJj42rcpKO0c/NlUrHibF5SLAVYiJHEwb96aek1Runy+yq0PgPh1uq3weQB3YqeQnpxQIiy7XDIeDSPP6ZXbq3BnNPc/t5NaG1prnPtWRJxEgRlyik4tcPpSeSp0X8zSbg0N11CLS41oaQmR7KVZui+PRsFLSFd3b3CoWxNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765641726; c=relaxed/simple;
	bh=nnhX1g4Ordr61I3/Mes91IwQ59xozmblbvAnSRlmb+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWfu95ZN+2kokoT4K3O2n7P29wcEt4mXICv4qcEo5FOss3AfA9O7/X8shQ0IPLclH3a+nq/29URPoZ1xOCniLKslt8eC7uGp3TZHptCDMEZmUHjoIKq9xRINIr4qhJ499zpL6LHC+vXCONt5i6ug+kY7qwGyMPWfK8B/GGRk/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqE7DdoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C2DC4CEF7;
	Sat, 13 Dec 2025 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765641725;
	bh=nnhX1g4Ordr61I3/Mes91IwQ59xozmblbvAnSRlmb+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tqE7DdoLHSDeAfff65N2f7UxQC7BiBCT8Jdrrb9YvDvaMegqzrVROhb85t/UjqNCi
	 VoG0PBRlIm5Ta4tPe5hTj+qbPUt3Th9muOuoectjK5zl1CeXioG/UFL6giXjsplJMF
	 c5ZrH/7vMkm6XNrAbZTBMbRFnh14hc/JAjbAWIkkr6W9RjR+m6nrwAvi8P6QtiYNU7
	 c1WTQP7T5yPmCmZp8t8ozC02Ff3P38Ymyhd09d2Q6aPHla2rNNGC1CWZ7TiTC7NQ/Y
	 EYjhVOlMDXuZM/wrXerapqNxzR7pa4wfBw8yXl+K+CxrDIiFFSteRScwEW4S3oPkLb
	 wqi62zJXbiPaw==
Date: Sat, 13 Dec 2025 16:01:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com, vkoul@kernel.org
Subject: Re: [PATCH v9 0/2] NXP SAR ADC IIO driver for s32g2/3 platforms
Message-ID: <20251213160154.6b1aba67@jic23-huawei>
In-Reply-To: <20251208020819.3063506-1-daniel.lezcano@linaro.org>
References: <20251208020819.3063506-1-daniel.lezcano@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Dec 2025 03:08:17 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> The S32G2 and S32G3 platforms have a couple of successive
> approximation register (SAR) ADCs with eight channels and 12-bit
> resolution. These changes provide the driver support for these ADCs
> and the bindings describing them.
> 
> The driver is derived from the BSP driver version. It has been partly
> rewritten to conform to upstream criteria.
> 
> https://github.com/nxp-auto-linux/linux/blob/release/bsp44.0-6.6.85-rt/drivers/iio/adc/s32cc_adc.c
> 
> After the V1 posting there were some discussions around the DMA code
> to be converted to use the IIO DMA API [1]. Unfortunately this one is
> not yet fully implemented and merged in the framework to support the
> cyclic DMA. The current DMA code in the driver has been used in
> production since several years and even if I agree it can be improved
> with a dedicated IIO DMA API in the future, IMO, it sounds reasonable
> to keep it as is until the IIO DMA API supporting the cyclic DMA is
> merged. I'll be glad to convert the driver code if such an API exists
> and allows to remove code inside the driver.
> 
> [1] https://lore.kernel.org/all/c30bb4b6328d15a9c213c0fa64b909035dc7bf40.camel@gmail.com/
> [2] https://lore.kernel.org/all/aRyBKH4KOQ1L8lA4@black.igk.intel.com/
Series applied to the testing branch of iio.git. It will go out as togreg once
I have rebased on rc1.

Thanks,

Jonathan


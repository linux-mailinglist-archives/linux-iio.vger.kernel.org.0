Return-Path: <linux-iio+bounces-11723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A93409B853C
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 22:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550031F211B9
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 21:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A631AF4E9;
	Thu, 31 Oct 2024 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPnjcPo5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932E18593E;
	Thu, 31 Oct 2024 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409920; cv=none; b=T5D2T9JNhOKXS9Tina94/3z4REf8ULKJfqzVj08Yu3fmghpF39aSuay2VdjeSc2gA8THoa/Lix5s73EGhcAV4dTqAsOZW2o+nZX2OAzrpmp4Bwtojw+s/weh8Na7h29H/+CTeTnQqe0ectyyFAznHqqG+LijWXlusVUVVLPYOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409920; c=relaxed/simple;
	bh=BpBApsHwFr03qfbUQXPEP9hsiehvNVIMqJuy5belJLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKXRq4iY5GUVYrcgmcrMAFqU24nSQJpO8xGfM9eOBmq0VrJonMSGm4Cm9MIrTQF4mBebMYpX0njH6GEpIzwgxn5NQ/ITFHL70YfqxJApUjDnGpsu8hm1CdNuAqeoEKRZV1Gf4+upRUrj9KHTMmwYU3ZWkZl7+XZFlgCJ97FVNiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPnjcPo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B39C4CEC3;
	Thu, 31 Oct 2024 21:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730409919;
	bh=BpBApsHwFr03qfbUQXPEP9hsiehvNVIMqJuy5belJLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QPnjcPo5LPDxOInSvU8IapJ5DtAIH0ZpbM7LeVRylCRClDNR4d0N/0CmUarDO1aiv
	 yRtH+Hr+ACO2HPNsLQwG9SylaVwClKTbFRBUzeBBw8AyZSQ5wJu3oG1d/dmdCzX84M
	 Kn2kJkXL7JXkSg5JRPJF7Sve3dgZu7c4fsSh+qIxvRsFuoLTqO/MP9L3iGNX17c0YV
	 t3KXAQTXv1HW0bd3sRutU5IPokx2qMRXQ5Hz9tgXSyh4YOOvtjQ2JqBO6Q4zKe4EbI
	 iZu/MuagSMmSQ7qU0NeU3/FKp9ZDYlnDepDqwMYyn3NS+1+3EYXxEshHlJC0z5DGdF
	 1pPiCum+0S5pA==
Date: Thu, 31 Oct 2024 21:25:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>, Angelo Dureghello
 <adureghello@baylibre.com>
Subject: Re: [PATCH v9 7/8] iio: dac: ad3552r: add high-speed platform
 driver
Message-ID: <20241031212511.57ec5d6e@jic23-huawei>
In-Reply-To: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-7-f6960b4f9719@kernel-space.org>
References: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
	<20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-7-f6960b4f9719@kernel-space.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 22:45:34 +0100
Angelo Dureghello <angelo@kernel-space.org> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add High Speed ad3552r platform driver.
> 
> The ad3552r DAC is controlled by a custom (fpga-based) DAC IP
> through the current AXI backend, or similar alternative IIO backend.
> 
> Compared to the existing driver (ad3552r.c), that is a simple SPI
> driver, this driver is coupled with a DAC IIO backend that finally
> controls the ad3552r by a fpga-based "QSPI+DDR" interface, to reach
> maximum transfer rate of 33MUPS using dma stream capabilities.
> 
> All commands involving QSPI bus read/write are delegated to the backend
> through the provided APIs for bus read/write.
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Missing bitfield.h include. I added whilst applying.

Jonathan


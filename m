Return-Path: <linux-iio+bounces-7044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0BC91CE2C
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 18:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6B21C20E95
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE9185626;
	Sat, 29 Jun 2024 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxUEIs8I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF939ADD;
	Sat, 29 Jun 2024 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719679247; cv=none; b=Yq7ay+li1dvuOMTMDX3WDDGN+uCHGO1DUTbhXXrecSJhkwW41DYMMTR35Sj9UhRgt9BNWTHpg5yWTIHoclrxL90pM4sl6nF0JEEq3LcsdxnUP6lSR4JZJSXVEmECBzvo37cBb6AODo36aW/DHVm79FKX9q+uB1iUxEK2Ojr7ELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719679247; c=relaxed/simple;
	bh=2/XkKgpkoMMVhGRWQx5/Delf4i82JSVhiOvsCQqqlXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrUMDNf3siTpsiLLETNsGW05Ojsxi5EIz9NZ3GI6OX1VfVk/LD0+Iwai+Bmxc8bWfSRNCF+WS8I4Gwto8nNE0zt6k22BtNr4PnSi2hj5Wutj1CCaPtzTAYU2o4ruK1SvtcWlDA9+acxO1ePU269Saxb93+/hMYSHFt8dukLX8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxUEIs8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4F2C2BBFC;
	Sat, 29 Jun 2024 16:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719679246;
	bh=2/XkKgpkoMMVhGRWQx5/Delf4i82JSVhiOvsCQqqlXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BxUEIs8Ig/yXrXOAtPjGpJRywtHetof/Y69Nhb91kExUvObT5oNzB6b6tPIWj+POw
	 zeQFPSFLV7a5aCWxFN7VKrqRO90b5+sanK1Q3mg8Dnswvb/Jn+X8I0sVkpCqNvP+cJ
	 5a9IvSgaYrsS1keBJU/ZhMNymdGek29PvvUz/eSjX9Xb7nwB9Q8shyyHn3G8/TGtxz
	 vBupKnvscMpolynm7XeP0C0lkBuwfVkmw0b8IYyprsV6hzHi5umGi1qdP/CBkvBvtu
	 wM81nlyX3dJjKaWpDlKF/lN/7eQVNuXDNEHW0Q5eEbQicRurovKAT0ZB8YfxfRvw6m
	 EHDgp2Z3P77Ag==
Date: Sat, 29 Jun 2024 17:40:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: baylibre-upstreaming@groups.io, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 0/5] iio: adc: ad4030: new driver for AD4030 and
 similar ADCs
Message-ID: <20240629174039.3e6053e5@jic23-huawei>
In-Reply-To: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 13:59:11 +0200
Esteban Blanc <eblanc@baylibre.com> wrote:

> This is adding DT bindings and a new driver for AD4030, AD4630 and
> AD4632 ADCs.
> 
> This work is being done in collaboration with Analog Devices Inc.,
> hence they are listed as maintainers rather than me.
> 
> The code has been tested on a Zedboard with an EVAL-AD4030-24FMCZ,
> an EVAL-AD4630-24FMCZ and an EVAL-AD4630-16FMCZ. As there is no eval
> board for AD4632 the support can't be tested at the moment. The main
> difference is the reduced throughput.
> 
> This series is taged as RFC because I think I'm misusing
> IIO_CHAN_INFO_CALIB*. For CALIBBIAS the doc in sysfs-bus-iio says
> "Hardware applied calibration offset (assumed to fix production
> inaccuracies)" but AD4030 offset in on 24bits and I would argue that at
> this point it's not just here to fix production inaccuracies. Same this
> for CALIBSCALE. What IIO attributes should I use instead?

Interesting.   So awkward question for you.  What's the point in applying
a digital offset?  calibbias is normally about tweaking the Analog side.
This just seems to be adding a value on.  I'm not sure it affects what
can actually be captured without saturation.
Maybe it has influence by changing the input range and scale for the
block averaging filter?  I'm not sure.

You can use offset for this given it's a simple linear value and not
anything to do with calibration. It's a little awkward though as that
is post scale rather than the other way around which is rather more
common.
Controls are in the form
voltage = (raw + offset) * scale 

So here
voltage = (raw + offset_reg / (gain_reg * other scaling)) * gain_reg * otherscaling.

Hence your offset is a bit fiddly to compute.

> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> ---
> Esteban Blanc (5):
>       dt-bindings: iio: adc: add ADI ad4030 and ad4630
>       iio: adc: ad4030: add driver for ad4030-24
>       iio: adc: ad4030: add averaging support
>       iio: adc: ad4030: add support for ad4630-24 and ad4630-16
>       iio: adc: ad4030: add support for ad4632-16 and ad4632-24
> 
>  .../devicetree/bindings/iio/adc/adi,ad4030.yaml    |  113 ++
>  MAINTAINERS                                        |    9 +
>  drivers/iio/adc/Kconfig                            |   13 +
>  drivers/iio/adc/Makefile                           |    1 +
>  drivers/iio/adc/ad4030.c                           | 1081 ++++++++++++++++++++
>  5 files changed, 1217 insertions(+)
> ---
> base-commit: 07d4d0bb4a8ddcc463ed599b22f510d5926c2495
> change-id: 20240624-eblanc-ad4630_v1-1a074097eb91
> 
> Best regards,



Return-Path: <linux-iio+bounces-22821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 338FDB28E24
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A180C1CE1A25
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9442E5D2F;
	Sat, 16 Aug 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0uNW2H9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B00153BD9;
	Sat, 16 Aug 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755350939; cv=none; b=Npzi+LLEcE0GqDZa101GG/XhdOgfFsMw/o4jZ/030YCdkynu9vzgmrjPFlJTfkf3NicmCpN9L9sHYLmBrIgSoBTK+nA2ptW9TYvtMjOlNu0frhebvgAYVd+QWWMVnUqcF6Pbgk8xrSiwrvdhw3jRc0vqFRqjq3ZToQDGGCKC+wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755350939; c=relaxed/simple;
	bh=LhpgfZIG1p+iKd5jf1S6zPl8oL3nAGFq/mjJ8z+fS60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjKAoXKm19oXr+N7Dr/w1H7U22rtJfZWbh6SooxX2DTLmEp/+sgQ68qq5IiDv0VfVpnUgErb5V7usxbDXM6cTqGWb1wu4XontFVPp6W/dSmKLIWr5SG0n7DElhd9P47n8xamW1443/59YNLLmGZ0Mpw8PM/6VO+/b6X+hlgcQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0uNW2H9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32215C4CEEF;
	Sat, 16 Aug 2025 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755350939;
	bh=LhpgfZIG1p+iKd5jf1S6zPl8oL3nAGFq/mjJ8z+fS60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u0uNW2H97GYGYKNmLh/zJe+wyCd8Qrvbu7q+ZLdC1iXQjBQZqiKPV/tkWq/6RbjDb
	 Pqy6XZv6fJxR/GC/h+z9GR4T6baTpI6vjqpqB04V5aE2RxqSxrlct/K2YoD13QTc9+
	 irQ/tVt2BiUNHXNQAziQQeuELeNsySHyQlFM71t/B3dTEQidVgqjZICkvyQBX3aQr1
	 3RGedHXiWiwfSxBzqPrBSdOTMyRMTY6FZn+eBTjNmYyUxEihEn9N8r7jOtrqlpLlZd
	 kcjnsOcKHwNWGoYOcF/rjWXwlqfQp7UAu8CRMLZbFRl2wlvW8VrltyWzrOGHE8h7La
	 04GlgZBjALwwg==
Date: Sat, 16 Aug 2025 14:28:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 primoz.fiser@norik.com, linux-iio@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Keep imx93 ADC works even calibration failed.
Message-ID: <20250816142850.53948a13@jic23-huawei>
In-Reply-To: <20250812-adc-v2-0-0260833f13b8@nxp.com>
References: <20250812-adc-v2-0-0260833f13b8@nxp.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 16:04:21 +0800
Haibo Chen <haibo.chen@nxp.com> wrote:

> imx93 ADC calibration has requirement for reference voltage:
>   ADC reference voltage Noise < 1.8V * 1/2^ENOB
> 
> Some boards can't meet such requirement, ADC calibration failed on these
> boards, and adc can't be used. This is not appropriate, board can't meet
> this requirement do not means ADC can't work, just means ADC can't work
> that accurate. Here add an optimization, keep adc works even calibration
> failed.
> 
> Changes in V2:
> - add patch 1 to keep one style of the hex values according to
>   Andy Shevchenko's suggestion.
> - keep {} when give the calibration failed warning log.
> 
> For the register 0x3A0, it is a new added register in latest imx93 RM,
> please refer to this link:
> https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-9-processors/i-mx-93-applications-processor-family-arm-cortex-a55-ml-acceleration-power-efficient-mpu:i.MX93
> 
> Patch v1 also pass test on one customer board, refer to this topic:
> https://patchwork.kernel.org/project/linux-iio/patch/20250710073905.1105417-2-primoz.fiser@norik.com/
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Series applied to the togreg branch of iio.git.

I'll push that out as testing to get a bit of build coverage before
risking letting next see it.

Thanks,

Jonathan

> ---
> Haibo Chen (2):
>       iio: adc: imx93_adc: keep one style of the hex values
>       iio: adc: imx93_adc: load calibrated values even calibration failed
> 
>  drivers/iio/adc/imx93_adc.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> ---
> base-commit: 2674d1eadaa2fd3a918dfcdb6d0bb49efe8a8bb9
> change-id: 20250812-adc-839e49d55da9
> 
> Best regards,


